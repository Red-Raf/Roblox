-- RuzHub Mobile MM2 - Rayfield UI
-- Полностью оптимизирован для телефона
-- Все функции из оригинального кода

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera

-- ====== ОСНОВНЫЕ ПЕРЕМЕННЫЕ ======
local ESPEnabled = false
local AimbotEnabled = false
local SpeedGlitchEnabled = false
local AntiFlingEnabled = false
local StretchEnabled = false
local CrosshairEnabled = false
local CrosshairSpin = false
local GunESPEnabled = true
local FOV = 70
local MaxSpeed = 200
local StretchFactor = 0.5
local CrosshairID = "98490421374360"
local BombGoldCooldown = false
local BombNormalCooldown = false
local FlingInProgress = false
local FlickInProgress = false
local WallHopInProgress = false

local PlayerData = {}
local LastUpdate = 0
local PredictionPart = nil
local GunMarker = nil
local CrosshairImage = nil
local CrosshairConnection = nil
local SavedParts = {}
local SavedLighting = {}

-- ====== 1. ESP СИСТЕМА ======
local ESPRoles = {
    Murderer = true,
    Sheriff = true,
    Hero = true,
    Innocent = true,
    Self = false
}

local ESPColors = {
    Murderer = Color3.fromRGB(255, 40, 40),
    Sheriff = Color3.fromRGB(40, 130, 255),
    Hero = Color3.fromRGB(255, 215, 0),
    Innocent = Color3.fromRGB(0, 220, 0)
}

function GetPlayerRole(player)
    local data = PlayerData[player.Name]
    if data then
        local role = tostring(data.Role or data.role or data.Team or ""):lower()
        if role:find("murd") then return "Murderer" end
        if role:find("sheriff") or role:find("gun") then return "Sheriff" end
        if role:find("hero") then return "Hero" end
    end
    return "Innocent"
end

function UpdatePlayerData()
    local remote = ReplicatedStorage:FindFirstChild("GetCurrentPlayerData", true)
    if remote and remote:IsA("RemoteFunction") then
        local success, data = pcall(function() return remote:InvokeServer() end)
        if success and type(data) == "table" then
            PlayerData = data
        end
    end
end

function ApplyESP(player, color)
    local char = player.Character
    if not char then return end
    local esp = char:FindFirstChild("RuzHub_ESP") or Instance.new("Highlight")
    esp.Name = "RuzHub_ESP"
    esp.Parent = char
    esp.FillColor = color
    esp.FillTransparency = 0.7
    esp.OutlineColor = Color3.fromRGB(255, 255, 255)
    esp.OutlineTransparency = 0.15
    esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end

function ClearESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            local esp = player.Character:FindFirstChild("RuzHub_ESP")
            if esp then esp:Destroy() end
        end
    end
end

function ToggleESP(state)
    ESPEnabled = state
    if state then
        RunService.Heartbeat:Connect(function()
            if not ESPEnabled then return end
            if tick() - LastUpdate > 0.5 then
                UpdatePlayerData()
                LastUpdate = tick()
            end
            for _, player in ipairs(Players:GetPlayers()) do
                if not player.Character then continue end
                local role = GetPlayerRole(player)
                local show = ESPRoles[role]
                if player == LocalPlayer and not ESPRoles.Self then show = false end
                if not show then
                    local esp = player.Character:FindFirstChild("RuzHub_ESP")
                    if esp then esp:Destroy() end
                else
                    ApplyESP(player, ESPColors[role])
                end
            end
        end)
    else
        ClearESP()
    end
end

-- ====== 2. AIMBOT ======
function CreatePredictionPart()
    local part = Instance.new("Part")
    part.Name = "RuzPredictionPart"
    part.Size = Vector3.new(0.5, 0.5, 0.5)
    part.Anchored = true
    part.CanCollide = false
    part.Transparency = 1
    part.Parent = Workspace
    return part
end

