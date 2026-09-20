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

if pg:FindFirstChild("SmileHubKey") then pg.SmileHubKey:Destroy() end

local sg = Instance.new("ScreenGui")
sg.Name = "SmileHubKey"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = pg

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1, 0, 1, 0)
bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
bg.BackgroundTransparency = 0.4
bg.BorderSizePixel = 0
bg.Parent = sg

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 370, 0, 480)
main.Position = UDim2.new(0.5, -185, 0.5, -240)
main.BackgroundColor3 = Color3.fromRGB(8, 8, 18)
main.BorderSizePixel = 0
main.Parent = sg
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 12)
mainCorner.Parent = main

local outerGlow = Instance.new("UIStroke")
outerGlow.Color = Color3.fromRGB(180, 140, 0)
outerGlow.Thickness = 2
outerGlow.Parent = main

local gridImg = Instance.new("ImageLabel")
gridImg.Size = UDim2.new(1, 0, 1, 0)
gridImg.BackgroundTransparency = 1
gridImg.Image = "rbxassetid://6372755229"
gridImg.ImageColor3 = Color3.fromRGB(30, 100, 30)
gridImg.ImageTransparency = 0.82
gridImg.ScaleType = Enum.ScaleType.Tile
gridImg.TileSize = UDim2.new(0, 60, 0, 60)
gridImg.Parent = main
local gridCorner = Instance.new("UICorner")
gridCorner.CornerRadius = UDim.new(0, 12)
gridCorner.Parent = gridImg

local topGrad = Instance.new("Frame")
topGrad.Size = UDim2.new(1, 0, 0.4, 0)
topGrad.BackgroundColor3 = Color3.fromRGB(20, 60, 10)
topGrad.BackgroundTransparency = 0.6
topGrad.BorderSizePixel = 0
topGrad.Parent = main
local topGradCorner = Instance.new("UICorner")
topGradCorner.CornerRadius = UDim.new(0, 12)
topGradCorner.Parent = topGrad

local titleSmile = Instance.new("TextLabel")
titleSmile.Size = UDim2.new(1, 0, 0, 44)
titleSmile.Position = UDim2.new(0, 0, 0, 18)
titleSmile.BackgroundTransparency = 1
titleSmile.Text = "Smile Hub"
titleSmile.TextColor3 = Color3.fromRGB(255, 200, 0)
titleSmile.TextSize = 30
titleSmile.Font = Enum.Font.GothamBold
titleSmile.TextXAlignment = Enum.TextXAlignment.Center
titleSmile.ZIndex = 3
titleSmile.Parent = main

local titleKey = Instance.new("TextLabel")
titleKey.Size = UDim2.new(1, 0, 0, 22)
titleKey.Position = UDim2.new(0, 0, 0, 60)
titleKey.BackgroundTransparency = 1
titleKey.Text = "Key System"
titleKey.TextColor3 = Color3.fromRGB(220, 40, 40)
titleKey.TextSize = 15
titleKey.Font = Enum.Font.GothamBold
titleKey.TextXAlignment = Enum.TextXAlignment.Center
titleKey.ZIndex = 3
titleKey.Parent = main

local divLine = Instance.new("Frame")
divLine.Size = UDim2.new(0.85, 0, 0, 1)
divLine.Position = UDim2.new(0.075, 0, 0, 86)
divLine.BackgroundColor3 = Color3.fromRGB(180, 140, 0)
divLine.BackgroundTransparency = 0.5
divLine.BorderSizePixel = 0
divLine.ZIndex = 3
divLine.Parent = main

local faceOuter = Instance.new("Frame")
faceOuter.Size = UDim2.new(0, 108, 0, 108)
faceOuter.Position = UDim2.new(0.5, -54, 0, 96)
faceOuter.BackgroundColor3 = Color3.fromRGB(200, 150, 0)
faceOuter.BorderSizePixel = 0
faceOuter.ZIndex = 3
faceOuter.Parent = main
local faceOuterCorner = Instance.new("UICorner")
faceOuterCorner.CornerRadius = UDim.new(1, 0)
faceOuterCorner.Parent = faceOuter

