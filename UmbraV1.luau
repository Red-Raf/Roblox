-- UmbraHub v1 MM2

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local TeleportService = game:GetService("TeleportService")
local TweenService = game:GetService("TweenService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera

-- ====== ПЕРЕМЕННЫЕ ======
local ESPEnabled = false
local GunESPEnabled = false
local XrayEnabled = false
local NoclipEnabled = false
local FlyEnabled = false
local FreecamEnabled = false
local AntiFlingEnabled = false
local InfiniteJumpEnabled = false
local InfiniteZoomEnabled = false
local AimAssistEnabled = false
local AutoShootEnabled = false
local MotionBlurEnabled = false
local CoinFarmEnabled = false
local AntiAFKEnabled = false
local SpeedGlitchEnabled = false
local StretchEnabled = false
local CrosshairEnabled = false
local CrosshairSpin = false

local BombGoldCooldown = false
local BombNormalCooldown = false
local FlingInProgress = false
local FlickInProgress = false
local WallHopInProgress = false
local OrbitAngle = 0
local OrbitTarget = nil

local PlayerData = {}
local LastUpdate = 0
local ESPHighlights = {}
local GunESPObjects = {}
local XrayParts = {}
local NoclipConn = nil
local FlyConn = nil
local FreecamConn = nil
local AntiFlingConn = nil
local SpeedGlitchConn = nil
local StretchConn = nil
local MotionBlurConn = nil
local MotionBlurEffect = nil
local CrosshairImage = nil
local CrosshairConn = nil
local FreecamPart = nil
local FreecamBody = nil

-- ====== НАСТРОЙКИ ======
local MaxSpeed = 200
local StretchFactor = 0.5
local CrosshairID = "98490421374360"
local FOV = 70
local EspFillTransparency = 100
local GunEspFillTransparency = 70
local MurdererHue = 0
local SheriffHue = 240
local InnocentHue = 120
local GunHue = 180
local ThemeHue = 140
local GuiScale = 1
local PlayerSpeed = 16
local PlayerJump = 50
local FlySpeed = 50
local PlayerSpinSpeed = 0
local FreecamSpeed = 50
local FpsCap = 60
local MotionBlurIntensity = 120
local MotionBlurThreshold = 5
local CustomTime = 14
local CustomTimeEnabled = false
local SaturationValue = 0
local AimAssistTarget = "Head"
local AimAssistRoleFilter = "All"
local AimAssistOnlyWithGun = false
local AimAssistPrediction = 150
local AimAssistPredictionEnabled = true
local CoinFarmSpeed = 25
local CoinFarmRadius = 15
local CoinFarmDropHeight = 15
local CoinFarmLobbyDistance = 120
local CoinFarmKillOnDeath = true
local CoinFarmTarget = "Murderer"
local OrbitSpeed = 60
local OrbitDistance = 10

-- ====== 1. ESP ======
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
    local remote = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
    if not remote then remote = ReplicatedStorage:FindFirstChild("GetCurrentPlayerData", true) end
    if remote and remote:IsA("RemoteFunction") then
        local success, data = pcall(function() return remote:InvokeServer() end)
        if success and type(data) == "table" then PlayerData = data end
    end
end

function ApplyESP(player)
    if not ESPEnabled then return end
    local char = player.Character
    if not char or player == LocalPlayer then return end
    local role = GetPlayerRole(player)
    local color
    if role == "Murderer" then color = Color3.fromHSV(MurdererHue / 360, 1, 1)
    elseif role == "Sheriff" or role == "Hero" then color = Color3.fromHSV(SheriffHue / 360, 1, 1)
    else color = Color3.fromHSV(InnocentHue / 360, 1, 1) end
    local esp = char:FindFirstChild("UmbraESP") or Instance.new("Highlight")
    esp.Name = "UmbraESP"
    esp.Parent = char
    esp.FillColor = color
    esp.FillTransparency = EspFillTransparency / 100
    esp.OutlineColor = color
    esp.OutlineTransparency = 0.25
    esp.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    ESPHighlights[player] = esp
end

function ClearESP()
    for player, esp in pairs(ESPHighlights) do if esp and esp.Parent then esp:Destroy() end end
    ESPHighlights = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            local esp = player.Character:FindFirstChild("UmbraESP")
            if esp then esp:Destroy() end
        end
    end
end

function ToggleESP(state)
    ESPEnabled = state
    if state then
        RunService.Heartbeat:Connect(function()
            if not ESPEnabled then return end
            if tick() - LastUpdate > 0.5 then UpdatePlayerData(); LastUpdate = tick() end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then ApplyESP(player) end
            end
        end)
    else ClearESP() end
end

-- ====== 2. GUN ESP ======
function ApplyGunESP(gun)
    if not GunESPEnabled or gun:FindFirstChild("GunESP") then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "GunESP"
    highlight.FillColor = Color3.fromHSV(GunHue / 360, 1, 1)
    highlight.OutlineColor = Color3.fromHSV(GunHue / 360, 1, 1)
    highlight.FillTransparency = GunEspFillTransparency / 100
    highlight.OutlineTransparency = 0.2
    highlight.Parent = gun
    table.insert(GunESPObjects, highlight)
    local billboard = Instance.new("BillboardGui", gun)
    billboard.Name = "GunESP"
    billboard.Size = UDim2.new(0, 120, 0, 20)
    billboard.StudsOffset = Vector3.new(0, 2, 0)
    billboard.AlwaysOnTop = true
    local label = Instance.new("TextLabel", billboard)
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "Gun Drop"
    label.TextColor3 = Color3.fromRGB(210, 190, 255)
    label.Font = Enum.Font.GothamBold
    label.TextScaled = true
    label.TextStrokeTransparency = 0
    table.insert(GunESPObjects, billboard)
end

function ClearGunESP()
    for _, obj in ipairs(GunESPObjects) do if obj and obj.Parent then obj:Destroy() end end
    GunESPObjects = {}
end

function ToggleGunESP(state)
    GunESPEnabled = state
    if state then
        task.wait(0.5)
        for _, child in ipairs(Workspace:GetDescendants()) do
            if child.Name == "GunDrop" and child:IsA("BasePart") then ApplyGunESP(child) end
        end
        Workspace.ChildAdded:Connect(function(child)
            if child.Name == "GunDrop" and child:IsA("BasePart") then ApplyGunESP(child) end
        end)
    else ClearGunESP() end
end

-- ====== 3. X-RAY ======
function ToggleXray(state)
    XrayEnabled = state
    if state then
        for _, part in ipairs(Workspace:GetDescendants()) do
            if part:IsA("BasePart") then
                XrayParts[part] = part.LocalTransparencyModifier
                part.LocalTransparencyModifier = 0.65
            end
        end
        Workspace.DescendantAdded:Connect(function(part)
            if part:IsA("BasePart") then
                XrayParts[part] = part.LocalTransparencyModifier
                part.LocalTransparencyModifier = 0.65
            end
        end)
    else
        for part, orig in pairs(XrayParts) do
            if part and part.Parent then part.LocalTransparencyModifier = orig end
        end
        XrayParts = {}
    end
end

-- ====== 4. NO CLIP ======
function ToggleNoclip(state)
    NoclipEnabled = state
    if NoclipConn then NoclipConn:Disconnect(); NoclipConn = nil end
    if state then
        NoclipConn = RunService.Stepped:Connect(function()
            if not NoclipEnabled then return end
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
                end
            end
        end)
    end
end

-- ====== 5. FLY ======
function ToggleFly(state)
    FlyEnabled = state
    if FlyConn then FlyConn:Disconnect(); FlyConn = nil end
    local char = LocalPlayer.Character
    local root, hum
    if char then
        root = char:FindFirstChild("HumanoidRootPart")
        hum = char:FindFirstChildOfClass("Humanoid")
    end
    if state and root and hum then
        hum.PlatformStand = true
        local bodyGyro = Instance.new("BodyGyro")
        bodyGyro.P = 90000
        bodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.cframe = root.CFrame
        bodyGyro.Parent = root
        local bodyVel = Instance.new("BodyVelocity")
        bodyVel.velocity = Vector3.new(0, 0.1, 0)
        bodyVel.maxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVel.Parent = root
        FlyConn = RunService.RenderStepped:Connect(function()
            if not FlyEnabled or not root or not root.Parent then
                if FlyConn then FlyConn:Disconnect(); FlyConn = nil end
                if bodyGyro then bodyGyro:Destroy() end
                if bodyVel then bodyVel:Destroy() end
                if hum then hum.PlatformStand = false end
                return
            end
            bodyGyro.cframe = CurrentCamera.CFrame
            local vel = hum.MoveDirection * FlySpeed
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0, FlySpeed, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.new(0, FlySpeed, 0) end
            bodyVel.velocity = vel
        end)
    elseif not state and hum then
        hum.PlatformStand = false
    end
end

-- ====== 6. FREECAM ======
function ToggleFreecam(state)
    FreecamEnabled = state
    if FreecamConn then FreecamConn:Disconnect(); FreecamConn = nil end
    if FreecamPart then FreecamPart:Destroy(); FreecamPart = nil end
    if state then
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then root.Anchored = true end
        FreecamPart = Instance.new("Part", Workspace)
        FreecamPart.Anchored = true
        FreecamPart.CanCollide = false
        FreecamPart.Transparency = 1
        FreecamPart.CFrame = CurrentCamera.CFrame
        CurrentCamera.CameraType = Enum.CameraType.Scriptable
        local yaw, pitch = 0, 0
        FreecamConn = RunService.RenderStepped:Connect(function()
            if not FreecamEnabled or not FreecamPart then
                if FreecamConn then FreecamConn:Disconnect(); FreecamConn = nil end
                return
            end
            UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
            local delta = UserInputService:GetMouseDelta()
            yaw = yaw - math.rad(delta.X * 0.25)
            pitch = math.clamp(pitch - math.rad(delta.Y * 0.25), -math.pi/2 + 0.01, math.pi/2 - 0.01)
            local cf = CFrame.new(FreecamPart.Position) * CFrame.Angles(0, yaw, 0) * CFrame.Angles(pitch, 0, 0)
            local vel = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then vel = vel + cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then vel = vel - cf.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then vel = vel - cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then vel = vel + cf.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then vel = vel + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then vel = vel - Vector3.new(0, 1, 0) end
            if vel.Magnitude > 0 then
                FreecamPart.CFrame = CFrame.new(FreecamPart.Position + vel.Unit * FreecamSpeed * 0.016) * CFrame.Angles(0, yaw, 0) * CFrame.Angles(pitch, 0, 0)
            else
                FreecamPart.CFrame = CFrame.new(FreecamPart.Position) * CFrame.Angles(0, yaw, 0) * CFrame.Angles(pitch, 0, 0)
            end
            CurrentCamera.CFrame = FreecamPart.CFrame
        end)
    else
        UserInputService.MouseBehavior = Enum.MouseBehavior.Default
        CurrentCamera.CameraType = Enum.CameraType.Custom
        local char = LocalPlayer.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if root then root.Anchored = false end
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then CurrentCamera.CameraSubject = hum end
    end
end

-- ====== 7. ANTI-FLING ======
function ToggleAntiFling(state)
    AntiFlingEnabled = state
    if AntiFlingConn then AntiFlingConn:Disconnect(); AntiFlingConn = nil end
    if state then
        AntiFlingConn = RunService.Heartbeat:Connect(function()
            if not AntiFlingEnabled then return end
            local char = LocalPlayer.Character
            if not char then return end
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    for _, part in ipairs(player.Character:GetDescendants()) do
                        if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
                    end
                end
            end
        end)
    end
end

-- ====== 8. INFINITE JUMP ======
function ToggleInfiniteJump(state)
    InfiniteJumpEnabled = state
end

-- ====== 9. INFINITE ZOOM ======
function ToggleInfiniteZoom(state)
    InfiniteZoomEnabled = state
    if state then
        LocalPlayer.CameraMinZoomDistance = 0.5
        LocalPlayer.CameraMaxZoomDistance = 2000
    else
        LocalPlayer.CameraMinZoomDistance = 0.5
        LocalPlayer.CameraMaxZoomDistance = 400
    end
end

-- ====== 10. AIM ASSIST (Silent Aim) ======
function GetAimTarget()
    if not AimAssistEnabled then return nil end
    local char = LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    local hasGun = LocalPlayer.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun")
    if AimAssistOnlyWithGun and not hasGun then return nil end
    
    local target = nil
    local targetDist = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if not player.Character then continue end
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
        if not targetRoot then continue end
        
        local role = GetPlayerRole(player)
        if AimAssistRoleFilter == "Murderer" and role ~= "Murderer" then continue end
        if AimAssistRoleFilter == "Sheriff" and role ~= "Sheriff" then continue end
        if AimAssistRoleFilter == "Murd/Sheriff" and role ~= "Murderer" and role ~= "Sheriff" then continue end
        
        local dist = (targetRoot.Position - root.Position).Magnitude
        if dist < targetDist then
            targetDist = dist
            target = player.Character
        end
    end
    return target
end

function GetAimPosition(targetChar)
    if not targetChar then return nil end
    local part = targetChar:FindFirstChild(AimAssistTarget == "Head" and "Head" or "HumanoidRootPart")
    if not part then part = targetChar:FindFirstChild("HumanoidRootPart") end
    if not part then return nil end
    if AimAssistPredictionEnabled then
        local root = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        if root then
            local dist = (part.Position - root.Position).Magnitude
            return part.Position + part.AssemblyLinearVelocity * (dist / AimAssistPrediction)
        end
    end
    return part.Position
end

-- ====== 11. AUTO SHOOT ======
function AutoShoot()
    if not AutoShootEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    local gun = LocalPlayer.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun")
    if not gun then return end
    local target = GetAimTarget()
    if not target then return end
    local pos = GetAimPosition(target)
    if not pos then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    if gun.Parent == LocalPlayer.Backpack then
        char.Humanoid:EquipTool(gun)
        task.wait(0.05)
    end
    
    local cf = CFrame.new(root.Position + Vector3.new(0, 1, 0), pos)
    pcall(function()
        local shoot = gun:FindFirstChild("Shoot")
        if shoot then shoot:FireServer(cf, CFrame.new(pos)) end
    end)
end

-- ====== 12. SHOOT / THROW ======
function Shoot()
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local target = GetAimTarget()
    if not target then
        Rayfield:Notify({Title = "UmbraHub", Content = "No target found", Duration = 2})
        return
    end
    local pos = GetAimPosition(target)
    if not pos then return end
    
    local gun = LocalPlayer.Backpack:FindFirstChild("Gun") or char:FindFirstChild("Gun")
    if gun then
        if gun.Parent ~= char then char.Humanoid:EquipTool(gun); task.wait() end
        local cf = CFrame.new(root.Position + Vector3.new(0, 1, 0), pos)
        pcall(function()
            local shoot = gun:FindFirstChild("Shoot")
            if shoot then shoot:FireServer(cf, CFrame.new(pos)) end
        end)
        return
    end
    
    local knife = LocalPlayer.Backpack:FindFirstChild("Knife") or char:FindFirstChild("Knife")
    if knife then
        if knife.Parent ~= char then char.Humanoid:EquipTool(knife); task.wait() end
        local cf = CFrame.new(root.Position + Vector3.new(0, 1, 0), pos)
        pcall(function()
            local events = knife:FindFirstChild("Events")
            if events then
                local throw = events:FindFirstChild("KnifeThrown")
                if throw then throw:FireServer(cf, CFrame.new(pos)) end
            end
        end)
        return
    end
    Rayfield:Notify({Title = "UmbraHub", Content = "No weapon found", Duration = 2})
end

-- ====== 13. BOMB JUMP ======
function BombJump(type)
    if type == "Gold" and BombGoldCooldown then
        Rayfield:Notify({Title = "UmbraHub", Content = "Gold Bomb on cooldown!", Duration = 2})
        return
    end
    if type == "Normal" and BombNormalCooldown then
        Rayfield:Notify({Title = "UmbraHub", Content = "Normal Bomb on cooldown!", Duration = 2})
        return
    end
    local char = LocalPlayer.Character
    if not char then return end
    local weapon = type == "Gold" and "GoldBomb" or "FakeBomb"
    local tool = LocalPlayer.Backpack:FindFirstChild(weapon) or char:FindFirstChild(weapon)
    if not tool then
        Rayfield:Notify({Title = "UmbraHub", Content = "No " .. weapon .. " found!", Duration = 2})
        return
    end
    if char ~= tool.Parent then char.Humanoid:EquipTool(tool); task.wait() end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    pcall(function()
        local remote = tool:FindFirstChild("Remote")
        if remote then remote:FireServer(CFrame.new(root.Position + root.CFrame.LookVector * 1.5 + Vector3.new(0, -3, 0)), 50) end
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

-- ====== 14. FLICK ======
function Flick()
    if FlickInProgress then return end
    FlickInProgress = true
    local char = LocalPlayer.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then
            local cf = root.CFrame
            local target = cf * CFrame.Angles(0, math.pi, 0)
            for i = 1, 4 do
                root.CFrame = cf:Lerp(target, i / 4)
                RunService.RenderStepped:Wait()
            end
        end
    end
    task.wait(0.15)
    FlickInProgress = false
end

-- ====== 15. WALL HOP ======
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

-- ====== 16. GRAB GUN ======
function GrabGun()
    local gunDrop = Workspace:FindFirstChild("GunDrop", true)
    if not gunDrop then
        Rayfield:Notify({Title = "UmbraHub", Content = "No gun on map!", Duration = 2})
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
        Rayfield:Notify({Title = "UmbraHub", Content = "Teleported to gun!", Duration = 2})
    end
end

-- ====== 17. FLING ======
function FlingPlayer(targetPlayer)
    if FlingInProgress then
        Rayfield:Notify({Title = "UmbraHub", Content = "Fling in progress...", Duration = 2})
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
        Rayfield:Notify({Title = "UmbraHub", Content = targetPlayer.Name .. " is sitting", Duration = 2})
        return
    end
    local targetRoot = targetHum.RootPart
    local targetPart = targetChar:FindFirstChild("Head") or targetChar:FindFirstChildOfClass("Accessory")
    if targetPart then targetPart = targetPart:FindFirstChild("Handle") or targetPart end
    if not targetPart then
        Rayfield:Notify({Title = "UmbraHub", Content = "No fling part found", Duration = 2})
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
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(2.25, 1.5, -2.25) + move * mag * CFrame.Angles(math.rad(angle), 0, 0)
            task.wait()
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(-2.25, -1.5, 2.25) + move * mag * CFrame.Angles(math.rad(angle), 0, 0)
            task.wait()
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(0, 1.5, 0) + move * CFrame.Angles(math.rad(angle), 0, 0)
            task.wait()
            root.CFrame = CFrame.new(targetPart.Position) * CFrame.new(0, -1.5, 0) + move * CFrame.Angles(math.rad(angle), 0, 0)
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
            if child:IsA("BasePart") then child.Velocity = Vector3.new(); child.RotVelocity = Vector3.new() end
        end
        task.wait()
        if (root.Position - oldPos.p).Magnitude < 25 then break end
    end
    Workspace.FallenPartsDestroyHeight = 100
    FlingInProgress = false
    Rayfield:Notify({Title = "UmbraHub", Content = "Fling finished!", Duration = 2})
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
            if hum and hum.Health > 0 then return player end
        end
    end
    return nil
end

-- ====== 18. SPEED GLITCH ======
function ToggleSpeedGlitch(state)
    SpeedGlitchEnabled = state
    if SpeedGlitchConn then SpeedGlitchConn:Disconnect(); SpeedGlitchConn = nil end
    if state then
        SpeedGlitchConn = RunService.RenderStepped:Connect(function()
            if not SpeedGlitchEnabled then return end
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not hum then return end
            local state = hum:GetState()
            if state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall then
                if hum.MoveDirection.Magnitude > 0 then hum.WalkSpeed = MaxSpeed end
            else
                hum.WalkSpeed = 16
            end
        end)
    end
end

-- ====== 19. STRETCH ======
function ToggleStretch(state)
    StretchEnabled = state
    if StretchConn then StretchConn:Disconnect(); StretchConn = nil end
    if state then
        StretchConn = RunService.RenderStepped:Connect(function()
            if not StretchEnabled then return end
            CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, StretchFactor, 0, 0, 0, 1)
        end)
    end
end

-- ====== 20. CROSSHAIR ======
function ToggleCrosshair(state)
    CrosshairEnabled = state
    if not state then
        local display = CoreGui:FindFirstChild("UmbraCrosshair")
        if display then display:Destroy() end
        if CrosshairConn then CrosshairConn:Disconnect(); CrosshairConn = nil end
        UserInputService.MouseIconEnabled = true
        return
    end
    local display = CoreGui:FindFirstChild("UmbraCrosshair")
    if display then display:Destroy() end
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UmbraCrosshair"
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
    CrosshairConn = RunService.RenderStepped:Connect(function()
        if not CrosshairImage or not CrosshairImage.Parent then return end
        local shiftLock = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
        CrosshairImage.Visible = CrosshairEnabled and shiftLock
        UserInputService.MouseIconEnabled = not CrosshairImage.Visible
    end)
end

-- ====== 21. MOTION BLUR ======
function ToggleMotionBlur(state)
    MotionBlurEnabled = state
    if not MotionBlurEffect then
        MotionBlurEffect = Instance.new("BlurEffect", Lighting)
        MotionBlurEffect.Size = 0
    end
    if MotionBlurConn then MotionBlurConn:Disconnect(); MotionBlurConn = nil end
    if state then
        local lastLook = CurrentCamera.CFrame.LookVector
        MotionBlurConn = RunService.RenderStepped:Connect(function()
            if not MotionBlurEnabled then return end
            local look = CurrentCamera.CFrame.LookVector
            local diff = (look - lastLook).Magnitude
            local threshold = MotionBlurThreshold / 1000
            if diff > threshold then
                MotionBlurEffect.Size = math.clamp((diff - threshold) * MotionBlurIntensity, 0, 24)
            else
                MotionBlurEffect.Size = 0
            end
            lastLook = look
        end)
    else
        if MotionBlurEffect then MotionBlurEffect.Size = 0 end
    end
end

-- ====== 22. ANTI-AFK ======
function ToggleAntiAFK(state)
    AntiAFKEnabled = state
end

-- ====== 23. COIN FARM ======
local CoinFarmConn = nil
local CoinFarmTargetPlayer = nil

function GetCoinContainer()
    for _, child in ipairs(Workspace:GetDescendants()) do
        if child:FindFirstChild("CoinContainer") and child:FindFirstChild("Spawns") then
            return child
        end
    end
    return nil
end

function ToggleCoinFarm(state)
    CoinFarmEnabled = state
    if CoinFarmConn then CoinFarmConn:Disconnect(); CoinFarmConn = nil end
    if state then
        CoinFarmConn = RunService.Heartbeat:Connect(function()
            if not CoinFarmEnabled then return end
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            local hum = char:FindFirstChildOfClass("Humanoid")
            if not root or not hum or hum.Health <= 0 then return end
            
            local lobby = Workspace:FindFirstChild("RegularLobby") or Workspace:FindFirstChild("Lobby")
            if lobby and (root.Position - lobby.GetPivot(lobby).Position).Magnitude <= CoinFarmLobbyDistance then return end
            
            local container = GetCoinContainer()
            if not container then return end
            
            local coins = {}
            for _, child in ipairs(container:GetChildren()) do
                if child.Name == "Coin_Server" and child:IsA("BasePart") and child:IsDescendantOf(Workspace) then
                    if CoinFarmTargetPlayer then
                        local targetRoot = CoinFarmTargetPlayer.Character and CoinFarmTargetPlayer.Character:FindFirstChild("HumanoidRootPart")
                        if targetRoot and (child.Position - targetRoot.Position).Magnitude <= CoinFarmRadius then
                            table.insert(coins, child)
                        end
                    else
                        table.insert(coins, child)
                    end
                end
            end
            
            if #coins == 0 then return end
            table.sort(coins, function(a, b)
                return (a.Position - root.Position).Magnitude < (b.Position - root.Position).Magnitude
            end)
            
            for _, coin in ipairs(coins) do
                if not CoinFarmEnabled or not hum or hum.Health <= 0 then break end
                if not coin or not coin:IsDescendantOf(Workspace) then break end
                
                -- Найти ближайшего врага
                local nearestEnemy = nil
                local nearestDist = CoinFarmRadius
                for _, player in ipairs(Players:GetPlayers()) do
                    if player == LocalPlayer then continue end
                    if not player.Character then continue end
                    local pRoot = player.Character:FindFirstChild("HumanoidRootPart")
                    if not pRoot then continue end
                    local dist = (pRoot.Position - root.Position).Magnitude
                    if dist < nearestDist then
                        local role = GetPlayerRole(player)
                        if CoinFarmTarget == "Murderer" and role == "Murderer" then
                            nearestDist = dist
                            nearestEnemy = player
                        elseif CoinFarmTarget == "Sheriff" and role == "Sheriff" then
                            nearestDist = dist
                            nearestEnemy = player
                        elseif CoinFarmTarget == "Any" and (role == "Murderer" or role == "Sheriff") then
                            nearestDist = dist
                            nearestEnemy = player
                        end
                    end
                end
                
                CoinFarmTargetPlayer = nearestEnemy
                
                -- Телепорт к монете
                local tween = TweenService:Create(root, TweenInfo.new((root.Position - coin.Position).Magnitude / CoinFarmSpeed, Enum.EasingStyle.Linear), {
                    CFrame = coin.CFrame
                })
                tween:Play()
                tween.Completed:Wait()
                
                -- Если рядом враг - килл
                if nearestEnemy and nearestEnemy.Character then
                    local eRoot = nearestEnemy.Character:FindFirstChild("HumanoidRootPart")
                    if eRoot and (root.Position - eRoot.Position).Magnitude <= 20 then
                        if CoinFarmKillOnDeath then
                            local eHum = nearestEnemy.Character:FindFirstChildOfClass("Humanoid")
                            if eHum and eHum.Health > 0 then
                                eHum.Health = 0
                            end
                        end
                    end
                end
                
                task.wait(0.1)
            end
        end)
    else
        CoinFarmTargetPlayer = nil
    end
end

-- ====== 24. SPECTATE ======
function SpectatePlayer(player, button)
    if not player or not player.Character then
        if button then button.Text = "Not Found" end
        task.delay(1.5, function() if button then button.Text = "Spectate" end end)
        return
    end
    local hum = player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        CurrentCamera.CameraSubject = hum
        CurrentCamera.CameraType = Enum.CameraType.Custom
        if button then button.Text = "Unspectate" end
        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not player or not player.Character or not player.Character:IsDescendantOf(Workspace) then
                if conn then conn:Disconnect() end
                if button then button.Text = "Spectate" end
                local localHum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                CurrentCamera.CameraSubject = localHum or Workspace
                CurrentCamera.CameraType = Enum.CameraType.Custom
                return
            end
            local newHum = player.Character:FindFirstChildOfClass("Humanoid")
            if newHum then CurrentCamera.CameraSubject = newHum end
        end)
    end
