local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

WindUI:AddTheme({
    Name                         = "PressureRed",
    Accent                       = Color3.fromHex("#DC2626"),
    Background                   = Color3.fromHex("#0A0A0C"),
    Outline                      = Color3.fromHex("#3B0A0A"),
    Text                         = Color3.fromHex("#F0F0F5"),
    Placeholder                  = Color3.fromHex("#7A4040"),
    Button                       = Color3.fromHex("#1F1010"),
    Icon                         = Color3.fromHex("#DC2626"),
    WindowBackground             = Color3.fromHex("#080809"),
    WindowShadow                 = Color3.fromHex("#000000"),
    DialogBackground             = Color3.fromHex("#0D0D10"),
    DialogBackgroundTransparency = 0,
    DialogTitle                  = Color3.fromHex("#F0F0F5"),
    DialogContent                = Color3.fromHex("#C0C0C5"),
    DialogIcon                   = Color3.fromHex("#DC2626"),
    WindowTopbarButtonIcon       = Color3.fromHex("#DC2626"),
    WindowTopbarTitle            = Color3.fromHex("#F0F0F5"),
    WindowTopbarAuthor           = Color3.fromHex("#7A4040"),
    WindowTopbarIcon             = Color3.fromHex("#DC2626"),
    TabBackground                = Color3.fromHex("#100808"),
    TabTitle                     = Color3.fromHex("#F0F0F5"),
    TabIcon                      = Color3.fromHex("#DC2626"),
    ElementBackground            = Color3.fromHex("#110A0A"),
    ElementTitle                 = Color3.fromHex("#F0F0F5"),
    ElementDesc                  = Color3.fromHex("#A08080"),
    ElementIcon                  = Color3.fromHex("#DC2626"),
    PopupBackground              = Color3.fromHex("#0D0D10"),
    PopupBackgroundTransparency  = 0,
    PopupTitle                   = Color3.fromHex("#F0F0F5"),
    PopupContent                 = Color3.fromHex("#C0C0C5"),
    PopupIcon                    = Color3.fromHex("#DC2626"),
})

WindUI:SetTheme("PressureRed")

local Window = WindUI:CreateWindow({
    Title         = "PressureHub",
    Author        = "MM2 Edition",
    Icon          = "zap",
    Folder        = "PressureHub",
    Size          = UDim2.fromOffset(580, 460),
    Theme         = "PressureRed",
    HideSearchBar = true,
    OpenButton    = {
        Title           = "PressureHub",
        CornerRadius    = UDim.new(0, 8),
        StrokeThickness = 2,
        Enabled         = true,
        Draggable       = true,
        OnlyMobile      = false,
        Color           = ColorSequence.new(
            Color3.fromHex("#DC2626"),
            Color3.fromHex("#7F1D1D")
        ),
    },
})

local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting     = game:GetService("Lighting")
local LocalPlayer  = Players.LocalPlayer
local Camera       = workspace.CurrentCamera

local AF = {
    Enabled     = false,
    FarmMode    = "Underground",
    TweenSpeed  = 15,
    AutoReset   = true,
    AvoidMurder = true,
}

local State = {
    farming = false,
    flying  = false,
    target  = nil,
    ignored = {},
    tween   = nil,
}

local function isBagFull()
    local pg = LocalPlayer.PlayerGui
    local mg = pg and pg:FindFirstChild("MainGUI")
    local lb = mg and mg:FindFirstChild("Lobby")
    local dk = lb and lb:FindFirstChild("Dock")
    local cb = dk and dk:FindFirstChild("CoinBags")
    local fn = cb and cb:FindFirstChild("FullBagNotification")
    return fn and fn.Visible or false
end

local function isRoundOver()
    local pg = LocalPlayer.PlayerGui
    local vg = pg and pg:FindFirstChild("Victory")
    if not vg then return false end
    for _, c in pairs(vg:GetChildren()) do
        if c:IsA("GuiObject") and c.Visible then return true end
    end
    return false
end

local function getCoinCount()
    local ok, v = pcall(function()
        return tonumber(LocalPlayer.PlayerGui.MainGUI.Game.CoinBags.Container.Coin.CurrencyFrame.Icon.Coins.Text) or 0
    end)
    return ok and v or 0