function GetClosestTarget()
    local char = LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local hasKnife = LocalPlayer.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
    local hasGun = LocalPlayer.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun")
    local closest, closestDist = nil, math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if not player.Character then continue end
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
        if not targetRoot then continue end
        
        local dist = (targetRoot.Position - root.Position).Magnitude
        local hasTargetKnife = player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")
        local hasTargetGun = player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")
        local priority = false
        
        if not hasKnife and not hasGun then
            if hasTargetKnife or hasTargetGun then priority = true end
        elseif hasGun and (hasTargetGun or hasTargetKnife) then
            priority = true
        elseif hasKnife and hasTargetKnife then
            priority = true
        end
        
        if priority and dist < closestDist then
            closestDist, closest = dist, player.Character
        end
    end
    
    if not closest then
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            if not player.Character then continue end
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if not hum or hum.Health <= 0 then continue end
            local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
            if not targetRoot then continue end
            local dist = (targetRoot.Position - root.Position).Magnitude
            if dist < closestDist then
                closestDist, closest = dist, player.Character
            end
        end
    end
    
    return closest
end

function UpdateAimbot()
    if not AimbotEnabled then
        if PredictionPart then PredictionPart:Destroy(); PredictionPart = nil end
        if GunMarker then GunMarker:Destroy(); GunMarker = nil end
        return
    end
    
    local target = GetClosestTarget()
    if target then
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not root then return end
        
        local targetPart = target:FindFirstChild("UpperTorso") or target:FindFirstChild("Torso") or target:FindFirstChild("HumanoidRootPart")
        if not targetPart then return end
        
        local hum = target:FindFirstChildOfClass("Humanoid")
        local vel = targetPart.AssemblyLinearVelocity
        if hum then
            local state = hum:GetState()
            if state == Enum.HumanoidStateType.Freefall or state == Enum.HumanoidStateType.Jumping then
                vel = Vector3.new(vel.X, vel.Y * 0.35, vel.Z)
            end
        end
        
        local dist = (targetPart.Position - root.Position).Magnitude
        local ping = 0
        pcall(function() ping = LocalPlayer:GetNetworkPing() * 0.5 end)
        local pred = targetPart.Position + vel * (dist / 250 + ping)
        
        if not PredictionPart then PredictionPart = CreatePredictionPart() end
        PredictionPart.CFrame = CFrame.new(pred)
        
        if not GunMarker then
            local marker = Instance.new("Part")
            marker.Name = "RuzGunMarker"
            marker.Size = Vector3.new(1.5, 0.15, 1.5)
            marker.Anchored = true
            marker.CanCollide = false
            marker.CastShadow = false
            marker.Material = Enum.Material.Neon
            marker.Color = Color3.fromRGB(50, 255, 80)
            marker.Transparency = 0.25
            marker.Parent = Workspace
            GunMarker = marker
        end
        GunMarker.CFrame = CFrame.new(targetPart.Position + Vector3.new(0, 0.1, 0))
    else
        if PredictionPart then PredictionPart:Destroy(); PredictionPart = nil end
        if GunMarker then GunMarker:Destroy(); GunMarker = nil end
    end
end

function Shoot()
    if not PredictionPart then return end
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local gun = LocalPlayer.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun")
    if gun then
        if char ~= gun.Parent then
            char.Humanoid:EquipTool(gun)
            task.wait()
        end
        local cframe = CFrame.new(root.Position + Vector3.new(0, 1, 0), PredictionPart.CFrame.Position)
        pcall(function()
            gun:WaitForChild("Shoot"):FireServer(cframe, CFrame.new(PredictionPart.CFrame.Position))
        end)
        return
    end
    
    local knife = LocalPlayer.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
    if knife then
        if char ~= knife.Parent then
            char.Humanoid:EquipTool(knife)
            task.wait()
        end
        local cframe = CFrame.new(root.Position + Vector3.new(0, 1, 0), PredictionPart.CFrame.Position)
        pcall(function()
            knife:WaitForChild("Events"):WaitForChild("KnifeThrown"):FireServer(cframe, CFrame.new(PredictionPart.CFrame.Position))
        end)
    end
end

-- ====== 3. FLICK ======
function Flick()
    if FlickInProgress then return end
    FlickInProgress = true
    local char = LocalPlayer.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            local cframe = root.CFrame
            local target = cframe * CFrame.Angles(0, math.pi, 0)
            for i = 1, 4 do
                root.CFrame = cframe:Lerp(target, i / 4)
                RunService.RenderStepped:Wait()
            end
        end
    end
    task.wait(0.15)
    FlickInProgress = false
end