local face = Instance.new("Frame")
face.Size = UDim2.new(0, 100, 0, 100)
face.Position = UDim2.new(0.5, -50, 0.5, -50)
face.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
face.BorderSizePixel = 0
face.ZIndex = 4
face.Parent = faceOuter
local faceCorner = Instance.new("UICorner")
faceCorner.CornerRadius = UDim.new(1, 0)
faceCorner.Parent = face

local eyeL = Instance.new("Frame")
eyeL.Size = UDim2.new(0, 11, 0, 13)
eyeL.Position = UDim2.new(0, 22, 0, 28)
eyeL.BackgroundColor3 = Color3.fromRGB(30, 20, 0)
eyeL.BorderSizePixel = 0
eyeL.ZIndex = 5
eyeL.Parent = face
local eyeLCorner = Instance.new("UICorner")
eyeLCorner.CornerRadius = UDim.new(1, 0)
eyeLCorner.Parent = eyeL

local eyeR = Instance.new("Frame")
eyeR.Size = UDim2.new(0, 11, 0, 13)
eyeR.Position = UDim2.new(0, 67, 0, 28)
eyeR.BackgroundColor3 = Color3.fromRGB(30, 20, 0)
eyeR.BorderSizePixel = 0
eyeR.ZIndex = 5
eyeR.Parent = face
local eyeRCorner = Instance.new("UICorner")
eyeRCorner.CornerRadius = UDim.new(1, 0)
eyeRCorner.Parent = eyeR

local mouthClip = Instance.new("Frame")
mouthClip.BackgroundTransparency = 1
mouthClip.BorderSizePixel = 0
mouthClip.ClipsDescendants = true
mouthClip.ZIndex = 5
mouthClip.Parent = face

local mouthRing = Instance.new("Frame")
mouthRing.BackgroundTransparency = 1
mouthRing.BorderSizePixel = 0
mouthRing.ZIndex = 6
mouthRing.Parent = mouthClip
local mouthRingCorner = Instance.new("UICorner")
mouthRingCorner.CornerRadius = UDim.new(1, 0)
mouthRingCorner.Parent = mouthRing
local mouthStroke = Instance.new("UIStroke")
mouthStroke.Color = Color3.fromRGB(30, 20, 0)
mouthStroke.Thickness = 6
mouthStroke.Parent = mouthRing

local cheekL = Instance.new("Frame")
cheekL.Size = UDim2.new(0, 18, 0, 9)
cheekL.Position = UDim2.new(0, 8, 0, 62)
cheekL.BackgroundColor3 = Color3.fromRGB(230, 100, 80)
cheekL.BackgroundTransparency = 0.3
cheekL.BorderSizePixel = 0
cheekL.ZIndex = 5
cheekL.Parent = face
local cheekLCorner = Instance.new("UICorner")
cheekLCorner.CornerRadius = UDim.new(1, 0)
cheekLCorner.Parent = cheekL

local cheekR = Instance.new("Frame")
cheekR.Size = UDim2.new(0, 18, 0, 9)
cheekR.Position = UDim2.new(0, 74, 0, 62)
cheekR.BackgroundColor3 = Color3.fromRGB(230, 100, 80)
cheekR.BackgroundTransparency = 0.3
cheekR.BorderSizePixel = 0
cheekR.ZIndex = 5
cheekR.Parent = face
local cheekRCorner = Instance.new("UICorner")
cheekRCorner.CornerRadius = UDim.new(1, 0)
cheekRCorner.Parent = cheekR

