local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
   Name = "Script Dumper Panel",
   LoadingTitle = "Инициализация панели...",
   LoadingSubtitle = "by custom utility",
   ConfigurationSaving = { Enabled = false },
   KeySystem = false
})

local Tab = Window:CreateTab("Перехватчик", "terminal")

local capturedCode = "Код еще не перехвачен..."

-- Элемент для отображения статуса / краткого текста
local StatusLabel = Tab:CreateParagraph({
   Title = "Статус", 
   Content = "Ожидание загрузки скрипта..."
})

-- Функция перехвата 
local oldLoadstring
oldLoadstring = hookfunction(loadstring, function(code, chunkname)
    if code then
        -- Пытаемся декомпилировать, если инжектор поддерживает, или сохраняем сам блок
        local success, result = pcall(function()
            -- Если функция decompile доступна в среде инжектора:
            if decompile then
                -- Превращаем полученную функцию в декомпилированный текст
                local fn, err = oldLoadstring(code, chunkname)
                if fn then return decompile(fn) end
            end
            return code -- Возвращаем исходный кусок, если декомпилятора нет
        end)
        
        if success then
            capturedCode = tostring(result)
            StatusLabel:Set({
                Title = "Успех!",
                Content = "Скрипт перехвачен. Нажмите кнопку копирования ниже."
            })
        end
    end
    return oldLoadstring(code, chunkname)
end)

Tab:CreateButton({
   Name = "Копировать расшифрованный/перехваченный код",
   Callback = function()
      setclipboard(capturedCode)
      Rayfield:Notify({
         Title = "Буфер обмена",
         Content = "Код успешно скопирован!",
         Duration = 4,
         Image = 4483362458,
      })
   end,
})
