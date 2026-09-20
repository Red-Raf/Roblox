--// SmileHub Key System — новый дизайн (чёрный + оранжевый)
--// Логика (API, HWID, проверка, привязка) не изменена.

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
-- Тема
------------------------------------------------------------------
local THEME = {
    bg           = Color3.fromRGB(15, 15, 18),
    bgDeep       = Color3.fromRGB(9, 9, 11),
    chip         = Color3.fromRGB(30, 21, 12),
    chipHover    = Color3.fromRGB(48, 31, 14),
    accent       = Color3.fromRGB(255, 140, 26),
    accentBright = Color3.fromRGB(255, 170, 70),
    accentDim    = Color3.fromRGB(120, 68, 18),
    border       = Color3.fromRGB(52, 40, 30),
    white        = Color3.fromRGB(255, 255, 255),
    muted        = Color3.fromRGB(150, 150, 160),
    faint        = Color3.fromRGB(80, 80, 90),
    ok           = Color3.fromRGB(80, 220, 100),
    err          = Color3.fromRGB(235, 65, 65),
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
    return math.clamp(math.min(vp.X / 420, vp.Y / 580), 0.5, 1)
end

------------------------------------------------------------------
-- ScreenGui + фон
------------------------------------------------------------------
if pg:FindFirstChild("SmileHubKey") then pg.SmileHubKey:Destroy() end

local sg = make("ScreenGui", {
    Name = "SmileHubKey",
    ResetOnSpawn = false,
    IgnoreGuiInset = true,
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
    Size = UDim2.new(0, 380, 0, 530),
    BackgroundColor3 = THEME.bg,
    BorderSizePixel = 0,
}, sg)
round(main, UDim.new(0, 22))
local mainStroke = stroke(main, THEME.white, 1.5)
make("UIGradient", {
    Color = ColorSequence.new(THEME.accent, THEME.border),
    Rotation = 90,
}, mainStroke)

local uiScale = make("UIScale", {Scale = fitScale() * 0.92}, main)

------------------------------------------------------------------
-- Шапка: [✕] SmileHub ............ [• Activation]
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
    BackgroundColor3 = THEME.white,
    BackgroundTransparency = 1,
    Text = "",
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 5,
}, headerBar)
round(closeBtn, UDim.new(0, 10))

for _, rot in ipairs({45, -45}) do
    local bar = make("Frame", {
        AnchorPoint = Vector2.new(0.5, 0.5),
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(18, 3),
        Rotation = rot,
        BackgroundColor3 = THEME.white,
        BorderSizePixel = 0,
        ZIndex = 6,
    }, closeBtn)
    round(bar, UDim.new(1, 0))
end

closeBtn.MouseEnter:Connect(function()
    tw(closeBtn, 0.12, {BackgroundTransparency = 0.85})
end)
closeBtn.MouseLeave:Connect(function()
    tw(closeBtn, 0.12, {BackgroundTransparency = 1})
end)

make("TextLabel", {
    Size = UDim2.new(0, 140, 1, 0),
    Position = UDim2.fromOffset(56, 0),
    BackgroundTransparency = 1,
    Text = "SmileHub",
    TextColor3 = THEME.muted,
    TextSize = 15,
    Font = Enum.Font.GothamSemibold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 4,
}, headerBar)

local activationBadge = make("Frame", {
    Size = UDim2.fromOffset(128, 32),
    Position = UDim2.new(1, -142, 0.5, -16),
    BackgroundColor3 = THEME.chip,
    BorderSizePixel = 0,
    ZIndex = 4,
}, headerBar)
round(activationBadge, UDim.new(1, 0))
stroke(activationBadge, THEME.accentDim, 1.2)

local abDot = make("Frame", {
    Size = UDim2.fromOffset(8, 8),
    Position = UDim2.new(0, 14, 0.5, -4),
    BackgroundColor3 = THEME.accent,
    BorderSizePixel = 0,
    ZIndex = 5,
}, activationBadge)
round(abDot, UDim.new(1, 0))

