-- ============================================================
-- DustWay Dashboard v1.0 — MM2
-- UI: Custom Dashboard (Sci-fi style)
-- Adapted for Executors
-- ============================================================

-- ===== 1. ЗАЩИТА =====
if getgenv().DustWayDashLoaded then
    warn("[DustWay] Уже запущен!")
    return
end
getgenv().DustWayDashLoaded = true

-- ===== 2. SERVICES =====
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Stats = game:GetService("Stats")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

-- ===== 3. ЗАЩИТА GUI ОТ АНТИЧИТОВ =====
local protectgui = protectgui or (syn and syn.protect_gui) or function() end
local guiParent = gethui and gethui() or CoreGui

-- ===== 4. НАСТРОЙКИ =====
local Settings = {
    AutoFarmEnabled = false,
    FarmMode = "Underground",
    TweenSpeed = 25,
    AutoReset = true,
    AvoidMurder = true,
    UndergroundOffset = 4,
    MaxDistance = 600,
    CoinLimit = 40,
}

local ChinaHatSettings = {
    enabled = true,
    hatColor = Color3.fromRGB(255, 105, 180),
    lightColor = Color3.fromRGB(255, 105, 180),
    lightBrightness = 0,
    lightRange = 12,
    scale = Vector3.new(1.7, 1.1, 1.7),
}

local State = {
    isFarming = false,
    isActivelyFlying = false,
    currentTargetCoin = nil,
    ignoredCoins = {},
    currentTween = nil,
}

local ESP_STATES = {ESPName = false, MurdererName = true, SheriffName = true, HeroName = true, InnocentName = true}
local ESP_HIGHLIGHT_STATES = {ESPHighlight = false, ESPHighlightMurderer = true, ESPHighlightSheriff = true, ESPHighlightHero = true, ESPHighlightInnocent = true}
local ESP_LINE_STATES = {ESPLine = false, MurdererLine = true, SheriffLine = true, HeroLine = true, InnocentLine = true, LineThickness = 1.4, LineTransparency = 1}

local KillAll = {Enabled = false, AttackDelay = 0.5}
local Movement = {SpeedWalk = {Enabled = false, Value = 16}, JumpPower = {Enabled = false, Value = 50}}
local AntiFling = {Enabled = false, Connections = nil}
local AutoFarm = {Enabled = false, Farming = false, BagFull = false, Resetting = false, StartPosition = nil}
local Performance = {Enabled = false, Overlay = nil}

local VALID_TARGET_ROLES = {"Sheriff", "Hero", "Innocent"}
local DEFAULT_WALK_SPEED = 16
local DEFAULT_JUMP_POWER = 50

local ESP = {billboards = {}, currentRoles = {}, LineDrawings = {}, Camera = workspace.CurrentCamera, Connections = {}, RolesData = {}, RolesCacheTime = 0}
local FarmStats = {CoinsCollected = 0, StartTime = 0, IsRunning = false}
local RemoteEvents = {CoinCollected = nil, RoundStart = nil, RoundEnd = nil}

-- ===== 5. CONFIG (для UI) =====
local CONFIG = {
    PlayerName = LocalPlayer.DisplayName,
    Level = 12,
    XP = 3450,
    MaxXP = 5000,
    Balance = 1250,
    Status = "Онлайн",

    BG_DARK = Color3.fromRGB(13, 13, 13),
    BG_SIDEBAR = Color3.fromRGB(17, 17, 17),
    BG_CARD = Color3.fromRGB(20, 20, 20),
    BG_ACTIVE = Color3.fromRGB(26, 26, 26),
    BORDER = Color3.fromRGB(40, 40, 40),
    BORDER_GLOW = Color3.fromRGB(80, 80, 80),
    TEXT_PRIMARY = Color3.fromRGB(220, 220, 220),
    TEXT_SUB = Color3.fromRGB(100, 100, 100),
    TEXT_MUTED = Color3.fromRGB(60, 60, 60),
    ACCENT_GLOW = Color3.fromRGB(130, 130, 130),
    STATUS_GREEN = Color3.fromRGB(58, 122, 58),
    XP_BAR = Color3.fromRGB(100, 100, 100),
    TWEEN_TIME = 0.18,

    RARITY_COLORS = {
        common = Color3.fromRGB(130, 130, 130),
        uncommon = Color3.fromRGB(80, 160, 80),
        rare = Color3.fromRGB(80, 120, 200),
        epic = Color3.fromRGB(150, 80, 200),
        legendary = Color3.fromRGB(220, 160, 40),
    },
    CELL_SIZE = 64,
    CELL_GAP = 8,
}

-- ===== 6. UTILS =====
local function isMobile()
    return UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
end

local function tween(obj, props, t)
    local info = TweenInfo.new(t or CONFIG.TWEEN_TIME, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    TweenService:Create(obj, info, props):Play()
end

local function makeCorner(parent, radius)
    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, radius)
    c.Parent = parent
    return c
end

local function makeStroke(parent, color, thickness)
    local s = Instance.new("UIStroke")
    s.Color = color
    s.Thickness = thickness or 1
    s.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    s.Parent = parent
    return s
end

local function makePadding(parent, px)
    local p = Instance.new("UIPadding")
    p.PaddingTop = UDim.new(0, px)
    p.PaddingBottom = UDim.new(0, px)
    p.PaddingLeft = UDim.new(0, px)
    p.PaddingRight = UDim.new(0, px)
    p.Parent = parent
    return p
end

local function makeLabel(parent, text, size, color, bold)
    local lbl = Instance.new("TextLabel")
    lbl.Text = text
    lbl.TextSize = size
    lbl.TextColor3 = color
    lbl.Font = bold and Enum.Font.GothamBold or Enum.Font.Gotham
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    lbl.TextYAlignment = Enum.TextYAlignment.Top
    lbl.Size = UDim2.new(1, 0, 0, size + 6)
    lbl.Parent = parent
    return lbl
end

local function getHRP()
    local char = LocalPlayer.Character
    if char then return char:FindFirstChild("HumanoidRootPart") end
    return nil
end

local function getTorso(char)
    if not char then return nil end
    return char:FindFirstChild("Torso") or char:FindFirstChild("LowerTorso") or char:FindFirstChild("HumanoidRootPart")
end

-- ============================================================
-- AUTO FARM FUNCTIONS
-- ============================================================

local function getCurrentCoins()
    local ok, res = pcall(function()
        local gui = LocalPlayer.PlayerGui:FindFirstChild("MainGUI")
        if not gui then return 0 end
        local g = gui:FindFirstChild("Game")
        if not g then return 0 end
        local cb = g:FindFirstChild("CoinBags")
        if not cb then return 0 end
        local c = cb:FindFirstChild("Container")
        if not c then return 0 end
        local coin = c:FindFirstChild("Coin")
        if not coin then return 0 end
        local cf = coin:FindFirstChild("CurrencyFrame")
        if not cf then return 0 end
        local icon = cf:FindFirstChild("Icon")
        if not icon then return 0 end
        local ct = icon:FindFirstChild("Coins")
        if not ct then return 0 end
        return ct.Text
    end)
    return ok and (tonumber(res) or 0) or 0
end

local function isRoundOver()
    local pGui = LocalPlayer:FindFirstChild("PlayerGui")
    if not pGui then return false end
    local v = pGui:FindFirstChild("Victory")
    if v then
        for _, c in pairs(v:GetChildren()) do
            if c:IsA("GuiObject") and c.Visible then return true end
        end
    end
    return false