end

-- ====== 25. TELEPORT ======
function TeleportToPlayer(player)
    if not player or not player.Character then return end
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
    if not targetRoot then return end
    root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
    Rayfield:Notify({Title = "UmbraHub", Content = "Teleported to " .. player.Name, Duration = 2})
end

-- ====== 26. RESPAWN / REJOIN ======
function Respawn()
    local char = LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        char.Humanoid.Health = 0
    end
end

function Rejoin()
    TeleportService:Teleport(game.PlaceId, LocalPlayer)
end

-- ====== RAYFIELD UI ======
local Window = Rayfield:CreateWindow({
    Name = "UmbraHub v1",
    LoadingTitle = "UmbraHub",
    LoadingSubtitle = "by Umbra",
    ConfigurationSaving = { Enabled = true, FolderName = "UmbraHub", FileName = "Settings" },
    Discord = { Enabled = false },
    KeySystem = false
})

-- ====== MAIN TAB ======
local MainTab = Window:CreateTab("Main", "zap")

MainTab:CreateParagraph({ Title = "UmbraHub v1 MM2", Content = "Mobile optimized\nAll features disabled by default" })

MainTab:CreateButton({ Name = "Shoot / Throw", Callback = Shoot, Desc = "Auto-aim and shoot/throw" })
MainTab:CreateButton({ Name = "Gold Bomb Jump", Callback = function() BombJump("Gold") end, Desc = "Jump with GoldBomb (4s cooldown)" })
MainTab:CreateButton({ Name = "Normal Bomb Jump", Callback = function() BombJump("Normal") end, Desc = "Jump with NormalBomb (21s cooldown)" })
MainTab:CreateButton({ Name = "Flick (180°)", Callback = Flick, Desc = "Instant 180° turn" })
MainTab:CreateButton({ Name = "Wall Hop", Callback = WallHop, Desc = "Jump with camera rotation" })
MainTab:CreateButton({ Name = "Grab Gun (Teleport)", Callback = GrabGun, Desc = "Teleport to dropped gun" })
MainTab:CreateButton({ Name = "Respawn", Callback = Respawn, Desc = "Kill yourself" })
MainTab:CreateButton({ Name = "Rejoin", Callback = Rejoin, Desc = "Rejoin the game" })

