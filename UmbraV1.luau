repeat task.wait() until game:IsLoaded()
task.wait(0.5)
print('UmbraHub v2.0 Initializing...')

local Players = game:GetService('Players')
local RunService = game:GetService('RunService')
local UserInputService = game:GetService('UserInputService')
local TweenService = game:GetService('TweenService')
local CoreGui = game:GetService('CoreGui')
local StarterGui = game:GetService('StarterGui')
local Lighting = game:GetService('Lighting')
local ReplicatedStorage = game:GetService('ReplicatedStorage')
local VirtualInputManager = game:GetService('VirtualInputManager')
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local Rayfield = loadstring(game:HttpGet('https://raw.githubusercontent.com/shlexware/Rayfield/main/source'))()

local Config = {
    Version = '2.0',
    Developer = 'UmbraHub',
    Discord = 'discord.gg/umbra',
    Settings = {
        Keybinds = { ToggleGUI = Enum.KeyCode.RightShift, PanicKey = Enum.KeyCode.End },
        Colors = { MurderESP = Color3.fromRGB(255,0,0), SheriffESP = Color3.fromRGB(0,0,255), InnocentESP = Color3.fromRGB(0,255,0), HeroESP = Color3.fromRGB(255,250,0) },
        ESP = { Murder = true, Sheriff = true, Innocent = true, Hero = true },
        Combat = { AutoShoot = false, AntiFling = false, AntiVoid = false, AutoWallHop = false, GrabGun = false },
        Rage = { Noclip = false },
    },
}

local goldBombCD = false
local normalBombCD = false
local velocityCap = 200
local speedGlitchValue = 200
local pingPrediction = false
local fovValue = 70
local lowGraphics = false
local highGraphics = false
local gunESP = true
local espEnabled = false
local espConnection = nil
local espData = {}
local espLastUpdate = 0
local espRoles = { Murderer = true, Sheriff = true, Hero = true, Innocent = true, Self = true }
local espColors = { Murderer = Color3.fromRGB(255,40,40), Sheriff = Color3.fromRGB(40,130,255), Hero = Color3.fromRGB(255,215,0), Innocent = Color3.fromRGB(0,220,0) }
local flickActive = false
local wallHopActive = false
local speedGlitchActive = false
local speedGlitchConnection = nil
local stretchActive = false
local stretchConnection = nil
local antiFlingActive = false
local antiFlingConnection = nil
local flingActive = false
local crosshairEnabled = false
local crosshairSpin = false
local crosshairImage = nil
local crosshairSpinConnection = nil
local crosshairId = "11770890197"
local shootButtonLocked = false
local grabbingGun = false
local droppedGunHighlight = nil
local droppedGunBillboard = nil
local droppedGunMarker = nil
local skyboxOriginal = nil
local lowGraphicsParts = {}
local lowGraphicsConnection = nil
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

