-- ============================================================
-- Umbra Deobfuscator v8.0 — Rayfield FIRST
-- Сначала UI, потом логика
-- ============================================================

-- ===== 1. ЗАГРУЖАЕМ RAYFIELD =====
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()

if not Rayfield then
    warn("[!] Rayfield не загружен")
    return
end

print("[✓] Rayfield загружен")

-- ===== 2. СОЗДАЁМ ОКНО =====
local Window = Rayfield:CreateWindow({
    Name = "Umbra Deobfuscator",
    LoadingTitle = "Umbra",
    LoadingSubtitle = "Stealth Deobfuscator",
    ConfigurationSaving = { Enabled = false }
})

print("[✓] Окно создано")

-- ===== 3. СОЗДАЁМ ВКЛАДКИ =====
local MainTab = Window:CreateTab("Главная")
local CodeTab = Window:CreateTab("Код")
local ConsoleTab = Window:CreateTab("Консоль")

print("[✓] Вкладки созданы")

-- ===== 4. ТЕСТОВЫЙ ЭЛЕМЕНТ (ПРОВЕРКА UI) =====
MainTab:CreateParagraph({
    Title = "Umbra Deobfuscator v8.0",
    Content = "Если вы видите это сообщение — UI работает!"
})

print("[✓] Тестовый элемент создан")

-- ===== 5. ТЕПЕРЬ ВСЯ ЛОГИКА =====

-- Переменные
local capturedScripts = {}
local scriptCounter = 0
local statusMessages = {}
local currentDeobfuscated = ""

-- Функция статуса
local function fireStatus(msg)
    table.insert(statusMessages, 1, os.date("%H:%M:%S") .. " " .. msg)
    if #statusMessages > 50 then
        table.remove(statusMessages)
    end
    print("[Umbra] " .. msg)
end

-- Декодер MoonVeil
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

