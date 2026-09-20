local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

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

local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.45
overlay.BorderSizePixel = 0
overlay.Parent = sg

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 380, 0, 560)
main.Position = UDim2.new(0.5, -190, 0.5, -280)
main.BackgroundColor3 = Color3.fromRGB(13, 13, 22)
main.BorderSizePixel = 0
main.Parent = sg
local mainC = Instance.new("UICorner")
mainC.CornerRadius = UDim.new(0, 18)
mainC.Parent = main
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(200, 155, 0)
mainStroke.Thickness = 2
mainStroke.Parent = main

local topAccent = Instance.new("Frame")
topAccent.Size = UDim2.new(1, 0, 0, 4)
topAccent.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
topAccent.BorderSizePixel = 0
topAccent.ZIndex = 4
topAccent.Parent = main
local topAccentC = Instance.new("UICorner")
topAccentC.CornerRadius = UDim.new(0, 18)
topAccentC.Parent = topAccent

local topAccentFix = Instance.new("Frame")
topAccentFix.Size = UDim2.new(1, 0, 0.5, 0)
topAccentFix.Position = UDim2.new(0, 0, 0.5, 0)
topAccentFix.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
topAccentFix.BorderSizePixel = 0
topAccentFix.ZIndex = 4
topAccentFix.Parent = topAccent

local headerBar = Instance.new("Frame")
headerBar.Size = UDim2.new(1, 0, 0, 44)
headerBar.BackgroundTransparency = 1
headerBar.ZIndex = 3
headerBar.Parent = main

local backLbl = Instance.new("TextLabel")
backLbl.Size = UDim2.new(0, 120, 1, 0)
backLbl.Position = UDim2.new(0, 14, 0, 0)
backLbl.BackgroundTransparency = 1
backLbl.Text = "← SmileHub"
backLbl.TextColor3 = Color3.fromRGB(160, 160, 160)
backLbl.TextSize = 13
backLbl.Font = Enum.Font.GothamSemibold
backLbl.TextXAlignment = Enum.TextXAlignment.Left
backLbl.ZIndex = 4
backLbl.Parent = headerBar

local activationBadge = Instance.new("Frame")
activationBadge.Size = UDim2.new(0, 120, 0, 30)
activationBadge.Position = UDim2.new(1, -134, 0.5, -15)
activationBadge.BackgroundColor3 = Color3.fromRGB(30, 24, 5)
activationBadge.BorderSizePixel = 0
activationBadge.ZIndex = 4
activationBadge.Parent = headerBar
local abC = Instance.new("UICorner")
abC.CornerRadius = UDim.new(1, 0)
abC.Parent = activationBadge
local abStroke = Instance.new("UIStroke")
abStroke.Color = Color3.fromRGB(200, 155, 0)
abStroke.Thickness = 1.2
abStroke.Parent = activationBadge

local abDot = Instance.new("Frame")
abDot.Size = UDim2.new(0, 8, 0, 8)
abDot.Position = UDim2.new(0, 10, 0.5, -4)
abDot.BackgroundColor3 = Color3.fromRGB(255, 200, 0)
abDot.BorderSizePixel = 0
abDot.ZIndex = 5
abDot.Parent = activationBadge
local abDotC = Instance.new("UICorner")
abDotC.CornerRadius = UDim.new(1, 0)
abDotC.Parent = abDot

local abText = Instance.new("TextLabel")
abText.Size = UDim2.new(1, -24, 1, 0)
abText.Position = UDim2.new(0, 22, 0, 0)
abText.BackgroundTransparency = 1
abText.Text = "Activation"
abText.TextColor3 = Color3.fromRGB(255, 200, 0)
abText.TextSize = 12
abText.Font = Enum.Font.GothamBold
abText.ZIndex = 5
abText.Parent = activationBadge

local logoBox = Instance.new("Frame")
logoBox.Size = UDim2.new(0, 100, 0, 100)
logoBox.Position = UDim2.new(0.5, -50, 0, 52)
logoBox.BackgroundColor3 = Color3.fromRGB(22, 18, 5)
logoBox.BorderSizePixel = 0
logoBox.ZIndex = 3
logoBox.Parent = main
local logoBoxC = Instance.new("UICorner")
logoBoxC.CornerRadius = UDim.new(0, 20)
logoBoxC.Parent = logoBox
local logoBoxStroke = Instance.new("UIStroke")
logoBoxStroke.Color = Color3.fromRGB(180, 140, 0)
logoBoxStroke.Thickness = 1.5
logoBoxStroke.Parent = logoBox