local Features = {
    Connections = {},
    Highlights = {},
    OldPos = nil,
    FPDH = workspace.FallenPartsDestroyHeight,
    ShootButton = nil,
    ShootGui = nil,
    BombJumpOnCooldown = false,
    GrabbingGun = false,
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

local skyboxPresets = {
    { name = 'Red', id = '98490421374360' },
    { name = 'Pink', id = '95000769820905' },
    { name = 'Pink 2', id = '82988835868087' },
    { name = 'Green', id = '5036205687' },
    { name = 'Black', id = '80807192441609' },
    { name = 'Cosmic', id = '77816282467771' },
    { name = 'Yellow', id = '2669948520' },
}

local crosshairPresets = {
    { name = 'Neon Cyan', id = '11770890197' },
    { name = 'Electric Purple', id = '11770691141' },
    { name = 'Precision Dot', id = '10878218308' },
    { name = 'Aim Cross', id = '10891594349' },
    { name = 'Blue Spec', id = '11720475063' },
    { name = 'Circle Dot', id = '10831379335' },
    { name = 'Green Hit', id = '8375241602' },
}

local function getRootPart(char)
    if not char then return nil end
    return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("LowerTorso") or char:FindFirstChild("MainPart")
end

local function getHeadPart(char)
    if not char then return nil end
    return char:FindFirstChild("Head") or char:FindFirstChild("head") or char:FindFirstChild("CameraPart")
end

local function IsAlive(player)
    local char = player.Character
    if not char then return false end
    local hum = char:FindFirstChildOfClass("Humanoid")
    return hum and hum.Health > 0
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
    btn.BackgroundColor3 = Color3.fromRGB(255,255,255)
    btn.BackgroundTransparency = 0.15
    btn.BorderSizePixel = 0
    btn.Text = ''
    btn.AutoButtonColor = false
    btn.ClipsDescendants = true
    btn.ZIndex = 10
    btn.Parent = sg

    local corner = Instance.new('UICorner')
    corner.CornerRadius = UDim.new(1,0)
    corner.Parent = btn

    local stroke = Instance.new('UIStroke')
    stroke.Color = Color3.fromRGB(255,255,255)
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = btn

    local crosshairContainer = Instance.new('Frame')
    crosshairContainer.Size = UDim2.new(1,0,1,0)
    crosshairContainer.BackgroundTransparency = 1
    crosshairContainer.ZIndex = 11
    crosshairContainer.Parent = btn

    local lineH = Instance.new('Frame')
    lineH.Size = UDim2.new(0.5,0,0,2)
    lineH.Position = UDim2.new(0.25,0,0.5,-1)
    lineH.BackgroundColor3 = Color3.fromRGB(255,255,255)
    lineH.BorderSizePixel = 0
    lineH.ZIndex = 12
    lineH.Parent = crosshairContainer

    local lineV = Instance.new('Frame')
    lineV.Size = UDim2.new(0,2,0.5,0)
    lineV.Position = UDim2.new(0.5,-1,0.25,0)
    lineV.BackgroundColor3 = Color3.fromRGB(255,255,255)
    lineV.BorderSizePixel = 0
    lineV.ZIndex = 12
    lineV.Parent = crosshairContainer

    local dot = Instance.new('Frame')
    dot.Size = UDim2.new(0,4,0,4)
    dot.Position = UDim2.new(0.5,-2,0.5,-2)
    dot.BackgroundColor3 = Color3.fromRGB(255,50,50)
    dot.BorderSizePixel = 0
    dot.ZIndex = 13
    local dotCorner = Instance.new('UICorner')
    dotCorner.CornerRadius = UDim.new(1,0)
    dotCorner.Parent = dot
    dot.Parent = crosshairContainer

    local label = Instance.new('TextLabel')
    label.Size = UDim2.new(1,0,0,16)
    label.Position = UDim2.new(0,0,0.78,0)
    label.BackgroundTransparency = 1
    label.Text = 'SHOOT'
    label.TextColor3 = Color3.fromRGB(255,255,255)
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
        TweenService:Create(pulse, TweenInfo.new(0.4), { Size = UDim2.new(0,120,0,120), BackgroundTransparency = 1 }):Play()
        task.delay(0.4, function() pulse:Destroy() end)
        shootMurdererDirect()
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

local function executeBombJumpNormal()
    if normalBombCD then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    local hum = char:FindFirstChildOfClass('Humanoid')
    if not hrp or not hum then return end
    local hasBomb = char:FindFirstChild('FakeBomb') or (LocalPlayer:FindFirstChild('Backpack') and LocalPlayer.Backpack:FindFirstChild('FakeBomb'))
    if not hasBomb then
        pcall(function()
            local remotes = ReplicatedStorage:FindFirstChild('Remotes', true)
            if remotes and remotes:FindFirstChild('Extras', true) and remotes.Extras:FindFirstChild('ReplicateToy') then
                remotes.Extras.ReplicateToy:InvokeServer('FakeBomb')
            end
        end)
        task.wait(0.3)
    end
    normalBombCD = true
    hum:ChangeState(Enum.HumanoidStateType.Jumping)
    hrp.Velocity = Vector3.new(hrp.Velocity.X, 120, hrp.Velocity.Z)
    local bomb = char:FindFirstChild('FakeBomb')
    if bomb and bomb:IsA('Tool') then pcall(function() bomb:Activate() end) end
    task.delay(21, function() normalBombCD = false end)
end

local function executeBombJumpGold()
    if goldBombCD then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    local hum = char:FindFirstChildOfClass('Humanoid')
    if not hrp or not hum then return end
    local hasBomb = char:FindFirstChild('GoldBomb') or (LocalPlayer:FindFirstChild('Backpack') and LocalPlayer.Backpack:FindFirstChild('GoldBomb'))
    if not hasBomb then
        pcall(function()
            local remotes = ReplicatedStorage:FindFirstChild('Remotes', true)
            if remotes and remotes:FindFirstChild('Extras', true) and remotes.Extras:FindFirstChild('ReplicateToy') then
                remotes.Extras.ReplicateToy:InvokeServer('GoldBomb')
            end
        end)
        task.wait(0.3)
    end
    goldBombCD = true
    hum:ChangeState(Enum.HumanoidStateType.Jumping)
    hrp.Velocity = Vector3.new(hrp.Velocity.X, 150, hrp.Velocity.Z)
    local bomb = char:FindFirstChild('GoldBomb')
    if bomb and bomb:IsA('Tool') then pcall(function() bomb:Activate() end) end
    task.delay(4, function() goldBombCD = false end)
end

local function performFlick()
    if flickActive then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    if not hrp then return end
    flickActive = true
    if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
        local startCF = hrp.CFrame
        local endCF = startCF * CFrame.Angles(0, math.rad(180), 0)
        for i = 1, 4 do
            hrp.CFrame = startCF:Lerp(endCF, i/4)
            RunService.RenderStepped:Wait()
        end
    else
        local startCam = camera.CFrame
        local lookVec = startCam.LookVector
        local targetCam = CFrame.lookAt(startCam.Position, startCam.Position + Vector3.new(-lookVec.X, lookVec.Y, -lookVec.Z))
        for i = 1, 5 do
            camera.CFrame = startCam:Lerp(targetCam, i/5)
            RunService.RenderStepped:Wait()
        end
    end
    task.wait(0.15)
    flickActive = false
end

local function performWallHop()
    if wallHopActive then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    local hum = char:FindFirstChildOfClass('Humanoid')
    if not hrp or not hum then return end
    wallHopActive = true
    if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
        local _, yRot, _ = hrp.CFrame:ToEulerAnglesYXZ()
        local targetRot = yRot - math.rad(90)
        for i = 1, 7 do
            local progress = (i/7)^2
            local currentRot = yRot + (targetRot - yRot) * progress
            hrp.CFrame = CFrame.new(hrp.Position) * CFrame.fromEulerAnglesYXZ(0, currentRot, 0)
            RunService.RenderStepped:Wait()
        end
    else
        local startCam = camera.CFrame
        local unit = Vector3.new(startCam.LookVector.X, 0, startCam.LookVector.Z).Unit
        local rightUnit = Vector3.new(startCam.RightVector.X, 0, startCam.RightVector.Z).Unit
        for i = 1, 7 do
            local progress = (i/7)^2
            local targetPos = camera.CFrame.Position + unit:Lerp(rightUnit, progress).Unit
            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetPos)
            RunService.RenderStepped:Wait()
        end
    end
    hrp.AssemblyLinearVelocity = Vector3.new(hrp.AssemblyLinearVelocity.X, 55, hrp.AssemblyLinearVelocity.Z)
    pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
    task.wait(0.12)
    if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
        local _, yRot, _ = hrp.CFrame:ToEulerAnglesYXZ()
        local startRot = yRot
        for i = 1, 5 do
            local progress = (i/5)^2
            local currentRot = startRot + (0 - startRot) * progress
            hrp.CFrame = CFrame.new(hrp.Position) * CFrame.fromEulerAnglesYXZ(0, currentRot, 0)
            RunService.RenderStepped:Wait()
        end
    else
        local startCam = camera.CFrame
        local unit = Vector3.new(startCam.LookVector.X, 0, startCam.LookVector.Z).Unit
        local rightUnit = Vector3.new(startCam.RightVector.X, 0, startCam.RightVector.Z).Unit
        for i = 1, 5 do
            local progress = (i/5)^2
            local targetPos = camera.CFrame.Position + rightUnit:Lerp(unit, progress).Unit
            camera.CFrame = CFrame.lookAt(camera.CFrame.Position, targetPos)
            RunService.RenderStepped:Wait()
        end
    end
    task.wait(0.1)
    wallHopActive = false