end

local function isBagFull()
    local pGui = LocalPlayer:FindFirstChild("PlayerGui")
    if pGui then
        local mg = pGui:FindFirstChild("MainGUI")
        if mg and mg:FindFirstChild("Lobby") and mg.Lobby:FindFirstChild("Dock") then
            local cb = mg.Lobby.Dock:FindFirstChild("CoinBags")
            if cb then
                local n = cb:FindFirstChild("FullBagNotification")
                if n and n.Visible then return true end
            end
        end
    end
    return false
end

local function hasNearbyMurderer()
    if not Settings.AvoidMurder then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local oHrp = p.Character:FindFirstChild("HumanoidRootPart")
            local bp = p:FindFirstChild("Backpack")
            if oHrp and (oHrp.Position - hrp.Position).Magnitude <= 10 then
                if p.Character:FindFirstChild("Knife") then return true end
                if bp and bp:FindFirstChild("Knife") then return true end
            end
        end
    end
    return false
end

local function getNearestCoin(torso)
    local container
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "CoinContainer" then container = obj break end
    end
    if not container then return nil end
    local nearest, minDist = nil, math.huge
    for _, coin in pairs(container:GetChildren()) do
        if coin.Name == "Coin_Server" and coin:IsA("BasePart") and not State.ignoredCoins[coin] then
            local d = (torso.Position - coin.Position).Magnitude
            if d < minDist and d <= Settings.MaxDistance then
                minDist = d
                nearest = coin
            end
        end
    end
    return nearest
end

local function applyFlightPhysics(char)
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return CFrame.Angles(0,0,0) end
    local bv = hrp:FindFirstChild("FarmBV")
    if not bv then
        bv = Instance.new("BodyVelocity")
        bv.Name = "FarmBV"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.Parent = hrp
    end
    local bg = hrp:FindFirstChild("FarmBG")
    if not bg then
        bg = Instance.new("BodyGyro")
        bg.Name = "FarmBG"
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
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hrp then
        if hrp:FindFirstChild("FarmBV") then hrp.FarmBV:Destroy() end
        if hrp:FindFirstChild("FarmBG") then hrp.FarmBG:Destroy() end
        if hrp.Anchored then hrp.Anchored = false end
    end
end

local function setupNoclip()
    local char = LocalPlayer.Character
    if not char then return end
    local hum = char:FindFirstChild("Humanoid")
    if hum then hum.PlatformStand = true end
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then part.CanCollide = false end
    end
end

local function flyToPoint(targetPos, targetCoin, hrp, torso, lockedRotation)
    local dist = (torso.Position - targetPos).Magnitude
    local tw = TweenService:Create(hrp, TweenInfo.new(dist / Settings.TweenSpeed, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos) * lockedRotation})
    State.currentTween = tw
    local reached = false
    tw:Play()
    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not State.isFarming or not targetCoin or not targetCoin:IsDescendantOf(workspace) then
            tw:Cancel()
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
            tw:Cancel()
            if conn then conn:Disconnect() end
        end
    end)
    while conn and conn.Connected do RunService.Heartbeat:Wait() end
    return reached
end