local function setSmile(mode)
    if mode == "happy" then
        mouthClip.Size = UDim2.new(0, 56, 0, 30)
        mouthClip.Position = UDim2.new(0, 22, 0, 58)
        mouthRing.Size = UDim2.new(0, 56, 0, 56)
        mouthRing.Position = UDim2.new(0, 0, 0, -28)
        eyeL.Size = UDim2.new(0, 11, 0, 13)
        eyeL.Position = UDim2.new(0, 22, 0, 26)
        eyeR.Size = UDim2.new(0, 11, 0, 13)
        eyeR.Position = UDim2.new(0, 67, 0, 26)
        cheekL.BackgroundTransparency = 0.3
        cheekR.BackgroundTransparency = 0.3
    elseif mode == "sad" then
        mouthClip.Size = UDim2.new(0, 56, 0, 30)
        mouthClip.Position = UDim2.new(0, 22, 0, 62)
        mouthRing.Size = UDim2.new(0, 56, 0, 56)
        mouthRing.Position = UDim2.new(0, 0, 0, 0)
        eyeL.Size = UDim2.new(0, 11, 0, 10)
        eyeL.Position = UDim2.new(0, 22, 0, 30)
        eyeR.Size = UDim2.new(0, 11, 0, 10)
        eyeR.Position = UDim2.new(0, 67, 0, 30)
        cheekL.BackgroundTransparency = 1
        cheekR.BackgroundTransparency = 1
    else
        mouthClip.Size = UDim2.new(0, 46, 0, 5)
        mouthClip.Position = UDim2.new(0, 27, 0, 66)
        mouthRing.Size = UDim2.new(0, 46, 0, 46)
        mouthRing.Position = UDim2.new(0, 0, 0, -20)
        eyeL.Size = UDim2.new(0, 11, 0, 13)
        eyeL.Position = UDim2.new(0, 22, 0, 28)
        eyeR.Size = UDim2.new(0, 11, 0, 13)
        eyeR.Position = UDim2.new(0, 67, 0, 28)
        cheekL.BackgroundTransparency = 1
        cheekR.BackgroundTransparency = 1
    end
end

setSmile("neutral")

local hwidLbl = Instance.new("TextLabel")
hwidLbl.Size = UDim2.new(1, -20, 0, 14)
hwidLbl.Position = UDim2.new(0, 10, 0, 212)
hwidLbl.BackgroundTransparency = 1
hwidLbl.Text = "HWID : " .. HWID
hwidLbl.TextColor3 = Color3.fromRGB(120, 120, 120)
hwidLbl.TextSize = 10
hwidLbl.Font = Enum.Font.Code
hwidLbl.TextXAlignment = Enum.TextXAlignment.Left
hwidLbl.TextTruncate = Enum.TextTruncate.AtEnd
hwidLbl.ZIndex = 3
hwidLbl.Parent = main

local inputWrapper = Instance.new("Frame")
inputWrapper.Size = UDim2.new(0, 330, 0, 48)
inputWrapper.Position = UDim2.new(0.5, -165, 0, 232)
inputWrapper.BackgroundColor3 = Color3.fromRGB(160, 120, 0)
inputWrapper.BorderSizePixel = 0
inputWrapper.ZIndex = 3
inputWrapper.Parent = main
local inputWrapperCorner = Instance.new("UICorner")
inputWrapperCorner.CornerRadius = UDim.new(0, 6)
inputWrapperCorner.Parent = inputWrapper

local inputInner = Instance.new("Frame")
inputInner.Size = UDim2.new(1, -4, 1, -4)
inputInner.Position = UDim2.new(0, 2, 0, 2)
inputInner.BackgroundColor3 = Color3.fromRGB(10, 10, 20)
inputInner.BorderSizePixel = 0
inputInner.ZIndex = 4
inputInner.Parent = inputWrapper
local inputInnerCorner = Instance.new("UICorner")
inputInnerCorner.CornerRadius = UDim.new(0, 5)
inputInnerCorner.Parent = inputInner

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -20, 1, 0)
inputBox.Position = UDim2.new(0, 10, 0, 0)
inputBox.BackgroundTransparency = 1
inputBox.TextColor3 = Color3.fromRGB(255, 220, 80)
inputBox.PlaceholderColor3 = Color3.fromRGB(120, 100, 40)
inputBox.PlaceholderText = "Введите ключ доступа..."
inputBox.TextSize = 13
inputBox.Font = Enum.Font.Code
inputBox.ClearTextOnFocus = false
inputBox.Text = ""
inputBox.ZIndex = 5
inputBox.Parent = inputInner