make("TextLabel", {
    Size = UDim2.new(1, -30, 1, 0),
    Position = UDim2.fromOffset(28, 0),
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

------------------------------------------------------------------
-- Логотип-смайлик
------------------------------------------------------------------
local logoBox = make("Frame", {
    AnchorPoint = Vector2.new(0.5, 0),
    Position = UDim2.new(0.5, 0, 0, 64),
    Size = UDim2.fromOffset(100, 100),
    BackgroundColor3 = Color3.fromRGB(24, 17, 10),
    BorderSizePixel = 0,
    ZIndex = 3,
}, main)
round(logoBox, UDim.new(0, 24))
stroke(logoBox, THEME.accentDim, 1.5)

local faceOuter = make("Frame", {
    Size = UDim2.fromOffset(72, 72),
    Position = UDim2.new(0.5, -36, 0.5, -36),
    BackgroundColor3 = Color3.fromRGB(200, 105, 10),
    BorderSizePixel = 0,
    ZIndex = 4,
}, logoBox)
round(faceOuter, UDim.new(1, 0))

local face = make("Frame", {
    Size = UDim2.fromOffset(64, 64),
    Position = UDim2.new(0.5, -32, 0.5, -32),
    BackgroundColor3 = Color3.fromRGB(255, 145, 25),
    BorderSizePixel = 0,
    ZIndex = 5,
}, faceOuter)
round(face, UDim.new(1, 0))

local EYE_COLOR = Color3.fromRGB(30, 15, 0)

local eyeL = make("Frame", {
    Size = UDim2.fromOffset(8, 9),
    Position = UDim2.fromOffset(14, 18),
    BackgroundColor3 = EYE_COLOR,
    BorderSizePixel = 0,
    ZIndex = 6,
}, face)
round(eyeL, UDim.new(1, 0))

local eyeR = make("Frame", {
    Size = UDim2.fromOffset(8, 9),
    Position = UDim2.fromOffset(42, 18),
    BackgroundColor3 = EYE_COLOR,
    BorderSizePixel = 0,
    ZIndex = 6,
}, face)
round(eyeR, UDim.new(1, 0))

local mouthClip = make("Frame", {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ClipsDescendants = true,
    ZIndex = 6,
}, face)

local mouthArc = make("Frame", {
    BackgroundTransparency = 1,
    BorderSizePixel = 0,
    ZIndex = 7,
}, mouthClip)
round(mouthArc, UDim.new(1, 0))
stroke(mouthArc, EYE_COLOR, 5)

local cheekL = make("Frame", {
    Size = UDim2.fromOffset(14, 7),
    Position = UDim2.fromOffset(4, 42),
    BackgroundColor3 = Color3.fromRGB(230, 70, 40),
    BackgroundTransparency = 0.3,
    BorderSizePixel = 0,
    ZIndex = 6,
}, face)
round(cheekL, UDim.new(1, 0))

local cheekR = make("Frame", {
    Size = UDim2.fromOffset(14, 7),
    Position = UDim2.fromOffset(46, 42),
    BackgroundColor3 = Color3.fromRGB(230, 70, 40),
    BackgroundTransparency = 0.3,
    BorderSizePixel = 0,
    ZIndex = 6,
}, face)
round(cheekR, UDim.new(1, 0))

local function setSmile(mode)
    if mode == "happy" then
        mouthClip.Size = UDim2.new(0, 38, 0, 20)
        mouthClip.Position = UDim2.new(0, 13, 0, 38)
        mouthArc.Size = UDim2.new(0, 38, 0, 38)
        mouthArc.Position = UDim2.new(0, 0, 0, -19)
        eyeL.Size = UDim2.new(0, 8, 0, 9)
        eyeL.Position = UDim2.new(0, 14, 0, 16)
        eyeR.Size = UDim2.new(0, 8, 0, 9)
        eyeR.Position = UDim2.new(0, 42, 0, 16)
        cheekL.BackgroundTransparency = 0.3
        cheekR.BackgroundTransparency = 0.3
    elseif mode == "sad" then
        mouthClip.Size = UDim2.new(0, 38, 0, 20)
        mouthClip.Position = UDim2.new(0, 13, 0, 42)
        mouthArc.Size = UDim2.new(0, 38, 0, 38)
        mouthArc.Position = UDim2.new(0, 0, 0, 0)
        eyeL.Size = UDim2.new(0, 8, 0, 7)
        eyeL.Position = UDim2.new(0, 14, 0, 20)
        eyeR.Size = UDim2.new(0, 8, 0, 7)
        eyeR.Position = UDim2.new(0, 42, 0, 20)
        cheekL.BackgroundTransparency = 1
        cheekR.BackgroundTransparency = 1
    else
        mouthClip.Size = UDim2.new(0, 34, 0, 4)
        mouthClip.Position = UDim2.new(0, 15, 0, 44)
        mouthArc.Size = UDim2.new(0, 34, 0, 34)
        mouthArc.Position = UDim2.new(0, 0, 0, -15)
        eyeL.Size = UDim2.new(0, 8, 0, 9)
        eyeL.Position = UDim2.new(0, 14, 0, 18)
        eyeR.Size = UDim2.new(0, 8, 0, 9)
        eyeR.Position = UDim2.new(0, 42, 0, 18)
        cheekL.BackgroundTransparency = 1
        cheekR.BackgroundTransparency = 1
    end
end

setSmile("happy")

------------------------------------------------------------------
-- Заголовок и описание
------------------------------------------------------------------
make("TextLabel", {
    Size = UDim2.new(1, -30, 0, 46),
    Position = UDim2.fromOffset(15, 176),
    BackgroundTransparency = 1,
    Text = "Activate License",
    TextColor3 = THEME.white,
    TextSize = 32,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Center,
    ZIndex = 3,
}, main)

make("TextLabel", {
    Size = UDim2.new(1, -60, 0, 44),
    Position = UDim2.fromOffset(30, 224),
    BackgroundTransparency = 1,
    Text = "Введите ваш SmileHub ключ чтобы привязать и активировать устройство.",
    TextColor3 = THEME.muted,
    TextSize = 14,
    Font = Enum.Font.Gotham,
    TextXAlignment = Enum.TextXAlignment.Center,
    TextYAlignment = Enum.TextYAlignment.Top,
    TextWrapped = true,
    ZIndex = 3,
}, main)

------------------------------------------------------------------
-- LICENSE KEY + Paste Key
------------------------------------------------------------------
make("TextLabel", {
    Size = UDim2.fromOffset(140, 28),
    Position = UDim2.fromOffset(20, 280),
    BackgroundTransparency = 1,
    Text = "LICENSE KEY",
    TextColor3 = Color3.fromRGB(110, 110, 120),
    TextSize = 13,
    Font = Enum.Font.GothamBold,
    TextXAlignment = Enum.TextXAlignment.Left,
    ZIndex = 3,
}, main)

local pasteBtn = make("TextButton", {
    Size = UDim2.fromOffset(104, 28),
    Position = UDim2.new(1, -124, 0, 280),
    BackgroundColor3 = THEME.chip,
    TextColor3 = THEME.accent,
    Text = "Paste Key",
    TextSize = 13,
    Font = Enum.Font.Code,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 4,
}, main)
round(pasteBtn, UDim.new(0, 9))
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
    Position = UDim2.fromOffset(20, 314),
    BackgroundColor3 = THEME.bgDeep,
    BorderSizePixel = 0,
    ZIndex = 3,
}, main)
round(inputOuter, UDim.new(0, 14))
local inputStroke = stroke(inputOuter, THEME.border, 1.5)