end

local function nearbyMurderer()
    if not AF.AvoidMurder then return false end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local oh = p.Character:FindFirstChild("HumanoidRootPart")
            if oh and (oh.Position - hrp.Position).Magnitude <= 10 then
                if p.Character:FindFirstChild("Knife") then return true end
                local bp = p:FindFirstChild("Backpack")
                if bp and bp:FindFirstChild("Knife") then return true end
            end
        end
    end
    return false
end

local function getNearestCoin(hrp)
    local container
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "CoinContainer" then container = obj break end
    end
    if not container then return nil end
    local best, bestDist = nil, math.huge
    for _, coin in pairs(container:GetChildren()) do
        if coin.Name == "Coin_Server" and coin:IsA("BasePart") and not State.ignored[coin] then
            local d = (hrp.Position - coin.Position).Magnitude
            if d < bestDist then bestDist = d best = coin end
        end
    end
    return best
end

local function removePhysics()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local bv = hrp:FindFirstChild("FarmBV")
    local bg = hrp:FindFirstChild("FarmBG")
    if bv then bv:Destroy() end
    if bg then bg:Destroy() end
end

local function stopFarming()
    State.farming = false
    State.flying  = false
    State.target  = nil
    if State.tween then
        pcall(function() State.tween:Cancel() end)
        State.tween = nil
    end
    removePhysics()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then
        hum.PlatformStand = false
        hum.Sit = false
    end
end

local function flyToCoin(coin, hrp, hum)
    local targetPos = coin.Position - Vector3.new(0, 4, 0)

    local bv = hrp:FindFirstChild("FarmBV")
    if not bv then
        bv          = Instance.new("BodyVelocity")
        bv.Name     = "FarmBV"
        bv.MaxForce = Vector3.new(1e9, 1e9, 1e9)
        bv.Velocity = Vector3.zero
        bv.Parent   = hrp
    end

    local bg = hrp:FindFirstChild("FarmBG")
    if not bg then
        bg           = Instance.new("BodyGyro")
        bg.Name      = "FarmBG"
        bg.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
        bg.P         = 50000
        bg.Parent    = hrp
    end

    local _, ry, _ = hrp.CFrame:ToOrientation()
    bg.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, ry, 0) * CFrame.Angles(math.rad(-90), 0, 0)

    hum.PlatformStand = true
    for _, p in pairs(LocalPlayer.Character:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end

    local dist = (hrp.Position - targetPos).Magnitude
    local tw = TweenService:Create(hrp, TweenInfo.new(dist / AF.TweenSpeed, Enum.EasingStyle.Linear), {
        CFrame = CFrame.new(targetPos) * bg.CFrame.Rotation
    })
    State.tween = tw
    tw:Play()

    local reached = false
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not State.farming or not coin.Parent then
            tw:Cancel()
            conn:Disconnect()
            return
        end
        if firetouchinterest then
            pcall(firetouchinterest, hrp, coin, 0)
            pcall(firetouchinterest, hrp, coin, 1)
        end
        if (hrp.Position - targetPos).Magnitude <= 2 then
            reached = true
            tw:Cancel()
            conn:Disconnect()
        end
    end)

    while conn.Connected do RunService.Heartbeat:Wait() end
    return reached
end

local function startFarming()
    if State.farming then return end
    State.farming = true
    table.clear(State.ignored)

    task.spawn(function()
        while State.farming do
            task.wait()

            if nearbyMurderer() then
                removePhysics()
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChild("Humanoid")
                if hum then hum.Sit = false end
                task.wait(1)
                continue
            end

            local char = LocalPlayer.Character
            local hrp  = char and char:FindFirstChild("HumanoidRootPart")
            local hum  = char and char:FindFirstChild("Humanoid")

            if not char or not hrp or not hum or hum.Health <= 0 then
                removePhysics()
                task.wait(1)
                continue
            end

            if isRoundOver() or isBagFull() then
                stopFarming()
                break
            end

            if AF.AutoReset and getCoinCount() >= 40 then
                hum.Health = 0
                task.wait(5)
                continue
            end

            local coin = getNearestCoin(hrp)
            if not coin then
                task.wait(0.5)
                continue
            end

            State.flying = true
            State.target = coin

            local reached = flyToCoin(coin, hrp, hum)

            if reached and State.farming and hum.Health > 0 then
                State.ignored[coin] = true
                task.delay(5, function() State.ignored[coin] = nil end)
            end

            State.flying = false
            State.target = nil
            task.wait(0.1)
        end
    end)
