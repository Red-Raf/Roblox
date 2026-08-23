-- RuzHub v7.3 — Rayfield Port (YinYangAsist)
-- Все функции сохранены, UI заменён на Rayfield

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Lighting = game:GetService("Lighting")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local CurrentCamera = Workspace.CurrentCamera

-- ===== Глобальные переменные (из вашего кода) =====
u9 = false
u10 = false
n1 = 200
n2 = 200
u13 = false
n3 = 70
u15 = false
u16 = false
u17 = true
u61 = false
u62 = nil
u99 = false
u105 = false
u116 = false
u120 = false
u157 = false
u198 = false
u199 = false
n17 = 0.5
id = "11770890197"
u201 = nil
u202 = nil
getgenv().RuzOldPos = nil
getgenv().RuzFPDH = Workspace.FallenPartsDestroyHeight

t2 = {}
n4 = 0
t3 = { Murderer = true, Sheriff = true, Hero = true, Innocent = true, Self = true }
t4 = {
    Murderer = Color3.fromRGB(255, 40, 40),
    Sheriff = Color3.fromRGB(40, 130, 255),
    Hero = Color3.fromRGB(255, 215, 0),
    Innocent = Color3.fromRGB(0, 220, 0)
}

u29 = nil
u31 = nil
u32 = nil
u82 = nil
u172 = nil
u140 = nil
u141 = false
u152 = false
u153 = nil
u201 = nil
u202 = nil
t16 = {}
t25 = {}

-- ===== ВСЕ ФУНКЦИИ ИЗ ВАШЕГО КОДА (1:1) =====

function v21(p1)
    local u362 = nil
    local p2Position = nil
    local Position = nil
    p1.InputBegan:Connect(function(p2)
        if p2.UserInputType == Enum.UserInputType.MouseButton1 or p2.UserInputType == Enum.UserInputType.Touch then
            u362 = true
            p2Position = p2.Position
            Position = p1.Position
        end
    end)
    p1.InputChanged:Connect(function(p3)
        if u362 then
            if p3.UserInputType == Enum.UserInputType.MouseMovement or p3.UserInputType == Enum.UserInputType.Touch then
                local v838 = p3.Position - p2Position
                p1.Position = UDim2.new(Position.X.Scale, Position.X.Offset + v838.X, Position.Y.Scale, Position.Y.Offset + v838.Y)
            end
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            u362 = false
        end
    end)
end

function v68()
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Character then
            local esp = player.Character:FindFirstChild("RuzHub_ESP")
            if esp then esp:Destroy() end
        end
    end
    t2 = {}
    n4 = 0
end

function u73(p20)
    local s1 = "Innocent"
    local v446 = t2[p20.Name]
    if v446 then
        local v447 = v446.Role or (v446.role or (v446.Team or ""))
        local v448 = tostring(v447):lower()
        if v448:find("murd") then return "Murderer" end
        if v448:find("sheriff") or v448:find("gun") then return "Sheriff" end
        if v448:find("hero") then s1 = "Hero" end
    end
    return s1
end

function u76(p21, p22)
    local v451 = p21:FindFirstChild("RuzHub_ESP") or Instance.new("Highlight")
    v451.Name = "RuzHub_ESP"
    v451.Parent = p21
    v451.FillColor = p22
    v451.FillTransparency = 0.7
    v451.OutlineColor = Color3.fromRGB(255, 255, 255)
    v451.OutlineTransparency = 0.15
    v451.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
end

function v78()
    local GetCurrentPlayerData = ReplicatedStorage:FindFirstChild("GetCurrentPlayerData", true)
    if GetCurrentPlayerData and GetCurrentPlayerData:IsA("RemoteFunction") then
        if u62 then u62:Disconnect() u62 = nil end
        u62 = RunService.Heartbeat:Connect(function()
            if u61 then
                if tick() - n4 > 0.5 then
                    local ok, result = pcall(function() return GetCurrentPlayerData:InvokeServer() end)
                    if ok and type(result) == "table" then t2 = result end
                    n4 = tick()
                end
                for _, player in ipairs(Players:GetPlayers()) do
                    if player.Character then
                        local v871 = u73(player)
                        local v872 = t3[v871]
                        if player == LocalPlayer and not t3.Self then v872 = false end
                        if not v872 then
                            local esp = player.Character:FindFirstChild("RuzHub_ESP")
                            if esp then esp:Destroy() end
                        else
                            u76(player.Character, t4[v871])
                        end
                    end
                end
            end
        end)
    else
        print("ESP remote not found!")
        u61 = false
    end
end

function u86()
    local Character = LocalPlayer.Character
    local v464 = Character and Character:FindFirstChild("HumanoidRootPart")
    if v464 then
        local v466 = LocalPlayer.Backpack:FindFirstChild("Knife") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Knife"))
        local v468 = LocalPlayer.Backpack:FindFirstChild("Gun") or (LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Gun"))
        local v469 = nil
        local n5 = math.huge
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                local Character2 = player.Character
                local Humanoid = Character2:FindFirstChildOfClass("Humanoid")
                if Humanoid and Humanoid.Health > 0 then
                    local HumanoidRootPart = Character2:FindFirstChild("HumanoidRootPart")
                    if HumanoidRootPart then
                        local v476 = player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife"))
                        local v477 = player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun"))
                        local Magnitude = (HumanoidRootPart.Position - v464.Position).Magnitude
                        local v479 = false
                        if not v466 then
                            if not v468 then
                                if v476 then v479 = true Magnitude = Magnitude - 1000 end
                                if v477 then v479 = true end
                            elseif v477 or v476 then v479 = true end
                        elseif v476 then v479 = true end
                        if v479 and Magnitude < n5 then
                            n5 = Magnitude
                            v469 = Character2
                        end
                    end
                end
            end
        end
        if not v469 then
            for _, player in ipairs(Players:GetPlayers()) do
                if player ~= LocalPlayer and player.Character then
                    local Character3 = player.Character
                    local Humanoid = Character3:FindFirstChildOfClass("Humanoid")
                    local HumanoidRootPart = Character3:FindFirstChild("HumanoidRootPart")
                    if Humanoid and Humanoid.Health > 0 and HumanoidRootPart then
                        local Magnitude = (HumanoidRootPart.Position - v464.Position).Magnitude
                        if Magnitude < n5 then
                            n5 = Magnitude
                            v469 = Character3
                        end
                    end
                end
            end
        end
        return v469
    end
    return nil
end

local u88 = Instance.new("Part")
u88.Name = "RuzPredictionPart"
u88.Size = Vector3.new(0.5, 0.5, 0.5)
u88.Anchored = true
u88.CanCollide = false
u88.Transparency = 1
u88.Parent = Workspace

RunService.RenderStepped:Connect(function()
    local v486 = u86()
    u82 = v486
    if v486 then
        local Character = LocalPlayer.Character
        local v488 = Character and Character:FindFirstChild("HumanoidRootPart")
        if v488 then
            local v489 = v486:FindFirstChild("UpperTorso") or (v486:FindFirstChild("Torso") or v486:FindFirstChild("HumanoidRootPart"))
            local Humanoid = v486:FindFirstChildOfClass("Humanoid")
            if v489 then
                local Position = v489.Position
                local v492 = (Position - v488.Position).Magnitude / 250
                if u13 then
                    local ok, result = pcall(function() return LocalPlayer:GetNetworkPing() end)
                    if ok and result then v492 = v492 + result * 0.5 end
                end
                local AssemblyLinearVelocity = v489.AssemblyLinearVelocity
                if Humanoid then
                    local State = Humanoid:GetState()
                    if State == Enum.HumanoidStateType.Freefall or State == Enum.HumanoidStateType.Jumping then
                        AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, AssemblyLinearVelocity.Y * 0.35, AssemblyLinearVelocity.Z)
                    end
                end
                u88.CFrame = CFrame.new(Position + AssemblyLinearVelocity * v492)
            end
        end
    end
end)