local function tweenToCoin(coin)
    if not coin or not coin.Parent or not coin:FindFirstChild("TouchInterest") then return false end
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return false end
    local target = coin.Position + Vector3.new(0, 2, 0)
    if (hrp.Position - target).Magnitude < 5 then return true end
    if State.currentTween then pcall(function() State.currentTween:Cancel() end) end
    State.currentTween = TweenService:Create(hrp, TweenInfo.new((hrp.Position - target).Magnitude / Settings.TweenSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {CFrame = CFrame.new(target)})
    hum.Sit = true
    State.currentTween:Play()
    local done = false
    local c
    c = State.currentTween.Completed:Connect(function() done = true; if c then c:Disconnect() end end)
    local t0 = tick()
    while not done and State.isFarming do
        task.wait(0.1)
        if not coin or not coin.Parent or not coin:FindFirstChild("TouchInterest") then
            if State.currentTween then pcall(function() State.currentTween:Cancel() end) end
            hum.Sit = false
            return false
        end
        if tick() - t0 > 30 then
            if State.currentTween then pcall(function() State.currentTween:Cancel() end) end
            hum.Sit = false
            return false
        end
    end
    hum.Sit = false
    return done
end

local function collectCoin(coin)
    if not coin or not coin.Parent then return end
    local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    pcall(function()
        firetouchinterest(hrp, coin, 0)
        task.wait(0.05)
        firetouchinterest(hrp, coin, 1)
    end)
end

local function startFarming()
    if State.isFarming then return end
    State.isFarming = true
    table.clear(State.ignoredCoins)
    task.spawn(function()
        while State.isFarming do
            task.wait()
            pcall(function()
                if hasNearbyMurderer() then
                    State.isActivelyFlying = false
                    State.currentTargetCoin = nil
                    removePhysics()
                    local char = LocalPlayer.Character
                    if char then
                        local hum = char:FindFirstChild("Humanoid")
                        if hum then hum.Sit = false end
                    end
                    task.wait(1)
                    return
                end
                local char = LocalPlayer.Character
                if not char then return end
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local torso = getTorso(char)
                local hum = char:FindFirstChild("Humanoid")
                if not hrp or not torso or not hum or hum.Health <= 0 then
                    State.isActivelyFlying = false
                    State.currentTargetCoin = nil
                    removePhysics()
                    task.wait(1)
                    return
                end
                if isRoundOver() or isBagFull() then
                    State.isActivelyFlying = false
                    State.currentTargetCoin = nil
                    removePhysics()
                    if hum then hum.Sit = false end
                    task.wait(1)
                    return
                end
                if Settings.AutoReset then
                    local coins = getCurrentCoins()
                    if coins >= Settings.CoinLimit then
                        hum.Health = 0
                        task.wait(5)
                        return
                    end
                end
                local targetCoin = getNearestCoin(torso)
                if not targetCoin or not targetCoin:IsDescendantOf(workspace) then
                    State.isActivelyFlying = false
                    State.currentTargetCoin = nil
                    removePhysics()
                    if hum then hum.Sit = false end
                    task.wait(0.5)
                    return
                end
                State.isActivelyFlying = true
                State.currentTargetCoin = targetCoin
                local reached = false
                if Settings.FarmMode == "Underground" then
                    setupNoclip()
                    local rot = applyFlightPhysics(char)
                    local pos = targetCoin.Position - Vector3.new(0, Settings.UndergroundOffset, 0)
                    reached = flyToPoint(pos, targetCoin, hrp, torso, rot)
                elseif Settings.FarmMode == "Sit" then
                    reached = tweenToCoin(targetCoin)
                    if reached and State.isFarming and hum.Health > 0 then
                        collectCoin(targetCoin)
                    end
                end
                if reached and State.isFarming and hum.Health > 0 then
                    State.ignoredCoins[targetCoin] = true
                    task.delay(5, function() State.ignoredCoins[targetCoin] = nil end)
                    task.wait(0.2)
                end
                State.currentTargetCoin = nil
            end)
        end
    end)
end

local function stopFarming()
    State.isFarming = false
    State.isActivelyFlying = false
    State.currentTargetCoin = nil
    if State.currentTween then
        pcall(function() State.currentTween:Cancel() end)
        State.currentTween = nil
    end
    removePhysics()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.PlatformStand = false
            hum.Sit = false
        end
    end
end

-- ============================================================
-- ESP FUNCTIONS
-- ============================================================

local function IsPlayerOnScreen(player)
    if not ESP.Camera then return true end
    local char = player.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end
    local pos, onScreen = ESP.Camera:WorldToViewportPoint(hrp.Position)
    if onScreen then
        local vs = ESP.Camera.ViewportSize
        return pos.X >= -50 and pos.X <= vs.X + 50 and pos.Y >= -50 and pos.Y <= vs.Y + 50
    end
    return false
end

local function GetRolesData()
    if tick() - ESP.RolesCacheTime < 0.5 then return ESP.RolesData end
    local ok, result = pcall(function()
        local gd = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
        if gd and gd:IsA("RemoteFunction") then return gd:InvokeServer() end
        return {}
    end)
    if ok and result then
        ESP.RolesData = result
        ESP.RolesCacheTime = tick()
    end
    return ESP.RolesData
end

local function IsAlive(player, roles)
    if not roles then return false end
    local d = roles[player.Name]
    if d then return not d.Killed and not d.Dead end
    return false
end

local function getPlayerRole(player, roles)
    if not roles then return nil, false end
    local d = roles[player.Name]
    if not d then return nil, false end
    return d.Role, IsAlive(player, roles)
end

local function GetPlayerColorByRole(role, alive)
    if not alive then return Color3.fromRGB(150, 150, 150) end
    if role == "Murderer" then return Color3.fromRGB(255, 0, 0) end
    if role == "Sheriff" then return Color3.fromRGB(0, 0, 255) end
    if role == "Hero" then return Color3.fromRGB(255, 255, 0) end
    if role == "Innocent" then return Color3.fromRGB(0, 255, 0) end
    return Color3.fromRGB(255, 255, 255)
end

local function updatePlayerBillboard(player, role, alive)
    if player == LocalPlayer then return end
    local char = player.Character
    if not char then return end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return end
    local color = GetPlayerColorByRole(role, alive)
    local bb = hrp:FindFirstChild("DustWayBillboard")
    if bb then
        local nl = bb:FindFirstChild("PlayerName")
        if nl then nl.TextColor3 = color; nl.Text = player.Name; return end
    else
        local newBb = Instance.new("BillboardGui")
        newBb.Name = "DustWayBillboard"
        newBb.Adornee = hrp
        newBb.AlwaysOnTop = true
        newBb.Size = UDim2.new(0, 100, 0, 30)
        newBb.StudsOffset = Vector3.new(0, 2.5, 0)
        newBb.ResetOnSpawn = false
        local lbl = Instance.new("TextLabel")
        lbl.Name = "PlayerName"
        lbl.Size = UDim2.new(1, 0, 1, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text = player.Name
        lbl.TextColor3 = color
        lbl.Font = Enum.Font.GothamBold
        lbl.TextSize = 14
        lbl.TextStrokeTransparency = 0.5
        lbl.TextStrokeColor3 = Color3.new(0, 0, 0)
        lbl.Parent = newBb
        newBb.Parent = hrp
        ESP.billboards[player] = newBb
    end
end

local function removePlayerBillboard(player)
    if player == LocalPlayer then return end
    if ESP.billboards[player] then ESP.billboards[player]:Destroy(); ESP.billboards[player] = nil end
    local char = player.Character
    if char then
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if hrp then
            local bb = hrp:FindFirstChild("DustWayBillboard")
            if bb then bb:Destroy() end
        end
    end
end

local function clearAllESP()
    for _, bb in pairs(ESP.billboards) do if bb and bb.Parent then bb:Destroy() end end
    ESP.billboards = {}
end

local function updatePlayerHighlight(player, role, alive)
    if player == LocalPlayer then return end
    local char = player.Character
    if not char then return end
    local hl = char:FindFirstChild("DustWayHighlight")
    if not hl or not hl:IsA("Highlight") then
        if hl then hl:Destroy() end
        hl = Instance.new("Highlight")
        hl.Name = "DustWayHighlight"
        hl.Adornee = char
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.FillTransparency = 0.7
        hl.OutlineTransparency = 0.4
        hl.OutlineColor = Color3.new(1, 1, 1)
        hl.Parent = char
    end
    hl.FillColor = GetPlayerColorByRole(role, alive)
end

local function removePlayerHighlight(player)
    if player == LocalPlayer then return end
    local char = player.Character
    if char then
        local h = char:FindFirstChild("DustWayHighlight")
        if h then h:Destroy() end
    end
end

local function clearAllHighlights()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then removePlayerHighlight(p) end
    end
end

local function updateESP()
    if not ESP_STATES.ESPName then clearAllESP(); return end
    local roles = GetRolesData()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            if not char or not hrp then removePlayerBillboard(p)
            elseif not IsPlayerOnScreen(p) then removePlayerBillboard(p)
            else
                local role, alive = getPlayerRole(p, roles)
                local show = false
                if role == "Murderer" and ESP_STATES.MurdererName then show = true
                elseif role == "Sheriff" and ESP_STATES.SheriffName then show = true
                elseif role == "Hero" and ESP_STATES.HeroName then show = true
                elseif role == "Innocent" and ESP_STATES.InnocentName then show = true
                elseif not role then show = true end
                if show then updatePlayerBillboard(p, role, alive) else removePlayerBillboard(p) end
            end
        end
    end
end

local function updateHighlights()
    if not ESP_HIGHLIGHT_STATES.ESPHighlight then clearAllHighlights(); return end
    local roles = GetRolesData()
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            if not p.Character or not IsPlayerOnScreen(p) then removePlayerHighlight(p)
            else
                local role, alive = getPlayerRole(p, roles)
                local show = false
                if role == "Murderer" and ESP_HIGHLIGHT_STATES.ESPHighlightMurderer then show = true
                elseif role == "Sheriff" and ESP_HIGHLIGHT_STATES.ESPHighlightSheriff then show = true
                elseif role == "Hero" and ESP_HIGHLIGHT_STATES.ESPHighlightHero then show = true
                elseif role == "Innocent" and ESP_HIGHLIGHT_STATES.ESPHighlightInnocent then show = true end
                if show then updatePlayerHighlight(p, role, alive) else removePlayerHighlight(p) end
            end
        end
    end
end

-- ============================================================
-- KILL ALL
-- ============================================================

local function getPlayerRoleFromServer(player)
    local gd = ReplicatedStorage:FindFirstChild("GetPlayerData", true)
    if gd and gd:IsA("RemoteFunction") then
        local data = gd:InvokeServer()
        if data and data[player.Name] then return data[player.Name].Role end
    end
    return nil
end

local function hasKnife()
    local char = LocalPlayer.Character
    if not char then return false end
    if char:FindFirstChild("Knife") then return true end
    local k = LocalPlayer.Backpack:FindFirstChild("Knife")
    if k then k.Parent = char; return true end
    return false
end

local function equipKnife()
    local bp = LocalPlayer:FindFirstChild("Backpack")
    local char = LocalPlayer.Character
    if not char then return false end
    local k = (bp and bp:FindFirstChild("Knife")) or char:FindFirstChild("Knife")
    if k then
        if char ~= k.Parent then k.Parent = char end
        return true
    end
    return false
end

local function getAllValidTargets()
    local t = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            local role = getPlayerRoleFromServer(p)
            local hum = p.Character:FindFirstChild("Humanoid")
            if role and hum and hum.Health > 0 and table.find(VALID_TARGET_ROLES, role) then
                table.insert(t, p)
            end
        end
    end
    return t
end

local function killAllPlayers()
    if not KillAll.Enabled then return end
    if not equipKnife() then return end
    task.wait(0.1)
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    if remotes then
        local gp = remotes:FindFirstChild("Gameplay")
        if gp then remotes = gp:FindFirstChild("KillEvent") end
    end
    local killEvent = remotes
    if not killEvent then return end
    local targets = getAllValidTargets()
    local hrp = getHRP()
    if not hrp then return end
    for _, p in ipairs(targets) do
        if not KillAll.Enabled then return end
        local char = p.Character
        if char and char:FindFirstChild("Humanoid") and char.Humanoid.Health > 0 and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = hrp.CFrame * CFrame.new(0, 0, -3)
            pcall(function() killEvent:FireServer(p.Name, Color3.new(1, 0, 0)) end)
            task.wait(KillAll.AttackDelay or 0.2)
        end
    end
end

-- ============================================================
-- ANTI-FLING
-- ============================================================

local function enableAntiFling()
    if AntiFling.Enabled then return end
    AntiFling.Enabled = true
    local lp = LocalPlayer
    local char = lp.Character or lp.CharacterAdded:Wait()
    local hum = char:WaitForChild("Humanoid")
    hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false)
    local function dc()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= lp and p.Character then
                for _, d in ipairs(p.Character:GetDescendants()) do
                    if d:IsA("BasePart") and not d.Anchored then d.CanCollide = false end
                end
            end
        end
    end
    dc()
    local thread = task.spawn(function()
        while AntiFling.Enabled do
            task.wait(0.3)
            if not char or not char.Parent then
                char = lp.Character
                if char then
                    hum = char:FindFirstChild("Humanoid")
                    if hum then hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false) end
                end
            end
            dc()
        end
    end)
    local pa = Players.PlayerAdded:Connect(function(p)
        if p ~= lp then
            p.CharacterAdded:Connect(function(c)
                task.wait(0.2)
                if AntiFling.Enabled then
                    for _, d in ipairs(c:GetDescendants()) do
                        if d:IsA("BasePart") and not d.Anchored then d.CanCollide = false end
                    end
                end
            end)
        end
    end)
    local ca = lp.CharacterAdded:Connect(function(c)
        char = c
        hum = char:FindFirstChild("Humanoid")
        if hum and AntiFling.Enabled then hum:SetStateEnabled(Enum.HumanoidStateType.Seated, false) end
        task.wait(0.2)
        if AntiFling.Enabled then dc() end
    end)
    AntiFling.Connections = {task = thread, playerAdded = pa, characterAdded = ca}