end

local function speedGlitchToggle()
    speedGlitchActive = not speedGlitchActive
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChildOfClass('Humanoid')
        if hum then
            if speedGlitchActive then
                if speedGlitchConnection then speedGlitchConnection:Disconnect() end
                speedGlitchConnection = RunService.RenderStepped:Connect(function()
                    local state = hum:GetState()
                    hum.WalkSpeed = (state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall) and (hum.MoveDirection.Magnitude > 0 and speedGlitchValue) or 16
                end)
            else
                if speedGlitchConnection then speedGlitchConnection:Disconnect(); speedGlitchConnection = nil end
                hum.WalkSpeed = 16
            end
        end
    end
    Rayfield:Notify({ Title = 'UmbraHub', Content = speedGlitchActive and 'Speed Glitch ON' or 'Speed Glitch OFF', Duration = 3 })
end

local function stretchToggle()
    stretchActive = not stretchActive
    if stretchActive then
        if not stretchConnection then
            stretchConnection = RunService.RenderStepped:Connect(function()
                camera.CFrame = camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, 0.5, 0, 0, 0, 1)
            end)
        end
    else
        if stretchConnection then stretchConnection:Disconnect(); stretchConnection = nil end
    end
    Rayfield:Notify({ Title = 'UmbraHub', Content = stretchActive and 'Stretch ON' or 'Stretch OFF', Duration = 3 })
end

local function antiFlingToggle(state)
    antiFlingActive = state
    if not state then
        if antiFlingConnection then antiFlingConnection:Disconnect(); antiFlingConnection = nil end
        return
    end
    if antiFlingConnection then antiFlingConnection:Disconnect() end
    antiFlingConnection = RunService.Heartbeat:Connect(function()
        if antiFlingActive then
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild('HumanoidRootPart')
            if hrp and hrp.AssemblyLinearVelocity.Magnitude > velocityCap then
                hrp.AssemblyLinearVelocity = hrp.AssemblyLinearVelocity.Unit * velocityCap
            end
        end
    end)
end

local function flingPlayer(targetPlayer)
    if flingActive then return end
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
        flingActive = true
        local FPos = function(BasePart, Pos, Ang)
            RootPart.CFrame = CFrame.new(BasePart.Position) * Pos * Ang
            Character:SetPrimaryPartCFrame(CFrame.new(BasePart.Position) * Pos * Ang)
            RootPart.Velocity = Vector3.new(9e7, 9E8, 9e7)
            RootPart.RotVelocity = Vector3.new(9e8, 9e8, 9e8)
        end
        local SFBasePart = function(BasePart)
            local TimeToWait = 2.5
            local Time = tick()
            local Angle = 0
            while tick() - Time < TimeToWait do
                if RootPart and THumanoid then
                    if BasePart.Velocity.Magnitude < 40 then
                        Angle = Angle + 100
                        FPos(BasePart, CFrame.new(0,1.5,0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,-1.5,0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,1.5,0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0,0))
                        task.wait()
                        FPos(BasePart, CFrame.new(0,-1.5,0) + THumanoid.MoveDirection * BasePart.Velocity.Magnitude / 1.25, CFrame.Angles(math.rad(Angle),0,0))
                        task.wait()
                    else
                        FPos(BasePart, CFrame.new(THumanoid.MoveDirection.X * THumanoid.WalkSpeed * 0.12, 3, THumanoid.MoveDirection.Z * THumanoid.WalkSpeed * 0.12), CFrame.Angles(1.57,0,0))
                        RootPart.Velocity = Vector3.new(9e8, 9e8, 9e8)
                        task.wait()
                        FPos(BasePart, CFrame.new(-THumanoid.MoveDirection.X * THumanoid.WalkSpeed * 0.06, -3, -THumanoid.MoveDirection.Z * THumanoid.WalkSpeed * 0.06), CFrame.Angles(0,0,0))
                        RootPart.Velocity = Vector3.new(9e8, 9e8, 9e8)
                        task.wait()
                        FPos(BasePart, CFrame.new(THumanoid.MoveDirection.X * THumanoid.WalkSpeed * 0.18, 3, THumanoid.MoveDirection.Z * THumanoid.WalkSpeed * 0.18), CFrame.Angles(1.57,0,0))
                        RootPart.Velocity = Vector3.new(9e8, 9e8, 9e8)
                        task.wait()
                        FPos(BasePart, CFrame.new(-THumanoid.MoveDirection.X * THumanoid.WalkSpeed * 0.06, -3, -THumanoid.MoveDirection.Z * THumanoid.WalkSpeed * 0.06), CFrame.Angles(0,0,0))
                        RootPart.Velocity = Vector3.new(9e8, 9e8, 9e8)
                        task.wait()
                    end
                end
            end
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
        flingActive = false
    end
