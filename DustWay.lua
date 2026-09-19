-- ============================================================
--              DustWay Hub v2 | MM2 Script
--        WindUI (Footagesus/latest) | Custom Build
-- ============================================================

-- ── Services ─────────────────────────────────────────────────
local cloneref   = (cloneref or clonereference or function(i) return i end)
local Players    = cloneref(game:GetService('Players'))
local RunService = cloneref(game:GetService('RunService'))
local TweenService = cloneref(game:GetService('TweenService'))
local UserInputService = cloneref(game:GetService('UserInputService'))
local ReplicatedStorage = cloneref(game:GetService('ReplicatedStorage'))
local Lighting   = cloneref(game:GetService('Lighting'))
local Workspace  = cloneref(game:GetService('Workspace'))

local player  = Players.LocalPlayer
local camera  = Workspace.CurrentCamera

-- ── WindUI (новая версия Footagesus) ─────────────────────────
local WindUI = loadstring(game:HttpGet(
    'https://raw.githubusercontent.com/Footagesus/WindUI/refs/heads/main/dist/main.lua'
))()

WindUI:SetTheme('Crimson')

-- ── Window ───────────────────────────────────────────────────
local Window = WindUI:CreateWindow({
    Title       = 'DustWay',
    Icon        = 'sword',
    Folder      = 'DustWay',
    NewElements = true,
    HideSearchBar = false,
    OpenButton  = {
        Title         = 'DustWay',
        CornerRadius  = UDim.new(1, 0),
        StrokeThickness = 2,
        Enabled       = true,
        Draggable     = true,
        OnlyMobile    = false,
        Scale         = 0.5,
        Color         = ColorSequence.new(
            Color3.fromHex('#b91c1c'),
            Color3.fromHex('#7f1d1d')
        ),
    },
    Topbar      = {
        Height      = 44,
        ButtonsType = 'Mac',
    },
})

Window:Tag({
    Title  = 'MM2 Hub',
    Icon   = 'zap',
    Color  = Color3.fromHex('#1c1c1c'),
    Border = true,
})

-- ════════════════════════════════════════════════════════════
--  SECTIONS / TABS
-- ════════════════════════════════════════════════════════════
local SecFarm    = Window:Section({ Title = 'AutoFarm'  })
local SecESP     = Window:Section({ Title = 'ESP'       })
local SecVisuals = Window:Section({ Title = 'Visuals'   })
local SecHat     = Window:Section({ Title = 'China Hat' })
local SecSettings = Window:Section({ Title = 'Settings' })

local TabFarm    = SecFarm:Tab    ({ Title = 'AutoFarm',  Icon = 'coins'   })
local TabESP     = SecESP:Tab     ({ Title = 'ESP',       Icon = 'eye'     })
local TabVisuals = SecVisuals:Tab ({ Title = 'Visuals',   Icon = 'palette' })
local TabHat     = SecHat:Tab     ({ Title = 'China Hat', Icon = 'hat'     })
local TabSettings = SecSettings:Tab({ Title = 'Settings', Icon = 'settings' })

-- ════════════════════════════════════════════════════════════
--  AUTOFARM (из autofarm_mm2.lua, логика без изменений)
-- ════════════════════════════════════════════════════════════
local LocalPlayer = player

local FarmSettings = {
    AutoFarmEnabled   = false,
    FarmMode          = 'Underground',
    TweenSpeed        = 25,
    AutoReset         = true,
    AvoidMurder       = true,
    UndergroundOffset = 4,
    MaxDistance       = 600,
    CoinLimit         = 40,
}
local FarmState = {
    isFarming         = false,
    isActivelyFlying  = false,
    currentTargetCoin = nil,
    ignoredCoins      = {},
    currentTween      = nil,
}

local function getTorso(char)
    if not char then return nil end
    return char:FindFirstChild('Torso') or char:FindFirstChild('LowerTorso') or char:FindFirstChild('HumanoidRootPart')
end
local function isRoundOver()
    local pGui = LocalPlayer:FindFirstChild('PlayerGui')
    if not pGui then return false end
    local vGui = pGui:FindFirstChild('Victory')
    if vGui then
        for _, c in pairs(vGui:GetChildren()) do
            if c:IsA('GuiObject') and c.Visible then return true end
        end
    end
    return false
end
local function isBagFull()
    local pGui = LocalPlayer:FindFirstChild('PlayerGui')
    if pGui then
        local mg = pGui:FindFirstChild('MainGUI')
        if mg and mg:FindFirstChild('Lobby') and mg.Lobby:FindFirstChild('Dock') then
            local cb = mg.Lobby.Dock:FindFirstChild('CoinBags')
            if cb then
                local n = cb:FindFirstChild('FullBagNotification')
                if n and n.Visible then return true end
            end
        end
    end
    return false
end
local function hasNearbyMurderer()
    if not FarmSettings.AvoidMurder then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    if not hrp then return false end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local oHRP = p.Character:FindFirstChild('HumanoidRootPart')
            local bp   = p:FindFirstChild('Backpack')
            if oHRP and (oHRP.Position - hrp.Position).Magnitude <= 10 then
                if p.Character:FindFirstChild('Knife') then return true end
                if bp and bp:FindFirstChild('Knife') then return true end
            end
        end
    end
    return false
end
local function getNearestCoin(torso)
    local container = nil
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj.Name == 'CoinContainer' then container = obj break end
    end
    if not container then return nil end
    local nearest, minDist = nil, math.huge
    for _, coin in pairs(container:GetChildren()) do
        if coin.Name == 'Coin_Server' and coin:IsA('BasePart') and not FarmState.ignoredCoins[coin] then
            local d = (torso.Position - coin.Position).Magnitude
            if d < minDist and d <= FarmSettings.MaxDistance then minDist = d nearest = coin end
        end
    end
    return nearest
end
local function applyFlightPhysics(char)
    if not char then return end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    if not hrp then return CFrame.Angles(0,0,0) end
    local bv = hrp:FindFirstChild('FarmBV')
    if not bv then
        bv = Instance.new('BodyVelocity')
        bv.Name = 'FarmBV'
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0,0,0)
        bv.Parent = hrp
    end
    local bg = hrp:FindFirstChild('FarmBG')
    if not bg then
        bg = Instance.new('BodyGyro')
        bg.Name = 'FarmBG'
        bg.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
        bg.P = 50000
        bg.Parent = hrp
        local _, rotY, _ = hrp.CFrame:ToOrientation()
        bg.CFrame = CFrame.new(hrp.Position) * CFrame.Angles(0, rotY, 0) * CFrame.Angles(math.rad(-90), 0, 0)
    end
    return bg.CFrame.Rotation
end
local function removePhysics()
    local char = LocalPlayer.Character
    if not char then return end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    if hrp then
        if hrp:FindFirstChild('FarmBV') then hrp.FarmBV:Destroy() end
        if hrp:FindFirstChild('FarmBG') then hrp.FarmBG:Destroy() end
        if hrp.Anchored then hrp.Anchored = false end
    end