-- ====== 4. WALL HOP ======
function WallHop()
    if WallHopInProgress then return end
    WallHopInProgress = true
    local char = LocalPlayer.Character
    if not char then WallHopInProgress = false; return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not root or not hum then WallHopInProgress = false; return end
    
    local camCF = CurrentCamera.CFrame
    local look = Vector3.new(camCF.LookVector.X, 0, camCF.LookVector.Z).Unit
    local right = Vector3.new(camCF.RightVector.X, 0, camCF.RightVector.Z).Unit
    
    for i = 1, 7 do
        local t = i / 7
        local smooth = t * t
        local newLook = look:Lerp(right, smooth).Unit
        CurrentCamera.CFrame = CFrame.lookAt(camCF.Position, camCF.Position + newLook)
        RunService.RenderStepped:Wait()
    end
    
    root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 55, root.AssemblyLinearVelocity.Z)
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
    task.wait(0.12)
    
    for i = 1, 5 do
        local t = i / 5
        local smooth = t * t
        local newLook = look:Lerp(right, smooth).Unit
        CurrentCamera.CFrame = CFrame.lookAt(camCF.Position, camCF.Position + newLook)
        RunService.RenderStepped:Wait()
    end
    task.wait(0.1)
    WallHopInProgress = false
end

-- ====== 5. SPEED GLITCH ======
function ToggleSpeedGlitch(state)
    SpeedGlitchEnabled = state
    if state then
        RunService.RenderStepped:Connect(function()
            if not SpeedGlitchEnabled then return end
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local state = hum:GetState()
            if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall then
                if hum.MoveDirection.Magnitude > 0 then
                    hum.WalkSpeed = MaxSpeed
                end
            else
                hum.WalkSpeed = 16
            end
        end)
    end
end

-- ====== 6. BOMB JUMP ======
function BombJump(type)
    if type == "Gold" and BombGoldCooldown then
        Rayfield:Notify({Title = "RuzHub", Content = "Gold Bomb on cooldown!", Duration = 2})
        return
    end
    if type == "Normal" and BombNormalCooldown then
        Rayfield:Notify({Title = "RuzHub", Content = "Normal Bomb on cooldown!", Duration = 2})
        return
    end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local weapon = type == "Gold" and "GoldBomb" or "FakeBomb"
    local tool = LocalPlayer.Backpack:FindFirstChild(weapon) or char:FindFirstChild(weapon)
    if not tool then
        Rayfield:Notify({Title = "RuzHub", Content = "No " .. weapon .. " found!", Duration = 2})
        return
    end
    
    if char ~= tool.Parent then
        char.Humanoid:EquipTool(tool)
        task.wait()
    end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    pcall(function()
        tool.Remote:FireServer(CFrame.new(root.Position + root.CFrame.LookVector * 1.5 + Vector3.new(0, -3, 0)), 50)
    end)
    
    char.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
    root.AssemblyLinearVelocity = Vector3.new(root.AssemblyLinearVelocity.X, 62, root.AssemblyLinearVelocity.Z)
    
    if type == "Gold" then
        BombGoldCooldown = true
        task.wait(4)
        BombGoldCooldown = false
    else
        BombNormalCooldown = true
        task.wait(21)
        BombNormalCooldown = false
    end
end

-- ====== 7. ANTI-FLING ======
function ToggleAntiFling(state)
    AntiFlingEnabled = state
    if state then
        RunService.Heartbeat:Connect(function()
            if not AntiFlingEnabled then return end
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if not root then return end
            local vel = root.AssemblyLinearVelocity
            if vel.Magnitude > MaxSpeed then
                root.AssemblyLinearVelocity = vel.Unit * MaxSpeed
            end
        end)
    end
end

-- ====== 8. GRAB GUN ======
function GrabGun()
    local gunDrop = Workspace:FindFirstChild("GunDrop", true)
    if not gunDrop then
        Rayfield:Notify({Title = "RuzHub", Content = "No gun on map!", Duration = 2})
        return
    end
    
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local pos
    if not gunDrop:IsA("BasePart") then
        local handle = gunDrop:FindFirstChild("Handle") or gunDrop:FindFirstChildWhichIsA("BasePart") or gunDrop.PrimaryPart
        pos = handle and handle.Position or gunDrop:GetModelCFrame().Position
    else
        pos = gunDrop.Position
    end
    
    if pos then
        local old = root.CFrame
        root.CFrame = CFrame.new(pos + Vector3.new(0, 2, 0))
        task.wait(0.2)
        root.CFrame = old
        Rayfield:Notify({Title = "RuzHub", Content = "Teleported to gun!", Duration = 2})
    end