end

RunService.Stepped:Connect(function()
    if not State.farming or not State.flying then return end
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if hum then hum.PlatformStand = true end
    if char then
        for _, p in pairs(char:GetDescendants()) do
            if p:IsA("BasePart") then p.CanCollide = false end
        end
    end
end)

local ESPDrawings = {}
local ESPEnabled = false
local ESPBox = true
local ESPLine = true
local ESPName = true
local ESPTrigger = false
local ESPBoxColor = Color3.fromRGB(255, 0, 0)
local ESPLineColor = Color3.fromRGB(0, 255, 0)
local ESPNameColor = Color3.fromRGB(255, 255, 255)
local ESPDistance = 500

local function removeESPForPlayer(player)
    if ESPDrawings[player] then
        for _, drawing in pairs(ESPDrawings[player]) do
            drawing.Visible = false
            drawing:Remove()
        end
        ESPDrawings[player] = nil
    end
end

local function getScreenPos(worldPos)
    local ok, screenPos = pcall(function()
        return Camera:WorldToScreenPoint(worldPos)
    end)
    return ok and screenPos or nil
end

local function updateESP()
    for player, drawings in pairs(ESPDrawings) do
        if not player or not player.Parent or not player.Character then
            removeESPForPlayer(player)
            continue
        end

        local hrp = player.Character:FindFirstChild("HumanoidRootPart")
        if not hrp then
            removeESPForPlayer(player)
            continue
        end

        local myHRP = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
        local dist = myHRP and (myHRP.Position - hrp.Position).Magnitude or 9999

        if dist > ESPDistance then
            removeESPForPlayer(player)
            continue
        end

        local head = player.Character:FindFirstChild("Head")
        if not head then continue end

        local topPos = getScreenPos(head.Position + Vector3.new(0, 3, 0))
        local botPos = getScreenPos(hrp.Position - Vector3.new(0, 3, 0))
        local centerPos = getScreenPos(hrp.Position)

        if topPos and botPos and centerPos then
            local height = math.abs(topPos.Y - botPos.Y)
            local width = height / 2

            if drawings.box then
                drawings.box.Visible = ESPBox
                drawings.box.TopLeft = Vector2.new(topPos.X - width / 2, topPos.Y)
                drawings.box.BottomRight = Vector2.new(topPos.X + width / 2, botPos.Y)
                drawings.box.Color = ESPBoxColor
            end

            if drawings.line then
                drawings.line.Visible = ESPLine
                drawings.line.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                drawings.line.To = Vector2.new(centerPos.X, centerPos.Y)
                drawings.line.Color = ESPLineColor
            end

            if drawings.name then
                drawings.name.Visible = ESPName
                drawings.name.Position = Vector2.new(topPos.X, topPos.Y - 20)
                drawings.name.Text = player.DisplayName or player.Name
                drawings.name.Color = ESPNameColor
            end

            if drawings.trigger then
                drawings.trigger.Visible = ESPTrigger
                drawings.trigger.Position = Vector2.new(centerPos.X - 20, centerPos.Y - 20)
                drawings.trigger.Size = 40
                drawings.trigger.Radius = 20
                drawings.trigger.Filled = false
                drawings.trigger.Color = ESPBoxColor
                drawings.trigger.Thickness = 2
            end
        end
    end
end

local function createESPForPlayer(player)
    if player == LocalPlayer then return end
    if ESPDrawings[player] then return end

    ESPDrawings[player] = {
        box = Drawing.new("Square"),
        line = Drawing.new("Line"),
        name = Drawing.new("Text"),
        trigger = Drawing.new("Circle"),
    }

    ESPDrawings[player].box.Thickness = 2
    ESPDrawings[player].box.Filled = false
    ESPDrawings[player].line.Thickness = 1
    ESPDrawings[player].name.Size = 18
    ESPDrawings[player].name.Center = true
end