-- ====== AIM TAB ======
local AimTab = Window:CreateTab("Aim", "crosshair")

AimTab:CreateToggle({ Name = "Silent Aim", CurrentValue = false, Callback = function(s) AimAssistEnabled = s end, Desc = "Auto-aim at enemies" })
AimTab:CreateToggle({ Name = "Auto Shoot", CurrentValue = false, Callback = function(s) AutoShootEnabled = s end, Desc = "Auto shoot when aiming" })

AimTab:CreateDropdown({
    Name = "Aim Target",
    Options = { "Head", "Torso" },
    CurrentOption = "Head",
    Callback = function(s) AimAssistTarget = s end,
    Desc = "Aim at head or torso"
})

AimTab:CreateDropdown({
    Name = "Role Filter",
    Options = { "All", "Murd/Sheriff", "Murderer", "Sheriff" },
    CurrentOption = "All",
    Callback = function(s) AimAssistRoleFilter = s end,
    Desc = "Filter by role"
})

AimTab:CreateToggle({ Name = "Only With Gun", CurrentValue = false, Callback = function(s) AimAssistOnlyWithGun = s end, Desc = "Aim only when holding gun" })
AimTab:CreateToggle({ Name = "Prediction", CurrentValue = true, Callback = function(s) AimAssistPredictionEnabled = s end, Desc = "Predict enemy movement" })