end

-- ====== 9. FLING ======
function FlingPlayer(targetPlayer, roleType)
    if FlingInProgress then
        Rayfield:Notify({Title = "RuzHub", Content = "Fling in progress...", Duration = 2})
        return
    end
    
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChildOfClass("Humanoid")
    local root = hum and hum.RootPart
    if not root then return end
    
    local targetChar = targetPlayer.Character
    if not targetChar then return end
    local targetHum = targetChar:FindFirstChildOfClass("Humanoid")
    if not targetHum or targetHum.Sit then
        Rayfield:Notify({Title = "RuzHub", Content = targetPlayer.Name .. " is sitting", Duration = 2})
        return
    end
    
    local targetRoot = targetHum.RootPart
    local targetPart = targetChar:FindFirstChild("Head") or targetChar:FindFirstChildOfClass("Accessory")
    if targetPart then targetPart = targetPart:FindFirstChild("Handle") or targetPart end
    if not targetPart then
        Rayfield:Notify({Title = "RuzHub", Content = "No fling part found", Duration = 2})
        return
    end
    
    FlingInProgress = true
    local oldPos = root.CFrame
    Workspace.FallenPartsDestroyHeight = math.huge
    
    local bodyVel = Instance.new("BodyVelocity")
    bodyVel.Velocity = Vector3.new(0, 0, 0)
    bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVel.Parent = root
    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    
    local startTime = tick() + 2.5
    local angle = 0
    
    while root and targetHum do
        if targetRoot.Velocity.Magnitude < 40 then
            angle = angle + 100
            local move = targetHum.MoveDirection
            local mag = targetRoot.Velocity.Magnitude / 1.25
            
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(0, 1.5, 0) + move * mag * CFrame.Angles(math.rad(angle), 0, 0)
            task.wait()
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(0, -1.5, 0) + move * mag * CFrame.Angles(math.rad(angle), 0, 0)
            task.wait()
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(0, 1.5, 0) + move * mag * CFrame.Angles(math.rad(angle), 0, 0)
            task.wait()
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(0, -1.5, 0) + move * mag * CFrame.Angles(math.rad(angle), 0, 0)
            task.wait()
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(0, 1.5, 0) * CFrame.Angles(math.rad(angle), 0, 0)
            task.wait()
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(0, -1.5, 0) * CFrame.Angles(math.rad(angle), 0, 0)
            task.wait()
        else
            local dir = targetHum.MoveDirection
            local speed = targetHum.WalkSpeed
            
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(dir.X * speed * 0.12, 3, dir.Z * speed * 0.12) * CFrame.Angles(math.pi/2, 0, 0)
            root.Velocity = Vector3.new(9e8, 9e8, 9e8)
            task.wait()
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(-dir.X * speed * 0.06, -3, -dir.Z * speed * 0.06)
            root.Velocity = Vector3.new(9e8, 9e8, 9e8)
            task.wait()
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(dir.X * speed * 0.18, 3, dir.Z * speed * 0.18) * CFrame.Angles(math.pi/2, 0, 0)
            root.Velocity = Vector3.new(9e8, 9e8, 9e8)
            task.wait()
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(-dir.X * speed * 0.06, -3, -dir.Z * speed * 0.06)
            root.Velocity = Vector3.new(9e8, 9e8, 9e8)
            task.wait()
        end
        if tick() > startTime then break end
    end
    
    bodyVel:Destroy()
    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
    Workspace.CurrentCamera.CameraSubject = hum
    
    for i = 1, 30 do
        root.CFrame = oldPos * CFrame.new(0, 0.5, 0)
        pcall(function() char:SetPrimaryPartCFrame(oldPos * CFrame.new(0, 0.5, 0)) end)
        hum:ChangeState(Enum.HumanoidStateType.GettingUp)
        for _, child in ipairs(char:GetChildren()) do
            if child:IsA("BasePart") then
                child.Velocity = Vector3.new()
                child.RotVelocity = Vector3.new()
            end
        end
        task.wait()
        if (root.Position - oldPos.p).Magnitude < 25 then break end
    end
    Workspace.FallenPartsDestroyHeight = 100
    FlingInProgress = false
    Rayfield:Notify({Title = "RuzHub", Content = "Fling finished!", Duration = 2})
