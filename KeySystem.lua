--// PressureKeySustem — красно-чёрный дизайн
--// Логика (API, HWID, проверка, привязка) не изменена.

local HUB_NAME = "PressureKeySustem" -- название, показывается в окне

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

local API_CHECK = "https://keybot-rfgspl.mia0.amvera.tech/api/check"
local API_BIND  = "https://keybot-rfgspl.mia0.amvera.tech/api/bind"

local function getHWID()
    if getdeviceid then return tostring(getdeviceid()) end
    return tostring(lp.UserId)
end
local HWID = getHWID()

local function httpPost(url, body)
    local fn = nil
    if syn and syn.request then fn = syn.request
    elseif http_request then fn = http_request
    elseif request then fn = request end
    if not fn then return nil end
    local ok, res = pcall(fn, {
        Url = url, Method = "POST",
        Headers = {["Content-Type"] = "application/json"},
        Body = HttpService:JSONEncode(body),
    })
    if ok then return res end
    return nil
end

------------------------------------------------------------------
-- Тема (красный + чёрный)
------------------------------------------------------------------
local THEME = {
    bg           = Color3.fromRGB(14, 12, 12),
    bgDeep       = Color3.fromRGB(8, 7, 7),
    chip         = Color3.fromRGB(32, 12, 12),
    chipHover    = Color3.fromRGB(56, 16, 16),
    accent       = Color3.fromRGB(230, 40, 40),
    accentBright = Color3.fromRGB(255, 95, 85),
    accentDim    = Color3.fromRGB(115, 24, 24),
    border       = Color3.fromRGB(52, 32, 32),
    white        = Color3.fromRGB(255, 255, 255),
    muted        = Color3.fromRGB(150, 145, 145),
    faint        = Color3.fromRGB(85, 80, 80),
    ok           = Color3.fromRGB(80, 220, 100),
    err          = Color3.fromRGB(255, 75, 75),
    warn         = Color3.fromRGB(255, 170, 40),
}

------------------------------------------------------------------
-- Хелперы
------------------------------------------------------------------
local function make(class, props, parent)
    local o = Instance.new(class)
    for k, v in pairs(props) do o[k] = v end
    o.Parent = parent
    return o
end

local function round(o, r)
    return make("UICorner", {CornerRadius = r}, o)
end

local function stroke(o, color, thickness)
    return make("UIStroke", {
        Color = color,
        Thickness = thickness,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    }, o)
end

local function tw(o, t, props, style, dir)
    local tween = TweenService:Create(
        o,
        TweenInfo.new(t, style or Enum.EasingStyle.Quad, dir or Enum.EasingDirection.Out),
        props
    )
    tween:Play()
    return tween
end

local function viewport()
    local cam = workspace.CurrentCamera
    return cam and cam.ViewportSize or Vector2.new(1280, 720)
end

local function fitScale()
    local vp = viewport()
    return math.clamp(math.min(vp.X / 420, vp.Y / 500), 0.5, 1)
end

------------------------------------------------------------------
-- ScreenGui + фон
------------------------------------------------------------------
if pg:FindFirstChild("SmileHubKey") then pg.SmileHubKey:Destroy() end
if pg:FindFirstChild("PressureKeySustem") then pg.PressureKeySustem:Destroy() end

local sg = make("ScreenGui", {
    Name = "PressureKeySustem",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
    DisplayOrder = 100000, -- поверх интерфейса игры (таймеры и т.п.)
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
}, pg)

local overlay = make("Frame", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundColor3 = Color3.fromRGB(0, 0, 0),
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    Active = true,
}, sg)

local main = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 380, 0, 456),
    BackgroundColor3 = THEME.bg,
    BorderSizePixel = 0,
}, sg)
round(main, UDim.new(0, 6))
local mainStroke = stroke(main, THEME.white, 1.5)
make("UIGradient", {
    Color = ColorSequence.new(THEME.accent, THEME.border),
    Rotation = 90,
}, mainStroke)

local uiScale = make("UIScale", {Scale = fitScale() * 0.92}, main)

------------------------------------------------------------------
-- Шапка: [✕] Название ............ [• Activation]
------------------------------------------------------------------
local headerBar = make("Frame", {
    Size = UDim2.new(1, 0, 0, 56),
    BackgroundTransparency = 1,
    ZIndex = 3,
}, main)

-- Белый крестик (две повёрнутые полоски) — закрывает панель полностью
local closeBtn = make("TextButton", {
    Size = UDim2.fromOffset(34, 34),
    Position = UDim2.fromOffset(14, 11),
    BackgroundColor3 = THEME.accent,
    BackgroundTransparency = 1,
    Text = "",
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 10,
}, headerBar)
round(closeBtn, UDim.new(0, 4))

