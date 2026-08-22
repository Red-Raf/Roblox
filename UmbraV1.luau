repeat task.wait() until game:IsLoaded()
task.wait(0.5)
print('UmbraHub Initialization...')

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')
local TweenService = game:GetService('TweenService')
local HttpService = game:GetService('HttpService')
local CoreGui = game:GetService('CoreGui')
local StarterGui = game:GetService('StarterGui')
local Lighting = game:GetService('Lighting')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local VirtualInputManager = game:GetService('VirtualInputManager')
local SoundService = game:GetService('SoundService')
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local Config = {
    Version = '1.0',
    Developer = 'UmbraHub',
    Discord = 'discord.gg/umbra',
    Color = {
        Background = { Primary = Color3.fromRGB(26,26,26), Secondary = Color3.fromRGB(28,28,28), Main = Color3.fromRGB(13,13,13), Hover = Color3.fromRGB(42,42,42), Active = Color3.fromRGB(40,40,40), Input = Color3.fromRGB(18,18,18) },
        Accent = { White = Color3.fromRGB(255,255,255), Gray = Color3.fromRGB(180,180,180), DarkGray = Color3.fromRGB(100,100,100) },
        State = { Success = Color3.fromRGB(46,204,113), Warning = Color3.fromRGB(241,196,15), Error = Color3.fromRGB(231,76,60), Info = Color3.fromRGB(52,152,219) },
        Text = { Primary = Color3.fromRGB(255,255,255), Secondary = Color3.fromRGB(200,200,200), Disabled = Color3.fromRGB(120,120,120) },
    },
    Size = {
        TopBar = { Height = 32, Spacing = 8, Radius = 6 },
        Window = { Width = 615, Height = 390, Radius = 16 },
        Nav = { Width = 140, ButtonHeight = 38, Spacing = 8, Radius = 8 },
        Element = { Height = 32, Spacing = 10 },
        Toggle = { Width = 42, Height = 20, DotSize = 16 },
        Slider = { Height = 6, HandleSize = 14 },
    },
    Anim = { Fast = 0.15, Normal = 0.25, Slow = 0.35 },
    Settings = {
        Keybinds = { ToggleGUI = Enum.KeyCode.RightShift, PanicKey = Enum.KeyCode.End },
        Colors = { ForceField = Color3.fromRGB(0,255,255), TargetESP = Color3.fromRGB(255,70,90), MurderESP = Color3.fromRGB(255,0,0), SheriffESP = Color3.fromRGB(0,0,255), InnocentESP = Color3.fromRGB(0,255,0), HeroESP = Color3.fromRGB(255,250,0) },
        ESP = { Murder = false, Sheriff = false, Innocent = false, Hero = false, TargetESP = false },
        Combat = { AutoShoot = false, BombJump = false, AntiFling = false, AntiVoid = false, AutoWallHop = false, GrabGun = false },
        Rage = { Noclip = false },
        Player = { ForceField = false, TargetESP = false },
    },
}

local ColorPresets = {
    { Name = 'Cyan', Color = Color3.fromRGB(0,255,255) },
    { Name = 'Pink', Color = Color3.fromRGB(255,105,180) },
    { Name = 'Red', Color = Color3.fromRGB(255,0,0) },
    { Name = 'White', Color = Color3.fromRGB(255,255,255) },
    { Name = 'Green', Color = Color3.fromRGB(0,255,0) },
    { Name = 'Blue', Color = Color3.fromRGB(0,100,255) },
    { Name = 'Yellow', Color = Color3.fromRGB(255,255,0) },
    { Name = 'Purple', Color = Color3.fromRGB(180,0,255) },
    { Name = 'Orange', Color = Color3.fromRGB(255,140,0) },
}

local defaultLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    GlobalShadows = Lighting.GlobalShadows,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    Ambient = Lighting.Ambient,
    FogStart = Lighting.FogStart,
    FogEnd = Lighting.FogEnd,
    FogColor = Lighting.FogColor,
}

local TargetESPVariables = {
    enabled = false,
    size = 45,
    maxRadius = 50,
    asset = "rbxassetid://113363639205880",
    color = Color3.fromRGB(255,70,90),
    rainbow = false,
    rotation = 0,
    gui = nil,
    frame = nil,
    texture = nil,
    currentTarget = nil,
}

local function getRootPart(char)
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("LowerTorso") or char:FindFirstChild("MainPart")
end

local function getHeadPart(char)
    if not char then return nil end
    return char:FindFirstChild("Head") or char:FindFirstChild("head") or char:FindFirstChild("CameraPart")
end

local function isFriend(player)
    if _G.FriendWhitelist and _G.FriendWhitelist[player] then return true end
    return false
end

local function isVisible(targetPart, character)
    local localChar = LocalPlayer.Character
    local head = getHeadPart(localChar)
    if not localChar or not head then return false end
    local origin = camera.CFrame.Position
    local direction = (targetPart.Position - origin)
    local raycastParams = RaycastParams.new()
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    raycastParams.FilterDescendantsInstances = {localChar, character}
    raycastParams.IgnoreWater = true
    local result = workspace:Raycast(origin, direction, raycastParams)
    return result == nil
end

local function TargetESP_Init()
    TargetESPVariables.gui = Instance.new("ScreenGui")
    TargetESPVariables.gui.Name = "UmbraTargetESP"
    TargetESPVariables.gui.ResetOnSpawn = false
    TargetESPVariables.gui.IgnoreGuiInset = true
    if gethui then TargetESPVariables.gui.Parent = gethui() else TargetESPVariables.gui.Parent = CoreGui end
    TargetESPVariables.frame = Instance.new("Frame")
    TargetESPVariables.frame.Size = UDim2.new(0,40,0,40)
    TargetESPVariables.frame.BackgroundTransparency = 1
    TargetESPVariables.frame.Visible = false
    TargetESPVariables.frame.Parent = TargetESPVariables.gui
    TargetESPVariables.texture = Instance.new("ImageLabel")
    TargetESPVariables.texture.Size = UDim2.new(1,0,1,0)
    TargetESPVariables.texture.AnchorPoint = Vector2.new(0.5,0.5)
    TargetESPVariables.texture.Position = UDim2.new(0.5,0,0.5,0)
    TargetESPVariables.texture.BackgroundTransparency = 1
    TargetESPVariables.texture.Image = TargetESPVariables.asset
    TargetESPVariables.texture.ImageColor3 = TargetESPVariables.color
    TargetESPVariables.texture.Parent = TargetESPVariables.frame
end
TargetESP_Init()

RunService.RenderStepped:Connect(function(dt)
    if not TargetESPVariables.enabled then
        TargetESPVariables.currentTarget = nil
        TargetESPVariables.frame.Visible = false
        return
    end
    if TargetESPVariables.currentTarget then
        if not TargetESPVariables.currentTarget.Character or not TargetESPVariables.currentTarget.Character:FindFirstChildOfClass("Humanoid") or TargetESPVariables.currentTarget.Character:FindFirstChildOfClass("Humanoid").Health <= 0 then
            TargetESPVariables.currentTarget = nil
        end
    end
    local bestTarget = nil
    local closestToCenter = math.huge
    local viewportSize = camera.ViewportSize
    local screenCenter = Vector2.new(viewportSize.X/2, viewportSize.Y/2)
    local localRoot = getRootPart(LocalPlayer.Character)
    if localRoot then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and not isFriend(player) then
                local hum = player.Character:FindFirstChildOfClass("Humanoid")
                local root = getRootPart(player.Character) or getHeadPart(player.Character)
                if hum and hum.Health > 0 and root then
                    local dist = (root.Position - localRoot.Position).Magnitude
                    if dist <= TargetESPVariables.maxRadius then
                        if isVisible(root, player.Character) then
                            local screenPos, onScreen = camera:WorldToViewportPoint(root.Position)
                            if onScreen then
                                local screenDist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                                if screenDist < closestToCenter and screenDist < 250 then
                                    closestToCenter = screenDist
                                    bestTarget = player
                                end
                            end
                        end
                    end
                end
            end
        end
    end
    TargetESPVariables.currentTarget = bestTarget
    if TargetESPVariables.currentTarget and TargetESPVariables.currentTarget.Character then
        local char = TargetESPVariables.currentTarget.Character
        local targetPart = getRootPart(char) or getHeadPart(char)
        local hum = char:FindFirstChildOfClass("Humanoid")
        if targetPart and hum and hum.Health > 0 then
            local screenPos, onScreen = camera:WorldToViewportPoint(targetPart.Position)
            if onScreen then
                TargetESPVariables.rotation = (TargetESPVariables.rotation + 140 * dt) % 360
                TargetESPVariables.texture.Rotation = TargetESPVariables.rotation
                TargetESPVariables.texture.Image = TargetESPVariables.asset
                if TargetESPVariables.rainbow then
                    TargetESPVariables.texture.ImageColor3 = Color3.fromHSV((tick() * 0.5) % 1, 0.8, 1)
                else
                    TargetESPVariables.texture.ImageColor3 = TargetESPVariables.color
                end
                local dist = (targetPart.Position - camera.CFrame.Position).Magnitude
                local scale = math.clamp(1 - (dist / 60), 0.6, 1.4)
                local calculatedSize = math.floor(TargetESPVariables.size * scale)
                TargetESPVariables.frame.Size = UDim2.new(0, calculatedSize, 0, calculatedSize)
                TargetESPVariables.frame.Position = UDim2.new(0, screenPos.X - calculatedSize / 2, 0, screenPos.Y - calculatedSize / 2)
                TargetESPVariables.frame.Visible = true
            else
                TargetESPVariables.frame.Visible = false
            end
        else
            TargetESPVariables.frame.Visible = false
        end
    else
        TargetESPVariables.frame.Visible = false
    end
end)