end

function FindFlingTarget(roleType)
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if not player.Character then continue end
        local hasWeapon = false
        if roleType == "Murderer" then
            hasWeapon = player.Backpack:FindFirstChild("Knife") or player.Character:FindFirstChild("Knife")
        else
            hasWeapon = player.Backpack:FindFirstChild("Gun") or player.Character:FindFirstChild("Gun")
        end
        if hasWeapon then
            local hum = player.Character:FindFirstChildOfClass("Humanoid")
            if hum and hum.Health > 0 then
                return player
            end
        end
    end
    return nil
end

-- ====== 10. GUN ESP ======
function MonitorGunDrops()
    local function OnGunDrop(gun)
        if not GunESPEnabled then return end
        task.wait(0.1)
        local pos
        if not gun:IsA("BasePart") then
            local handle = gun:FindFirstChild("Handle") or gun:FindFirstChildWhichIsA("BasePart")
            pos = handle and handle.Position or gun:GetModelCFrame().Position
        else
            pos = gun.Position
        end
        if pos then
            local marker = Instance.new("Part")
            marker.Name = "RuzGunMarker"
            marker.Size = Vector3.new(1.5, 0.15, 1.5)
            marker.Anchored = true
            marker.CanCollide = false
            marker.CastShadow = false
            marker.Material = Enum.Material.Neon
            marker.Color = Color3.fromRGB(50, 255, 80)
            marker.Transparency = 0.25
            marker.CFrame = CFrame.new(pos + Vector3.new(0, 0.1, 0))
            marker.Parent = Workspace
            task.spawn(function()
                while marker and marker.Parent do
                    for i = 0, 1, 0.05 do
                        if not marker or not marker.Parent then break end
                        marker.Transparency = 0.25 + 0.5 * math.sin(i * math.pi)
                        task.wait(0.03)
                    end
                end
            end)
        end
    end
    
    task.wait(1.5)
    local existing = Workspace:FindFirstChild("GunDrop", true)
    if existing then OnGunDrop(existing) end
    
    Workspace.ChildAdded:Connect(function(child)
        if child.Name == "GunDrop" then OnGunDrop(child) end
        if child:IsA("Model") or child:IsA("Folder") then
            child.ChildAdded:Connect(function(sub)
                if sub.Name == "GunDrop" then OnGunDrop(sub) end
            end)
        end
    end)
end

-- ====== 11. STRETCH ======
function ToggleStretch(state)
    StretchEnabled = state
    if state then
        RunService.RenderStepped:Connect(function()
            if not StretchEnabled then return end
            CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, StretchFactor, 0, 0, 0, 1)
        end)
    end
end

-- ====== 12. CROSSHAIR ======
function ToggleCrosshair(state)
    CrosshairEnabled = state
    if not state then
        local display = CoreGui:FindFirstChild("RuzCrosshairDisplay")
        if display then display:Destroy() end
        if CrosshairConnection then CrosshairConnection:Disconnect(); CrosshairConnection = nil end
        UserInputService.MouseIconEnabled = true
        return
    end
    
    local display = CoreGui:FindFirstChild("RuzCrosshairDisplay")
    if display then display:Destroy() end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "RuzCrosshairDisplay"
    screenGui.ResetOnSpawn = false
    screenGui.DisplayOrder = 25
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = CoreGui
    
    CrosshairImage = Instance.new("ImageLabel")
    CrosshairImage.AnchorPoint = Vector2.new(0.5, 0.5)
    CrosshairImage.Position = UDim2.new(0.5, 0, 0.5, 0)
    CrosshairImage.Size = UDim2.new(0, 42, 0, 42)
    CrosshairImage.BackgroundTransparency = 1
    CrosshairImage.Image = "rbxassetid://" .. CrosshairID
    CrosshairImage.ZIndex = 10
    CrosshairImage.Visible = false
    CrosshairImage.Parent = screenGui
    
    if CrosshairSpin then
        RunService.RenderStepped:Connect(function()
            if CrosshairImage and CrosshairImage.Parent and CrosshairImage.Visible then
                CrosshairImage.Rotation = CrosshairImage.Rotation + 4
            end
        end)
    end
    
    CrosshairConnection = RunService.RenderStepped:Connect(function()
        if not CrosshairImage or not CrosshairImage.Parent then return end
        local shiftLock = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
        CrosshairImage.Visible = CrosshairEnabled and shiftLock
        UserInputService.MouseIconEnabled = not CrosshairImage.Visible
    end)
