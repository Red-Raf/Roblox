--!strict
--[[
	ModernUI Executor Edition (Часть 1 из 2)
	Полная версия со всеми функциями и анимациями.
]]

local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

local Player = Players.LocalPlayer

-- Защита от дублирования: удаляем старый интерфейс, если он уже был запущен
if CoreGui:FindFirstChild("ModernUI_Executor") then
	CoreGui.ModernUI_Executor:Destroy()
end

local parentContainer = (gethui and gethui()) or CoreGui

--================================================================
-- ТЕМА
--================================================================
local Theme = {
	Background   = Color3.fromRGB(255, 255, 255),
	Sidebar      = Color3.fromRGB(248, 248, 248),
	ElementBg    = Color3.fromRGB(242, 242, 242),
	ElementBg2   = Color3.fromRGB(230, 230, 230),
	Accent       = Color3.fromRGB(255, 126, 20),
	Text         = Color3.fromRGB(28, 28, 28),
	SubText      = Color3.fromRGB(130, 130, 130),
	Stroke       = Color3.fromRGB(224, 224, 224),
}

local TWEEN_FAST = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local TWEEN_MED  = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

--================================================================
-- ВСПОМОГАТЕЛЬНОЕ
--================================================================
local function new(class: string, props: {[string]: any}, children: {Instance}?)
	local inst = Instance.new(class)
	for k, v in pairs(props) do
		(inst :: any)[k] = v
	end
	if children then
		for _, child in ipairs(children) do
			child.Parent = inst
		end
	end
	return inst
end

local function corner(radius: number)
	return new("UICorner", { CornerRadius = UDim.new(0, radius) })
end

local function stroke(color: Color3?, thickness: number?)
	return new("UIStroke", {
		Color = color or Theme.Stroke,
		Thickness = thickness or 1,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
	})
end

local BUILTIN = {
	LinkNote = {
		ru = "Игра не может открыть ссылку напрямую — выделите текст выше и скопируйте вручную",
		en = "The game can't open the link directly — select the text above and copy it manually.",
	},
	ErrorPrefix = {
		ru = "Ошибка: ",
		en = "Error: ",
	},
}

local function resolveText(template: any, lang: string): string
	if typeof(template) == "table" then
		return template[lang] or template.en or template.ru or ""
	end
	return tostring(template)
end

local function toLabel(template: any): string
	if typeof(template) == "table" then
		return tostring(template.ru or template.en or "callback")
	end
	return tostring(template)
end

local function bindText(self_: any, instance: Instance, template: any)
	if self_ and self_._i18n then
		table.insert(self_._i18n, { instance = instance, template = template })
	end
	(instance :: any).Text = resolveText(template, (self_ and self_.Language) or "ru")
end

--================================================================
-- АНИМАЦИИ И КОЛБЭКИ
--================================================================
local function cascadeIn(container: Instance, opts: any?)
	opts = opts or {}
	local stagger = opts.stagger or 0.05
	local slideOffset = opts.offset or 18
	local startDelay = opts.startDelay or 0.04

	local index = 0
	for _, child in ipairs(container:GetChildren()) do
		if child:IsA("GuiObject") then
			index += 1
			local itemDelay = startDelay + (index - 1) * stagger
			local originalPos = child.Position
			child.Position = originalPos + UDim2.new(0, 0, 0, slideOffset)

			task.delay(itemDelay, function()
				if not child.Parent then return end
				TweenService:Create(child, TWEEN_MED, { Position = originalPos }):Play()
			end)
		end
	end
end

local function wrapCallback(fn: (...any) -> ...any, opts: any?)
	opts = opts or {}
	local label = opts.label or "callback"
	local cooldown = opts.cooldown or 0
	local maxRetries = opts.retries or 0
	local retryDelay = opts.retryDelay or 0.3
	local busy = false
	local lastCall = 0

	return function(...)
		local now = os.clock()
		if busy then return end
		if cooldown > 0 and (now - lastCall) < cooldown then return end

		busy = true
		lastCall = now
		local args = { ... }
		local argCount = select("#", ...)

		task.spawn(function()
			local attempt = 0
			local ok, err

			repeat
				attempt += 1
				ok, err = pcall(fn, table.unpack(args, 1, argCount))
				if not ok and attempt <= maxRetries then
					task.wait(retryDelay)
				end
			until ok or attempt > maxRetries

			if not ok and opts.onError then
				pcall(opts.onError, tostring(err))
			end
			busy = false
		end)
	end
end

