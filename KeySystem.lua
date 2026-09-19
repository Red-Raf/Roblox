local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")

local lp = Players.LocalPlayer
local pg = lp:WaitForChild("PlayerGui")

local API_CHECK = "https://keybot-rfgspl.mia0.amvera.tech/api/check"
local API_BIND  = "https://keybot-rfgspl.mia0.amvera.tech/api/bind"

local function getHWID()
    if getdeviceid then
        return tostring(getdeviceid())
    end
    return tostring(lp.UserId)
end

local HWID = getHWID()

local function httpPost(url, body)
    local fn = nil
    if syn and syn.request then
        fn = syn.request
    elseif http_request then
        fn = http_request
    elseif request then
        fn = request
    end
    if not fn then return nil end
    local ok, res = pcall(fn, {
        Url = url,
        Method = "POST",
        Headers = { ["Content-Type"] = "application/json" },
        Body = HttpService:JSONEncode(body),
    })
    if ok then return res end
    return nil
end

if pg:FindFirstChild("SmileHubKey") then
    pg.SmileHubKey:Destroy()
end

local sg = Instance.new("ScreenGui")
sg.Name = "SmileHubKey"
sg.ResetOnSpawn = false
sg.IgnoreGuiInset = true
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = pg

local main = Instance.new("Frame")
main.Size = UDim2.new(0, 400, 0, 350)
main.Position = UDim2.new(0.5, -200, 0.5, -175)
main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
main.BorderSizePixel = 0
main.Parent = sg
local mainCorner = Instance.new("UICorner")
mainCorner.CornerRadius = UDim.new(0, 8)
mainCorner.Parent = main
local mainStroke = Instance.new("UIStroke")
mainStroke.Color = Color3.fromRGB(255, 255, 255)
mainStroke.Thickness = 1.5
mainStroke.Parent = main

local topbar = Instance.new("Frame")
topbar.Size = UDim2.new(1, 0, 0, 40)
topbar.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
topbar.BorderSizePixel = 0
topbar.ZIndex = 2
topbar.Parent = main
local topCorner = Instance.new("UICorner")
topCorner.CornerRadius = UDim.new(0, 8)
topCorner.Parent = topbar
local topFix = Instance.new("Frame")
topFix.Size = UDim2.new(1, 0, 0, 10)
topFix.Position = UDim2.new(0, 0, 1, -10)
topFix.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
topFix.BorderSizePixel = 0
topFix.ZIndex = 2
topFix.Parent = topbar

local titleLbl = Instance.new("TextLabel")
titleLbl.Size = UDim2.new(1, -50, 1, 0)
titleLbl.Position = UDim2.new(0, 14, 0, 0)
titleLbl.BackgroundTransparency = 1
titleLbl.Text = "SmileHub  //  KEY SYSTEM"
titleLbl.TextColor3 = Color3.fromRGB(255, 255, 255)
titleLbl.TextSize = 13
titleLbl.Font = Enum.Font.Code
titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.ZIndex = 3
titleLbl.Parent = topbar

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -40, 0, 0)
closeBtn.BackgroundTransparency = 1
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(150, 150, 150)
closeBtn.TextSize = 15
closeBtn.Font = Enum.Font.Code
closeBtn.ZIndex = 4
closeBtn.Parent = topbar
closeBtn.MouseButton1Click:Connect(function()
    sg:Destroy()
end)

local face = Instance.new("Frame")
face.Size = UDim2.new(0, 90, 0, 90)
face.Position = UDim2.new(0.5, -45, 0, 50)
face.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
face.BorderSizePixel = 0
face.Parent = main
local faceCorner = Instance.new("UICorner")
faceCorner.CornerRadius = UDim.new(1, 0)
faceCorner.Parent = face

local eyeL = Instance.new("Frame")
eyeL.Size = UDim2.new(0, 10, 0, 10)
eyeL.Position = UDim2.new(0, 20, 0, 25)
eyeL.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
eyeL.BorderSizePixel = 0
eyeL.Parent = face
local eyeLCorner = Instance.new("UICorner")
eyeLCorner.CornerRadius = UDim.new(1, 0)
eyeLCorner.Parent = eyeL

local eyeR = Instance.new("Frame")
eyeR.Size = UDim2.new(0, 10, 0, 10)
eyeR.Position = UDim2.new(0, 60, 0, 25)
eyeR.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
eyeR.BorderSizePixel = 0
eyeR.Parent = face
local eyeRCorner = Instance.new("UICorner")
eyeRCorner.CornerRadius = UDim.new(1, 0)
eyeRCorner.Parent = eyeR

local mouthClip = Instance.new("Frame")
mouthClip.BackgroundTransparency = 1
mouthClip.BorderSizePixel = 0
mouthClip.ClipsDescendants = true
mouthClip.Parent = face