local HitsoundData = {
    enabled = false,
    selectedGunshot = "RPGS Candy",
    selectedKnifeKill = "Golden Knife Kill",
    hooked = {},
    gunshotSounds = {
        ["Alchemist Burst"] = "rbxassetid://130507807370367",
        ["RPGS Candy"]      = "rbxassetid://83995181532586",
        ["RPGE Beary"]      = "rbxassetid://112424028680133",
        ["DB Bloss"]        = "rbxassetid://97681259004692",
        ["Rev Blossom"]     = "rbxassetid://118868788824782",
        ["Kawaii DG"]       = "rbxassetid://135458839245691",
        ["Hit Basic 3"]     = "rbxassetid://90160800327080",
        ["Bameware"]        = "rbxassetid://3124331820",
        ["Bell"]            = "rbxassetid://6534947240",
        ["Bubble"]          = "rbxassetid://6534947588",
        ["Pick"]            = "rbxassetid://1347140027",
        ["Pop"]             = "rbxassetid://198598793",
        ["Rust"]            = "rbxassetid://1255040462",
        ["Sans"]            = "rbxassetid://3188795283",
        ["Fart"]            = "rbxassetid://130833677",
        ["Big"]             = "rbxassetid://5332005053",
        ["Vine"]            = "rbxassetid://5332680810",
        ["Bruh"]            = "rbxassetid://4578740568",
        ["Skeet"]           = "rbxassetid://5633695679",
        ["Neverlose"]       = "rbxassetid://6534948092",
        ["Fatality"]        = "rbxassetid://6534947869",
        ["Bonk"]            = "rbxassetid://5766898159",
        ["Minecraft"]       = "rbxassetid://4018616850",
        ["Call of Duty"]    = "rbxassetid://5952120301",
        ["Bat"]             = "rbxassetid://3333907347",
        ["Saber"]           = "rbxassetid://8415678813",
        ["Notif"]           = "rbxassetid://6696469190",
        ["Shutter"]         = "rbxassetid://10066921516",
        ["RIFK7"]           = "rbxassetid://9102080552",
        ["LazerBeam"]       = "rbxassetid://130791043",
        ["WindowsXPError"]  = "rbxassetid://160715357",
        ["BowHit"]          = "rbxassetid://1053296915",
        ["Bow"]             = "rbxassetid://3442683707",
        ["OSU"]             = "rbxassetid://7147454322",
        ["Old Fatality"]    = "rbxassetid://6607142036",
        ["TF2"]             = "rbxassetid://2868331684",
        ["BulletDeflect"]   = "rbxassetid://1657157666",
        ["UwU"]             = "rbxassetid://8679659744",
        ["Cod"]             = "rbxassetid://160432334",
    },
    knifeKillSounds = {
        ["S3 Coin Hit"]         = "rbxassetid://139857881082762",
        ["Custom Hit 1"]        = "rbxassetid://138592514473573",
        ["Golden Knife Kill"]   = "rbxassetid://6066375795",
        ["Among Us"]            = "rbxassetid://130456049552264",
        ["Jeff Laugh"]          = "rbxassetid://140445930084397",
        ["Pelmeni"]             = "rbxassetid://130226230760992",
        ["Horror Kill"]         = "rbxassetid://128741351184513",
        ["Jeff Stab"]           = "rbxassetid://81483362340487",
        ["Bameware"]            = "rbxassetid://3124331820",
        ["Bell"]                = "rbxassetid://6534947240",
        ["Bubble"]              = "rbxassetid://6534947588",
        ["Pick"]                = "rbxassetid://1347140027",
        ["Pop"]                 = "rbxassetid://198598793",
        ["Rust"]                = "rbxassetid://1255040462",
        ["Sans"]                = "rbxassetid://3188795283",
        ["Fart"]                = "rbxassetid://130833677",
        ["Big"]                 = "rbxassetid://5332005053",
        ["Vine"]                = "rbxassetid://5332680810",
        ["Bruh"]                = "rbxassetid://4578740568",
        ["Skeet"]               = "rbxassetid://5633695679",
        ["Neverlose"]           = "rbxassetid://6534948092",
        ["Fatality"]            = "rbxassetid://6534947869",
        ["Bonk"]                = "rbxassetid://5766898159",
        ["Minecraft"]           = "rbxassetid://4018616850",
        ["Call of Duty"]        = "rbxassetid://5952120301",
        ["Bat"]                 = "rbxassetid://3333907347",
        ["Saber"]               = "rbxassetid://8415678813",
        ["Notif"]               = "rbxassetid://6696469190",
        ["Shutter"]             = "rbxassetid://10066921516",
        ["RIFK7"]               = "rbxassetid://9102080552",
        ["LazerBeam"]           = "rbxassetid://130791043",
        ["WindowsXPError"]      = "rbxassetid://160715357",
        ["BowHit"]              = "rbxassetid://1053296915",
        ["Bow"]                 = "rbxassetid://3442683707",
        ["OSU"]                 = "rbxassetid://7147454322",
        ["Old Fatality"]        = "rbxassetid://6607142036",
        ["TF2"]                 = "rbxassetid://2868331684",
        ["BulletDeflect"]       = "rbxassetid://1657157666",
        ["UwU"]                 = "rbxassetid://8679659744",
        ["Cod"]                 = "rbxassetid://160432334",
    },
}

local function hookSound(sound)
    if not sound:IsA("Sound") or HitsoundData.hooked[sound] then return end
    HitsoundData.hooked[sound] = true
    sound.Played:Connect(function()
        if sound.Name == "Gunshot" and HitsoundData.selectedGunshot and HitsoundData.selectedGunshot ~= "None" and HitsoundData.gunshotSounds[HitsoundData.selectedGunshot] and sound.SoundId ~= HitsoundData.gunshotSounds[HitsoundData.selectedGunshot] then
            sound.SoundId = HitsoundData.gunshotSounds[HitsoundData.selectedGunshot]
            sound.TimePosition = 0
            sound:Play()
        elseif sound.Name == "Kill" and HitsoundData.selectedKnifeKill and HitsoundData.selectedKnifeKill ~= "None" and HitsoundData.knifeKillSounds[HitsoundData.selectedKnifeKill] and sound.SoundId ~= HitsoundData.knifeKillSounds[HitsoundData.selectedKnifeKill] then
            sound.SoundId = HitsoundData.knifeKillSounds[HitsoundData.selectedKnifeKill]
            sound.TimePosition = 0
            sound:Play()
        end
    end)
end

workspace.DescendantAdded:Connect(function(d)
    if d:IsA("Sound") and (d.Name == "Gunshot" or d.Name == "Kill") then hookSound(d) end
end)
for _, d in ipairs(workspace:GetDescendants()) do
    if d:IsA("Sound") and (d.Name == "Gunshot" or d.Name == "Kill") then hookSound(d) end
end

local isWallHopEnabled = false
local isFlicking = false
local lastFlickTime = 0
local lastHitInstance = nil

local function performVideoFlick()
    if isFlicking then return end
    isFlicking = true
    local char = LocalPlayer.Character
    local hum = char and char:FindFirstChild("Humanoid")
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hum or not hrp then isFlicking = false return end
    hum:ChangeState(Enum.HumanoidStateType.Jumping)
    hrp.Velocity = Vector3.new(hrp.Velocity.X, 50, hrp.Velocity.Z)
    local startCFrame = camera.CFrame
    camera.CFrame = startCFrame * CFrame.Angles(0, math.rad(180), 0)
    task.wait(0.01)
    camera.CFrame = startCFrame
    isFlicking = false
end

RunService.Heartbeat:Connect(function()
    if not Config.Settings.Combat.AutoWallHop then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local raycastParams = RaycastParams.new()
    raycastParams.FilterDescendantsInstances = {char}
    raycastParams.FilterType = Enum.RaycastFilterType.Exclude
    local result = workspace:Raycast(hrp.Position, camera.CFrame.LookVector * 3, raycastParams)
    if result and result.Instance.CanCollide then
        if lastHitInstance and lastHitInstance ~= result.Instance then
            if tick() - lastFlickTime > 0.05 then
                lastFlickTime = tick()
                performVideoFlick()
            end
        end
        lastHitInstance = result.Instance
    else
        lastHitInstance = nil
    end
end)

local function IsAlive(player)
    local char = player.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
end

local grabbingGun = false
local Murder = nil

local function grabGun()
    if grabbingGun then return end
    if not IsAlive(LocalPlayer) then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not hrp then return end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    local isMurderer = (char:FindFirstChild("Knife")) or (bp and bp:FindFirstChild("Knife")) or (Murder and LocalPlayer.Name == Murder)
    if isMurderer then return end
    local function hasGun()
        local currentBp = LocalPlayer:FindFirstChild("Backpack")
        return (char:FindFirstChild("Gun") or char:FindFirstChild("Revolver")) or (currentBp and (currentBp:FindFirstChild("Gun") or currentBp:FindFirstChild("Revolver")))
    end
    if hasGun() then return end
    local gunDrop = workspace:FindFirstChild("GunDrop", true) or workspace:FindFirstChild("DroppedGun", true)
    local handle = gunDrop and (gunDrop:FindFirstChild("Handle", true) or gunDrop:FindFirstChildOfClass("Part", true) or gunDrop)
    if not handle then return end
    grabbingGun = true
    local originalCFrame = hrp.CFrame
    local targetCFrame = handle:IsA("Model") and handle:GetPivot() or handle.CFrame
    hrp.CFrame = targetCFrame * CFrame.new(0, -1, 0)
    if firetouchinterest then
        pcall(function()
            firetouchinterest(hrp, handle, 0)
            task.wait(0.02)
            firetouchinterest(hrp, handle, 1)
        end)
    end
    task.wait(0.15)
    if IsAlive(LocalPlayer) then hrp.CFrame = originalCFrame end
    grabbingGun = false
end

task.spawn(function()
    while true do
        if Config.Settings.Combat.GrabGun then pcall(grabGun) end
        task.wait(0.5)
    end
end)

local Features = {
    Connections = {},
    Highlights = {},
    OldPos = nil,
    FPDH = workspace.FallenPartsDestroyHeight,
    ShootButton = nil,
    ShootGui = nil,
    BombJumpOnCooldown = false,
}

local function addConn(conn)
    table.insert(Features.Connections, conn)
    return conn
end

local Util = {}

function Util:Tween(obj, props, duration, style, direction)
    if not obj then return end
    duration = duration or Config.Anim.Normal
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    local tween = TweenService:Create(obj, TweenInfo.new(duration, style, direction), props)
    tween:Play()
    return tween
end

function Util:Corner(obj, radius)
    local corner = Instance.new('UICorner')
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = obj
    return corner
end

function Util:Stroke(obj, thickness, color, transparency)
    local stroke = Instance.new('UIStroke')
    stroke.Thickness = thickness or 1
    stroke.Color = color or Config.Color.Accent.White
    stroke.Transparency = transparency or 0.8
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = obj
    return stroke
end

function Util:Gradient(obj, colorSeq, rotation)
    local gradient = Instance.new('UIGradient')
    gradient.Color = colorSeq or ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(1, Color3.fromRGB(180,180,180)) }
    gradient.Rotation = rotation or 90
    gradient.Parent = obj
    return gradient
end

function Util:Ripple(button)
    button.ClipsDescendants = true
    button.MouseButton1Down:Connect(function()
        local ripple = Instance.new('Frame')
        ripple.AnchorPoint = Vector2.new(0.5,0.5)
        ripple.BackgroundColor3 = Config.Color.Accent.White
        ripple.BackgroundTransparency = 0.5
        ripple.Size = UDim2.new(0,0,0,0)
        ripple.ZIndex = button.ZIndex + 100
        ripple.BorderSizePixel = 0
        local mousePos = UserInputService:GetMouseLocation()
        local buttonPos = button.AbsolutePosition
        local relPos = mousePos - buttonPos
        ripple.Position = UDim2.new(0, relPos.X, 0, relPos.Y)
        ripple.Parent = button
        Util:Corner(ripple, 999)
        local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2.5
        Util:Tween(ripple, { Size = UDim2.new(0,size,0,size), BackgroundTransparency = 1 }, 0.6, Enum.EasingStyle.Circular)
        task.delay(0.6, function() ripple:Destroy() end)
    end)