local function normalizeCallback(callback: any, label: string, self_: any)
	local function toastOnError(err: string)
		if self_ and self_._showErrorToast then
			local lang = self_.Language or "ru"
			self_:Notify(BUILTIN.ErrorPrefix[lang] .. err, 4)
		end
	end

	if typeof(callback) == "table" then
		local userOnError = callback.onError
		return wrapCallback(callback.fn or function() end, {
			label = label,
			cooldown = callback.cooldown,
			retries = callback.retries,
			retryDelay = callback.retryDelay,
			timeout = callback.timeout,
			silent = callback.silent,
			onError = function(err)
				if userOnError then pcall(userOnError, err) end
				toastOnError(err)
			end,
		})
	end

	return wrapCallback(callback or function() end, {
		label = label,
		onError = toastOnError,
	})
end

--================================================================
-- БИБЛИОТЕКА (ЧАСТЬ 1)
--================================================================
local ModernUI = {}
ModernUI.__index = ModernUI

function ModernUI.new(config: {
	Title: (string | {[string]: string})?,
	AvatarId: string?,
	Language: ("ru" | "en")?,
	ShowErrorsAsToast: boolean?,
	IncludeSettingsTab: boolean?,
})
	config = config or {}
	local initialLang = config.Language or "ru"

	local screenGui = new("ScreenGui", {
		Name = "ModernUI_Executor",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		IgnoreGuiInset = true,
		Parent = parentContainer,
	})

	local main = new("Frame", {
		Name = "Main",
		Size = UDim2.new(0.86, 0, 0.62, 0),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Theme.Background,
		Parent = screenGui,
	}, { corner(16), stroke(Theme.Stroke, 1) })

	local sidebar = new("Frame", {
		Name = "Sidebar",
		Size = UDim2.new(0, 74, 1, 0),
		BackgroundColor3 = Theme.Sidebar,
		Parent = main,
	}, { corner(16) })

	new("Frame", {
		Size = UDim2.new(0, 16, 1, 0),
		Position = UDim2.new(1, -16, 0, 0),
		BackgroundColor3 = Theme.Sidebar,
		BorderSizePixel = 0,
		Parent = sidebar,
	})

	local avatarHolder = new("Frame", {
		Size = UDim2.new(0, 52, 0, 52),
		Position = UDim2.new(0.5, 0, 0, 14),
		AnchorPoint = Vector2.new(0.5, 0),
		BackgroundColor3 = Theme.ElementBg,
		Parent = sidebar,
	}, { corner(26), stroke(Theme.Accent, 2) })

	local avatarImage = new("ImageLabel", {
		Size = UDim2.new(1, -4, 1, -4),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = config.AvatarId or "",
		ScaleType = Enum.ScaleType.Crop,
		Parent = avatarHolder,
	}, { corner(24) })

	local tabButtons = new("ScrollingFrame", {
		Name = "TabButtons",
		Size = UDim2.new(1, 0, 1, -136),
		Position = UDim2.new(0, 0, 0, 80),
		BackgroundTransparency = 1,
		ScrollBarThickness = 2,
		ScrollBarImageColor3 = Theme.Accent,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Parent = sidebar,
	}, {
		new("UIListLayout", {
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			Padding = UDim.new(0, 10),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		new("UIPadding", { PaddingTop = UDim.new(0, 4) }),
	})

	local contentHolder = new("Frame", {
		Name = "ContentHolder",
		Size = UDim2.new(1, -74, 1, 0),
		Position = UDim2.new(0, 74, 0, 0),
		BackgroundTransparency = 1,
		Parent = main,
	})

	local titleLabel: TextLabel? = nil
	if config.Title then
		titleLabel = new("TextLabel", {
			Size = UDim2.new(1, -110, 0, 34),
			Position = UDim2.new(0, 16, 0, 8),
			BackgroundTransparency = 1,
			Text = "",
			Font = Enum.Font.GothamBold,
			TextSize = 18,
			TextColor3 = Theme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = contentHolder,
		})
	end

	local self = setmetatable({
		ScreenGui = screenGui,
		Main = main,
		Sidebar = sidebar,
		ContentHolder = contentHolder,
		TabButtons = tabButtons,
		AvatarImage = avatarImage,
		Tabs = {},
		Language = initialLang,
		_titleOffset = config.Title and 44 or 0,
		_firstTab = nil,
		_mainSize = main.Size,
		_open = true,
		_i18n = {},
		_showErrorToast = config.ShowErrorsAsToast == true,
		_tabCounter = 0,
	}, ModernUI)

	if titleLabel and config.Title then
		bindText(self, titleLabel, config.Title)
	end

	-- Переключатель языка (RU/EN)
	do
		local langHolder = new("Frame", {
			Name = "LanguageSwitch",
			Size = UDim2.new(0, 76, 0, 28),
			Position = UDim2.new(1, -16, 0, 10),
			AnchorPoint = Vector2.new(1, 0),
			BackgroundColor3 = Theme.ElementBg,
			Parent = contentHolder,
		}, { corner(8), stroke() })

		local ruBtn = new("TextButton", {
			Size = UDim2.new(0.5, 0, 1, 0),
			BackgroundColor3 = initialLang == "ru" and Theme.Accent or Theme.ElementBg,
			Text = "RU",
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = Theme.Text,
			AutoButtonColor = false,
			Parent = langHolder,
		}, { corner(8) })

		local enBtn = new("TextButton", {
			Size = UDim2.new(0.5, 0, 1, 0),
			Position = UDim2.new(0.5, 0, 0, 0),
			BackgroundColor3 = initialLang == "en" and Theme.Accent or Theme.ElementBg,
			Text = "EN",
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = Theme.Text,
			AutoButtonColor = false,
			Parent = langHolder,
		}, { corner(8) })

		ruBtn.MouseButton1Click:Connect(function() self:SetLanguage("ru") end)
		enBtn.MouseButton1Click:Connect(function() self:SetLanguage("en") end)

		self._updateLangButtons = function(lang)
			ruBtn.BackgroundColor3 = lang == "ru" and Theme.Accent or Theme.ElementBg
			enBtn.BackgroundColor3 = lang == "en" and Theme.Accent or Theme.ElementBg
		end
	end

	-- Плавающая кнопка сворачивания
	local floatBtn = new("TextButton", {
		Name = "ToggleButton",
		Size = UDim2.new(0, 52, 0, 52),
		Position = UDim2.new(1, -72, 1, -130),
		BackgroundColor3 = Theme.Accent,
		AutoButtonColor = false,
		Text = "",
		ZIndex = 10,
		Parent = screenGui,
	}, { corner(26), stroke(Color3.new(1, 1, 1), 1) })

	local iconHolder = new("Frame", {
		Size = UDim2.new(0, 22, 0, 16),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		ZIndex = 11,
		Parent = floatBtn,
	})

	local barTop = new("Frame", { Size = UDim2.new(1, 0, 0, 3), Position = UDim2.new(0.5, 0, 0, 1), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 11, Parent = iconHolder }, { corner(2) })
	local barMid = new("Frame", { Size = UDim2.new(1, 0, 0, 3), Position = UDim2.new(0.5, 0, 0.5, 0), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 11, Parent = iconHolder }, { corner(2) })
	local barBottom = new("Frame", { Size = UDim2.new(1, 0, 0, 3), Position = UDim2.new(0.5, 1, 1, -1), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.new(1, 1, 1), ZIndex = 11, Parent = iconHolder }, { corner(2) })

	local function setIconState(open: boolean)
		if open then
			TweenService:Create(barTop, TWEEN_MED, { Position = UDim2.new(0.5, 0, 0.5, 0), Rotation = 45 }):Play()
			TweenService:Create(barMid, TWEEN_FAST, { BackgroundTransparency = 1 }):Play()
			TweenService:Create(barBottom, TWEEN_MED, { Position = UDim2.new(0.5, 0, 0.5, 0), Rotation = -45 }):Play()
		else
			TweenService:Create(barTop, TWEEN_MED, { Position = UDim2.new(0.5, 0, 0, 1), Rotation = 0 }):Play()
			TweenService:Create(barMid, TWEEN_FAST, { BackgroundTransparency = 0 }):Play()
			TweenService:Create(barBottom, TWEEN_MED, { Position = UDim2.new(0.5, 0, 1, -1), Rotation = 0 }):Play()
		end
	end

	do
		local dragging, didDrag = false, false
		local dragStart, startPos
		floatBtn.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging, didDrag = true, false
				dragStart, startPos = input.Position, floatBtn.Position
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local delta = input.Position - dragStart
				if delta.Magnitude > 5 then didDrag = true end
				floatBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
			end
		end)
		UserInputService.InputEnded:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
				dragging = false
				if not didDrag then self:Toggle() end
			end
		end)
	end

	self.ToggleButton = floatBtn
	self._setIconState = setIconState

	if config.IncludeSettingsTab ~= false then
		local settingsTab = self:CreateTab({ ru = "Настройки", en = "Settings" }, nil, { isSystem = true, tabId = "Settings", layoutOrder = 1000000 })
	end

	return self
