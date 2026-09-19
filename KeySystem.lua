-- ════════════════════════════════════════════
--        SmileHub Key System
-- ════════════════════════════════════════════
local Players          = game:GetService("Players")
local HttpService      = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local TweenService     = game:GetService("TweenService")

local Player    = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local API_CHECK = "https://keybot-rfgspl.mia0.amvera.tech/api/check"
local API_BIND  = "https://keybot-rfgspl.mia0.amvera.tech/api/bind"

-- ── HWID ─────────────────────────────────────
local function getHWID()
    if getdeviceid   then return tostring(getdeviceid()) end
    if getexecutorname then
        return tostring(Player.UserId) .. "_" .. tostring(getexecutorname())
    end
    return tostring(Player.UserId)
end
local HWID = getHWID()

-- ── HTTP ──────────────────────────────────────
local function httpPost(url, body)
    local fn = (syn and syn.request)
             or (http and http.request)
             or http_request
             or request
             or (fluxus and fluxus.request)
    if not fn then return nil, "no_http" end
    local ok, res = pcall(fn, {
        Url     = url,
        Method  = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body    = HttpService:JSONEncode(body),
    })
    if ok and res then return res, nil end
    return nil, "failed"
end

-- ════════════════════════════════════════════
--  GUI
-- ════════════════════════════════════════════
-- Уничтожаем старый если есть
if PlayerGui:FindFirstChild("SmileHubKey") then
    PlayerGui.SmileHubKey:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name           = "SmileHubKey"
ScreenGui.ResetOnSpawn   = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent         = PlayerGui

-- Главная рамка
local Main = Instance.new("Frame")
Main.Name              = "Main"
Main.Size              = UDim2.new(0, 400, 0, 350)
Main.Position          = UDim2.new(0.5, -200, 0.5, -175)
Main.BackgroundColor3  = Color3.fromRGB(10, 10, 10)
Main.BorderSizePixel   = 0
Main.ClipsDescendants  = true
Main.Parent            = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 8)

local MainStroke = Instance.new("UIStroke", Main)
MainStroke.Color     = Color3.fromRGB(255, 255, 255)
MainStroke.Thickness = 1.5

-- ── TopBar ───────────────────────────────────
local TopBar = Instance.new("Frame")
TopBar.Size             = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
TopBar.BorderSizePixel  = 0
TopBar.ZIndex           = 2
TopBar.Parent           = Main
Instance.new("UICorner", TopBar).CornerRadius = UDim.new(0, 8)

-- Фикс нижних скруглений TopBar
local Fix = Instance.new("Frame", TopBar)
Fix.Size             = UDim2.new(1, 0, 0, 8)
Fix.Position         = UDim2.new(0, 0, 1, -8)
Fix.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
Fix.BorderSizePixel  = 0
Fix.ZIndex           = 2

local TitleLbl = Instance.new("TextLabel", TopBar)
TitleLbl.Size               = UDim2.new(1, -50, 1, 0)
TitleLbl.Position           = UDim2.new(0, 14, 0, 0)
TitleLbl.BackgroundTransparency = 1
TitleLbl.Text               = "SmileHub  //  KEY SYSTEM"
TitleLbl.TextColor3         = Color3.fromRGB(255, 255, 255)
TitleLbl.TextSize           = 13
TitleLbl.Font               = Enum.Font.Code
TitleLbl.TextXAlignment     = Enum.TextXAlignment.Left
TitleLbl.ZIndex             = 3

local CloseBtn = Instance.new("TextButton", TopBar)
CloseBtn.Size               = UDim2.new(0, 40, 0, 40)
CloseBtn.Position           = UDim2.new(1, -40, 0, 0)
CloseBtn.BackgroundTransparency = 1
CloseBtn.Text               = "✕"
CloseBtn.TextColor3         = Color3.fromRGB(150, 150, 150)
CloseBtn.TextSize           = 15
CloseBtn.Font               = Enum.Font.Code
CloseBtn.ZIndex             = 4
CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- ── Смайлик ──────────────────────────────────
-- Лицо (белый круг)
local Face = Instance.new("Frame", Main)
Face.Size            = UDim2.new(0, 90, 0, 90)
Face.Position        = UDim2.new(0.5, -45, 0, 50)
Face.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Face.BorderSizePixel  = 0
Instance.new("UICorner", Face).CornerRadius = UDim.new(1, 0)