end

local function disableAntiFling()
    if not AntiFling.Enabled then return end
    AntiFling.Enabled = false
    local c = AntiFling.Connections
    if c then
        if c.task then task.cancel(c.task) end
        if c.playerAdded then c.playerAdded:Disconnect() end
        if c.characterAdded then c.characterAdded:Disconnect() end
    end
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            for _, d in ipairs(p.Character:GetDescendants()) do
                if d:IsA("BasePart") then d.CanCollide = true end
            end
        end
    end
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum:SetStateEnabled(Enum.HumanoidStateType.Seated, true) end
    end
    AntiFling.Connections = nil
end

-- ============================================================
-- CHINA HAT
-- ============================================================

local function CreateHat(Character)
    local Head = Character:FindFirstChild("Head")
    if not Head then return end
    local Cone = Instance.new("Part")
    Cone.Size = Vector3.new(1, 1, 1)
    Cone.BrickColor = BrickColor.new("Hot pink")
    Cone.Material = Enum.Material.Neon
    Cone.Transparency = 0.2
    Cone.Anchored = false
    Cone.CanCollide = false
    Cone.Color = ChinaHatSettings.hatColor
    Cone.Name = "DustWayHat"
    local Mesh = Instance.new("SpecialMesh")
    Mesh.MeshType = Enum.MeshType.FileMesh
    Mesh.MeshId = "rbxassetid://1033714"
    Mesh.Scale = ChinaHatSettings.scale
    Mesh.Parent = Cone
    local Weld = Instance.new("Weld")
    Weld.Part0 = Head
    Weld.Part1 = Cone
    Weld.C0 = CFrame.new(0, 0.9, 0)
    Weld.Parent = Cone
    local Light = Instance.new("PointLight")
    Light.Color = ChinaHatSettings.lightColor
    Light.Brightness = ChinaHatSettings.lightBrightness
    Light.Range = ChinaHatSettings.lightRange
    Light.Shadows = true
    Light.Parent = Cone
    Cone.Parent = Character
end

local function OnCharacterAdded(Character)
    if ChinaHatSettings.enabled then
        Character:WaitForChild("Head")
        CreateHat(Character)
    end
end

LocalPlayer.CharacterAdded:Connect(OnCharacterAdded)
if LocalPlayer.Character then OnCharacterAdded(LocalPlayer.Character) end

-- ============================================================
-- MOVEMENT
-- ============================================================

local function updateWalkSpeed()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.WalkSpeed = Movement.SpeedWalk.Enabled and Movement.SpeedWalk.Value or DEFAULT_WALK_SPEED
        end
    end
end

local function updateJumpPower()
    local char = LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.JumpPower = Movement.JumpPower.Enabled and Movement.JumpPower.Value or DEFAULT_JUMP_POWER
        end
    end
end

-- ============================================================
-- BUILD UI
-- ============================================================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DustWayDashboard"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = false
ScreenGui.Parent = guiParent
protectgui(ScreenGui)

-- Trigger Button
local TriggerBtn = Instance.new("ImageButton")
TriggerBtn.Name = "TriggerBtn"
TriggerBtn.Size = UDim2.new(0, 52, 0, 52)
TriggerBtn.Position = UDim2.new(0, 20, 1, -72)
TriggerBtn.BackgroundColor3 = CONFIG.BG_SIDEBAR
TriggerBtn.AutoButtonColor = false
TriggerBtn.ZIndex = 10
TriggerBtn.Parent = ScreenGui
makeCorner(TriggerBtn, 10)
makeStroke(TriggerBtn, CONFIG.BORDER_GLOW, 1)

local TriggerIcon = Instance.new("TextLabel")
TriggerIcon.Size = UDim2.new(1, 0, 1, 0)
TriggerIcon.BackgroundTransparency = 1
TriggerIcon.Text = "⬡"
TriggerIcon.TextSize = 24
TriggerIcon.TextColor3 = CONFIG.TEXT_PRIMARY
TriggerIcon.Font = Enum.Font.GothamBold
TriggerIcon.TextXAlignment = Enum.TextXAlignment.Center
TriggerIcon.TextYAlignment = Enum.TextYAlignment.Center
TriggerIcon.Parent = TriggerBtn

-- Dashboard Frame
local Dashboard = Instance.new("Frame")
Dashboard.Name = "Dashboard"
Dashboard.BackgroundColor3 = CONFIG.BG_DARK
Dashboard.BackgroundTransparency = 0
Dashboard.Visible = false
Dashboard.ZIndex = 5

local function updateLayout()
    if isMobile() then
        Dashboard.Size = UDim2.new(0.96, 0, 0.72, 0)
        Dashboard.Position = UDim2.new(0.02, 0, 0.14, 0)
    else
        Dashboard.Size = UDim2.new(0, 680, 0, 420)
        Dashboard.Position = UDim2.new(0.5, -340, 0.5, -210)
    end
end

updateLayout()
Dashboard.Parent = ScreenGui
makeCorner(Dashboard, 14)
makeStroke(Dashboard, CONFIG.BORDER, 1)