local faceOuter = Instance.new("Frame")
faceOuter.Size = UDim2.new(0, 72, 0, 72)
faceOuter.Position = UDim2.new(0.5, -36, 0.5, -36)
faceOuter.BackgroundColor3 = Color3.fromRGB(210, 160, 0)
faceOuter.BorderSizePixel = 0
faceOuter.ZIndex = 4
faceOuter.Parent = logoBox
local foC = Instance.new("UICorner")
foC.CornerRadius = UDim.new(1, 0)
foC.Parent = faceOuter

local face = Instance.new("Frame")
face.Size = UDim2.new(0, 64, 0, 64)
face.Position = UDim2.new(0.5, -32, 0.5, -32)
face.BackgroundColor3 = Color3.fromRGB(255, 205, 0)
face.BorderSizePixel = 0
face.ZIndex = 5
face.Parent = faceOuter
local faceC = Instance.new("UICorner")
faceC.CornerRadius = UDim.new(1, 0)
faceC.Parent = face

local eyeL = Instance.new("Frame")
eyeL.Size = UDim2.new(0, 8, 0, 9)
eyeL.Position = UDim2.new(0, 14, 0, 18)
eyeL.BackgroundColor3 = Color3.fromRGB(30, 20, 0)
eyeL.BorderSizePixel = 0
eyeL.ZIndex = 6
eyeL.Parent = face
local eyeLC = Instance.new("UICorner")
eyeLC.CornerRadius = UDim.new(1, 0)
eyeLC.Parent = eyeL

local eyeR = Instance.new("Frame")
eyeR.Size = UDim2.new(0, 8, 0, 9)
eyeR.Position = UDim2.new(0, 42, 0, 18)
eyeR.BackgroundColor3 = Color3.fromRGB(30, 20, 0)
eyeR.BorderSizePixel = 0
eyeR.ZIndex = 6
eyeR.Parent = face
local eyeRC = Instance.new("UICorner")
eyeRC.CornerRadius = UDim.new(1, 0)
eyeRC.Parent = eyeR

local mouthClip = Instance.new("Frame")
mouthClip.BackgroundTransparency = 1
mouthClip.BorderSizePixel = 0
mouthClip.ClipsDescendants = true
mouthClip.ZIndex = 6
mouthClip.Parent = face

local mouthArc = Instance.new("Frame")
mouthArc.BackgroundTransparency = 1
mouthArc.BorderSizePixel = 0
mouthArc.ZIndex = 7
mouthArc.Parent = mouthClip
local mouthArcC = Instance.new("UICorner")
mouthArcC.CornerRadius = UDim.new(1, 0)
mouthArcC.Parent = mouthArc
local mouthStroke = Instance.new("UIStroke")
mouthStroke.Color = Color3.fromRGB(30, 20, 0)
mouthStroke.Thickness = 5
mouthStroke.Parent = mouthArc

local cheekL = Instance.new("Frame")
cheekL.Size = UDim2.new(0, 14, 0, 7)
cheekL.Position = UDim2.new(0, 4, 0, 42)
cheekL.BackgroundColor3 = Color3.fromRGB(230, 90, 70)
cheekL.BackgroundTransparency = 0.3
cheekL.BorderSizePixel = 0
cheekL.ZIndex = 6
cheekL.Parent = face
local cheekLC = Instance.new("UICorner")
cheekLC.CornerRadius = UDim.new(1, 0)
cheekLC.Parent = cheekL

local cheekR = Instance.new("Frame")
cheekR.Size = UDim2.new(0, 14, 0, 7)
cheekR.Position = UDim2.new(0, 46, 0, 42)
cheekR.BackgroundColor3 = Color3.fromRGB(230, 90, 70)
cheekR.BackgroundTransparency = 0.3
cheekR.BorderSizePixel = 0
cheekR.ZIndex = 6
cheekR.Parent = face
local cheekRC = Instance.new("UICorner")
cheekRC.CornerRadius = UDim.new(1, 0)
cheekRC.Parent = cheekR

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