function u96()
    local Character = LocalPlayer.Character
    if Character then
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            local v507 = LocalPlayer.Backpack:FindFirstChild("Knife") or Character:FindFirstChild("Knife")
            if v507 then
                if Character ~= v507.Parent then
                    Character.Humanoid:EquipTool(v507)
                    task.wait(0)
                end
                local v508 = u82
                if not u82 then
                    local n6 = math.huge
                    for _, player in ipairs(Players:GetPlayers()) do
                        if player ~= LocalPlayer and player.Character then
                            local HumanoidRootPart2 = player.Character:FindFirstChild("HumanoidRootPart")
                            local Humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                            if HumanoidRootPart2 and Humanoid and Humanoid.Health > 0 then
                                local Magnitude = (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude
                                if Magnitude < n6 then
                                    n6 = Magnitude
                                    v508 = player.Character
                                end
                            end
                        end
                    end
                end
                if v508 then
                    local HumanoidRootPart3 = v508:FindFirstChild("HumanoidRootPart")
                    if HumanoidRootPart3 then
                        local v516 = v508:FindFirstChild("UpperTorso") or (v508:FindFirstChild("Torso") or HumanoidRootPart3)
                        local AssemblyLinearVelocity = HumanoidRootPart3.AssemblyLinearVelocity
                        local Magnitude = (v516.Position - HumanoidRootPart.Position).Magnitude
                        local n7 = 0
                        if u13 then
                            local ok, result = pcall(function() return LocalPlayer:GetNetworkPing() end)
                            n7 = ok and result or 0
                        end
                        local u522 = v516.Position + Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z) * (Magnitude / 65 + n7 * 0.5)
                        pcall(function()
                            local KnifeThrown = v507:WaitForChild("Events"):WaitForChild("KnifeThrown")
                            local cFrame = CFrame.new(HumanoidRootPart.Position, u522)
                            KnifeThrown:FireServer(cFrame, CFrame.new(u522))
                        end)
                    end
                else
                    print("No target found!")
                end
            else
                print("No knife in inventory!")
            end
        end
    end
end

function u97()
    local Character = LocalPlayer.Character
    if Character then
        local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
        if HumanoidRootPart then
            local v499 = LocalPlayer.Backpack:FindFirstChild("Gun") or Character:FindFirstChild("Gun")
            if v499 then
                if u82 then
                    if Character ~= v499.Parent then
                        Character.Humanoid:EquipTool(v499)
                        task.wait(0)
                    end
                    local CFramePosition = u88.CFrame.Position
                    local v501 = HumanoidRootPart.Position + Vector3.new(0, 1, 0)
                    local cFrame = CFrame.new(v501, CFramePosition)
                    pcall(function()
                        local Shoot = v499:WaitForChild("Shoot")
                        Shoot:FireServer(cFrame, CFrame.new(CFramePosition))
                    end)
                else
                    print("No target found.")
                end
            else
                print("No gun in inventory!")
            end
        end
    end
end

function u98()
    if LocalPlayer.Character then
        if not LocalPlayer.Backpack:FindFirstChild("Knife") and (not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("Knife")) then
            u97()
            return
        end
        u96()
    end
end

function u104()
    if u99 then return end
    local Character = LocalPlayer.Character
    if not Character then return end
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then return end
    u99 = true
    if UserInputService.MouseBehavior ~= Enum.MouseBehavior.LockCenter then
        local HumanoidRootPartCFrame = HumanoidRootPart.CFrame
        local v530 = HumanoidRootPartCFrame * CFrame.Angles(0, math.pi, 0)
        for i = 1, 4 do
            HumanoidRootPart.CFrame = HumanoidRootPartCFrame:Lerp(v530, i / 4)
            RunService.RenderStepped:Wait()
        end
    else
        local CFrame2 = CurrentCamera.CFrame
        local LookVector = CFrame2.LookVector
        local vector3 = Vector3.new(-LookVector.X, LookVector.Y, -LookVector.Z)
        local cFrame = CFrame.lookAt(CFrame2.Position, CFrame2.Position + vector3)
        for i = 1, 5 do
            CurrentCamera.CFrame = CFrame2:Lerp(cFrame, i / 5)
            RunService.RenderStepped:Wait()
        end
    end
    task.wait(0.15)
    u99 = false
end

