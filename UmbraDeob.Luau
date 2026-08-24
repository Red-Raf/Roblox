-- Простейший тест Rayfield
local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source.lua"))()
if Rayfield then
    local Window = Rayfield:CreateWindow({
        Name = "Test",
        LoadingTitle = "Test",
        LoadingSubtitle = "Test",
        ConfigurationSaving = { Enabled = false }
    })
    local Tab = Window:CreateTab("Test")
    Tab:CreateLabel("UI works!")
    print("UI should be visible")
else
    warn("Rayfield failed")
end
