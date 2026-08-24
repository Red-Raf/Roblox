-- ============================================================
-- Umbra Deobfuscator v6.0 — Mobile UI + Stealth
-- Всё в одном скрипте, без файлов
-- Обход детекта, копирование в буфер
-- ============================================================

-- ===== 1. СКРЫТАЯ ЗАГРУЗКА (ОБХОД ДЕТЕКТА) =====
local oldLoadstring = loadstring
local oldHttpGet = game.HttpGet
local oldHttpGetAsync = game.HttpGetAsync

-- Маскируемся под системный скрипт
local function stealthMode()
    -- Скрываем наш скрипт от других
    if script then
        local mt = getmetatable(script) or {}
        mt.__index = function(t, k)
            if k == "Source" then return "" end
            if k == "Name" then return "System" end
            return nil
        end
        setmetatable(script, mt)
        script.Name = "System"
        script.Enabled = true
    end
    
    -- Маскируем debug
    if debug then
        debug.getinfo = function() return nil end
        debug.getregistry = function() return {} end
    end
    
    -- Перехватываем error("Tamper")
    _G.error = function(msg, lvl)
        if msg and type(msg) == "string" and msg:find("Tamper") then
            return
        end
        return oldError(msg, lvl)
    end
end

-- Запускаем скрытый режим
stealthMode()

-- ===== 2. ЗАГРУЗКА RAYFIELD (МОБИЛЬНАЯ ВЕРСИЯ) =====
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()

if not Rayfield then
    warn("[!] Ошибка загрузки Rayfield")
    return
end

print("[✓] Umbra Deobfuscator v6.0 загружен!")

-- ===== 3. СОЗДАНИЕ UI =====
local Window = Rayfield:CreateWindow({
    Name = "Umbra Deobfuscator",
    Icon = 0,
    LoadingTitle = "Umbra",
    LoadingSubtitle = "Stealth Deobfuscator",
    ConfigurationSaving = { Enabled = false }
})

local MainTab = Window:CreateTab("Главная", 0)
local CodeTab = Window:CreateTab("Код", 0)
local ConsoleTab = Window:CreateTab("Консоль", 0)

-- ===== 4. ПЕРЕМЕННЫЕ =====
local capturedScripts = {}
local scriptCounter = 0
local statusMessages = {}
local isCapturing = true
local currentDeobfuscated = ""
local selectedScript = nil

-- ===== 5. СИСТЕМА СТАТУСА =====
local function fireStatus(msg)
    table.insert(statusMessages, 1, msg)
    if #statusMessages > 50 then
        table.remove(statusMessages)
    end
    print("[Umbra] " .. msg)
end

-- ===== 6. ДЕКОДЕР MOONVEIL =====
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