-- Левый глаз
local EyeL = Instance.new("Frame", Face)
EyeL.Size            = UDim2.new(0, 10, 0, 10)
EyeL.Position        = UDim2.new(0, 20, 0, 25)
EyeL.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
EyeL.BorderSizePixel  = 0
Instance.new("UICorner", EyeL).CornerRadius = UDim.new(1, 0)

-- Правый глаз
local EyeR = Instance.new("Frame", Face)
EyeR.Size            = UDim2.new(0, 10, 0, 10)
EyeR.Position        = UDim2.new(0, 60, 0, 25)
EyeR.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
EyeR.BorderSizePixel  = 0
Instance.new("UICorner", EyeR).CornerRadius = UDim.new(1, 0)

-- Контейнер рта (с обрезкой)
local MouthClip = Instance.new("Frame", Face)
MouthClip.Size              = UDim2.new(0, 50, 0, 26)
MouthClip.Position          = UDim2.new(0, 20, 0, 52)
MouthClip.BackgroundTransparency = 1
MouthClip.BorderSizePixel   = 0
MouthClip.ClipsDescendants  = true

-- Дуга рта
local MouthArc = Instance.new("Frame", MouthClip)
MouthArc.Size           = UDim2.new(0, 50, 0, 50)
MouthArc.BackgroundTransparency = 1
MouthArc.BorderSizePixel = 0
Instance.new("UICorner", MouthArc).CornerRadius = UDim.new(1, 0)

local MouthLine = Instance.new("UIStroke", MouthArc)
MouthLine.Color     = Color3.fromRGB(10, 10, 10)
MouthLine.Thickness = 5

-- Функции смайлика
local function setSmile(mode)
    if mode == "happy" then
        -- Нижняя часть дуги = улыбка
        MouthClip.Size     = UDim2.new(0, 50, 0, 26)
        MouthClip.Position = UDim2.new(0, 20, 0, 52)
        MouthArc.Position  = UDim2.new(0, 0, 0, -24)
        MouthLine.Color    = Color3.fromRGB(10, 10, 10)
    elseif mode == "sad" then
        -- Верхняя часть дуги = грусть
        MouthClip.Size     = UDim2.new(0, 50, 0, 26)
        MouthClip.Position = UDim2.new(0, 20, 0, 58)
        MouthArc.Position  = UDim2.new(0, 0, 0, 0)
        MouthLine.Color    = Color3.fromRGB(10, 10, 10)
    else
        -- Нейтральная линия
        MouthClip.Size     = UDim2.new(0, 50, 0, 5)
        MouthClip.Position = UDim2.new(0, 20, 0, 58)
        MouthArc.Position  = UDim2.new(0, 0, 0, -22)
        MouthLine.Color    = Color3.fromRGB(10, 10, 10)
    end
end

setSmile("neutral")

-- ── HWID label ────────────────────────────────
local HWIDLbl = Instance.new("TextLabel", Main)
HWIDLbl.Size               = UDim2.new(1, -20, 0, 14)
HWIDLbl.Position           = UDim2.new(0, 10, 0, 148)
HWIDLbl.BackgroundTransparency = 1
HWIDLbl.Text               = "HWID: " .. HWID
HWIDLbl.TextColor3         = Color3.fromRGB(50, 50, 50)
HWIDLbl.TextSize           = 9
HWIDLbl.Font               = Enum.Font.Code
HWIDLbl.TextXAlignment     = Enum.TextXAlignment.Left
HWIDLbl.TextTruncate       = Enum.TextTruncate.AtEnd

-- ── TextBox ───────────────────────────────────
local InputBox = Instance.new("TextBox", Main)
InputBox.Size               = UDim2.new(0, 360, 0, 44)
InputBox.Position           = UDim2.new(0, 20, 0, 168)
InputBox.BackgroundColor3   = Color3.fromRGB(20, 20, 20)
InputBox.TextColor3         = Color3.fromRGB(255, 255, 255)
InputBox.PlaceholderColor3  = Color3.fromRGB(80, 80, 80)
InputBox.PlaceholderText    = "Введите ключ доступа..."
InputBox.TextSize           = 13
InputBox.Font               = Enum.Font.Code
InputBox.ClearTextOnFocus   = false
InputBox.Text               = ""
Instance.new("UICorner", InputBox).CornerRadius = UDim.new(0, 5)
local IBStroke = Instance.new("UIStroke", InputBox)
IBStroke.Color = Color3.fromRGB(50, 50, 50) IBStroke.Thickness = 1
local IBPad = Instance.new("UIPadding", InputBox)
IBPad.PaddingLeft = UDim.new(0, 12)