end
local function setupNoclip()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild('Humanoid')
    if hum then hum.PlatformStand = true end
    for _, p in pairs(char:GetDescendants()) do
        if p:IsA('BasePart') and p.CanCollide then p.CanCollide = false end
    end
end
local function flyToPoint(targetPos, targetCoin, hrp, torso, lockedRotation)
    local dist = (torso.Position - targetPos).Magnitude
    local ti = TweenInfo.new(dist / FarmSettings.TweenSpeed, Enum.EasingStyle.Linear)
    local tween = TweenService:Create(hrp, ti, { CFrame = CFrame.new(targetPos) * lockedRotation })
    FarmState.currentTween = tween
    local reached = false
    tween:Play()
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not FarmState.isFarming or not targetCoin or not targetCoin:IsDescendantOf(Workspace) then
            tween:Cancel()
            if conn then conn:Disconnect() end
            return
        end
        if firetouchinterest then
            pcall(function()
                firetouchinterest(torso, targetCoin, 0)
                firetouchinterest(torso, targetCoin, 1)
            end)
        end
        if (torso.Position - targetPos).Magnitude <= 1.5 then
            reached = true
            tween:Cancel()
            if conn then conn:Disconnect() end
        end
    end)
    while conn and conn.Connected do RunService.Heartbeat:Wait() end
    return reached