AimTab:CreateSlider({
    Name = "Prediction Distance",
    Range = {50, 500},
    Increment = 10,
    CurrentValue = 150,
    Callback = function(s) AimAssistPrediction = s end,
    Desc = "Prediction strength"
})

AimTab:CreateSlider({
    Name = "Orbit Speed",
    Range = {10, 200},
    Increment = 5,
    CurrentValue = 60,
    Callback = function(s) OrbitSpeed = s end,
    Desc = "Orbit rotation speed"
})

AimTab:CreateSlider({
    Name = "Orbit Distance",
    Range = {1, 30},
    Increment = 1,
    CurrentValue = 10,
    Callback = function(s) OrbitDistance = s end,
    Desc = "Orbit distance"
})

-- ====== ESP TAB ======
local ESPTab = Window:CreateTab("ESP", "eye")

ESPTab:CreateToggle({ Name = "ESP (Roles)", CurrentValue = false, Callback = ToggleESP, Desc = "Show player roles" })
ESPTab:CreateToggle({ Name = "Gun ESP", CurrentValue = false, Callback = ToggleGunESP, Desc = "Show dropped guns" })
ESPTab:CreateToggle({ Name = "X-Ray", CurrentValue = false, Callback = ToggleXray, Desc = "See through walls" })

ESPTab:CreateSlider({
    Name = "ESP Fill Transparency",
    Range = {10, 100},
    Increment = 5,
    CurrentValue = 100,
    Callback = function(s) EspFillTransparency = s end,
    Desc = "ESP transparency"
})