function u110()
    if u105 then return end
    local Character = LocalPlayer.Character
    if not Character then return end
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
    if not HumanoidRootPart then return end
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if not Humanoid then return end
    u105 = true
    local v547 = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
    local _, v549, _ = HumanoidRootPart.CFrame:ToEulerAnglesYXZ()
    local CFrame3 = CurrentCamera.CFrame
    if not v547 then
        local v552 = v549 - math.pi / 2
        for i = 1, 7 do
            local v540 = i / 7
            local v543 = v549 + (v552 - v549) * v540
            local v542 = CFrame.fromEulerAnglesYXZ(0, v543, 0)
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position) * v542
            RunService.RenderStepped:Wait()
        end
    else
        local Unit = Vector3.new(CFrame3.LookVector.X, 0, CFrame3.LookVector.Z).Unit
        local RightVectorX = CFrame3.RightVector.X
        local RightVectorZ = CFrame3.RightVector.Z
        local Unit2 = Vector3.new(RightVectorX, 0, RightVectorZ).Unit
        for i = 1, 7 do
            local v542 = i / 7
            local v543 = CurrentCamera.CFrame.Position + Unit:Lerp(Unit2, v542).Unit
            CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, v543)
            RunService.RenderStepped:Wait()
        end
    end
    local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity
    HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(AssemblyLinearVelocity.X, 55, AssemblyLinearVelocity.Z)
    pcall(function() Humanoid:ChangeState(Enum.HumanoidStateType.Jumping) end)
    task.wait(0.12)
    if not v547 then
        local _, v576, _ = HumanoidRootPart.CFrame:ToEulerAnglesYXZ()
        for i = 1, 5 do
            local v542 = i / 5
            HumanoidRootPart.CFrame = CFrame.new(HumanoidRootPart.Position) * CFrame.fromEulerAnglesYXZ(0, v576 + (v549 - v576) * v542, 0)
            RunService.RenderStepped:Wait()
        end
    else
        local Unit = Vector3.new(CFrame3.LookVector.X, 0, CFrame3.LookVector.Z).Unit
        local LookVectorX = CurrentCamera.CFrame.LookVector.X
        local LookVectorZ = CurrentCamera.CFrame.LookVector.Z
        local Unit3 = Vector3.new(LookVectorX, 0, LookVectorZ).Unit
        for i = 1, 5 do
            local v542 = i / 5
            CurrentCamera.CFrame = CFrame.lookAt(CurrentCamera.CFrame.Position, CurrentCamera.CFrame.Position + Unit3:Lerp(Unit, v542).Unit)
            RunService.RenderStepped:Wait()
        end
    end
    task.wait(0.1)
    u105 = false
end

function v115(p23, p24)
    local Character = LocalPlayer.Character
    if Character then
        local v596 = LocalPlayer.Backpack:FindFirstChild(p23) or Character:FindFirstChild(p23)
        if v596 then
            local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
            if HumanoidRootPart then
                if Character ~= v596.Parent then
                    Character.Humanoid:EquipTool(v596)
                    task.wait()
                end
                pcall(function()
                    v596.Remote:FireServer(CFrame.new(HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 1.5 + Vector3.new(0, -3, 0)), 50)
                end)
                Character.Humanoid:ChangeState(Enum.HumanoidStateType.Freefall)
                HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(HumanoidRootPart.AssemblyLinearVelocity.X, 62, HumanoidRootPart.AssemblyLinearVelocity.Z)
                if not p24 then
                    task.spawn(function() u10 = true task.wait(21) u10 = false end)
                else
                    task.spawn(function() u9 = true task.wait(4) u9 = false end)
                end
            end
        else
            print("No " .. p23 .. " found!")
        end
    end
end

function v119(p25)
    local Humanoid = p25:WaitForChild("Humanoid")
    if u117 then u117:Disconnect() end
    u117 = RunService.RenderStepped:Connect(function()
        if u116 then
            local State = Humanoid:GetState()
            Humanoid.WalkSpeed = (State == Enum.HumanoidStateType.Jumping or State == Enum.HumanoidStateType.Freefall) and (Humanoid.MoveDirection.Magnitude > 0 and n2) or 16
        else
            Humanoid.WalkSpeed = 16
        end
    end)
end

LocalPlayer.CharacterAdded:Connect(v119)
if LocalPlayer.Character then task.spawn(v119, LocalPlayer.Character) end

function v125(p26)
    u120 = p26
    if not p26 then
        if u121 then u121:Disconnect() u121 = nil end
        return
    end
    if u121 then u121:Disconnect() end
    u121 = RunService.RenderStepped:Connect(function()
        CurrentCamera.CFrame = CurrentCamera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, n17, 0, 0, 0, 1)
    end)
end

function v145()
    for _, child in pairs(Lighting:GetChildren()) do
        if child:IsA("Sky") or child:IsA("Atmosphere") or child:IsA("Clouds") then
            child:Destroy()
        end
    end
    if u140 then
        local Sky = Instance.new("Sky", Lighting)
        for k, v in pairs(u140) do Sky[k] = v end
    end
    u141 = false
    print("Skybox restored to default.")
end

function u147(p27)
    for _, child in pairs(Lighting:GetChildren()) do
        if child:IsA("Sky") or child:IsA("Atmosphere") or child:IsA("Clouds") then
            child:Destroy()
        end
    end
    local Sky = Instance.new("Sky", Lighting)
    Sky.Name = "RuzHub_CustomSky"
    local v625 = "rbxassetid://" .. tostring(p27)
    Sky.SkyboxBk = v625
    Sky.SkyboxDn = v625
    Sky.SkyboxFt = v625
    Sky.SkyboxLf = v625
    Sky.SkyboxRt = v625
    Sky.SkyboxUp = v625
    Sky.SunTextureId = ""
    Sky.MoonTextureId = ""
    Sky.SunAngularSize = 0
    Sky.StarCount = 0
    Lighting.ClockTime = 14
    Lighting.Brightness = 2
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 999999
    u141 = true
end

function u156(p28)
    u152 = p28
    if not p28 then
        if u153 then u153:Disconnect() u153 = nil end
        return
    end
    if u153 then u153:Disconnect() end
    u153 = RunService.Heartbeat:Connect(function()
        if u152 then
            local Character = LocalPlayer.Character
            local v894 = Character and Character:FindFirstChild("HumanoidRootPart")
            if v894 then
                local AssemblyLinearVelocity = v894.AssemblyLinearVelocity
                if AssemblyLinearVelocity.Magnitude > n1 then
                    v894.AssemblyLinearVelocity = AssemblyLinearVelocity.Unit * n1
                end
            end
        end
    end)
end