-- Деобфускация
local function deobfuscateScript(code)
    if not code or code == "" then
        return nil, "Код пуст"
    end

    fireStatus("Начало деобфускации...")
    local result = code

    -- Удаляем анти-дамп
    result = result:gsub('error%s*%(%-?"[Tt]amper[^)]*%)', '-- anti-dump removed')
    result = result:gsub('local function r3%(%.%.%.)%s*error%(%-?"Tamper[^)]*%)%s*return%s*end', '-- anti-dump removed')
    result = result:gsub('r3%(%)', '-- r3() disabled')
    result = result:gsub('while true do%s*l1 = l2;%s*l2 = l1;%s*r3%(%);%s*end', '-- loop removed')
    result = result:gsub('if r1 then', 'if true then')
    result = result:gsub('error%s*%(', 'print(')

    -- Извлекаем строки
    local strings = {}
    for str in result:gmatch('"([^"\\]*)"') do
        if #str > 2 then
            local dec = decodeMoonVeilString(str)
            if dec and dec ~= "" then
                table.insert(strings, dec)
            end
        end
    end

    -- Форматируем
    result = result:gsub('([tT]hen)%s+', '%1\n    ')
    result = result:gsub('([dD]o)%s+', '%1\n    ')
    result = result:gsub('([eE]lse)%s+', '%1\n    ')
    result = result:gsub('%s+', ' ')
    result = result:gsub(';', ';\n')

    -- Собираем финальный результат
    local final = "-- ============================================================\n"
    final = final .. "-- Umbra Deobfuscator v8.0 — Декодированный скрипт\n"
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

    fireStatus("Деобфускация завершена! Строк: " .. #strings)
    return final, #strings
end

-- Загрузка скрипта
local function loadAndDeobfuscate(url)
    fireStatus("Загрузка: " .. url)

    local success, code = pcall(function()
        return game:HttpGet(url)
    end)

    if not success then
        fireStatus("Ошибка: " .. tostring(code))
        return nil
    end

    if not code or code == "" then
        fireStatus("Скрипт пустой")
        return nil
    end

    fireStatus("Загружено: " .. #code .. " символов")

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
        fireStatus("Деобфусцирован! Размер: " .. #deobfuscated)
        return deobfuscated
    end

    return nil
end

-- ===== 6. UI ЭЛЕМЕНТЫ (ПОСЛЕ ЛОГИКИ) =====

-- Статус
local statusLabel = MainTab:CreateLabel("Статус: ✅ Готов")
local countLabel = MainTab:CreateLabel("Скриптов: 0")

-- Поле ввода
local inputField = MainTab:CreateInput({
    Name = "Ссылка на скрипт",
    PlaceholderText = "https://raw.githubusercontent.com/...",
    RemoveTextWhileFocus = false,
    Callback = function(Text) end
})

-- Кнопка загрузки
MainTab:CreateButton({
    Name = "🚀 Загрузить и деобфусцировать",
    Callback = function()
        local url = inputField:GetText()
        if url == "" then
            fireStatus("Введите ссылку")
            statusLabel:Set("Статус: ❌ Нет ссылки")
            return
        end

        statusLabel:Set("Статус: ⏳ Загрузка...")
        local result = loadAndDeobfuscate(url)

        if result then
            statusLabel:Set("Статус: ✅ Деобфусцирован!")
            countLabel:Set("Скриптов: " .. scriptCounter)
            updateCodeDisplay()
        else
            statusLabel:Set("Статус: ❌ Ошибка")
        end
    end
})

-- Кнопка из буфера
MainTab:CreateButton({
    Name = "🔄 Деобфусцировать из буфера",
    Callback = function()
        statusLabel:Set("Статус: ⏳ Обработка...")
        
        local clipboard = ""
        if setclipboard then
            clipboard = getclipboard and getclipboard() or ""
        end
        
        if clipboard == "" then
            fireStatus("Буфер пуст")
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
            fireStatus("Из буфера! Строк: " .. count)
            updateCodeDisplay()
        else
            statusLabel:Set("Статус: ❌ Ошибка")
        end
    end
})

MainTab:CreateDivider()

MainTab:CreateParagraph({
    Title = "Обход защиты",
    Content = "• Маскировка debug\n• Перехват error(\"Tamper\")\n• Скрытие имени скрипта"
})

-- ===== 7. КОНСОЛЬ =====
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

-- Автообновление консоли
game:GetService("RunService").Heartbeat:Connect(function()
    updateConsole()
end)

ConsoleTab:CreateButton({
    Name = "🗑️ Очистить консоль",
    Callback = function()
        statusMessages = {}
        updateConsole()
        fireStatus("Консоль очищена")
    end
})

-- ===== 8. КОД =====
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
                fireStatus("Код скопирован!")
            elseif toclipboard then
                toclipboard(currentDeobfuscated)
                fireStatus("Код скопирован!")
            else
                fireStatus("Копирование недоступно")
            end
        else
            fireStatus("Нет кода")
        end
    end
})

CodeTab:CreateButton({
    Name = "📦 Копировать все скрипты",
    Callback = function()
        if scriptCounter == 0 then
            fireStatus("Нет скриптов")
            return
        end
        
        local all = "-- Umbra Dump — Всего: " .. scriptCounter .. "\n\n"
        for i = 1, scriptCounter do
            local script = capturedScripts[i]
            if script then
                all = all .. "===== " .. script.name .. " =====\n"
                all = all .. "-- Время: " .. script.time .. "\n"
                all = all .. "-- Размер: " .. script.size .. "\n"
                all = all .. "-- Строк: " .. (script.strings or 0) .. "\n\n"
                all = all .. script.source .. "\n\n"
            end
        end
        
        if setclipboard then
            setclipboard(all)
            fireStatus("Все скопированы! (" .. scriptCounter .. " шт.)")
        elseif toclipboard then
            toclipboard(all)
            fireStatus("Все скопированы! (" .. scriptCounter .. " шт.)")
        else
            fireStatus("Копирование недоступно")
        end
    end
})

CodeTab:CreateButton({
    Name = "🔄 Обновить",
    Callback = function()
        updateCodeDisplay()
        fireStatus("Обновлено")
    end
})

CodeTab:CreateButton({
    Name = "🗑️ Очистить всё",
    Callback = function()
        capturedScripts = {}
        scriptCounter = 0
        currentDeobfuscated = ""
        updateCodeDisplay()
        countLabel:Set("Скриптов: 0")
        fireStatus("Очищено")
    end
})

-- ===== 9. ЗАПУСК =====
fireStatus("Umbra Deobfuscator v8.0 активирован")
fireStatus("Вставьте ссылку и нажмите 'Загрузить'")
statusLabel:Set("Статус: ✅ Готов к работе")
countLabel:Set("Скриптов: 0")

updateConsole()
updateCodeDisplay()

print([[
╔═══════════════════════════════════════╗
║   Umbra Deobfuscator v8.0            ║
║          
╚═══════════════════════════════════════╝
]])