end

function Util:GetGameName()
    return game.PlaceId == 142823291 and 'MM2' or 'MMV'
end

function Util:GetPlayerName()
    local name = LocalPlayer.DisplayName or LocalPlayer.Name
    return #name > 12 and name:sub(1,10) .. '..' or name
end

function Util:Clamp(val, min, max)
    return math.max(min, math.min(max, val))
end

function Util:Round(num, decimals)
    local mult = 10 ^ (decimals or 0)
    return math.floor(num * mult + 0.5) / mult
end

local FPS = {
    frames = 0,
    lastUpdate = tick(),
    current = 60,
    history = {},
    maxHistory = 60,
}

function FPS:Update()
    self.frames = self.frames + 1
    local now = tick()
    if now - self.lastUpdate >= 0.5 then
        local instant = self.frames / (now - self.lastUpdate)
        table.insert(self.history, instant)
        if #self.history > self.maxHistory then table.remove(self.history, 1) end
        local sum = 0
        for _, fps in ipairs(self.history) do sum = sum + fps end
        self.current = math.floor(sum / #self.history)
        self.frames = 0
        self.lastUpdate = now
    end
    return self.current
end

function FPS:GetColor()
    if self.current >= 55 then return Config.Color.State.Success
    elseif self.current >= 30 then return Config.Color.State.Warning
    else return Config.Color.State.Error end
end

RunService.RenderStepped:Connect(function() FPS:Update() end)

local Snow = {
    particles = {},
    container = nil,
    active = false,
    count = 120,
}

function Snow:Create(parent)
    self.container = Instance.new('Frame')
    self.container.Name = 'SnowSystem'
    self.container.Size = UDim2.new(1,0,1,0)
    self.container.BackgroundTransparency = 1
    self.container.ClipsDescendants = true
    self.container.ZIndex = 5
    self.container.Parent = parent
    for i = 1, self.count do
        local flake = Instance.new('Frame')
        flake.AnchorPoint = Vector2.new(0.5,0.5)
        local size = math.random(2,5)
        flake.Size = UDim2.new(0,size,0,size)
        flake.Position = UDim2.new(math.random(),0,math.random(),0)
        flake.BackgroundColor3 = Config.Color.Accent.White
        flake.BackgroundTransparency = math.random(60,85)/100
        flake.BorderSizePixel = 0
        flake.ZIndex = 6
        Util:Corner(flake, 999)
        flake.Parent = self.container
        table.insert(self.particles, { frame = flake, speed = math.random(30,100)/1000, sway = math.random(10,25), offset = math.random(0,628)/100, rotation = 0, rotSpeed = math.random(-2,2) })
    end
    self.active = true
    self:Animate()
end

function Snow:Animate()
    local time = 0
    RunService.RenderStepped:Connect(function(dt)
        if not self.active then return end
        time = time + dt
        for _, p in ipairs(self.particles) do
            if not p.frame.Parent then continue end
            local pos = p.frame.Position
            local newY = pos.Y.Scale + p.speed * dt
            if newY > 1.1 then
                p.frame.Position = UDim2.new(math.random(),0,-0.1,0)
            else
                local swayX = math.sin(time * 2 + p.offset) * (p.sway / 1000)
                p.frame.Position = UDim2.new(pos.X.Scale + swayX, 0, newY, 0)
            end
            p.rotation = p.rotation + p.rotSpeed
            p.frame.Rotation = p.rotation
        end
    end)
end

function Snow:Toggle(state)
    self.active = state
    if self.container then self.container.Visible = state end
end

function Snow:Destroy()
    self.active = false
    if self.container then self.container:Destroy() end
    self.particles = {}
end

local function applyHighlight(player, color)
    local character = player.Character
    if not character then return end
    local highlight = character:FindFirstChild('Umbra_ESP')
    if not highlight then
        highlight = Instance.new('Highlight')
        highlight.Name = 'Umbra_ESP'
        highlight.FillColor = color
        highlight.OutlineColor = color
        highlight.FillTransparency = 0.5
        highlight.OutlineTransparency = 0
        highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        highlight.Parent = character
        Features.Highlights[player] = highlight
    else
        highlight.FillColor = color
        highlight.OutlineColor = color
    end
end

local function removeHighlight(player)
    local character = player.Character
    if character then
        local highlight = character:FindFirstChild('Umbra_ESP')
        if highlight then highlight:Destroy() end
    end
    Features.Highlights[player] = nil
end

local function updateESP()
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            local bp = player:FindFirstChild('Backpack')
            local hasKnife = (player.Character:FindFirstChild('Knife')) or (bp and bp:FindFirstChild('Knife'))
            local hasGun = (player.Character:FindFirstChild('Gun') or player.Character:FindFirstChild('Revolver')) or (bp and (bp:FindFirstChild('Gun') or bp:FindFirstChild('Revolver')))
            local color = nil
            if hasKnife and Config.Settings.ESP.Murder then color = Config.Settings.Colors.MurderESP
            elseif hasGun and Config.Settings.ESP.Sheriff then color = Config.Settings.Colors.SheriffESP
            elseif Config.Settings.ESP.Innocent and not hasKnife and not hasGun then color = Config.Settings.Colors.InnocentESP end
            if color then applyHighlight(player, color) else removeHighlight(player) end
        end
    end
end

task.spawn(function()
    while true do
        pcall(updateESP)
        task.wait(0.15)
    end
end)

local function setNoclip(state)
    Config.Settings.Rage.Noclip = state
end

addConn(RunService.Stepped:Connect(function()
    if not Config.Settings.Rage.Noclip then return end
    local char = LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA('BasePart') then part.CanCollide = false end
        end
    end
end))

local function flingPlayer(targetPlayer)
    local Character = LocalPlayer.Character
    local Humanoid = Character and Character:FindFirstChildOfClass('Humanoid')
    local RootPart = Humanoid and Humanoid.RootPart or (Character and Character:FindFirstChild('HumanoidRootPart'))
    local TCharacter = targetPlayer.Character
    if not TCharacter then return end
    local THumanoid = TCharacter:FindFirstChildOfClass('Humanoid')
    local TRootPart = THumanoid and THumanoid.RootPart or TCharacter:FindFirstChild('HumanoidRootPart')
    local THead = TCharacter:FindFirstChild('Head')
    local Accessory = TCharacter:FindFirstChildOfClass('Accessory')
    local Handle = Accessory and Accessory:FindFirstChild('Handle')
    if Character and Humanoid and RootPart then
        if RootPart.Velocity.Magnitude < 50 then Features.OldPos = RootPart.CFrame end
        if THumanoid and THumanoid.Sit then return end
        if THead then workspace.CurrentCamera.CameraSubject = THead
        elseif Handle then workspace.CurrentCamera.CameraSubject = Handle
        elseif THumanoid and TRootPart then workspace.CurrentCamera.CameraSubject = THumanoid end
        if not TCharacter:FindFirstChildWhichIsA('BasePart') then return end
        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9E8, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
        local SFBasePart = function(BasePart)
            local TimeToWait = 2
            local Time = tick()
            local Angle = 0
            repeat
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 50 then
                        Angle = Angle + 100
                        FPos(BasePart, CFrame.new(0,1.5,0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,-1.5,0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,1.5,0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,-1.5,0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,1.5,0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle),0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,-1.5,0) + THumanoid.MoveDirection, CFrame.Angles(math.rad(Angle),0,0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(0,1.5,THumanoid.WalkSpeed), CFrame.Angles(math.rad(90),0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,-1.5,-THumanoid.WalkSpeed), CFrame.Angles(0,0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,1.5,THumanoid.WalkSpeed), CFrame.Angles(math.rad(90),0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,-1.5,0), CFrame.Angles(math.rad(90),0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,-1.5,0), CFrame.Angles(0,0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,-1.5,0), CFrame.Angles(math.rad(90),0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,-1.5,0), CFrame.Angles(0,0,0))
                        task.wait()
                    end
                end
            until Time + TimeToWait < tick()
        end
        workspace.FallenPartsDestroyHeight = 0/0
        local BV = Instance.new('BodyVelocity')
        BV.Parent = RootPart
        BV.Velocity = Vector3.new()
        BV.MaxForce = Vector3.new(9e9,9e9,9e9)
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
        if TRootPart then SFBasePart(TRootPart)
        elseif THead then SFBasePart(THead)
        elseif Handle then SFBasePart(Handle) end
        BV:Destroy()
        Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
        workspace.CurrentCamera.CameraSubject = Humanoid
        if Features.OldPos then
            repeat
                RootPart.CFrame = Features.OldPos * CFrame.new(0,0.5,0)
                Character:SetPrimaryPartCFrame(Features.OldPos * CFrame.new(0,0.5,0))
                Humanoid:ChangeState('GettingUp')
                for _, part in pairs(Character:GetChildren()) do
                    if part:IsA('BasePart') then part.Velocity, part.RotVelocity = Vector3.new(), Vector3.new() end
                end
                task.wait()
            until (RootPart.Position - Features.OldPos.p).Magnitude < 25
            workspace.FallenPartsDestroyHeight = Features.FPDH
        end
    end
end

local function getMurderer()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local bp = p:FindFirstChild('Backpack')
            if (bp and bp:FindFirstChild('Knife')) or p.Character:FindFirstChild('Knife') then return p end
        end
    end
    return nil
end

local function getSheriff()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local bp = p:FindFirstChild('Backpack')
            local hasGun = (bp and (bp:FindFirstChild('Gun') or bp:FindFirstChild('Revolver'))) or p.Character:FindFirstChild('Gun') or p.Character:FindFirstChild('Revolver')
            if hasGun then return p end
        end
    end
    return nil
end

local function fireGun(gun, targetPosition)
    local char = LocalPlayer.Character
    local bp = LocalPlayer:FindFirstChild('Backpack')
    if gun.Parent == bp then
        char.Humanoid:EquipTool(gun)
        task.wait(0.05)
    end
    local originCF
    local gunServer = gun:FindFirstChild('GunServer')
    if gunServer then
        local attachment = gunServer:FindFirstChild('GunRaycastAttachment1') or gunServer:FindFirstChild('RaycastAttachment')
        if attachment then originCF = attachment.WorldCFrame end
    end
    if not originCF then
        local handle = gun:FindFirstChild('Handle') or gun:FindFirstChild('Gun')
        if handle and handle:IsA('BasePart') then originCF = handle.CFrame end
    end
    if not originCF then
        local hrp = char:FindFirstChild('HumanoidRootPart')
        if hrp then originCF = hrp.CFrame end
    end
    if not originCF then return end
    local shootRemote = gun:FindFirstChild('Shoot') or gun:FindFirstChild('Fire')
    if shootRemote then
        local args = { CFrame.new(originCF.Position, targetPosition), CFrame.new(targetPosition) }
        shootRemote:FireServer(unpack(args))
    else
        pcall(function()
            if ReplicatedStorage:FindFirstChild('ShootGun') then
                ReplicatedStorage.ShootGun:InvokeServer(1, targetPosition, targetPosition)
            else
                VirtualInputManager:SendMouseButtonEvent(0,0,0,true,game,1)
                task.wait(0.05)
                VirtualInputManager:SendMouseButtonEvent(0,0,0,false,game,1)
            end
        end)
    end
end

local function shootMurdererDirect()
    local char = LocalPlayer.Character
    if not char then return end
    local gun = char:FindFirstChild('Gun') or char:FindFirstChild('Revolver')
    if not gun then
        local bp = LocalPlayer:FindFirstChild('Backpack')
        gun = bp and (bp:FindFirstChild('Gun') or bp:FindFirstChild('Revolver'))
    end
    if not gun then return end
    local m = getMurderer()
    if m and m.Character and m.Character:FindFirstChild('HumanoidRootPart') then
        fireGun(gun, m.Character.HumanoidRootPart.Position)
    end
end

local shootButtonLocked = false

local function createDraggableShootButton()
    if Features.ShootGui then Features.ShootGui:Destroy() end
    local sg = Instance.new('ScreenGui')
    sg.Name = 'Umbra_ShootBtn'
    sg.ResetOnSpawn = false
    sg.IgnoreGuiInset = true
    sg.DisplayOrder = 999999
    if gethui then sg.Parent = gethui() else sg.Parent = CoreGui end
    Features.ShootGui = sg
    
    local btn = Instance.new('TextButton')
    btn.Name = 'ShootButton'
    btn.Size = UDim2.new(0, 75, 0, 75)
    btn.Position = UDim2.new(0.85, 0, 0.6, 0)
    btn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    btn.BackgroundTransparency = 0.15
    btn.BorderSizePixel = 0
    btn.Text = ''
    btn.AutoButtonColor = false
    btn.ClipsDescendants = true
    btn.ZIndex = 10
    btn.Parent = sg
    
    local corner = Instance.new('UICorner')
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = btn
    
    local stroke = Instance.new('UIStroke')
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = btn
    
    local crosshairContainer = Instance.new('Frame')
    crosshairContainer.Size = UDim2.new(1, 0, 1, 0)
    crosshairContainer.BackgroundTransparency = 1
    crosshairContainer.ZIndex = 11
    crosshairContainer.Parent = btn
    
    local lineH = Instance.new('Frame')
    lineH.Size = UDim2.new(0.5, 0, 0, 2)
    lineH.Position = UDim2.new(0.25, 0, 0.5, -1)
    lineH.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    lineH.BorderSizePixel = 0
    lineH.ZIndex = 12
    lineH.Parent = crosshairContainer
    
    local lineV = Instance.new('Frame')
    lineV.Size = UDim2.new(0, 2, 0.5, 0)
    lineV.Position = UDim2.new(0.5, -1, 0.25, 0)
    lineV.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    lineV.BorderSizePixel = 0
    lineV.ZIndex = 12
    lineV.Parent = crosshairContainer
    
    local dot = Instance.new('Frame')
    dot.Size = UDim2.new(0, 4, 0, 4)
    dot.Position = UDim2.new(0.5, -2, 0.5, -2)
    dot.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
    dot.BorderSizePixel = 0
    dot.ZIndex = 13
    local dotCorner = Instance.new('UICorner')
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
    dot.Parent = crosshairContainer
    
    local label = Instance.new('TextLabel')
    label.Size = UDim2.new(1, 0, 0, 16)
    label.Position = UDim2.new(0, 0, 0.78, 0)
    label.BackgroundTransparency = 1
    label.Text = 'SHOOT'
    label.TextColor3 = Color3.fromRGB(255, 255, 255)
    label.TextSize = 10
    label.Font = Enum.Font.GothamBold
    label.TextTransparency = 0.5
    label.ZIndex = 12
    label.Parent = crosshairContainer
    
    local dragging = false
    local dragStart = nil
    local startPos = nil
    
    local function beginDrag(input)
        if shootButtonLocked then return end
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = btn.Position
        end
    end
    
    btn.InputBegan:Connect(beginDrag)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    
    btn.MouseButton1Click:Connect(function()
        local pulse = Instance.new('Frame')
        pulse.AnchorPoint = Vector2.new(0.5,0.5)
        pulse.BackgroundColor3 = Color3.fromRGB(255,255,255)
        pulse.BackgroundTransparency = 0.6
        pulse.Size = UDim2.new(0,0,0,0)
        pulse.Position = UDim2.new(0.5,0,0.5,0)
        pulse.ZIndex = 1
        pulse.BorderSizePixel = 0
        pulse.Parent = btn
        local pulseCorner = Instance.new('UICorner')
        pulseCorner.CornerRadius = UDim.new(1,0)
        pulseCorner.Parent = pulse
        Util:Tween(pulse, { Size = UDim2.new(0,120,0,120), BackgroundTransparency = 1 }, 0.4)
        task.delay(0.4, function() pulse:Destroy() end)
        
        local char = LocalPlayer.Character
        if char then
            local gun = char:FindFirstChild('Gun') or char:FindFirstChild('Revolver')
            if not gun then
                local bp = LocalPlayer:FindFirstChild('Backpack')
                gun = bp and (bp:FindFirstChild('Gun') or bp:FindFirstChild('Revolver'))
            end
            if gun then
                local m = getMurderer()
                if m and m.Character and m.Character:FindFirstChild('HumanoidRootPart') then
                    fireGun(gun, m.Character.HumanoidRootPart.Position)
                else
                    local target = nil
                    local closest = math.huge
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            local hrp = player.Character:FindFirstChild('HumanoidRootPart')
                            local hum = player.Character:FindFirstChildOfClass('Humanoid')
                            if hrp and hum and hum.Health > 0 then
                                local dist = (hrp.Position - char.HumanoidRootPart.Position).Magnitude
                                if dist < closest then
                                    closest = dist
                                    target = player
                                end
                            end
                        end
                    end
                    if target and target.Character and target.Character:FindFirstChild('HumanoidRootPart') then
                        fireGun(gun, target.Character.HumanoidRootPart.Position)
                    end
                end
            end
        end
    end)
    
    Features.ShootButton = btn
    Features.ShootGui = sg
end

local function removeDraggableShootButton()
    if Features.ShootGui then
        Features.ShootGui:Destroy()
        Features.ShootGui = nil
        Features.ShootButton = nil
    end
end

local function executeBombJump()
    if Features.BombJumpOnCooldown then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    local hum = char:FindFirstChildOfClass('Humanoid')
    if not hrp or not hum then return end
    local hasBomb = char:FindFirstChild('FakeBomb') or (LocalPlayer:FindFirstChild('Backpack') and LocalPlayer.Backpack:FindFirstChild('FakeBomb'))
    if not hasBomb then
        pcall(function()
            local remotes = ReplicatedStorage:FindFirstChild('Remotes', true)
            if remotes then
                local extras = remotes:FindFirstChild('Extras', true)
                if extras then
                    local replicate = extras:FindFirstChild('ReplicateToy')
                    if replicate then replicate:InvokeServer('FakeBomb') end
                end
            end
        end)
        task.wait(0.3)
    end
    Features.BombJumpOnCooldown = true
    hum:ChangeState(Enum.HumanoidStateType.Jumping)
    hrp.Velocity = Vector3.new(hrp.Velocity.X, 120, hrp.Velocity.Z)
    local bomb = char:FindFirstChild('FakeBomb')
    if bomb and bomb:IsA('Tool') then pcall(function() bomb:Activate() end) end
    task.delay(1.2, function() Features.BombJumpOnCooldown = false end)
end

addConn(RunService.Heartbeat:Connect(function()
    if not Config.Settings.Combat.AntiFling then return end
    local char = LocalPlayer.Character
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA('BasePart') then
            for _, otherPlayer in ipairs(Players:GetPlayers()) do
                if otherPlayer ~= LocalPlayer and otherPlayer.Character then
                    for _, otherPart in ipairs(otherPlayer.Character:GetDescendants()) do
                        if otherPart:IsA('BasePart') then
                            pcall(function()
                                part.CanCollide = false
                                local nc = Instance.new('NoCollisionConstraint')
                                nc.Part0 = part
                                nc.Part1 = otherPart
                                nc.Parent = part
                                game:GetService('Debris'):AddItem(nc, 0.1)
                            end)
                        end
                    end
                end
            end
        end
    end
end))

local ForceFieldVariables = {
    enabled = false,
    color = Color3.fromRGB(128,128,128),
    rainbow = false,
    originalColors = {},
    connection = nil,
}

local function ForceField_Apply(char)
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA('BasePart') and part.Name ~= 'HumanoidRootPart' then
            if not ForceFieldVariables.originalColors[part] then ForceFieldVariables.originalColors[part] = part.Color end
            part.Material = Enum.Material.ForceField
            part.Color = ForceFieldVariables.rainbow and Color3.fromHSV(tick() % 5 / 5, 1, 1) or ForceFieldVariables.color
        end
    end
end

local function ForceField_Remove(char)
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA('BasePart') and ForceFieldVariables.originalColors[part] then
            part.Material = Enum.Material.Plastic
            part.Color = ForceFieldVariables.originalColors[part]
        end
    end
end

local function ForceField_Update()
    if ForceFieldVariables.enabled and LocalPlayer.Character then ForceField_Apply(LocalPlayer.Character) end
end

local function ForceField_ToggleEnabled(value)
    ForceFieldVariables.enabled = value
    if value and LocalPlayer.Character then
        ForceField_Apply(LocalPlayer.Character)
        if not ForceFieldVariables.connection then
            ForceFieldVariables.connection = RunService.Heartbeat:Connect(function()
                if ForceFieldVariables.rainbow and ForceFieldVariables.enabled and LocalPlayer.Character then
                    for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
                        if part:IsA('BasePart') and part.Material == Enum.Material.ForceField then
                            part.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
                        end
                    end
                end
            end)
        end
    else
        if LocalPlayer.Character then ForceField_Remove(LocalPlayer.Character) end
        if ForceFieldVariables.connection then
            ForceFieldVariables.connection:Disconnect()
            ForceFieldVariables.connection = nil
        end
    end
end

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    if ForceFieldVariables.enabled then ForceField_Apply(char) end
end)

