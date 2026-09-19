-- Сервисы
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local API_URL  = "https://keybot-rfgspl.mia0.amvera.tech/api/check"
local API_BIND = "https://keybot-rfgspl.mia0.amvera.tech/api/bind"

-- HWID
local function getHWID()
    if getdeviceid then return tostring(getdeviceid())
    elseif getexecutorname then return tostring(Player.UserId).."_"..tostring(getexecutorname())
    else return tostring(Player.UserId) end
end
local HWID = getHWID()

-- HTTP helper
local function httpRequest(url, method, body)
    local fn = (syn and syn.request) or http_request or request or (fluxus and fluxus.request)
    if not fn then return nil, "no_http" end
    local ok, res = pcall(function()
        return fn({
            Url = url, Method = method or "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = body and HttpService:JSONEncode(body) or nil,
        })
    end)
    if ok and res then return res, nil end
    return nil, "failed"
end

-- ════════════════════════════════════════════════════════════
--  UI
-- ════════════════════════════════════════════════════════════
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SmileHubKeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = PlayerGui

-- Главный фрейм
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 400, 0, 340)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -170)
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 6)

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.Thickness = 1.5
MainStroke.Parent = MainFrame

-- TopBar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 38)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 6)

-- Нижняя заглушка скруглений у TopBar
local TopBarFix = Instance.new("Frame")
TopBarFix.Size = UDim2.new(1, 0, 0, 10)
TopBarFix.Position = UDim2.new(0, 0, 1, -10)
TopBarFix.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TopBarFix.BorderSizePixel = 0
TopBarFix.Parent = TopBar

