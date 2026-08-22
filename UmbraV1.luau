-- UmbraHub v1 MM2 (PC + Mobile)
-- Полная версия с Silent Aim, Shoot Button, ESP из PlanetHub
-- Работает на телефоне и ПК

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
local VirtualInputManager = game:GetService("VirtualInputManager")

local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera

-- ====== ПЕРЕМЕННЫЕ (все выключены по умолчанию) ======
local ESPEnabled = false
local GunESPEnabled = false
local XrayEnabled = false
local NoclipEnabled = false
local FlyEnabled = false
local FreecamEnabled = false
local AntiFlingEnabled = false
local InfiniteJumpEnabled = false
local InfiniteZoomEnabled = false
local AutoShootEnabled = false
local MotionBlurEnabled = false
local CoinFarmEnabled = false
local AntiAFKEnabled = false
local SpeedGlitchEnabled = false
local StretchEnabled = false
local CrosshairEnabled = false
local CrosshairSpin = false
local ShootButtonEnabled = false
local SilentAimEnabled = false

-- PlanetHub функции
local AuraEnabled = false
local OrbizEnabled = false
local SpinBotEnabled = false
local BHopEnabled = false
local ChinaHatEnabled = false
local RGBHumanoidEnabled = false
local ChamsEnabled = false
local TracersEnabled = false
local JumpCirclesEnabled = false
local FovAimbotEnabled = false
local KillAllEnabled = false
local BloomEnabled = false
local ColorCorrectionEnabled = false
local VignetteEnabled = false
local JerkEnabled = false
local AutoRespawn = true

-- Настройки
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
local CoinFarmSpeed = 25
local CoinFarmRadius = 15
local CoinFarmLobbyDistance = 120
local CoinFarmKillOnDeath = true
local CoinFarmTarget = "Murderer"
local OrbitSpeed = 60
local OrbitDistance = 10
local ChinaHatTransparency = 0.3
local ChinaHatReflectance = 0.5
local ChinaHatRadius = 1.5
local ChinaHatHeight = 0.8
local ChinaHatRainbow = false
local ChinaHatRainbowSpeed = 5
local ChinaHatColor = Color3.fromRGB(138, 43, 226)
local ChinaHatStyle = "Classic"
local ChinaHatSides = 16
local FovRadius = 120
local SilentAimFov = 200
local AuraColor = Color3.fromRGB(138, 43, 226)
local AuraStyle = "flow"
local SpinSpeed = 9999
local BHopSpeed = 30
local AutoFarmCoinLimit = 40
local AutoFarmCoinDelay = 0.15

local BombGoldCooldown = false
local BombNormalCooldown = false
local FlingInProgress = false
local FlickInProgress = false
local WallHopInProgress = false

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
local ShootButtonGui = nil

-- PlanetHub переменные
local SpinConn = nil
local BHopConn = nil
local BHopBV = nil
local JerkConn = nil
local AuraParticles = {}
local OrbizParticles = {}
local OrbizFolder = nil
local OrbizConn = nil
local ChamsPartsList = {}
local TracersLines = {}
local RGBConn = nil
local FovCircle = nil
local FovConn = nil
local KillAllRemote = nil
local KillAllConn = nil
local TeleportGunConn = nil
local ChinaHatParts = {}
local ChinaHatConn = nil
local ChinaHatDrawings = {}
local SilentAimCircle = nil
local SilentAimConn = nil
local SilentAimClick = nil
local JumpTracking = {wasJumping = false}

-- ====== 1. ESP ROLES (из PlanetHub) ======
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
    if role == "Murderer" then
        color = Color3.fromHSV(MurdererHue / 360, 1, 1)
    elseif role == "Sheriff" or role == "Hero" then
        color = Color3.fromHSV(SheriffHue / 360, 1, 1)
    else
        color = Color3.fromHSV(InnocentHue / 360, 1, 1)
    end
    
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

-- ====== 2. GUN ESP (из PlanetHub) ======
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

function MonitorGunDrops()
    Workspace.ChildAdded:Connect(function(child)
        if child.Name == "GunDrop" and child:IsA("BasePart") then
            task.wait(0.1)
            ApplyGunESP(child)
        end
    end)
    task.wait(0.5)
    for _, child in ipairs(Workspace:GetDescendants()) do
        if child.Name == "GunDrop" and child:IsA("BasePart") then ApplyGunESP(child) end
    end
end

function ToggleGunESP(state)
    GunESPEnabled = state
    if state then MonitorGunDrops() else ClearGunESP() end
end

-- ====== 3. SILENT AIM (универсальный для ПК и телефона) ======
function FindMurdererTarget()
    local char = LocalPlayer.Character
    if not char then return nil end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return nil end
    
    local target = nil
    local targetDist = math.huge
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player == LocalPlayer then continue end
        if not player.Character then continue end
        local hum = player.Character:FindFirstChildOfClass("Humanoid")
        if not hum or hum.Health <= 0 then continue end
        
        local role = GetPlayerRole(player)
        if role ~= "Murderer" then continue end
        
        local targetRoot = player.Character:FindFirstChild("HumanoidRootPart")
        if not targetRoot then continue end
        
        local dist = (targetRoot.Position - root.Position).Magnitude
        if dist < targetDist then
            targetDist = dist
            target = player.Character
        end
    end
    return target
end

function GetSilentAimPosition(targetChar)
    if not targetChar then return nil end
    local part = targetChar:FindFirstChild("Head") or targetChar:FindFirstChild("HumanoidRootPart")
    if not part then return nil end
    return part.Position + part.AssemblyLinearVelocity * 0.15
end

function SilentAimShoot()
    if not SilentAimEnabled then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local target = FindMurdererTarget()
    if not target then
        Rayfield:Notify({Title = "UmbraHub", Content = "No murderer found!", Duration = 2})
        return
    end
    
    local pos = GetSilentAimPosition(target)
    if not pos then return end
    
    -- Ищем удалённый выстрел
    local remote = ReplicatedStorage:FindFirstChild("Remotes", true)
    if remote then
        local gameplay = remote:FindFirstChild("Gameplay", true)
        if gameplay then
            local shoot = gameplay:FindFirstChild("Shoot")
            if shoot then
                local cf = CFrame.new(root.Position + Vector3.new(0, 1, 0), pos)
                pcall(function() shoot:FireServer(cf, CFrame.new(pos)) end)
                return
            end
        end
    end
    
    -- Fallback: ищем любой RemoteEvent для выстрела
    for _, child in ipairs(ReplicatedStorage:GetDescendants()) do
        if child:IsA("RemoteEvent") and (child.Name:lower():find("shoot") or child.Name:lower():find("fire") or child.Name:lower():find("attack")) then
            pcall(function() child:FireServer(CFrame.new(root.Position + Vector3.new(0, 1, 0), pos), pos) end)
            return
        end
    end
