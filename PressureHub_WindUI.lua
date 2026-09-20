-- ════════════════════════════════════════════════════════════
--  PressureHub · Murder Mystery 2
--  UI: WindUI (Footagesus) · Тема: чёрно-красная
-- ════════════════════════════════════════════════════════════

local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

-- ── Чёрно-красная тема ──────────────────────────────────────
WindUI:AddTheme({
    Name       = "PressureRed",

    Accent     = Color3.fromHex("#DC2626"),   -- красный акцент
    Background = Color3.fromHex("#0A0A0C"),   -- почти чёрный
    Outline    = Color3.fromHex("#3B0A0A"),   -- тёмно-красный бордер
    Text       = Color3.fromHex("#F0F0F5"),   -- белый текст
    Placeholder= Color3.fromHex("#7A4040"),   -- приглушённый
    Button     = Color3.fromHex("#1F1010"),   -- кнопки
    Icon       = Color3.fromHex("#DC2626"),   -- иконки красные

    WindowBackground  = Color3.fromHex("#080809"),
    WindowShadow      = Color3.fromHex("#000000"),

    DialogBackground            = Color3.fromHex("#0D0D10"),
    DialogBackgroundTransparency = 0,
    DialogTitle   = Color3.fromHex("#F0F0F5"),
    DialogContent = Color3.fromHex("#C0C0C5"),
    DialogIcon    = Color3.fromHex("#DC2626"),

    WindowTopbarButtonIcon = Color3.fromHex("#DC2626"),
    WindowTopbarTitle      = Color3.fromHex("#F0F0F5"),
    WindowTopbarAuthor     = Color3.fromHex("#7A4040"),
    WindowTopbarIcon       = Color3.fromHex("#DC2626"),

    TabBackground = Color3.fromHex("#100808"),
    TabTitle      = Color3.fromHex("#F0F0F5"),
    TabIcon       = Color3.fromHex("#DC2626"),

    ElementBackground = Color3.fromHex("#110A0A"),
    ElementTitle      = Color3.fromHex("#F0F0F5"),
    ElementDesc       = Color3.fromHex("#A08080"),
    ElementIcon       = Color3.fromHex("#DC2626"),

    PopupBackground            = Color3.fromHex("#0D0D10"),
    PopupBackgroundTransparency = 0,
    PopupTitle   = Color3.fromHex("#F0F0F5"),
    PopupContent = Color3.fromHex("#C0C0C5"),
    PopupIcon    = Color3.fromHex("#DC2626"),
})

WindUI:SetTheme("PressureRed")

-- ── Окно ────────────────────────────────────────────────────
local Window = WindUI:CreateWindow({
    Title   = "PressureHub",
    Author  = "MM2 AutoFarm",
    Icon    = "zap",
    Folder  = "PressureHub",
    Size    = UDim2.fromOffset(580, 460),
    Theme   = "PressureRed",
    HideSearchBar = true,

    OpenButton = {
        Title          = "PressureHub",
        CornerRadius   = UDim.new(0, 8),
        StrokeThickness = 2,
        Enabled        = true,
        Draggable      = true,
        OnlyMobile     = false,
        Color          = ColorSequence.new(
            Color3.fromHex("#DC2626"),
            Color3.fromHex("#7F1D1D")
        ),
    },
})

-- ════════════════════════════════════════════════════════════
--  AutoFarm логика
-- ════════════════════════════════════════════════════════════

local Players      = game:GetService("Players")
local RunService   = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local LocalPlayer  = Players.LocalPlayer

local AF = {
    Enabled     = false,
    FarmMode    = "Underground",
    TweenSpeed  = 25,
    AutoReset   = true,
    AvoidMurder = true,
    UGOffset    = 4,
    MaxDist     = 600,
    CoinLimit   = 40,
}

local State = {
    farming  = false,
    flying   = false,
    target   = nil,
    ignored  = {},
    tween    = nil,
}

local function getTorso(char)
    return char and (
        char:FindFirstChild("HumanoidRootPart") or
        char:FindFirstChild("LowerTorso") or
        char:FindFirstChild("Torso")
    )
