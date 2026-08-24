-- ============================================================
-- Umbra Deobfuscator v9.0 — Native GUI
-- Работает без Rayfield, только CoreGui
-- ============================================================

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "UmbraDeobfuscator"
screenGui.ResetOnSpawn = false
screenGui.Parent = game:GetService("CoreGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 420, 0, 520)
frame.Position = UDim2.new(0.5, -210, 0.5, -260)
frame.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
frame.BorderSizePixel = 0
frame.Parent = screenGui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0, 45)
title.BackgroundTransparency = 1
title.Text = "🐉 Umbra Deobfuscator v9.0"
title.TextColor3 = Color3.fromRGB(220, 220, 230)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.Parent = frame

local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -38, 0, 8)
closeBtn.BackgroundColor3 = Color3.fromRGB(180, 40, 40)
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
closeBtn.Font = Enum.Font.GothamBold
closeBtn.TextSize = 16
closeBtn.Parent = frame
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(0, 6)
closeBtn.MouseButton1Click:Connect(function() screenGui:Destroy() end)

local function createTextBox(placeholder, y, height, parent)
    local box = Instance.new("TextBox")
    box.Size = UDim2.new(0.9, 0, 0, height or 35)
    box.Position = UDim2.new(0.05, 0, 0, y)
    box.BackgroundColor3 = Color3.fromRGB(30, 30, 36)
    box.TextColor3 = Color3.fromRGB(220, 220, 230)
    box.PlaceholderText = placeholder or ""
    box.PlaceholderColor3 = Color3.fromRGB(120, 120, 130)
    box.Font = Enum.Font.Gotham
    box.TextSize = 13
    box.ClearTextOnFocus = false
    box.Parent = parent
    Instance.new("UICorner", box).CornerRadius = UDim.new(0, 6)
    return box
end

local function createButton(text, y, color, parent, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0.42, 0, 0, 35)
    btn.Position = UDim2.new(0.05 + (text:find("Очистить") and 0.53 or 0), 0, 0, y)
    btn.BackgroundColor3 = color or Color3.fromRGB(50, 140, 50)
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 14
    btn.Parent = parent
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)
    btn.MouseButton1Click:Connect(callback or function() end)
    return btn
end

local inputBox = createTextBox("Вставьте ссылку на скрипт...", 55, 35, frame)

local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0.9, 0, 0, 25)
statusLabel.Position = UDim2.new(0.05, 0, 0, 100)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = "✅ Готов"
statusLabel.TextColor3 = Color3.fromRGB(120, 200, 120)
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 13
statusLabel.TextXAlignment = Enum.TextXAlignment.Left
statusLabel.Parent = frame

local outputBox = Instance.new("TextBox")
outputBox.Size = UDim2.new(0.9, 0, 0, 280)
outputBox.Position = UDim2.new(0.05, 0, 0, 185)
outputBox.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
outputBox.TextColor3 = Color3.fromRGB(190, 190, 200)
outputBox.Text = ""
outputBox.Font = Enum.Font.Gotham
outputBox.TextSize = 12
outputBox.TextWrapped = true
outputBox.TextXAlignment = Enum.TextXAlignment.Left
outputBox.TextYAlignment = Enum.TextYAlignment.Top
outputBox.ClearTextOnFocus = false
outputBox.MultiLine = true
outputBox.Parent = frame
Instance.new("UICorner", outputBox).CornerRadius = UDim.new(0, 6)

local function log(msg)
    local time = os.date("%H:%M:%S")
    outputBox.Text = time .. " " .. msg .. "\n" .. outputBox.Text
    if #outputBox.Text > 5000 then
        outputBox.Text = outputBox.Text:sub(1, 4000)
    end
end

local function decodeMoonVeilString(encoded)
    if not encoded or encoded == "" then return "" end
    local result = ""
    for i = 1, #encoded do
        local byte = string.byte(encoded, i)
        if byte >= 48 and byte <= 57 then
            result = result .. string.char(byte + 16)
        elseif byte >= 65 and byte <= 90 then
            result = result .. string.char(byte + 32)
        elseif byte >= 97 and byte <= 122 then
            result = result .. string.char(byte - 32)
        else
            result = result .. string.char(byte)
        end
    end
    return result
end