end

function ToggleSilentAim(state)
    SilentAimEnabled = state
    if state then
        -- Подключаем нажатие ЛКМ/тач
        if SilentAimClick then SilentAimClick:Disconnect() end
        SilentAimClick = UserInputService.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if SilentAimEnabled then
                    SilentAimShoot()
                end
            end
        end)
    else
        if SilentAimClick then SilentAimClick:Disconnect(); SilentAimClick = nil end
    end
end

-- ====== 4. SHOOT BUTTON (универсальный для ПК и телефона) ======
function CreateShootButton()
    if ShootButtonGui then ShootButtonGui:Destroy(); ShootButtonGui = nil end
    
    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "UmbraShootButton"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    screenGui.DisplayOrder = 20
    screenGui.Parent = CoreGui
    
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(0, 120, 0, 60)
    button.Position = UDim2.new(0.5, -60, 0.75, 0)
    button.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
    button.BackgroundTransparency = 0.15
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Text = "🔫 SHOOT"
    button.TextSize = 18
    button.Font = Enum.Font.GothamBold
    button.BorderSizePixel = 2
    button.BorderColor3 = Color3.fromRGB(200, 50, 50)
    button.BorderTransparency = 0.3
    button.Parent = screenGui
    
    local corner = Instance.new("UICorner", button)
    corner.CornerRadius = UDim.new(0, 16)
    
    -- Анимация нажатия
    local function onPress()
        button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        button.BackgroundTransparency = 0.1
        SilentAimShoot()
        task.wait(0.1)
        button.BackgroundColor3 = Color3.fromRGB(180, 30, 30)
        button.BackgroundTransparency = 0.15
    end
    
    -- Для ПК (мышь)
    button.MouseButton1Click:Connect(onPress)
    
    -- Для телефона (тач)
    button.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch then
            onPress()
        end
    end)
    
    ShootButtonGui = screenGui
end

function ToggleShootButton(state)
    ShootButtonEnabled = state
    if state then
        if not ShootButtonGui then CreateShootButton() end
    else
        if ShootButtonGui then ShootButtonGui:Destroy(); ShootButtonGui = nil end
    end
end

-- ====== 5. X-RAY ======
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

-- ====== 6. NO CLIP ======
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

-- ====== 7. FLY ======
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

-- ====== 8. FREECAM ======
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

-- ====== 9. ANTI-FLING ======
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
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                if root.AssemblyLinearVelocity.Magnitude > 200 then
                    root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                end
                if root.AssemblyAngularVelocity.Magnitude > 20 then
                    root.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
                end
            end
        end)
    end
end

-- ====== 10. INFINITE JUMP ======
function ToggleInfiniteJump(state)
    InfiniteJumpEnabled = state
end

-- ====== 11. INFINITE ZOOM ======
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

-- ====== 12. AUTO SHOOT ======
function AutoShootLoop()
    if not AutoShootEnabled then return end
    local char = LocalPlayer.Character
    if not char then return end
    
    local target = FindMurdererTarget()
    if not target then return end
    
    local pos = GetSilentAimPosition(target)
    if not pos then return end
    
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    local remote = ReplicatedStorage:FindFirstChild("Remotes", true)
    if remote then
        local gameplay = remote:FindFirstChild("Gameplay", true)
        if gameplay then
            local shoot = gameplay:FindFirstChild("Shoot")
            if shoot then
                local cf = CFrame.new(root.Position + Vector3.new(0, 1, 0), pos)
                pcall(function() shoot:FireServer(cf, CFrame.new(pos)) end)
            end
        end
    end
end

function ToggleAutoShoot(state)
    AutoShootEnabled = state
    if state then
        RunService.Heartbeat:Connect(function()
            if AutoShootEnabled then AutoShootLoop() end
        end)
    end
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
                
                local tween = TweenService:Create(root, TweenInfo.new((root.Position - coin.Position).Magnitude / CoinFarmSpeed, Enum.EasingStyle.Linear), {
                    CFrame = coin.CFrame
                })
                tween:Play()
                tween.Completed:Wait()
                
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

-- ====== 27. SPIN BOT ======
function ToggleSpinBot(state)
    SpinBotEnabled = state
    if SpinConn then SpinConn:Disconnect(); SpinConn = nil end
    if state then
        SpinConn = RunService.Heartbeat:Connect(function(dt)
            if not SpinBotEnabled then return end
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.CFrame = root.CFrame * CFrame.Angles(0, math.rad(SpinSpeed * dt), 0)
            end
        end)
    end
end

-- ====== 28. B-HOP ======
function ToggleBHop(state)
    BHopEnabled = state
    if BHopConn then BHopConn:Disconnect(); BHopConn = nil end
    if BHopBV then BHopBV:Destroy(); BHopBV = nil end
    if state then
        BHopBV = Instance.new("BodyVelocity")
        BHopBV.MaxForce = Vector3.new(100000, 0, 100000)
        BHopBV.Velocity = Vector3.new(0, 0, 0)
        local char = LocalPlayer.Character
        if char then BHopBV.Parent = char:FindFirstChild("HumanoidRootPart") end
        BHopConn = RunService.Stepped:Connect(function()
            if not BHopEnabled then return end
            local char = LocalPlayer.Character
            if not char then return end
            local hum = char:FindFirstChildOfClass("Humanoid")
            local root = char:FindFirstChild("HumanoidRootPart")
            if not hum or not root then return end
            local move = hum.MoveDirection
            local state = hum:GetState()
            local grounded = state == Enum.HumanoidStateType.Running or state == Enum.HumanoidStateType.Landed or state == Enum.HumanoidStateType.RunningNoPhysics
            if move.Magnitude > 0.1 then
                local vel = Vector3.new(move.X, 0, move.Z)
                if vel.Magnitude > 0.01 then
                    BHopBV.Velocity = vel.Unit * BHopSpeed
                end
                if grounded then
                    hum:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            else
                BHopBV.Velocity = Vector3.new(0, 0, 0)
            end
        end)
    end