local prefixBadge = make("Frame", {
    Size = UDim2.fromOffset(44, 34),
    Position = UDim2.new(0, 10, 0.5, -17),
    BackgroundColor3 = THEME.chip,
    BorderSizePixel = 0,
    ZIndex = 4,
}, inputOuter)
round(prefixBadge, UDim.new(0, 9))
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
    PlaceholderColor3 = Color3.fromRGB(85, 70, 55),
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
    Position = UDim2.fromOffset(20, 378),
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
    Position = UDim2.fromOffset(20, 398),
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
    Position = UDim2.fromOffset(20, 422),
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
    Position = UDim2.fromOffset(20, 452),
    BackgroundColor3 = THEME.chip,
    TextColor3 = THEME.white,
    Text = "Activate License",
    TextSize = 18,
    Font = Enum.Font.GothamBold,
    AutoButtonColor = false,
    BorderSizePixel = 0,
    ZIndex = 3,
}, main)
round(activateBtn, UDim.new(0, 14))
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
-- Paste Key
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
    setSmile("neutral")
    setStatus("> Проверка лицензии...", THEME.accent)
    setSub("Подождите")

    local res = httpPost(API_CHECK, { key = key, hwid = HWID })

    if not res then
        setSmile("sad")
        setStatus("> Ошибка соединения", THEME.err)
        setSub("Сервер недоступен")
        activateBtn.Text = "Activate License"
        busy = false
        return
    end

    if res.StatusCode ~= 200 then
        setSmile("sad")
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
        setSmile("sad")
        setStatus("> Неверный ответ сервера", THEME.err)
        setSub("")
        activateBtn.Text = "Activate License"
        busy = false
        return
    end

    local s = data.status

    if s == "success" then
        setStatus("> Привязка устройства...", THEME.accent)
        setSub("HWID: " .. HWID)

        local bRes = httpPost(API_BIND, { key = key, hwid = HWID })

        if not bRes or bRes.StatusCode ~= 200 then
            setSmile("sad")
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
            setSmile("happy")
            setStatus("> Лицензия активирована!", THEME.ok)
            setSub("Добро пожаловать в SmileHub!")
            task.wait(1.5)
            closeGui()
        else
            setSmile("sad")
            setStatus("> Ошибка при привязке", THEME.err)
            setSub("")
        end

    elseif s == "bound_to_you" then
        setSmile("happy")
        setStatus("> Лицензия подтверждена!", THEME.ok)
        setSub("Добро пожаловать в SmileHub!")
        task.wait(1.5)
        closeGui()

    elseif s == "bound_to_other" then
        setSmile("sad")
        setStatus("> Ключ занят другим устройством", THEME.err)
        setSub("Каждый ключ работает только на 1 устройстве")

    elseif s == "expired" then
        setSmile("sad")
        setStatus("> Лицензия просрочена", THEME.warn)
        setSub("Получите новый ключ")

    else
        setSmile("sad")
        setStatus("> Неверный ключ", THEME.err)
        setSub("Проверьте ключ и попробуйте снова")
    end

    activateBtn.Text = "Activate License"
    busy = false
end

local function tryActivate()
    local key = inputBox.Text:match("^%s*(.-)%s*$")
    if key == "" then
        setSmile("sad")
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
