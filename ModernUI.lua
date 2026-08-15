--!strict
return (function()
--[[
	ModernUI - лёгкая UI-библиотека для Roblox
	Особенности:
		- Тёмная (чёрная) современная тема
		- Боковые вкладки слева, аватарка/иконка панели сверху
		- Плавающая перетаскиваемая кнопка открытия/закрытия панели
		- Продвинутая обёртка колбэков: pcall, кулдаун, ретраи, таймаут, onError,
		  опциональные тосты об ошибках прямо в игре
		- Встроенный перевод интерфейса (русский/английский) с переключателем RU/EN
		- Ссылки на Discord/Telegram в боковой панели
		- Анимированные (вращающиеся) 3D-модели — для кнопки и внутри вкладок
		- Элементы: Button, Toggle, Checkbox, Slider, Label, Dropdown, ModelViewer
		- Разделы (Section) — визуальная группировка элементов внутри вкладки
		- Список игроков на сервере (аватар + ник + кнопка "Использовать")
		- Оптимизировано под мобильные экраны (крупные тач-зоны)

	Использование смотри в Example_Usage.lua
]]

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local GuiService = game:GetService("GuiService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

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
local TWEEN_BOUNCE = TweenInfo.new(0.35, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
local TWEEN_PRESS = TweenInfo.new(0.08, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

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
	MobileWarning = {
		ru = "[ModernUI] Библиотека пока оптимизирована только под мобильные устройства. Интерфейс всё равно будет создан, но не гарантируется корректный вид на ПК.",
		en = "[ModernUI] The library is currently optimized for mobile devices only. The UI will still be created, but correct appearance on PC isn't guaranteed.",
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
-- ПРОДВИНУТАЯ ОБЁРТКА КОЛБЭКОВ
--================================================================
export type WrapOptions = {
	label: string?,
	cooldown: number?,
	retries: number?,
	retryDelay: number?,
	timeout: number?,
	onError: ((err: string) -> ())?,
	silent: boolean?,
}

local function wrapCallback(fn: (...any) -> ...any, opts: WrapOptions?)
	opts = opts or {}
	local label = opts.label or "callback"
	local cooldown = opts.cooldown or 0
	local maxRetries = opts.retries or 0
	local retryDelay = opts.retryDelay or 0.3
	local timeout = opts.timeout
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

				if timeout then
					local done = false
					task.spawn(function()
						ok, err = pcall(fn, table.unpack(args, 1, argCount))
						done = true
					end)
					local waited = 0
					while not done and waited < timeout do
						task.wait(0.05)
						waited += 0.05
					end
					if not done then
						ok, err = false, "timeout"
					end
				else
					ok, err = pcall(fn, table.unpack(args, 1, argCount))
				end

				if not ok and attempt <= maxRetries then
					task.wait(retryDelay)
				end
			until ok or attempt > maxRetries

			if not ok then
				if not opts.silent then
					warn(("[ModernUI] Ошибка в '%s' (попытка %d/%d): %s"):format(label, attempt, maxRetries + 1, tostring(err)))
				end
				if opts.onError then
					pcall(opts.onError, tostring(err))
				end
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

local function isMobile(): boolean
	return UserInputService.TouchEnabled and not UserInputService.MouseEnabled
end

local function createModelViewport(props: {[string]: any}, model: Model, spinSpeed: number?)
	local viewport = new("ViewportFrame", props, { corner(12) })

	local camera = Instance.new("Camera")
	viewport.CurrentCamera = camera
	camera.Parent = viewport
	camera.FieldOfView = 40

	local modelClone = model:Clone()
	modelClone.Parent = viewport

	local ok, cf, boundsSize = pcall(function()
		return modelClone:GetBoundingBox()
	end)

	local center = ok and cf.Position or Vector3.new(0, 0, 0)
	local radius = (ok and boundsSize.Magnitude or 4) * 0.9
	local speed = spinSpeed or 0.5
	local angle = 0

	local connection: RBXScriptConnection
	connection = RunService.RenderStepped:Connect(function(dt)
		if not viewport.Parent then
			connection:Disconnect()
			return
		end
		angle += dt * speed
		local camPos = center + Vector3.new(math.cos(angle), 0.35, math.sin(angle)) * radius
		camera.CFrame = CFrame.new(camPos, center)
	end)

	local function destroy()
		if connection then connection:Disconnect() end
		viewport:Destroy()
	end

	return viewport, destroy
end

local function collectTransparencyProps(inst: Instance): {{inst: Instance, prop: string}}
	local result = {}
	if inst:IsA("GuiObject") then
		table.insert(result, { inst = inst, prop = "BackgroundTransparency" })
	end
	if inst:IsA("TextLabel") or inst:IsA("TextButton") or inst:IsA("TextBox") then
		table.insert(result, { inst = inst, prop = "TextTransparency" })
	end
	if inst:IsA("ImageLabel") or inst:IsA("ImageButton") then
		table.insert(result, { inst = inst, prop = "ImageTransparency" })
	end
	if inst:IsA("UIStroke") then
		table.insert(result, { inst = inst, prop = "Transparency" })
	end
	return result
end

local function cascadeIn(container: Instance, opts: {stagger: number?, offset: number?, startDelay: number?}?)
	opts = opts or {}
	local stagger = opts.stagger or 0.05
	local slideOffset = opts.offset or 18
	local startDelay = opts.startDelay or 0.04

	local index = 0
	for _, child in ipairs(container:GetChildren()) do
		if child:IsA("GuiObject") then
			index += 1
			local itemDelay = startDelay + (index - 1) * stagger

			local snapshot = collectTransparencyProps(child)
			for _, desc in ipairs(child:GetDescendants()) do
				for _, entry in ipairs(collectTransparencyProps(desc)) do
					table.insert(snapshot, entry)
				end
			end

			local originalPos = child.Position
			local originalValues = {}
			for i, entry in ipairs(snapshot) do
				originalValues[i] = (entry.inst :: any)[entry.prop]
			end

			child.Position = originalPos + UDim2.new(0, 0, 0, slideOffset)
			for i, entry in ipairs(snapshot) do
				(entry.inst :: any)[entry.prop] = 1
			end

			task.delay(itemDelay, function()
				if not child.Parent then return end
				TweenService:Create(child, TWEEN_MED, { Position = originalPos }):Play()
				for i, entry in ipairs(snapshot) do
					if entry.inst.Parent then
						TweenService:Create(entry.inst, TWEEN_MED, { [entry.prop] = originalValues[i] }):Play()
					end
				end
			end)
		end
	end
end

local function pressBounce(target: GuiObject)
	local scaleInst = target:FindFirstChildOfClass("UIScale")
	if not scaleInst then
		scaleInst = new("UIScale", { Scale = 1 })
		scaleInst.Parent = target
	end
	TweenService:Create(scaleInst, TWEEN_PRESS, { Scale = 0.96 }):Play()
	task.delay(0.08, function()
		if scaleInst.Parent then
			TweenService:Create(scaleInst, TWEEN_PRESS, { Scale = 1 }):Play()
		end
	end)
end

local ModernUI = {}
ModernUI.__index = ModernUI

export type Window = typeof(setmetatable({} :: {
	ScreenGui: ScreenGui,
	Sidebar: Frame,
	ContentHolder: Frame,
	TabButtons: Frame,
	AvatarImage: ImageLabel,
	Tabs: {[string]: Frame},
	_firstTab: string?,
}, ModernUI))

function ModernUI.new(config: {
	Title: (string | {[string]: string})?,
	AvatarId: string?,
	MobileOnly: boolean?,
	Language: ("ru" | "en")?,
	ShowErrorsAsToast: boolean?,
	IncludeSettingsTab: boolean?,
}) : Window
	config = config or {}
	local initialLang = config.Language or "ru"

	if config.MobileOnly ~= false and not isMobile() then
		warn(resolveText(BUILTIN.MobileWarning, initialLang))
	end

	local screenGui = new("ScreenGui", {
		Name = "ModernUI",
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		IgnoreGuiInset = true,
		Parent = PlayerGui,
	})

	local main = new("Frame", {
		Name = "Main",
		Size = UDim2.new(0.7, 0, 0.74, 0),
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

	local tabIndicator = new("Frame", {
		Name = "TabIndicator",
		Size = UDim2.new(0, 3, 0, 36),
		Position = UDim2.new(0, 2, 0, 84),
		BackgroundColor3 = Theme.Accent,
		ZIndex = 2,
		Parent = sidebar,
	}, { corner(2) })

	local function moveTabIndicator(btn: TextButton)
		task.defer(function()
			if not btn.Parent or not tabIndicator.Parent then return end
			local relativeY = btn.AbsolutePosition.Y - sidebar.AbsolutePosition.Y
			local targetY = relativeY + (btn.AbsoluteSize.Y - tabIndicator.AbsoluteSize.Y) / 2
			TweenService:Create(tabIndicator, TWEEN_MED, {
				Position = UDim2.new(0, 2, 0, targetY),
			}):Play()
		end)
	end

	local socialFooter = new("Frame", {
		Name = "SocialFooter",
		Size = UDim2.new(1, -8, 0, 44),
		Position = UDim2.new(0, 4, 1, -50),
		BackgroundTransparency = 1,
		Parent = sidebar,
	}, {
		new("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			Padding = UDim.new(0, 6),
			Wraps = true,
		}),
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
		SocialFooter = socialFooter,
		AvatarImage = avatarImage,
		Tabs = {},
		Language = initialLang,
		_titleOffset = config.Title and 44 or 0,
		_firstTab = nil,
		_mainSize = main.Size,
		_baseMainSize = main.Size,
		_open = true,
		_i18n = {},
		_showErrorToast = config.ShowErrorsAsToast == true,
		_tabCounter = 0,
	}, ModernUI)

	if titleLabel and config.Title then
		bindText(self, titleLabel, config.Title)
			end
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

		local function updateLangButtons(lang: string)
			ruBtn.BackgroundColor3 = lang == "ru" and Theme.Accent or Theme.ElementBg
			enBtn.BackgroundColor3 = lang == "en" and Theme.Accent or Theme.ElementBg
		end

		ruBtn.MouseButton1Click:Connect(function()
			(self :: any):SetLanguage("ru")
		end)
		enBtn.MouseButton1Click:Connect(function()
			(self :: any):SetLanguage("en")
		end)

		(self :: any)._updateLangButtons = updateLangButtons
	end

	(self :: any)._moveTabIndicator = moveTabIndicator

	local floatBtnShadow = new("Frame", {
		Name = "ToggleButtonShadow",
		Size = UDim2.new(0, 52, 0, 52),
		Position = UDim2.new(1, -72, 1, -130),
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.78,
		ZIndex = 9,
		Parent = screenGui,
	}, { corner(26) })

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

	floatBtn:GetPropertyChangedSignal("Position"):Connect(function()
		floatBtnShadow.Position = floatBtn.Position + UDim2.new(0, 0, 0, 4)
	end)

	local iconHolder = new("Frame", {
		Size = UDim2.new(0, 22, 0, 16),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		ZIndex = 11,
		Parent = floatBtn,
	})

	local barTop = new("Frame", {
		Size = UDim2.new(1, 0, 0, 3),
		Position = UDim2.new(0.5, 0, 0, 1),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.new(1, 1, 1),
		ZIndex = 11,
		Parent = iconHolder,
	}, { corner(2) })

	local barMid = new("Frame", {
		Size = UDim2.new(1, 0, 0, 3),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.new(1, 1, 1),
		ZIndex = 11,
		Parent = iconHolder,
	}, { corner(2) })

	local barBottom = new("Frame", {
		Size = UDim2.new(1, 0, 0, 3),
		Position = UDim2.new(0.5, 1, 1, -1),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Color3.new(1, 1, 1),
		ZIndex = 11,
		Parent = iconHolder,
	}, { corner(2) })

	local function setIconState(open: boolean)
		if open then
			TweenService:Create(barTop, TWEEN_MED, {
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Rotation = 45,
			}):Play()
			TweenService:Create(barMid, TWEEN_FAST, {
				BackgroundTransparency = 1,
			}):Play()
			TweenService:Create(barBottom, TWEEN_MED, {
				Position = UDim2.new(0.5, 0, 0.5, 0),
				Rotation = -45,
			}):Play()
		else
			TweenService:Create(barTop, TWEEN_MED, {
				Position = UDim2.new(0.5, 0, 0, 1),
				Rotation = 0,
			}):Play()
			TweenService:Create(barMid, TWEEN_FAST, {
				BackgroundTransparency = 0,
			}):Play()
			TweenService:Create(barBottom, TWEEN_MED, {
				Position = UDim2.new(0.5, 0, 1, -1),
				Rotation = 0,
			}):Play()
		end
	end

	do
		local dragging = false
		local didDrag = false
		local dragStart: Vector2
		local startPos: UDim2

		floatBtn.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				didDrag = false
				dragStart = input.Position
				startPos = floatBtn.Position
			end
		end)

		UserInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				local delta = input.Position - dragStart
				if delta.Magnitude > 5 then
					didDrag = true
				end
				floatBtn.Position = UDim2.new(
					startPos.X.Scale, startPos.X.Offset + delta.X,
					startPos.Y.Scale, startPos.Y.Offset + delta.Y
				)
			end
		end)

		UserInputService.InputEnded:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
				dragging = false
				if not didDrag then
					(self :: any):Toggle()
				end
			end
		end)
	end

	(self :: any).ToggleButton = floatBtn
	(self :: any)._setIconState = setIconState
	(self :: any)._iconHolder = iconHolder

	if config.IncludeSettingsTab ~= false then
		local settingsTab = (self :: any):CreateTab(
			{ ru = "Настройки", en = "Settings" },
			nil,
			{ isSystem = true, tabId = "Settings", layoutOrder = 1000000 }
		)

		settingsTab.CreateDropdown(
			{ ru = "Язык", en = "Language" },
			{ "Русский", "English" },
			initialLang == "en" and "English" or "Русский",
			function(choice: string)
				(self :: any):SetLanguage(choice == "English" and "en" or "ru")
			end
		)

		settingsTab.CreateSlider(
			{ ru = "Масштаб панели", en = "Panel scale" },
			70, 130, 100,
			function(percent: number)
				local self__ = self :: any
				local scale = percent / 100
				local base = self__._baseMainSize
				local newSize = UDim2.new(
					base.X.Scale * scale, base.X.Offset,
					base.Y.Scale * scale, base.Y.Offset
				)
				self__._mainSize = newSize
				self__.Main.Size = newSize
			end
		)

		settingsTab.CreateLabel({ ru = "Библиотека: ModernUI", en = "Library: ModernUI" })

		(self :: any).SettingsTab = settingsTab
	end

	return (self :: any) :: Window
end

function ModernUI.Toggle(self: Window)
	local self_ = self :: any
	self_._open = not self_._open
	self_._setIconState(self_._open)

	if self_._open then
		self_.Main.Visible = true
		self_.Main.Size = UDim2.new(0, 0, 0, 0)
		TweenService:Create(self_.Main, TWEEN_BOUNCE, { Size = self_._mainSize }):Play()

		cascadeIn(self_.TabButtons, { stagger = 0.04, offset = 14, startDelay = 0.05 })
		for _, page in pairs(self_.Tabs) do
			if page.Visible then
				cascadeIn(page, { stagger = 0.06, offset = 22, startDelay = 0.08 })
			end
		end
	else
		local tween = TweenService:Create(self_.Main, TWEEN_MED, { Size = UDim2.new(0, 0, 0, 0) })
		tween:Play()
		tween.Completed:Once(function()
			if not self_._open then
				self_.Main.Visible = false
			end
		end)
	end
end

function ModernUI.SetLanguage(self: Window, lang: "ru" | "en")
	local self_ = self :: any
	self_.Language = lang
	for _, entry in ipairs(self_._i18n) do
		if entry.instance and entry.instance.Parent then
			(entry.instance :: any).Text = resolveText(entry.template, lang)
		end
	end
	if self_._updateLangButtons then
		self_._updateLangButtons(lang)
	end
end

function ModernUI.Notify(self: Window, message: string | {[string]: string}, duration: number?)
	local self_ = self :: any
	local text = resolveText(message, self_.Language)
	duration = duration or 3

	local toast = new("Frame", {
		Size = UDim2.new(0, 260, 0, 46),
		Position = UDim2.new(0.5, 0, 1, -20),
		AnchorPoint = Vector2.new(0.5, 1),
		BackgroundColor3 = Theme.ElementBg,
		BackgroundTransparency = 1,
		ZIndex = 200,
		Parent = self_.ScreenGui,
	}, { corner(10), stroke(Theme.Stroke, 1) })

	local strokeInst = toast:FindFirstChildOfClass("UIStroke") :: UIStroke
	strokeInst.Transparency = 1

	local label = new("TextLabel", {
		Size = UDim2.new(1, -20, 1, -12),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Text = text,
		TextWrapped = true,
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

function ModernUI.SetAvatar(self: Window, avatarId: string | number)
	if typeof(avatarId) == "number" then
		local Players_ = game:GetService("Players")
		local ok, content = pcall(function()
			return Players_:GetUserThumbnailAsync(avatarId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
		end)
		if ok then
			(self :: any).AvatarImage.Image = content
		end
	else
		(self :: any).AvatarImage.Image = avatarId
	end
end

function ModernUI.SetButtonModel(self: Window, model: Model, spinSpeed: number?)
	local self_ = self :: any

	local old = self_.ToggleButton:FindFirstChild("ButtonModelViewport")
	if old then old:Destroy() end

	self_._iconHolder.Visible = false

	local viewport = createModelViewport({
		Name = "ButtonModelViewport",
		Size = UDim2.new(1, -8, 1, -8),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		ZIndex = 11,
		Parent = self_.ToggleButton,
	}, model, spinSpeed)

	return viewport
end

function ModernUI.AddSocialLink(self: Window, kind: "Discord" | "Telegram" | "Custom", url: string, customLabel: string?)
	local self_ = self :: any

	local presets = {
		Discord = { Color = Color3.fromRGB(88, 101, 242), Letter = "D", Name = "Discord" },
		Telegram = { Color = Color3.fromRGB(38, 159, 222), Letter = "T", Name = "Telegram" },
	}
	local preset = presets[kind] or {
		Color = Theme.Accent,
		Letter = (customLabel or "?"):sub(1, 1):upper(),
		Name = customLabel or "Ссылка",
	}

	local btn = new("TextButton", {
		Size = UDim2.new(0, 34, 0, 34),
		BackgroundColor3 = preset.Color,
		Text = preset.Letter,
		Font = Enum.Font.GothamBold,
		TextSize = 15,
		TextColor3 = Color3.new(1, 1, 1),
		AutoButtonColor = false,
		Parent = self_.SocialFooter,
	}, { corner(17) })

	btn.MouseButton1Down:Connect(function()
		TweenService:Create(btn, TWEEN_FAST, { Size = UDim2.new(0, 30, 0, 30) }):Play()
	end)
	btn.MouseButton1Up:Connect(function()
		TweenService:Create(btn, TWEEN_FAST, { Size = UDim2.new(0, 34, 0, 34) }):Play()
	end)

	btn.MouseButton1Click:Connect(wrapCallback(function()
		local opened = false
		pcall(function()
			opened = GuiService:OpenBrowserWindowAsync(url) and true or false
		end)
		if not opened then
			self_:_ShowLinkPopup(preset.Name, url)
		end
	end, { label = "social_" .. preset.Name }))

	return btn
end

function ModernUI._ShowLinkPopup(self: Window, title: string, url: string)
	local self_ = self :: any

	local existing = self_.ScreenGui:FindFirstChild("LinkPopup")
	if existing then existing:Destroy() end

	local overlay = new("Frame", {
		Name = "LinkPopup",
		Size = UDim2.new(1, 0, 1, 0),
		BackgroundColor3 = Color3.new(0, 0, 0),
		BackgroundTransparency = 0.45,
		ZIndex = 100,
		Parent = self_.ScreenGui,
	})

	local card = new("Frame", {
		Size = UDim2.new(0.82, 0, 0, 150),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = Theme.Background,
		ZIndex = 101,
		Parent = overlay,
	}, { corner(16), stroke() })

	new("TextLabel", {
		Size = UDim2.new(1, -56, 0, 26),
		Position = UDim2.new(0, 14, 0, 12),
		BackgroundTransparency = 1,
		Text = title,
		Font = Enum.Font.GothamBold,
		TextSize = 16,
		TextColor3 = Theme.Text,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 101,
		Parent = card,
	})

	local closeBtn = new("TextButton", {
		Size = UDim2.new(0, 28, 0, 28),
		Position = UDim2.new(1, -40, 0, 10),
		BackgroundColor3 = Theme.ElementBg2,
		Text = "×",
		TextColor3 = Theme.Text,
		Font = Enum.Font.GothamBold,
		TextSize = 18,
		AutoButtonColor = false,
		ZIndex = 102,
		Parent = card,
	}, { corner(14) })
	closeBtn.MouseButton1Click:Connect(function()
		overlay:Destroy()
	end)

	new("TextBox", {
		Size = UDim2.new(1, -28, 0, 36),
		Position = UDim2.new(0, 14, 0, 50),
		BackgroundColor3 = Theme.ElementBg,
		Text = url,
		ClearTextOnFocus = false,
		Font = Enum.Font.Gotham,
		TextSize = 13,
		TextColor3 = Theme.Text,
		ZIndex = 101,
		Parent = card,
	}, { corner(8), stroke() })

	new("TextLabel", {
		Size = UDim2.new(1, -28, 0, 34),
		Position = UDim2.new(0, 14, 0, 96),
		BackgroundTransparency = 1,
		Text = resolveText(BUILTIN.LinkNote, self_.Language),
		Font = Enum.Font.Gotham,
		TextSize = 11,
		TextColor3 = Theme.SubText,
		TextWrapped = true,
		ZIndex = 101,
		Parent = card,
	})
		end
		local function createElementFactory(container: Instance, self_: any)
	local Factory = {}

	function Factory.CreateButton(text: string | {[string]: string}, callback: any)
		local wrapped = normalizeCallback(callback, toLabel(text), self_)

		local button = new("TextButton", {
			Size = UDim2.new(1, 0, 0, 48),
			BackgroundColor3 = Theme.ElementBg,
			Text = "",
			AutoButtonColor = false,
			Parent = container,
		}, { corner(12), stroke() })

		local buttonLabel = new("TextLabel", {
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
		bindText(self_, buttonLabel, text)

		button.MouseButton1Down:Connect(function()
			TweenService:Create(button, TWEEN_FAST, { BackgroundColor3 = Theme.ElementBg2 }):Play()
			pressBounce(button)
		end)
		button.MouseButton1Up:Connect(function()
			TweenService:Create(button, TWEEN_FAST, { BackgroundColor3 = Theme.ElementBg }):Play()
		end)
		button.MouseButton1Click:Connect(wrapped)

		return button
	end

	function Factory.CreateToggle(text: string | {[string]: string}, default: boolean?, callback: any)
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

		local clickArea = new("TextButton", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = "",
			Parent = holder,
		})

		clickArea.MouseButton1Click:Connect(function()
			state = not state
			TweenService:Create(switchBg, TWEEN_FAST, {
				BackgroundColor3 = state and Theme.Accent or Theme.ElementBg2,
			}):Play()
			TweenService:Create(knob, TWEEN_FAST, {
				Position = state and UDim2.new(1, -3, 0.5, 0) or UDim2.new(0, 3, 0.5, 0),
				AnchorPoint = Vector2.new(state and 1 or 0, 0.5),
			}):Play()
			pressBounce(switchBg)
			wrapped(state)
		end)

		return {
			Set = function(newState: boolean)
				state = newState
				switchBg.BackgroundColor3 = state and Theme.Accent or Theme.ElementBg2
				knob.Position = state and UDim2.new(1, -3, 0.5, 0) or UDim2.new(0, 3, 0.5, 0)
				knob.AnchorPoint = Vector2.new(state and 1 or 0, 0.5)
			end,
			Get = function() return state end,
		}
	end

	function Factory.CreateCheckbox(text: string | {[string]: string}, default: boolean?, callback: any)
		local wrapped = normalizeCallback(callback, toLabel(text), self_)
		local checked = default or false

		local holder = new("Frame", {
			Size = UDim2.new(1, 0, 0, 48),
			BackgroundColor3 = Theme.ElementBg,
			Parent = container,
		}, { corner(12), stroke() })

		local checkboxLabel = new("TextLabel", {
			Size = UDim2.new(1, -64, 1, 0),
			Position = UDim2.new(0, 16, 0, 0),
			BackgroundTransparency = 1,
			Text = "",
			Font = Enum.Font.GothamMedium,
			TextSize = 15,
			TextColor3 = Theme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = holder,
		})
		bindText(self_, checkboxLabel, text)

		local box = new("Frame", {
			Size = UDim2.new(0, 26, 0, 26),
			Position = UDim2.new(1, -16, 0.5, 0),
			AnchorPoint = Vector2.new(1, 0.5),
			BackgroundColor3 = checked and Theme.Accent or Theme.ElementBg2,
			Parent = holder,
		}, { corner(7), stroke(Theme.Stroke, 1) })

		local checkMark = new("TextLabel", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = "✓",
			Font = Enum.Font.GothamBold,
			TextSize = 17,
			TextColor3 = Color3.new(1, 1, 1),
			TextTransparency = checked and 0 or 1,
			Parent = box,
		})

		local clickArea = new("TextButton", {
			Size = UDim2.new(1, 0, 1, 0),
			BackgroundTransparency = 1,
			Text = "",
			Parent = holder,
		})

		local function applyVisual(animate: boolean)
			local targetColor = checked and Theme.Accent or Theme.ElementBg2
			local targetTransparency = checked and 0 or 1
			if animate then
				TweenService:Create(box, TWEEN_FAST, { BackgroundColor3 = targetColor }):Play()
				TweenService:Create(checkMark, TWEEN_FAST, { TextTransparency = targetTransparency }):Play()
			else
				box.BackgroundColor3 = targetColor
				checkMark.TextTransparency = targetTransparency
			end
		end

		clickArea.MouseButton1Click:Connect(function()
			checked = not checked
			applyVisual(true)
			pressBounce(box)
			wrapped(checked)
		end)

		return {
			Set = function(newVal: boolean)
				checked = newVal
				applyVisual(false)
			end,
			Get = function() return checked end,
		}
	end

	function Factory.CreateSlider(text: string | {[string]: string}, min: number, max: number, default: number?, callback: any)
		local wrapped = normalizeCallback(callback, toLabel(text), self_)
		local value = math.clamp(default or min, min, max)
		local dragging = false

		local holder = new("Frame", {
			Size = UDim2.new(1, 0, 0, 60),
			BackgroundColor3 = Theme.ElementBg,
			Parent = container,
		}, { corner(12), stroke() })

		local label = new("TextLabel", {
			Size = UDim2.new(1, -32, 0, 24),
			Position = UDim2.new(0, 16, 0, 6),
			BackgroundTransparency = 1,
			Text = "",
			Font = Enum.Font.GothamMedium,
			TextSize = 15,
			TextColor3 = Theme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = holder,
		})
		bindText(self_, label, text)

		local valueLabel = new("TextLabel", {
			Size = UDim2.new(0, 50, 0, 24),
			Position = UDim2.new(1, -16, 0, 6),
			AnchorPoint = Vector2.new(1, 0),
			BackgroundTransparency = 1,
			Text = tostring(value),
			Font = Enum.Font.GothamBold,
			TextSize = 14,
			TextColor3 = Theme.Accent,
			TextXAlignment = Enum.TextXAlignment.Right,
			Parent = holder,
		})

		local track = new("Frame", {
			Size = UDim2.new(1, -32, 0, 8),
			Position = UDim2.new(0, 16, 1, -18),
			BackgroundColor3 = Theme.ElementBg2,
			Parent = holder,
		}, { corner(4) })

		local function ratio()
			return (value - min) / (max - min)
		end

		local fill = new("Frame", {
			Size = UDim2.new(ratio(), 0, 1, 0),
			BackgroundColor3 = Theme.Accent,
			Parent = track,
		}, { corner(4) })

		local knob = new("Frame", {
			Size = UDim2.new(0, 18, 0, 18),
			Position = UDim2.new(ratio(), 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Color3.new(1, 1, 1),
			Parent = track,
		}, { corner(9), stroke(Theme.Stroke, 1) })

		local function updateFromX(inputX: number)
			local abs = track.AbsolutePosition.X
			local size = track.AbsoluteSize.X
			local r = math.clamp((inputX - abs) / size, 0, 1)
			value = math.floor(min + (max - min) * r + 0.5)
			fill.Size = UDim2.new(r, 0, 1, 0)
			knob.Position = UDim2.new(r, 0, 0.5, 0)
			valueLabel.Text = tostring(value)
			wrapped(value)
		end

		track.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				updateFromX(input.Position.X)
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
				updateFromX(input.Position.X)
			end
		end)
		UserInputService.InputEnded:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = false
			end
		end)

		return {
			Set = function(v: number)
				value = math.clamp(v, min, max)
				fill.Size = UDim2.new(ratio(), 0, 1, 0)
				knob.Position = UDim2.new(ratio(), 0, 0.5, 0)
				valueLabel.Text = tostring(value)
			end,
			Get = function() return value end,
		}
	end

	function Factory.CreateLabel(text: string | {[string]: string})
		local labelInst = new("TextLabel", {
			Size = UDim2.new(1, 0, 0, 28),
			BackgroundTransparency = 1,
			Text = "",
			Font = Enum.Font.Gotham,
			TextSize = 13,
			TextColor3 = Theme.SubText,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = container,
		})
		bindText(self_, labelInst, text)
		return labelInst
	end

	function Factory.CreateModelViewer(model: Model, height: number?, spinSpeed: number?)
		local holder = new("Frame", {
			Size = UDim2.new(1, 0, 0, height or 180),
			BackgroundColor3 = Theme.ElementBg,
			Parent = container,
		}, { corner(12), stroke() })

		local viewport, destroy = createModelViewport({
			Size = UDim2.new(1, -12, 1, -12),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = Theme.ElementBg2,
			Parent = holder,
		}, model, spinSpeed)

		return {
			Viewport = viewport,
			Destroy = destroy,
		}
	end

	function Factory.CreateDropdown(text: string | {[string]: string}, options: {string}, default: string?, callback: any)
		local wrapped = normalizeCallback(callback, toLabel(text), self_)
		local selected = default or options[1]
		local open = false

		local holder = new("Frame", {
			Size = UDim2.new(1, 0, 0, 48),
			BackgroundColor3 = Theme.ElementBg,
			ClipsDescendants = true,
			Parent = container,
		}, { corner(12), stroke() })

		local dropdownLabel = new("TextLabel", {
			Size = UDim2.new(1, -140, 0, 48),
			Position = UDim2.new(0, 16, 0, 0),
			BackgroundTransparency = 1,
			Text = "",
			Font = Enum.Font.GothamMedium,
			TextSize = 15,
			TextColor3 = Theme.Text,
			TextXAlignment = Enum.TextXAlignment.Left,
			Parent = holder,
		})
		bindText(self_, dropdownLabel, text)

		local current = new("TextButton", {
			Size = UDim2.new(0, 120, 0, 32),
			Position = UDim2.new(1, -16, 0, 8),
			AnchorPoint = Vector2.new(1, 0),
			BackgroundColor3 = Theme.ElementBg2,
			Text = selected,
			Font = Enum.Font.GothamMedium,
			TextSize = 13,
			TextColor3 = Theme.Text,
			AutoButtonColor = false,
			Parent = holder,
		}, { corner(8) })

		local list = new("Frame", {
			Size = UDim2.new(1, -32, 0, #options * 34),
			Position = UDim2.new(0, 16, 0, 52),
			BackgroundTransparency = 1,
			Parent = holder,
		}, {
			new("UIListLayout", { Padding = UDim.new(0, 4) }),
		})

		for _, opt in ipairs(options) do
			local optBtn = new("TextButton", {
				Size = UDim2.new(1, 0, 0, 30),
				BackgroundColor3 = Theme.ElementBg2,
				Text = opt,
				Font = Enum.Font.Gotham,
				TextSize = 13,
				TextColor3 = Theme.SubText,
				AutoButtonColor = false,
				Parent = list,
			}, { corner(8) })

			optBtn.MouseButton1Click:Connect(wrapCallback(function()
				selected = opt
				current.Text = selected
				open = false
				holder.Size = UDim2.new(1, 0, 0, 48)
				wrapped(selected)
			end, { label = toLabel(text) .. "_option" }))
		end

		current.MouseButton1Click:Connect(function()
			open = not open
			TweenService:Create(holder, TWEEN_MED, {
				Size = open and UDim2.new(1, 0, 0, 52 + #options * 34) or UDim2.new(1, 0, 0, 48),
			}):Play()
		end)

		return {
			Get = function() return selected end,
		}
	end

	function Factory.CreateSection(title: string | {[string]: string})
		local card = new("Frame", {
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundColor3 = Theme.Sidebar,
			Parent = container,
		}, {
			corner(14),
			stroke(),
			new("UIPadding", {
				PaddingTop = UDim.new(0, 12),
				PaddingBottom = UDim.new(0, 12),
				PaddingLeft = UDim.new(0, 10),
				PaddingRight = UDim.new(0, 10),
			}),
			new("UIListLayout", {
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
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

	function Factory.CreatePlayerList(opts: {
		height: number?,
		buttonText: (string | {[string]: string})?,
		onUse: ((player: Player) -> ())?,
	}?)
		opts = opts or {}
		local PlayersService = game:GetService("Players")

		local holder = new("Frame", {
			Size = UDim2.new(1, 0, 0, opts.height or 220),
			BackgroundColor3 = Theme.ElementBg,
			Parent = container,
		}, { corner(12), stroke() })

		local list = new("ScrollingFrame", {
			Size = UDim2.new(1, -12, 1, -12),
			Position = UDim2.new(0.5, 0, 0.5, 0),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundTransparency = 1,
			ScrollBarThickness = 3,
			ScrollBarImageColor3 = Theme.Accent,
			CanvasSize = UDim2.new(0, 0, 0, 0),
			AutomaticCanvasSize = Enum.AutomaticSize.Y,
			Parent = holder,
		}, {
			new("UIGridLayout", {
				CellSize = UDim2.new(0, 84, 0, 112),
				CellPadding = UDim2.new(0, 8, 0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			}),
		})

		local cards: {[Player]: Frame} = {}

		local function addPlayerCard(plr: Player)
			if cards[plr] then return end

			local card = new("Frame", {
				BackgroundColor3 = Theme.ElementBg2,
				Parent = list,
			}, { corner(10), stroke() })

			local avatar = new("ImageLabel", {
				Size = UDim2.new(0, 48, 0, 48),
				Position = UDim2.new(0.5, 0, 0, 8),
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundColor3 = Theme.ElementBg,
				ScaleType = Enum.ScaleType.Crop,
				Parent = card,
			}, { corner(24) })

			task.spawn(function()
				local ok, content = pcall(function()
					return PlayersService:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
				end)
				if ok and avatar.Parent then
					avatar.Image = content
				end
			end)

			new("TextLabel", {
				Size = UDim2.new(1, -6, 0, 16),
				Position = UDim2.new(0.5, 0, 0, 60),
				AnchorPoint = Vector2.new(0.5, 0),
				BackgroundTransparency = 1,
				Text = plr.DisplayName ~= plr.Name and (plr.DisplayName .. " (@" .. plr.Name .. ")") or plr.Name,
				Font = Enum.Font.GothamMedium,
				TextSize = 10,
				TextColor3 = Theme.Text,
				TextScaled = false,
				TextWrapped = true,
				TextTruncate = Enum.TextTruncate.AtEnd,
				Parent = card,
			})

			local useBtn = new("TextButton", {
				Size = UDim2.new(1, -12, 0, 22),
				Position = UDim2.new(0.5, 0, 1, -8),
				AnchorPoint = Vector2.new(0.5, 1),
				BackgroundColor3 = Theme.Accent,
				Text = "",
				AutoButtonColor = false,
				Parent = card,
			}, { corner(6) })

			local useLabel = new("TextLabel", {
				Size = UDim2.new(1, 0, 1, 0),
				BackgroundTransparency = 1,
				Text = "",
				Font = Enum.Font.GothamBold,
				TextSize = 11,
				TextColor3 = Color3.new(1, 1, 1),
				Parent = useBtn,
			})
			bindText(self_, useLabel, opts.buttonText or { ru = "Выбрать", en = "Use" })

			useBtn.MouseButton1Click:Connect(normalizeCallback(
				opts.onUse and function() opts.onUse(plr) end or nil,
				"playerlist_use_" .. plr.Name,
				self_
			))

			cards[plr] = card
		end

		local function removePlayerCard(plr: Player)
			local card = cards[plr]
			if card then
				card:Destroy()
				cards[plr] = nil
			end
		end

		for _, plr in ipairs(PlayersService:GetPlayers()) do
			addPlayerCard(plr)
		end

		local addedConn = PlayersService.PlayerAdded:Connect(addPlayerCard)
		local removingConn = PlayersService.PlayerRemoving:Connect(removePlayerCard)

		return {
			Frame = holder,
			Destroy = function()
				addedConn:Disconnect()
				removingConn:Disconnect()
				holder:Destroy()
			end,
		}
	end

	return Factory
end

function ModernUI.CreateTab(self: Window, name: string | {[string]: string}, icon: string?, _opts: {isSystem: boolean?, tabId: string?, layoutOrder: number?}?)
	local self_ = self :: any
	local opts = _opts or {}

	self_._tabCounter = (self_._tabCounter or 0) + 1
	local layoutOrder = opts.layoutOrder or self_._tabCounter
	local tabId = opts.tabId or ("Tab_" .. self_._tabCounter)

	local isFirst = (not opts.isSystem) and self_._firstTab == nil
	if isFirst then self_._firstTab = tabId end

	local btn = new("TextButton", {
		Name = tabId,
		LayoutOrder = layoutOrder,
		Size = UDim2.new(0, 52, 0, 52),
		BackgroundColor3 = isFirst and Theme.Accent or Theme.ElementBg,
		Text = "",
		AutoButtonColor = false,
		Parent = self_.TabButtons,
	}, { corner(14) })

	if isFirst and self_._moveTabIndicator then
		self_._moveTabIndicator(btn)
	end

	new("ImageLabel", {
		Size = UDim2.new(0, 24, 0, 24),
		Position = UDim2.new(0.5, 0, icon and 0.34 or 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Image = icon or "",
		ImageColor3 = Theme.Text,
		Visible = icon ~= nil,
		Parent = btn,
	})

	local tabLabel = new("TextLabel", {
		Size = UDim2.new(1, -4, 0, 14),
		Position = UDim2.new(0.5, 0, icon and 0.78 or 0.5, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundTransparency = 1,
		Text = "",
		Font = Enum.Font.GothamMedium,
		TextSize = 10,
		TextColor3 = Theme.Text,
		TextWrapped = true,
		Parent = btn,
	})
	bindText(self_, tabLabel, name)

	local page = new("ScrollingFrame", {
		Name = tabId .. "_Page",
		Size = UDim2.new(1, -32, 1, -(28 + self_._titleOffset)),
		Position = UDim2.new(0, 16, 0, 20 + self_._titleOffset),
		BackgroundTransparency = 1,
		ScrollBarThickness = 3,
		ScrollBarImageColor3 = Theme.Accent,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = isFirst,
		Parent = self_.ContentHolder,
	}, {
		new("UIListLayout", {
			Padding = UDim.new(0, 10),
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
	})

	self_.Tabs[tabId] = page

	btn.MouseButton1Click:Connect(function()
		for tabName, p in pairs(self_.Tabs) do
			p.Visible = (tabName == tabId)
		end
		for _, otherBtn in ipairs(self_.TabButtons:GetChildren()) do
			if otherBtn:IsA("TextButton") then
				TweenService:Create(otherBtn, TWEEN_FAST, {
					BackgroundColor3 = (otherBtn.Name == tabId) and Theme.Accent or Theme.ElementBg,
				}):Play()
			end
		end
		if self_._moveTabIndicator then
			self_._moveTabIndicator(btn)
		end
		pressBounce(btn)
		cascadeIn(page, { stagger = 0.05, offset = 20, startDelay = 0 })
	end)

	local Tab = createElementFactory(page, self_)

	return Tab
end

function ModernUI.Destroy(self: Window)
	(self :: any).ScreenGui:Destroy()
end

return ModernUI
end)()