for _, rot in ipairs({45, -45}) do
    local bar = make("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(20, 3),
        Rotation = rot,
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        ZIndex = 11,
    }, closeBtn)
    round(bar, UDim.new(0, 1))
end

closeBtn.MouseEnter:Connect(function()
    tw(closeBtn, 0.12, {BackgroundTransparency = 0.6})
end)
closeBtn.MouseLeave:Connect(function()
    tw(closeBtn, 0.12, {BackgroundTransparency = 1})
end)

make("TextLabel", {
    Size = UDim2.new(0, 170, 1, 0),
    Position = UDim2.fromOffset(56, 0),
    BackgroundTransparency = 1,
    Text = HUB_NAME,
    TextColor3 = THEME.muted,
    TextSize = 15,
    Font = Enum.Font.GothamSemibold,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
    ZIndex = 4,
}, headerBar)

local activationBadge = make("Frame", {
    Size = UDim2.fromOffset(112, 30),
    Position = UDim2.new(1, -126, 0.5, -15),
    BackgroundColor3 = THEME.chip,
    BorderSizePixel = 0,
    ZIndex = 4,
}, headerBar)
round(activationBadge, UDim.new(0, 4))
stroke(activationBadge, THEME.accentDim, 1.2)

local abDot = make("Frame", {
    Size = UDim2.fromOffset(7, 7),
    Position = UDim2.new(0, 11, 0.5, -3),
    BackgroundColor3 = THEME.accent,
    BorderSizePixel = 0,
    ZIndex = 5,
}, activationBadge)
round(abDot, UDim.new(1, 0))

make("TextLabel", {
    Size = UDim2.new(1, -28, 1, 0),
    Position = UDim2.fromOffset(26, 0),
    BackgroundTransparency = 1,
    Text = "Activation",
    TextColor3 = THEME.accent,
    TextSize = 13,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 5,
}, activationBadge)

local dotPulse = TweenService:Create(
    abDot,
    TweenInfo.new(0.9, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1, true),
    {BackgroundTransparency = 0.7}
)
dotPulse:Play()

-- Линия под шапкой
make("Frame", {
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.fromOffset(0, 56),
    BackgroundColor3 = THEME.border,
    BorderSizePixel = 0,
    ZIndex = 3,
}, main)

------------------------------------------------------------------
-- Заголовок и описание
------------------------------------------------------------------
make("TextLabel", {
    Size = UDim2.new(1, -30, 0, 46),
    Position = UDim2.fromOffset(15, 76),
    BackgroundTransparency = 1,
    Text = "Activate License",
    TextColor3 = THEME.white,
    TextSize = 32,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 3,
}, main)

make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0),
    Size = UDim2.fromOffset(48, 3),
    Position = UDim2.new(0.5, 0, 0, 128),
    BackgroundColor3 = THEME.accent,
    BorderSizePixel = 0,
    ZIndex = 3,
}, main)

make("TextLabel", {
    Size = UDim2.new(1, -60, 0, 44),
    Position = UDim2.fromOffset(30, 144),
    BackgroundTransparency = 1,
    Text = "Введите ваш " .. HUB_NAME .. " ключ чтобы привязать и активировать устройство.",
    TextColor3 = THEME.muted,
    TextSize = 14,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = true,
    ZIndex = 3,
}, main)

------------------------------------------------------------------
-- LICENSE KEY + Paste
------------------------------------------------------------------
make("TextLabel", {
    Size = UDim2.fromOffset(140, 28),
    Position = UDim2.fromOffset(20, 200),
    BackgroundTransparency = 1,
    Text = "LICENSE KEY",
    TextColor3 = Color3.fromRGB(115, 110, 110),
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 3,
}, main)

local pasteBtn = make("TextButton", {
    Size = UDim2.fromOffset(104, 28),
    Position = UDim2.new(1, -124, 0, 200),
    BackgroundColor3 = THEME.chip,
    TextColor3 = THEME.accent,
    Text = "Paste Ключ",
    TextSize = 13,
    Font = Enum.Font.Code,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 4,
}, main)
round(pasteBtn, UDim.new(0, 4))
local pasteStroke = stroke(pasteBtn, THEME.accentDim, 1)

pasteBtn.MouseEnter:Connect(function()
    tw(pasteBtn, 0.12, {BackgroundColor3 = THEME.chipHover})
    tw(pasteStroke, 0.12, {Color = THEME.accent})
end)
pasteBtn.MouseLeave:Connect(function()
    tw(pasteBtn, 0.12, {BackgroundColor3 = THEME.chip})
    tw(pasteStroke, 0.12, {Color = THEME.accentDim})
end)