-- ── Кнопки ────────────────────────────────────
local EnterBtn = Instance.new("TextButton", Main)
EnterBtn.Size              = UDim2.new(0, 172, 0, 40)
EnterBtn.Position          = UDim2.new(0, 20, 0, 224)
EnterBtn.BackgroundColor3  = Color3.fromRGB(0, 120, 255)
EnterBtn.TextColor3        = Color3.fromRGB(255, 255, 255)
EnterBtn.Text              = "ENTER"
EnterBtn.TextSize          = 13
EnterBtn.Font              = Enum.Font.Code
EnterBtn.AutoButtonColor   = false
Instance.new("UICorner", EnterBtn).CornerRadius = UDim.new(0, 5)

local ClearBtn = Instance.new("TextButton", Main)
ClearBtn.Size              = UDim2.new(0, 172, 0, 40)
ClearBtn.Position          = UDim2.new(0, 208, 0, 224)
ClearBtn.BackgroundColor3  = Color3.fromRGB(25, 25, 25)
ClearBtn.TextColor3        = Color3.fromRGB(180, 180, 180)
ClearBtn.Text              = "CLEAR"
ClearBtn.TextSize          = 13
ClearBtn.Font              = Enum.Font.Code
ClearBtn.AutoButtonColor   = false
Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 5)
local CStroke = Instance.new("UIStroke", ClearBtn)
CStroke.Color = Color3.fromRGB(55, 55, 55) CStroke.Thickness = 1

-- ── Status labels ─────────────────────────────
local StatusLbl = Instance.new("TextLabel", Main)
StatusLbl.Size              = UDim2.new(1, -20, 0, 24)
StatusLbl.Position          = UDim2.new(0, 10, 0, 278)
StatusLbl.BackgroundTransparency = 1
StatusLbl.Text              = ""
StatusLbl.TextColor3        = Color3.fromRGB(220, 220, 220)
StatusLbl.TextSize          = 12
StatusLbl.Font              = Enum.Font.Code
StatusLbl.TextXAlignment    = Enum.TextXAlignment.Center

local SubLbl = Instance.new("TextLabel", Main)
SubLbl.Size                 = UDim2.new(1, -20, 0, 18)
SubLbl.Position             = UDim2.new(0, 10, 0, 302)
SubLbl.BackgroundTransparency = 1
SubLbl.Text                 = ""
SubLbl.TextColor3           = Color3.fromRGB(80, 80, 80)
SubLbl.TextSize             = 10
SubLbl.Font                 = Enum.Font.Code
SubLbl.TextXAlignment       = Enum.TextXAlignment.Center

-- Helpers
local function setStatus(t, c) StatusLbl.Text = t StatusLbl.TextColor3 = c or Color3.fromRGB(220,220,220) end
local function setSub(t, c) SubLbl.Text = t SubLbl.TextColor3 = c or Color3.fromRGB(80,80,80) end

-- Hover
EnterBtn.MouseEnter:Connect(function() EnterBtn.BackgroundColor3 = Color3.fromRGB(30,140,255) end)
EnterBtn.MouseLeave:Connect(function() EnterBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)  end)
ClearBtn.MouseEnter:Connect(function() ClearBtn.BackgroundColor3 = Color3.fromRGB(38,38,38)   end)
ClearBtn.MouseLeave:Connect(function() ClearBtn.BackgroundColor3 = Color3.fromRGB(25,25,25)   end)

-- ════════════════════════════════════════════
--  Drag
-- ════════════════════════════════════════════
local dragging, dragStart, dragPos
TopBar.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1
    or inp.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = inp.Position
        dragPos   = Main.Position
        inp.Changed:Connect(function()
            if inp.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(inp)
    if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement
                  or inp.UserInputType == Enum.UserInputType.Touch) then
        local d = inp.Position - dragStart
        Main.Position = UDim2.new(
            dragPos.X.Scale, dragPos.X.Offset + d.X,
            dragPos.Y.Scale, dragPos.Y.Offset + d.Y
        )
    end