-- Заголовок
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, -50, 1, 0)
TitleLabel.Position = UDim2.new(0, 14, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "SmileHub  //  KEY SYSTEM"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 13
TitleLabel.Font = Enum.Font.Code
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

-- Закрыть
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 38, 0, 38)
CloseBtn.Position = UDim2.new(1, -38, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Color3.fromRGB(160, 160, 160)
CloseBtn.TextSize = 14
CloseBtn.Font = Enum.Font.Code
CloseBtn.Parent = TopBar
CloseBtn.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- ── Смайлик (Drawing на ViewportFrame) ──────────────────────
local ViewportFrame = Instance.new("ViewportFrame")
ViewportFrame.Size = UDim2.new(0, 90, 0, 90)
ViewportFrame.Position = UDim2.new(0.5, -45, 0, 46)
ViewportFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
ViewportFrame.BorderSizePixel = 0
ViewportFrame.Parent = MainFrame

-- Смайлик через ImageLabel (SVG-like через Drawing-style Frame)
-- Голова
local FaceCircle = Instance.new("Frame")
FaceCircle.Size = UDim2.new(0, 86, 0, 86)
FaceCircle.Position = UDim2.new(0, 2, 0, 2)
FaceCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
FaceCircle.BorderSizePixel = 0
FaceCircle.Parent = ViewportFrame
Instance.new("UICorner", FaceCircle).CornerRadius = UDim.new(1, 0)

-- Левый глаз
local LeftEye = Instance.new("Frame")
LeftEye.Size = UDim2.new(0, 10, 0, 10)
LeftEye.Position = UDim2.new(0, 22, 0, 26)
LeftEye.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
LeftEye.BorderSizePixel = 0
LeftEye.Parent = FaceCircle
Instance.new("UICorner", LeftEye).CornerRadius = UDim.new(1, 0)

-- Правый глаз
local RightEye = Instance.new("Frame")
RightEye.Size = UDim2.new(0, 10, 0, 10)
RightEye.Position = UDim2.new(0, 54, 0, 26)
RightEye.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
RightEye.BorderSizePixel = 0
RightEye.Parent = FaceCircle
Instance.new("UICorner", RightEye).CornerRadius = UDim.new(1, 0)

-- Рот (улыбка / грусть) — реализуем через ImageLabel с Arc
-- Используем два полукруглых Frame с clip
local MouthClip = Instance.new("Frame")
MouthClip.Size = UDim2.new(0, 46, 0, 24)
MouthClip.Position = UDim2.new(0, 20, 0, 50)
MouthClip.BackgroundTransparency = 1
MouthClip.BorderSizePixel = 0
MouthClip.ClipsDescendants = true
MouthClip.Parent = FaceCircle

-- Круг для рта (верхняя половина = грусть, нижняя = улыбка)
local MouthArc = Instance.new("Frame")
MouthArc.Size = UDim2.new(0, 46, 0, 46)
MouthArc.Position = UDim2.new(0, 0, 0, 0) -- сдвигается для smile/sad
MouthArc.BackgroundTransparency = 1
MouthArc.BorderSizePixel = 0
MouthArc.Parent = MouthClip

local MouthStroke = Instance.new("UIStroke")
MouthStroke.Color = Color3.fromRGB(10, 10, 10)
MouthStroke.Thickness = 5
MouthStroke.Parent = MouthArc
Instance.new("UICorner", MouthArc).CornerRadius = UDim.new(1, 0)

-- Функции смайлика
local smileState = "neutral" -- "happy" / "sad" / "neutral"

local function setSmile(mode)
    smileState = mode
    if mode == "happy" then
        -- Нижняя половина круга → улыбка
        MouthClip.Position = UDim2.new(0, 20, 0, 50)
        MouthClip.Size = UDim2.new(0, 46, 0, 24)
        MouthArc.Position = UDim2.new(0, 0, 0, -22) -- показываем нижнюю часть
        MouthArc.Size = UDim2.new(0, 46, 0, 46)
        MouthStroke.Color = Color3.fromRGB(10, 10, 10)
        LeftEye.Size = UDim2.new(0, 10, 0, 10)
        LeftEye.Position = UDim2.new(0, 22, 0, 26)
        RightEye.Size = UDim2.new(0, 10, 0, 10)
        RightEye.Position = UDim2.new(0, 54, 0, 26)
        FaceCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    elseif mode == "sad" then
        -- Верхняя половина круга → грусть
        MouthClip.Position = UDim2.new(0, 20, 0, 56)
        MouthClip.Size = UDim2.new(0, 46, 0, 24)
        MouthArc.Position = UDim2.new(0, 0, 0, 0) -- показываем верхнюю часть
        MouthArc.Size = UDim2.new(0, 46, 0, 46)
        MouthStroke.Color = Color3.fromRGB(10, 10, 10)
        LeftEye.Size = UDim2.new(0, 10, 0, 10)
        LeftEye.Position = UDim2.new(0, 22, 0, 26)
        RightEye.Size = UDim2.new(0, 10, 0, 10)
        RightEye.Position = UDim2.new(0, 54, 0, 26)
        FaceCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    else
        -- Нейтральный (прямая линия)
        MouthClip.Position = UDim2.new(0, 18, 0, 56)
        MouthClip.Size = UDim2.new(0, 50, 0, 6)
        MouthArc.Position = UDim2.new(0, 0, 0, -22)
        MouthArc.Size = UDim2.new(0, 50, 0, 50)
        FaceCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end
end

setSmile("neutral")

-- ── HWID label ───────────────────────────────────────────────
local HWIDLabel = Instance.new("TextLabel")
HWIDLabel.Size = UDim2.new(1, -20, 0, 16)
HWIDLabel.Position = UDim2.new(0, 10, 0, 142)
HWIDLabel.BackgroundTransparency = 1
HWIDLabel.Text = "HWID: " .. HWID
HWIDLabel.TextColor3 = Color3.fromRGB(55, 55, 55)
HWIDLabel.TextSize = 9
HWIDLabel.Font = Enum.Font.Code
HWIDLabel.TextXAlignment = Enum.TextXAlignment.Left
HWIDLabel.TextTruncate = Enum.TextTruncate.AtEnd
HWIDLabel.Parent = MainFrame

-- ── TextBox ──────────────────────────────────────────────────
local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0, 360, 0, 42)
TextBox.Position = UDim2.new(0, 20, 0, 164)
TextBox.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderColor3 = Color3.fromRGB(90, 90, 90)
TextBox.PlaceholderText = "Введите ключ доступа..."
TextBox.TextSize = 13
TextBox.Font = Enum.Font.Code
TextBox.ClearTextOnFocus = false
TextBox.Parent = MainFrame
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 4)
local tbs = Instance.new("UIStroke", TextBox)
tbs.Color = Color3.fromRGB(55, 55, 55) tbs.Thickness = 1