end
local function tweenToCoin(coin)
    if not coin or not coin.Parent or not coin:FindFirstChild('TouchInterest') then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    local hum = char:FindFirstChildOfClass('Humanoid')
    if not hrp or not hum then return false end
    local target = coin.Position + Vector3.new(0,2,0)
    if (hrp.Position - target).Magnitude < 5 then return true end
    if FarmState.currentTween then pcall(function() FarmState.currentTween:Cancel() end) end
    FarmState.currentTween = TweenService:Create(hrp,
        TweenInfo.new((hrp.Position - target).Magnitude / FarmSettings.TweenSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { CFrame = CFrame.new(target) }
    )
    hum.Sit = true
    FarmState.currentTween:Play()
    local done = false
    local c
    c = FarmState.currentTween.Completed:Connect(function() done = true if c then c:Disconnect() end end)
    local t0 = tick()
    while not done and FarmState.isFarming do
        task.wait(0.1)
        if not coin or not coin.Parent or not coin:FindFirstChild('TouchInterest') then
            if FarmState.currentTween then pcall(function() FarmState.currentTween:Cancel() end) end
            hum.Sit = false return false
        end
        if tick() - t0 > 30 then
            if FarmState.currentTween then pcall(function() FarmState.currentTween:Cancel() end) end
            hum.Sit = false return false
        end
    end
    hum.Sit = false return done
end
local function collectCoin(coin)
    if not coin or not coin.Parent then return end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild('HumanoidRootPart')
    if not hrp then return end
    pcall(function()
        firetouchinterest(hrp, coin, 0)
        task.wait(0.05)
        firetouchinterest(hrp, coin, 1)
    end)
end
local function startFarming()
    if FarmState.isFarming then return end
    FarmState.isFarming = true
    table.clear(FarmState.ignoredCoins)
    task.spawn(function()
        while FarmState.isFarming do
            task.wait()
            pcall(function()
                if hasNearbyMurderer() then
                    FarmState.isActivelyFlying = false
                    FarmState.currentTargetCoin = nil
                    removePhysics()
                    local char = LocalPlayer.Character
                    if char then
                        local hum = char:FindFirstChild('Humanoid')
                        if hum then hum.Sit = false end
                    end
                    task.wait(1) return
                end
                local char = LocalPlayer.Character
                if not char then return end
                local hrp = char:FindFirstChild('HumanoidRootPart')
                local torso = getTorso(char)
                local humanoid = char:FindFirstChild('Humanoid')
                if not hrp or not torso or not humanoid or humanoid.Health <= 0 then
                    FarmState.isActivelyFlying = false FarmState.currentTargetCoin = nil
                    removePhysics() task.wait(1) return
                end
                if isRoundOver() or isBagFull() then
                    FarmState.isActivelyFlying = false FarmState.currentTargetCoin = nil
                    removePhysics() if humanoid then humanoid.Sit = false end
                    task.wait(1) return
                end
                if FarmSettings.AutoReset and LocalPlayer.PlayerGui then
                    local gui = LocalPlayer.PlayerGui:FindFirstChild('MainGUI')
                    local coinsVal = 0
                    if gui then
                        pcall(function()
                            local icon = gui.Game.CoinBags.Container.Coin.CurrencyFrame.Icon
                            coinsVal = tonumber(icon.Coins.Text) or 0
                        end)
                    end
                    if coinsVal >= FarmSettings.CoinLimit then
                        humanoid.Health = 0 task.wait(5) return
                    end
                end
                local targetCoin = getNearestCoin(torso)
                if not targetCoin or not targetCoin:IsDescendantOf(Workspace) then
                    FarmState.isActivelyFlying = false FarmState.currentTargetCoin = nil
                    removePhysics() if humanoid then humanoid.Sit = false end
                    task.wait(0.5) return
                end
                FarmState.isActivelyFlying = true FarmState.currentTargetCoin = targetCoin
                local reached = false
                if FarmSettings.FarmMode == 'Underground' then
                    setupNoclip()
                    local lockedRot = applyFlightPhysics(char)
                    local tp = targetCoin.Position - Vector3.new(0, FarmSettings.UndergroundOffset, 0)
                    reached = flyToPoint(tp, targetCoin, hrp, torso, lockedRot)
                elseif FarmSettings.FarmMode == 'Sit' then
                    reached = tweenToCoin(targetCoin)
                    if reached and FarmState.isFarming and humanoid.Health > 0 then
                        collectCoin(targetCoin)
                    end
                end
                if reached and FarmState.isFarming and humanoid.Health > 0 then
                    FarmState.ignoredCoins[targetCoin] = true
                    task.delay(5, function() FarmState.ignoredCoins[targetCoin] = nil end)
                    task.wait(0.2)
                end
                FarmState.currentTargetCoin = nil
            end)
        end
    end)
end
local function stopFarming()
    FarmState.isFarming = false FarmState.isActivelyFlying = false FarmState.currentTargetCoin = nil
    if FarmState.currentTween then pcall(function() FarmState.currentTween:Cancel() end) FarmState.currentTween = nil end
    removePhysics()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild('Humanoid')
        if hum then hum.PlatformStand = false hum.Sit = false end
    end
end
RunService.Stepped:Connect(function()
    if not FarmState.isFarming or not FarmState.isActivelyFlying or FarmSettings.FarmMode ~= 'Underground' then return end
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild('Humanoid')
    if hum then hum.PlatformStand = true end
    for _, p in pairs(char:GetDescendants()) do
        if p:IsA('BasePart') and p.CanCollide then p.CanCollide = false end
    end
end)

-- ── AutoFarm UI ──────────────────────────────────────────────
TabFarm:Section({ Title = 'Coin Farm' })

TabFarm:Toggle({
    Title = 'Enable AutoFarm',
    Value = false,
    Callback = function(v)
        FarmSettings.AutoFarmEnabled = v
        if v then startFarming() else stopFarming() end
    end,
})

TabFarm:Space()

TabFarm:Dropdown({
    Title  = 'Farm Mode',
    Values = { 'Underground', 'Sit' },
    Value  = 'Underground',
    Callback = function(v) FarmSettings.FarmMode = v end,
})

TabFarm:Space()
TabFarm:Section({ Title = 'Settings' })

TabFarm:Slider({
    Title = 'Tween Speed',
    Step  = 1,
    Value = { Min = 5, Max = 100, Default = 25 },
    Callback = function(v) FarmSettings.TweenSpeed = v end,
})

TabFarm:Space()

TabFarm:Slider({
    Title = 'Coin Limit (AutoReset)',
    Step  = 1,
    Value = { Min = 5, Max = 100, Default = 40 },
    Callback = function(v) FarmSettings.CoinLimit = v end,
})

TabFarm:Space()

TabFarm:Slider({
    Title = 'Max Coin Distance',
    Step  = 10,
    Value = { Min = 50, Max = 1000, Default = 600 },
    Callback = function(v) FarmSettings.MaxDistance = v end,
})

TabFarm:Space()

TabFarm:Slider({
    Title = 'Underground Offset',
    Step  = 0.5,
    Value = { Min = 0, Max = 10, Default = 4 },
    Callback = function(v) FarmSettings.UndergroundOffset = v end,
})

TabFarm:Space()
TabFarm:Section({ Title = 'Options' })

TabFarm:Toggle({
    Title = 'Auto Reset at Coin Limit',
    Value = true,
    Callback = function(v) FarmSettings.AutoReset = v end,
})

TabFarm:Space()

TabFarm:Toggle({
    Title = 'Avoid Murderer',
    Value = true,
    Callback = function(v) FarmSettings.AvoidMurder = v end,
})

-- ════════════════════════════════════════════════════════════
--  ESP + SHOOT/THROW  (из ruz.lua — логика сохранена точно)
-- ════════════════════════════════════════════════════════════

-- ESP state
local espEnabled  = false
local espConn     = nil
local espRoleData = {}
local espLastTick = 0

local espShowRoles = {
    Murderer  = true,
    Sheriff   = true,
    Hero      = true,
    Innocent  = true,
    Self      = true,
}
local espColors = {
    Murderer = Color3.fromRGB(255, 40,  40),
    Sheriff  = Color3.fromRGB(40,  130, 255),
    Hero     = Color3.fromRGB(255, 215, 0),
    Innocent = Color3.fromRGB(0,   220, 0),
}

local function espGetRole(p)
    local data = espRoleData[p.Name]
    if data then
        local v = tostring(data.Role or data.role or data.Team or ''):lower()
        if v:find('murd')    then return 'Murderer' end
        if v:find('sheriff') or v:find('gun') then return 'Sheriff' end
        if v:find('hero')    then return 'Hero' end
    end
    return 'Innocent'
end

local function espApply(char, color)
    local h = char:FindFirstChild('DustWay_ESP') or Instance.new('Highlight')
    h.Name              = 'DustWay_ESP'
    h.Parent            = char
    h.FillColor         = color
    h.FillTransparency  = 0.7
    h.OutlineColor      = Color3.fromRGB(255, 255, 255)
    h.OutlineTransparency = 0.15
    h.DepthMode         = Enum.HighlightDepthMode.AlwaysOnTop
end

local function espClear()
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then
            local h = p.Character:FindFirstChild('DustWay_ESP')
            if h then h:Destroy() end
        end
    end
    espRoleData = {}
end

local function espStart()
    if espConn then espConn:Disconnect() espConn = nil end
    local remote = ReplicatedStorage:FindFirstChild('GetCurrentPlayerData', true)
    if not remote or not remote:IsA('RemoteFunction') then
        WindUI:Notify({
            Title   = 'DustWay',
            Content = 'ESP remote не найден!',
            Duration = 3,
            Icon    = 'bell',
        })
        espEnabled = false
        return
    end
    espConn = RunService.Heartbeat:Connect(function()
        if not espEnabled then return end
        if tick() - espLastTick > 0.5 then
            local ok, result = pcall(function() return remote:InvokeServer() end)
            if ok and type(result) == 'table' then espRoleData = result end
            espLastTick = tick()
        end
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character then
                local role  = espGetRole(p)
                local shown = espShowRoles[role]
                if p == player and not espShowRoles.Self then shown = false end
                if not shown then
                    local h = p.Character:FindFirstChild('DustWay_ESP')
                    if h then h:Destroy() end
                else
                    espApply(p.Character, espColors[role])
                end
            end
        end
    end)
end

-- Nearest target tracker (для Shoot/Throw)
local nearestTarget = nil

RunService.RenderStepped:Connect(function()
    local char = player.Character
    local hrp  = char and char:FindFirstChild('HumanoidRootPart')
    if not hrp then nearestTarget = nil return end

    local knifeOwner = player.Backpack:FindFirstChild('Knife') or (char and char:FindFirstChild('Knife'))
    local gunOwner   = player.Backpack:FindFirstChild('Gun')   or (char and char:FindFirstChild('Gun'))
    local best, bestDist = nil, math.huge

    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= player and p.Character then
            local c   = p.Character
            local hum = c:FindFirstChildOfClass('Humanoid')
            if hum and hum.Health > 0 then
                local pHRP = c:FindFirstChild('HumanoidRootPart')
                if pHRP then
                    local pKnife = p.Backpack:FindFirstChild('Knife') or c:FindFirstChild('Knife')
                    local pGun   = p.Backpack:FindFirstChild('Gun')   or c:FindFirstChild('Gun')
                    local dist   = (pHRP.Position - hrp.Position).Magnitude
                    local prio   = false
                    if not knifeOwner and not gunOwner then
                        if pKnife then prio = true dist = dist - 1000 end
                        if pGun   then prio = true end
                    elseif gunOwner and (pGun or pKnife) then
                        prio = true
                    elseif knifeOwner and pKnife then
                        prio = true
                    end
                    if prio and dist < bestDist then bestDist = dist best = c end
                end
            end
        end
    end

    if not best then
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= player and p.Character then
                local c   = p.Character
                local hum = c:FindFirstChildOfClass('Humanoid')
                local pHRP = c:FindFirstChild('HumanoidRootPart')
                if hum and hum.Health > 0 and pHRP then
                    local dist = (pHRP.Position - hrp.Position).Magnitude
                    if dist < bestDist then bestDist = dist best = c end
                end
            end
        end
    end

    nearestTarget = best
end)

-- Prediction part (как в ruz.lua)
local predPart = Instance.new('Part')
predPart.Name         = 'DW_PredictionPart'
predPart.Size         = Vector3.new(0.5, 0.5, 0.5)
predPart.Anchored     = true
predPart.CanCollide   = false
predPart.Transparency = 1
predPart.Parent       = Workspace

local pingOffset = false

local function doThrowKnife()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    if not hrp then return end
    local knife = player.Backpack:FindFirstChild('Knife') or char:FindFirstChild('Knife')
    if not knife then
        WindUI:Notify({ Title='DustWay', Content='Нет ножа в инвентаре!', Duration=3, Icon='bell' })
        return
    end
    local targetChar = nearestTarget
    if not targetChar then
        WindUI:Notify({ Title='DustWay', Content='Цель не найдена!', Duration=3, Icon='bell' })
        return
    end
    local targetHRP = targetChar:FindFirstChild('HumanoidRootPart')
    if not targetHRP then return end
    local torso = targetChar:FindFirstChild('UpperTorso') or targetChar:FindFirstChild('Torso') or targetHRP
    local vel = targetHRP.AssemblyLinearVelocity
    local dist = (torso.Position - hrp.Position).Magnitude
    local ping = 0
    if pingOffset then
        local ok, r = pcall(function() return player:GetNetworkPing() end)
        ping = ok and r or 0
    end
    local aimPos = torso.Position + Vector3.new(vel.X, 0, vel.Z) * (dist / 65 + ping * 0.5)
    if char ~= knife.Parent then char.Humanoid:EquipTool(knife) task.wait(0) end
    pcall(function()
        local knifeThrown = ReplicatedStorage:WaitForChild('Events', 5)
        if knifeThrown then knifeThrown = knifeThrown:WaitForChild('KnifeThrown', 5) end
        if not knifeThrown then return end
        local cf = CFrame.new(hrp.Position, aimPos)
        knifeThrown:FireServer(cf, CFrame.new(aimPos))
    end)
end

local function doShoot()
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    if not hrp then return end
    local gun = player.Backpack:FindFirstChild('Gun') or char:FindFirstChild('Gun')
    if not gun then
        WindUI:Notify({ Title='DustWay', Content='Нет пушки в инвентаре!', Duration=3, Icon='bell' })
        return
    end
    local targetChar = nearestTarget
    if not targetChar then
        WindUI:Notify({ Title='DustWay', Content='Цель не найдена!', Duration=3, Icon='bell' })
        return
    end
    local targetHRP = targetChar:FindFirstChild('HumanoidRootPart')
    if not targetHRP then return end
    local aimPos = predPart.CFrame.Position
    if char ~= gun.Parent then char.Humanoid:EquipTool(gun) task.wait(0) end
    pcall(function()
        local shoot = gun:WaitForChild('Shoot', 5)
        if not shoot then return end
        local firePos = hrp.Position + Vector3.new(0, 1, 0)
        local cf = CFrame.new(firePos, aimPos)
        shoot:FireServer(cf, CFrame.new(aimPos))
    end)
end

local function doShootOrThrow()
    local char = player.Character
    if not char then return end
    local hasKnife = player.Backpack:FindFirstChild('Knife') or char:FindFirstChild('Knife')
    local hasGun   = player.Backpack:FindFirstChild('Gun')   or char:FindFirstChild('Gun')
    if not hasKnife then
        doShoot()
    else
        doThrowKnife()
    end
end

-- Screen button layer (Shoot/Throw)
local btnGui = Instance.new('ScreenGui', game.CoreGui)
btnGui.Name          = 'DustWay_BtnLayer'
btnGui.ResetOnSpawn  = false
btnGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
btnGui.DisplayOrder  = 10

local btnObjects = {}

local function makeBtn(name, pos, size, color, labelText)
    if btnObjects[name] then
        btnObjects[name]:Destroy()
        btnObjects[name] = nil
    end
    local btn = Instance.new('TextButton', btnGui)
    btn.Name               = 'DW_Btn_' .. name
    btn.Size               = size
    btn.Position           = pos
    btn.BackgroundColor3   = Color3.fromRGB(0, 0, 0)
    btn.BackgroundTransparency = 0.6
    btn.Text               = ''
    btn.AutoButtonColor    = false
    btn.BorderSizePixel    = 0
    Instance.new('UICorner', btn).CornerRadius = UDim.new(0, size.Y.Offset * 0.2)
    local stroke = Instance.new('UIStroke', btn)
    stroke.Color       = color
    stroke.Thickness   = 1.3
    stroke.Transparency = 0.5
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    local lbl = Instance.new('TextLabel', btn)
    lbl.Size               = UDim2.new(1, 0, 1, 0)
    lbl.BackgroundTransparency = 1
    lbl.Text               = labelText
    lbl.TextColor3         = color
    lbl.Font               = Enum.Font.GothamBold
    lbl.TextSize           = math.max(10, size.Y.Offset * 0.14)
    lbl.TextYAlignment     = Enum.TextYAlignment.Center
    lbl.TextXAlignment     = Enum.TextXAlignment.Center
    -- drag
    local dragging, dStart, dPos = false, nil, nil
    btn.InputBegan:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
            dragging = true dStart = inp.Position dPos = btn.Position
        end
    end)
    btn.InputChanged:Connect(function(inp)
        if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
            local d = inp.Position - dStart
            btn.Position = UDim2.new(dPos.X.Scale, dPos.X.Offset + d.X, dPos.Y.Scale, dPos.Y.Offset + d.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(inp)
        if inp.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    btnObjects[name] = btn
    return btn
end

local showShootThrow = true

local function setShootThrowBtn(v)
    showShootThrow = v
    if v then
        local btn = makeBtn('ShootThrow', UDim2.new(0.5, -10, 0.78, 0), UDim2.new(0, 56, 0, 56), Color3.fromRGB(255, 255, 255), 'SHOOT\nTHROW')
        btn.MouseButton1Click:Connect(doShootOrThrow)
    else
        if btnObjects['ShootThrow'] then btnObjects['ShootThrow']:Destroy() btnObjects['ShootThrow'] = nil end
    end
end

setShootThrowBtn(true)

-- ── ESP UI ───────────────────────────────────────────────────
TabESP:Section({ Title = 'Highlight ESP' })

TabESP:Toggle({
    Title = 'Enable ESP',
    Value = false,
    Callback = function(v)
        espEnabled = v
        if v then espStart() else
            if espConn then espConn:Disconnect() espConn = nil end
            task.delay(0.1, espClear)
        end
        WindUI:Notify({ Title='DustWay', Content = v and 'ESP ВКЛ' or 'ESP ВЫКЛ', Duration=2, Icon='eye' })
    end,
})

TabESP:Space()
TabESP:Section({ Title = 'Role Visibility' })

TabESP:Toggle({
    Title = 'Show Murderer',
    Value = true,
    Callback = function(v) espShowRoles.Murderer = v end,
})
TabESP:Space()
TabESP:Toggle({
    Title = 'Show Sheriff',
    Value = true,
    Callback = function(v) espShowRoles.Sheriff = v end,
})
TabESP:Space()
TabESP:Toggle({
    Title = 'Show Hero',
    Value = true,
    Callback = function(v) espShowRoles.Hero = v end,
})
TabESP:Space()
TabESP:Toggle({
    Title = 'Show Innocent',
    Value = true,
    Callback = function(v) espShowRoles.Innocent = v end,
})
TabESP:Space()
TabESP:Toggle({
    Title = 'Show Self',
    Value = true,
    Callback = function(v) espShowRoles.Self = v end,
})

TabESP:Space()
TabESP:Section({ Title = 'Shoot / Throw Button' })

TabESP:Toggle({
    Title = 'Show Shoot/Throw Button',
    Value = true,
    Callback = function(v) setShootThrowBtn(v) end,
})

TabESP:Space()

TabESP:Toggle({
    Title = 'Ping Offset (Shoot/Throw)',
    Desc  = 'Добавляет пинг-компенсацию',
    Value = false,
    Callback = function(v) pingOffset = v end,
})

TabESP:Space()

TabESP:Button({
    Title    = 'Throw Knife',
    Icon     = 'sword',
    Justify  = 'Center',
    Callback = function() doThrowKnife() end,
})

TabESP:Space()

TabESP:Button({
    Title    = 'Shoot Gun',
    Icon     = 'crosshair',
    Justify  = 'Center',
    Callback = function() doShoot() end,
})

-- ════════════════════════════════════════════════════════════
--  VISUALS (Trail, ForceField, AuraTrailer, FullBright)
--  + АУРЫ из aura.lua
-- ════════════════════════════════════════════════════════════

local defaultLighting = {
    Brightness     = Lighting.Brightness,
    ClockTime      = Lighting.ClockTime,
    GlobalShadows  = Lighting.GlobalShadows,
    OutdoorAmbient = Lighting.OutdoorAmbient,
    Ambient        = Lighting.Ambient,
}

-- Trail
local TrailV = {
    enabled = false, isGradient = false, lifetime = 0.5,
    transparencyStart = 0, rainbow = false,
    colorStatic = Color3.fromRGB(0, 255, 255),
    gradient1   = Color3.fromRGB(0, 86, 255),
    gradient2   = Color3.fromRGB(255, 0, 0),
    parts = {}, connection = nil,
}
local function Trail_Remove(char)
    if TrailV.parts[char] then TrailV.parts[char]:Destroy() TrailV.parts[char] = nil end
    if char and char:FindFirstChild('HumanoidRootPart') then
        local t = char.HumanoidRootPart
        if t:FindFirstChild('TrailAttach0') then t.TrailAttach0:Destroy() end
        if t:FindFirstChild('TrailAttach1') then t.TrailAttach1:Destroy() end
    end
end
local function Trail_Add(char)
    local t = char:WaitForChild('HumanoidRootPart', 5) if not t then return end
    Trail_Remove(char)
    local a0 = Instance.new('Attachment') a0.Name = 'TrailAttach0' a0.Position = Vector3.new(0,2,0) a0.Parent = t
    local a1 = Instance.new('Attachment') a1.Name = 'TrailAttach1' a1.Position = Vector3.new(0,-2,0) a1.Parent = t
    local trail = Instance.new('Trail')
    trail.Attachment0 = a0 trail.Attachment1 = a1
    trail.Lifetime = TrailV.lifetime
    trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, TrailV.transparencyStart), NumberSequenceKeypoint.new(1,1)})
    if TrailV.isGradient then trail.Color = ColorSequence.new(TrailV.gradient1, TrailV.gradient2)
    else trail.Color = ColorSequence.new(TrailV.colorStatic) end
    trail.LightEmission = 0.2 trail.Enabled = true trail.Parent = char
    TrailV.parts[char] = trail