-- Top Line
local TopLine = Instance.new("Frame")
TopLine.Size = UDim2.new(0.45, 0, 0, 1)
TopLine.Position = UDim2.new(0.27, 0, 0, 0)
TopLine.BackgroundColor3 = CONFIG.BORDER_GLOW
TopLine.BorderSizePixel = 0
TopLine.ZIndex = 6
TopLine.Parent = Dashboard

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.BackgroundColor3 = CONFIG.BG_SIDEBAR
Sidebar.BorderSizePixel = 0
Sidebar.ZIndex = 6

if isMobile() then
    Sidebar.Size = UDim2.new(1, 0, 0, 48)
    Sidebar.Position = UDim2.new(0, 0, 0, 0)
else
    Sidebar.Size = UDim2.new(0, 160, 1, 0)
    Sidebar.Position = UDim2.new(0, 0, 0, 0)
end

Sidebar.Parent = Dashboard

local SidebarBorder = Instance.new("Frame")
SidebarBorder.Size = UDim2.new(0, 1, 1, 0)
SidebarBorder.Position = UDim2.new(1, 0, 0, 0)
SidebarBorder.BackgroundColor3 = CONFIG.BORDER
SidebarBorder.BorderSizePixel = 0
SidebarBorder.ZIndex = 7
SidebarBorder.Parent = Sidebar

-- Logo
local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(0, 36, 0, 36)
LogoFrame.Position = UDim2.new(0, 14, 0, 14)
LogoFrame.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
LogoFrame.ZIndex = 7
LogoFrame.Parent = Sidebar
makeCorner(LogoFrame, 8)
makeStroke(LogoFrame, CONFIG.BORDER_GLOW, 1)

local LogoLabel = Instance.new("TextLabel")
LogoLabel.Size = UDim2.new(1, 0, 1, 0)
LogoLabel.BackgroundTransparency = 1
LogoLabel.Text = "⬡"
LogoLabel.TextSize = 18
LogoLabel.TextColor3 = CONFIG.TEXT_PRIMARY
LogoLabel.Font = Enum.Font.GothamBold
LogoLabel.TextXAlignment = Enum.TextXAlignment.Center
LogoLabel.ZIndex = 8
LogoLabel.Parent = LogoFrame

-- Navigation
local NAV_ITEMS = {
    {id = "home", icon = "🏠", label = "Главная"},
    {id = "esp", icon = "👁", label = "ESP"},
    {id = "combat", icon = "⚔", label = "Бой"},
    {id = "farm", icon = "📦", label = "Автофарм"},
    {id = "visuals", icon = "🎨", label = "Визуал"},
    {id = "settings", icon = "⚙", label = "Настройки"},
}

local PAGE_DATA = {
    home = {title = "DustWay Hub", sub = "MM2 — Dashboard"},
    esp = {title = "ESP", sub = "Визуализация игроков"},
    combat = {title = "Бой", sub = "Боевые функции"},
    farm = {title = "Автофарм", sub = "Автоматический фарм монет"},
    visuals = {title = "Визуал", sub = "Косметические функции"},
    settings = {title = "Настройки", sub = "Параметры хаба"},
}

local NavList = Instance.new("Frame")
NavList.Name = "NavList"
NavList.BackgroundTransparency = 1
NavList.ZIndex = 7

if isMobile() then
    NavList.Size = UDim2.new(1, -160, 1, 0)
    NavList.Position = UDim2.new(0, 64, 0, 0)
    local ug = Instance.new("UIGridLayout")
    ug.FillDirection = Enum.FillDirection.Horizontal
    ug.CellSize = UDim2.new(0, 48, 1, 0)
    ug.CellPadding = UDim2.new(0, 2, 0, 0)
    ug.HorizontalAlignment = Enum.HorizontalAlignment.Left
    ug.VerticalAlignment = Enum.VerticalAlignment.Center
    ug.Parent = NavList
else
    NavList.Size = UDim2.new(1, 0, 1, -80)
    NavList.Position = UDim2.new(0, 0, 0, 68)
    local ul = Instance.new("UIListLayout")
    ul.FillDirection = Enum.FillDirection.Vertical
    ul.Padding = UDim.new(0, 2)
    ul.Parent = NavList
end

NavList.Parent = Sidebar

local navButtons = {}
local currentPage = "home"

local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "Content"
ContentFrame.BackgroundTransparency = 1
ContentFrame.ZIndex = 6

if isMobile() then
    ContentFrame.Size = UDim2.new(1, -16, 1, -60)
    ContentFrame.Position = UDim2.new(0, 8, 0, 54)
else
    ContentFrame.Size = UDim2.new(1, -172, 1, 0)
    ContentFrame.Position = UDim2.new(0, 168, 0, 0)
end

ContentFrame.Parent = Dashboard

local contentList = Instance.new("UIListLayout")
contentList.FillDirection = Enum.FillDirection.Vertical
contentList.Padding = UDim.new(0, 12)
contentList.Parent = ContentFrame

local contentPad = Instance.new("UIPadding")
contentPad.PaddingTop = UDim.new(0, 18)
contentPad.PaddingBottom = UDim.new(0, 14)
contentPad.PaddingRight = UDim.new(0, 16)
contentPad.Parent = ContentFrame

-- Title Block
local TitleBlock = Instance.new("Frame")
TitleBlock.Size = UDim2.new(1, 0, 0, 46)
TitleBlock.BackgroundTransparency = 1
TitleBlock.ZIndex = 7
TitleBlock.Parent = ContentFrame

local PageTitle = makeLabel(TitleBlock, "DustWay Hub", 20, CONFIG.TEXT_PRIMARY, true)
PageTitle.Position = UDim2.new(0, 0, 0, 0)
PageTitle.ZIndex = 8

local PageSub = makeLabel(TitleBlock, "MM2 — Dashboard", 11, CONFIG.TEXT_SUB)
PageSub.Position = UDim2.new(0, 0, 0, 26)
PageSub.ZIndex = 8
PageSub.TextWrapped = true

-- Page Container
local PageContainer = Instance.new("ScrollingFrame")
PageContainer.Name = "PageContainer"
PageContainer.Size = UDim2.new(1, 0, 1, -46)
PageContainer.Position = UDim2.new(0, 0, 0, 46)
PageContainer.BackgroundTransparency = 1
PageContainer.BorderSizePixel = 0
PageContainer.ScrollBarThickness = 0
PageContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
PageContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
PageContainer.ZIndex = 7
PageContainer.Parent = ContentFrame

local pageLayout = Instance.new("UIListLayout")
pageLayout.FillDirection = Enum.FillDirection.Vertical
pageLayout.Padding = UDim.new(0, 10)
pageLayout.Parent = PageContainer

-- Build a container for each page
local Pages = {}
for _, item in ipairs(NAV_ITEMS) do
    local page = Instance.new("Frame")
    page.Name = "Page_" .. item.id
    page.Size = UDim2.new(1, 0, 0, 0)
    page.AutomaticSize = Enum.AutomaticSize.Y
    page.BackgroundTransparency = 1
    page.Visible = (item.id == "home")
    page.ZIndex = 8
    page.Parent = PageContainer

    local pl = Instance.new("UIListLayout")
    pl.FillDirection = Enum.FillDirection.Vertical
    pl.Padding = UDim.new(0, 10)
    pl.Parent = page

    Pages[item.id] = page
end