local mouthArc = Instance.new("Frame")
mouthArc.BackgroundTransparency = 1
mouthArc.BorderSizePixel = 0
mouthArc.Parent = mouthClip
local mouthCorner = Instance.new("UICorner")
mouthCorner.CornerRadius = UDim.new(1, 0)
mouthCorner.Parent = mouthArc
local mouthStroke = Instance.new("UIStroke")
mouthStroke.Color = Color3.fromRGB(10, 10, 10)
mouthStroke.Thickness = 5
mouthStroke.Parent = mouthArc

local function setSmile(mode)
    if mode == "happy" then
        mouthClip.Size = UDim2.new(0, 50, 0, 26)
        mouthClip.Position = UDim2.new(0, 20, 0, 52)
        mouthArc.Size = UDim2.new(0, 50, 0, 50)
        mouthArc.Position = UDim2.new(0, 0, 0, -24)
    elseif mode == "sad" then
        mouthClip.Size = UDim2.new(0, 50, 0, 26)
        mouthClip.Position = UDim2.new(0, 20, 0, 58)
        mouthArc.Size = UDim2.new(0, 50, 0, 50)
        mouthArc.Position = UDim2.new(0, 0, 0, 0)
    else
        mouthClip.Size = UDim2.new(0, 50, 0, 5)
        mouthClip.Position = UDim2.new(0, 20, 0, 60)
        mouthArc.Size = UDim2.new(0, 50, 0, 50)
        mouthArc.Position = UDim2.new(0, 0, 0, -22)
    end
end

setSmile("neutral")

local hwidLbl = Instance.new("TextLabel")
hwidLbl.Size = UDim2.new(1, -20, 0, 14)
hwidLbl.Position = UDim2.new(0, 10, 0, 148)
hwidLbl.BackgroundTransparency = 1
hwidLbl.Text = "HWID: " .. HWID
hwidLbl.TextColor3 = Color3.fromRGB(50, 50, 50)
hwidLbl.TextSize = 9
hwidLbl.Font = Enum.Font.Code
hwidLbl.TextXAlignment = Enum.TextXAlignment.Left
hwidLbl.TextTruncate = Enum.TextTruncate.AtEnd
hwidLbl.Parent = main

local inputBox = Instance.new("TextBox")
inputBox.Size = UDim2.new(0, 360, 0, 44)
inputBox.Position = UDim2.new(0, 20, 0, 168)
inputBox.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.PlaceholderColor3 = Color3.fromRGB(80, 80, 80)
inputBox.PlaceholderText = "Введите ключ доступа..."
inputBox.TextSize = 13
inputBox.Font = Enum.Font.Code
inputBox.ClearTextOnFocus = false
inputBox.Text = ""
inputBox.Parent = main
local inputCorner = Instance.new("UICorner")
inputCorner.CornerRadius = UDim.new(0, 5)
inputCorner.Parent = inputBox
local inputStroke = Instance.new("UIStroke")
inputStroke.Color = Color3.fromRGB(50, 50, 50)
inputStroke.Thickness = 1
inputStroke.Parent = inputBox
local inputPad = Instance.new("UIPadding")
inputPad.PaddingLeft = UDim.new(0, 12)
inputPad.Parent = inputBox

local enterBtn = Instance.new("TextButton")
enterBtn.Size = UDim2.new(0, 172, 0, 40)
enterBtn.Position = UDim2.new(0, 20, 0, 224)
enterBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
enterBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
enterBtn.Text = "ENTER"
enterBtn.TextSize = 13
enterBtn.Font = Enum.Font.Code
enterBtn.AutoButtonColor = false
enterBtn.Parent = main
local enterCorner = Instance.new("UICorner")
enterCorner.CornerRadius = UDim.new(0, 5)
enterCorner.Parent = enterBtn

local clearBtn = Instance.new("TextButton")
clearBtn.Size = UDim2.new(0, 172, 0, 40)
clearBtn.Position = UDim2.new(0, 208, 0, 224)
clearBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
clearBtn.TextColor3 = Color3.fromRGB(180, 180, 180)
clearBtn.Text = "CLEAR"
clearBtn.TextSize = 13
clearBtn.Font = Enum.Font.Code
clearBtn.AutoButtonColor = false
clearBtn.Parent = main
local clearCorner = Instance.new("UICorner")
clearCorner.CornerRadius = UDim.new(0, 5)
clearCorner.Parent = clearBtn
local clearStroke = Instance.new("UIStroke")
clearStroke.Color = Color3.fromRGB(55, 55, 55)
clearStroke.Thickness = 1
clearStroke.Parent = clearBtn

local statusLbl = Instance.new("TextLabel")
statusLbl.Size = UDim2.new(1, -20, 0, 24)
statusLbl.Position = UDim2.new(0, 10, 0, 278)
statusLbl.BackgroundTransparency = 1
statusLbl.Text = ""
statusLbl.TextColor3 = Color3.fromRGB(220, 220, 220)
statusLbl.TextSize = 12
statusLbl.Font = Enum.Font.Code
statusLbl.TextXAlignment = Enum.TextXAlignment.Center
statusLbl.Parent = main