local inputOuter = make("Frame", {
    Size = UDim2.new(1, -40, 0, 54),
    Position = UDim2.fromOffset(20, 234),
    BackgroundColor3 = THEME.bgDeep,
    BorderSizePixel = 0,
    ZIndex = 3,
}, main)
round(inputOuter, UDim.new(0, 4))
local inputStroke = stroke(inputOuter, THEME.border, 1.5)

local prefixBadge = make("Frame", {
    Size = UDim2.fromOffset(44, 34),
    Position = UDim2.new(0, 10, 0.5, -17),
    BackgroundColor3 = THEME.chip,
    BorderSizePixel = 0,
    ZIndex = 4,
}, inputOuter)
round(prefixBadge, UDim.new(0, 3))
stroke(prefixBadge, THEME.accentDim, 1)

make("TextLabel", {
    Size = UDim2.new(1, 0, 1, 0),
    BackgroundTransparency = 1,
    Text = "Sm",
    TextColor3 = THEME.accent,
    TextSize = 15,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 5,
}, prefixBadge)

local inputBox = make("TextBox", {
    Size = UDim2.new(1, -70, 1, 0),
    Position = UDim2.fromOffset(62, 0),
    BackgroundTransparency = 1,
    TextColor3 = THEME.accentBright,
    PlaceholderColor3 = Color3.fromRGB(90, 70, 70),
    PlaceholderText = "Sm-Vip-XXXXXXXXXXXX",
    TextSize = 15,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    ClearTextOnFocus = false,
    Text = "",
    ZIndex = 5,
}, inputOuter)

inputBox.Focused:Connect(function()
    tw(inputStroke, 0.15, {Color = THEME.accent})
end)
inputBox.FocusLost:Connect(function()
    tw(inputStroke, 0.15, {Color = THEME.border})
end)

------------------------------------------------------------------
-- HWID / статус
------------------------------------------------------------------
make("TextLabel", {
    Size = UDim2.new(1, -40, 0, 16),
    Position = UDim2.fromOffset(20, 298),
    BackgroundTransparency = 1,
    Text = "HWID : " .. HWID,
    TextColor3 = THEME.faint,
    TextSize = 10,
    Font = Enum.Font.Code,
    TextXAlignment = Enum.TextXAlignment.Left,
    TextTruncate = Enum.TextTruncate.AtEnd,
    ZIndex = 3,
}, main)

local statusLbl = make("TextLabel", {
    Size = UDim2.new(1, -40, 0, 24),
    Position = UDim2.fromOffset(20, 318),
    BackgroundTransparency = 1,
    Text = "",
    TextColor3 = THEME.err,
    TextSize = 14,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 3,
}, main)

local subLbl = make("TextLabel", {
    Size = UDim2.new(1, -40, 0, 18),
    Position = UDim2.fromOffset(20, 342),
    BackgroundTransparency = 1,
    Text = "",
    TextColor3 = THEME.muted,
    TextSize = 12,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 3,
}, main)

local function setStatus(t, c)
    statusLbl.Text = t
    statusLbl.TextColor3 = c or THEME.err
end

local function setSub(t, c)
    subLbl.Text = t
    subLbl.TextColor3 = c or THEME.muted
end

------------------------------------------------------------------
-- Кнопка Activate License
------------------------------------------------------------------
local activateBtn = make("TextButton", {
    Size = UDim2.new(1, -40, 0, 54),
    Position = UDim2.fromOffset(20, 376),
    BackgroundColor3 = THEME.chip,
    TextColor3 = THEME.white,
    Text = "Activate License",
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 3,
}, main)
round(activateBtn, UDim.new(0, 4))
local activateStroke = stroke(activateBtn, THEME.accentDim, 1.8)

activateBtn.MouseEnter:Connect(function()
    tw(activateBtn, 0.12, {BackgroundColor3 = THEME.chipHover})
    tw(activateStroke, 0.12, {Color = THEME.accent})
end)
activateBtn.MouseLeave:Connect(function()
    tw(activateBtn, 0.12, {BackgroundColor3 = THEME.chip})
    tw(activateStroke, 0.12, {Color = THEME.accentDim})
end)

------------------------------------------------------------------
-- Закрытие / перетаскивание / масштаб
------------------------------------------------------------------
local connections = {}
local closed = false

local function closeGui()
    if closed then return end
    closed = true
    dotPulse:Cancel()
    for _, c in ipairs(connections) do c:Disconnect() end
    tw(overlay, 0.15, {BackgroundTransparency = 1})
    tw(uiScale, 0.15, {Scale = uiScale.Scale * 0.92})
    task.delay(0.16, function()
        sg:Destroy()
    end)