end
local function Trail_UpdateAll()
    for char, trail in pairs(TrailV.parts) do
        if trail and trail.Parent and char == player.Character then
            trail.Lifetime = TrailV.lifetime
            trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, TrailV.transparencyStart), NumberSequenceKeypoint.new(1,1)})
            if TrailV.isGradient then trail.Color = ColorSequence.new(TrailV.gradient1, TrailV.gradient2)
            elseif TrailV.rainbow then trail.Color = ColorSequence.new(Color3.fromHSV(tick()%5/5,1,1))
            else trail.Color = ColorSequence.new(TrailV.colorStatic) end
        end
    end
end
local function Trail_Toggle(v)
    TrailV.enabled = v
    if v and player.Character then
        Trail_Add(player.Character)
        if TrailV.connection then TrailV.connection:Disconnect() end
        TrailV.connection = RunService.Heartbeat:Connect(Trail_UpdateAll)
    else
        if player.Character then Trail_Remove(player.Character) end
        if TrailV.connection then TrailV.connection:Disconnect() TrailV.connection = nil end
    end
end

-- ForceField
local FFV = { enabled = false, color = Color3.fromRGB(128,128,128), rainbow = false, originalColors = {}, connection = nil }
local function FF_SaveColors(char)
    FFV.originalColors[char] = {}
    for _, p in pairs(char:GetDescendants()) do
        if p:IsA('BasePart') and p.Name ~= 'ChineseHat' then
            FFV.originalColors[char][p] = { Color = p.Color, Material = p.Material }
        end
    end