local function refreshESPPlayers()
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if ESPEnabled then
                createESPForPlayer(p)
            else
                removeESPForPlayer(p)
            end
        end
    end
end

Players.PlayerAdded:Connect(function(p)
    if ESPEnabled then
        createESPForPlayer(p)
    end
end)

Players.PlayerRemoving:Connect(function(p)
    removeESPForPlayer(p)
end)

RunService.RenderStepped:Connect(function()
    if ESPEnabled then
        updateESP()
    end
end)

local AuraParticles = {}
local AuraTypes = {
    "None", "Beta", "Hallows", "Kitty", "Kirumi",
    "Rainbow", "Red", "Blue", "Green", "Orange",
}
local AuraColor = Color3.fromRGB(133, 220, 255)
local AuraEnabled = false
local AuraType = "None"

local function clearAura()
    for _, p in pairs(AuraParticles) do
        if p and p.Parent then p:Destroy() end
    end
    AuraParticles = {}
end

local function applyAura()
    clearAura()
    if not AuraEnabled or AuraType == "None" then return end
    local char = LocalPlayer.Character
    if not char then return end
    local parts = {
        "Head", "UpperTorso", "LowerTorso",
        "LeftUpperArm", "RightUpperArm",
        "LeftUpperLeg", "RightUpperLeg",
    }
    for _, name in pairs(parts) do
        local part = char:FindFirstChild(name)
        if part then
            local pe = Instance.new("ParticleEmitter")
            pe.Name          = "PressureAura"
            pe.Color         = ColorSequence.new(AuraColor)
            pe.LightEmission = 0.5
            pe.LightInfluence = 0.5
            pe.Size          = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0.3),
                NumberSequenceKeypoint.new(1, 0),
            })
            pe.Transparency  = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 1),
            })
            pe.Speed         = NumberRange.new(1, 3)
            pe.Rate          = 20
            pe.Lifetime      = NumberRange.new(0.5, 1.2)
            pe.SpreadAngle   = Vector2.new(30, 30)
            pe.Parent        = part
            table.insert(AuraParticles, pe)
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function()
    if AuraEnabled then
        task.delay(0.75, applyAura)
    end
end)

local ChinaHatPart  = nil
local ChinaHatWeld  = nil
local ChinaHatEnabled = false

local function removeHat()
    if ChinaHatPart then ChinaHatPart:Destroy() ChinaHatPart = nil end
    if ChinaHatWeld then ChinaHatWeld:Destroy() ChinaHatWeld = nil end
end

local function applyHat()
    removeHat()
    local char = LocalPlayer.Character
    local head = char and char:FindFirstChild("Head")
    if not head then return end

    local hat = Instance.new("Part")
    hat.Name        = "ChinaHat"
    hat.Size        = Vector3.new(2.2, 0.3, 2.2)
    hat.CanCollide  = false
    hat.Anchored    = false
    hat.Parent      = char

    local mesh = Instance.new("SpecialMesh")
    mesh.MeshType = Enum.MeshType.FileMesh
    mesh.MeshId   = "rbxassetid://1072909"
    mesh.TextureId = "rbxassetid://1072910"
    mesh.Scale    = Vector3.new(1.1, 1.1, 1.1)
    mesh.Parent   = hat

    local weld = Instance.new("WeldConstraint")
    weld.Part0  = head
    weld.Part1  = hat
    weld.Parent = hat
    hat.CFrame  = head.CFrame * CFrame.new(0, 0.7, 0)

    ChinaHatPart = hat
    ChinaHatWeld = weld
end

LocalPlayer.CharacterAdded:Connect(function()
    if ChinaHatEnabled then
        task.delay(1, applyHat)
    end
end)

local ChamsEnabled = false
local ChamsColor   = Color3.fromRGB(255, 0, 0)
local ChamsOriginals = {}
local CHAMS_PARTS = {
    "Head","LeftFoot","LeftHand","LeftLowerArm","LeftLowerLeg",
    "LeftUpperArm","LeftUpperLeg","LowerTorso","RightFoot","RightHand",
    "RightLowerArm","RightLowerLeg","RightUpperArm","RightUpperLeg","UpperTorso",
}