local subLbl = Instance.new("TextLabel")
subLbl.Size = UDim2.new(1, -20, 0, 18)
subLbl.Position = UDim2.new(0, 10, 0, 302)
subLbl.BackgroundTransparency = 1
subLbl.Text = ""
subLbl.TextColor3 = Color3.fromRGB(80, 80, 80)
subLbl.TextSize = 10
subLbl.Font = Enum.Font.Code
subLbl.TextXAlignment = Enum.TextXAlignment.Center
subLbl.Parent = main

local function setStatus(t, c)
    statusLbl.Text = t
    statusLbl.TextColor3 = c or Color3.fromRGB(220, 220, 220)
end

local function setSub(t, c)
    subLbl.Text = t
    subLbl.TextColor3 = c or Color3.fromRGB(80, 80, 80)
end

enterBtn.MouseEnter:Connect(function()
    enterBtn.BackgroundColor3 = Color3.fromRGB(30, 140, 255)
end)
enterBtn.MouseLeave:Connect(function()
    enterBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
end)
clearBtn.MouseEnter:Connect(function()
    clearBtn.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
end)
clearBtn.MouseLeave:Connect(function()
    clearBtn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
end)

local dragging = false
local dragStart = nil
local dragPos = nil

topbar.InputBegan:Connect(function(inp)
    if inp.UserInputType == Enum.UserInputType.MouseButton1 or inp.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = inp.Position
        dragPos = main.Position
        inp.Changed:Connect(function()
            if inp.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
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
    enterBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    setSmile("neutral")
    setStatus("> Проверка ключа...", Color3.fromRGB(200, 200, 200))
    setSub("Подождите")

    local res = httpPost(API_CHECK, { key = key, hwid = HWID })

    if not res then
        setSmile("sad")
        setStatus("> Ошибка соединения", Color3.fromRGB(255, 80, 80))
        setSub("Проверьте подключение к серверу")
        enterBtn.Text = "ENTER"
        enterBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        busy = false
        return
    end

    if res.StatusCode ~= 200 then
        setSmile("sad")
        setStatus("> Ошибка сервера: " .. tostring(res.StatusCode), Color3.fromRGB(255, 80, 80))
        setSub("")
        enterBtn.Text = "ENTER"
        enterBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        busy = false
        return
    end

    local ok, data = pcall(function()
        return HttpService:JSONDecode(res.Body)
    end)

    if not ok or not data then
        setSmile("sad")
        setStatus("> Ошибка ответа сервера", Color3.fromRGB(255, 80, 80))
        setSub("")
        enterBtn.Text = "ENTER"
        enterBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
        busy = false
        return
    end

    local s = data.status

    if s == "success" then
        setStatus("> Привязка устройства...", Color3.fromRGB(255, 200, 0))
        setSub("HWID: " .. HWID)

        local bRes = httpPost(API_BIND, { key = key, hwid = HWID })

        if not bRes or bRes.StatusCode ~= 200 then
            setSmile("sad")
            setStatus("> Ошибка привязки", Color3.fromRGB(255, 80, 80))
            setSub("")
            enterBtn.Text = "ENTER"
            enterBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
            busy = false
            return
        end

        local ok2, bd = pcall(function()
            return HttpService:JSONDecode(bRes.Body)
        end)

        if ok2 and bd and bd.status == "bound" then
            setSmile("happy")
            setStatus("> Успешно! Устройство привязано", Color3.fromRGB(80, 255, 120))
            setSub("Загрузка SmileHub...")
            task.wait(1.5)
            sg:Destroy()
        else
            setSmile("sad")
            setStatus("> Ошибка при привязке", Color3.fromRGB(255, 80, 80))
            setSub("")
        end

    elseif s == "bound_to_you" then
        setSmile("happy")
        setStatus("> Устройство подтверждено!", Color3.fromRGB(80, 255, 120))
        setSub("Загрузка SmileHub...")
        task.wait(1.5)
        sg:Destroy()

    elseif s == "bound_to_other" then
        setSmile("sad")
        setStatus("> Ключ занят другим устройством", Color3.fromRGB(255, 80, 80))
        setSub("Каждый ключ работает только на 1 устройстве")

    elseif s == "expired" then
        setSmile("sad")
        setStatus("> Ключ просрочен", Color3.fromRGB(255, 160, 0))
        setSub("Получите новый ключ")

    else
        setSmile("sad")
        setStatus("> Неверный ключ", Color3.fromRGB(255, 80, 80))
        setSub("Проверьте ключ и попробуйте снова")
    end

    enterBtn.Text = "ENTER"
    enterBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 255)
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
        setStatus("> Введите ключ", Color3.fromRGB(255, 160, 0))
        setSub("")
        return
    end
    task.spawn(checkKey, key)
end)