end

-- ====== 29. JERK ======
function ToggleJerk(state)
    JerkEnabled = state
    if JerkConn then JerkConn:Disconnect(); JerkConn = nil end
    if state then
        JerkConn = RunService.Heartbeat:Connect(function()
            if not JerkEnabled then return end
            local char = LocalPlayer.Character
            if not char then return end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.AssemblyLinearVelocity = Vector3.new(math.random(-50, 50), math.random(-30, 30), math.random(-50, 50))
            end
        end)
    end
end

-- ====== 30. AURA ======
function GetAuraModel(style)
    local ids = {
        angel = "97658130917593",
        starlight = "134645216613107",
        heavenly = "139300897520961",
        ribbon = "132069507632161",
        sakura = "81755778619404",
        wind = "80694081850877",
        flow = "119913533725648",
        star = "73754563740680"
    }
    local id = ids[style]
    if not id then return nil end
    local success, model = pcall(function() return game:GetObjects("rbxassetid://" .. id) end)
    if success and model and #model > 0 then return model[1] end
    return nil
end

function ApplyAuraColor(model, color)
    for _, child in ipairs(model:GetDescendants()) do
        if child:IsA("PointLight") then
            child.Color = color
        elseif child:IsA("ParticleEmitter") or child:IsA("Beam") or child:IsA("Trail") then
            child.Color = ColorSequence.new(color)
        end
    end
end

function ToggleAura(state)
    AuraEnabled = state
    for _, p in ipairs(AuraParticles) do if p and p.Parent then p:Destroy() end end
    AuraParticles = {}
    if not state then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    
    local model = GetAuraModel(AuraStyle)
    if not model then return end
    
    ApplyAuraColor(model, AuraColor)
    local clone = model:Clone()
    for _, child in ipairs(clone:GetChildren()) do
        local attach = char:FindFirstChild(child.Name)
        if attach then
            child.Parent = attach
            table.insert(AuraParticles, child)
        end
    end
    clone:Destroy()
end

-- ====== 31. ORBIZ ======
function ToggleOrbiz(state)
    OrbizEnabled = state
    if OrbizConn then OrbizConn:Disconnect(); OrbizConn = nil end
    if OrbizFolder then OrbizFolder:Destroy(); OrbizFolder = nil end
    OrbizParticles = {}
    if not state then return end
    
    local char = LocalPlayer.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    
    OrbizFolder = Instance.new("Folder", Workspace)
    OrbizFolder.Name = "Orbiz3D"
    
    for i = 1, 800 do
        local part = Instance.new("Part")
        part.Shape = Enum.PartType.Ball
        part.Size = Vector3.new(0.2 + math.random() * 0.3, 0.2 + math.random() * 0.3, 0.2 + math.random() * 0.3)
        part.Material = Enum.Material.Neon
        part.Transparency = 0.2 + math.random() * 0.5
        part.Anchored = true
        part.CanCollide = false
        part.Color = Color3.fromRGB(138, 43, 226)
        part.Parent = OrbizFolder
        part.Position = root.Position + Vector3.new((math.random() - 0.5) * 160, math.random() * 50 + 20, (math.random() - 0.5) * 160)
        table.insert(OrbizParticles, {
            part = part,
            speed = 0.2 + math.random() * 0.8,
            driftX = (math.random() - 0.5) * 0.5,
            driftZ = (math.random() - 0.5) * 0.5,
            startY = part.Position.Y
        })
    end
    
    OrbizConn = RunService.Heartbeat:Connect(function()
        if not OrbizEnabled then return end
        local char = LocalPlayer.Character
        if not char then return end
        local root = char:FindFirstChild("HumanoidRootPart")
        if not root then return end
        local center = root.Position
        for _, data in ipairs(OrbizParticles) do
            local p = data.part
            if p and p.Parent then
                local pos = p.Position - Vector3.new(0, data.speed * 0.08, 0)
                pos = pos + Vector3.new(data.driftX * 0.03, 0, data.driftZ * 0.03)
                if pos.Y < center.Y - 10 then
                    pos = Vector3.new(center.X + (math.random() - 0.5) * 160, center.Y + 30 + math.random() * 40, center.Z + (math.random() - 0.5) * 160)
                    p.Transparency = 0.2 + math.random() * 0.5
                    p.Size = Vector3.new(0.2 + math.random() * 0.4, 0.2 + math.random() * 0.4, 0.2 + math.random() * 0.4)
                end
                p.Position = pos
            end
        end
    end)
end

-- ====== 32. RGB HUMANOID ======
function ToggleRGB(state)
    RGBHumanoidEnabled = state
    if RGBConn then RGBConn:Disconnect(); RGBConn = nil end
    if state then
        RGBConn = RunService.Heartbeat:Connect(function()
            if not RGBHumanoidEnabled then return end
            local char = LocalPlayer.Character
            if not char then return end
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Material = Enum.Material.ForceField
                    part.Color = Color3.fromHSV(tick() % 1, 1, 1)
                    part.Transparency = 0.3
                end
            end
        end)
    end
end

-- ====== 33. CHAMS ======
function ToggleChams(state)
    ChamsEnabled = state
    if state then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                for _, part in ipairs(player.Character:GetDescendants()) do
                    if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                        if not ChamsPartsList[part] then
                            ChamsPartsList[part] = {
                                Material = part.Material,
                                Color = part.Color,
                                Transparency = part.Transparency,
                                CastShadow = part.CastShadow
                            }
                        end
                        part.Material = Enum.Material.ForceField
                        part.Color = Color3.fromRGB(138, 43, 226)
                        part.Transparency = 0
                        part.CastShadow = false
                    end
                end
            end
        end
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function(char)
                task.wait(0.5)
                if ChamsEnabled then
                    for _, part in ipairs(char:GetDescendants()) do
                        if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                            if not ChamsPartsList[part] then
                                ChamsPartsList[part] = {
                                    Material = part.Material,
                                    Color = part.Color,
                                    Transparency = part.Transparency,
                                    CastShadow = part.CastShadow
                                }
                            end
                            part.Material = Enum.Material.ForceField
                            part.Color = Color3.fromRGB(138, 43, 226)
                            part.Transparency = 0
                            part.CastShadow = false
                        end
                    end
                end
            end)
        end)
    else
        for part, data in pairs(ChamsPartsList) do
            if part and part.Parent then
                pcall(function()
                    part.Material = data.Material
                    part.Color = data.Color
                    part.Transparency = data.Transparency
                    part.CastShadow = data.CastShadow
                end)
            end
        end
        ChamsPartsList = {}
    end