end

local function flingMurderer()
    if flingActive then return end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and (player.Backpack:FindFirstChild('Knife') or player.Character:FindFirstChild('Knife')) then
            local hum = player.Character:FindFirstChildOfClass('Humanoid')
            if hum and hum.Health > 0 then
                task.spawn(flingPlayer, player)
                return
            end
        end
    end
    Rayfield:Notify({ Title = 'UmbraHub', Content = 'No knife player found!', Duration = 3 })
end

local function flingSheriff()
    if flingActive then return end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and (player.Backpack:FindFirstChild('Gun') or player.Character:FindFirstChild('Gun')) then
            local hum = player.Character:FindFirstChildOfClass('Humanoid')
            if hum and hum.Health > 0 then
                task.spawn(flingPlayer, player)
                return
            end
        end
    end
    Rayfield:Notify({ Title = 'UmbraHub', Content = 'No gun player found!', Duration = 3 })
end

local function grabGunTeleport()
    local GunDrop = workspace:FindFirstChild('GunDrop', true)
    if GunDrop then
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild('HumanoidRootPart')
        if hrp then
            local targetPos = GunDrop:IsA('BasePart') and GunDrop.Position or (GunDrop:FindFirstChild('Handle') and GunDrop.Handle.Position) or (GunDrop:FindFirstChildWhichIsA('BasePart') and GunDrop:FindFirstChildWhichIsA('BasePart').Position) or GunDrop:GetModelCFrame().Position
            if targetPos then
                local orig = hrp.CFrame
                hrp.CFrame = CFrame.new(targetPos + Vector3.new(0, 2, 0))
                task.wait(0.2)
                hrp.CFrame = orig
                Rayfield:Notify({ Title = 'UmbraHub', Content = 'Teleported to gun!', Duration = 3 })
            end
        end
    else
        Rayfield:Notify({ Title = 'UmbraHub', Content = 'No gun on map!', Duration = 3 })
    end
end

local function grabGunAuto()
    if grabbingGun then return end
    if not IsAlive(LocalPlayer) then return end
    local char = LocalPlayer.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")
    if not char or not hrp then return end
    local bp = LocalPlayer:FindFirstChild("Backpack")
    local isMurderer = (char:FindFirstChild("Knife")) or (bp and bp:FindFirstChild("Knife"))
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

local function toggleESP()
    espEnabled = not espEnabled
    if not espEnabled then
        if espConnection then espConnection:Disconnect(); espConnection = nil end
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then
                local esp = player.Character:FindFirstChild('Umbra_ESP')
                if esp then esp:Destroy() end
            end
        end
    else
        espConnection = RunService.Heartbeat:Connect(function()
            if espEnabled then
                if tick() - espLastUpdate > 0.5 then
                    local remote = ReplicatedStorage:FindFirstChild('GetCurrentPlayerData', true)
                    if remote and remote:IsA('RemoteFunction') then
                        local ok, result = pcall(function() return remote:InvokeServer() end)
                        if ok and type(result) == 'table' then espData = result end
                        espLastUpdate = tick()
                    end
                end
                for _, player in ipairs(Players:GetPlayers()) do
                    if player.Character then
                        local bp = player:FindFirstChild('Backpack')
                        local hasKnife = (player.Character:FindFirstChild('Knife')) or (bp and bp:FindFirstChild('Knife'))
                        local hasGun = (player.Character:FindFirstChild('Gun') or player.Character:FindFirstChild('Revolver')) or (bp and (bp:FindFirstChild('Gun') or bp:FindFirstChild('Revolver')))
                        local role = 'Innocent'
                        if espData and espData[player.Name] then
                            local r = (espData[player.Name].Role or espData[player.Name].role or espData[player.Name].Team or ''):lower()
                            if r:find('murd') then role = 'Murderer'
                            elseif r:find('sheriff') or r:find('gun') then role = 'Sheriff'
                            elseif r:find('hero') then role = 'Hero' end
                        end
                        local show = espRoles[role]
                        if player == LocalPlayer and not espRoles.Self then show = false end
                        if show then
                            local hl = player.Character:FindFirstChild('Umbra_ESP') or Instance.new('Highlight')
                            hl.Name = 'Umbra_ESP'
                            hl.Parent = player.Character
                            hl.FillColor = espColors[role]
                            hl.FillTransparency = 0.7
                            hl.OutlineColor = Color3.fromRGB(255,255,255)
                            hl.OutlineTransparency = 0.15
                            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        else
                            local hl = player.Character:FindFirstChild('Umbra_ESP')
                            if hl then hl:Destroy() end
                        end
                    end
                end
            end
        end)
    end
    Rayfield:Notify({ Title = 'UmbraHub', Content = espEnabled and 'ESP ON' or 'ESP OFF', Duration = 3 })
end

local function toggleDroppedGunESP(state)
    gunESP = state
    if not state then
        if droppedGunHighlight then droppedGunHighlight:Destroy(); droppedGunHighlight = nil end
        if droppedGunBillboard then droppedGunBillboard:Destroy(); droppedGunBillboard = nil end
        if droppedGunMarker then droppedGunMarker:Destroy(); droppedGunMarker = nil end
    end
    Rayfield:Notify({ Title = 'UmbraHub', Content = state and 'Gun ESP ON' or 'Gun ESP OFF', Duration = 3 })