print('UmbraHub Features Loaded')

local GUI = {
    ScreenGui = nil,
    TopBar = {},
    Main = { IsOpen = false, CurrentTab = 'Visuals', Blur = nil, Window = nil, Nav = {}, Content = nil },
    ToggleStates = {},
}

function GUI:Initialize()
    self.ScreenGui = Instance.new('ScreenGui')
    self.ScreenGui.Name = 'UmbraHub_' .. HttpService:GenerateGUID(false):sub(1,8)
    self.ScreenGui.ResetOnSpawn = false
    self.ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    self.ScreenGui.IgnoreGuiInset = true
    self.ScreenGui.DisplayOrder = 999999999
    if gethui then self.ScreenGui.Parent = gethui()
    elseif syn and syn.protect_gui then syn.protect_gui(self.ScreenGui) self.ScreenGui.Parent = CoreGui
    else self.ScreenGui.Parent = CoreGui end
    self:CreateTopBar()
    self:CreateMainWindow()
end

function GUI:CreateTopBar()
    local container = Instance.new('Frame')
    container.Name = 'TopBar'
    container.Size = UDim2.new(0,410,0,Config.Size.TopBar.Height)
    container.Position = UDim2.new(0,15,0,15)
    container.BackgroundTransparency = 1
    container.ZIndex = 100
    container.Parent = self.ScreenGui
    local candyBtn = self:CreateTopBarBlock('UmbraHub', 110, 0, true)
    candyBtn.MouseButton1Click:Connect(function() self:ToggleMain() end)
    candyBtn.Parent = container
    self.TopBar.CandyBtn = candyBtn
    local fpsBlock = self:CreateTopBarBlock('FPS: 60', 70, 118, false)
    fpsBlock.Parent = container
    self.TopBar.FPS = fpsBlock
    local gameBlock = self:CreateTopBarBlock(Util:GetGameName(), 110, 196, false)
    gameBlock.Parent = container
    self.TopBar.Game = gameBlock
    local playerBlock = self:CreateTopBarBlock(Util:GetPlayerName(), 120, 314, false)
    playerBlock.Parent = container
    self.TopBar.Player = playerBlock
    task.spawn(function()
        while task.wait(0.5) do
            if self.TopBar.FPS and self.TopBar.FPS.Parent then
                self.TopBar.FPS.Text = 'FPS: ' .. FPS.current
                Util:Tween(self.TopBar.FPS, { TextColor3 = FPS:GetColor() }, 0.3)
            else break end
        end
    end)