local function applyChams(char)
    if not char then return end
    ChamsOriginals = {}
    for _, name in pairs(CHAMS_PARTS) do
        local p = char:FindFirstChild(name)
        if p and p:IsA("BasePart") then
            ChamsOriginals[name] = { Color = p.Color, Material = p.Material }
            p.Material = Enum.Material.ForceField
            p.Color    = ChamsColor
        end
    end
end

local function removeChams(char)
    if not char then return end
    for _, name in pairs(CHAMS_PARTS) do
        local p = char:FindFirstChild(name)
        if p and p:IsA("BasePart") and ChamsOriginals[name] then
            p.Color    = ChamsOriginals[name].Color
            p.Material = ChamsOriginals[name].Material
        end
    end
    ChamsOriginals = {}
end

LocalPlayer.CharacterAdded:Connect(function(char)
    if ChamsEnabled then
        task.delay(1, function() applyChams(char) end)
    end
end)

local HeadlessEnabled = false

local function applyHeadless(char)
    local head = char and char:FindFirstChild("Head")
    if not head then return end
    head.Transparency = 1
    local face = head:FindFirstChild("face")
    if face then face.Transparency = 1 end
end

local function removeHeadless(char)
    local head = char and char:FindFirstChild("Head")
    if not head then return end
    head.Transparency = 0
    local face = head:FindFirstChild("face")
    if face then face.Transparency = 0 end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    if HeadlessEnabled then
        task.delay(1, function() applyHeadless(char) end)
    end
end)

local FullbrightEnabled = false
local OriginalLighting = {
    Brightness     = Lighting.Brightness,
    Ambient        = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
}

local function applyFullbright()
    Lighting.Brightness     = 3
    Lighting.Ambient        = Color3.fromRGB(178, 178, 178)
    Lighting.OutdoorAmbient = Color3.fromRGB(178, 178, 178)
end

local function removeFullbright()
    Lighting.Brightness     = OriginalLighting.Brightness
    Lighting.Ambient        = OriginalLighting.Ambient
    Lighting.OutdoorAmbient = OriginalLighting.OutdoorAmbient
end

local GunMaterialEnabled = false
local GunMaterialType    = Enum.Material.Neon
local GunMaterialColor   = Color3.fromRGB(220, 40, 40)
local GunGlowEnabled     = false
local GunGlowColor       = Color3.fromRGB(220, 40, 40)
local GunEffectType      = "None"
local GunTransparency    = 0

local GunEffects = {
    "None", "Phantom", "TransparentBlue", "Neon"
}

task.spawn(function()
    while task.wait(0.3) do
        if not GunMaterialEnabled and not GunGlowEnabled and GunEffectType == "None" then continue end
        local char = LocalPlayer.Character
        if not char then continue end
        for _, child in pairs(char:GetChildren()) do
            if child:IsA("Tool") then
                for _, p in pairs(child:GetDescendants()) do
                    if p:IsA("BasePart") and p.Transparency < 1 then
                        pcall(function()
                            if GunMaterialEnabled then
                                p.Material = GunMaterialType
                                p.Color    = GunMaterialColor
                            end
                            if GunGlowEnabled then
                                local light = p:FindFirstChild("GunLight")
                                if not light then
                                    light = Instance.new("PointLight")
                                    light.Name = "GunLight"
                                    light.Color = GunGlowColor
                                    light.Brightness = 2
                                    light.Range = 15
                                    light.Parent = p
                                else
                                    light.Color = GunGlowColor
                                end
                            end
                            if GunEffectType == "Phantom" then
                                p.Transparency = 0.2
                            elseif GunEffectType == "TransparentBlue" then
                                p.Transparency = 0.5
                                p.Color = Color3.fromRGB(0, 150, 255)
                            elseif GunEffectType == "Neon" then
                                p.Material = Enum.Material.Neon
                                p.Transparency = GunTransparency
                            end
                        end)
                    end
                end
            end
        end
    end
end)

local PlayerSpeed = 50
local SpeedEnabled = false
local WallSpeedEnabled = false
local JumpPowerEnabled = false
local JumpPower = 50
local InvisEnabled = false
local InvisOriginals = {}