end

local function markGun(gun)
    if not gunESP then return end
    if droppedGunHighlight then droppedGunHighlight:Destroy() end
    if droppedGunBillboard then droppedGunBillboard:Destroy() end
    if droppedGunMarker then droppedGunMarker:Destroy() end
    local hl = Instance.new('Highlight')
    hl.Adornee = gun
    hl.FillColor = Color3.fromRGB(255,215,0)
    hl.OutlineColor = Color3.fromRGB(255,255,255)
    hl.FillTransparency = 0.35
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = gun
    droppedGunHighlight = hl
    local part = gun:FindFirstChild('Handle') or (gun:IsA('Model') and gun.PrimaryPart) or gun:FindFirstChildWhichIsA('BasePart') or gun
    if part and part:IsA('BasePart') then
        local marker = Instance.new('Part')
        marker.Name = 'UmbraGunMarker'
        marker.Size = Vector3.new(1.5,0.15,1.5)
        marker.Anchored = true
        marker.CanCollide = false
        marker.CastShadow = false
        marker.Material = Enum.Material.Neon
        marker.Color = Color3.fromRGB(50,255,80)
        marker.Transparency = 0.25
        marker.CFrame = CFrame.new(part.Position + Vector3.new(0,0.1,0))
        marker.Parent = workspace
        droppedGunMarker = marker
        task.spawn(function()
            while marker and marker.Parent do
                for i = 0, 1, 0.05 do
                    if not marker or not marker.Parent then break end
                    marker.Transparency = 0.25 + 0.5 * math.sin(i * math.pi)
                    task.wait(0.03)
                end
            end
        end)
        local bill = Instance.new('BillboardGui')
        bill.Adornee = part
        bill.Size = UDim2.new(0,130,0,36)
        bill.StudsOffset = Vector3.new(0,4,0)
        bill.AlwaysOnTop = true
        bill.MaxDistance = 300
        bill.Parent = part
        local frame = Instance.new('Frame', bill)
        frame.Size = UDim2.new(1,0,1,0)
        frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
        frame.BackgroundTransparency = 0.4
        frame.BorderSizePixel = 0
        local uc = Instance.new('UICorner', frame)
        uc.CornerRadius = UDim.new(0,6)
        local stroke = Instance.new('UIStroke', frame)
        stroke.Color = Color3.fromRGB(255,215,0)
        stroke.Thickness = 1.5
        stroke.Transparency = 0.1
        local lbl = Instance.new('TextLabel', frame)
        lbl.Size = UDim2.new(1,0,1,0)
        lbl.BackgroundTransparency = 1
        lbl.Text = 'GUN ON MAP'
        lbl.TextColor3 = Color3.fromRGB(255,215,0)
        lbl.Font = Enum.Font.GothamBlack
        lbl.TextSize = 13
        lbl.TextStrokeTransparency = 0.4
        lbl.TextStrokeColor3 = Color3.fromRGB(0,0,0)
        droppedGunBillboard = bill
    end
end

local function trackGunDrops()
    local function scanFolder(folder)
        for _, child in ipairs(folder:GetChildren()) do
            if child:IsA('Model') or child:IsA('Folder') then
                scanFolder(child)
            end
        end
        local gun = folder:FindFirstChild('GunDrop', true)
        if gun then
            task.wait(0.1)
            if gunESP then markGun(gun) end
        end
    end
    workspace.ChildAdded:Connect(function(child)
        if child:IsA('Model') or child:IsA('Folder') then
            scanFolder(child)
        end
        if child.Name == 'GunDrop' then
            task.wait(0.1)
            if gunESP then
                markGun(child)
                Rayfield:Notify({ Title = 'UmbraHub', Content = 'Gun dropped on the map!', Duration = 3 })
            end
        end
    end)
    for _, child in ipairs(workspace:GetChildren()) do
        if child:IsA('Model') or child:IsA('Folder') then
            scanFolder(child)
        end
        if child.Name == 'GunDrop' then
            task.wait(0.1)
            if gunESP then markGun(child) end
        end
    end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            task.spawn(function()
                player.CharacterAdded:Connect(function(char)
                    local hum = char:WaitForChild('Humanoid', 5)
                    if hum then
                        hum.Died:Connect(function()
                            if player.Backpack:FindFirstChild('Gun') or char:FindFirstChild('Gun') then
                                task.delay(0.8, function()
                                    local gun = workspace:FindFirstChild('GunDrop', true)
                                    if gun and gunESP then
                                        markGun(gun)
                                        Rayfield:Notify({ Title = 'UmbraHub', Content = 'Gun dropped on the map!', Duration = 3 })
                                    end
                                end)
                            end
                        end)
                    end
                end)
            end, player)
        end
    end
end