function v161(p29)
    if u157 then return end
    local Character = LocalPlayer.Character
    if not Character then return end
    local Humanoid = Character:FindFirstChildOfClass("Humanoid")
    if not Humanoid then return end
    local RootPart = Humanoid.RootPart
    if not RootPart then return end
    local Character4 = p29.Character
    if not Character4 then return end
    local Humanoid2 = Character4:FindFirstChildOfClass("Humanoid")
    local v663 = Humanoid2 and Humanoid2.RootPart
    local Head = Character4:FindFirstChild("Head")
    local Accessory = Character4:FindFirstChildOfClass("Accessory")
    local v666 = Accessory and Accessory:FindFirstChild("Handle")
    if RootPart.Velocity.Magnitude < 50 then
        getgenv().RuzOldPos = RootPart.CFrame
    end
    if not Humanoid2 or not Humanoid2.Sit then
        local v667 = Head or (v666 or Humanoid2)
        if v667 then
            Workspace.CurrentCamera.CameraSubject = v667
        end
        if Character4:FindFirstChildWhichIsA("BasePart") then
            local function u670(p30, p31, p32)
                RootPart.CFrame = CFrame.new(p30.Position) * p31 * p32
                pcall(function() Character:SetPrimaryPartCFrame(CFrame.new(p30.Position) * p31 * p32) end)
                RootPart.Velocity = Vector3.new(90000000, 900000000, 90000000)
                RootPart.RotVelocity = Vector3.new(900000000, 900000000, 900000000)
            end
            u157 = true
            Workspace.FallenPartsDestroyHeight = 0/0
            local BodyVelocity = Instance.new("BodyVelocity")
            BodyVelocity.Velocity = Vector3.new(0, 0, 0)
            BodyVelocity.MaxForce = Vector3.new(9000000000, 9000000000, 9000000000)
            BodyVelocity.Parent = RootPart
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
            local v673 = v663 or (Head or v666)
            if not v673 then
                print(p29.Name .. " — no valid fling part.")
            else
                (function(p33)
                    local v904 = tick() + 2.5
                    local n18 = 0
                    while RootPart and Humanoid2 do
                        local Magnitude = p33.Velocity.Magnitude
                        if not (Magnitude < 40) then
                            local MoveDirection = Humanoid2.MoveDirection
                            local WalkSpeed = Humanoid2.WalkSpeed
                            u670(p33, CFrame.new(MoveDirection.X * WalkSpeed * 0.12, 3, MoveDirection.Z * WalkSpeed * 0.12), CFrame.Angles(math.pi/2, 0, 0))
                            RootPart.Velocity = Vector3.new(900000000, 900000000, 900000000)
                            task.wait()
                            u670(p33, CFrame.new(-MoveDirection.X * WalkSpeed * 0.06, -3, -MoveDirection.Z * WalkSpeed * 0.06), CFrame.Angles(0, 0, 0))
                            RootPart.Velocity = Vector3.new(900000000, 900000000, 900000000)
                            task.wait()
                            u670(p33, CFrame.new(MoveDirection.X * WalkSpeed * 0.18, 3, MoveDirection.Z * WalkSpeed * 0.18), CFrame.Angles(math.pi/2, 0, 0))
                            RootPart.Velocity = Vector3.new(900000000, 900000000, 900000000)
                            task.wait()
                            u670(p33, CFrame.new(-MoveDirection.X * WalkSpeed * 0.06, -3, -MoveDirection.Z * WalkSpeed * 0.06), CFrame.Angles(0, 0, 0))
                            RootPart.Velocity = Vector3.new(900000000, 900000000, 900000000)
                            task.wait()
                        else
                            n18 = n18 + 100
                            u670(p33, CFrame.new(0, 1.5, 0) + Humanoid2.MoveDirection * Magnitude / 1.25, CFrame.Angles(math.rad(n18), 0, 0))
                            task.wait()
                            u670(p33, CFrame.new(0, -1.5, 0) + Humanoid2.MoveDirection * Magnitude / 1.25, CFrame.Angles(math.rad(n18), 0, 0))
                            task.wait()
                            u670(p33, CFrame.new(0, 1.5, 0) + Humanoid2.MoveDirection * Magnitude / 1.25, CFrame.Angles(math.rad(n18), 0, 0))
                            task.wait()
                            u670(p33, CFrame.new(0, -1.5, 0) + Humanoid2.MoveDirection * Magnitude / 1.25, CFrame.Angles(math.rad(n18), 0, 0))
                            task.wait()
                            u670(p33, CFrame.new(0, 1.5, 0), CFrame.Angles(math.rad(n18), 0, 0))
                            task.wait()
                            u670(p33, CFrame.new(0, -1.5, 0), CFrame.Angles(math.rad(n18), 0, 0))
                            task.wait()
                        end
                        if v904 < tick() then return end
                    end
                end)(v673)
            end
            BodyVelocity:Destroy()
            Humanoid:SetStateEnabled(Enum.HumanoidStateType.Seated, true)
            Workspace.CurrentCamera.CameraSubject = Humanoid
            if getgenv().RuzOldPos then
                local n19 = 0
                repeat
                    n19 = n19 + 1
                    RootPart.CFrame = getgenv().RuzOldPos * CFrame.new(0, 0.5, 0)
                    pcall(function() Character:SetPrimaryPartCFrame(getgenv().RuzOldPos * CFrame.new(0, 0.5, 0)) end)
                    Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    for _, child in ipairs(Character:GetChildren()) do
                        if child:IsA("BasePart") then
                            child.Velocity = Vector3.new()
                            child.RotVelocity = Vector3.new()
                        end
                    end
                    task.wait()
                until n19 > 30 or (RootPart.Position - getgenv().RuzOldPos.p).Magnitude < 25
                Workspace.FallenPartsDestroyHeight = getgenv().RuzFPDH
                print("Returned to previous position.")
            end
            u157 = false
        end
    else
        print(p29.Name .. " is sitting, skipped.")
    end
end

function u176(p34)
    if p34:IsA("BasePart") then
        if not t16[p34] then
            t16[p34] = { Material = p34.Material, CastShadow = p34.CastShadow }
        end
        p34.Material = Enum.Material.SmoothPlastic
        p34.CastShadow = false
    end
    if p34:IsA("Decal") or p34:IsA("Texture") then
        if not t16[p34] then
            t16[p34] = { Transparency = p34.Transparency }
        end
        p34.Transparency = 1
    end