local function applySpeed()
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChild("Humanoid")
    if not hrp or not hum then return end

    if SpeedEnabled then
        local moveDir = hum.MoveDirection
        if moveDir.Magnitude > 0 then
            local vel = hrp.Velocity
            local newVel = Vector3.new(moveDir.X * PlayerSpeed, vel.Y, moveDir.Z * PlayerSpeed)
            hrp.Velocity = newVel
            hrp.AssemblyLinearVelocity = newVel
        end
    end
end

local function applyJumpPower()
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    if not hum then return end
    if JumpPowerEnabled then
        hum.JumpPower = JumpPower
    end
end

local function applyInvis()
    InvisOriginals = {}
    local char = LocalPlayer.Character
    if not char then return end

    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            InvisOriginals[part] = part.Transparency
            part.Transparency = 0.5
        elseif part:IsA("Decal") then
            InvisOriginals[part] = part.Transparency
            part.Transparency = 1
        end
    end
end

local function removeInvis()
    local char = LocalPlayer.Character
    if not char then return end

    for part, trans in pairs(InvisOriginals) do
        if part and part.Parent then
            part.Transparency = trans
        end
    end
    InvisOriginals = {}
end

RunService.Heartbeat:Connect(function()
    if SpeedEnabled then applySpeed() end
    if JumpPowerEnabled then applyJumpPower() end
end)

LocalPlayer.CharacterAdded:Connect(function(char)
    if InvisEnabled then
        task.delay(0.5, applyInvis)
    end
    if JumpPowerEnabled then
        task.delay(0.5, applyJumpPower)
    end
end)

local TabFarm = Window:Tab({ Title = "AutoFarm", Icon = "coins" })

TabFarm:Toggle({
    Title    = "Auto Farm",
    Desc     = "Automatically collects coins",
    Icon     = "play",
    Default  = false,
    Callback = function(v)
        AF.Enabled = v
        if v then startFarming() else stopFarming() end
    end,
})

TabFarm:Toggle({
    Title    = "Auto Reset (40 coins)",
    Desc     = "Resets character at 40 coins",
    Icon     = "refresh-cw",
    Default  = true,
    Callback = function(v) AF.AutoReset = v end,
})

TabFarm:Toggle({
    Title    = "Avoid Murderer",
    Desc     = "Pauses if knife is nearby",
    Icon     = "shield",
    Default  = true,
    Callback = function(v) AF.AvoidMurder = v end,
})

TabFarm:Dropdown({
    Title    = "Farm Mode",
    Desc     = "Underground = noclip, Sit = tween",
    Icon     = "layers",
    Values   = { "Underground", "Sit" },
    Default  = "Underground",
    Callback = function(v) AF.FarmMode = v end,
})

TabFarm:Slider({
    Title    = "Movement Speed",
    Desc     = "Tween speed toward coins",
    Icon     = "gauge",
    Value    = { Min = 5, Max = 30, Default = 15 },
    Callback = function(v) AF.TweenSpeed = v end,
})

TabFarm:Button({
    Title    = "Stop Farm",
    Desc     = "Force stop farming",
    Icon     = "square",
    Callback = function()
        stopFarming()
        WindUI:Notification({ Title = "PressureHub", Content = "Farm stopped.", Icon = "x", Duration = 3 })
    end,
})

local TabPlayer = Window:Tab({ Title = "Player", Icon = "user" })

TabPlayer:Toggle({
    Title    = "Speed",
    Desc     = "Speed glitch movement",
    Icon     = "zap",
    Default  = false,
    Callback = function(v) SpeedEnabled = v end,
})

TabPlayer:Slider({
    Title    = "Speed Value",
    Desc     = "Movement speed amount",
    Icon     = "gauge",
    Value    = { Min = 10, Max = 200, Default = 50 },
    Callback = function(v) PlayerSpeed = v end,
})

TabPlayer:Toggle({
    Title    = "Wall Speed",
    Desc     = "Speed glitch on walls",
    Icon     = "zap",
    Default  = false,
    Callback = function(v) WallSpeedEnabled = v end,
})

TabPlayer:Toggle({
    Title    = "Jump Power",
    Desc     = "Increase jump height",
    Icon     = "arrow-up",
    Default  = false,
    Callback = function(v)
        JumpPowerEnabled = v
        if v then applyJumpPower() end
    end,
})