local function setPage(pageId)
    if pageId == currentPage then return end
    currentPage = pageId
    if PAGE_DATA[pageId] then
        tween(PageTitle, {TextTransparency = 0.6}, 0.08)
        task.delay(0.08, function()
            PageTitle.Text = PAGE_DATA[pageId].title
            PageSub.Text = PAGE_DATA[pageId].sub
            tween(PageTitle, {TextTransparency = 0}, 0.12)
        end)
    end
    for id, page in Pages do
        page.Visible = (id == pageId)
    end
    for id, btn in navButtons do
        if id == pageId then
            tween(btn, {BackgroundColor3 = CONFIG.BG_ACTIVE, BackgroundTransparency = 0})
        else
            tween(btn, {BackgroundColor3 = CONFIG.BG_SIDEBAR, BackgroundTransparency = 1})
        end
    end
end

for _, item in ipairs(NAV_ITEMS) do
    local btn = Instance.new("TextButton")
    btn.Name = item.id
    btn.BackgroundTransparency = item.id == "home" and 0 or 1
    btn.BackgroundColor3 = item.id == "home" and CONFIG.BG_ACTIVE or CONFIG.BG_SIDEBAR
    btn.AutoButtonColor = false
    btn.ZIndex = 8

    if isMobile() then
        btn.Size = UDim2.new(0, 48, 1, 0)
        btn.Text = item.icon
        btn.TextSize = 18
        btn.Font = Enum.Font.GothamBold
        btn.TextColor3 = CONFIG.TEXT_PRIMARY
        btn.TextXAlignment = Enum.TextXAlignment.Center
    else
        btn.Size = UDim2.new(1, 0, 0, 38)
        btn.Text = item.icon .. "  " .. item.label
        btn.TextSize = 13
        btn.Font = Enum.Font.Gotham
        btn.TextColor3 = item.id == "home" and CONFIG.TEXT_PRIMARY or CONFIG.TEXT_SUB
        btn.TextXAlignment = Enum.TextXAlignment.Left
        local pad = Instance.new("UIPadding")
        pad.PaddingLeft = UDim.new(0, 14)
        pad.Parent = btn
    end

    makeCorner(btn, 6)

    btn.MouseEnter:Connect(function()
        if btn.Name ~= currentPage then tween(btn, {BackgroundTransparency = 0.6}) end
    end)
    btn.MouseLeave:Connect(function()
        if btn.Name ~= currentPage then tween(btn, {BackgroundTransparency = 1}) end
    end)
    btn.Activated:Connect(function() setPage(item.id) end)

    navButtons[item.id] = btn
    btn.Parent = NavList
end

-- ============================================================
-- TAB: HOME (Dashboard)
-- ============================================================

local function createCard(parent, title, desc, icon, callback)
    local card = Instance.new("TextButton")
    card.Size = UDim2.new(1, 0, 0, 60)
    card.BackgroundColor3 = CONFIG.BG_CARD
    card.AutoButtonColor = false
    card.Text = ""
    card.ZIndex = 8
    card.Parent = parent
    makeCorner(card, 10)
    makeStroke(card, CONFIG.BORDER, 1)
    makePadding(card, 12)

    local row = Instance.new("Frame")
    row.Size = UDim2.new(1, 0, 1, 0)
    row.BackgroundTransparency = 1
    row.ZIndex = 9
    row.Parent = card

    local iconL = Instance.new("TextLabel")
    iconL.Size = UDim2.new(0, 40, 1, 0)
    iconL.BackgroundTransparency = 1
    iconL.Text = icon
    iconL.TextSize = 24
    iconL.TextColor3 = CONFIG.TEXT_PRIMARY
    iconL.Font = Enum.Font.GothamBold
    iconL.ZIndex = 10
    iconL.Parent = row

    local titleL = makeLabel(row, title, 14, CONFIG.TEXT_PRIMARY, true)
    titleL.Position = UDim2.new(0, 48, 0, 2)
    titleL.Size = UDim2.new(1, -48, 0, 18)
    titleL.ZIndex = 10

    local descL = makeLabel(row, desc, 10, CONFIG.TEXT_SUB)
    descL.Position = UDim2.new(0, 48, 0, 22)
    descL.Size = UDim2.new(1, -48, 0, 14)
    descL.TextWrapped = true
    descL.ZIndex = 10

    card.MouseEnter:Connect(function() tween(card, {BackgroundColor3 = CONFIG.BG_ACTIVE}) end)
    card.MouseLeave:Connect(function() tween(card, {BackgroundColor3 = CONFIG.BG_CARD}) end)
    card.Activated:Connect(function() if callback then callback() end end)

    return card
end

createCard(Pages.home, "Автофарм", "Автоматический сбор монет", "📦", function() setPage("farm") end)
createCard(Pages.home, "ESP", "Подсветка игроков по ролям", "👁", function() setPage("esp") end)
createCard(Pages.home, "Бой", "Auto-Shoot, Kill All, Fake Bomb", "⚔", function() setPage("combat") end)
createCard(Pages.home, "Визуал", "China Hat и косметика", "🎨", function() setPage("visuals") end)
createCard(Pages.home, "Настройки", "Speed, Jump, Anti-Fling", "⚙", function() setPage("settings") end)

-- ============================================================
-- TAB: ESP
-- ============================================================

local function createToggle(parent, title, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 42)
    frame.BackgroundColor3 = CONFIG.BG_CARD
    frame.ZIndex = 8
    frame.Parent = parent
    makeCorner(frame, 8)
    makeStroke(frame, CONFIG.BORDER, 1)

    local lbl = makeLabel(frame, title, 13, CONFIG.TEXT_PRIMARY)
    lbl.Position = UDim2.new(0, 12, 0, 12)
    lbl.Size = UDim2.new(1, -70, 0, 18)
    lbl.ZIndex = 9

    local toggleBg = Instance.new("Frame")
    toggleBg.Size = UDim2.new(0, 40, 0, 20)
    toggleBg.Position = UDim2.new(1, -52, 0.5, -10)
    toggleBg.BackgroundColor3 = default and CONFIG.STATUS_GREEN or Color3.fromRGB(60, 60, 65)
    toggleBg.ZIndex = 9
    toggleBg.Parent = frame
    makeCorner(toggleBg, 10)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 16, 0, 16)
    knob.Position = default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.ZIndex = 10
    knob.Parent = toggleBg
    makeCorner(knob, 8)

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 11
    btn.Parent = frame

    local state = default
    btn.Activated:Connect(function()
        state = not state
        tween(toggleBg, {BackgroundColor3 = state and CONFIG.STATUS_GREEN or Color3.fromRGB(60, 60, 65)}, 0.2)
        tween(knob, {Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}, 0.2)
        if callback then callback(state) end
    end)

    return frame
end