local function deobfuscateScript(code)
    if not code or code == "" then return nil end
    log("🔍 Начало деобфускации...")
    
    local result = code
    result = result:gsub('error%s*%(%-?"[Tt]amper[^)]*%)', '-- anti-dump removed')
    result = result:gsub('local function r3%(%.%.%.)%s*error%(%-?"Tamper[^)]*%)%s*return%s*end', '-- anti-dump removed')
    result = result:gsub('r3%(%)', '-- r3() disabled')
    result = result:gsub('while true do%s*l1 = l2;%s*l2 = l1;%s*r3%(%);%s*end', '-- loop removed')
    result = result:gsub('if r1 then', 'if true then')
    result = result:gsub('error%s*%(', 'print(')
    
    local strings = {}
    for str in result:gmatch('"([^"\\]*)"') do
        if #str > 2 then
            local dec = decodeMoonVeilString(str)
            if dec and dec ~= "" then table.insert(strings, dec) end
        end
    end
    
    result = result:gsub('([tT]hen)%s+', '%1\n    ')
    result = result:gsub('([dD]o)%s+', '%1\n    ')
    result = result:gsub('([eE]lse)%s+', '%1\n    ')
    result = result:gsub('%s+', ' ')
    result = result:gsub(';', ';\n')
    
    local final = "-- Umbra Deobfuscator v9.0\n"
    final = final .. "-- Дата: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
    final = final .. "-- Найдено строк: " .. #strings .. "\n\n"
    if #strings > 0 then
        for i, dec in ipairs(strings) do
            if #dec < 200 then final = final .. "-- " .. dec .. "\n" end
        end
        final = final .. "\n"
    end
    final = final .. result
    
    log("✅ Деобфускация завершена! Строк: " .. #strings)
    return final
end

local function loadAndDeobfuscate(url)
    log("📥 Загрузка: " .. url)
    local success, code = pcall(function() return game:HttpGet(url) end)
    if not success then
        log("❌ Ошибка: " .. tostring(code))
        statusLabel.Text = "❌ Ошибка загрузки"
        return
    end
    if not code or code == "" then
        log("❌ Скрипт пустой")
        statusLabel.Text = "❌ Пустой скрипт"
        return
    end
    log("📦 Загружено: " .. #code .. " символов")
    local deobfuscated = deobfuscateScript(code)
    if deobfuscated then
        statusLabel.Text = "✅ Деобфусцирован!"
        log("📋 Размер: " .. #deobfuscated)
        if setclipboard then
            setclipboard(deobfuscated)
            log("📋 Код скопирован в буфер!")
        end
    else
        statusLabel.Text = "❌ Ошибка деобфускации"
    end
end

createButton("🚀 Загрузить", 135, Color3.fromRGB(50, 150, 50), frame, function()
    local url = inputBox.Text
    if url == "" then
        log("⚠️ Введите ссылку")
        statusLabel.Text = "❌ Нет ссылки"
        return
    end
    statusLabel.Text = "⏳ Загрузка..."
    loadAndDeobfuscate(url)
end)

createButton("🗑️ Очистить", 135, Color3.fromRGB(150, 40, 40), frame, function()
    outputBox.Text = ""
    statusLabel.Text = "✅ Готов"
    log("🗑️ Консоль очищена")
end)

local copyBtn = createButton("📋 Копировать", 135, Color3.fromRGB(40, 100, 180), frame, function()
    if outputBox.Text ~= "" then
        if setclipboard then
            setclipboard(outputBox.Text)
            log("📋 Текст скопирован!")
        else
            log("⚠️ Копирование недоступно")
        end
    else
        log("⚠️ Нет текста для копирования")
    end
end)
copyBtn.Position = UDim2.new(0.53, 0, 0, 175)

local loadBtn = createButton("📥 Из буфера", 135, Color3.fromRGB(180, 140, 40), frame, function()
    local clipboard = ""
    if getclipboard then
        clipboard = getclipboard()
    end
    if clipboard == "" then
        log("⚠️ Буфер пуст")
        return
    end
    statusLabel.Text = "⏳ Обработка..."
    local deobfuscated = deobfuscateScript(clipboard)
    if deobfuscated then
        statusLabel.Text = "✅ Деобфусцирован!"
        log("📋 Размер: " .. #deobfuscated)
        if setclipboard then
            setclipboard(deobfuscated)
            log("📋 Код скопирован в буфер!")
        end
    else
        statusLabel.Text = "❌ Ошибка"
    end
end)
loadBtn.Position = UDim2.new(0.05, 0, 0, 175)

log("🐉 Umbra Deobfuscator v9.0 активирован")
log("💡 Вставьте ссылку и нажмите 'Загрузить'")
statusLabel.Text = "✅ Готов"

-- Возможность перетаскивания
local dragStart, dragStartPos
frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragStart = input.Position
        dragStartPos = frame.Position
    end
end)
frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement and dragStart then
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            dragStartPos.X.Scale,
            dragStartPos.X.Offset + delta.X,
            dragStartPos.Y.Scale,
            dragStartPos.Y.Offset + delta.Y
        )
    end
end)
frame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragStart = nil
    end
end)

print("🐉 Umbra Deobfuscator v9.0 загружен!")