end

-- ====== 13. SKYBOX ======
local DefaultSky = {}

function SaveDefaultSky()
    local sky = Lighting:FindFirstChildOfClass("Sky")
    if sky then
        DefaultSky = {
            SkyboxBk = sky.SkyboxBk,
            SkyboxDn = sky.SkyboxDn,
            SkyboxFt = sky.SkyboxFt,
            SkyboxLf = sky.SkyboxLf,
            SkyboxRt = sky.SkyboxRt,
            SkyboxUp = sky.SkyboxUp
        }
    end
end

function ApplySkybox(id)
    for _, child in pairs(Lighting:GetChildren()) do
        if child:IsA("Sky") or child:IsA("Atmosphere") or child:IsA("Clouds") then
            child:Destroy()
        end
    end
    local sky = Instance.new("Sky", Lighting)
    sky.Name = "RuzHub_CustomSky"
    local url = "rbxassetid://" .. tostring(id)
    sky.SkyboxBk = url
    sky.SkyboxDn = url
    sky.SkyboxFt = url
    sky.SkyboxLf = url
    sky.SkyboxRt = url
    sky.SkyboxUp = url
    sky.SunTextureId = ""
    sky.MoonTextureId = ""
    sky.SunAngularSize = 0
    sky.StarCount = 0
    Lighting.ClockTime = 14
    Lighting.Brightness = 2
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
end

function RestoreSkybox()
    for _, child in pairs(Lighting:GetChildren()) do
        if child:IsA("Sky") or child:IsA("Atmosphere") or child:IsA("Clouds") then
            child:Destroy()
        end
    end
    if DefaultSky then
        local sky = Instance.new("Sky", Lighting)
        for k, v in pairs(DefaultSky) do
            sky[k] = v
        end
    end
end

-- ====== 14. GRAPHICS ======
function ToggleLowGraphics(state)
    if state then
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
        pcall(function() setfpscap(9999) end)
        Lighting.GlobalShadows = false
        Lighting.Brightness = 2
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                if not SavedParts[part] then
                    SavedParts[part] = {Material = part.Material, CastShadow = part.CastShadow}
                end
                part.Material = Enum.Material.SmoothPlastic
                part.CastShadow = false
            end
            if part:IsA("Decal") or part:IsA("Texture") then
                if not SavedParts[part] then
                    SavedParts[part] = {Transparency = part.Transparency}
                end
                part.Transparency = 1
            end
        end
    else
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
        for part, data in pairs(SavedParts) do
            if part and part.Parent then
                pcall(function()
                    for k, v in pairs(data) do part[k] = v end
                end)
            end
        end
        SavedParts = {}
    end
end

function ToggleHighGraphics(state)
    if state then
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level21 end)
        Lighting.GlobalShadows = true
        Lighting.Brightness = 3.5
        Lighting.Ambient = Color3.fromRGB(80, 80, 100)
        Lighting.OutdoorAmbient = Color3.fromRGB(100, 110, 130)
        local bloom = Lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", Lighting)
        bloom.Intensity = 0.6
        bloom.Size = 24
        bloom.Threshold = 0.95
        local sunRays = Lighting:FindFirstChildOfClass("SunRaysEffect") or Instance.new("SunRaysEffect", Lighting)
        sunRays.Intensity = 0.25
        sunRays.Spread = 1
        local colorCorr = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
        colorCorr.Saturation = 0.2
        colorCorr.Contrast = 0.1
        colorCorr.Brightness = 0.05
    else
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
        Lighting.Brightness = 2
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(0, 0, 0)
        Lighting.OutdoorAmbient = Color3.fromRGB(0, 0, 0)
        for _, child in pairs(Lighting:GetChildren()) do
            if child:IsA("BloomEffect") or child:IsA("SunRaysEffect") or child:IsA("ColorCorrectionEffect") then
                child:Destroy()
            end
        end
    end
end

-- ====== 15. FOV SLIDER ======
function SetFOV(value)
    FOV = value
    CurrentCamera.FieldOfView = value
end