local function lowGraphicsToggle(state)
    if state then
        lowGraphics = true
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
        pcall(function() setfpscap(9999) end)
        Lighting.GlobalShadows = false
        Lighting.Brightness = 2
        for _, descendant in ipairs(workspace:GetDescendants()) do
            pcall(function()
                if descendant:IsA('BasePart') then
                    if not lowGraphicsParts[descendant] then
                        lowGraphicsParts[descendant] = { Material = descendant.Material, CastShadow = descendant.CastShadow }
                    end
                    descendant.Material = Enum.Material.SmoothPlastic
                    descendant.CastShadow = false
                end
                if descendant:IsA('Decal') or descendant:IsA('Texture') then
                    if not lowGraphicsParts[descendant] then
                        lowGraphicsParts[descendant] = { Transparency = descendant.Transparency }
                    end
                    descendant.Transparency = 1
                end
            end)
        end
        if lowGraphicsConnection then lowGraphicsConnection:Disconnect() end
        lowGraphicsConnection = workspace.DescendantAdded:Connect(function(d)
            task.wait(0.1)
            pcall(function()
                if d:IsA('BasePart') then
                    if not lowGraphicsParts[d] then lowGraphicsParts[d] = { Material = d.Material, CastShadow = d.CastShadow } end
                    d.Material = Enum.Material.SmoothPlastic
                    d.CastShadow = false
                end
                if d:IsA('Decal') or d:IsA('Texture') then
                    if not lowGraphicsParts[d] then lowGraphicsParts[d] = { Transparency = d.Transparency } end
                    d.Transparency = 1
                end
            end)
        end)
        Rayfield:Notify({ Title = 'UmbraHub', Content = 'Low Graphics ON', Duration = 3 })
    else
        lowGraphics = false
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
        Lighting.GlobalShadows = defaultLighting.GlobalShadows
        Lighting.Brightness = defaultLighting.Brightness
        Lighting.Ambient = defaultLighting.Ambient
        Lighting.OutdoorAmbient = defaultLighting.OutdoorAmbient
        if lowGraphicsConnection then lowGraphicsConnection:Disconnect(); lowGraphicsConnection = nil end
        for k, v in pairs(lowGraphicsParts) do
            pcall(function()
                if k and k.Parent then
                    for k2, v2 in pairs(v) do k[k2] = v2 end
                end
            end)
        end
        lowGraphicsParts = {}
        Rayfield:Notify({ Title = 'UmbraHub', Content = 'Low Graphics OFF', Duration = 3 })
    end
end

local function highGraphicsToggle(state)
    if state then
        if lowGraphics then lowGraphicsToggle(false) end
        highGraphics = true
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level21 end)
        Lighting.GlobalShadows = true
        Lighting.Brightness = 3.5
        Lighting.Ambient = Color3.fromRGB(80,80,100)
        Lighting.OutdoorAmbient = Color3.fromRGB(100,110,130)
        local bloom = Lighting:FindFirstChildOfClass('BloomEffect') or Instance.new('BloomEffect', Lighting)
        bloom.Intensity = 0.6
        bloom.Size = 24
        bloom.Threshold = 0.95
        local sunRays = Lighting:FindFirstChildOfClass('SunRaysEffect') or Instance.new('SunRaysEffect', Lighting)
        sunRays.Intensity = 0.25
        sunRays.Spread = 1
        local colorCorr = Lighting:FindFirstChildOfClass('ColorCorrectionEffect') or Instance.new('ColorCorrectionEffect', Lighting)
        colorCorr.Saturation = 0.2
        colorCorr.Contrast = 0.1
        colorCorr.Brightness = 0.05
        Rayfield:Notify({ Title = 'UmbraHub', Content = 'High Graphics ON', Duration = 3 })
    else
        highGraphics = false
        pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
        Lighting.Brightness = defaultLighting.Brightness
        Lighting.GlobalShadows = defaultLighting.GlobalShadows
        Lighting.Ambient = defaultLighting.Ambient
        Lighting.OutdoorAmbient = defaultLighting.OutdoorAmbient
        for _, child in pairs(Lighting:GetChildren()) do
            if child:IsA('BloomEffect') or child:IsA('SunRaysEffect') or child:IsA('ColorCorrectionEffect') then
                child:Destroy()
            end
        end
        Rayfield:Notify({ Title = 'UmbraHub', Content = 'High Graphics OFF', Duration = 3 })
    end
end

local function applySkybox(id)
    for _, child in pairs(Lighting:GetChildren()) do
        if child:IsA('Sky') or child:IsA('Atmosphere') or child:IsA('Clouds') then
            child:Destroy()
        end
    end
    local sky = Instance.new('Sky', Lighting)
    sky.Name = 'UmbraHub_CustomSky'
    local url = 'rbxassetid://' .. tostring(id)
    sky.SkyboxBk = url
    sky.SkyboxDn = url
    sky.SkyboxFt = url
    sky.SkyboxLf = url
    sky.SkyboxRt = url
    sky.SkyboxUp = url
    sky.SunTextureId = ''
    sky.MoonTextureId = ''
    sky.SunAngularSize = 0
    sky.StarCount = 0
    Lighting.ClockTime = 14
    Lighting.Brightness = 2
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
end

local function restoreSkybox()
    if skyboxOriginal then
        for _, child in pairs(Lighting:GetChildren()) do
            if child:IsA('Sky') or child:IsA('Atmosphere') or child:IsA('Clouds') then
                child:Destroy()
            end
        end
        local sky = Instance.new('Sky', Lighting)
        for k, v in pairs(skyboxOriginal) do sky[k] = v end
    end
    Rayfield:Notify({ Title = 'UmbraHub', Content = 'Skybox restored', Duration = 3 })
end