local mainTitle = Instance.new("TextLabel")
mainTitle.Size = UDim2.new(1, -30, 0, 46)
mainTitle.Position = UDim2.new(0, 15, 0, 162)
mainTitle.BackgroundTransparency = 1
mainTitle.Text = "Activate License"
mainTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
mainTitle.TextSize = 30
mainTitle.Font = Enum.Font.GothamBold
mainTitle.TextXAlignment = Enum.TextXAlignment.Center
mainTitle.ZIndex = 3
mainTitle.Parent = main

local subTitle = Instance.new("TextLabel")
subTitle.Size = UDim2.new(1, -40, 0, 44)
subTitle.Position = UDim2.new(0, 20, 0, 208)
subTitle.BackgroundTransparency = 1
subTitle.Text = "Введите ваш SmileHub ключ чтобы привязать и активировать устройство."
subTitle.TextColor3 = Color3.fromRGB(150, 150, 160)
subTitle.TextSize = 13
subTitle.Font = Enum.Font.Gotham
subTitle.TextXAlignment = Enum.TextXAlignment.Center
subTitle.TextWrapped = true
subTitle.ZIndex = 3
subTitle.Parent = main

local divLine = Instance.new("Frame")
divLine.Size = UDim2.new(1, -40, 0, 1)
divLine.Position = UDim2.new(0, 20, 0, 260)
divLine.BackgroundColor3 = Color3.fromRGB(50, 45, 20)
divLine.BorderSizePixel = 0
divLine.ZIndex = 3
divLine.Parent = main

local keyLabel = Instance.new("TextLabel")
keyLabel.Size = UDim2.new(0, 120, 0, 28)
keyLabel.Position = UDim2.new(0, 20, 0, 272)
keyLabel.BackgroundTransparency = 1
keyLabel.Text = "LICENSE KEY"
keyLabel.TextColor3 = Color3.fromRGB(120, 120, 130)
keyLabel.TextSize = 11
keyLabel.Font = Enum.Font.GothamBold
keyLabel.TextXAlignment = Enum.TextXAlignment.Left
keyLabel.ZIndex = 3
keyLabel.Parent = main

local pasteBtn = Instance.new("TextButton")
pasteBtn.Size = UDim2.new(0, 100, 0, 28)
pasteBtn.Position = UDim2.new(1, -120, 0, 272)
pasteBtn.BackgroundColor3 = Color3.fromRGB(28, 22, 5)
pasteBtn.TextColor3 = Color3.fromRGB(255, 200, 0)
pasteBtn.Text = "Paste Key"
pasteBtn.TextSize = 12
pasteBtn.Font = Enum.Font.GothamBold
pasteBtn.AutoButtonColor = false
pasteBtn.BorderSizePixel = 0
pasteBtn.ZIndex = 4
pasteBtn.Parent = main
local pasteBtnC = Instance.new("UICorner")
pasteBtnC.CornerRadius = UDim.new(0, 8)
pasteBtnC.Parent = pasteBtn
local pasteBtnStroke = Instance.new("UIStroke")
pasteBtnStroke.Color = Color3.fromRGB(180, 140, 0)
pasteBtnStroke.Thickness = 1
pasteBtnStroke.Parent = pasteBtn

pasteBtn.MouseEnter:Connect(function()
    pasteBtn.BackgroundColor3 = Color3.fromRGB(45, 35, 8)
end)
pasteBtn.MouseLeave:Connect(function()
    pasteBtn.BackgroundColor3 = Color3.fromRGB(28, 22, 5)
end)

local inputOuter = Instance.new("Frame")
inputOuter.Size = UDim2.new(1, -40, 0, 54)
inputOuter.Position = UDim2.new(0, 20, 0, 308)
inputOuter.BackgroundColor3 = Color3.fromRGB(18, 15, 5)
inputOuter.BorderSizePixel = 0
inputOuter.ZIndex = 3
inputOuter.Parent = main
local inputOuterC = Instance.new("UICorner")
inputOuterC.CornerRadius = UDim.new(0, 12)
inputOuterC.Parent = inputOuter
local inputOuterStroke = Instance.new("UIStroke")
inputOuterStroke.Color = Color3.fromRGB(120, 95, 0)
inputOuterStroke.Thickness = 1.5
inputOuterStroke.Parent = inputOuter

