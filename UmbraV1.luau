-- UmbraHub For mm2 (телеграм канал и дискорд сервер выйдут при релизе ...

local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- === НАСТРОЙКИ ПО УМОЛЧАНИЮ ===
local Settings = {
    ChamsESP = true,
    RoleESP = true,
    GunESP = true,
    XrayEnabled = false,
    InfiniteJumpEnabled = true,
    WalkSpeed = 16,
    FlyEnabled = false,
    FlySpeed = 50,
    CoinFarmEnabled = false,
    AutoGrabGun = true,
    FlingSheriffEnabled = false,
    EspFillTransparency = 100,
    GunEspFillTransparency = 70,
    InnocentHue = 120,
    MurdererHue = 0,
    SheriffHue = 240,
    GunHue = 180
}

-- === ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ ===
local function GetColorFromHue(hue) return Color3.fromHSV(hue/360, 1, 1) end

local function GetPlayerRole(player)
    -- Заглушка: реальная логика требует ремаут
    if player.Name == "MurdererExample" then return "Murderer" end
    if player.Name == "SheriffExample" then return "Sheriff" end
    return "Innocent"
end

local function GetCharacter(player) return player and player.Character end

local function GetMurderer()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and GetPlayerRole(player) == "Murderer" then
            return player, GetCharacter(player)
        end
    end
    return nil, nil
end

local function GetSheriff()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and (GetPlayerRole(player) == "Sheriff" or GetPlayerRole(player) == "Hero") then
            return player, GetCharacter(player)
        end
    end
    return nil, nil
end

-- === 1. ESP (CHAMS + ROLE + GUN + XRAY) ===
local GunESPObjects = {}

local function SetChams(character, color)
    if not character then return end
    local hrp = character:FindFirstChild("HumanoidRootPart")
    if hrp then hrp.LocalTransparencyModifier = Settings.XrayEnabled and 1 or 0 end
    local highlight = character:FindFirstChild("ChamsESP")
    if highlight then
        highlight.FillColor = color
        highlight.OutlineColor = color
        highlight.FillTransparency = Settings.EspFillTransparency / 100
        return
    end
    local newHighlight = Instance.new("Highlight")
    newHighlight.Name = "ChamsESP"
    newHighlight.FillTransparency = Settings.EspFillTransparency / 100
    newHighlight.OutlineTransparency = 0.25
    newHighlight.FillColor = color
    newHighlight.OutlineColor = color
    newHighlight.Parent = character
end

local function GetPlayerColor(character)
    local player = Players:GetPlayerFromCharacter(character)
    if not player then return GetColorFromHue(Settings.InnocentHue) end
    local role = GetPlayerRole(player)
    if Settings.RoleESP then
        if role == "Murderer" then return GetColorFromHue(Settings.MurdererHue) end
        if role == "Sheriff" or role == "Hero" then return GetColorFromHue(Settings.SheriffHue) end
    end
    return GetColorFromHue(Settings.InnocentHue)
end

local function UpdateAllESP()
    if not Settings.ChamsESP then return end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            SetChams(player.Character, GetPlayerColor(player.Character))
        end
    end
end

local function ClearAllESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            local highlight = player.Character:FindFirstChild("ChamsESP")
            if highlight then highlight:Destroy() end
            local hrp = player.Character:FindFirstChild("HumanoidRootPart")
            if hrp then hrp.LocalTransparencyModifier = 0 end
        end
    end
end

local function AddGunESP(part)
    if not Settings.GunESP or not part or not part:IsA("BasePart") or part.Name ~= "GunDrop" then return end
    if part:FindFirstChild("GunESP") then return end
    local highlight = Instance.new("Highlight")
    highlight.Name = "GunESP"
    highlight.FillColor = GetColorFromHue(Settings.GunHue)
    highlight.OutlineColor = GetColorFromHue(Settings.GunHue)
    highlight.FillTransparency = Settings.GunEspFillTransparency / 100
    highlight.OutlineTransparency = 0.2
    highlight.Parent = part
    table.insert(GunESPObjects, highlight)
end

local function ClearGunESP()
    for _, obj in ipairs(GunESPObjects) do
        pcall(function() obj:Destroy() end)
    end
    GunESPObjects = {}
end

-- XRAY
local XrayConnections = {}
local function EnableXray()
    ClearXray()
    local function handlePart(part)
        if not part:IsA("BasePart") then return end
        if part:FindFirstChildWhichIsA("Humanoid") or part:FindFirstChildWhichIsA("Accessory") then return end
        if XrayConnections[part] == nil then
            XrayConnections[part] = part.LocalTransparencyModifier
        end
        part.LocalTransparencyModifier = 0.65
    end
    for _, part in ipairs(Workspace:GetDescendants()) do
        handlePart(part)
    end
    local conn = Workspace.DescendantAdded:Connect(handlePart)
    table.insert(XrayConnections, conn)
end

local function ClearXray()
    for part, trans in pairs(XrayConnections) do
        if type(part) == "Instance" and part:IsA("BasePart") then
            pcall(function() part.LocalTransparencyModifier = trans end)
        end
    end
    for _, conn in ipairs(XrayConnections) do
        if type(conn) == "RBXScriptConnection" then pcall(function() conn:Disconnect() end) end
    end
    XrayConnections = {}
end

-- === 2. INFINITE JUMP ===
local JumpConn
local function ToggleInfiniteJump()
    Settings.InfiniteJumpEnabled = not Settings.InfiniteJumpEnabled
    if Settings.InfiniteJumpEnabled then
        JumpConn = UserInputService.InputBegan:Connect(function(input, processed)
            if processed then return end
            if input.KeyCode == Enum.KeyCode.Space then
                local plrChar = LocalPlayer.Character
                if plrChar then
                    local humanoid = plrChar:FindFirstChildOfClass("Humanoid")
                    if humanoid then humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end
                end
            end
        end)
    else
        if JumpConn then JumpConn:Disconnect() end
    end
end

-- === 3. WALK SPEED ===
local function ApplyWalkSpeed()
    local plrChar = LocalPlayer.Character
    if plrChar then
        local humanoid = plrChar:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = Settings.WalkSpeed
        end
    end
end

-- === 4. FLY ===
local FlyBodyGyro, FlyBodyVelocity, FlyConn
local function ToggleFly()
    Settings.FlyEnabled = not Settings.FlyEnabled
    if Settings.FlyEnabled then
        local plrChar = LocalPlayer.Character
        if not plrChar then return end
        local hrp = plrChar:FindFirstChild("HumanoidRootPart")
        local humanoid = plrChar:FindFirstChildOfClass("Humanoid")
        if not hrp or not humanoid then return end
        humanoid.PlatformStand = true
        FlyBodyGyro = Instance.new("BodyGyro")
        FlyBodyGyro.P = 90000
        FlyBodyGyro.maxTorque = Vector3.new(9e9, 9e9, 9e9)
        FlyBodyGyro.CFrame = hrp.CFrame
        FlyBodyGyro.Parent = hrp
        FlyBodyVelocity = Instance.new("BodyVelocity")
        FlyBodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
        FlyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        FlyBodyVelocity.Parent = hrp
        FlyConn = RunService.RenderStepped:Connect(function()
            if not Settings.FlyEnabled or not LocalPlayer.Character then
                ToggleFly()
                return
            end
            local newHrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not newHrp then return end
            FlyBodyGyro.CFrame = Camera.CFrame
            local moveDir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then moveDir = moveDir - Vector3.new(0, 1, 0) end
            if moveDir.Magnitude > 0 then
                FlyBodyVelocity.Velocity = moveDir.Unit * Settings.FlySpeed
            else
                FlyBodyVelocity.Velocity = Vector3.new(0, 0.1, 0)
            end
        end)
    else
        if FlyBodyGyro then FlyBodyGyro:Destroy() end
        if FlyBodyVelocity then FlyBodyVelocity:Destroy() end
        if FlyConn then FlyConn:Disconnect() end
        local plrChar = LocalPlayer.Character
        if plrChar then
            local humanoid = plrChar:FindFirstChildOfClass("Humanoid")
            if humanoid then humanoid.PlatformStand = false end
        end
    end
end

-- === 5. FLING SHERIFF ===
local function FlingSheriff()
    if not Settings.FlingSheriffEnabled then return end
    local sheriff, sheriffChar = GetSheriff()
    if not sheriffChar then return end
    local plrChar = LocalPlayer.Character
    if not plrChar then return end
    local hrp = plrChar:FindFirstChild("HumanoidRootPart")
    local targetHrp = sheriffChar:FindFirstChild("HumanoidRootPart")
    if not hrp or not targetHrp then return end
    -- Флинг через телепорт вверх
    hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 0, 3)
    task.wait(0.05)
    hrp.CFrame = targetHrp.CFrame * CFrame.new(0, 50, 0)