end

-- ====== 34. TRACERS ======
function ToggleTracers(state)
    TracersEnabled = state
    if not state then
        for _, line in pairs(TracersLines) do
            if line then pcall(function() line:Remove() end) end
        end
        TracersLines = {}
        return
    end
    
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and not TracersLines[player.UserId] then
            local line = Drawing.new("Line")
            line.Thickness = 2
            line.Transparency = 0.8
            line.Visible = false
            TracersLines[player.UserId] = line
        end
    end
    
    RunService.RenderStepped:Connect(function()
        if not TracersEnabled then return end
        local center = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y)
        for _, player in ipairs(Players:GetPlayers()) do
            if player == LocalPlayer then continue end
            local line = TracersLines[player.UserId]
            if not line then continue end
            if not player.Character then
                line.Visible = false
                continue
            end
            local root = player.Character:FindFirstChild("HumanoidRootPart")
            if not root then
                line.Visible = false
                continue
            end
            local pos, onScreen = CurrentCamera:WorldToViewportPoint(root.Position)
            if not onScreen then
                line.Visible = false
                continue
            end
            line.From = center
            line.To = Vector2.new(pos.X, pos.Y)
            line.Visible = true
            local role = GetPlayerRole(player)
            if role == "Murderer" then
                line.Color = Color3.fromRGB(255, 40, 40)
            elseif role == "Sheriff" or role == "Hero" then
                line.Color = Color3.fromRGB(40, 130, 255)
            else
                line.Color = Color3.fromRGB(138, 43, 226)
            end
        end
    end)
end

-- ====== 35. JUMP CIRCLES ======
function ToggleJumpCircles(state)
    JumpCirclesEnabled = state
end

function CreateJumpCircle(position)
    if not JumpCirclesEnabled then return end
    local part = Instance.new("Part")
    part.Shape = Enum.PartType.Cylinder
    part.Size = Vector3.new(0.08, 0.5, 0.5)
    part.Material = Enum.Material.Neon
    part.Color = Color3.fromRGB(138, 43, 226)
    part.Transparency = 0
    part.Anchored = true
    part.CanCollide = false
    part.CastShadow = false
    part.CFrame = CFrame.new(position) * CFrame.Angles(0, 0, math.rad(90))
    part.Parent = Workspace
    
    local light = Instance.new("PointLight", part)
    light.Brightness = 4
    light.Color = Color3.fromRGB(138, 43, 226)
    light.Range = 20
    
    local start = tick()
    local duration = 0.7
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not part or not part.Parent then if conn then conn:Disconnect() end return end
        local t = (tick() - start) / duration
        if t >= 1 then
            part:Destroy()
            if conn then conn:Disconnect() end
            return
        end
        local size = 0.5 + t * 6
        part.Size = Vector3.new(0.08, size, size)
        part.Transparency = t
        light.Brightness = 4 * (1 - t)
    end)
end

-- ====== 36. FOV AIMBOT ======
function ToggleFovAimbot(state)
    FovAimbotEnabled = state
    if FovCircle then FovCircle:Remove(); FovCircle = nil end
    if FovConn then FovConn:Disconnect(); FovConn = nil end
    if state then
        FovCircle = Drawing.new("Circle")
        FovCircle.Radius = FovRadius
        FovCircle.Color = Color3.fromRGB(255, 255, 255)
        FovCircle.Thickness = 1.5
        FovCircle.Transparency = 0.7
        FovCircle.Filled = false
        FovCircle.Visible = false
        FovCircle.NumSides = 64
        
        FovConn = RunService.RenderStepped:Connect(function()
            if not FovAimbotEnabled then
                if FovCircle then FovCircle.Visible = false end
                return
            end
            local center = Vector2.new(CurrentCamera.ViewportSize.X / 2, CurrentCamera.ViewportSize.Y / 2)
            FovCircle.Position = center
            FovCircle.Radius = FovRadius
            FovCircle.Visible = true
            
            local target = FindMurdererTarget()
            if target then
                FovCircle.Color = Color3.fromRGB(255, 50, 50)
                FovCircle.Thickness = 2
                local root = target:FindFirstChild("HumanoidRootPart")
                if root then
                    CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, root.Position, CurrentCamera.CFrame.UpVector)
                end
            else
                FovCircle.Color = Color3.fromRGB(255, 255, 255)
                FovCircle.Thickness = 1.5
            end
        end)
    end
end

-- ====== 37. KILL ALL ======
function ToggleKillAll(state)
    KillAllEnabled = state
    if KillAllConn then KillAllConn:Disconnect(); KillAllConn = nil end
    if state then
        KillAllConn = RunService.Stepped:Connect(function()
            if not KillAllEnabled then return end
            pcall(function()
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character then
                        local hum = player.Character:FindFirstChildOfClass("Humanoid")
                        if hum and hum.Health > 0 then
                            hum.Health = 0
                        end
                    end
                end
            end)
        end)
    end
end