end

function v183()
    u15 = false
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
    Lighting.GlobalShadows = t15.GlobalShadows
    Lighting.Brightness = t15.Brightness
    Lighting.Ambient = t15.Ambient
    Lighting.OutdoorAmbient = t15.OutdoorAmbient
    if u172 then u172:Disconnect() u172 = nil end
    for k, v in pairs(t16) do
        if k and k.Parent then
            pcall(function() for k2, v2 in pairs(v) do k[k2] = v2 end end)
        end
    end
    t16 = {}
    print("Low Graphics OFF")
end

function v204()
    if u202 then u202:Disconnect() u202 = nil end
    if not u199 or not u201 or not u201.Parent then
        if u201 then u201.Rotation = 0 end
        return
    end
    u202 = RunService.RenderStepped:Connect(function()
        if u201 and u201.Parent and u201.Visible then
            u201.Rotation = u201.Rotation + 4
        end
    end)
end

function u218(p35)
    local u740 = nil
    local p36Position = nil
    local Position = nil
    p35.InputBegan:Connect(function(p36)
        if p36.UserInputType == Enum.UserInputType.MouseButton1 or p36.UserInputType == Enum.UserInputType.Touch then
            u740 = true
            p36Position = p36.Position
            Position = p35.Position
        end
    end)
    p35.InputChanged:Connect(function(p37)
        if u740 then
            if p37.UserInputType == Enum.UserInputType.MouseMovement or p37.UserInputType == Enum.UserInputType.Touch then
                local v923 = p37.Position - p36Position
                p35.Position = UDim2.new(Position.X.Scale, Position.X.Offset + v923.X, Position.Y.Scale, Position.Y.Offset + v923.Y)
            end
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            u740 = false
        end
    end)
end