end

local function getCurrentCoins()
    local ok, v = pcall(function()
        local pg  = LocalPlayer.PlayerGui
        local mg  = pg:FindFirstChild("MainGUI");       assert(mg)
        local gm  = mg:FindFirstChild("Game");          assert(gm)
        local cb  = gm:FindFirstChild("CoinBags");      assert(cb)
        local con = cb:FindFirstChild("Container");     assert(con)
        local co  = con:FindFirstChild("Coin");         assert(co)
        local cf  = co:FindFirstChild("CurrencyFrame"); assert(cf)
        local ic  = cf:FindFirstChild("Icon");          assert(ic)
        local ct  = ic:FindFirstChild("Coins");         assert(ct)
        return ct.Text
    end)
    return ok and (tonumber(v) or 0) or 0
end

local function isRoundOver()
    local pg = LocalPlayer:FindFirstChild("PlayerGui"); if not pg then return false end
    local vg = pg:FindFirstChild("Victory");            if not vg then return false end
    for _, c in pairs(vg:GetChildren()) do
        if c:IsA("GuiObject") and c.Visible then return true end
    end
    return false
end

local function isBagFull()
    local pg = LocalPlayer:FindFirstChild("PlayerGui"); if not pg then return false end
    local mg = pg:FindFirstChild("MainGUI");            if not mg then return false end
    local lb = mg:FindFirstChild("Lobby");              if not lb then return false end
    local dk = lb:FindFirstChild("Dock");               if not dk then return false end
    local cb = dk:FindFirstChild("CoinBags");           if not cb then return false end
    local fn = cb:FindFirstChild("FullBagNotification")
    return fn and fn.Visible or false
end

local function nearbyMurderer()
    if not AF.AvoidMurder then return false end
    local char = LocalPlayer.Character; if not char then return false end
    local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return false end
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

local function getNearestCoin(torso)
    local container
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "CoinContainer" then container = obj; break end
    end
    if not container then return nil end

    local best, bestDist = nil, math.huge
    for _, coin in pairs(container:GetChildren()) do
        if coin.Name == "Coin_Server" and coin:IsA("BasePart")
            and not State.ignored[coin] then
            local d = (torso.Position - coin.Position).Magnitude
            if d < bestDist and d <= AF.MaxDist then
                bestDist = d; best = coin
            end
        end
    end
    return best
end

local function removePhysics()
    local char = LocalPlayer.Character; if not char then return end
    local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    if hrp:FindFirstChild("FarmBV") then hrp.FarmBV:Destroy() end
    if hrp:FindFirstChild("FarmBG") then hrp.FarmBG:Destroy() end
end

local function applyFlight(hrp)
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
        local _, ry, _ = hrp.CFrame:ToOrientation()
        bg.CFrame = CFrame.new(hrp.Position)
            * CFrame.Angles(0, ry, 0)
            * CFrame.Angles(math.rad(-90), 0, 0)
    end
    return bg.CFrame.Rotation
end

local function setupNoclip(char)
    local hum = char:FindFirstChild("Humanoid")
    if hum then hum.PlatformStand = true end
    for _, p in pairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end
end

local function flyToPoint(targetPos, coin, hrp, torso, rot)
    local d    = (torso.Position - targetPos).Magnitude
    local info = TweenInfo.new(d / AF.TweenSpeed, Enum.EasingStyle.Linear)
    local tw   = TweenService:Create(hrp, info, { CFrame = CFrame.new(targetPos) * rot })
    State.tween = tw
    local reached = false
    tw:Play()

    local conn
    conn = RunService.Heartbeat:Connect(function()
        if not State.farming or not coin or not coin:IsDescendantOf(workspace) then
            tw:Cancel(); conn:Disconnect(); return
        end
        if firetouchinterest then
            pcall(firetouchinterest, torso, coin, 0)
            pcall(firetouchinterest, torso, coin, 1)
        end
        if (torso.Position - targetPos).Magnitude <= 1.5 then
            reached = true; tw:Cancel(); conn:Disconnect()
        end
    end)

    while conn.Connected do RunService.Heartbeat:Wait() end
    return reached