local function createSlider(parent, title, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 55)
    frame.BackgroundColor3 = CONFIG.BG_CARD
    frame.ZIndex = 8
    frame.Parent = parent
    makeCorner(frame, 8)
    makeStroke(frame, CONFIG.BORDER, 1)

    local lbl = makeLabel(frame, title, 13, CONFIG.TEXT_PRIMARY)
    lbl.Position = UDim2.new(0, 12, 0, 6)
    lbl.Size = UDim2.new(1, -70, 0, 18)
    lbl.ZIndex = 9

    local valLbl = makeLabel(frame, tostring(default), 13, CONFIG.TEXT_PRIMARY, true)
    valLbl.Position = UDim2.new(1, -60, 0, 6)
    valLbl.Size = UDim2.new(0, 48, 0, 18)
    valLbl.TextXAlignment = Enum.TextXAlignment.Right
    valLbl.ZIndex = 9

    local track = Instance.new("Frame")
    track.Size = UDim2.new(1, -24, 0, 6)
    track.Position = UDim2.new(0, 12, 0, 38)
    track.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
    track.ZIndex = 9
    track.Parent = frame
    makeCorner(track, 3)

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.BackgroundColor3 = CONFIG.STATUS_GREEN
    fill.ZIndex = 10
    fill.Parent = track
    makeCorner(fill, 3)

    local knob = Instance.new("Frame")
    knob.Size = UDim2.new(0, 14, 0, 14)
    knob.Position = UDim2.new((default - min) / (max - min), -7, 0.5, -7)
    knob.BackgroundColor3 = Color3.new(1, 1, 1)
    knob.ZIndex = 11
    knob.Parent = track
    makeCorner(knob, 7)

    local dragging = false
    local function updateValue(input)
        local rel = math.clamp((input.Position.X - track.AbsolutePosition.X) / track.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * rel)
        fill.Size = UDim2.new(rel, 0, 1, 0)
        knob.Position = UDim2.new(rel, -7, 0.5, -7)
        valLbl.Text = tostring(value)
        if callback then callback(value) end
    end

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 1, 0)
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.ZIndex = 12
    btn.Parent = track

    btn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            updateValue(input)
        end
    end)
    btn.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            updateValue(input)
        end
    end)

    return frame
end

-- ESP Page
createToggle(Pages.esp, "ESP Name", ESP_STATES.ESPName, function(v)
    ESP_STATES.ESPName = v
    if not v then clearAllESP() else updateESP() end
end)

createToggle(Pages.esp, "Murderer Name", ESP_STATES.MurdererName, function(v)
    ESP_STATES.MurdererName = v
    if ESP_STATES.ESPName then updateESP() end
end)

createToggle(Pages.esp, "Sheriff Name", ESP_STATES.SheriffName, function(v)
    ESP_STATES.SheriffName = v
    if ESP_STATES.ESPName then updateESP() end
end)

createToggle(Pages.esp, "Hero Name", ESP_STATES.HeroName, function(v)
    ESP_STATES.HeroName = v
    if ESP_STATES.ESPName then updateESP() end
end)

createToggle(Pages.esp, "Innocent Name", ESP_STATES.InnocentName, function(v)
    ESP_STATES.InnocentName = v
    if ESP_STATES.ESPName then updateESP() end
end)

createToggle(Pages.esp, "ESP Highlight", ESP_HIGHLIGHT_STATES.ESPHighlight, function(v)
    ESP_HIGHLIGHT_STATES.ESPHighlight = v
    if not v then clearAllHighlights() else updateHighlights() end
end)

createToggle(Pages.esp, "Murderer Highlight", ESP_HIGHLIGHT_STATES.ESPHighlightMurderer, function(v)
    ESP_HIGHLIGHT_STATES.ESPHighlightMurderer = v
    if ESP_HIGHLIGHT_STATES.ESPHighlight then updateHighlights() end
end)

createToggle(Pages.esp, "Sheriff Highlight", ESP_HIGHLIGHT_STATES.ESPHighlightSheriff, function(v)
    ESP_HIGHLIGHT_STATES.ESPHighlightSheriff = v
    if ESP_HIGHLIGHT_STATES.ESPHighlight then updateHighlights() end
end)

createToggle(Pages.esp, "Hero Highlight", ESP_HIGHLIGHT_STATES.ESPHighlightHero, function(v)
    ESP_HIGHLIGHT_STATES.ESPHighlightHero = v
    if ESP_HIGHLIGHT_STATES.ESPHighlight then updateHighlights() end
end)

createToggle(Pages.esp, "Innocent Highlight", ESP_HIGHLIGHT_STATES.ESPHighlightInnocent, function(v)
    ESP_HIGHLIGHT_STATES.ESPHighlightInnocent = v
    if ESP_HIGHLIGHT_STATES.ESPHighlight then updateHighlights() end
end)

-- ============================================================
-- TAB: COMBAT
-- ============================================================

local function createButton(parent, title, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, 0, 0, 42)
    btn.BackgroundColor3 = CONFIG.BG_CARD
    btn.Text = title
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = CONFIG.TEXT_PRIMARY
    btn.AutoButtonColor = false
    btn.ZIndex = 8
    btn.Parent = parent
    makeCorner(btn, 8)
    makeStroke(btn, CONFIG.BORDER, 1)

    btn.MouseEnter:Connect(function() tween(btn, {BackgroundColor3 = CONFIG.BG_ACTIVE}) end)
    btn.MouseLeave:Connect(function() tween(btn, {BackgroundColor3 = CONFIG.BG_CARD}) end)
    btn.Activated:Connect(function() if callback then callback() end end)

    return btn
end

createButton(Pages.combat, "🗡 Shoot Murderer", function()
    -- Shoot Murderer logic
    local function getMurderer()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Backpack:FindFirstChild("Knife") then return p end
        end
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Knife") then return p end
        end
        return nil
    end
    local function getSheriff()
        for _, p in ipairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Backpack:FindFirstChild("Gun") then return p end
        end
        for _, p in ipairs(Players:GetPlayers()) do
            if p.Character and p.Character:FindFirstChild("Gun") then return p end
        end
        return nil
    end
    if getSheriff() ~= LocalPlayer then
        print("[DustWay] Вы не Sheriff")
        return
    end
    local m = getMurderer()
    if not m or not m.Character then return end
    local char = LocalPlayer.Character
    if not char then return end
    local gun = char:FindFirstChild("Gun") or LocalPlayer.Backpack:FindFirstChild("Gun")
    if not gun then return end
    if char ~= gun.Parent then char.Humanoid:EquipTool(gun); task.wait(0.05) end
    local th = m.Character:FindFirstChild("HumanoidRootPart")
    if not th then return end
    local pred = th.Position + th.AssemblyLinearVelocity * Vector3.new(0.75, 0.5, 0.75) * (2.8 / 15) + m.Character.Humanoid.MoveDirection * 2.8
    local hand = char:FindFirstChild("RightHand")
    if not hand then return end
    pcall(function()
        gun:WaitForChild("Shoot"):FireServer(CFrame.new(hand.Position), CFrame.new(pred))
    end)
end)

createToggle(Pages.combat, "Auto Kill All", KillAll.Enabled, function(v)
    KillAll.Enabled = v
    if v then
        task.spawn(function()
            while KillAll.Enabled do
                if hasKnife() then
                    killAllPlayers()
                    task.wait(3)
                else
                    task.wait(1)
                end
            end
        end)
    end
end)

createButton(Pages.combat, "💣 Fake Bomb Jump", function()
    local char = LocalPlayer.Character
    if not char then return end
    local bp = LocalPlayer.Backpack
    local bomb = bp:FindFirstChild("FakeBomb") or char:FindFirstChild("FakeBomb")
    if not bomb then
        local r = ReplicatedStorage:FindFirstChild("Remotes")
        if r then
            local e = r:FindFirstChild("Extras")
            if e then
                local rep = e:FindFirstChild("ReplicateToy")
                if rep then pcall(function() rep:InvokeServer("FakeBomb") end) end
            end
        end
        bomb = bp:WaitForChild("FakeBomb", 5)
        if not bomb then return end
    end
    bomb.Parent = char
    local hum = char:FindFirstChild("Humanoid")
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if hum and hrp then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
        hum.JumpPower = 53
        if bomb:FindFirstChild("Remote") then
            bomb.Remote:FireServer(hrp.CFrame * CFrame.new(0, -3, 0), 50)
        end
        task.wait(0.3)
        if bomb and char == bomb.Parent then bomb.Parent = bp end
        if hum then hum.JumpPower = 51 end
    end
end)