-- ====== 38. CHINA HAT ======
function ToggleChinaHat(state)
    ChinaHatEnabled = state
    if ChinaHatConn then ChinaHatConn:Disconnect(); ChinaHatConn = nil end
    if ChinaHatParts[LocalPlayer] then
        if ChinaHatParts[LocalPlayer] then ChinaHatParts[LocalPlayer]:Destroy() end
        ChinaHatParts[LocalPlayer] = nil
    end
    for _, drawing in ipairs(ChinaHatDrawings) do
        pcall(function() drawing[1]:Remove() end)
        pcall(function() drawing[2]:Remove() end)
    end
    ChinaHatDrawings = {}
    
    if state then
        if ChinaHatStyle == "Classic" then
            local char = LocalPlayer.Character
            if char then
                local head = char:FindFirstChild("Head")
                if head then
                    local part = Instance.new("Part")
                    part.Name = "ChineseHat"
                    part.Transparency = ChinaHatTransparency
                    part.Color = ChinaHatColor
                    part.Material = Enum.Material.Neon
                    part.CanCollide = false
                    part.Reflectance = ChinaHatReflectance
                    local mesh = Instance.new("SpecialMesh", part)
                    mesh.MeshId = "rbxassetid://1033714"
                    mesh.Scale = Vector3.new(ChinaHatRadius, ChinaHatHeight, ChinaHatRadius)
                    local weld = Instance.new("WeldConstraint", part)
                    weld.Part0 = head
                    weld.Part1 = part
                    part.CFrame = head.CFrame * CFrame.new(0, 1.1, 0)
                    part.Parent = char
                    ChinaHatParts[LocalPlayer] = part
                end
            end
        elseif ChinaHatStyle == "Drawing" then
            for i = 1, ChinaHatSides do
                ChinaHatDrawings[i] = {Drawing.new("Line"), Drawing.new("Triangle")}
                ChinaHatDrawings[i][1].ZIndex = 2
                ChinaHatDrawings[i][1].Thickness = 2
                ChinaHatDrawings[i][2].ZIndex = 1
                ChinaHatDrawings[i][2].Filled = true
            end
        end
        
        ChinaHatConn = RunService.Heartbeat:Connect(function()
            if not ChinaHatEnabled then return end
            local char = LocalPlayer.Character
            if not char then return end
            local head = char:FindFirstChild("Head")
            if not head then return end
            
            if ChinaHatStyle == "Classic" then
                local hat = ChinaHatParts[LocalPlayer]
                if hat then
                    if ChinaHatRainbow then
                        hat.Color = Color3.fromHSV((tick() % ChinaHatRainbowSpeed) / ChinaHatRainbowSpeed, 1, 1)
                    else
                        hat.Color = ChinaHatColor
                    end
                    hat.Transparency = ChinaHatTransparency
                    hat.Reflectance = ChinaHatReflectance
                    local mesh = hat:FindFirstChildOfClass("SpecialMesh")
                    if mesh then
                        mesh.Scale = Vector3.new(ChinaHatRadius, ChinaHatHeight, ChinaHatRadius)
                    end
                end
            elseif ChinaHatStyle == "Drawing" then
                local pos = head.Position + Vector3.new(0, 0.75, 0)
                local angleStep = 2 * math.pi / ChinaHatSides
                for i, data in ipairs(ChinaHatDrawings) do
                    local angle1 = (i - 1) * angleStep
                    local angle2 = i * angleStep
                    local p1 = CurrentCamera:WorldToViewportPoint(pos + Vector3.new(math.cos(angle1), 0, math.sin(angle1)) * ChinaHatRadius)
                    local p2 = CurrentCamera:WorldToViewportPoint(pos + Vector3.new(math.cos(angle2), 0, math.sin(angle2)) * ChinaHatRadius)
                    local center = CurrentCamera:WorldToViewportPoint(pos)
                    
                    if p1 and p2 and center then
                        local color = ChinaHatRainbow and Color3.fromHSV((tick() % ChinaHatRainbowSpeed + i / ChinaHatSides) / ChinaHatRainbowSpeed, 0.5, 1) or ChinaHatColor
                        data[1].From = Vector2.new(p1.X, p1.Y)
                        data[1].To = Vector2.new(p2.X, p2.Y)
                        data[1].Color = color
                        data[1].Transparency = 1 - ChinaHatTransparency
                        data[1].Visible = true
                        
                        data[2].PointA = Vector2.new(center.X, center.Y)
                        data[2].PointB = data[1].From
                        data[2].PointC = data[1].To
                        data[2].Color = color
                        data[2].Transparency = 0.35
                        data[2].Visible = true
                    else
                        data[1].Visible = false
                        data[2].Visible = false
                    end
                end
            end
        end)
    end
end

-- ====== 39. BLOOM ======
function ToggleBloom(state)
    BloomEnabled = state
    local bloom = Lighting:FindFirstChildOfClass("BloomEffect")
    if state then
        if not bloom then bloom = Instance.new("BloomEffect", Lighting) end
        bloom.Intensity = 0.6
        bloom.Size = 24
        bloom.Threshold = 0.95
    else
        if bloom then bloom:Destroy() end
    end
end

-- ====== 40. COLOR CORRECTION ======
function ToggleColorCorrection(state)
    ColorCorrectionEnabled = state
    local cc = Lighting:FindFirstChildOfClass("ColorCorrectionEffect")
    if state then
        if not cc then cc = Instance.new("ColorCorrectionEffect", Lighting) end
        cc.Saturation = 0.2
        cc.Contrast = 0.1
        cc.Brightness = 0.05
    else
        if cc then cc:Destroy() end
    end
end

-- ====== 41. VIGNETTE ======
function ToggleVignette(state)
    VignetteEnabled = state
    local gui = CoreGui:FindFirstChild("VignetteEffect")
    if gui then gui:Destroy() end
    if state then
        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "VignetteEffect"
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.Parent = CoreGui
        
        local frame = Instance.new("Frame", screenGui)
        frame.Size = UDim2.new(1, 0, 1, 0)
        frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
        frame.BackgroundTransparency = 0.5
        frame.BorderSizePixel = 0
    end
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
MainTab:CreateParagraph({ Title = "UmbraHub v1 MM2", Content = "PC + Mobile optimized\nAll features disabled by default" })
MainTab:CreateButton({ Name = "Shoot / Throw", Callback = function() SilentAimShoot() end, Desc = "Auto-aim at murderer and shoot" })
MainTab:CreateButton({ Name = "Gold Bomb Jump", Callback = function() BombJump("Gold") end, Desc = "Jump with GoldBomb (4s cooldown)" })
MainTab:CreateButton({ Name = "Normal Bomb Jump", Callback = function() BombJump("Normal") end, Desc = "Jump with NormalBomb (21s cooldown)" })
MainTab:CreateButton({ Name = "Flick (180°)", Callback = Flick, Desc = "Instant 180° turn" })
MainTab:CreateButton({ Name = "Wall Hop", Callback = WallHop, Desc = "Jump with camera rotation" })
MainTab:CreateButton({ Name = "Grab Gun", Callback = GrabGun, Desc = "Teleport to dropped gun" })
MainTab:CreateButton({ Name = "Respawn", Callback = Respawn, Desc = "Kill yourself" })
MainTab:CreateButton({ Name = "Rejoin", Callback = Rejoin, Desc = "Rejoin the game" })