local function makeGoldBtn(text, posX, width)
    local wrapper = Instance.new("Frame")
    wrapper.Size = UDim2.new(0, width, 0, 48)
    wrapper.Position = UDim2.new(0, posX, 0, 296)
    wrapper.BackgroundColor3 = Color3.fromRGB(180, 140, 0)
    wrapper.BorderSizePixel = 0
    wrapper.ZIndex = 3
    wrapper.Parent = main
    local wc = Instance.new("UICorner")
    wc.CornerRadius = UDim.new(0, 6)
    wc.Parent = wrapper

    local inner = Instance.new("TextButton")
    inner.Size = UDim2.new(1, -4, 1, -4)
    inner.Position = UDim2.new(0, 2, 0, 2)
    inner.BackgroundColor3 = Color3.fromRGB(25, 20, 5)
    inner.TextColor3 = Color3.fromRGB(220, 170, 0)
    inner.Text = text
    inner.TextSize = 15
    inner.Font = Enum.Font.GothamBold
    inner.AutoButtonColor = false
    inner.BorderSizePixel = 0
    inner.ZIndex = 4
    inner.Parent = wrapper
    local ic = Instance.new("UICorner")
    ic.CornerRadius = UDim.new(0, 5)
    ic.Parent = inner

    inner.MouseEnter:Connect(function()
        inner.BackgroundColor3 = Color3.fromRGB(45, 35, 5)
    end)
    inner.MouseLeave:Connect(function()
        inner.BackgroundColor3 = Color3.fromRGB(25, 20, 5)
    end)

    return inner
end

local enterBtn = makeGoldBtn("ENTER", 20, 155)
local clearBtn = makeGoldBtn("CLEAR", 195, 155)

local statusLbl = Instance.new("TextLabel")
statusLbl.Size = UDim2.new(1, -20, 0, 28)
statusLbl.Position = UDim2.new(0, 10, 0, 358)
statusLbl.BackgroundTransparency = 1
statusLbl.Text = ""
statusLbl.TextColor3 = Color3.fromRGB(220, 50, 50)
statusLbl.TextSize = 15
statusLbl.Font = Enum.Font.GothamBold
statusLbl.TextXAlignment = Enum.TextXAlignment.Center
statusLbl.ZIndex = 3
statusLbl.Parent = main

local subLbl = Instance.new("TextLabel")
subLbl.Size = UDim2.new(1, -20, 0, 22)
subLbl.Position = UDim2.new(0, 10, 0, 386)
subLbl.BackgroundTransparency = 1
subLbl.Text = ""
subLbl.TextColor3 = Color3.fromRGB(140, 140, 140)
subLbl.TextSize = 12
subLbl.Font = Enum.Font.Code
subLbl.TextXAlignment = Enum.TextXAlignment.Center
subLbl.ZIndex = 3
subLbl.Parent = main

local versionLbl = Instance.new("TextLabel")
versionLbl.Size = UDim2.new(1, 0, 0, 18)
versionLbl.Position = UDim2.new(0, 0, 0, 454)
versionLbl.BackgroundTransparency = 1
versionLbl.Text = "v1.0 — SmileHub"
versionLbl.TextColor3 = Color3.fromRGB(80, 80, 80)
versionLbl.TextSize = 10
versionLbl.Font = Enum.Font.Code
versionLbl.TextXAlignment = Enum.TextXAlignment.Center
versionLbl.ZIndex = 3
versionLbl.Parent = main

local function setStatus(t, c)
    statusLbl.Text = t
    statusLbl.TextColor3 = c or Color3.fromRGB(220, 50, 50)
end

local function setSub(t, c)
    subLbl.Text = t
    subLbl.TextColor3 = c or Color3.fromRGB(140, 140, 140)