end

function ModernUI.Toggle(self)
	self._open = not self._open
	self._setIconState(self._open)
	if self._open then
		self.Main.Visible = true
		self.Main.Size = UDim2.new(0, 0, 0, 0)
		TweenService:Create(self.Main, TWEEN_MED, { Size = self._mainSize }):Play()
	else
		local tween = TweenService:Create(self.Main, TWEEN_MED, { Size = UDim2.new(0, 0, 0, 0) })
		tween:Play()
		tween.Completed:Once(function()
			if not self._open then self.Main.Visible = false end
		end)
	end
end

function ModernUI.SetLanguage(self, lang)
	self.Language = lang
	for _, entry in ipairs(self._i18n) do
		if entry.instance and entry.instance.Parent then
			(entry.instance :: any).Text = resolveText(entry.template, lang)
		end
	end
	if self._updateLangButtons then self._updateLangButtons(lang) end
end

function ModernUI.Notify(self, message, duration)
	local text = resolveText(message, self.Language)
	duration = duration or 3
	local toast = new("Frame", {
		Size = UDim2.new(0, 260, 0, 46),
		Position = UDim2.new(0.5, 0, 1, -20),
		AnchorPoint = Vector2.new(0.5, 1),
		BackgroundColor3 = Theme.ElementBg,
		BackgroundTransparency = 1,
		ZIndex = 200,
		Parent = self.ScreenGui,
	}, { corner(10), stroke(Theme.Stroke, 1) })

	local strokeInst = toast:FindFirstChildOfClass("UIStroke") :: UIStroke
	strokeInst.Transparency = 1
	local label = new("TextLabel", {
		Size = UDim2.new(1, -20, 1, -12),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Text = text,
		Font = Enum.Font.GothamMedium,
		TextSize = 12,
		TextColor3 = Theme.Text,
		TextTransparency = 1,
		ZIndex = 201,
		Parent = toast,
	})

	TweenService:Create(toast, TWEEN_MED, { BackgroundTransparency = 0 }):Play()
	TweenService:Create(strokeInst, TWEEN_MED, { Transparency = 0 }):Play()
	TweenService:Create(label, TWEEN_MED, { TextTransparency = 0 }):Play()

	task.delay(duration, function()
		if not toast.Parent then return end
		TweenService:Create(toast, TWEEN_MED, { BackgroundTransparency = 1 }):Play()
		TweenService:Create(strokeInst, TWEEN_MED, { Transparency = 1 }):Play()
		TweenService:Create(label, TWEEN_MED, { TextTransparency = 1 }):Play()
		task.wait(0.3)
		toast:Destroy()
	end)