end

function GUI:CreateTopBarBlock(text, width, xPos, isButton)
    local block = Instance.new(isButton and 'TextButton' or 'TextLabel')
    block.Size = UDim2.new(0,width,0,Config.Size.TopBar.Height)
    block.Position = UDim2.new(0,xPos,0,0)
    block.BackgroundColor3 = Config.Color.Background.Primary
    block.BackgroundTransparency = 0.15
    block.BorderSizePixel = 0
    block.Font = Enum.Font.GothamBold
    block.Text = text
    block.TextColor3 = Config.Color.Text.Primary
    block.TextSize = 12
    block.ZIndex = 101
    if isButton then block.AutoButtonColor = false end
    Util:Corner(block, Config.Size.TopBar.Radius)
    Util:Stroke(block, 1, Config.Color.Accent.White, 0.8)
    local glow = Instance.new('TextLabel')
    glow.Size = UDim2.new(1,0,1,2)
    glow.Position = UDim2.new(0,0,0,1)
    glow.BackgroundTransparency = 1
    glow.Font = block.Font
    glow.Text = block.Text
    glow.TextColor3 = Config.Color.Accent.White
    glow.TextSize = block.TextSize
    glow.TextTransparency = 0.85
    glow.ZIndex = 100
    glow.Parent = block
    if isButton then
        block.MouseEnter:Connect(function()
            Util:Tween(block, { BackgroundColor3 = Config.Color.Background.Hover }, Config.Anim.Fast)
            Util:Tween(glow, { TextTransparency = 0.65 }, Config.Anim.Fast)
        end)
        block.MouseLeave:Connect(function()
            Util:Tween(block, { BackgroundColor3 = Config.Color.Background.Primary }, Config.Anim.Fast)
            Util:Tween(glow, { TextTransparency = 0.85 }, Config.Anim.Fast)
        end)
        Util:Ripple(block)
    end
    return block
end

function GUI:CreateMainWindow()
    self.Main.Blur = Instance.new('Frame')
    self.Main.Blur.Size = UDim2.new(1,0,1,0)
    self.Main.Blur.BackgroundColor3 = Color3.new(0,0,0)
    self.Main.Blur.BackgroundTransparency = 1
    self.Main.Blur.Visible = false
    self.Main.Blur.ZIndex = 50
    self.Main.Blur.Parent = self.ScreenGui
    self.Main.Window = Instance.new('Frame')
    self.Main.Window.Size = UDim2.new(0,Config.Size.Window.Width,0,Config.Size.Window.Height)
    self.Main.Window.Position = UDim2.new(0.5,-Config.Size.Window.Width/2,0.5,-Config.Size.Window.Height/2)
    self.Main.Window.BackgroundColor3 = Config.Color.Background.Main
    self.Main.Window.BackgroundTransparency = 0.1
    self.Main.Window.BorderSizePixel = 0
    self.Main.Window.Visible = false
    self.Main.Window.ZIndex = 51
    self.Main.Window.Parent = self.ScreenGui
    Util:Corner(self.Main.Window, Config.Size.Window.Radius)
    Util:Stroke(self.Main.Window, 1.5, Config.Color.Accent.White, 0.85)
    self:CreateAccentBar()
    Snow:Create(self.Main.Window)
    self:CreateTitleBar()
    self:CreateNavigation()
    self:CreateContentArea()
    self:LoadTab('Visuals')
end

function GUI:CreateAccentBar()
    local bar = Instance.new('Frame')
    bar.Name = 'AccentBar'
    bar.Size = UDim2.new(0,4,1,0)
    bar.BackgroundColor3 = Config.Color.Accent.White
    bar.BorderSizePixel = 0
    bar.ZIndex = 60
    bar.Parent = self.Main.Window
    local grad = Util:Gradient(bar, ColorSequence.new{ ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)), ColorSequenceKeypoint.new(0.5, Color3.fromRGB(200,200,200)), ColorSequenceKeypoint.new(1, Color3.fromRGB(255,255,255)) }, 90)
    task.spawn(function()
        local offset = 0
        while self.Main.Window and self.Main.Window.Parent do
            task.wait(0.03)
            offset = offset + 0.015
            if grad and grad.Parent then grad.Offset = Vector2.new(0, math.sin(offset * 2) * 0.3) else break end
        end
    end)
end

function GUI:CreateTitleBar()
    local bar = Instance.new('Frame')
    bar.Size = UDim2.new(1,0,0,45)
    bar.BackgroundTransparency = 1
    bar.ZIndex = 52
    bar.Parent = self.Main.Window
    local title = Instance.new('TextLabel')
    title.Size = UDim2.new(0,200,1,0)
    title.Position = UDim2.new(0,20,0,0)
    title.BackgroundTransparency = 1
    title.Font = Enum.Font.GothamBold
    title.Text = 'UMBRAHUB MM2'
    title.TextColor3 = Config.Color.Text.Primary
    title.TextSize = 14
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 53
    title.Parent = bar
    local version = Instance.new('TextLabel')
    version.Size = UDim2.new(0,120,1,0)
    version.Position = UDim2.new(0,160,0,0)
    version.BackgroundTransparency = 1
    version.Font = Enum.Font.GothamBold
    version.Text = 'v' .. Config.Version
    version.TextColor3 = Config.Color.Accent.Gray
    version.TextSize = 9
    version.TextXAlignment = Enum.TextXAlignment.Left
    version.TextTransparency = 0.4
    version.ZIndex = 53
    version.Parent = bar
    local close = Instance.new('TextButton')
    close.Size = UDim2.new(0,30,0,30)
    close.Position = UDim2.new(1,-40,0,7)
    close.BackgroundColor3 = Config.Color.Background.Secondary
    close.BackgroundTransparency = 0.3
    close.BorderSizePixel = 0
    close.Font = Enum.Font.GothamBold
    close.Text = 'X'
    close.TextColor3 = Config.Color.Text.Primary
    close.TextSize = 14
    close.AutoButtonColor = false
    close.ZIndex = 54
    close.Parent = bar
    Util:Corner(close, 6)
    Util:Stroke(close, 1, Config.Color.Accent.White, 0.8)
    close.MouseEnter:Connect(function() Util:Tween(close, { BackgroundColor3 = Config.Color.State.Error }, Config.Anim.Fast) end)
    close.MouseLeave:Connect(function() Util:Tween(close, { BackgroundColor3 = Config.Color.Background.Secondary }, Config.Anim.Fast) end)
    close.MouseButton1Click:Connect(function() self:ToggleMain() end)
    Util:Ripple(close)
    local div = Instance.new('Frame')
    div.Size = UDim2.new(1,-20,0,1)
    div.Position = UDim2.new(0,10,1,-1)
    div.BackgroundColor3 = Config.Color.Accent.White
    div.BackgroundTransparency = 0.9
    div.BorderSizePixel = 0
    div.ZIndex = 52
    div.Parent = bar
end

function GUI:CreateNavigation()
    local nav = Instance.new('Frame')
    nav.Size = UDim2.new(0,Config.Size.Nav.Width,1,-65)
    nav.Position = UDim2.new(0,15,0,55)
    nav.BackgroundTransparency = 1
    nav.ZIndex = 52
    nav.Parent = self.Main.Window
    local tabs = { {name='Visuals',icon='V'}, {name='Combat',icon='C'}, {name='Rage',icon='R'}, {name='Fun',icon='F'}, {name='Settings',icon='S'}, {name='Misc',icon='M'} }
    local yPos = 0
    for i, tab in ipairs(tabs) do
        local btn = self:CreateNavButton(tab.name, tab.icon, yPos, i == 1)
        btn.Parent = nav
        self.Main.Nav[tab.name] = btn
        yPos = yPos + Config.Size.Nav.ButtonHeight + Config.Size.Nav.Spacing
    end
end