end

-- === 6. GRAB GUN ===
local function AutoGrabGun(part)
    if not Settings.AutoGrabGun or not part or part.Name ~= "GunDrop" then return end
    local plrChar = LocalPlayer.Character
    if not plrChar then return end
    local hrp = plrChar:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local oldCF = hrp.CFrame
    hrp.CFrame = part.CFrame + Vector3.new(0, 1.5, 0)
    task.delay(0.25, function()
        if hrp then hrp.CFrame = oldCF end
    end)
end

-- === 7. COIN FARM ===
local CoinFarmRunning = false
local function CoinFarmLoop()
    CoinFarmRunning = true
    while CoinFarmRunning and Settings.CoinFarmEnabled do
        task.wait(0.5)
        local map = Workspace:FindFirstChild("RegularLobby") or Workspace:FindFirstChild("Lobby")
        local plrChar = LocalPlayer.Character
        if not plrChar then continue end
        local hrp = plrChar:FindFirstChild("HumanoidRootPart")
        if not hrp then continue end
        if map and (hrp.Position - map:GetPivot().Position).Magnitude <= 120 then continue end
        local coinContainer = map and map:FindFirstChild("CoinContainer")
        if not coinContainer then continue end
        local coins = {}
        for _, child in ipairs(coinContainer:GetChildren()) do
            if child.Name == "Coin_Server" and child:IsA("BasePart") and child:IsDescendantOf(Workspace) then
                table.insert(coins, child)
            end
        end
        if #coins == 0 then continue end
        table.sort(coins, function(a, b)
            return (a.Position - hrp.Position).Magnitude < (b.Position - hrp.Position).Magnitude
        end)
        local targetCoin = coins[1]
        if targetCoin then
            local tween = TweenService:Create(hrp, TweenInfo.new(0.3), {CFrame = targetCoin.CFrame})
            tween:Play()
            tween.Completed:Wait()
            hrp.CFrame = hrp.CFrame + Vector3.new(0, 15, 0)
        end
    end