end)

-- ════════════════════════════════════════════
--  Логика ключей
-- ════════════════════════════════════════════
local busy = false

local function checkKey(key)
    if busy then return end
    busy = true

    EnterBtn.Text = "..."
    EnterBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    setSmile("neutral")
    setStatus("> Проверка ключа...", Color3.fromRGB(200,200,200))
    setSub("Подождите")

    local res, err = httpPost(API_CHECK, { key = key, hwid = HWID })

    if err == "no_http" then
        setSmile("sad")
        setStatus("> HTTP не поддерживается экзекутором", Color3.fromRGB(255,80,80))
        setSub("")
        goto done
    end

    if not res or res.StatusCode ~= 200 then
        setSmile("sad")
        setStatus("> Ошибка соединения с сервером", Color3.fromRGB(255,80,80))
        setSub("Код: " .. tostring(res and res.StatusCode or "нет ответа"))
        goto done
    end

    do
        local ok, data = pcall(HttpService.JSONDecode, HttpService, res.Body)
        if not ok or not data then
            setSmile("sad")
            setStatus("> Ошибка ответа сервера", Color3.fromRGB(255,80,80))
            setSub("")
            goto done
        end

        local s = data.status

        if s == "success" then
            -- Привязываем
            setStatus("> Привязка устройства...", Color3.fromRGB(255,200,0))
            setSub("HWID: " .. HWID)

            local bRes, bErr = httpPost(API_BIND, { key = key, hwid = HWID })
            if bErr or not bRes or bRes.StatusCode ~= 200 then
                setSmile("sad")
                setStatus("> Ошибка привязки к серверу", Color3.fromRGB(255,80,80))
                setSub("")
                goto done
            end

            local ok2, bd = pcall(HttpService.JSONDecode, HttpService, bRes.Body)
            if ok2 and bd and bd.status == "bound" then
                setSmile("happy")
                setStatus("> Успешно! Устройство привязано", Color3.fromRGB(80,255,120))
                setSub("Загрузка SmileHub...")
                task.wait(1.5)
                ScreenGui:Destroy()
                -- loadstring(game:HttpGet("ВАШ_URL_СКРИПТА"))()
            else
                setSmile("sad")
                setStatus("> Ошибка при привязке", Color3.fromRGB(255,80,80))
                setSub("")
            end

        elseif s == "bound_to_you" then
            setSmile("happy")
            setStatus("> Устройство подтверждено!", Color3.fromRGB(80,255,120))
            setSub("Загрузка SmileHub...")
            task.wait(1.5)
            ScreenGui:Destroy()
            -- loadstring(game:HttpGet("ВАШ_URL_СКРИПТА"))()

        elseif s == "bound_to_other" then
            setSmile("sad")
            setStatus("> Ключ занят другим устройством", Color3.fromRGB(255,80,80))
            setSub("Каждый ключ работает только на 1 устройстве")

        elseif s == "expired" then
            setSmile("sad")
            setStatus("> Ключ просрочен", Color3.fromRGB(255,160,0))
            setSub("Получите новый ключ")

        else
            setSmile("sad")
            setStatus("> Неверный ключ", Color3.fromRGB(255,80,80))
            setSub("Проверьте ключ и попробуйте снова")
        end
    end

    ::done::
    task.wait(0.1)
    EnterBtn.Text             = "ENTER"
    EnterBtn.BackgroundColor3 = Color3.fromRGB(0,120,255)
    busy = false
end

-- ════════════════════════════════════════════
--  Кнопки
-- ════════════════════════════════════════════
ClearBtn.MouseButton1Click:Connect(function()
    InputBox.Text = ""
    setStatus("") setSub("")
    setSmile("neutral")
end)

EnterBtn.MouseButton1Click:Connect(function()
    local key = InputBox.Text:match("^%s*(.-)%s*$")
    if key == "" then
        setSmile("sad")
        setStatus("> Введите ключ", Color3.fromRGB(255,160,0))
        setSub("")
        return
    end
    task.spawn(checkKey, key)
end)