function GUI:CreateNavButton(name, icon, yPos, isActive)
    local btn = Instance.new('TextButton')
    btn.Name = name
    btn.Size = UDim2.new(1,0,0,Config.Size.Nav.ButtonHeight)
    btn.Position = UDim2.new(0,0,0,yPos)
    btn.BackgroundColor3 = isActive and Config.Color.Background.Active or Config.Color.Background.Secondary
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Text = ''
    btn.ZIndex = 53
    Util:Corner(btn, Config.Size.Nav.Radius)
    Util:Stroke(btn, 0.5, Config.Color.Accent.White, 0.92)
    local indicator = Instance.new('Frame')
    indicator.Name = 'Indicator'
    indicator.Size = UDim2.new(0,3,1,-10)
    indicator.Position = UDim2.new(0,2,0,5)
    indicator.BackgroundColor3 = Config.Color.Accent.White
    indicator.BorderSizePixel = 0
    indicator.Visible = isActive
    indicator.ZIndex = 54
    Util:Corner(indicator, 999)
    indicator.Parent = btn
    local iconLbl = Instance.new('TextLabel')
    iconLbl.Size = UDim2.new(0,25,1,0)
    iconLbl.Position = UDim2.new(0,12,0,0)
    iconLbl.BackgroundTransparency = 1
    iconLbl.Font = Enum.Font.GothamBold
    iconLbl.Text = icon
    iconLbl.TextColor3 = Config.Color.Text.Primary
    iconLbl.TextSize = 14
    iconLbl.ZIndex = 54
    iconLbl.Parent = btn
    local textLbl = Instance.new('TextLabel')
    textLbl.Size = UDim2.new(1,-45,1,0)
    textLbl.Position = UDim2.new(0,40,0,0)
    textLbl.BackgroundTransparency = 1
    textLbl.Font = Enum.Font.GothamMedium
    textLbl.Text = name
    textLbl.TextColor3 = Config.Color.Text.Primary
    textLbl.TextSize = 11
    textLbl.TextXAlignment = Enum.TextXAlignment.Left
    textLbl.ZIndex = 54
    textLbl.Parent = btn
    local glow = Instance.new('TextLabel')
    glow.Size = textLbl.Size
    glow.Position = UDim2.new(0,40,0,1)
    glow.BackgroundTransparency = 1
    glow.Font = textLbl.Font    glow.Text = textLbl.Text
    glow.TextColor3 = Config.Color.Accent.White
    glow.TextSize = textLbl.TextSize
    glow.TextXAlignment = textLbl.TextXAlignment
    glow.TextTransparency = 0.92
    glow.ZIndex = 53
    glow.Parent = btn
    btn.MouseEnter:Connect(function()
        if self.Main.CurrentTab ~= name then
            Util:Tween(btn, { BackgroundColor3 = Config.Color.Background.Hover }, Config.Anim.Fast)
            Util:Tween(glow, { TextTransparency = 0.75 }, Config.Anim.Fast)
        end
    end)
    btn.MouseLeave:Connect(function()
        if self.Main.CurrentTab ~= name then
            Util:Tween(btn, { BackgroundColor3 = Config.Color.Background.Secondary }, Config.Anim.Fast)
            Util:Tween(glow, { TextTransparency = 0.92 }, Config.Anim.Fast)
        end
    end)
    btn.MouseButton1Click:Connect(function() self:SwitchTab(name) end)
    Util:Ripple(btn)
    return btn
end

function GUI:CreateContentArea()
    self.Main.Content = Instance.new('ScrollingFrame')
    self.Main.Content.Size = UDim2.new(1,-(Config.Size.Nav.Width+40),1,-75)
    self.Main.Content.Position = UDim2.new(0,Config.Size.Nav.Width+20,0,60)
    self.Main.Content.BackgroundTransparency = 1
    self.Main.Content.BorderSizePixel = 0
    self.Main.Content.ScrollBarThickness = 5
    self.Main.Content.ScrollBarImageColor3 = Config.Color.Accent.White
    self.Main.Content.ScrollBarImageTransparency = 0.7
    self.Main.Content.CanvasSize = UDim2.new(0,0,0,0)
    self.Main.Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
    self.Main.Content.ScrollingDirection = Enum.ScrollingDirection.Y
    self.Main.Content.ElasticBehavior = Enum.ElasticBehavior.Never
    self.Main.Content.ZIndex = 52
    self.Main.Content.Parent = self.Main.Window
    local list = Instance.new('UIListLayout')
    list.Padding = UDim.new(0,8)
    list.SortOrder = Enum.SortOrder.LayoutOrder
    list.Parent = self.Main.Content
    local pad = Instance.new('UIPadding')
    pad.PaddingLeft = UDim.new(0,5)
    pad.PaddingRight = UDim.new(0,10)
    pad.PaddingTop = UDim.new(0,5)
    pad.PaddingBottom = UDim.new(0,5)
    pad.Parent = self.Main.Content
    list:GetPropertyChangedSignal('AbsoluteContentSize'):Connect(function()
        local contentHeight = list.AbsoluteContentSize.Y + 10
        local viewHeight = self.Main.Content.AbsoluteSize.Y
        if contentHeight <= viewHeight then
            self.Main.Content.CanvasSize = UDim2.new(0,0,0,0)
            self.Main.Content.CanvasPosition = Vector2.new(0,0)
        else
            self.Main.Content.CanvasSize = UDim2.new(0,0,0,contentHeight)
        end
    end)
end

function GUI:SwitchTab(tabName)
    if self.Main.CurrentTab == tabName then return end
    for name, btn in pairs(self.Main.Nav) do
        local indicator = btn:FindFirstChild('Indicator')
        local glow = btn:FindFirstChild('TextLabel')
        if name == tabName then
            Util:Tween(btn, { BackgroundColor3 = Config.Color.Background.Active }, Config.Anim.Normal)
            if indicator then indicator.Visible = true end
            if glow then Util:Tween(glow, { TextTransparency = 0.65 }, Config.Anim.Fast) end
        else
            Util:Tween(btn, { BackgroundColor3 = Config.Color.Background.Secondary }, Config.Anim.Normal)
            if indicator then indicator.Visible = false end
            if glow then Util:Tween(glow, { TextTransparency = 0.92 }, Config.Anim.Fast) end
        end
    end
    self.Main.CurrentTab = tabName
    self:LoadTab(tabName)
end

function GUI:LoadTab(tabName)
    for _, child in ipairs(self.Main.Content:GetChildren()) do
        if not child:IsA('UIListLayout') and not child:IsA('UIPadding') then child:Destroy() end
    end
    self.Main.Content.CanvasPosition = Vector2.new(0,0)
    if tabName == 'Visuals' then self:CreateVisualsTab()
    elseif tabName == 'Combat' then self:CreateCombatTab()
    elseif tabName == 'Rage' then self:CreateRageTab()
    elseif tabName == 'Fun' then self:CreateFunTab()
    elseif tabName == 'Settings' then self:CreateSettingsTab()
    elseif tabName == 'Misc' then self:CreateMiscTab() end
end

function GUI:CreateSection(title)
    local section = Instance.new('Frame')
    section.Size = UDim2.new(1,0,0,40)
    section.BackgroundColor3 = Config.Color.Background.Secondary
    section.BackgroundTransparency = 0.4
    section.BorderSizePixel = 0
    section.AutomaticSize = Enum.AutomaticSize.Y
    section.ZIndex = 53
    section.Parent = self.Main.Content
    Util:Corner(section, 8)
    Util:Stroke(section, 1, Config.Color.Accent.White, 0.88)
    local titleLbl = Instance.new('TextLabel')
    titleLbl.Size = UDim2.new(1,-20,0,25)
    titleLbl.Position = UDim2.new(0,10,0,6)
    titleLbl.BackgroundTransparency = 1
    titleLbl.Font = Enum.Font.GothamBold
    titleLbl.Text = title
    titleLbl.TextColor3 = Config.Color.Text.Primary
    titleLbl.TextSize = 12
    titleLbl.TextXAlignment = Enum.TextXAlignment.Left
    titleLbl.ZIndex = 54
    titleLbl.Parent = section
    local container = Instance.new('Frame')
    container.Name = 'Container'
    container.Size = UDim2.new(1,-20,0,0)
    container.Position = UDim2.new(0,10,0,32)
    container.BackgroundTransparency = 1
    container.AutomaticSize = Enum.AutomaticSize.Y
    container.ZIndex = 53
    container.Parent = section
    local list = Instance.new('UIListLayout')
    list.Padding = UDim.new(0,6)
    list.Parent = container
    local pad = Instance.new('UIPadding')
    pad.PaddingBottom = UDim.new(0,8)
    pad.Parent = section
    return container
end

function GUI:CreateToggle(parent, text, default, callback)
    local stateKey = text
    if self.ToggleStates[stateKey] ~= nil then default = self.ToggleStates[stateKey] end
    local toggle = Instance.new('Frame')
    toggle.Size = UDim2.new(1,0,0,Config.Size.Element.Height)
    toggle.BackgroundColor3 = Config.Color.Background.Input
    toggle.BackgroundTransparency = 0.5
    toggle.BorderSizePixel = 0
    toggle.ZIndex = 54
    toggle.Parent = parent
    Util:Corner(toggle, 6)
    Util:Stroke(toggle, 0.5, Config.Color.Accent.White, 0.9)
    local label = Instance.new('TextLabel')
    label.Size = UDim2.new(1,-50,1,0)
    label.Position = UDim2.new(0,10,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Config.Color.Text.Primary
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 55
    label.Parent = toggle
    local btn = Instance.new('TextButton')
    btn.Size = UDim2.new(0,Config.Size.Toggle.Width,0,Config.Size.Toggle.Height)
    btn.Position = UDim2.new(1,-45,0.5,-10)
    btn.BackgroundColor3 = default and Config.Color.State.Success or Config.Color.Background.Primary
    btn.BorderSizePixel = 0
    btn.Text = ''
    btn.AutoButtonColor = false
    btn.ZIndex = 55
    btn.Parent = toggle
    Util:Corner(btn, 999)
    local dot = Instance.new('Frame')
    dot.Size = UDim2.new(0,Config.Size.Toggle.DotSize,0,Config.Size.Toggle.DotSize)
    dot.Position = default and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8)
    dot.BackgroundColor3 = Config.Color.Accent.White
    dot.BorderSizePixel = 0
    dot.ZIndex = 56
    Util:Corner(dot, 999)
    dot.Parent = btn
    local state = default
    btn.MouseButton1Click:Connect(function()
        state = not state
        self.ToggleStates[stateKey] = state
        Util:Tween(btn, { BackgroundColor3 = state and Config.Color.State.Success or Config.Color.Background.Primary }, Config.Anim.Fast)
        Util:Tween(dot, { Position = state and UDim2.new(1,-18,0.5,-8) or UDim2.new(0,2,0.5,-8) }, Config.Anim.Normal)
        if callback then pcall(callback, state) end
    end)
    return toggle
end