local function setCrosshair(state)
    crosshairEnabled = state
    if not state then
        local rcd = CoreGui:FindFirstChild('UmbraCrosshairDisplay')
        if rcd then rcd:Destroy() end
        if crosshairSpinConnection then crosshairSpinConnection:Disconnect(); crosshairSpinConnection = nil end
        UserInputService.MouseIconEnabled = true
        Rayfield:Notify({ Title = 'UmbraHub', Content = 'Crosshair OFF', Duration = 3 })
        return
    end
    local rcd = CoreGui:FindFirstChild('UmbraCrosshairDisplay')
    if rcd then rcd:Destroy() end
    if crosshairSpinConnection then crosshairSpinConnection:Disconnect(); crosshairSpinConnection = nil end
    local sg = Instance.new('ScreenGui', CoreGui)
    sg.Name = 'UmbraCrosshairDisplay'
    sg.ResetOnSpawn = false
    sg.DisplayOrder = 25
    sg.IgnoreGuiInset = true
    crosshairImage = Instance.new('ImageLabel', sg)
    crosshairImage.AnchorPoint = Vector2.new(0.5,0.5)
    crosshairImage.Position = UDim2.new(0.5,0,0.5,0)
    crosshairImage.Size = UDim2.new(0,42,0,42)
    crosshairImage.BackgroundTransparency = 1
    crosshairImage.Image = 'rbxassetid://' .. crosshairId
    crosshairImage.ZIndex = 10
    crosshairImage.Visible = false
    RunService.RenderStepped:Connect(function()
        if crosshairImage and crosshairImage.Parent then
            local visible = crosshairEnabled and (UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter)
            crosshairImage.Visible = visible
            UserInputService.MouseIconEnabled = not visible
            local pg = LocalPlayer:FindFirstChild('PlayerGui')
            if pg then
                local gt = pg:FindFirstChild('GameTopbar')
                if gt and gt:FindFirstChild('Crosshair') then
                    gt.Crosshair.Visible = false
                end
            end
        end
    end)
    if crosshairSpin then
        if crosshairSpinConnection then crosshairSpinConnection:Disconnect() end
        crosshairSpinConnection = RunService.RenderStepped:Connect(function()
            if crosshairImage and crosshairImage.Parent and crosshairImage.Visible then
                crosshairImage.Rotation = crosshairImage.Rotation + 4
            end
        end)
    end
    Rayfield:Notify({ Title = 'UmbraHub', Content = 'Crosshair ON', Duration = 3 })
end

local function setCrosshairSpin(state)
    crosshairSpin = state
    if state then
        if crosshairSpinConnection then crosshairSpinConnection:Disconnect() end
        crosshairSpinConnection = RunService.RenderStepped:Connect(function()
            if crosshairImage and crosshairImage.Parent and crosshairImage.Visible then
                crosshairImage.Rotation = crosshairImage.Rotation + 4
            end
        end)
    else
        if crosshairSpinConnection then crosshairSpinConnection:Disconnect(); crosshairSpinConnection = nil end
    end
end

local function setCrosshairID(newId)
    crosshairId = newId
    if crosshairEnabled and crosshairImage then
        crosshairImage.Image = 'rbxassetid://' .. newId
    end
end

local function setSkyboxID(newId)
    applySkybox(newId)
end

local Window = Rayfield:CreateWindow({
    Name = 'UmbraHub',
    Icon = 0,
    LoadingTitle = 'UmbraHub',
    LoadingSubtitle = 'by Umbra Team',
    ConfigurationSaving = { Enabled = true, FileName = 'UmbraHub' },
    Discord = { Enabled = true, Invite = 'umbra' },
    Keybinds = { Enabled = true, ToggleKey = Enum.KeyCode.RightShift, HoldToggle = false },
})

local MainTab = Window:CreateTab('Main', 0)
local EspTab = Window:CreateTab('ESP', 1)
local VisualsTab = Window:CreateTab('Visuals', 2)
local SettingsTab = Window:CreateTab('Settings', 3)

local mainSection = MainTab:CreateSection('Buttons')
MainTab:CreateToggle({ Name = 'Show Shoot Button', CurrentValue = false, Callback = function(v) if v then createDraggableShootButton() else removeDraggableShootButton() end end })
MainTab:CreateToggle({ Name = 'Lock Shoot Button', CurrentValue = false, Callback = function(v) shootButtonLocked = v end })
MainTab:CreateButton({ Name = 'Shoot/Throw (Aimlock)', Callback = shootMurdererDirect })
MainTab:CreateToggle({ Name = 'Auto Shoot', CurrentValue = false, Callback = function(v) Config.Settings.Combat.AutoShoot = v end })
MainTab:CreateButton({ Name = 'Bomb Jump (Normal)', Callback = executeBombJumpNormal })
MainTab:CreateButton({ Name = 'Bomb Jump (Gold)', Callback = executeBombJumpGold })
MainTab:CreateButton({ Name = 'Flick (180)', Callback = performFlick })
MainTab:CreateButton({ Name = 'Wall Hop', Callback = performWallHop })
MainTab:CreateButton({ Name = 'Grab Gun (Teleport)', Callback = grabGunTeleport })
MainTab:CreateButton({ Name = 'Fling Murderer', Callback = flingMurderer })
MainTab:CreateButton({ Name = 'Fling Sheriff', Callback = flingSheriff })
MainTab:CreateToggle({ Name = 'Auto Grab Gun', CurrentValue = false, Callback = function(v) Config.Settings.Combat.GrabGun = v end })

local combatSection = MainTab:CreateSection('Combat')
MainTab:CreateToggle({ Name = 'Anti-Fling', CurrentValue = false, Callback = antiFlingToggle })
MainTab:CreateToggle({ Name = 'Anti-Void', CurrentValue = false, Callback = function(v) Config.Settings.Combat.AntiVoid = v; workspace.FallenPartsDestroyHeight = v and -0/0 or Features.FPDH end })
MainTab:CreateToggle({ Name = 'Noclip', CurrentValue = false, Callback = function(v) Config.Settings.Rage.Noclip = v end })
MainTab:CreateToggle({ Name = 'Ping Prediction', CurrentValue = false, Callback = function(v) pingPrediction = v end })
MainTab:CreateSlider({ Name = 'Velocity Cap', Min = 50, Max = 500, Value = 200, Callback = function(v) velocityCap = v end })
MainTab:CreateSlider({ Name = 'Speed Glitch Value', Min = 50, Max = 600, Value = 200, Callback = function(v) speedGlitchValue = v end })
MainTab:CreateButton({ Name = 'Toggle Speed Glitch', Callback = speedGlitchToggle })