end
local function FF_Apply(char)
    FF_SaveColors(char)
    for _, p in pairs(char:GetDescendants()) do
        if p:IsA('BasePart') and p.Name ~= 'ChineseHat' then p.Color = FFV.color p.Material = Enum.Material.ForceField end
    end
end
local function FF_Update()
    if player.Character and FFV.enabled then
        for _, p in pairs(player.Character:GetDescendants()) do
            if p:IsA('BasePart') and p.Name ~= 'ChineseHat' and p.Material == Enum.Material.ForceField then
                p.Color = FFV.rainbow and Color3.fromHSV(tick()%5/5,1,1) or FFV.color
            end
        end
    end
end
local function FF_Remove(char)
    if FFV.originalColors[char] then
        for part, data in pairs(FFV.originalColors[char]) do
            if part and part.Parent and part:IsA('BasePart') then part.Color = data.Color part.Material = data.Material end
        end
        FFV.originalColors[char] = {}
    end
end
local function FF_Toggle(v)
    FFV.enabled = v
    if player.Character then
        if v then FF_Apply(player.Character)
            if FFV.connection then FFV.connection:Disconnect() end
            FFV.connection = RunService.Heartbeat:Connect(FF_Update)
        else
            if FFV.connection then FFV.connection:Disconnect() FFV.connection = nil end
            FF_Remove(player.Character)
        end
    end
end