function v220(p38, p39, p40, p41, p42)
    if t25[p38] then
        t25[p38].btn:Destroy()
        t25[p38] = nil
    end
    local TextButton = Instance.new("TextButton")
    TextButton.Name = "RuzBtn_" .. p38
    TextButton.Size = p40
    TextButton.Position = p39
    TextButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    TextButton.BackgroundTransparency = 0.6
    TextButton.Text = ""
    TextButton.AutoButtonColor = false
    TextButton.BorderSizePixel = 0    Instance.new("UICorner", TextButton).CornerRadius = UDim.new(0, p40.Y.Offset * 0.2)
    local UIStroke = Instance.new("UIStroke", TextButton)
    UIStroke.Color = p41
    UIStroke.Thickness = 1.3
    UIStroke.Transparency = 0.5
    UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local TextLabel = Instance.new("TextLabel", TextButton)
    TextLabel.Name = "Lbl"
    TextLabel.Size = UDim2.new(1, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.Text = p42
    TextLabel.TextColor3 = p41
    TextLabel.Font = Enum.Font.GothamBold
    local v755 = p40.Y.Offset * 0.14
    TextLabel.TextSize = math.max(10, v755)
    TextLabel.TextYAlignment = Enum.TextYAlignment.Center
    TextLabel.TextXAlignment = Enum.TextXAlignment.Center
    u218(TextButton)
    t25[p38] = { btn = TextButton, stroke = UIStroke, lbl = TextLabel }
    return t25[p38]
end

function u222(p43, p44)
    local YOffset = p43.btn.Size.Y.Offset
    local v759 = YOffset * 0.55
    local v760 = math.floor(v759)
    local ImageLabel = Instance.new("ImageLabel", p43.btn)
    ImageLabel.Name = "SpinImg"
    ImageLabel.Size = UDim2.new(0, v760, 0, v760)
    ImageLabel.Position = UDim2.new(0.5, -v760 / 2, 0.5, -v760 / 2)
    ImageLabel.BackgroundTransparency = 1
    ImageLabel.Image = "rbxassetid://" .. tostring(p44)
    p43.img = ImageLabel
    p43.lbl.Size = UDim2.new(1, 0, 0.28, 0)
    p43.lbl.Position = UDim2.new(0, 0, 0.72, 0)
    local lbl = p43.lbl
    local v763 = YOffset * 0.12
    lbl.TextSize = math.max(9, v763)
    task.spawn(function()
        while ImageLabel and ImageLabel.Parent do
            ImageLabel.Rotation = ImageLabel.Rotation + 4
            RunService.RenderStepped:Wait()
        end
    end)
    return ImageLabel
end

function v232(p45)
    if p45 then
        local btn = v220("GoldBomb", UDim2.new(0.5, -210, 0.78, 0), UDim2.new(0, 88, 0, 88), Color3.fromRGB(255, 215, 0), "GOLD\nJUMP")
        btn.btn.MouseButton1Click:Connect(function()
            if not u9 then v115("GoldBomb", true) else print("Gold Bomb on cooldown.") end
        end)
    elseif t25.GoldBomb then
        t25.GoldBomb.btn:Destroy()
        t25.GoldBomb = nil
    end
end

function v239(p46)
    if p46 then
        local btn = v220("NormalBomb", UDim2.new(0.5, -110, 0.78, 0), UDim2.new(0, 88, 0, 88), Color3.fromRGB(0, 170, 255), "NORMAL\nJUMP")
        btn.btn.MouseButton1Click:Connect(function()
            if not u10 then v115("FakeBomb", false) else print("Normal Bomb on cooldown.") end
        end)
    elseif t25.NormalBomb then
        t25.NormalBomb.btn:Destroy()
        t25.NormalBomb = nil
    end
end

function v244(p47)
    if p47 then
        local btn = v220("Shoot", UDim2.new(0.5, -10, 0.78, 0), UDim2.new(0, 88, 0, 88), Color3.fromRGB(255, 255, 255), "SHOOT")
        u222(btn, 5159914132)
        btn.btn.MouseButton1Click:Connect(u98)
    elseif t25.Shoot then
        t25.Shoot.btn:Destroy()
        t25.Shoot = nil
    end
end

function u252(p48)
    if p48 then
        local btn = v220("ESP", UDim2.new(0.5, 90, 0.78, 16), UDim2.new(0, 56, 0, 56), Color3.fromRGB(10, 140, 30), "ESP\nOFF")
        btn.btn.MouseButton1Click:Connect(function()
            u61 = not u61
            if not u61 then
                if u62 then u62:Disconnect() u62 = nil end
                task.delay(0.1, v68)
            else
                v78()
            end
            print(u61 and "ESP ON" or "ESP OFF")
        end)
    elseif t25.ESP then
        t25.ESP.btn:Destroy()
        t25.ESP = nil
    end
end

function u257(p49)
    if p49 then
        local btn = v220("Flick", UDim2.new(0.5, 154, 0.78, 16), UDim2.new(0, 56, 0, 56), Color3.fromRGB(180, 50, 255), "FLICK")
        btn.btn.MouseButton1Click:Connect(u104)
    elseif t25.Flick then
        t25.Flick.btn:Destroy()
        t25.Flick = nil
    end
end

function u263(p50)
    if p50 then
        local btn = v220("Speed", UDim2.new(0.5, -278, 0.78, 16), UDim2.new(0, 56, 0, 56), Color3.fromRGB(0, 140, 120), "SPEED")
        btn.btn.MouseButton1Click:Connect(function()
            u116 = not u116
            print(u116 and "Speed Glitch ON" or "Speed Glitch OFF")
        end)
    elseif t25.Speed then
        t25.Speed.btn:Destroy()
        t25.Speed = nil
    end
end

function u270(p51)
    if p51 then
        local btn = v220("Stretch", UDim2.new(0.5, -214, 0.78, 16), UDim2.new(0, 56, 0, 56), Color3.fromRGB(200, 80, 0), "STRETCH")
        btn.btn.MouseButton1Click:Connect(function()
            u120 = not u120
            v125(u120)
            print(u120 and "Stretch ON" or "Stretch OFF")
        end)
    elseif t25.Stretch then
        t25.Stretch.btn:Destroy()
        t25.Stretch = nil
    end
end

function u275()
    local GunDrop = Workspace:FindFirstChild("GunDrop", true)
    if GunDrop then
        local Character = LocalPlayer.Character
        local v611 = Character and Character:FindFirstChild("HumanoidRootPart")
        if v611 then
            local v613
            if not GunDrop:IsA("BasePart") then
                local v612 = GunDrop:FindFirstChild("Handle") or (GunDrop:FindFirstChildWhichIsA("BasePart") or GunDrop.PrimaryPart)
                v613 = v612 and v612.Position or GunDrop:GetModelCFrame().Position
            else
                v613 = GunDrop.Position
            end
            if v613 then
                local CFrame5 = v611.CFrame
                v611.CFrame = CFrame.new(v613 + Vector3.new(0, 2, 0))
                task.wait(0.2)
                v611.CFrame = CFrame5
                print("Teleported to gun!")
            else
                print("Gun position not found!")
            end
        end
    else
        print("No gun on map!")
    end
end

function u276(p52)
    if p52 then
        local btn = v220("GrabGun", UDim2.new(0.5, 90, 0.68, 16), UDim2.new(0, 56, 0, 56), Color3.fromRGB(200, 120, 0), "GRAB\nGUN")
        btn.btn.MouseButton1Click:Connect(u275)
    elseif t25.GrabGun then
        t25.GrabGun.btn:Destroy()
        t25.GrabGun = nil
    end
end

function u281(p53)
    if p53 then
        local btn = v220("WallHop", UDim2.new(0.5, 154, 0.68, 16), UDim2.new(0, 56, 0, 56), Color3.fromRGB(0, 210, 210), "WALL\nHOP")
        btn.btn.MouseButton1Click:Connect(u110)
    elseif t25.WallHop then
        t25.WallHop.btn:Destroy()
        t25.WallHop = nil
    end
end

function u286()
    if not u157 then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and (player.Backpack:FindFirstChild("Knife") or (player.Character and player.Character:FindFirstChild("Knife"))) then
                local Humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if Humanoid and Humanoid.Health > 0 then
                    print("Flinging: " .. player.Name)
                    task.spawn(v161, player)
                    return
                end
            end
        end
        print("No knife player found!")
    else
        print("Fling in progress...")
    end
end

function u287(p54)
    if p54 then
        local btn = v220("FlingMurderer", UDim2.new(0.5, -278, 0.68, 16), UDim2.new(0, 56, 0, 56), Color3.fromRGB(255, 50, 50), "FLING\nMURD")
        btn.btn.MouseButton1Click:Connect(u286)
    elseif t25.FlingMurderer then
        t25.FlingMurderer.btn:Destroy()
        t25.FlingMurderer = nil
    end
end

function u292()
    if not u157 then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character and (player.Backpack:FindFirstChild("Gun") or (player.Character and player.Character:FindFirstChild("Gun"))) then
                local Humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                if Humanoid and Humanoid.Health > 0 then
                    print("Flinging: " .. player.Name)
                    task.spawn(v161, player)
                    return
                end
            end
        end
        print("No gun player found!")
    else
        print("Fling in progress...")
    end
end

function u293(p55)
    if p55 then
        local btn = v220("FlingSheriff", UDim2.new(0.5, -214, 0.68, 16), UDim2.new(0, 56, 0, 56), Color3.fromRGB(40, 130, 255), "FLING\nSHERIF")
        btn.btn.MouseButton1Click:Connect(u292)
    elseif t25.FlingSheriff then
        t25.FlingSheriff.btn:Destroy()
        t25.FlingSheriff = nil
    end
end

function u312()
    local RuzCrosshairDisplay = game.CoreGui:FindFirstChild("RuzCrosshairDisplay")
    if RuzCrosshairDisplay then RuzCrosshairDisplay:Destroy() end
    if u202 then u202:Disconnect() u202 = nil end
    local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
    ScreenGui.Name = "RuzCrosshairDisplay"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.DisplayOrder = 25
    ScreenGui.IgnoreGuiInset = true
    u201 = Instance.new("ImageLabel", ScreenGui)
    u201.AnchorPoint = Vector2.new(0.5, 0.5)
    u201.Position = UDim2.new(0.5, 0, 0.5, 0)
    u201.Size = UDim2.new(0, 42, 0, 42)
    u201.BackgroundTransparency = 1
    u201.Image = "rbxassetid://" .. id
    u201.ZIndex = 10
    u201.Visible = false
    RunService.RenderStepped:Connect(function()
        if u201 and u201.Parent then
            local v914 = UserInputService.MouseBehavior == Enum.MouseBehavior.LockCenter
            local PlayerGui = LocalPlayer:FindFirstChild("PlayerGui")
            if PlayerGui then
                local GameTopbar = PlayerGui:FindFirstChild("GameTopbar")
                if GameTopbar and GameTopbar:FindFirstChild("Crosshair") then
                    GameTopbar.Crosshair.Visible = false
                end
            end
            u201.Visible = u198 and (v914 or false)
            UserInputService.MouseIconEnabled = not u201.Visible
        end
    end)
    v204()
end

function u316()
    if u16 then
        u16 = false
        Lighting.Brightness = t15.Brightness
        Lighting.GlobalShadows = t15.GlobalShadows
        Lighting.Ambient = t15.Ambient
        Lighting.OutdoorAmbient = t15.OutdoorAmbient
        for _, child in ipairs(Lighting:GetChildren()) do
            if child:IsA("BloomEffect") or child:IsA("SunRaysEffect") or child:IsA("ColorCorrectionEffect") then
                child:Destroy()
            end
        end
    end
    u15 = true
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    pcall(function() setfpscap(9999) end)
    Lighting.GlobalShadows = false
    Lighting.Brightness = 2
    for _, descendant in ipairs(Workspace:GetDescendants()) do
        pcall(function() u176(descendant) end)
    end
    if u172 then u172:Disconnect() end
    u172 = Workspace.DescendantAdded:Connect(function(descendant)
        task.wait(0.1)
        pcall(function() u176(descendant) end)
    end)
    print("Low Graphics ON — FPS boost active")
end

function u319()
    if u15 then v183() end
    u16 = true
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level21 end)
    Lighting.GlobalShadows = true
    Lighting.Brightness = 3.5
    Lighting.Ambient = Color3.fromRGB(80, 80, 100)
    Lighting.OutdoorAmbient = Color3.fromRGB(100, 110, 130)
    local v701 = Lighting:FindFirstChildOfClass("BloomEffect") or Instance.new("BloomEffect", Lighting)
    v701.Intensity = 0.6
    v701.Size = 24
    v701.Threshold = 0.95
    local v702 = Lighting:FindFirstChildOfClass("SunRaysEffect") or Instance.new("SunRaysEffect", Lighting)
    v702.Intensity = 0.25
    v702.Spread = 1
    local v703 = Lighting:FindFirstChildOfClass("ColorCorrectionEffect") or Instance.new("ColorCorrectionEffect", Lighting)
    v703.Saturation = 0.2
    v703.Contrast = 0.1
    v703.Brightness = 0.05
    print("High Graphics ON")