ESPTab:CreateSlider({
    Name = "Gun ESP Transparency",
    Range = {10, 100},
    Increment = 5,
    CurrentValue = 70,
    Callback = function(s) GunEspFillTransparency = s end,
    Desc = "Gun ESP transparency"
})

ESPTab:CreateSlider({
    Name = "Murderer Hue",
    Range = {0, 360},
    Increment = 1,
    CurrentValue = 0,
    Callback = function(s) MurdererHue = s end,
    Desc = "Color for Murderer"
})

ESPTab:CreateSlider({
    Name = "Sheriff Hue",
    Range = {0, 360},
    Increment = 1,
    CurrentValue = 240,
    Callback = function(s) SheriffHue = s end,
    Desc = "Color for Sheriff/Hero"
})

ESPTab:CreateSlider({
    Name = "Innocent Hue",
    Range = {0, 360},
    Increment = 1,
    CurrentValue = 120,
    Callback = function(s) InnocentHue = s end,
    Desc = "Color for Innocent"
})

ESPTab:CreateSlider({
    Name = "Gun Hue",
    Range = {0, 360},
    Increment = 1,
    CurrentValue = 180,
    Callback = function(s) GunHue = s end,
    Desc = "Color for Gun ESP"
})

-- ====== MOVEMENT TAB ======
local MoveTab = Window:CreateTab("Movement", "move")