-- ====== RAYFIELD UI ======
local Window = Rayfield:CreateWindow({
    Name = "RuzHub MM2",
    LoadingTitle = "RuzHub Mobile",
    LoadingSubtitle = "by YinYang",
    ConfigurationSaving = {
        Enabled = true,
        FolderName = "RuzHub",
        FileName = "Settings"
    },
    Discord = {
        Enabled = false,
        Invite = "noinvite",
        RememberJoins = true
    },
    KeySystem = false,
    KeySettings = {
        Title = "RuzHub",
        Subtitle = "Key System",
        Note = "No key required"
    }
})

-- MAIN TAB
local MainTab = Window:CreateTab("Main", "zap")

MainTab:CreateParagraph({
    Title = "RuzHub Mobile MM2",
    Content = "Все функции адаптированы для телефона\nНажмите на кнопку для активации"
})

MainTab:CreateButton({
    Name = "Shoot / Throw",
    Callback = Shoot,
    Desc = "Авто-прицел и выстрел/бросок"
})

MainTab:CreateButton({
    Name = "Gold Bomb Jump",
    Callback = function() BombJump("Gold") end,
    Desc = "Прыжок с GoldBomb (4с кулдаун)"
})

MainTab:CreateButton({
    Name = "Normal Bomb Jump",
    Callback = function() BombJump("Normal") end,
    Desc = "Прыжок с NormalBomb (21с кулдаун)"
})

MainTab:CreateButton({
    Name = "Flick (180°)",
    Callback = Flick,
    Desc = "Мгновенный разворот на 180°"
})

MainTab:CreateButton({
    Name = "Wall Hop",
    Callback = WallHop,
    Desc = "Прыжок с поворотом камеры"
})

MainTab:CreateButton({
    Name = "Grab Gun (Teleport)",
    Callback = GrabGun,
    Desc = "Телепорт к выпавшему оружию"
})

-- AIM TAB
local AimTab = Window:CreateTab("Aim", "crosshair")

AimTab:CreateToggle({
    Name = "Aimbot",
    CurrentValue = false,
    Callback = function(state)
        AimbotEnabled = state
        if state then
            RunService.Heartbeat:Connect(UpdateAimbot)
        end
    end,
    Desc = "Автоматическое прицеливание"
})

AimTab:CreateToggle({
    Name = "Crosshair (ShiftLock)",
    CurrentValue = false,
    Callback = ToggleCrosshair,
    Desc = "Кастомный прицел (виден только в ShiftLock)"
})

AimTab:CreateToggle({
    Name = "Crosshair Spin",
    CurrentValue = false,
    Callback = function(state)
        CrosshairSpin = state
        if CrosshairImage then
            CrosshairImage.Rotation = 0
        end
    end,
    Desc = "Вращающийся прицел"
})

AimTab:CreateInput({
    Name = "Crosshair ID",
    CurrentValue = "98490421374360",
    PlaceholderText = "Введите ID изображения",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        CrosshairID = text
        if CrosshairImage then
            CrosshairImage.Image = "rbxassetid://" .. text
        end
    end,
    Desc = "ID картинки для прицела"
})

-- ESP TAB
local ESPTab = Window:CreateTab("ESP", "eye")

ESPTab:CreateToggle({
    Name = "ESP (Roles)",
    CurrentValue = false,
    Callback = ToggleESP,
    Desc = "Отображение ролей Murderer/Sheriff/Hero"
})

ESPTab:CreateToggle({
    Name = "Show Self",
    CurrentValue = false,
    Callback = function(state)
        ESPRoles.Self = state
    end,
    Desc = "Показывать себя в ESP"
})

ESPTab:CreateToggle({
    Name = "Gun ESP (Map)",
    CurrentValue = true,
    Callback = function(state)
        GunESPEnabled = state
    end,
    Desc = "Маркер выпавшего оружия"
})

-- MOVEMENT TAB
local MoveTab = Window:CreateTab("Movement", "move")

MoveTab:CreateToggle({
    Name = "Speed Glitch",
    CurrentValue = false,
    Callback = ToggleSpeedGlitch,
    Desc = "Увеличение скорости в прыжке"
})

MoveTab:CreateSlider({
    Name = "Speed Value",
    Range = {50, 600},
    Increment = 10,
    Suffix = "",
    CurrentValue = 200,
    Callback = function(value)
        MaxSpeed = value
    end,
    Desc = "Максимальная скорость"
})