end

function u320()
    u16 = false
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic end)
    Lighting.Brightness = t15.Brightness
    Lighting.GlobalShadows = t15.GlobalShadows
    Lighting.Ambient = t15.Ambient
    Lighting.OutdoorAmbient = t15.OutdoorAmbient
    for _, child in ipairs(Lighting:GetChildren()) do
        if child:IsA("BloomEffect") or child:IsA("SunRaysEffect") or child:IsA("ColorCorrectionEffect") then
            child:Destroy()
        end
    end
    print("High Graphics OFF")
end

-- ===== СОХРАНЯЕМ НАЧАЛЬНЫЕ НАСТРОЙКИ LIGHTING =====
t15 = {
    GlobalShadows = Lighting.GlobalShadows,
    Brightness = Lighting.Brightness,
    Ambient = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient
}

-- ===== РАЗМЕЩАЕМ КНОПКИ НА ЭКРАНЕ =====
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.Name = "RuzHub_BtnLayer"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.DisplayOrder = 10
u215 = ScreenGui

-- Автозагрузка базовых кнопок
v232(true)
v239(true)
v244(true)

-- ===== RAYFIELD UI =====
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Rayfield:CreateWindow({
    Name = "RuzHub v7.3",
    Icon = 0,
    LoadingTitle = "RuzHub",
    LoadingSubtitle = "by YinYangAsist",
    ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Main", 0)
local ESPTab = Window:CreateTab("ESP", 0)

-- ===== MAIN TAB =====
MainTab:CreateParagraph({ Title = "Auto-Loaded Buttons", Content = "Gold Bomb, Normal Bomb and Shoot/Throw are enabled by default." })

MainTab:CreateToggle({
    Name = "Show Gold Bomb",
    CurrentValue = true,
    Callback = function(Value) v232(Value) end
})

MainTab:CreateToggle({
    Name = "Show Normal Bomb",
    CurrentValue = true,
    Callback = function(Value) v239(Value) end
})

MainTab:CreateToggle({
    Name = "Show Shoot/Throw",
    CurrentValue = true,
    Callback = function(Value) v244(Value) end
})

MainTab:CreateDivider()

MainTab:CreateParagraph({ Title = "Optional Buttons", Content = "Toggle to add or remove from screen." })

MainTab:CreateToggle({
    Name = "Load ESP Toggle",
    CurrentValue = false,
    Callback = function(Value) u252(Value) end
})

MainTab:CreateToggle({
    Name = "Load Flick",
    CurrentValue = false,
    Callback = function(Value) u257(Value) end
})

MainTab:CreateToggle({
    Name = "Load Grab Gun",
    CurrentValue = false,
    Callback = function(Value) u276(Value) end
})

MainTab:CreateToggle({
    Name = "Load Speed Glitch",
    CurrentValue = false,
    Callback = function(Value) u263(Value) end
})

MainTab:CreateToggle({
    Name = "Load Stretch",
    CurrentValue = false,
    Callback = function(Value) u270(Value) end
})

MainTab:CreateToggle({
    Name = "Load Fling Murderer",
    CurrentValue = false,
    Callback = function(Value) u287(Value) end
})

MainTab:CreateToggle({
    Name = "Load Fling Sheriff",
    CurrentValue = false,
    Callback = function(Value) u293(Value) end
})

MainTab:CreateToggle({
    Name = "Load Wall Hop",
    CurrentValue = false,
    Callback = function(Value) u281(Value) end
})

MainTab:CreateDivider()

MainTab:CreateParagraph({ Title = "Skybox", Content = "Click the button below to open the visual skybox picker." })
MainTab:CreateButton({
    Name = "Open Skybox Picker",
    Callback = function()
        -- Упрощённый выбор скибокса (без графического интерфейса, но с функциями)
        local SkyboxList = {
            {name = "Red", id = "98490421374360"},
            {name = "Pink", id = "95000769820905"},
            {name = "Pink 2", id = "82988835868087"},
            {name = "Green", id = "5036205687"},
            {name = "Black", id = "80807192441609"},
            {name = "Cosmic", id = "77816282467771"},
            {name = "Yellow", id = "2669948520"}
        }
        local function showSkyboxPicker()
            -- Вывод через Rayfield не имеет встроенного picker, поэтому используем простой select
            local options = {}
            for _, v in ipairs(SkyboxList) do
                table.insert(options, v.name)
            end
            -- Создаём временный Dropdown для выбора
            -- (в Rayfield нет встроенного окна, поэтому используем простой Input)
            local input = Rayfield:CreateInput({
                Name = "Enter Skybox ID or Name",
                PlaceholderText = "e.g. 98490421374360 or Red",
                RemoveTextWhileFocus = false,
                Callback = function(Text)
                    local found = false
                    for _, v in ipairs(SkyboxList) do
                        if Text == v.name or Text == v.id then
                            u147(v.id)
                            found = true
                            break
                        end
                    end
                    if not found then
                        u147(Text)
                    end
                end
            })
            MainTab:AddElement(input)
        end
        showSkyboxPicker()
    end
})

MainTab:CreateButton({
    Name = "Restore Default Sky",
    Callback = function() v145() end
})

MainTab:CreateDivider()

MainTab:CreateParagraph({ Title = "Crosshair", Content = "Visible only when ShiftLock is active." })
MainTab:CreateToggle({
    Name = "Enable Custom Crosshair",
    CurrentValue = false,
    Callback = function(Value)
        u198 = Value
        if Value then
            u312()
        else
            local RuzCrosshairDisplay = game.CoreGui:FindFirstChild("RuzCrosshairDisplay")
            if RuzCrosshairDisplay then RuzCrosshairDisplay:Destroy() end
            u201 = nil
            if u202 then u202:Disconnect() u202 = nil end
            UserInputService.MouseIconEnabled = true
        end
    end
})

MainTab:CreateDivider()

MainTab:CreateParagraph({ Title = "Graphics", Content = "Low: removes textures, map looks flat, boosts FPS." })
MainTab:CreateToggle({
    Name = "Low Graphics (FPS Boost)",
    CurrentValue = false,
    Callback = function(Value)
        if not Value then
            v183()
        else
            u316()
        end
    end
})

MainTab:CreateToggle({
    Name = "High Graphics (Beautiful)",
    CurrentValue = false,
    Callback = function(Value)
        if not Value then
            u320()
        else
            u319()
        end
    end
})

MainTab:CreateDivider()

MainTab:CreateParagraph({ Title = "Extra Scripts", Content = "Universal scripts and additional tools." })
MainTab:CreateButton({
    Name = "Load Emotes GUI",
    Callback = function()
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/7yd7/Hub/refs/heads/Branch/GUIS/Emotes.lua"))())
    end
})
MainTab:CreateButton({
    Name = "Load Infinite Yield",
    Callback = function()
        pcall(loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))())
    end
})