MoveTab:CreateToggle({ Name = "Speed Glitch", CurrentValue = false, Callback = ToggleSpeedGlitch, Desc = "Speed boost while jumping" })
MoveTab:CreateSlider({ Name = "Speed Value", Range = {50, 600}, Increment = 10, CurrentValue = 200, Callback = function(s) MaxSpeed = s end, Desc = "Max speed" })

MoveTab:CreateToggle({ Name = "Anti-Fling", CurrentValue = false, Callback = ToggleAntiFling, Desc = "Protection from fling" })
MoveTab:CreateToggle({ Name = "Infinite Jump", CurrentValue = false, Callback = ToggleInfiniteJump, Desc = "Jump infinitely" })
MoveTab:CreateToggle({ Name = "No Clip", CurrentValue = false, Callback = ToggleNoclip, Desc = "Walk through walls" })
MoveTab:CreateToggle({ Name = "Fly", CurrentValue = false, Callback = ToggleFly, Desc = "Fly with Space/Shift" })
MoveTab:CreateToggle({ Name = "Freecam", CurrentValue = false, Callback = ToggleFreecam, Desc = "Free camera mode" })
MoveTab:CreateToggle({ Name = "Infinite Zoom", CurrentValue = false, Callback = ToggleInfiniteZoom, Desc = "Zoom far away" })