end

local function tweenSit(coin)
    if not coin or not coin.Parent or not coin:FindFirstChild("TouchInterest") then
        return false
    end
    local char = LocalPlayer.Character; if not char then return false end
    local hrp  = char:FindFirstChild("HumanoidRootPart")
    local hum  = char:FindFirstChildOfClass("Humanoid")
    if not hrp or not hum then return false end

    local target = coin.Position + Vector3.new(0, 2, 0)
    if (hrp.Position - target).Magnitude < 5 then return true end

    if State.tween then pcall(function() State.tween:Cancel() end) end

    local tw = TweenService:Create(hrp,
        TweenInfo.new((hrp.Position - target).Magnitude / AF.TweenSpeed,
            Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { CFrame = CFrame.new(target) }
    )
    State.tween = tw
    hum.Sit = true
    tw:Play()

    local done = false
    local c = tw.Completed:Connect(function() done = true end)
    local t0 = tick()

    while not done and State.farming do
        task.wait(0.1)
        if not coin or not coin.Parent then
            pcall(function() tw:Cancel() end)
            hum.Sit = false; c:Disconnect(); return false
        end
        if tick() - t0 > 30 then
            pcall(function() tw:Cancel() end)
            hum.Sit = false; c:Disconnect(); return false
        end
    end

    c:Disconnect(); hum.Sit = false
    return done
end

local function collectCoin(coin)
    local char = LocalPlayer.Character; if not char then return end
    local hrp  = char:FindFirstChild("HumanoidRootPart"); if not hrp then return end
    if firetouchinterest then
        pcall(firetouchinterest, hrp, coin, 0)
        task.wait(0.05)
        pcall(firetouchinterest, hrp, coin, 1)
    end
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
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then hum.PlatformStand = false; hum.Sit = false end
    end
end

local function startFarming()
    if State.farming then return end
    State.farming = true
    table.clear(State.ignored)

    task.spawn(function()
        while State.farming do
            task.wait()
            local ok, _ = pcall(function()

                if nearbyMurderer() then
                    State.flying = false; State.target = nil
                    removePhysics()
                    local c = LocalPlayer.Character
                    if c then
                        local h = c:FindFirstChild("Humanoid")
                        if h then h.Sit = false end
                    end
                    task.wait(1); return
                end

                local char = LocalPlayer.Character
                if not char then task.wait(1); return end
                local hrp   = char:FindFirstChild("HumanoidRootPart")
                local torso = getTorso(char)
                local hum   = char:FindFirstChild("Humanoid")
                if not hrp or not torso or not hum or hum.Health <= 0 then
                    removePhysics(); task.wait(1); return
                end

                if isRoundOver() or isBagFull() then
                    stopFarming(); return
                end

                if AF.AutoReset and getCurrentCoins() >= AF.CoinLimit then
                    hum.Health = 0; task.wait(5); return
                end

                local coin = getNearestCoin(torso)
                if not coin or not coin:IsDescendantOf(workspace) then
                    task.wait(0.5); return
                end

                State.flying = true; State.target = coin
                local reached = false

                if AF.FarmMode == "Underground" then
                    setupNoclip(char)
                    local rot = applyFlight(hrp)
                    local pos = coin.Position - Vector3.new(0, AF.UGOffset, 0)
                    reached   = flyToPoint(pos, coin, hrp, torso, rot)

                elseif AF.FarmMode == "Sit" then
                    reached = tweenSit(coin)
                    if reached and State.farming and hum.Health > 0 then
                        collectCoin(coin)
                    end
                end

                if reached and State.farming and hum.Health > 0 then
                    State.ignored[coin] = true
                    task.delay(5, function() State.ignored[coin] = nil end)
                    task.wait(0.2)
                end
                State.target = nil
            end)

            if not ok then
                State.flying = false; State.target = nil
                removePhysics(); task.wait(1)
            end
        end
    end)
end

-- Noclip keepalive
RunService.Stepped:Connect(function()
    if not State.farming or not State.flying
        or AF.FarmMode ~= "Underground" then return end
    local char = LocalPlayer.Character; if not char then return end
    local hum  = char:FindFirstChild("Humanoid")
    if hum then hum.PlatformStand = true end
    for _, p in pairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end
end)

-- ════════════════════════════════════════════════════════════
--  UI: Вкладки
-- ════════════════════════════════════════════════════════════

-- ── Вкладка 1: AutoFarm ─────────────────────────────────────
local TabFarm = Window:Tab({ Title = "AutoFarm", Icon = "coins" })

TabFarm:Toggle({
    Title    = "Автофарм монет",
    Desc     = "Автоматически собирает монеты",
    Icon     = "play",
    Default  = false,
    Callback = function(v)
        AF.Enabled = v
        if v then startFarming() else stopFarming() end
    end,
})

TabFarm:Toggle({
    Title    = "Авто-сброс",
    Desc     = "Сброс при достижении лимита монет",
    Icon     = "refresh-cw",
    Default  = true,
    Callback = function(v) AF.AutoReset = v end,
})

TabFarm:Toggle({
    Title    = "Избегать убийцу",
    Desc     = "Останавливается если рядом нож",
    Icon     = "shield",
    Default  = true,
    Callback = function(v) AF.AvoidMurder = v end,
})

TabFarm:Dropdown({
    Title   = "Режим фарма",
    Desc    = "Underground — под землёй, Sit — сидя",
    Icon    = "layers",
    Values  = { "Underground", "Sit" },
    Default = "Underground",
    Callback = function(v) AF.FarmMode = v end,
})

TabFarm:Slider({
    Title = "Скорость движения",
    Desc  = "Скорость tween к монете",
    Icon  = "gauge",
    Value = { Min = 5, Max = 150, Default = 25 },
    Callback = function(v) AF.TweenSpeed = v end,
})

TabFarm:Slider({
    Title = "Лимит монет (авто-сброс)",
    Desc  = "При скольких монетах сбрасываться",
    Icon  = "hash",
    Value = { Min = 5, Max = 100, Default = 40 },
    Callback = function(v) AF.CoinLimit = v end,
})

TabFarm:Slider({
    Title = "Макс. дистанция до монеты",
    Desc  = "Игнорировать монеты дальше этого",
    Icon  = "move",
    Value = { Min = 50, Max = 1000, Default = 600 },
    Callback = function(v) AF.MaxDist = v end,
})

TabFarm:Slider({
    Title = "Смещение Underground",
    Desc  = "На сколько studs уходить под землю",
    Icon  = "arrow-down",
    Value = { Min = 0, Max = 15, Default = 4 },
    Callback = function(v) AF.UGOffset = v end,
})

TabFarm:Button({
    Title    = "Остановить фарм",
    Desc     = "Принудительная остановка",
    Icon     = "square",
    Callback = function()
        stopFarming()
        WindUI:Notification({
            Title   = "PressureHub",
            Content = "Фарм остановлен.",
            Icon    = "x",
            Duration = 3,
        })
    end,
})

-- ── Вкладка 2: Настройки ────────────────────────────────────
local TabSettings = Window:Tab({ Title = "Настройки", Icon = "settings" })

TabSettings:Keybind({
    Title   = "Клавиша меню",
    Desc    = "Открыть / закрыть PressureHub",
    Icon    = "keyboard",
    Default = Enum.KeyCode.RightShift,
    Callback = function(key)
        Window:EditKeybind(key)
    end,
})

TabSettings:Button({
    Title    = "Выгрузить скрипт",
    Desc     = "Удалить UI и остановить всё",
    Icon     = "trash-2",
    Callback = function()
        stopFarming()
        WindUI:Destroy()
    end,
})

-- ── Приветственный попап ────────────────────────────────────
WindUI:Notification({
    Title   = "PressureHub",
    Content = "Загружен! RightShift — открыть меню.",
    Icon    = "zap",
    Duration = 5,
})