local espSection = EspTab:CreateSection('ESP Settings')
EspTab:CreateToggle({ Name = 'Enable ESP', CurrentValue = false, Callback = toggleESP })
EspTab:CreateToggle({ Name = 'Show Murderer', CurrentValue = true, Callback = function(v) espRoles.Murderer = v end })
EspTab:CreateToggle({ Name = 'Show Sheriff', CurrentValue = true, Callback = function(v) espRoles.Sheriff = v end })
EspTab:CreateToggle({ Name = 'Show Hero', CurrentValue = true, Callback = function(v) espRoles.Hero = v end })
EspTab:CreateToggle({ Name = 'Show Innocents', CurrentValue = true, Callback = function(v) espRoles.Innocent = v end })
EspTab:CreateToggle({ Name = 'Show Self', CurrentValue = true, Callback = function(v) espRoles.Self = v end })
EspTab:CreateColorPicker({ Name = 'Murderer Color', CurrentValue = Color3.fromRGB(255,40,40), Callback = function(c) espColors.Murderer = c end })
EspTab:CreateColorPicker({ Name = 'Sheriff Color', CurrentValue = Color3.fromRGB(40,130,255), Callback = function(c) espColors.Sheriff = c end })
EspTab:CreateColorPicker({ Name = 'Hero Color', CurrentValue = Color3.fromRGB(255,215,0), Callback = function(c) espColors.Hero = c end })
EspTab:CreateColorPicker({ Name = 'Innocent Color', CurrentValue = Color3.fromRGB(0,220,0), Callback = function(c) espColors.Innocent = c end })
EspTab:CreateToggle({ Name = 'Dropped Gun ESP', CurrentValue = true, Callback = toggleDroppedGunESP })

local visualSection = VisualsTab:CreateSection('Visual Settings')
VisualsTab:CreateSlider({ Name = 'FOV', Min = 30, Max = 120, Value = 70, Callback = function(v) fovValue = v; camera.FieldOfView = v end })
VisualsTab:CreateButton({ Name = 'Reset FOV', Callback = function() fovValue = 70; camera.FieldOfView = 70; Rayfield:Notify({ Title = 'UmbraHub', Content = 'FOV reset to 70', Duration = 3 }) end })
VisualsTab:CreateToggle({ Name = 'Stretch', CurrentValue = false, Callback = stretchToggle })
VisualsTab:CreateToggle({ Name = 'Low Graphics', CurrentValue = false, Callback = lowGraphicsToggle })
VisualsTab:CreateToggle({ Name = 'High Graphics', CurrentValue = false, Callback = highGraphicsToggle })
VisualsTab:CreateToggle({ Name = 'Crosshair', CurrentValue = false, Callback = setCrosshair })
VisualsTab:CreateToggle({ Name = 'Crosshair Spin', CurrentValue = false, Callback = setCrosshairSpin })

for _, preset in ipairs(crosshairPresets) do
    VisualsTab:CreateButton({ Name = 'Crosshair: ' .. preset.name, Callback = function() setCrosshairID(preset.id); Rayfield:Notify({ Title = 'UmbraHub', Content = 'Crosshair: ' .. preset.name, Duration = 3 }) end })
end

for _, preset in ipairs(skyboxPresets) do
    VisualsTab:CreateButton({ Name = 'Skybox: ' .. preset.name, Callback = function() setSkyboxID(preset.id); Rayfield:Notify({ Title = 'UmbraHub', Content = 'Skybox: ' .. preset.name, Duration = 3 }) end })
end

VisualsTab:CreateButton({ Name = 'Restore Skybox', Callback = restoreSkybox })

local settingsSection = SettingsTab:CreateSection('Settings')
SettingsTab:CreateKeybind({ Name = 'Toggle GUI', CurrentValue = Enum.KeyCode.RightShift, Callback = function(k) Config.Settings.Keybinds.ToggleGUI = k end })
SettingsTab:CreateKeybind({ Name = 'Panic Key', CurrentValue = Enum.KeyCode.End, Callback = function(k) Config.Settings.Keybinds.PanicKey = k end })

UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Config.Settings.Keybinds.PanicKey then
        Rayfield:Destroy()
        removeDraggableShootButton()
        for _, c in ipairs(Features.Connections) do pcall(function() c:Disconnect() end) end
    end
end)

task.spawn(function()
    while true do
        if Config.Settings.Combat.AutoShoot then pcall(shootMurdererDirect) end
        task.wait(0.12)
    end
end)

task.spawn(function()
    while true do
        if Config.Settings.Combat.GrabGun then pcall(grabGunAuto) end
        task.wait(0.5)
    end
end)

trackGunDrops()

LocalPlayer.CharacterAdded:Connect(function(char)
    task.wait(1)
    if speedGlitchActive then
        local hum = char:FindFirstChildOfClass('Humanoid')
        if hum then
            if speedGlitchConnection then speedGlitchConnection:Disconnect() end
            speedGlitchConnection = RunService.RenderStepped:Connect(function()
                local state = hum:GetState()
                hum.WalkSpeed = (state == Enum.HumanoidStateType.Jumping or state == Enum.HumanoidStateType.Freefall) and (hum.MoveDirection.Magnitude > 0 and speedGlitchValue) or 16
            end)
        end
    end
end)

Rayfield:Notify({ Title = 'UmbraHub', Content = 'Loaded successfully! Press RightShift to open menu', Duration = 5 })
print('UmbraHub v2.0 Loaded')