-- Отступ текста внутри TextBox
local TBPad = Instance.new("UIPadding", TextBox)
TBPad.PaddingLeft = UDim.new(0, 10)

-- ── Кнопки ───────────────────────────────────────────────────
local EnterBtn = Instance.new("TextButton")
EnterBtn.Size = UDim2.new(0, 172, 0, 38)
EnterBtn.Position = UDim2.new(0, 20, 0, 216)
EnterBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
EnterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
EnterBtn.Text = "ENTER"
EnterBtn.TextSize = 13
EnterBtn.Font = Enum.Font.Code
EnterBtn.AutoButtonColor = false
EnterBtn.Parent = MainFrame
Instance.new("UICorner", EnterBtn).CornerRadius = UDim.new(0, 4)

local ClearBtn = Instance.new("TextButton")
ClearBtn.Size = UDim2.new(0, 172, 0, 38)
ClearBtn.Position = UDim2.new(0, 208, 0, 216)
ClearBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
ClearBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
ClearBtn.Text = "CLEAR"
ClearBtn.TextSize = 13
ClearBtn.Font = Enum.Font.Code
ClearBtn.AutoButtonColor = false
ClearBtn.Parent = MainFrame
Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 4)
local cbs = Instance.new("UIStroke", ClearBtn)
cbs.Color = Color3.fromRGB(60, 60, 60) cbs.Thickness = 1

-- ── Status labels ─────────────────────────────────────────────
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, -20, 0, 22)
StatusLabel.Position = UDim2.new(0, 10, 0, 264)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(220, 220, 220)
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.Code
StatusLabel.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel.Parent = MainFrame

local StatusLabel2 = Instance.new("TextLabel")
StatusLabel2.Size = UDim2.new(1, -20, 0, 18)
StatusLabel2.Position = UDim2.new(0, 10, 0, 286)
StatusLabel2.BackgroundTransparency = 1
StatusLabel2.Text = ""
StatusLabel2.TextColor3 = Color3.fromRGB(90, 90, 90)
StatusLabel2.TextSize = 10
StatusLabel2.Font = Enum.Font.Code
StatusLabel2.TextXAlignment = Enum.TextXAlignment.Center
StatusLabel2.Parent = MainFrame

-- ── Helpers ───────────────────────────────────────────────────
local function setStatus(text, color)
    StatusLabel.Text = text
    StatusLabel.TextColor3 = color or Color3.fromRGB(220, 220, 220)
end
local function setStatus2(text, color)
    StatusLabel2.Text = text
    StatusLabel2.TextColor3 = color or Color3.fromRGB(90, 90, 90)
end

-- Hover effects
EnterBtn.MouseEnter:Connect(function()
    EnterBtn.BackgroundColor3 = Color3.fromRGB(30, 140, 255)
end)
EnterBtn.MouseLeave:Connect(function()
    EnterBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
end)
ClearBtn.MouseEnter:Connect(function()
    ClearBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
end)
ClearBtn.MouseLeave:Connect(function()
    ClearBtn.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
end)

-- ════════════════════════════════════════════════════════════
--  Dragging
-- ════════════════════════════════════════════════════════════
local dragging, dragInput, dragStart, startPos

TopBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
TopBar.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
end)

-- ════════════════════════════════════════════════════════════
--  Логика ключей + HWID
-- ════════════════════════════════════════════════════════════
local busy = false