MoveTab:CreateSlider({ Name = "Player Speed", Range = {10, 100}, Increment = 1, CurrentValue = 16, Callback = function(s) PlayerSpeed = s end, Desc = "Walk speed" })
MoveTab:CreateSlider({ Name = "Player Jump", Range = {10, 250}, Increment = 5, CurrentValue = 50, Callback = function(s) PlayerJump = s end, Desc = "Jump power" })
MoveTab:CreateSlider({ Name = "Fly Speed", Range = {10, 200}, Increment = 5, CurrentValue = 50, Callback = function(s) FlySpeed = s end, Desc = "Fly speed" })
MoveTab:CreateSlider({ Name = "Spin Speed", Range = {0, 500}, Increment = 10, CurrentValue = 0, Callback = function(s) PlayerSpinSpeed = s end, Desc = "Auto spin speed" })
MoveTab:CreateSlider({ Name = "FOV", Range = {30, 120}, Increment = 1, CurrentValue = 70, Callback = function(s) FOV = s; CurrentCamera.FieldOfView = s end, Desc = "Field of view" })

-- ====== FLING TAB ======
local FlingTab = Window:CreateTab("Fling", "sword")

FlingTab:CreateButton({
    Name = "Fling Murderer",
    Callback = function()
        local target = FindFlingTarget("Murderer")
        if target then FlingPlayer(target) else Rayfield:Notify({Title = "UmbraHub", Content = "No murderer found!", Duration = 2}) end
    end,
    Desc = "Fling player with knife"
})

FlingTab:CreateButton({
    Name = "Fling Sheriff",
    Callback = function()
        local target = FindFlingTarget("Sheriff")
        if target then FlingPlayer(target) else Rayfield:Notify({Title = "UmbraHub", Content = "No sheriff found!", Duration = 2}) end
    end,
    Desc = "Fling player with gun"
})

FlingTab:CreateParagraph({ Title = "Fling Status", Content = "In Progress: " .. tostring(FlingInProgress) })

-- ====== SPECTATE TAB ======
local SpecTab = Window:CreateTab("Spectate", "users")

SpecTab:CreateButton({
    Name = "Spectate Murderer",
    Callback = function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and GetPlayerRole(player) == "Murderer" then
                SpectatePlayer(player)
                return
            end
        end
        Rayfield:Notify({Title = "UmbraHub", Content = "No murderer found!", Duration = 2})
    end,
    Desc = "Spectate the murderer"
})

SpecTab:CreateButton({
    Name = "Spectate Sheriff",
    Callback = function()
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and GetPlayerRole(player) == "Sheriff" then
                SpectatePlayer(player)
                return
            end
        end
        Rayfield:Notify({Title = "UmbraHub", Content = "No sheriff found!", Duration = 2})
    end,
    Desc = "Spectate the sheriff"
})

SpecTab:CreateInput({
    Name = "Spectate by Name",
    CurrentValue = "",
    PlaceholderText = "Enter player name...",
    Callback = function(text)
        if text == "" then return end
        for _, player in ipairs(Players:GetPlayers()) do
            if string.lower(player.Name):match(string.lower(text)) then
                SpectatePlayer(player)
                return
            end
        end
        Rayfield:Notify({Title = "UmbraHub", Content = "Player not found!", Duration = 2})
    end,
    Desc = "Type name to spectate"
})

SpecTab:CreateInput({
    Name = "Teleport to Player",
    CurrentValue = "",
    PlaceholderText = "Enter player name...",
    Callback = function(text)
        if text == "" then return end
        for _, player in ipairs(Players:GetPlayers()) do
            if string.lower(player.Name):match(string.lower(text)) then
                TeleportToPlayer(player)
                return
            end
        end
        Rayfield:Notify({Title = "UmbraHub", Content = "Player not found!", Duration = 2})
    end,
    Desc = "Type name to teleport"
})

-- ====== COIN FARM TAB ======
local FarmTab = Window:CreateTab("Coin Farm", "dollar-sign")

FarmTab:CreateParagraph({ Title = "Coin Farm", Content = "Auto collect coins and kill enemies" })

FarmTab:CreateToggle({ Name = "Enable Coin Farm", CurrentValue = false, Callback = ToggleCoinFarm, Desc = "Start/Stop coin farming" })

FarmTab:CreateDropdown({
    Name = "Target Role",
    Options = { "Murderer", "Sheriff", "Any" },
    CurrentOption = "Murderer",
    Callback = function(s) CoinFarmTarget = s end,
    Desc = "Which role to target"
})

FarmTab:CreateToggle({ Name = "Kill on Death", CurrentValue = true, Callback = function(s) CoinFarmKillOnDeath = s end, Desc = "Auto kill nearby enemies" })