local prefixBadge = Instance.new("Frame")
prefixBadge.Size = UDim2.new(0, 44, 0, 34)
prefixBadge.Position = UDim2.new(0, 10, 0.5, -17)
prefixBadge.BackgroundColor3 = Color3.fromRGB(40, 30, 5)
prefixBadge.BorderSizePixel = 0
prefixBadge.ZIndex = 4
prefixBadge.Parent = inputOuter
local prefixC = Instance.new("UICorner")
prefixC.CornerRadius = UDim.new(0, 8)
prefixC.Parent = prefixBadge
local prefixStroke = Instance.new("UIStroke")
prefixStroke.Color = Color3.fromRGB(180, 140, 0)
prefixStroke.Thickness = 1
prefixStroke.Parent = prefixBadge

local prefixLbl = Instance.new("TextLabel")
prefixLbl.Size = UDim2.new(1, 0, 1, 0)
prefixLbl.BackgroundTransparency = 1
prefixLbl.Text = "Sm"
prefixLbl.TextColor3 = Color3.fromRGB(255, 200, 0)
prefixLbl.TextSize = 13
prefixLbl.Font = Enum.Font.GothamBold
prefixLbl.TextXAlignment = Enum.TextXAlignment.Center
prefixLbl.ZIndex = 5
prefixLbl.Parent = prefixBadge

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(1, -70, 1, 0)
inputBox.Position = UDim2.new(0, 62, 0, 0)
inputBox.BackgroundTransparency = 1
inputBox.TextColor3 = Color3.fromRGB(255, 210, 60)
inputBox.PlaceholderColor3 = Color3.fromRGB(100, 80, 20)
inputBox.PlaceholderText = "Sm-Vip-XXXXXXXXXXXX"
inputBox.TextSize = 14
inputBox.Font = Enum.Font.Code
inputBox.ClearTextOnFocus = false
inputBox.Text = ""
inputBox.ZIndex = 5
inputBox.Parent = inputOuter

local hwidLbl = Instance.new("TextLabel")
hwidLbl.Size = UDim2.new(1, -40, 0, 16)
hwidLbl.Position = UDim2.new(0, 20, 0, 370)
hwidLbl.BackgroundTransparency = 1
hwidLbl.Text = "HWID : " .. HWID
hwidLbl.TextColor3 = Color3.fromRGB(70, 70, 80)
hwidLbl.TextSize = 9
hwidLbl.Font = Enum.Font.Code
hwidLbl.TextXAlignment = Enum.TextXAlignment.Left
hwidLbl.TextTruncate = Enum.TextTruncate.AtEnd
hwidLbl.ZIndex = 3
hwidLbl.Parent = main

local statusLbl = Instance.new("TextLabel")
statusLbl.Size = UDim2.new(1, -40, 0, 26)
statusLbl.Position = UDim2.new(0, 20, 0, 390)
statusLbl.BackgroundTransparency = 1
statusLbl.Text = ""
statusLbl.TextColor3 = Color3.fromRGB(220, 50, 50)
statusLbl.TextSize = 14
statusLbl.Font = Enum.Font.GothamBold
statusLbl.TextXAlignment = Enum.TextXAlignment.Center
statusLbl.ZIndex = 3
statusLbl.Parent = main

local subLbl = Instance.new("TextLabel")
subLbl.Size = UDim2.new(1, -40, 0, 20)
subLbl.Position = UDim2.new(0, 20, 0, 416)
subLbl.BackgroundTransparency = 1
subLbl.Text = ""
subLbl.TextColor3 = Color3.fromRGB(130, 130, 140)
subLbl.TextSize = 11
subLbl.Font = Enum.Font.Gotham
subLbl.TextXAlignment = Enum.TextXAlignment.Center
subLbl.ZIndex = 3
subLbl.Parent = main

local activateBtn = Instance.new("TextButton")
activateBtn.Size = UDim2.new(1, -40, 0, 54)
activateBtn.Position = UDim2.new(0, 20, 0, 446)
activateBtn.BackgroundColor3 = Color3.fromRGB(28, 22, 5)
activateBtn.TextColor3 = Color3.fromRGB(255, 210, 0)
activateBtn.Text = "Activate License"
activateBtn.TextSize = 17
activateBtn.Font = Enum.Font.GothamBold
activateBtn.AutoButtonColor = false
activateBtn.BorderSizePixel = 0
activateBtn.ZIndex = 3
activateBtn.Parent = main
local activateBtnC = Instance.new("UICorner")
activateBtnC.CornerRadius = UDim.new(0, 12)
activateBtnC.Parent = activateBtn
local activateBtnStroke = Instance.new("UIStroke")
activateBtnStroke.Color = Color3.fromRGB(200, 155, 0)
activateBtnStroke.Thickness = 1.8
activateBtnStroke.Parent = activateBtn