-- AuraTrailer
local ATV = { enabled = false, color = Color3.fromRGB(255,0,0), lifetime = 0.5 }
local function AT_Toggle(v)
    local char = player.Character if not char then return end
    local hrp = char:FindFirstChild('HumanoidRootPart') if not hrp then return end
    for _, part in pairs(char:GetChildren()) do
        if part:IsA('BasePart') and part ~= hrp then
            if v then
                if not part:FindFirstChild('AuraTrailer') then
                    local trail = Instance.new('Trail') trail.Name = 'AuraTrailer'
                    trail.Texture = 'rbxassetid://1390780157' trail.Parent = part
                    local p1 = Instance.new('Attachment', part) p1.Name = 'AuraPointer1'
                    local p2 = Instance.new('Attachment', hrp) p2.Name = 'AuraPointer2'
                    trail.Attachment0 = p1 trail.Attachment1 = p2
                    trail.Color = ColorSequence.new(ATV.color, ATV.color)
                    trail.Lifetime = ATV.lifetime
                end
            else
                if part:FindFirstChild('AuraTrailer') then part.AuraTrailer:Destroy() end
                if part:FindFirstChild('AuraPointer1') then part.AuraPointer1:Destroy() end
            end
        end
    end
    if not v then
        for _, obj in pairs(hrp:GetChildren()) do
            if obj.Name == 'AuraPointer2' then obj:Destroy() end
        end
    end
end
local function AT_Update()
    local char = player.Character if not char then return end
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA('Trail') and v.Name == 'AuraTrailer' then
            v.Color = ColorSequence.new(ATV.color, ATV.color) v.Lifetime = ATV.lifetime
        end
    end
end

-- ── Auras из aura.lua ────────────────────────────────────────
local AuraModelIDs = {
    Godly         = 'rbxassetid://16699750981',
    ['Super Sayien'] = 'rbxassetid://116109508364297',
    ['North Star'] = 'rbxassetid://83945069652732',
    ['Blue Lord']  = 'rbxassetid://10974316799',
    ['Pink Aura']  = 'rbxassetid://115980859615239',
    ['Angel Wing'] = 'rbxassetid://90022969696073',
    ['Sweet Heart'] = 'rbxassetid://91724768175470',
    ['Ethereal Aura'] = 'rbxassetid://97041568674250',
}
local AuraModelNames = {'Godly','Super Sayien','North Star','Blue Lord','Pink Aura','Angel Wing','Sweet Heart','Ethereal Aura'}

local PARTICLE_AURA_DATA = {
    {'starlight','rbxassetid://134645216613107'},
    {'heavenly','rbxassetid://139300897520961'},
    {'ribbon','rbxassetid://132069507632161'},
    {'sakura','rbxassetid://81755778619404'},
    {'angel','rbxassetid://97658130917593'},
    {'wind','rbxassetid://80694081850877'},
    {'flow','rbxassetid://119913533725648'},
    {'star','rbxassetid://73754563740680'},
    {'neon','rbxassetid://18498709246'},
}
local particleAuraIdByName = {}
local particleAuraNames = {}
for _, row in ipairs(PARTICLE_AURA_DATA) do
    table.insert(particleAuraNames, row[1])
    particleAuraIdByName[row[1]] = row[2]
end

local activeClassicAuras  = {}
local activeParticleAuras = {}
local loadedParticleAuras = {}
local particleAuraColor   = Color3.fromRGB(133, 220, 255)

local function ClassicAura_DisableOne(name)
    if activeClassicAuras[name] then
        for _, v in pairs(activeClassicAuras[name]) do
            if v and v.Parent then pcall(function() v:Destroy() end) end
        end
        activeClassicAuras[name] = nil
    end
end
local function ClassicAura_EnableOne(char, name)
    if not char or not char.Parent then return end
    ClassicAura_DisableOne(name)
    local id = AuraModelIDs[name]
    if not id then return end
    local ok, model = pcall(function() return game:GetObjects(id)[1] end)
    if not ok or not model then return end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    if not hrp then return end
    model.Parent = char
    local weld = Instance.new('WeldConstraint')
    weld.Part0 = hrp
    local mp = model.PrimaryPart or model:FindFirstChildOfClass('BasePart')
    if mp then weld.Part1 = mp end
    weld.Parent = model
    activeClassicAuras[name] = { model }
end
local classicAuraEnabled  = false
local selectedClassicAuras = {}
local function ClassicAura_RefreshAll()
    local char = player.Character
    for _, name in ipairs(AuraModelNames) do ClassicAura_DisableOne(name) end
    if classicAuraEnabled and char then
        for name, on in pairs(selectedClassicAuras) do
            if on then task.spawn(ClassicAura_EnableOne, char, name) end
        end
    end
end

local function ParticleAura_LoadOne(name)
    if loadedParticleAuras[name] then return loadedParticleAuras[name] end
    local id = particleAuraIdByName[name]
    if not id then return nil end
    local ok, obj = pcall(function() return game:GetObjects(id)[1] end)
    if not ok or not obj then return nil end
    loadedParticleAuras[name] = obj
    return obj
end
local function ParticleAura_DisableOne(name)
    if activeParticleAuras[name] then
        for _, v in pairs(activeParticleAuras[name]) do
            if v and v.Parent then pcall(function() v:Destroy() end) end
        end
        activeParticleAuras[name] = nil
    end
end
local function ParticleAura_EnableOne(char, name)
    if not char or not char.Parent then return end
    ParticleAura_DisableOne(name)
    local template = ParticleAura_LoadOne(name)
    if not template then return end
    local hrp = char:FindFirstChild('HumanoidRootPart')
    if not hrp then return end
    local clone = template:Clone()
    clone.Parent = hrp
    for _, e in pairs(clone:GetDescendants()) do
        if e:IsA('ParticleEmitter') or e:IsA('Trail') then
            if e:IsA('ParticleEmitter') then e.Color = ColorSequence.new(particleAuraColor) end
        end
    end
    activeParticleAuras[name] = { clone }
end
local particleAuraEnable = false
local selectedParticleAuras = {}
local function ParticleAura_RefreshAll()
    local char = player.Character
    for _, name in ipairs(particleAuraNames) do ParticleAura_DisableOne(name) end
    if particleAuraEnable and char then
        for name, on in pairs(selectedParticleAuras) do
            if on then task.spawn(ParticleAura_EnableOne, char, name) end
        end
    end
end

-- ── Visuals UI ───────────────────────────────────────────────
TabVisuals:Section({ Title = 'Trail' })