TabPlayer:Slider({
    Title    = "Jump Power Value",
    Desc     = "Jump height amount",
    Icon     = "gauge",
    Value    = { Min = 5, Max = 200, Default = 50 },
    Callback = function(v)
        JumpPower = v
        if JumpPowerEnabled then applyJumpPower() end
    end,
})

TabPlayer:Toggle({
    Title    = "Invisibility",
    Desc     = "Invisible to other players (semi-transparent for you)",
    Icon     = "eye-off",
    Default  = false,
    Callback = function(v)
        InvisEnabled = v
        local char = LocalPlayer.Character
        if v then
            applyInvis()
        else
            removeInvis()
        end
    end,
})

local TabESP = Window:Tab({ Title = "ESP", Icon = "scan" })

TabESP:Toggle({
    Title    = "Enable ESP",
    Desc     = "Show ESP on all players",
    Icon     = "eye",
    Default  = false,
    Callback = function(v)
        ESPEnabled = v
        if v then
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= LocalPlayer then
                    createESPForPlayer(p)
                end
            end
        else
            for p, _ in pairs(ESPDrawings) do
                removeESPForPlayer(p)
            end
        end
    end,
})

TabESP:Toggle({
    Title    = "ESP Box",
    Desc     = "Draw boxes around players",
    Icon     = "square",
    Default  = true,
    Callback = function(v) ESPBox = v end,
})

TabESP:Toggle({
    Title    = "ESP Line",
    Desc     = "Draw lines to players",
    Icon     = "arrow-right",
    Default  = true,
    Callback = function(v) ESPLine = v end,
})

TabESP:Toggle({
    Title    = "ESP Name",
    Desc     = "Show player names",
    Icon     = "type",
    Default  = true,
    Callback = function(v) ESPName = v end,
})

TabESP:Toggle({
    Title    = "ESP Trigger",
    Desc     = "Rotating reticle on players",
    Icon     = "target",
    Default  = false,
    Callback = function(v) ESPTrigger = v end,
})

TabESP:Slider({
    Title    = "ESP Distance",
    Desc     = "Max distance to show ESP",
    Icon     = "move",
    Value    = { Min = 100, Max = 1000, Default = 500 },
    Callback = function(v) ESPDistance = v end,
})

TabESP:ColorPicker({
    Title    = "Box Color",
    Desc     = "ESP box color",
    Icon     = "palette",
    Default  = Color3.fromRGB(255, 0, 0),
    Callback = function(v) ESPBoxColor = v end,
})

TabESP:ColorPicker({
    Title    = "Line Color",
    Desc     = "ESP line color",
    Icon     = "palette",
    Default  = Color3.fromRGB(0, 255, 0),
    Callback = function(v) ESPLineColor = v end,
})

TabESP:ColorPicker({
    Title    = "Name Color",
    Desc     = "Player name color",
    Icon     = "palette",
    Default  = Color3.fromRGB(255, 255, 255),
    Callback = function(v) ESPNameColor = v end,
})

local TabVisuals = Window:Tab({ Title = "Visuals", Icon = "eye" })

TabVisuals:Toggle({
    Title    = "Chams",
    Desc     = "ForceField material on your character",
    Icon     = "user",
    Default  = false,
    Callback = function(v)
        ChamsEnabled = v
        local char = LocalPlayer.Character
        if v then applyChams(char) else removeChams(char) end
    end,
})

TabVisuals:ColorPicker({
    Title    = "Chams Color",
    Desc     = "Chams body color",
    Icon     = "droplet",
    Default  = Color3.fromRGB(255, 0, 0),
    Callback = function(v)
        ChamsColor = v
        if ChamsEnabled then
            applyChams(LocalPlayer.Character)
        end
    end,
})

TabVisuals:Toggle({
    Title    = "Particle Aura",
    Desc     = "Particle effect around your character",
    Icon     = "sparkles",
    Default  = false,
    Callback = function(v)
        AuraEnabled = v
        if v then applyAura() else clearAura() end
    end,
})

TabVisuals:ColorPicker({
    Title    = "Aura Color",
    Desc     = "Color of the particle aura",
    Icon     = "palette",
    Default  = Color3.fromRGB(133, 220, 255),
    Callback = function(v)
        AuraColor = v
        if AuraEnabled then applyAura() end
    end,
})