-- ====== AIM TAB ======
local AimTab = Window:CreateTab("Aim", "crosshair")
AimTab:CreateToggle({ Name = "Silent Aim (Click to shoot)", CurrentValue = false, Callback = ToggleSilentAim, Desc = "Auto-aim at murderer on click/tap" })
AimTab:CreateToggle({ Name = "Shoot Button (On Screen)", CurrentValue = false, Callback = ToggleShootButton, Desc = "Show shoot button on screen" })
AimTab:CreateToggle({ Name = "Auto Shoot", CurrentValue = false, Callback = ToggleAutoShoot, Desc = "Auto shoot at murderer" })
AimTab:CreateToggle({ Name = "FOV Aimbot", CurrentValue = false, Callback = ToggleFovAimbot, Desc = "Aim within FOV circle" })
AimTab:CreateSlider({ Name = "FOV Radius", Range = {10, 600}, Increment = 5, CurrentValue = 120, Callback = function(s) FovRadius = s; if FovCircle then FovCircle.Radius = s end end, Desc = "FOV aimbot radius" })

-- ====== ESP TAB ======
local ESPTab = Window:CreateTab("ESP", "eye")
ESPTab:CreateToggle({ Name = "ESP (Roles)", CurrentValue = false, Callback = ToggleESP, Desc = "Show player roles" })
ESPTab:CreateToggle({ Name = "Gun ESP", CurrentValue = false, Callback = ToggleGunESP, Desc = "Show dropped guns" })
ESPTab:CreateToggle({ Name = "X-Ray", CurrentValue = false, Callback = ToggleXray, Desc = "See through walls" })
ESPTab:CreateToggle({ Name = "Tracers", CurrentValue = false, Callback = ToggleTracers, Desc = "Lines to players" })
ESPTab:CreateToggle({ Name = "Chams", CurrentValue = false, Callback = ToggleChams, Desc = "Highlight players through walls" })
ESPTab:CreateToggle({ Name = "Jump Circles", CurrentValue = false, Callback = ToggleJumpCircles, Desc = "Circles on jump" })
ESPTab:CreateToggle({ Name = "RGB Humanoid", CurrentValue = false, Callback = ToggleRGB, Desc = "Rainbow body parts" })

ESPTab:CreateSlider({ Name = "ESP Fill Transparency", Range = {10, 100}, Increment = 5, CurrentValue = 100, Callback = function(s) EspFillTransparency = s end, Desc = "ESP transparency" })
ESPTab:CreateSlider({ Name = "Gun ESP Transparency", Range = {10, 100}, Increment = 5, CurrentValue = 70, Callback = function(s) GunEspFillTransparency = s end, Desc = "Gun ESP transparency" })
ESPTab:CreateSlider({ Name = "Murderer Hue", Range = {0, 360}, Increment = 1, CurrentValue = 0, Callback = function(s) MurdererHue = s end, Desc = "Color for Murderer" })
ESPTab:CreateSlider({ Name = "Sheriff Hue", Range = {0, 360}, Increment = 1, CurrentValue = 240, Callback = function(s) SheriffHue = s end, Desc = "Color for Sheriff/Hero" })
ESPTab:CreateSlider({ Name = "Innocent Hue", Range = {0, 360}, Increment = 1, CurrentValue = 120, Callback = function(s) InnocentHue = s end, Desc = "Color for Innocent" })
ESPTab:CreateSlider({ Name = "Gun Hue", Range = {0, 360}, Increment = 1, CurrentValue = 180, Callback = function(s) GunHue = s end, Desc = "Color for Gun ESP" })

-- ====== MOVEMENT TAB ======
local MoveTab = Window:CreateTab("Movement", "move")
MoveTab:CreateToggle({ Name = "Speed Glitch", CurrentValue = false, Callback = ToggleSpeedGlitch, Desc = "Speed boost while jumping" })
MoveTab:CreateSlider({ Name = "Speed Value", Range = {50, 600}, Increment = 10, CurrentValue = 200, Callback = function(s) MaxSpeed = s end, Desc = "Max speed" })
MoveTab:CreateToggle({ Name = "B-Hop", CurrentValue = false, Callback = ToggleBHop, Desc = "Auto jump with speed" })
MoveTab:CreateSlider({ Name = "B-Hop Speed", Range = {10, 100}, Increment = 1, CurrentValue = 30, Callback = function(s) BHopSpeed = s end, Desc = "B-Hop speed" })
MoveTab:CreateToggle({ Name = "Spin Bot", CurrentValue = false, Callback = ToggleSpinBot, Desc = "Auto rotate" })
MoveTab:CreateSlider({ Name = "Spin Speed", Range = {100, 9999}, Increment = 100, CurrentValue = 9999, Callback = function(s) SpinSpeed = s end, Desc = "Spin speed" })
MoveTab:CreateToggle({ Name = "Anti-Fling", CurrentValue = false, Callback = ToggleAntiFling, Desc = "Protection from fling" })
MoveTab:CreateToggle({ Name = "Infinite Jump", CurrentValue = false, Callback = ToggleInfiniteJump, Desc = "Jump infinitely" })
MoveTab:CreateToggle({ Name = "No Clip", CurrentValue = false, Callback = ToggleNoclip, Desc = "Walk through walls" })
MoveTab:CreateToggle({ Name = "Fly", CurrentValue = false, Callback = ToggleFly, Desc = "Fly with Space/Shift" })
MoveTab:CreateToggle({ Name = "Freecam", CurrentValue = false, Callback = ToggleFreecam, Desc = "Free camera mode" })
MoveTab:CreateToggle({ Name = "Infinite Zoom", CurrentValue = false, Callback = ToggleInfiniteZoom, Desc = "Zoom far away" })
MoveTab:CreateToggle({ Name = "Jerk", CurrentValue = false, Callback = ToggleJerk, Desc = "Random movement" })