TabVisuals:Toggle({
    Title = 'Enable Trail', Value = false,
    Callback = function(v) Trail_Toggle(v) end,
})
TabVisuals:Space()
TabVisuals:Toggle({
    Title = 'Gradient Mode', Value = false,
    Callback = function(v)
        TrailV.isGradient = v
        if TrailV.enabled and player.Character then Trail_Add(player.Character) end
    end,
})
TabVisuals:Space()
TabVisuals:Toggle({
    Title = 'Rainbow', Value = false,
    Callback = function(v) TrailV.rainbow = v Trail_UpdateAll() end,
})
TabVisuals:Space()
TabVisuals:Slider({
    Title = 'Lifetime', Step = 0.1, Value = { Min = 0.1, Max = 3, Default = 0.5 },
    Callback = function(v) TrailV.lifetime = v Trail_UpdateAll() end,
})
TabVisuals:Space()
TabVisuals:Slider({
    Title = 'Start Transparency', Step = 0.01, Value = { Min = 0, Max = 1, Default = 0 },
    Callback = function(v) TrailV.transparencyStart = v Trail_UpdateAll() end,
})
TabVisuals:Space()
TabVisuals:ColorPicker({
    Title = 'Trail Color', Value = Color3.fromRGB(0, 255, 255),
    Callback = function(v) TrailV.colorStatic = v Trail_UpdateAll() end,
})
TabVisuals:Space()
TabVisuals:ColorPicker({
    Title = 'Gradient Color 1', Value = Color3.fromRGB(0, 86, 255),
    Callback = function(v) TrailV.gradient1 = v Trail_UpdateAll() end,
})
TabVisuals:Space()
TabVisuals:ColorPicker({
    Title = 'Gradient Color 2', Value = Color3.fromRGB(255, 0, 0),
    Callback = function(v) TrailV.gradient2 = v Trail_UpdateAll() end,
})

TabVisuals:Space()
TabVisuals:Section({ Title = 'ForceField' })

TabVisuals:Toggle({
    Title = 'Enable ForceField', Value = false,
    Callback = function(v) FF_Toggle(v) end,
})
TabVisuals:Space()
TabVisuals:Toggle({
    Title = 'Rainbow', Value = false,
    Callback = function(v) FFV.rainbow = v FF_Update() end,
})
TabVisuals:Space()
TabVisuals:ColorPicker({
    Title = 'ForceField Color', Value = Color3.fromRGB(128,128,128),
    Callback = function(v)
        FFV.color = v
        if FFV.enabled and not FFV.rainbow and player.Character then FF_Apply(player.Character) end
    end,
})

TabVisuals:Space()
TabVisuals:Section({ Title = 'Aura Trailer' })

TabVisuals:Toggle({
    Title = 'Enable Aura Trailer', Value = false,
    Callback = function(v) ATV.enabled = v AT_Toggle(v) end,
})
TabVisuals:Space()
TabVisuals:ColorPicker({
    Title = 'Aura Trailer Color', Value = Color3.fromRGB(255,0,0),
    Callback = function(v) ATV.color = v if ATV.enabled then AT_Update() end end,
})
TabVisuals:Space()
TabVisuals:Slider({
    Title = 'Aura Trailer Lifetime', Step = 0.1, Value = { Min = 0.1, Max = 3, Default = 0.5 },
    Callback = function(v) ATV.lifetime = v if ATV.enabled then AT_Update() end end,
})

TabVisuals:Space()
TabVisuals:Section({ Title = 'Classic Aura' })

TabVisuals:Toggle({
    Title = 'Enable Classic Aura', Value = false,
    Callback = function(v) classicAuraEnabled = v ClassicAura_RefreshAll() end,
})
TabVisuals:Space()
TabVisuals:Dropdown({
    Title  = 'Select Classic Auras',
    Values = AuraModelNames,
    Value  = {},
    Multi  = true,
    Callback = function(v)
        selectedClassicAuras = v or {}
        ClassicAura_RefreshAll()
    end,
})

TabVisuals:Space()
TabVisuals:Section({ Title = 'Particle Aura' })

TabVisuals:Toggle({
    Title = 'Enable Particle Aura', Value = false,
    Callback = function(v) particleAuraEnable = v ParticleAura_RefreshAll() end,
})
TabVisuals:Space()
TabVisuals:ColorPicker({
    Title = 'Particle Aura Color', Value = Color3.fromRGB(133, 220, 255),
    Callback = function(v) particleAuraColor = v ParticleAura_RefreshAll() end,
})
TabVisuals:Space()
TabVisuals:Dropdown({
    Title  = 'Select Particle Auras',
    Values = particleAuraNames,
    Value  = {},
    Multi  = true,
    Callback = function(v)
        selectedParticleAuras = v or {}
        ParticleAura_RefreshAll()
    end,
})

TabVisuals:Space()
TabVisuals:Section({ Title = 'Lighting' })

TabVisuals:Toggle({
    Title = 'Full Bright', Value = false,
    Callback = function(v)
        if v then
            Lighting.Brightness = 2 Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
            Lighting.OutdoorAmbient = Color3.fromRGB(128,128,128)
            Lighting.Ambient = Color3.fromRGB(128,128,128)
        else
            Lighting.Brightness = defaultLighting.Brightness
            Lighting.ClockTime  = defaultLighting.ClockTime
            Lighting.GlobalShadows = defaultLighting.GlobalShadows
            Lighting.OutdoorAmbient = defaultLighting.OutdoorAmbient
            Lighting.Ambient = defaultLighting.Ambient
        end
    end,
})

-- ════════════════════════════════════════════════════════════
--  CHINA HAT
-- ════════════════════════════════════════════════════════════
local HatV = {
    enabled = false, style = 'Classic',
    transparency = 0.3, rainbow = false, rainbowSpeed = 5,
    color = Color3.fromRGB(0, 255, 255),
    radius = 2.4, height = 1.6, reflectance = 0, sides = 25,
    parts = {}, connection = nil,
}
local tau      = math.pi * 2
local drawings = {}
for i = 1, HatV.sides do
    drawings[i] = { Drawing.new('Line'), Drawing.new('Triangle') }
    drawings[i][1].ZIndex = 2 drawings[i][1].Thickness = 2
    drawings[i][2].ZIndex = 1 drawings[i][2].Filled = true
end

local function Hat_RemoveClassic()
    if HatV.parts[player.Character] then HatV.parts[player.Character]:Destroy() HatV.parts[player.Character] = nil end
end
local function Hat_AddClassic(char)
    task.wait(0.1)
    local head = char:WaitForChild('Head', 5) if not head then return end
    Hat_RemoveClassic()
    local hat = Instance.new('Part')
    hat.Name = 'ChineseHat' hat.Transparency = HatV.transparency hat.Color = HatV.color
    hat.Material = Enum.Material.Neon hat.CanCollide = false hat.Reflectance = HatV.reflectance
    local mesh = Instance.new('SpecialMesh')
    mesh.MeshId = 'rbxassetid://1033714'
    mesh.Scale = Vector3.new(HatV.radius, HatV.height, HatV.radius) mesh.Parent = hat
    local weld = Instance.new('WeldConstraint')
    weld.Part0 = head weld.Part1 = hat weld.Parent = hat
    hat.CFrame = head.CFrame * CFrame.new(0, 1.1, 0) hat.Parent = char
    HatV.parts[char] = hat