-- ===== 7. ДЕОБФУСКАЦИЯ =====
local function deobfuscateScript(code)
    if not code or code == "" then
        return nil, "Код пуст"
    end
    
    fireStatus("[*] Начало деобфускации...")
    
    local result = code
    
    -- 1. Удаляем анти-дамп
    result = result:gsub('error%s*%(%-?"[Tt]amper[^)]*%)', '-- anti-dump removed')
    result = result:gsub('local function r3%(%.%.%.)%s*error%(%-?"Tamper[^)]*%)%s*return%s*end', '-- anti-dump removed')
    result = result:gsub('r3%(%)', '-- r3() disabled')
    result = result:gsub('while true do%s*l1 = l2;%s*l2 = l1;%s*r3%(%);%s*end', '-- loop removed')
    result = result:gsub('if r1 then', 'if true then')
    result = result:gsub('error%s*%(', 'print(')
    
    -- 2. Извлекаем строки
    local strings = {}
    for str in result:gmatch('"([^"\\]*)"') do
        if #str > 2 then
            local dec = decodeMoonVeilString(str)
            if dec and dec ~= "" then
                table.insert(strings, dec)
            end
        end
    end
    
    -- 3. Форматируем
    result = result:gsub('([tT]hen)%s+', '%1\n    ')
    result = result:gsub('([dD]o)%s+', '%1\n    ')
    result = result:gsub('([eE]lse)%s+', '%1\n    ')
    result = result:gsub('%s+', ' ')
    result = result:gsub(';', ';\n')
    
    -- 4. Собираем финальный результат
    local final = "-- ============================================================\n"
    final = final .. "-- Umbra Deobfuscator v6.0 — Декодированный скрипт\n"
    final = final .. "-- Дата: " .. os.date("%Y-%m-%d %H:%M:%S") .. "\n"
    final = final .. "-- Найдено строк: " .. #strings .. "\n"
    final = final .. "-- ============================================================\n\n"
    
    if #strings > 0 then
        final = final .. "-- === НАЙДЕННЫЕ СТРОКИ ===\n"
        for i, dec in ipairs(strings) do
            if #dec < 200 then
                final = final .. "-- " .. dec .. "\n"
            end
        end
        final = final .. "\n"
    end
    
    final = final .. "-- === ОСНОВНОЙ КОД ===\n"
    final = final .. result
    
    fireStatus("[✓] Деобфускация завершена! Найдено строк: " .. #strings)
    return final, #strings
end

-- ===== 8. ЗАГРУЗКА СКРИПТА =====
local function loadAndDeobfuscate(url)
    fireStatus("[*] Загрузка скрипта: " .. url)
    
    local success, code = pcall(function()
        return game:HttpGet(url)
    end)
    
    if not success then
        fireStatus("[!] Ошибка загрузки: " .. tostring(code))
        return nil
    end
    
    if not code or code == "" then
        fireStatus("[!] Скрипт пустой")
        return nil
    end
    
    fireStatus("[✓] Загружено: " .. #code .. " символов")
    
    local deobfuscated, count = deobfuscateScript(code)
    if deobfuscated then
        scriptCounter = scriptCounter + 1
        capturedScripts[scriptCounter] = {
            source = deobfuscated,
            name = "Deobfuscated_" .. scriptCounter,
            time = os.date("%H:%M:%S"),
            size = #deobfuscated,
            strings = count
        }
        currentDeobfuscated = deobfuscated
        fireStatus("[✓] Скрипт деобфусцирован! Размер: " .. #deobfuscated .. " символов")
        return deobfuscated
    end
    
    return nil
end

-- ===== 9. UI ЭЛЕМЕНТЫ =====

-- === Главная ===
MainTab:CreateParagraph({
    Title = "Umbra Deobfuscator v6.0",
    Content = "Stealth деобфускатор для MoonVeil\nС обходом детекта"
})

local statusLabel = MainTab:CreateLabel("Статус: ✅ Готов")
local countLabel = MainTab:CreateLabel("Скриптов: 0")

MainTab:CreateInput({
    Name = "Ссылка на скрипт",
    PlaceholderText = "https://raw.githubusercontent.com/...",
    RemoveTextWhileFocus = false,
    Callback = function(Text)
        -- Сохраняем для кнопки
    end
})

MainTab:CreateButton({
    Name = "🚀 Загрузить и деобфусцировать",
    Callback = function()
        local inputBox = MainTab:GetInput("Ссылка на скрипт")
        local url = inputBox and inputBox:GetText() or ""
        
        if url == "" then
            fireStatus("[!] Введите ссылку на скрипт")
            statusLabel:Set("Статус: ❌ Нет ссылки")
            return
        end
        
        statusLabel:Set("Статус: ⏳ Загрузка...")
        local result = loadAndDeobfuscate(url)
        
        if result then
            statusLabel:Set("Статус: ✅ Деобфусцирован!")
            countLabel:Set("Скриптов: " .. scriptCounter)
            -- Обновляем вкладку с кодом
            updateCodeDisplay()
        else
            statusLabel:Set("Статус: ❌ Ошибка")
        end
    end
})

MainTab:CreateButton({
    Name = "🔄 Деобфусцировать из буфера",
    Callback = function()
        statusLabel:Set("Статус: ⏳ Обработка...")
        
        local clipboard = ""
        if setclipboard then
            -- Получаем из буфера (если поддерживается)
            clipboard = getclipboard and getclipboard() or ""
        end
        
        if clipboard == "" then
            fireStatus("[!] Буфер обмена пуст или недоступен")
            statusLabel:Set("Статус: ❌ Нет данных")
            return
        end
        
        local deobfuscated, count = deobfuscateScript(clipboard)
        if deobfuscated then
            scriptCounter = scriptCounter + 1
            capturedScripts[scriptCounter] = {
                source = deobfuscated,
                name = "FromClipboard_" .. scriptCounter,
                time = os.date("%H:%M:%S"),
                size = #deobfuscated,
                strings = count
            }
            currentDeobfuscated = deobfuscated
            statusLabel:Set("Статус: ✅ Деобфусцирован!")
            countLabel:Set("Скриптов: " .. scriptCounter)
            fireStatus("[✓] Деобфусцировано из буфера! Строк: " .. count)
            updateCodeDisplay()
        else
            statusLabel:Set("Статус: ❌ Ошибка")
        end
    end
})

MainTab:CreateDivider()

MainTab:CreateToggle({
    Name = "🛡️ Скрытый режим (Stealth)",
    CurrentValue = true,
    Callback = function(Value)
        if Value then
            stealthMode()
            fireStatus("[*] Скрытый режим активирован")
            statusLabel:Set("Статус: 🛡️ Stealth режим")
        else
            fireStatus("[!] Скрытый режим выключен (риск детекта)")
            statusLabel:Set("Статус: ⚠️ Stealth выключен")
        end
    end
})

MainTab:CreateDivider()

MainTab:CreateParagraph({
    Title = "Обход защиты",
    Content = "• Маскировка debug\n• Перехват error(\"Tamper\")\n• Скрытие имени скрипта\n• Игнорирование анти-дампа"
})

-- === Консоль ===
local consoleLabel = ConsoleTab:CreateLabel("Консоль:\nОжидание...")

local function updateConsole()
    local text = ""
    for i, msg in ipairs(statusMessages) do
        if i <= 30 then
            text = text .. msg .. "\n"
        end
    end
    if text == "" then
        text = "Ожидание...\n"
    end
    pcall(function()
        consoleLabel:Set("Консоль:\n" .. text)
    end)
end

-- Обновление консоли
game:GetService("RunService").Heartbeat:Connect(function()
    updateConsole()
end)

ConsoleTab:CreateButton({
    Name = "🗑️ Очистить консоль",
    Callback = function()
        statusMessages = {}
        updateConsole()
        fireStatus("[*] Консоль очищена")
    end
})

-- === Код ===
local codeDisplay = CodeTab:CreateLabel("Нет деобфусцированного кода")

local function updateCodeDisplay()
    if currentDeobfuscated and currentDeobfuscated ~= "" then
        local display = currentDeobfuscated
        if #display > 3000 then
            display = display:sub(1, 3000) .. "\n\n... (полный код скопирован в буфер)"
        end
        codeDisplay:Set(display)
    else
        codeDisplay:Set("Нет деобфусцированного кода")
    end
end

CodeTab:CreateButton({
    Name = "📋 Копировать полный код",
    Callback = function()
        if currentDeobfuscated and currentDeobfuscated ~= "" then
            if setclipboard then
                setclipboard(currentDeobfuscated)
                fireStatus("[✓] Код скопирован в буфер обмена!")
            elseif toclipboard then
                toclipboard(currentDeobfuscated)
                fireStatus("[✓] Код скопирован в буфер обмена!")
            else
                fireStatus("[!] Копирование недоступно")
            end
        else
            fireStatus("[!] Нет кода для копирования")
        end
    end
})

CodeTab:CreateButton({
    Name = "📦 Копировать все скрипты",
    Callback = function()
        if scriptCounter == 0 then
            fireStatus("[!] Нет скриптов")
            return
        end
        
        local all = "-- Umbra Dump — Всего скриптов: " .. scriptCounter .. "\n\n"
        for i = 1, scriptCounter do
            local script = capturedScripts[i]
            if script then
                all = all .. "===== " .. script.name .. " =====\n"
                all = all .. "-- Время: " .. script.time .. "\n"
                all = all .. "-- Размер: " .. script.size .. " символов\n"
                all = all .. "-- Строк: " .. (script.strings or 0) .. "\n\n"
                all = all .. script.source .. "\n\n"
            end
        end
        
        if setclipboard then
            setclipboard(all)
            fireStatus("[✓] Все скрипты скопированы! (" .. scriptCounter .. " шт.)")
        elseif toclipboard then
            toclipboard(all)
            fireStatus("[✓] Все скрипты скопированы! (" .. scriptCounter .. " шт.)")
        else
            fireStatus("[!] Копирование недоступно")
        end
    end
})

CodeTab:CreateButton({
    Name = "🔄 Обновить отображение",
    Callback = function()
        updateCodeDisplay()
        fireStatus("[*] Отображение обновлено")
    end
})

CodeTab:CreateButton({
    Name = "🗑️ Очистить все скрипты",
    Callback = function()
        capturedScripts = {}
        scriptCounter = 0
        currentDeobfuscated = ""
        updateCodeDisplay()
        countLabel:Set("Скриптов: 0")
        fireStatus("[*] Все скрипты удалены")
    end
})

-- ===== 10. ПЕРВИЧНЫЙ ЗАПУСК =====
fireStatus("[*] Umbra Deobfuscator v6.0 активирован")
fireStatus("[*] Обход детекта включён")
fireStatus("[*] Вставьте ссылку на скрипт и нажмите 'Загрузить'")
statusLabel:Set("Статус: ✅ Готов к работе")
countLabel:Set("Скриптов: 0")

updateConsole()
updateCodeDisplay()

-- ===== 11. СКРЫТИЕ ОТ ДЕТЕКТА =====
local function finalStealth()
    -- Удаляем следы из глобальной таблицы
    local hiddenVars = {
        "oldLoadstring", "oldHttpGet", "oldHttpGetAsync",
        "Rayfield", "Window", "MainTab", "CodeTab", "ConsoleTab"
    }
    for _, var in ipairs(hiddenVars) do
        if _G[var] then
            _G[var] = nil
        end
    end
end

task.wait(0.5)
finalStealth()

print([[
╔═══════════════════════════════════════╗
║   Umbra Deobfuscator v6.0            ║
║   Mobile — Stealth Mode              ║
║   Обход детекта активен              ║
╚═══════════════════════════════════════╝
]])

-- ===== 12. ВОЗВРАТ =====
return {
    status = fireStatus,
    deobfuscate = deobfuscateScript,
    getScripts = function() return capturedScripts end,
    getCount = function() return scriptCounter end
}