activateBtn.MouseEnter:Connect(function()
    activateBtn.BackgroundColor3 = Color3.fromRGB(45, 35, 5)
end)
activateBtn.MouseLeave:Connect(function()
    activateBtn.BackgroundColor3 = Color3.fromRGB(28, 22, 5)
end)

local function setStatus(t, c)
    statusLbl.Text = t
    statusLbl.TextColor3 = c or Color3.fromRGB(220, 50, 50)
end

local function setSub(t, c)
    subLbl.Text = t
    subLbl.TextColor3 = c or Color3.fromRGB(130, 130, 140)
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
    if dragging and (inp.UserInputType == Enum.UserInputType.MouseMovement or inp.UserInputType == Enum.UserInputType.Touch) then
        local d = inp.Position - dragStart
        main.Position = UDim2.new(dragPos.X.Scale, dragPos.X.Offset + d.X, dragPos.Y.Scale, dragPos.Y.Offset + d.Y)
    end
end)

pasteBtn.MouseButton1Click:Connect(function()
    local ok, clip = pcall(function()
        return UserInputService:GetClipboardText()
    end)
    if ok and clip and clip ~= "" then
        inputBox.Text = clip
        setStatus("") setSub("")
    else
        setStatus("> Буфер обмена пуст", Color3.fromRGB(200, 150, 30))
    end
end)

local busy = false

local function checkKey(key)
    if busy then return end
    busy = true
    activateBtn.Text = "Проверка..."
    setSmile("neutral")
    setStatus("> Проверка лицензии...", Color3.fromRGB(200, 170, 40))
    setSub("Подождите")

    local res = httpPost(API_CHECK, { key = key, hwid = HWID })

    if not res then
        setSmile("sad")
        setStatus("> Ошибка соединения", Color3.fromRGB(220, 50, 50))
        setSub("Сервер недоступен")
        activateBtn.Text = "Activate License"
        busy = false
        return
    end

    if res.StatusCode ~= 200 then
        setSmile("sad")
        setStatus("> Ошибка сервера: " .. tostring(res.StatusCode), Color3.fromRGB(220, 50, 50))
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
        setStatus("> Неверный ответ сервера", Color3.fromRGB(220, 50, 50))
        setSub("")
        activateBtn.Text = "Activate License"
        busy = false
        return
    end

    local s = data.status

    if s == "success" then
        setStatus("> Привязка устройства...", Color3.fromRGB(200, 170, 40))
        setSub("HWID: " .. HWID)

        local bRes = httpPost(API_BIND, { key = key, hwid = HWID })

        if not bRes or bRes.StatusCode ~= 200 then
            setSmile("sad")
            setStatus("> Ошибка привязки", Color3.fromRGB(220, 50, 50))
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
            setStatus("> Лицензия активирована!", Color3.fromRGB(80, 220, 100))
            setSub("Добро пожаловать в SmileHub!")
            task.wait(1.5)
            sg:Destroy()
        else
            setSmile("sad")
            setStatus("> Ошибка при привязке", Color3.fromRGB(220, 50, 50))
            setSub("")
        end

    elseif s == "bound_to_you" then
        setSmile("happy")
        setStatus("> Лицензия подтверждена!", Color3.fromRGB(80, 220, 100))
        setSub("Добро пожаловать в SmileHub!")
        task.wait(1.5)
        sg:Destroy()

    elseif s == "bound_to_other" then
        setSmile("sad")
        setStatus("> Ключ занят другим устройством", Color3.fromRGB(220, 50, 50))
        setSub("Каждый ключ работает только на 1 устройстве")

    elseif s == "expired" then
        setSmile("sad")
        setStatus("> Лицензия просрочена", Color3.fromRGB(220, 140, 30))
        setSub("Получите новый ключ")

    else
        setSmile("sad")
        setStatus("> Неверный ключ", Color3.fromRGB(220, 50, 50))
        setSub("Проверьте ключ и попробуйте снова")
    end

    activateBtn.Text = "Activate License"
    busy = false
end

activateBtn.MouseButton1Click:Connect(function()
    local key = inputBox.Text:match("^%s*(.-)%s*$")
    if key == "" then
        setSmile("sad")
        setStatus("> Введите ключ лицензии", Color3.fromRGB(220, 140, 30))
        setSub("")
        return
    end
    task.spawn(checkKey, key)
end)