MoveTab:CreateToggle({
    Name = "Anti-Fling (NoClip)",
    CurrentValue = false,
    Callback = ToggleAntiFling,
    Desc = "Защита от вылетов/ограничение скорости"
})

MoveTab:CreateSlider({
    Name = "FOV (Camera)",
    Range = {30, 120},
    Increment = 1,
    Suffix = "°",
    CurrentValue = 70,
    Callback = SetFOV,
    Desc = "Поле зрения камеры"
})

-- FLING TAB
local FlingTab = Window:CreateTab("Fling", "sword")

FlingTab:CreateButton({
    Name = "Fling Murderer",
    Callback = function()
        local target = FindFlingTarget("Murderer")
        if target then
            FlingPlayer(target, "Murderer")
        else
            Rayfield:Notify({Title = "RuzHub", Content = "No murderer found!", Duration = 2})
        end
    end,
    Desc = "Кинуть игрока с ножом"
})

FlingTab:CreateButton({
    Name = "Fling Sheriff",
    Callback = function()
        local target = FindFlingTarget("Sheriff")
        if target then
            FlingPlayer(target, "Sheriff")
        else
            Rayfield:Notify({Title = "RuzHub", Content = "No sheriff found!", Duration = 2})
        end
    end,
    Desc = "Кинуть игрока с пистолетом"
})

FlingTab:CreateParagraph({
    Title = "Fling Status",
    Content = "In Progress: " .. tostring(FlingInProgress)
})

-- GRAPHICS TAB
local GraphicsTab = Window:CreateTab("Graphics", "monitor")

GraphicsTab:CreateToggle({
    Name = "Low Graphics (FPS Boost)",
    CurrentValue = false,
    Callback = ToggleLowGraphics,
    Desc = "Убирает тени/текстуры для FPS"
})

GraphicsTab:CreateToggle({
    Name = "High Graphics (Beautiful)",
    CurrentValue = false,
    Callback = ToggleHighGraphics,
    Desc = "Включает Bloom/SunRays/эффекты"
})

GraphicsTab:CreateToggle({
    Name = "Stretch (Wide)",
    CurrentValue = false,
    Callback = ToggleStretch,
    Desc = "Растягивает изображение"
})

GraphicsTab:CreateSlider({
    Name = "Stretch Factor",
    Range = {10, 100},
    Increment = 5,
    Suffix = "%",
    CurrentValue = 50,
    Callback = function(value)
        StretchFactor = value / 100
        if StretchEnabled then
            ToggleStretch(true)
        end
    end,
    Desc = "10% = широкое, 100% = нормальное"
})

-- SKYBOX TAB
local SkyTab = Window:CreateTab("Skybox", "cloud")

SkyTab:CreateButton({
    Name = "Restore Default Sky",
    Callback = RestoreSkybox,
    Desc = "Вернуть стандартное небо"
})

SkyTab:CreateInput({
    Name = "Skybox ID",
    CurrentValue = "",
    PlaceholderText = "Введите ID неба",
    RemoveTextAfterFocusLost = false,
    Callback = function(text)
        if text ~= "" then
            ApplySkybox(text)
            Rayfield:Notify({Title = "RuzHub", Content = "Skybox applied!", Duration = 2})
        end
    end,
    Desc = "ID картинки для неба"
})

-- Preset Skybox Buttons
local SkyPresets = {
    {"Red", "98490421374360"},
    {"Pink", "95000769820905"},
    {"Green", "5036205687"},
    {"Black", "80807192441609"},
    {"Cosmic", "77816282467771"},
    {"Yellow", "2669948520"}
}

for _, preset in ipairs(SkyPresets) do
    SkyTab:CreateButton({
        Name = preset[1],
        Callback = function()
            ApplySkybox(preset[2])
            Rayfield:Notify({Title = "RuzHub", Content = "Skybox: " .. preset[1], Duration = 2})
        end,
        Desc = "Применить " .. preset[1] .. " небо"
    })
end

-- ====== ИНИЦИАЛИЗАЦИЯ ======
SaveDefaultSky()
MonitorGunDrops()

Rayfield:Notify({
    Title = "RuzHub Mobile",
    Content = "Загружено! Все функции готовы.",
    Duration = 3
})

print("RuzHub Mobile MM2 loaded!")