end
local function Hat_UpdateClassic()
    for char, hat in pairs(HatV.parts) do
        if hat and hat.Parent and char == player.Character then
            hat.Transparency = HatV.transparency hat.Reflectance = HatV.reflectance
            hat.Color = HatV.rainbow and Color3.fromHSV(tick()%HatV.rainbowSpeed/HatV.rainbowSpeed,1,1) or HatV.color
            local m = hat:FindFirstChildOfClass('SpecialMesh')
            if m then m.Scale = Vector3.new(HatV.radius, HatV.height, HatV.radius) end
        end
    end
end
local function Hat_UpdateDrawing()
    local pass = HatV.enabled and player.Character and player.Character:FindFirstChild('Head')
        and (camera.CFrame.p - camera.Focus.p).Magnitude > 1
        and player.Character.Humanoid.Health > 0
    for i = 1, #drawings do
        local line, tri = drawings[i][1], drawings[i][2]
        if pass then
            local color = HatV.rainbow and Color3.fromHSV((tick()%HatV.rainbowSpeed/HatV.rainbowSpeed-(i/#drawings))%1,0.5,1) or HatV.color
            local pos      = player.Character.Head.Position + Vector3.new(0, 0.75, 0)
            local topWorld = pos + Vector3.new(0, 0.75, 0)
            local last, next2 = (i/HatV.sides)*tau, ((i+1)/HatV.sides)*tau
            local lastW = pos + Vector3.new(math.cos(last),0,math.sin(last)) * HatV.radius
            local nextW = pos + Vector3.new(math.cos(next2),0,math.sin(next2)) * HatV.radius
            local ls = camera:WorldToViewportPoint(lastW)
            local ns = camera:WorldToViewportPoint(nextW)
            local ts = camera:WorldToViewportPoint(topWorld)
            line.From = Vector2.new(ls.X,ls.Y) line.To = Vector2.new(ns.X,ns.Y)
            line.Color = color line.Transparency = 1 - HatV.transparency line.Visible = true
            tri.PointA = Vector2.new(ts.X,ts.Y) tri.PointB = line.From tri.PointC = line.To
            tri.Color = color tri.Transparency = 0.35 tri.Visible = true
        else
            line.Visible = false tri.Visible = false
        end
    end
end
local function Hat_Toggle(v)
    HatV.enabled = v
    if v then
        if HatV.style == 'Classic' and player.Character then Hat_AddClassic(player.Character) end
        if HatV.connection then HatV.connection:Disconnect() end
        HatV.connection = RunService.Heartbeat:Connect(function()
            if HatV.style == 'Classic' then Hat_UpdateClassic() end
        end)
    else
        if player.Character then Hat_RemoveClassic() end
        for i = 1, #drawings do drawings[i][1].Visible = false drawings[i][2].Visible = false end
        if HatV.connection then HatV.connection:Disconnect() HatV.connection = nil end
    end
end
local function Hat_ChangeStyle(newStyle)
    local was = HatV.enabled HatV.style = newStyle
    if was then Hat_Toggle(false) task.wait(0.1) Hat_Toggle(true) end
end
local function Hat_UpdateSides(n)
    HatV.sides = n
    for i = 1, #drawings do drawings[i][1]:Remove() drawings[i][2]:Remove() end
    drawings = {}
    for i = 1, n do
        drawings[i] = { Drawing.new('Line'), Drawing.new('Triangle') }
        drawings[i][1].ZIndex = 2 drawings[i][1].Thickness = 2
        drawings[i][2].ZIndex = 1 drawings[i][2].Filled = true
    end
end
RunService.RenderStepped:Connect(function()
    if HatV.enabled and HatV.style == 'Drawing' then Hat_UpdateDrawing() end
end)

-- ── China Hat UI ─────────────────────────────────────────────
TabHat:Section({ Title = 'China Hat' })

TabHat:Toggle({
    Title = 'Enable Hat', Value = false,
    Callback = function(v) Hat_Toggle(v) end,
})
TabHat:Space()
TabHat:Dropdown({
    Title = 'Hat Style', Values = {'Classic','Drawing'}, Value = 'Classic',
    Callback = function(v) Hat_ChangeStyle(v) end,
})
TabHat:Space()
TabHat:Toggle({
    Title = 'Rainbow', Value = false,
    Callback = function(v) HatV.rainbow = v end,
})
TabHat:Space()
TabHat:Slider({
    Title = 'Rainbow Speed', Step = 1, Value = { Min = 1, Max = 20, Default = 5 },
    Callback = function(v) HatV.rainbowSpeed = v end,
})
TabHat:Space()
TabHat:Slider({
    Title = 'Transparency', Step = 0.01, Value = { Min = 0, Max = 1, Default = 0.3 },
    Callback = function(v) HatV.transparency = v end,
})
TabHat:Space()
TabHat:Slider({
    Title = 'Radius', Step = 0.1, Value = { Min = 0.5, Max = 10, Default = 2.4 },
    Callback = function(v) HatV.radius = v end,
})
TabHat:Space()
TabHat:Slider({
    Title = 'Height', Step = 0.1, Value = { Min = 0.5, Max = 5, Default = 1.6 },
    Callback = function(v) HatV.height = v end,
})
TabHat:Space()
TabHat:Slider({
    Title = 'Reflectance (Classic)', Step = 0.01, Value = { Min = 0, Max = 1, Default = 0 },
    Callback = function(v) HatV.reflectance = v end,
})
TabHat:Space()
TabHat:Slider({
    Title = 'Sides (Drawing)', Step = 1, Value = { Min = 3, Max = 300, Default = 25 },
    Callback = function(v) Hat_UpdateSides(v) end,
})
TabHat:Space()
TabHat:ColorPicker({
    Title = 'Hat Color', Value = Color3.fromRGB(0, 255, 255),
    Callback = function(v) HatV.color = v end,
})

-- ════════════════════════════════════════════════════════════
--  SETTINGS
-- ════════════════════════════════════════════════════════════
TabSettings:Section({ Title = 'Menu' })

TabSettings:Button({
    Title    = 'Unload DustWay',
    Icon     = 'x',
    Justify  = 'Center',
    Callback = function()
        WindUI:Destroy()
        stopFarming()
        if espConn then espConn:Disconnect() end
        espClear()
        for i = 1, #drawings do drawings[i][1]:Remove() drawings[i][2]:Remove() end
        if btnGui then btnGui:Destroy() end
        if predPart then predPart:Destroy() end
    end,
})

-- CharacterAdded reapply
player.CharacterAdded:Connect(function(char)
    if HatV.enabled and HatV.style == 'Classic' then task.spawn(Hat_AddClassic, char) end
    if FFV.enabled then task.wait(1) FF_Apply(char) end
    if TrailV.enabled then Trail_Add(char) end
    if classicAuraEnabled then task.wait(1) ClassicAura_RefreshAll() end
    if particleAuraEnable then task.wait(1) ParticleAura_RefreshAll() end
end)

-- Startup notification
WindUI:Notify({
    Title    = 'DustWay v2',
    Content  = 'Loaded! MM2 Hub Ready.',
    Icon     = 'zap',
    Duration = 5,
})