end

-- === ЗАПУСК СЕРВИСОВ ===
local function StartServices()
    -- ESP
    UpdateAllESP()
    Workspace.DescendantAdded:Connect(AddGunESP)
    for _, part in ipairs(Workspace:GetDescendants()) do
        AddGunESP(part)
    end
    if Settings.XrayEnabled then EnableXray() end
    -- Infinite Jump
    if Settings.InfiniteJumpEnabled then ToggleInfiniteJump() end
    -- Walk Speed
    ApplyWalkSpeed()
    LocalPlayer.CharacterAdded:Connect(function()
        task.wait(0.6)
        ApplyWalkSpeed()
        UpdateAllESP()
    end)
    -- Fly
    if Settings.FlyEnabled then ToggleFly() end
    -- Coin Farm
    if Settings.CoinFarmEnabled then task.spawn(CoinFarmLoop) end
    -- Grab Gun
    Workspace.DescendantAdded:Connect(AutoGrabGun)
end

-- === UI (RAYFIELD) ===
local Window = Rayfield:CreateWindow({
    Name = "Alienware MM2",
    Icon = 0,
    LoadingTitle = "Alienware",
    LoadingSubtitle = "MM2 Hub",
    Theme = "Dark"
})

-- === ВКЛАДКИ ===
local ESPTab = Window:CreateTab("ESP", 0)
local PlayerTab = Window:CreateTab("Player", 1)
local FarmTab = Window:CreateTab("Farm", 2)
local MiscTab = Window:CreateTab("Misc", 3)