TabVisuals:Dropdown({
    Title    = "Aura Type",
    Desc     = "Style of particle aura",
    Icon     = "layers",
    Values   = AuraTypes,
    Default  = "None",
    Callback = function(v)
        AuraType = v
        if AuraEnabled then applyAura() end
    end,
})

TabVisuals:Toggle({
    Title    = "China Hat",
    Desc     = "Attach a straw hat to your head",
    Icon     = "triangle",
    Default  = false,
    Callback = function(v)
        ChinaHatEnabled = v
        if v then applyHat() else removeHat() end
    end,
})

TabVisuals:Toggle({
    Title    = "Headless",
    Desc     = "Make your head invisible",
    Icon     = "user-x",
    Default  = false,
    Callback = function(v)
        HeadlessEnabled = v
        local char = LocalPlayer.Character
        if v then applyHeadless(char) else removeHeadless(char) end
    end,
})

TabVisuals:Toggle({
    Title    = "Fullbright",
    Desc     = "Maximum ambient lighting",
    Icon     = "sun",
    Default  = false,
    Callback = function(v)
        FullbrightEnabled = v
        if v then applyFullbright() else removeFullbright() end
    end,
})

TabVisuals:Toggle({
    Title    = "Gun Material",
    Desc     = "Change material of held weapon",
    Icon     = "zap",
    Default  = false,
    Callback = function(v) GunMaterialEnabled = v end,
})

TabVisuals:ColorPicker({
    Title    = "Gun Color",
    Desc     = "Color of the gun material",
    Icon     = "droplet",
    Default  = Color3.fromRGB(220, 40, 40),
    Callback = function(v) GunMaterialColor = v end,
})

TabVisuals:Dropdown({
    Title    = "Gun Material Type",
    Desc     = "Material applied to the gun",
    Icon     = "box",
    Values   = {
        "Neon", "ForceField", "Glass", "Metal",
        "DiamondPlate", "Foil", "SmoothPlastic",
    },
    Default  = "Neon",
    Callback = function(v)
        GunMaterialType = Enum.Material[v] or Enum.Material.Neon
    end,
})

TabVisuals:Toggle({
    Title    = "Gun Glow",
    Desc     = "Add light to your gun",
    Icon     = "lightbulb",
    Default  = false,
    Callback = function(v) GunGlowEnabled = v end,
})

TabVisuals:ColorPicker({
    Title    = "Glow Color",
    Desc     = "Color of gun glow effect",
    Icon     = "palette",
    Default  = Color3.fromRGB(220, 40, 40),
    Callback = function(v) GunGlowColor = v end,
})

TabVisuals:Dropdown({
    Title    = "Gun Effect",
    Desc     = "Apply special effect to gun",
    Icon     = "sparkles",
    Values   = GunEffects,
    Default  = "None",
    Callback = function(v) GunEffectType = v end,
})

TabVisuals:Slider({
    Title    = "Gun Transparency",
    Desc     = "Neon gun transparency (0-1)",
    Icon     = "eye-off",
    Value    = { Min = 0, Max = 1, Default = 0 },
    Callback = function(v) GunTransparency = v end,
})

local TabSettings = Window:Tab({ Title = "Settings", Icon = "settings" })

TabSettings:Keybind({
    Title    = "Menu Keybind",
    Desc     = "Open / close PressureHub",
    Icon     = "keyboard",
    Default  = Enum.KeyCode.RightShift,
    Callback = function(key) Window:EditKeybind(key) end,
})

TabSettings:Button({
    Title    = "Unload",
    Desc     = "Remove UI and stop everything",
    Icon     = "trash-2",
    Callback = function()
        stopFarming()
        clearAura()
        removeHat()
        removeChams(LocalPlayer.Character)
        removeHeadless(LocalPlayer.Character)
        removeFullbright()
        removeInvis()
        for p, _ in pairs(ESPDrawings) do
            removeESPForPlayer(p)
        end
        WindUI:Destroy()
    end,
})

WindUI:Notification({
    Title    = "PressureHub",
    Content  = "Loaded! RightShift to open menu.",
    Icon     = "zap",
    Duration = 5,
})