end

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

UserInputService.InputChanged:Connect(function(inp)
    if dragging then
        if inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch then
            local d = inp.Position - dragStart
            main.Position = UDim2.new(dragPos.X.Scale, dragPos.X.Offset + d.X, dragPos.Y.Scale, dragPos.Y.Offset + d.Y)
        end
    end
end)

local busy = false

local function checkKey(key)
    if busy then return end
    busy = true
    enterBtn.Text = "..."
    setSmile("neutral")
    setStatus("> Проверка ключа...", Color3.fromRGB(200, 170, 50))
    setSub("Подождите")

    local res = httpPost(API_CHECK, { key = key, hwid = HWID })

    if not res then
        setSmile("sad")
        setStatus("> Ошибка соединения", Color3.fromRGB(220, 50, 50))
        setSub("Сервер недоступен")
        enterBtn.Text = "ENTER"
        busy = false
        return
    end

    if res.StatusCode ~= 200 then
        setSmile("sad")
        setStatus("> Ошибка сервера: " .. tostring(res.StatusCode), Color3.fromRGB(220, 50, 50))
        setSub("")
        enterBtn.Text = "ENTER"
        busy = false
        return
    end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(res.Body)
    end)

    if not ok or not data then
        setSmile("sad")
        setStatus("> Неверный ответ сервера", Color3.fromRGB(220, 50, 50))
        setSub("")
        enterBtn.Text = "ENTER"
        busy = false
        return
    end

    local s = data.status

    if s == "success" then
        setStatus("> Привязка устройства...", Color3.fromRGB(200, 170, 50))
        setSub("HWID: " .. HWID)

        local bRes = httpPost(API_BIND, { key = key, hwid = HWID })

        if not bRes or bRes.StatusCode ~= 200 then
            setSmile("sad")
            setStatus("> Ошибка привязки", Color3.fromRGB(220, 50, 50))
            setSub("")
            enterBtn.Text = "ENTER"
            busy = false
            return
        end

        local ok2, bd = pcall(function()
            return HttpService:JSONDecode(bRes.Body)
        end)

        if ok2 and bd and bd.status == "bound" then
            setSmile("happy")
            setStatus("> Успешно! Добро пожаловать!", Color3.fromRGB(80, 220, 100))
            setSub("Загрузка SmileHub...")
            task.wait(1.5)
            sg:Destroy()
        else
            setSmile("sad")
            setStatus("> Ошибка при привязке", Color3.fromRGB(220, 50, 50))
            setSub("")
        end

    elseif s == "bound_to_you" then
        setSmile("happy")
        setStatus("> Добро пожаловать!", Color3.fromRGB(80, 220, 100))
        setSub("Загрузка SmileHub...")
        task.wait(1.5)
        sg:Destroy()

    elseif s == "bound_to_other" then
        setSmile("sad")
        setStatus("> Ключ занят другим устройством", Color3.fromRGB(220, 50, 50))
        setSub("Каждый ключ работает только на 1 устройстве")

    elseif s == "expired" then
        setSmile("sad")
        setStatus("> Ключ просрочен", Color3.fromRGB(220, 140, 30))
        setSub("Получите новый ключ")

    else
        setSmile("sad")
        setStatus("> Неверный ключ", Color3.fromRGB(220, 50, 50))
        setSub("Проверьте ключ и попробуйте снова")
    end

    enterBtn.Text = "ENTER"
    busy = false
end

clearBtn.MouseButton1Click:Connect(function()
    inputBox.Text = ""
    setStatus("")
    setSub("")
    setSmile("neutral")
end)

enterBtn.MouseButton1Click:Connect(function()
    local key = inputBox.Text:match("^%s*(.-)%s*$")
    if key == "" then
        setSmile("sad")
        setStatus("> Введите ключ", Color3.fromRGB(220, 140, 30))
        setSub("")
        return
    end
    task.spawn(checkKey, key)
end)
