local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")


local API_URL = "https://keybot-rfgspl.mia0.amvera.tech/api/check"



local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "KeySystemGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 200)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -100)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(1, 0, 0, 40)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "MM2 Key System"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextSize = 18
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.Parent = MainFrame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0.85, 0, 0, 40)
TextBox.Position = UDim2.new(0.075, 0, 0, 55)
TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.PlaceholderText = "Введите ключ..."
TextBox.TextSize = 14
TextBox.Font = Enum.Font.Gotham
TextBox.ClearTextOnFocus = false
TextBox.Parent = MainFrame

local TextBoxCorner = Instance.new("UICorner")
TextBoxCorner.CornerRadius = UDim.new(0, 6)
TextBoxCorner.Parent = TextBox

local EnterButton = Instance.new("TextButton")
EnterButton.Size = UDim2.new(0.4, 0, 0, 35)
EnterButton.Position = UDim2.new(0.075, 0, 0, 115)
EnterButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
EnterButton.TextColor3 = Color3.fromRGB(255, 255, 255)
EnterButton.Text = "Enter"
EnterButton.TextSize = 14
EnterButton.Font = Enum.Font.GothamBold
EnterButton.Parent = MainFrame

local EnterCorner = Instance.new("UICorner")
EnterCorner.CornerRadius = UDim.new(0, 6)
EnterCorner.Parent = EnterButton

local ClearButton = Instance.new("TextButton")
ClearButton.Size = UDim2.new(0.4, 0, 0, 35)
ClearButton.Position = UDim2.new(0.525, 0, 0, 115)
ClearButton.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
ClearButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ClearButton.Text = "Clear"
ClearButton.TextSize = 14
ClearButton.Font = Enum.Font.GothamBold
ClearButton.Parent = MainFrame

local ClearCorner = Instance.new("UICorner")
ClearCorner.CornerRadius = UDim.new(0, 6)
ClearCorner.Parent = ClearButton

local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 25)
StatusLabel.Position = UDim2.new(0, 0, 0, 165)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
StatusLabel.TextSize = 14
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.Parent = MainFrame


local function checkKey(keyValue)
	local requestFunc = syn and syn.request or http_request or request
	if not requestFunc then
		StatusLabel.Text = "Ошибка: Эксплойт не поддерживает HTTP запросы"
		return
	end

	local success, response = pcall(function()
		return requestFunc({
			Url = API_URL,
			Method = "POST",
			Headers = {
				["Content-Type"] = "application/json"
			},
			Body = HttpService:JSONEncode({
				key = keyValue
			})
		})
	end)

	if success and response and response.StatusCode == 200 then
		local data = HttpService:JSONDecode(response.Body)
		if data.status == "success" then
			StatusLabel.Text = "Successfully!"
			task.wait(1)
			
			
			ScreenGui:Destroy()
			
			
			print("Ключ успешно активирован. Загрузка скрипта...")
		elseif data.status == "expired" then
			StatusLabel.Text = "Ключ просрочен"
		else
			StatusLabel.Text = "Неверный ключ"
		end
	else
		StatusLabel.Text = "Ошибка соединения с сервером"
	end
end


ClearButton.MouseButton1Click:Connect(function()
	TextBox.Text = ""
	StatusLabel.Text = ""
end)

EnterButton.MouseButton1Click:Connect(function()
	local key = TextBox.Text
	if key == "" then
		StatusLabel.Text = "Введите ключ"
		return
	end
	StatusLabel.Text = "Проверка..."
	task.spawn(function()
		checkKey(key)
	end)
end)