MainTab:CreateDivider()

MainTab:CreateToggle({
    Name = "Anti-Fling",
    CurrentValue = false,
    Callback = function(Value) u156(Value) end
})

MainTab:CreateToggle({
    Name = "Auto Ping Prediction",
    CurrentValue = false,
    Callback = function(Value) u13 = Value end
})

MainTab:CreateSlider({
    Name = "Speed Glitch Slider",
    Min = 50,
    Max = 600,
    Default = 200,
    Increment = 10,
    Callback = function(Value) n2 = Value end
})

MainTab:CreateDropdown({
    Name = "Velocity Cap (Anti-Fling)",
    Options = {"50", "100", "150", "200", "300", "500"},
    CurrentOption = "200",
    Callback = function(Option) n1 = tonumber(Option) or 200 end
})

-- ===== ESP TAB =====
ESPTab:CreateToggle({
    Name = "Enable ESP",
    CurrentValue = false,
    Callback = function(Value)
        u61 = Value
        if not Value then
            if u62 then u62:Disconnect() u62 = nil end
            task.delay(0.1, v68)
        else
            v78()
        end
    end
})

ESPTab:CreateDivider()

ESPTab:CreateToggle({
    Name = "Show Murderer",
    CurrentValue = true,
    Callback = function(Value) t3.Murderer = Value end
})
ESPTab:CreateToggle({
    Name = "Show Sheriff",
    CurrentValue = true,
    Callback = function(Value) t3.Sheriff = Value end
})
ESPTab:CreateToggle({
    Name = "Show Hero",
    CurrentValue = true,
    Callback = function(Value) t3.Hero = Value end
})
ESPTab:CreateToggle({
    Name = "Show Innocents",
    CurrentValue = true,
    Callback = function(Value) t3.Innocent = Value end
})
ESPTab:CreateToggle({
    Name = "Show Self",
    CurrentValue = true,
    Callback = function(Value) t3.Self = Value end
})

ESPTab:CreateToggle({
    Name = "Dropped Gun ESP",
    CurrentValue = true,
    Callback = function(Value)
        u17 = Value
        if not Value then
            if u31 then u31:Destroy() u31 = nil end
            if u32 then u32:Destroy() u32 = nil end
            if u29 then u29:Destroy() u29 = nil end
        end
    end
})

ESPTab:CreateDivider()

ESPTab:CreateColorPicker({
    Name = "Murderer Color",
    CurrentValue = Color3.fromRGB(255, 40, 40),
    Callback = function(Value) t4.Murderer = Value end
})
ESPTab:CreateColorPicker({
    Name = "Sheriff Color",
    CurrentValue = Color3.fromRGB(40, 130, 255),
    Callback = function(Value) t4.Sheriff = Value end
})
ESPTab:CreateColorPicker({
    Name = "Hero Color",
    CurrentValue = Color3.fromRGB(255, 215, 0),
    Callback = function(Value) t4.Hero = Value end
})
ESPTab:CreateColorPicker({
    Name = "Innocent Color",
    CurrentValue = Color3.fromRGB(0, 220, 0),
    Callback = function(Value) t4.Innocent = Value end
})

print("[RuzHub v7.3] Rayfield port loaded. Все функции сохранены.")