function GUI:CreateSlider(parent, text, min, max, default, callback)
    local slider = Instance.new('Frame')
    slider.Size = UDim2.new(1,0,0,44)
    slider.BackgroundColor3 = Config.Color.Background.Input
    slider.BackgroundTransparency = 0.5
    slider.BorderSizePixel = 0
    slider.ZIndex = 54
    slider.Parent = parent
    Util:Corner(slider, 6)
    Util:Stroke(slider, 0.5, Config.Color.Accent.White, 0.9)
    local label = Instance.new('TextLabel')
    label.Size = UDim2.new(1,-70,0,18)
    label.Position = UDim2.new(0,10,0,4)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Config.Color.Text.Primary
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 55
    label.Parent = slider
    local value = Instance.new('TextLabel')
    value.Size = UDim2.new(0,60,0,18)
    value.Position = UDim2.new(1,-68,0,4)
    value.BackgroundTransparency = 1
    value.Font = Enum.Font.GothamBold
    value.Text = tostring(default)
    value.TextColor3 = Config.Color.Accent.White
    value.TextSize = 10
    value.TextXAlignment = Enum.TextXAlignment.Right
    value.ZIndex = 55
    value.Parent = slider
    local bg = Instance.new('Frame')
    bg.Size = UDim2.new(1,-20,0,Config.Size.Slider.Height)
    bg.Position = UDim2.new(0,10,1,-14)
    bg.BackgroundColor3 = Config.Color.Background.Primary
    bg.BorderSizePixel = 0
    bg.ZIndex = 55
    Util:Corner(bg, 999)
    bg.Parent = slider
    local fill = Instance.new('Frame')
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = Config.Color.Accent.White
    fill.BorderSizePixel = 0
    fill.ZIndex = 56
    Util:Corner(fill, 999)
    fill.Parent = bg
    local handle = Instance.new('Frame')
    handle.Size = UDim2.new(0,Config.Size.Slider.HandleSize,0,Config.Size.Slider.HandleSize)
    handle.Position = UDim2.new(1,-7,0.5,-7)
    handle.BackgroundColor3 = Config.Color.Accent.White
    handle.BorderSizePixel = 0
    handle.ZIndex = 57
    Util:Corner(handle, 999)
    handle.Parent = fill
    local dragging = false
    local currentValue = default
    local function update(input)
        local absPos = bg.AbsolutePosition
        local absSize = bg.AbsoluteSize
        local x = Util:Clamp(input.Position.X - absPos.X, 0, absSize.X)
        local percent = absSize.X > 0 and (x / absSize.X) or 0
        currentValue = Util:Round(min + (max - min) * percent, 0)
        value.Text = tostring(currentValue)
        fill.Size = UDim2.new(percent, 0, 1, 0)
        if callback then pcall(callback, currentValue) end
    end
    local function beginDrag(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            update(input)
        end
    end
    bg.InputBegan:Connect(beginDrag)
    fill.InputBegan:Connect(beginDrag)
    handle.InputBegan:Connect(beginDrag)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then update(input) end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then dragging = false end
    end)
    return slider
end

function GUI:CreateButton(parent, text, callback)
    local btn = Instance.new('TextButton')
    btn.Size = UDim2.new(1,0,0,30)
    btn.BackgroundColor3 = Config.Color.Background.Secondary
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.Text = text
    btn.TextColor3 = Config.Color.Text.Primary
    btn.TextSize = 11
    btn.AutoButtonColor = false
    btn.ZIndex = 54
    btn.Parent = parent
    Util:Corner(btn, 6)
    local stroke = Util:Stroke(btn, 1, Config.Color.Accent.White, 0.85)
    btn.MouseEnter:Connect(function()
        Util:Tween(btn, { BackgroundColor3 = Config.Color.Background.Hover }, Config.Anim.Fast)
        Util:Tween(stroke, { Transparency = 0.6 }, Config.Anim.Fast)
    end)
    btn.MouseLeave:Connect(function()
        Util:Tween(btn, { BackgroundColor3 = Config.Color.Background.Secondary }, Config.Anim.Fast)
        Util:Tween(stroke, { Transparency = 0.85 }, Config.Anim.Fast)
    end)
    btn.MouseButton1Click:Connect(function() if callback then pcall(callback) end end)
    Util:Ripple(btn)
    return btn
end