end

closeBtn.MouseButton1Click:Connect(closeGui)

local dragging = false
local dragStart = nil
local dragPos = nil

main.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = inp.Position
        dragPos = main.Position
        inp.Changed:Connect(function()
            if inp.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)

table.insert(connections, UserInputService.InputChanged:Connect(function(inp)
    if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
        local d = inp.Position - dragStart
        main.Position = UDim2.new(dragPos.X.Scale, dragPos.X.Offset + d.X, dragPos.Y.Scale, dragPos.Y.Offset + d.Y)
    end
end))

local cam = workspace.CurrentCamera
if cam then
    table.insert(connections, cam:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        if not closed then uiScale.Scale = fitScale() end
    end))
end

------------------------------------------------------------------
-- Paste
------------------------------------------------------------------
pasteBtn.MouseButton1Click:Connect(function()
    local ok, clip = pcall(function()
        return UserInputService:GetClipboardText()
    end)
    if not (ok and clip and clip ~= "") and getclipboard then
        ok, clip = pcall(getclipboard)
    end
    if ok and clip and clip ~= "" then
        inputBox.Text = clip
        setStatus("") setSub("")
    else
        setStatus("> Буфер обмена пуст", THEME.warn)
    end
end)

------------------------------------------------------------------
-- Проверка ключа
------------------------------------------------------------------
local busy = false

local function checkKey(key)
    if busy then return end
    busy = true
    activateBtn.Text = "Проверка..."
    setStatus("> Проверка лицензии...", THEME.accentBright)
    setSub("Подождите")

    local res = httpPost(API_CHECK, { key = key, hwid = HWID })

    if not res then
        setStatus("> Ошибка соединения", THEME.err)
        setSub("Сервер недоступен")
        activateBtn.Text = "Activate License"
        busy = false
        return
    end

    if res.StatusCode ~= 200 then
        setStatus("> Ошибка сервера: " .. tostring(res.StatusCode), THEME.err)
        setSub("")
        activateBtn.Text = "Activate License"
        busy = false
        return
    end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(res.Body)
    end)

    if not ok or not data then
        setStatus("> Неверный ответ сервера", THEME.err)
        setSub("")
        activateBtn.Text = "Activate License"
        busy = false
        return
    end

    local s = data.status

    if s == "success" then
        setStatus("> Привязка устройства...", THEME.accentBright)
        setSub("HWID: " .. HWID)

        local bRes = httpPost(API_BIND, { key = key, hwid = HWID })

        if not bRes or bRes.StatusCode ~= 200 then
            setStatus("> Ошибка привязки", THEME.err)
            setSub("")
            activateBtn.Text = "Activate License"
            busy = false
            return
        end

        local ok2, bd = pcall(function()
            return HttpService:JSONDecode(bRes.Body)
        end)

        if ok2 and bd and bd.status == "bound" then
            setStatus("> Лицензия активирована!", THEME.ok)
            setSub("Добро пожаловать в " .. HUB_NAME .. "!")
            task.wait(1.5)
            closeGui()
        else
            setStatus("> Ошибка при привязке", THEME.err)
            setSub("")
        end

    elseif s == "bound_to_you" then
        setStatus("> Лицензия подтверждена!", THEME.ok)
        setSub("Добро пожаловать в " .. HUB_NAME .. "!")
        task.wait(1.5)
        closeGui()

    elseif s == "bound_to_other" then
        setStatus("> Ключ занят другим устройством", THEME.err)
        setSub("Каждый ключ работает только на 1 устройстве")

    elseif s == "expired" then
        setStatus("> Лицензия просрочена", THEME.warn)
        setSub("Получите новый ключ")

    else
        setStatus("> Неверный ключ", THEME.err)
        setSub("Проверьте ключ и попробуйте снова")
    end

    activateBtn.Text = "Activate License"
    busy = false
end

local function tryActivate()
    local key = inputBox.Text:match("^%s*(.-)%s*$")
    if key == "" then
        setStatus("> Введите ключ лицензии", THEME.warn)
        setSub("")
        return
    end
    task.spawn(checkKey, key)
end

activateBtn.MouseButton1Click:Connect(tryActivate)

inputBox.FocusLost:Connect(function(enterPressed)
    if enterPressed then tryActivate() end
end)

------------------------------------------------------------------
-- Анимация появления
------------------------------------------------------------------
tw(overlay, 0.25, {BackgroundTransparency = 0.45})
tw(uiScale, 0.3, {Scale = fitScale()}, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