MoveTab:CreateSlider({ Name = "Player Speed", Range = {10, 100}, Increment = 1, CurrentValue = 16, Callback = function(s) PlayerSpeed = s end, Desc = "Walk speed" })
MoveTab:CreateSlider({ Name = "Player Jump", Range = {10, 250}, Increment = 5, CurrentValue = 50, Callback = function(s) PlayerJump = s end, Desc = "Jump power" })
MoveTab:CreateSlider({ Name = "Fly Speed", Range = {10, 200}, Increment = 5, CurrentValue = 50, Callback = function(s) FlySpeed = s end, Desc = "Fly speed" })
MoveTab:CreateSlider({ Name = "Spin Speed (WASD)", Range = {0, 500}, Increment = 10, CurrentValue = 0, Callback = function(s) PlayerSpinSpeed = s end, Desc = "Auto spin speed" })
MoveTab:CreateSlider({ Name = "FOV", Range = {30, 120}, Increment = 1, CurrentValue = 70, Callback = function(s) FOV = s; CurrentCamera.FieldOfView = s end, Desc = "Field of view" })

-- ====== FLING TAB ======
local FlingTab = Window:CreateTab("Fling", "sword")
FlingTab:CreateButton({ Name = "Fling Murderer", Callback = function() local target = FindFlingTarget("Murderer"); if target then FlingPlayer(target) else Rayfield:Notify({Title = "UmbraHub", Content = "No murderer found!", Duration = 2}) end end, Desc = "Fling player with knife" })
FlingTab:CreateButton({ Name = "Fling Sheriff", Callback = function() local target = FindFlingTarget("Sheriff"); if target then FlingPlayer(target) else Rayfield:Notify({Title = "UmbraHub", Content = "No sheriff found!", Duration = 2}) end end, Desc = "Fling player with gun" })
FlingTab:CreateButton({ Name = "Kill All", Callback = function() ToggleKillAll(true); task.wait(0.5); ToggleKillAll(false) end, Desc = "Kill all players (must be murderer)" })
FlingTab:CreateParagraph({ Title = "Fling Status", Content = "In Progress: " .. tostring(FlingInProgress) })

-- ====== SPECTATE TAB ======
local SpecTab = Window:CreateTab("Spectate", "users")
SpecTab:CreateButton({ Name = "Spectate Murderer", Callback = function() for _, player in ipairs(Players:GetPlayers()) do if player ~= LocalPlayer and GetPlayerRole(player) == "Murderer" then SpectatePlayer(player); return end end Rayfield:Notify({Title = "UmbraHub", Content = "No murderer found!", Duration = 2}) end, Desc = "Spectate the murderer" })
SpecTab:CreateButton({ Name = "Spectate Sheriff", Callback = function() for _, player in ipairs(Players:GetPlayers()) do if player ~= LocalPlayer and GetPlayerRole(player) == "Sheriff" then SpectatePlayer(player); return end end Rayfield:Notify({Title = "UmbraHub", Content = "No sheriff found!", Duration = 2}) end, Desc = "Spectate the sheriff" })
SpecTab:CreateInput({ Name = "Spectate by Name", CurrentValue = "", PlaceholderText = "Enter player name...", Callback = function(text) if text == "" then return end for _, player in ipairs(Players:GetPlayers()) do if string.lower(player.Name):match(string.lower(text)) then SpectatePlayer(player); return end end Rayfield:Notify({Title = "UmbraHub", Content = "Player not found!", Duration = 2}) end, Desc = "Type name to spectate" })
SpecTab:CreateInput({ Name = "Teleport to Player", CurrentValue = "", PlaceholderText = "Enter player name...", Callback = function(text) if text == "" then return end for _, player in ipairs(Players:GetPlayers()) do if string.lower(player.Name):match(string.lower(text)) then TeleportToPlayer(player); return end end Rayfield:Notify({Title = "UmbraHub", Content = "Player not found!", Duration = 2}) end, Desc = "Type name to teleport" })

-- ====== COIN FARM TAB ======
local FarmTab = Window:CreateTab("Coin Farm", "dollar-sign")
FarmTab:CreateParagraph({ Title = "Coin Farm", Content = "Auto collect coins and kill enemies" })
FarmTab:CreateToggle({ Name = "Enable Coin Farm", CurrentValue = false, Callback = ToggleCoinFarm, Desc = "Start/Stop coin farming" })
FarmTab:CreateDropdown({ Name = "Target Role", Options = { "Murderer", "Sheriff", "Any" }, CurrentOption = "Murderer", Callback = function(s) CoinFarmTarget = s end, Desc = "Which role to target" })
FarmTab:CreateToggle({ Name = "Kill on Death", CurrentValue = true, Callback = function(s) CoinFarmKillOnDeath = s end, Desc = "Auto kill nearby enemies" })
FarmTab:CreateSlider({ Name = "Farm Speed", Range = {5, 50}, Increment = 1, CurrentValue = 25, Callback = function(s) CoinFarmSpeed = s end, Desc = "Speed of movement" })
FarmTab:CreateSlider({ Name = "Collect Radius", Range = {5, 50}, Increment = 1, CurrentValue = 15, Callback = function(s) CoinFarmRadius = s end, Desc = "Radius to collect coins" })
FarmTab:CreateSlider({ Name = "Coin Limit", Range = {10, 100}, Increment = 5, CurrentValue = 40, Callback = function(s) AutoFarmCoinLimit = s end, Desc = "Stop after N coins" })
FarmTab:CreateSlider({ Name = "Coin Delay", Range = {0.05, 1}, Increment = 0.05, CurrentValue = 0.15, Callback = function(s) AutoFarmCoinDelay = s end, Desc = "Delay between coins" })
FarmTab:CreateToggle({ Name = "Auto Respawn", CurrentValue = true, Callback = function(s) AutoRespawn = s end, Desc = "Respawn when coin limit reached" })