end
--[[
	ModernUI Executor Edition (Часть 2 из 2)
	Продолжение фабрики элементов и пример использования.
]]

local function createElementFactory(container, self_)
	local Factory = {}

	function Factory.CreateButton(text, callback)
		local wrapped = normalizeCallback(callback, toLabel(text), self_)
		local button = new("TextButton", {
			Size = UDim2.new(1, 0, 0, 48),
			BackgroundColor3 = Theme.ElementBg,
			Text = "",
			AutoButtonColor = false,
			Parent = container,
		}, { corner(12), stroke() })

		local label = new("TextLabel", {
			Size = UDim2.new(1, -24, 1, 0),
			Position = UDim2.new(0, 16, 0, 0),
			BackgroundTransparency = 1,
			Text = "",
			Font = Enum.Font.GothamMedium,
			TextSize = 15,
			TextColor3 = Theme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = button,
		})
		bindText(self_, label, text)
		button.MouseButton1Click:Connect(wrapped)
		return button
	end

	function Factory.CreateToggle(text, default, callback)
		local wrapped = normalizeCallback(callback, toLabel(text), self_)
		local state = default or false

		local holder = new("Frame", {
			Size = UDim2.new(1, 0, 0, 48),
			BackgroundColor3 = Theme.ElementBg,
			Parent = container,
		}, { corner(12), stroke() })

		local toggleLabel = new("TextLabel", {
			Size = UDim2.new(1, -80, 1, 0),
			Position = UDim2.new(0, 16, 0, 0),
			BackgroundTransparency = 1,
			Text = "",
			Font = Enum.Font.GothamMedium,
			TextSize = 15,
			TextColor3 = Theme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = holder,
		})
		bindText(self_, toggleLabel, text)

		local switchBg = new("Frame", {
			Size = UDim2.new(0, 46, 0, 26),
			Position = UDim2.new(1, -16, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundColor3 = state and Theme.Accent or Theme.ElementBg2,
			Parent = holder,
		}, { corner(13) })

		local knob = new("Frame", {
			Size = UDim2.new(0, 20, 0, 20),
			Position = state and UDim2.new(1, -3, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
			AnchorPoint = Vector2.new(state and 1 or 0, 0.5),
			BackgroundColor3 = Color3.new(1, 1, 1),
			Parent = switchBg,
		}, { corner(10), stroke(Theme.Stroke, 1) })

		local clickArea = new("TextButton", { Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1, Text = "", Parent = holder })
		clickArea.MouseButton1Click:Connect(function()
			state = not state
			TweenService:Create(switchBg, TWEEN_FAST, { BackgroundColor3 = state and Theme.Accent or Theme.ElementBg2 }):Play()
			TweenService:Create(knob, TWEEN_FAST, { Position = state and UDim2.new(1, -3, 0.5, 0) or UDim2.new(0, 3, 0.5, 0), AnchorPoint = Vector2.new(state and 1 or 0, 0.5) }):Play()
			wrapped(state)
		end)

		return {
			Set = function(s) state = s end,
			Get = function() return state end,
		}
	end

	function Factory.CreateSection(title)
		local card = new("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Theme.Sidebar,
			Parent = container,
		}, {
			corner(14),
			stroke(),
			new("UIPadding", { PaddingTop = UDim.new(0, 12), PaddingBottom = UDim.new(0, 12), PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }),
			new("UIListLayout", { Padding = UDim.new(0, 8), SortOrder = Enum.SortOrder.LayoutOrder }),
		})

		local titleLabel = new("TextLabel", {
			Size = UDim2.new(1, 0, 0, 16),
			LayoutOrder = 0,
			BackgroundTransparency = 1,
			Text = "",
			Font = Enum.Font.GothamBold,
			TextSize = 12,
			TextColor3 = Theme.SubText,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = card,
		})
		bindText(self_, titleLabel, title)

		return createElementFactory(card, self_)
	end

	return Factory
end

function ModernUI.CreateTab(self, name, icon, _opts)
	local opts = _opts or {}
	local tabId = opts.tabId or toLabel(name)
	local isFirst = (not opts.isSystem) and self._firstTab == nil
	if isFirst then self._firstTab = tabId end

	self._tabCounter = (self._tabCounter or 0) + 1

	local btn = new("TextButton", {
		Name = tabId,
		LayoutOrder = opts.layoutOrder or self._tabCounter,
		Size = UDim2.new(0, 52, 0, 52),
		BackgroundColor3 = isFirst and Theme.Accent or Theme.ElementBg,
		Text = "",
		AutoButtonColor = false,
		Parent = self.TabButtons,
	}, { corner(14) })

	local page = new("ScrollingFrame", {
		Name = tabId .. "_Page",
		Size = UDim2.new(1, -32, 1, -(28 + self._titleOffset)),
		Position = UDim2.new(0, 16, 0, 20 + self._titleOffset),
		BackgroundTransparency = 1,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = Theme.Accent,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = isFirst,
		Parent = self.ContentHolder,
	}, {
		new("UIListLayout", { Padding = UDim.new(0, 10), SortOrder = Enum.SortOrder.LayoutOrder }),
	})

	self.Tabs[tabId] = page

	btn.MouseButton1Click:Connect(function()
		for tabName, p in pairs(self.Tabs) do
			p.Visible = (tabName == tabId)
		end
		for _, otherBtn in ipairs(self.TabButtons:GetChildren()) do
			if otherBtn:IsA("TextButton") then
				TweenService:Create(otherBtn, TWEEN_FAST, {
					BackgroundColor3 = (otherBtn.Name == tabId) and Theme.Accent or Theme.ElementBg,
				}):Play()
			end
		end
	end)

	local factory = createElementFactory(page, self)
	cascadeIn(page)
	return factory
end

--================================================================
-- ПРИМЕР ИСПОЛЬЗОВАНИЯ
--================================================================
local Window = ModernUI.new({
	Title = { ru = "Executor Hub", en = "Executor Hub" },
	AvatarId = "rbxassetid://0",
	Language = "ru",
	ShowErrorsAsToast = true,
})

local MainTab = Window:CreateTab({ ru = "Главная", en = "Main" }, "rbxassetid://0")
local MiscSection = MainTab.CreateSection({ ru = "Управление", en = "Controls" })

MiscSection.CreateButton({ ru = "Запустить мой скрипт", en = "Run my script" }, function()
	print("Ваш внешний скрипт успешно запущен параллельно с UI!")
	Window:Notify({ ru = "Скрипт выполнен!", en = "Script executed!" }, 2)
end)

MiscSection.CreateToggle({ ru = "Функция вкл/выкл", en = "Toggle feature" }, false, function(state)
	if state then
		print("Функция включена")
	else
		print("Функция выключена")
	end
end)