local function checkKey(keyValue)
    if busy then return end
    busy = true

    EnterBtn.Text = "..."
    EnterBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    setSmile("neutral")
    setStatus("> Проверка ключа...", Color3.fromRGB(200, 200, 200))
    setStatus2("Подождите")

    local res, err = httpRequest(API_URL, "POST", { key = keyValue, hwid = HWID })

    if err == "no_http" then
        setSmile("sad")
        setStatus("> Ошибка: HTTP не поддерживается", Color3.fromRGB(255, 80, 80))
        setStatus2("")
        goto done
    end
    if not res or res.StatusCode ~= 200 then
        setSmile("sad")
        setStatus("> Ошибка соединения с сервером", Color3.fromRGB(255, 80, 80))
        setStatus2("Код: " .. tostring(res and res.StatusCode or "нет ответа"))
        goto done
    end

    do
        local ok, data = pcall(HttpService.JSONDecode, HttpService, res.Body)
        if not ok or not data then
            setSmile("sad")
            setStatus("> Ошибка ответа сервера", Color3.fromRGB(255, 80, 80))
            setStatus2("")
            goto done
        end

        local status = data.status

        if status == "success" then
            -- Не привязан → привязываем
            setStatus("> Привязка устройства...", Color3.fromRGB(255, 200, 0))
            setStatus2("HWID: " .. HWID)

            local bindRes, bindErr = httpRequest(API_BIND, "POST", { key = keyValue, hwid = HWID })

            if bindErr or not bindRes or bindRes.StatusCode ~= 200 then
                setSmile("sad")
                setStatus("> Ошибка привязки", Color3.fromRGB(255, 80, 80))
                setStatus2("")
                goto done
            end

            local ok2, bindData = pcall(HttpService.JSONDecode, HttpService, bindRes.Body)
            if ok2 and bindData and bindData.status == "bound" then
                setSmile("happy")
                setStatus("> Успешно! Устройство привязано", Color3.fromRGB(80, 255, 120))
                setStatus2("Загрузка SmileHub...")
                task.wait(1.5)
                ScreenGui:Destroy()
                -- loadstring(game:HttpGet("ВАШ_СКРИПТ_URL"))()
            else
                setSmile("sad")
                setStatus("> Ошибка при привязке", Color3.fromRGB(255, 80, 80))
                setStatus2("")
            end

        elseif status == "bound_to_you" then
            setSmile("happy")
            setStatus("> Устройство подтверждено!", Color3.fromRGB(80, 255, 120))
            setStatus2("Загрузка SmileHub...")
            task.wait(1.5)
            ScreenGui:Destroy()
            -- loadstring(game:HttpGet("ВАШ_СКРИПТ_URL"))()

        elseif status == "bound_to_other" then
            setSmile("sad")
            setStatus("> Ключ привязан к другому устройству", Color3.fromRGB(255, 80, 80))
            setStatus2("Каждый ключ работает только на 1 устройстве")

        elseif status == "expired" then
            setSmile("sad")
            setStatus("> Ключ просрочен", Color3.fromRGB(255, 160, 0))
            setStatus2("Получите новый ключ")

        else
            setSmile("sad")
            setStatus("> Неверный ключ", Color3.fromRGB(255, 80, 80))
            setStatus2("Проверьте ключ и попробуйте снова")
        end
    end

    ::done::
    EnterBtn.Text = "ENTER"
    EnterBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
    busy = false
end

-- ════════════════════════════════════════════════════════════
--  Кнопки
-- ════════════════════════════════════════════════════════════
ClearBtn.MouseButton1Click:Connect(function()
    TextBox.Text = ""
    setStatus("") setStatus2("")
    setSmile("neutral")
end)

EnterBtn.MouseButton1Click:Connect(function()
    local key = TextBox.Text:match("^%s*(.-)%s*$") -- trim
    if key == "" then
        setSmile("sad")
        setStatus("> Введите ключ", Color3.fromRGB(255, 160, 0))
        setStatus2("")
        return
    end
    task.spawn(function() checkKey(key) end)
end)