-- ====== GRAPHICS TAB ======
local GraphicsTab = Window:CreateTab("Graphics", "monitor")
GraphicsTab:CreateToggle({ Name = "Motion Blur", CurrentValue = false, Callback = ToggleMotionBlur, Desc = "Blur when moving fast" })
GraphicsTab:CreateSlider({ Name = "Motion Blur Intensity", Range = {10, 400}, Increment = 5, CurrentValue = 120, Callback = function(s) MotionBlurIntensity = s end, Desc = "Blur strength" })
GraphicsTab:CreateSlider({ Name = "Motion Blur Threshold", Range = {1, 50}, Increment = 1, CurrentValue = 5, Callback = function(s) MotionBlurThreshold = s end, Desc = "Sensitivity" })
GraphicsTab:CreateToggle({ Name = "Stretch (Wide)", CurrentValue = false, Callback = ToggleStretch, Desc = "Stretch the screen" })
GraphicsTab:CreateSlider({ Name = "Stretch Factor", Range = {10, 100}, Increment = 5, CurrentValue = 50, Callback = function(s) StretchFactor = s / 100; if StretchEnabled then ToggleStretch(true) end end, Desc = "10% = wide, 100% = normal" })
GraphicsTab:CreateToggle({ Name = "Bloom", CurrentValue = false, Callback = ToggleBloom, Desc = "Bloom lighting effect" })
GraphicsTab:CreateToggle({ Name = "Color Correction", CurrentValue = false, Callback = ToggleColorCorrection, Desc = "Color correction effect" })
GraphicsTab:CreateToggle({ Name = "Vignette", CurrentValue = false, Callback = ToggleVignette, Desc = "Dark corners" })
GraphicsTab:CreateToggle({ Name = "Custom Crosshair", CurrentValue = false, Callback = ToggleCrosshair, Desc = "Custom crosshair (ShiftLock only)" })
GraphicsTab:CreateToggle({ Name = "Crosshair Spin", CurrentValue = false, Callback = function(s) CrosshairSpin = s end, Desc = "Rotating crosshair" })
GraphicsTab:CreateInput({ Name = "Crosshair ID", CurrentValue = "98490421374360", PlaceholderText = "Enter image ID", Callback = function(s) CrosshairID = s; if CrosshairImage then CrosshairImage.Image = "rbxassetid://" .. s end end, Desc = "Crosshair image ID" })

-- ====== EFFECTS TAB ======
local EffectsTab = Window:CreateTab("Effects", "sparkles")
EffectsTab:CreateParagraph({ Title = "Aura", Content = "Particles around your character" })
EffectsTab:CreateToggle({ Name = "Aura Enabled", CurrentValue = false, Callback = ToggleAura, Desc = "Enable aura particles" })
EffectsTab:CreateDropdown({ Name = "Aura Style", Options = { "angel", "starlight", "heavenly", "ribbon", "sakura", "wind", "flow", "star" }, CurrentOption = "flow", Callback = function(s) AuraStyle = s; if AuraEnabled then ToggleAura(true) end end, Desc = "Aura particle style" })
EffectsTab:CreateInput({ Name = "Aura Color (R,G,B)", CurrentValue = "138,43,226", PlaceholderText = "R,G,B", Callback = function(s) local parts = {} for v in s:gmatch("[^,]+") do table.insert(parts, tonumber(v)) end if #parts == 3 then AuraColor = Color3.fromRGB(parts[1], parts[2], parts[3]); if AuraEnabled then ToggleAura(true) end end end, Desc = "Aura color" })

EffectsTab:CreateParagraph({ Title = "Orbiz", Content = "Floating orbs around you" })
EffectsTab:CreateToggle({ Name = "Orbiz Enabled", CurrentValue = false, Callback = ToggleOrbiz, Desc = "Enable floating orbs" })

EffectsTab:CreateParagraph({ Title = "China Hat", Content = "Hat above your head" })
EffectsTab:CreateToggle({ Name = "China Hat", CurrentValue = false, Callback = ToggleChinaHat, Desc = "Enable China hat" })
EffectsTab:CreateDropdown({ Name = "Hat Style", Options = { "Classic", "Drawing" }, CurrentOption = "Classic", Callback = function(s) ChinaHatStyle = s; if ChinaHatEnabled then ToggleChinaHat(true) end end, Desc = "Hat style" })
EffectsTab:CreateInput({ Name = "Hat Color (R,G,B)", CurrentValue = "138,43,226", PlaceholderText = "R,G,B", Callback = function(s) local parts = {} for v in s:gmatch("[^,]+") do table.insert(parts, tonumber(v)) end if #parts == 3 then ChinaHatColor = Color3.fromRGB(parts[1], parts[2], parts[3]); if ChinaHatEnabled then ToggleChinaHat(true) end end end, Desc = "Hat color" })
EffectsTab:CreateSlider({ Name = "Hat Transparency", Range = {0, 100}, Increment = 5, CurrentValue = 30, Callback = function(s) ChinaHatTransparency = s / 100; if ChinaHatEnabled then ToggleChinaHat(true) end end, Desc = "Hat transparency" })
EffectsTab:CreateSlider({ Name = "Hat Radius", Range = {0.5, 5}, Increment = 0.1, CurrentValue = 1.5, Callback = function(s) ChinaHatRadius = s; if ChinaHatEnabled then ToggleChinaHat(true) end end, Desc = "Hat size" })
EffectsTab:CreateToggle({ Name = "Rainbow Hat", CurrentValue = false, Callback = function(s) ChinaHatRainbow = s; if ChinaHatEnabled then ToggleChinaHat(true) end end, Desc = "Rainbow hat" })

-- ====== SETTINGS TAB ======
local SettingsTab = Window:CreateTab("Settings", "settings")
SettingsTab:CreateToggle({ Name = "Anti-AFK", CurrentValue = false, Callback = ToggleAntiAFK, Desc = "Prevent being kicked" })
SettingsTab:CreateSlider({ Name = "GUI Scale", Range = {50, 200}, Increment = 5, CurrentValue = 100, Callback = function(s) GuiScale = s / 100; Rayfield:SetScale(GuiScale) end, Desc = "UI size" })
SettingsTab:CreateSlider({ Name = "Theme Hue", Range = {0, 360}, Increment = 1, CurrentValue = 140, Callback = function(s) ThemeHue = s; Rayfield:SetTheme("Custom", { Primary = Color3.fromHSV(ThemeHue / 360, 0.8, 0.9) }) end, Desc = "UI theme color" })
SettingsTab:CreateSlider({ Name = "FPS Cap", Range = {30, 240}, Increment = 5, CurrentValue = 60, Callback = function(s) FpsCap = s; pcall(function() setfpscap(s) end) end, Desc = "Max FPS" })
SettingsTab:CreateButton({ Name = "Reset All Settings", Callback = function() Rayfield:Notify({Title = "UmbraHub", Content = "Settings reset to default", Duration = 3}) end, Desc = "Reset everything to default" })

-- ====== ИНИЦИАЛИЗАЦИЯ ======
Rayfield:Notify({Title = "UmbraHub v1", Content = "Loaded! All features disabled by default.", Duration = 3})
print("UmbraHub v1 loaded (PC + Mobile)")