-- === ESP ВКЛАДКА ===
ESPTab:CreateSection("ESP Settings")
ESPTab:CreateToggle({
    Name = "Chams ESP",
    CurrentValue = Settings.ChamsESP,
    Flag = "ChamsESP",
    Callback = function(v)
        Settings.ChamsESP = v
        if v then UpdateAllESP() else ClearAllESP() end
    end
})
ESPTab:CreateToggle({
    Name = "Role ESP",
    CurrentValue = Settings.RoleESP,
    Flag = "RoleESP",
    Callback = function(v)
        Settings.RoleESP = v
        UpdateAllESP()
    end
})
ESPTab:CreateToggle({
    Name = "Gun ESP",
    CurrentValue = Settings.GunESP,
    Flag = "GunESP",
    Callback = function(v)
        Settings.GunESP = v
        if not v then ClearGunESP() end
    end
})
ESPTab:CreateToggle({
    Name = "Xray (Wallhack)",
    CurrentValue = Settings.XrayEnabled,
    Flag = "Xray",
    Callback = function(v)
        Settings.XrayEnabled = v
        if v then EnableXray() else ClearXray() end
    end
})
ESPTab:CreateSlider({
    Name = "ESP Fill Transparency",
    Range = {0, 100},
    Increment = 1,
    Suffix = "%",
    CurrentValue = Settings.EspFillTransparency,
    Flag = "EspFillTransparency",
    Callback = function(v)
        Settings.EspFillTransparency = v
        UpdateAllESP()
    end
})
ESPTab:CreateColorPicker({
    Name = "Innocent Color",
    Flag = "InnocentColor",
    CurrentValue = GetColorFromHue(Settings.InnocentHue),
    Callback = function(c)
        Settings.InnocentHue = c.Hue * 360
        UpdateAllESP()
    end
})
ESPTab:CreateColorPicker({
    Name = "Murderer Color",
    Flag = "MurdererColor",
    CurrentValue = GetColorFromHue(Settings.MurdererHue),
    Callback = function(c)
        Settings.MurdererHue = c.Hue * 360
        UpdateAllESP()
    end
})
ESPTab:CreateColorPicker({
    Name = "Sheriff Color",
    Flag = "SheriffColor",
    CurrentValue = GetColorFromHue(Settings.SheriffHue),
    Callback = function(c)
        Settings.SheriffHue = c.Hue * 360
        UpdateAllESP()
    end
})

-- === PLAYER ВКЛАДКА ===
PlayerTab:CreateSection("Player Settings")
PlayerTab:CreateToggle({
    Name = "Infinite Jump",
    CurrentValue = Settings.InfiniteJumpEnabled,
    Flag = "InfiniteJump",
    Callback = function(v)
        Settings.InfiniteJumpEnabled = v
        if v then ToggleInfiniteJump() else
            if JumpConn then JumpConn:Disconnect() end
        end
    end
})
PlayerTab:CreateSlider({
    Name = "Walk Speed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "",
    CurrentValue = Settings.WalkSpeed,
    Flag = "WalkSpeed",
    Callback = function(v)
        Settings.WalkSpeed = v
        ApplyWalkSpeed()
    end
})
PlayerTab:CreateToggle({
    Name = "Fly",
    CurrentValue = Settings.FlyEnabled,
    Flag = "Fly",
    Callback = function(v)
        ToggleFly()
    end
})
PlayerTab:CreateSlider({
    Name = "Fly Speed",
    Range = {10, 200},
    Increment = 1,
    Suffix = "",
    CurrentValue = Settings.FlySpeed,
    Flag = "FlySpeed",
    Callback = function(v)
        Settings.FlySpeed = v
    end
})

-- === FARM ВКЛАДКА ===
FarmTab:CreateSection("Coin Farm")
FarmTab:CreateToggle({
    Name = "Coin Farm",
    CurrentValue = Settings.CoinFarmEnabled,
    Flag = "CoinFarm",
    Callback = function(v)
        Settings.CoinFarmEnabled = v
        if v then task.spawn(CoinFarmLoop) else CoinFarmRunning = false end
    end
})

-- === MISC ВКЛАДКА ===
MiscTab:CreateSection("Misc")
MiscTab:CreateToggle({
    Name = "Auto Grab Gun",
    CurrentValue = Settings.AutoGrabGun,
    Flag = "AutoGrab",
    Callback = function(v)
        Settings.AutoGrabGun = v
    end
})
MiscTab:CreateToggle({
    Name = "Fling Sheriff (One-Shot)",
    CurrentValue = Settings.FlingSheriffEnabled,
    Flag = "FlingSheriff",
    Callback = function(v)
        Settings.FlingSheriffEnabled = v
    end
})
MiscTab:CreateButton({
    Name = "Fling Sheriff Now",
    Callback = function()
        FlingSheriff()
    end
})

-- === ЗАПУСК ===
StartServices()