createButton(Pages.combat, "🔫 Grab Gun", function()
    local hrp = getHRP()
    if not hrp then return end
    for _, child in pairs(workspace:GetChildren()) do
        if child:IsA("Model") and child:FindFirstChild("GunDrop") then
            local gun = child.GunDrop
            firetouchinterest(hrp, gun, 0)
            task.wait(0.1)
            firetouchinterest(hrp, gun, 1)
            return
        end
    end
end)

-- ============================================================
-- TAB: FARM
-- ============================================================

createToggle(Pages.farm, "Auto Farm", Settings.AutoFarmEnabled, function(v)
    Settings.AutoFarmEnabled = v
    AutoFarm.Enabled = v
    if v then startFarming() else stopFarming() end
end)

createSlider(Pages.farm, "Tween Speed", 10, 100, Settings.TweenSpeed, function(v) Settings.TweenSpeed = v end)
createSlider(Pages.farm, "Coin Limit", 10, 100, Settings.CoinLimit, function(v) Settings.CoinLimit = v end)
createSlider(Pages.farm, "Max Distance", 100, 1000, Settings.MaxDistance, function(v) Settings.MaxDistance = v end)
createSlider(Pages.farm, "Underground Offset", 1, 10, Settings.UndergroundOffset, function(v) Settings.UndergroundOffset = v end)

createToggle(Pages.farm, "Auto Reset", Settings.AutoReset, function(v) Settings.AutoReset = v end)
createToggle(Pages.farm, "Avoid Murder", Settings.AvoidMurder, function(v) Settings.AvoidMurder = v end)

-- ============================================================
-- TAB: VISUALS
-- ============================================================

createToggle(Pages.visuals, "Enable China Hat", ChinaHatSettings.enabled, function(v)
    ChinaHatSettings.enabled = v
    local char = LocalPlayer.Character
    if char then
        if v then
            char:WaitForChild("Head")
            CreateHat(char)
        else
            local hat = char:FindFirstChild("DustWayHat")
            if hat then hat:Destroy() end
        end
    end
end)

createSlider(Pages.visuals, "Light Brightness", 0, 10, ChinaHatSettings.lightBrightness, function(v)
    ChinaHatSettings.lightBrightness = v
    local char = LocalPlayer.Character
    if char then
        local hat = char:FindFirstChild("DustWayHat")
        if hat then
            local light = hat:FindFirstChildOfClass("PointLight")
            if light then light.Brightness = v end
        end
    end
end)

createSlider(Pages.visuals, "Light Range", 1, 30, ChinaHatSettings.lightRange, function(v)
    ChinaHatSettings.lightRange = v
    local char = LocalPlayer.Character
    if char then
        local hat = char:FindFirstChild("DustWayHat")
        if hat then
            local light = hat:FindFirstChildOfClass("PointLight")
            if light then light.Range = v end
        end
    end
end)

-- ============================================================
-- TAB: SETTINGS
-- ============================================================

createToggle(Pages.settings, "Speed Walk", false, function(v)
    Movement.SpeedWalk.Enabled = v
    updateWalkSpeed()
end)

createSlider(Pages.settings, "Speed Value", 16, 116, 16, function(v)
    Movement.SpeedWalk.Value = v
    if Movement.SpeedWalk.Enabled then updateWalkSpeed() end
end)

createToggle(Pages.settings, "Jump Power", false, function(v)
    Movement.JumpPower.Enabled = v
    updateJumpPower()
end)

createSlider(Pages.settings, "Jump Value", 50, 150, 50, function(v)
    Movement.JumpPower.Value = v
    if Movement.JumpPower.Enabled then updateJumpPower() end
end)

createToggle(Pages.settings, "Anti-Fling", false, function(v)
    if v then enableAntiFling() else disableAntiFling() end
end)

-- Info
local infoFrame = Instance.new("Frame")
infoFrame.Size = UDim2.new(1, 0, 0, 100)
infoFrame.BackgroundColor3 = CONFIG.BG_CARD
infoFrame.ZIndex = 8
infoFrame.Parent = Pages.settings
makeCorner(infoFrame, 8)
makeStroke(infoFrame, CONFIG.BORDER, 1)

local infoLbl = makeLabel(infoFrame, "Player: " .. LocalPlayer.DisplayName .. "\nUsername: @" .. LocalPlayer.Name .. "\nUser ID: " .. tostring(LocalPlayer.UserId) .. "\nPlace ID: " .. tostring(game.PlaceId), 11, CONFIG.TEXT_SUB)
infoLbl.Position = UDim2.new(0, 12, 0, 12)
infoLbl.Size = UDim2.new(1, -24, 0, 80)
infoLbl.TextWrapped = true
infoLbl.ZIndex = 9

-- ============================================================
-- OPEN / CLOSE
-- ============================================================

local isOpen = false

local function openDashboard()
    isOpen = true
    Dashboard.Visible = true
    Dashboard.BackgroundTransparency = 1
    local targetPos = isMobile() and UDim2.new(0.02, 0, 0.14, 0) or UDim2.new(0.5, -340, 0.5, -210)
    Dashboard.Position = targetPos + UDim2.new(0, 0, 0, 30)
    tween(Dashboard, {BackgroundTransparency = 0}, 0.22)
    tween(Dashboard, {Position = targetPos}, 0.22)
end

local function closeDashboard()
    isOpen = false
    local targetPos = Dashboard.Position + UDim2.new(0, 0, 0, 20)
    tween(Dashboard, {BackgroundTransparency = 1, Position = targetPos}, 0.18)
    task.delay(0.2, function() Dashboard.Visible = false end)
end

TriggerBtn.Activated:Connect(function()
    if isOpen then closeDashboard() else openDashboard() end
end)

-- Keyboard
if not isMobile() then
    UserInputService.InputBegan:Connect(function(input, processed)
        if processed then return end
        if input.KeyCode == Enum.KeyCode.M then
            if isOpen then closeDashboard() else openDashboard() end
        end
        if input.KeyCode == Enum.KeyCode.Escape and isOpen then
            closeDashboard()
        end
    end)
end

-- ============================================================
-- ESP AUTO UPDATE
-- ============================================================

RunService.Heartbeat:Connect(function()
    if ESP_STATES.ESPName then updateESP() else clearAllESP() end
end)

RunService.Heartbeat:Connect(function()
    if ESP_HIGHLIGHT_STATES.ESPHighlight then updateHighlights() else clearAllHighlights() end
end)

Players.PlayerAdded:Connect(function(p)
    if p ~= LocalPlayer then
        p.CharacterAdded:Connect(function() task.wait(0.5); updateESP() end)
    end
end)

Players.PlayerRemoving:Connect(function(p)
    if p ~= LocalPlayer then
        removePlayerBillboard(p)
        removePlayerHighlight(p)
    end
end)

workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function()
    ESP.Camera = workspace.CurrentCamera
end)

-- Initial
updateWalkSpeed()
updateJumpPower()

print("[DustWay Dashboard] v1.0 loaded")
print("[DustWay] Нажмите M (ПК) или ⬡ (мобилка) чтобы открыть")