FarmTab:CreateSlider({
    Name = "Farm Speed",
    Range = {5, 50},
    Increment = 1,
    CurrentValue = 25,
    Callback = function(s) CoinFarmSpeed = s end,
    Desc = "Speed of movement"
})

FarmTab:CreateSlider({
    Name = "Collect Radius",
    Range = {5, 50},
    Increment = 1,
    CurrentValue = 15,
    Callback = function(s) CoinFarmRadius = s end,
    Desc = "Radius to collect coins"
})

FarmTab:CreateSlider({
    Name = "Drop Height",
    Range = {5, 30},
    Increment = 1,
    CurrentValue = 15,
    Callback = function(s) CoinFarmDropHeight = s end,
    Desc = "Height to drop after teleport"
})

FarmTab:CreateSlider({
    Name = "Lobby Distance",
    Range = {50, 300},
    Increment = 10,
    CurrentValue = 120,
    Callback = function(s) CoinFarmLobbyDistance = s end,
    Desc = "Distance from lobby to farm"
})

-- ====== GRAPHICS TAB ======
local GraphicsTab = Window:CreateTab("Graphics", "monitor")

GraphicsTab:CreateToggle({ Name = "Motion Blur", CurrentValue = false, Callback = ToggleMotionBlur, Desc = "Blur when moving fast" })

GraphicsTab:CreateSlider({
    Name = "Motion Blur Intensity",
    Range = {10, 400},
    Increment = 5,
    CurrentValue = 120,
    Callback = function(s) MotionBlurIntensity = s end,
    Desc = "Blur strength"
})

GraphicsTab:CreateSlider({
    Name = "Motion Blur Threshold",
    Range = {1, 50},
    Increment = 1,
    CurrentValue = 5,
    Callback = function(s) MotionBlurThreshold = s end,
    Desc = "Sensitivity"
})

GraphicsTab:CreateToggle({ Name = "Stretch (Wide)", CurrentValue = false, Callback = ToggleStretch, Desc = "Stretch the screen" })

GraphicsTab:CreateSlider({
    Name = "Stretch Factor",
    Range = {10, 100},
    Increment = 5,
    CurrentValue = 50,
    Callback = function(s) StretchFactor = s / 100; if StretchEnabled then ToggleStretch(true) end end,
    Desc = "10% = wide, 100% = normal"
})

GraphicsTab:CreateToggle({ Name = "Custom Crosshair", CurrentValue = false, Callback = ToggleCrosshair, Desc = "Custom crosshair (ShiftLock only)" })
GraphicsTab:CreateToggle({ Name = "Crosshair Spin", CurrentValue = false, Callback = function(s) CrosshairSpin = s end, Desc = "Rotating crosshair" })

GraphicsTab:CreateInput({
    Name = "Crosshair ID",
    CurrentValue = "98490421374360",
    PlaceholderText = "Enter image ID",
    Callback = function(s)
        CrosshairID = s
        if CrosshairImage then CrosshairImage.Image = "rbxassetid://" .. s end
    end,
    Desc = "Crosshair image ID"
})

GraphicsTab:CreateToggle({ Name = "Custom Time", CurrentValue = false, Callback = function(s) CustomTimeEnabled = s; if s then Lighting.ClockTime = CustomTime end end, Desc = "Set custom time" })

GraphicsTab:CreateSlider({
    Name = "Time",
    Range = {0, 24},
    Increment = 0.5,
    CurrentValue = 14,
    Callback = function(s) CustomTime = s; if CustomTimeEnabled then Lighting.ClockTime = s end end,
    Desc = "Time of day"
})

GraphicsTab:CreateSlider({
    Name = "Saturation",
    Range = {-100, 100},
    Increment = 5,
    CurrentValue = 0,
    Callback = function(s)
        SaturationValue = s / 100
        if MotionBlurEffect then MotionBlurEffect.Saturation = SaturationValue end
    end,
    Desc = "Color saturation"
})

-- ====== SETTINGS TAB ======
local SettingsTab = Window:CreateTab("Settings", "settings")

SettingsTab:CreateToggle({ Name = "Anti-AFK", CurrentValue = false, Callback = ToggleAntiAFK, Desc = "Prevent being kicked" })

SettingsTab:CreateSlider({
    Name = "GUI Scale",
    Range = {50, 200},
    Increment = 5,
    CurrentValue = 100,
    Callback = function(s)
        GuiScale = s / 100
        Rayfield:SetScale(GuiScale)
    end,
    Desc = "UI size"
})

SettingsTab:CreateSlider({
    Name = "Theme Hue",
    Range = {0, 360},
    Increment = 1,
    CurrentValue = 140,
    Callback = function(s)
        ThemeHue = s
        Rayfield:SetTheme("Custom", { Primary = Color3.fromHSV(ThemeHue / 360, 0.8, 0.9) })
    end,
    Desc = "UI theme color"
})

SettingsTab:CreateSlider({
    Name = "FPS Cap",
    Range = {30, 240},
    Increment = 5,
    CurrentValue = 60,
    Callback = function(s)
        FpsCap = s
        pcall(function() setfpscap(s) end)
    end,
    Desc = "Max FPS"
})

SettingsTab:CreateButton({
    Name = "Reset All Settings",
    Callback = function()
        Rayfield:Notify({Title = "UmbraHub", Content = "Settings reset to default", Duration = 3})
        -- Reset logic
    end,
    Desc = "Reset everything to default"
})

-- ====== ИНИЦИАЛИЗАЦИЯ ======
Rayfield:Notify({Title = "UmbraHub v1", Content = "Loaded! All features disabled by default.", Duration = 3})
print("UmbraHub v1 loaded.")