function GUI:CreateColorPicker(parent, text, defaultColor, callback)
    local picker = Instance.new('Frame')
    picker.Size = UDim2.new(1,0,0,Config.Size.Element.Height)
    picker.BackgroundColor3 = Config.Color.Background.Input
    picker.BackgroundTransparency = 0.5
    picker.BorderSizePixel = 0
    picker.ZIndex = 54
    picker.Parent = parent
    Util:Corner(picker, 6)
    Util:Stroke(picker, 0.5, Config.Color.Accent.White, 0.9)
    local label = Instance.new('TextLabel')
    label.Size = UDim2.new(1,-50,1,0)
    label.Position = UDim2.new(0,10,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Config.Color.Text.Primary
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 55
    label.Parent = picker
    local colorBox = Instance.new('TextButton')
    colorBox.Size = UDim2.new(0,35,0,20)
    colorBox.Position = UDim2.new(1,-45,0.5,-10)
    colorBox.BackgroundColor3 = defaultColor
    colorBox.BorderSizePixel = 0
    colorBox.Text = ''
    colorBox.AutoButtonColor = false
    colorBox.ZIndex = 55
    Util:Corner(colorBox, 4)
    colorBox.Parent = picker
    local currentColor = defaultColor
    local expanded = false
    local presetFrame = nil
    colorBox.MouseButton1Click:Connect(function()
        if expanded and presetFrame then presetFrame:Destroy() presetFrame = nil expanded = false return end
        expanded = true
        presetFrame = Instance.new('Frame')
        presetFrame.Size = UDim2.new(1,0,0,70)
        presetFrame.BackgroundColor3 = Config.Color.Background.Secondary
        presetFrame.BackgroundTransparency = 0.2
        presetFrame.BorderSizePixel = 0
        presetFrame.ZIndex = 60
        presetFrame.Parent = parent
        Util:Corner(presetFrame, 6)
        Util:Stroke(presetFrame, 1, Config.Color.Accent.White, 0.7)
        local grid = Instance.new('UIGridLayout')
        grid.CellSize = UDim2.new(0,28,0,28)
        grid.CellPadding = UDim2.new(0,4,0,4)
        grid.FillDirectionMaxCells = 9
        grid.HorizontalAlignment = Enum.HorizontalAlignment.Center
        grid.VerticalAlignment = Enum.VerticalAlignment.Center
        grid.Parent = presetFrame
        local pad = Instance.new('UIPadding')
        pad.PaddingTop = UDim.new(0,6)
        pad.PaddingBottom = UDim.new(0,6)
        pad.PaddingLeft = UDim.new(0,6)
        pad.PaddingRight = UDim.new(0,6)
        pad.Parent = presetFrame
        for _, preset in ipairs(ColorPresets) do
            local pBtn = Instance.new('TextButton')
            pBtn.Size = UDim2.new(0,28,0,28)
            pBtn.BackgroundColor3 = preset.Color
            pBtn.BorderSizePixel = 0
            pBtn.Text = ''
            pBtn.AutoButtonColor = false
            pBtn.ZIndex = 61
            Util:Corner(pBtn, 4)
            pBtn.Parent = presetFrame
            pBtn.MouseButton1Click:Connect(function()
                currentColor = preset.Color
                colorBox.BackgroundColor3 = currentColor
                if callback then pcall(callback, currentColor) end
                if presetFrame then presetFrame:Destroy() end
                expanded = false
                presetFrame = nil
            end)
        end
    end)
    return picker
end

function GUI:CreateLabel(parent, labelText, valueText)
    local frame = Instance.new('Frame')
    frame.Size = UDim2.new(1,0,0,26)
    frame.BackgroundColor3 = Config.Color.Background.Input
    frame.BackgroundTransparency = 0.6
    frame.BorderSizePixel = 0
    frame.ZIndex = 54
    frame.Parent = parent
    Util:Corner(frame, 6)
    local label = Instance.new('TextLabel')
    label.Size = UDim2.new(0.5,-10,1,0)
    label.Position = UDim2.new(0,10,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = labelText
    label.TextColor3 = Config.Color.Text.Secondary
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 55
    label.Parent = frame
    local value = Instance.new('TextLabel')
    value.Size = UDim2.new(0.5,-10,1,0)
    value.Position = UDim2.new(0.5,0,0,0)
    value.BackgroundTransparency = 1
    value.Font = Enum.Font.GothamBold
    value.Text = valueText
    value.TextColor3 = Config.Color.Text.Primary
    value.TextSize = 10
    value.TextXAlignment = Enum.TextXAlignment.Right
    value.ZIndex = 55
    value.Parent = frame
    return frame
end

function GUI:CreateKeybindButton(parent, text, defaultKey, callback)
    local keybind = Instance.new('Frame')
    keybind.Size = UDim2.new(1,0,0,Config.Size.Element.Height)
    keybind.BackgroundColor3 = Config.Color.Background.Input
    keybind.BackgroundTransparency = 0.5
    keybind.BorderSizePixel = 0
    keybind.ZIndex = 54
    keybind.Parent = parent
    Util:Corner(keybind, 6)
    Util:Stroke(keybind, 0.5, Config.Color.Accent.White, 0.9)
    local label = Instance.new('TextLabel')
    label.Size = UDim2.new(1,-90,1,0)
    label.Position = UDim2.new(0,10,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Config.Color.Text.Primary
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 55
    label.Parent = keybind
    local btn = Instance.new('TextButton')
    btn.Size = UDim2.new(0,80,0,24)
    btn.Position = UDim2.new(1,-85,0.5,-12)
    btn.BackgroundColor3 = Config.Color.Background.Secondary
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.GothamBold
    btn.Text = defaultKey.Name
    btn.TextColor3 = Config.Color.Text.Primary
    btn.TextSize = 10
    btn.AutoButtonColor = false
    btn.ZIndex = 55
    Util:Corner(btn, 4)
    btn.Parent = keybind
    local listening = false
    btn.MouseButton1Click:Connect(function()
        if listening then return end
        listening = true
        btn.Text = '...'
        local connection
        connection = UserInputService.InputBegan:Connect(function(input, gp)
            if gp then return end
            if input.UserInputType == Enum.UserInputType.Keyboard then
                btn.Text = input.KeyCode.Name
                if callback then pcall(callback, input.KeyCode) end
                listening = false
                connection:Disconnect()
            end
        end)
    end)
    return keybind
end

function GUI:CreateDropdown(parent, text, options, defaultOption, callback)
    local dropdown = Instance.new('Frame')
    dropdown.Size = UDim2.new(1,0,0,Config.Size.Element.Height)
    dropdown.BackgroundColor3 = Config.Color.Background.Input
    dropdown.BackgroundTransparency = 0.5
    dropdown.BorderSizePixel = 0
    dropdown.ZIndex = 54
    dropdown.Parent = parent
    Util:Corner(dropdown, 6)
    Util:Stroke(dropdown, 0.5, Config.Color.Accent.White, 0.9)
    local label = Instance.new('TextLabel')
    label.Size = UDim2.new(1,-100,1,0)
    label.Position = UDim2.new(0,10,0,0)
    label.BackgroundTransparency = 1
    label.Font = Enum.Font.Gotham
    label.Text = text
    label.TextColor3 = Config.Color.Text.Primary
    label.TextSize = 10
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.ZIndex = 55
    label.Parent = dropdown
    local btn = Instance.new('TextButton')
    btn.Size = UDim2.new(0,90,0,24)
    btn.Position = UDim2.new(1,-95,0.5,-12)
    btn.BackgroundColor3 = Config.Color.Background.Secondary
    btn.BackgroundTransparency = 0.3
    btn.BorderSizePixel = 0
    btn.Font = Enum.Font.Gotham
    btn.Text = defaultOption
    btn.TextColor3 = Config.Color.Text.Primary
    btn.TextSize = 10
    btn.AutoButtonColor = false
    btn.ZIndex = 55
    Util:Corner(btn, 4)
    btn.Parent = dropdown
    local currentIndex = 1
    for i, opt in ipairs(options) do if opt == defaultOption then currentIndex = i break end end
    btn.MouseButton1Click:Connect(function()
        currentIndex = currentIndex + 1
        if currentIndex > #options then currentIndex = 1 end
        btn.Text = options[currentIndex]
        if callback then pcall(callback, options[currentIndex]) end
    end)
    return dropdown
end

function GUI:CreateVisualsTab()
    local player = self:CreateSection('Player — ESP')
    self:CreateToggle(player, 'Highlight Murder', Config.Settings.ESP.Murder, function(s) Config.Settings.ESP.Murder = s end)
    self:CreateToggle(player, 'Highlight Sheriff', Config.Settings.ESP.Sheriff, function(s) Config.Settings.ESP.Sheriff = s end)
    self:CreateToggle(player, 'Highlight Hero', Config.Settings.ESP.Hero, function(s) Config.Settings.ESP.Hero = s end)
    self:CreateToggle(player, 'Highlight Innocent', Config.Settings.ESP.Innocent, function(s) Config.Settings.ESP.Innocent = s end)
    self:CreateColorPicker(player, 'Murder ESP Color', Config.Settings.Colors.MurderESP, function(c) Config.Settings.Colors.MurderESP = c end)
    self:CreateColorPicker(player, 'Sheriff ESP Color', Config.Settings.Colors.SheriffESP, function(c) Config.Settings.Colors.SheriffESP = c end)
    self:CreateColorPicker(player, 'Innocent ESP Color', Config.Settings.Colors.InnocentESP, function(c) Config.Settings.Colors.InnocentESP = c end)
    local targetEsp = self:CreateSection('Player — Target ESP')
    self:CreateToggle(targetEsp, 'Enable Target ESP', Config.Settings.ESP.TargetESP, function(s) TargetESPVariables.enabled = s end)
    self:CreateToggle(targetEsp, 'Rainbow Mode', TargetESPVariables.rainbow, function(s) TargetESPVariables.rainbow = s end)
    self:CreateSlider(targetEsp, 'ESP Size', 20, 100, TargetESPVariables.size, function(v) TargetESPVariables.size = v end)
    self:CreateSlider(targetEsp, 'Max Radius', 10, 150, TargetESPVariables.maxRadius, function(v) TargetESPVariables.maxRadius = v end)
    self:CreateColorPicker(targetEsp, 'Target ESP Color', TargetESPVariables.color, function(c) TargetESPVariables.color = c end)
    local ffSec = self:CreateSection('Player — ForceField')
    self:CreateToggle(ffSec, 'Enable ForceField', false, function(s) ForceField_ToggleEnabled(s) end)
    self:CreateToggle(ffSec, 'Rainbow Mode', false, function(s) ForceFieldVariables.rainbow = s ForceField_Update() end)
    self:CreateColorPicker(ffSec, 'ForceField Color', ForceFieldVariables.color, function(c) ForceFieldVariables.color = c if ForceFieldVariables.enabled then ForceField_Apply(LocalPlayer.Character) end end)
    local hitsoundSec = self:CreateSection('HitSound')
    local gunshotOptions = { "None" }; for name in pairs(HitsoundData.gunshotSounds) do table.insert(gunshotOptions, name) end table.sort(gunshotOptions)
    local knifeOptions = { "None" }; for name in pairs(HitsoundData.knifeKillSounds) do table.insert(knifeOptions, name) end table.sort(knifeOptions)
    self:CreateDropdown(hitsoundSec, 'Gunshot Sound', gunshotOptions, HitsoundData.selectedGunshot, function(sound) HitsoundData.selectedGunshot = sound == "None" and nil or sound end)
    self:CreateButton(hitsoundSec, 'Preview Gunshot', function()
        if HitsoundData.selectedGunshot and HitsoundData.selectedGunshot ~= "None" and HitsoundData.gunshotSounds[HitsoundData.selectedGunshot] then
            local previewSound = Instance.new("Sound")
            previewSound.SoundId = HitsoundData.gunshotSounds[HitsoundData.selectedGunshot]
            previewSound.Volume = 0.5
            previewSound.Parent = SoundService
            previewSound:Play()
            game:GetService("Debris"):AddItem(previewSound, 3)
        end
    end)
    self:CreateDropdown(hitsoundSec, 'Knife Kill Sound', knifeOptions, HitsoundData.selectedKnifeKill, function(sound) HitsoundData.selectedKnifeKill = sound == "None" and nil or sound end)
    self:CreateButton(hitsoundSec, 'Preview Knife Kill', function()
        if HitsoundData.selectedKnifeKill and HitsoundData.selectedKnifeKill ~= "None" and HitsoundData.knifeKillSounds[HitsoundData.selectedKnifeKill] then
            local previewSound = Instance.new("Sound")
            previewSound.SoundId = HitsoundData.knifeKillSounds[HitsoundData.selectedKnifeKill]
            previewSound.Volume = 0.5
            previewSound.Parent = SoundService
            previewSound:Play()
            game:GetService("Debris"):AddItem(previewSound, 3)
        end
    end)
    self:CreateButton(hitsoundSec, 'Clear Selection', function()
        HitsoundData.selectedGunshot = "None"
        HitsoundData.selectedKnifeKill = "None"
        self:LoadTab('Visuals')
    end)
end

function GUI:CreateCombatTab()
    local shootSec = self:CreateSection('Shoot')
    self:CreateToggle(shootSec, 'Draggable Shoot Button', false, function(s)
        if s then
            createDraggableShootButton()
        else
            removeDraggableShootButton()
        end
    end)
    self:CreateToggle(shootSec, 'Lock Shoot Button Position', false, function(s)
        shootButtonLocked = s
    end)
    self:CreateButton(shootSec, 'Shoot Murderer Now', function()
        shootMurdererDirect()
    end)
    self:CreateToggle(shootSec, 'Auto Shoot Murderer', Config.Settings.Combat.AutoShoot, function(s)
        Config.Settings.Combat.AutoShoot = s
    end)
    local bombSec = self:CreateSection('Bomb Jump')
    self:CreateButton(bombSec, 'Bomb Jump', function()
        executeBombJump()
    end)
    local otherSec = self:CreateSection('Other')
    self:CreateToggle(otherSec, 'Anti Fling', Config.Settings.Combat.AntiFling, function(s)
        Config.Settings.Combat.AntiFling = s
    end)
    self:CreateToggle(otherSec, 'Anti-Void', Config.Settings.Combat.AntiVoid, function(s)
        Config.Settings.Combat.AntiVoid = s
        if s then workspace.FallenPartsDestroyHeight = -0/0 else workspace.FallenPartsDestroyHeight = Features.FPDH end
    end)
    self:CreateToggle(otherSec, 'Auto WallHop', Config.Settings.Combat.AutoWallHop, function(s)
        Config.Settings.Combat.AutoWallHop = s
    end)
    self:CreateToggle(otherSec, 'Grab Gun', Config.Settings.Combat.GrabGun, function(s)
        Config.Settings.Combat.GrabGun = s
    end)
end

function GUI:CreateRageTab()
    local rage = self:CreateSection('Rage Features')
    self:CreateToggle(rage, 'Noclip', Config.Settings.Rage.Noclip, function(s)
        setNoclip(s)
    end)
end

function GUI:CreateFunTab()
    local fling = self:CreateSection('Fling (Click Player)')
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            self:CreateButton(fling, player.DisplayName .. ' (@' .. player.Name .. ')', function()
                flingPlayer(player)
            end)
        end
    end
    self:CreateButton(fling, 'Refresh Player List', function()
        self:LoadTab('Fun')
    end)
end

function GUI:CreateSettingsTab()
    local gui = self:CreateSection('GUI Settings')
    self:CreateSlider(gui, 'Transparency', 0, 100, 10, function(v)
        if self.Main.Window then self.Main.Window.BackgroundTransparency = v/100 end
    end)
    self:CreateToggle(gui, 'Snow Effect', true, function(s)
        Snow:Toggle(s)
    end)
    local keys = self:CreateSection('Keybinds')
    self:CreateKeybindButton(keys, 'Toggle GUI', Config.Settings.Keybinds.ToggleGUI, function(key)
        Config.Settings.Keybinds.ToggleGUI = key
    end)
    self:CreateKeybindButton(keys, 'Panic Key', Config.Settings.Keybinds.PanicKey, function(key)
        Config.Settings.Keybinds.PanicKey = key
    end)
end

function GUI:CreateMiscTab()
    local util = self:CreateSection('Utilities')
    self:CreateButton(util, 'Copy Game Link', function()
        if setclipboard then setclipboard('https://www.roblox.com/games/' .. game.PlaceId) end
    end)
    self:CreateButton(util, 'Lower Graphics (Make All Plastic)', function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA('BasePart') then obj.Material = Enum.Material.Plastic end
        end
    end)
    local info = self:CreateSection('Information')
    self:CreateLabel(info, 'Developer', Config.Developer)
    self:CreateLabel(info, 'Version', Config.Version)
    self:CreateLabel(info, 'Discord', Config.Discord)
end

function GUI:ToggleMain()
    self.Main.IsOpen = not self.Main.IsOpen
    if self.Main.IsOpen then
        self.Main.Blur.Visible = true
        self.Main.Window.Visible = true
        Util:Tween(self.Main.Blur, { BackgroundTransparency = 0.2 }, Config.Anim.Slow)
        self.Main.Window.Position = UDim2.new(0.5, -Config.Size.Window.Width/2, 1.5, 0)
        Util:Tween(self.Main.Window, { Position = UDim2.new(0.5, -Config.Size.Window.Width/2, 0.5, -Config.Size.Window.Height/2) }, 0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
    else
        Util:Tween(self.Main.Blur, { BackgroundTransparency = 1 }, Config.Anim.Normal)
        Util:Tween(self.Main.Window, { Position = UDim2.new(0.5, -Config.Size.Window.Width/2, 1.5, 0) }, 0.4, Enum.EasingStyle.Back, Enum.EasingDirection.In)
        task.wait(0.4)
        self.Main.Blur.Visible = false
        self.Main.Window.Visible = false
    end
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Config.Settings.Keybinds.ToggleGUI then
        GUI:ToggleMain()
    elseif input.KeyCode == Config.Settings.Keybinds.PanicKey then
        GUI.ScreenGui:Destroy()
        Snow:Destroy()
        removeDraggableShootButton()
        for _, c in ipairs(Features.Connections) do
            pcall(function() c:Disconnect() end)
        end
    end
end)

task.spawn(function()
    while true do
        if Config.Settings.Combat.AutoShoot then
            pcall(shootMurdererDirect)
        end
        task.wait(0.12)
    end
end)

GUI:Initialize()

pcall(function()
    StarterGui:SetCore('SendNotification', {
        Title = 'UmbraHub MM2',
        Text = 'Press RightShift to open',
        Duration = 5,
    })
end)

print('UmbraHub v' .. Config.Version .. ' Loaded')
print('Game: ' .. Util:GetGameName())
print('Developer: ' .. Config.Developer)
print('Discord: ' .. Config.Discord)
print('Toggle: RightShift | Panic: End')