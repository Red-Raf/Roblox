local SOURCE, LIBRARY_SOURCE = [===[
local SHITARO = ...;

if type(SHITARO) ~= "string" and readfile and isfile and isfile("UI-lib/shitaroebet.luau") then
	SHITARO = readfile("UI-lib/shitaroebet.luau");
end;

assert(type(SHITARO) == "string" and SHITARO ~= "", "shitaroebet source missing");

local chunk = assert(loadstring(SHITARO, "@shitaroebet"))
local lib = chunk();

SHITARO = nil;

assert(type(lib) == "table" and type(lib.window) == "function", "shitaroebet did not load");

local NeverLose = {};

NeverLose.Lib = lib;
NeverLose.ScreenGui = lib.scr;
NeverLose.AccentColor = lib.theme.accent;
NeverLose.MainColor = lib.theme.bg;
NeverLose.GlobalLogo = lib.logo;
NeverLose.EnabledBlur = false;
NeverLose.UnloadEnabled = false;
NeverLose.GlobalSignals = {};
NeverLose.Flags = {};
NeverLose.OnToggleChanged = function() end;
NeverLose.BuiltInRegular = Font.fromEnum(Enum.Font.GothamMedium);
NeverLose.BuiltInBold = Font.fromEnum(Enum.Font.GothamBold);

NeverLose.Mobile = lib.mobile and true or false;
NeverLose.IsMobile = NeverLose.Mobile;

local function laneFor(position)
	if NeverLose.Mobile then return "full" end;

	return (position == "right") and "right" or "left";
end;

function NeverLose.RandomString()
	local out = {};

	for _ = 1, 12 do out[#out + 1] = string.char(math.random(1, 7)) end;

	return table.concat(out);
end;

function NeverLose:AddSignal(signal)
	table.insert(NeverLose.GlobalSignals, signal);

	return signal;
end;

function NeverLose:CreateShadow()
	return { Render = function() end, Destroy = function() end };
end;

function NeverLose:CreateBlurModule() end;

function NeverLose:CreateIndicator()
	local ind = {};

	function ind:Set() end;
	function ind:SetRender() end;
	function ind:SetText() end;
	function ind:Remove() end;

	return ind;
end;

NeverLose.Brand = "Wsp boi";

function NeverLose:CreateNotification()
	return {
		new = function(c)
			c = c or {};

			lib:notify({
				title = c.Title or NeverLose.Brand,
				text = c.Content or "",
				icon = NeverLose.IconName(c.Icon or "info"),
				life = c.Duration or 5,
			});
		end,
	};
end;

function NeverLose:CreateLogger()
	return {
		new = function(ic, txt, dur, col)
			lib:notify({
				title = tostring(txt or ""),
				icon = NeverLose.IconName(ic or "file-text"),
				life = dur or 4,
				tone = (typeof(col) == "Color3") and col or nil,
			});
		end,
	};
end;

local ICON_ALIAS = {
	["arrow-down"] = "chevron-down",
	["arrow-left"] = "chevron-right",
	["arrow-right"] = "chevron-right",
	["arrow-right-from-portrait-rectangle"] = "log-out",
	["arrow-rotate-right"] = "refresh-cw",
	["arrow-spin-clockwise"] = "refresh-cw",
	["arrow-up"] = "chevron-up",
	["bookmark"] = "book",
	["chart-four-vertical-bars"] = "activity",
	["chart-line"] = "activity",
	["chevron-large-left"] = "chevron-right",
	["chevron-large-right"] = "chevron-right",
	["chevron-small-down"] = "chevron-down",
	["chevron-small-left"] = "chevron-right",
	["chevron-small-right"] = "chevron-right",
	["chevron-small-up"] = "chevron-up",
	["circle"] = "circle-dot",
	["circle-check"] = "check",
	["circle-play"] = "circle-dot",
	["circle-x"] = "x",
	["crosshairs"] = "crosshair",
	["cube-vertexes"] = "box",
	["eye-slash"] = "eye-off",
	["file-box"] = "file-text",
	["flag"] = "map-pin",
	["floppy-disk"] = "save",
	["frame-corners"] = "monitor",
	["gear"] = "settings",
	["globe-detailed"] = "globe",
	["globe-simplified"] = "globe",
	["hammer-code"] = "wrench",
	["list-bulleted"] = "list",
	["magnifying-glass"] = "search",
	["music"] = "volume-2",
	["music-note"] = "volume-2",
	["paint-brush"] = "palette",
	["pause-large"] = "x",
	["pause-small"] = "x",
	["person"] = "user",
	["person-play"] = "hand",
	["person-running"] = "person-standing",
	["play-large"] = "zap",
	["play-small"] = "zap",
	["plus-large"] = "plus",
	["signal-exclamation"] = "wifi",
	["square"] = "x",
	["square-check"] = "check",
	["stop-large"] = "x",
	["stop-small"] = "x",
	["three-dots-horizontal"] = "ellipsis",
	["three-sliders-horizontal"] = "sliders-horizontal",
	["trash-can"] = "trash-2",
};

function NeverLose.IconName(name)
	local key = string.lower(tostring(name or "")):gsub("%-bold$", "");

	if lib.icons[key] then return key end;

	local alias = ICON_ALIAS[key];

	if alias and lib.icons[alias] then return alias end;

	return key;
end;

function NeverLose.ApplyIcon(label, name)
	if typeof(label) ~= "Instance" then return end;

	local id = lib.icons[NeverLose.IconName(name)];

	if not id then
		label.Text = "";

		return;
	end;

	label.Text = "";

	local image = label:FindFirstChild("Icon");

	if not image then
		image = Instance.new("ImageLabel");
		image.Name = "Icon";
		image.BackgroundTransparency = 1;
		image.AnchorPoint = Vector2.new(0.5, 0.5);
		image.Position = UDim2.fromScale(0.5, 0.5);
		image.Size = UDim2.fromScale(0.85, 0.85);
		image.ScaleType = Enum.ScaleType.Fit;
		image.Parent = label;
	end;

	image.Image = "rbxassetid://" .. id;
	image.ImageColor3 = label.TextColor3;
	image.ZIndex = label.ZIndex;
end;

function NeverLose.SetWatermark(on)
	pcall(function() lib:setwatermark(on and true or false) end);
end;

function NeverLose.SetWatermarkText(text)
	for _, child in ipairs(lib.scr:GetDescendants()) do
		if child:IsA("TextLabel") and child.Text == "shitaro.lol" then
			child.Text = tostring(text or "");

			return true;
		end;
	end;

	return false;
end;

function NeverLose.SetKeybindList(on)
	pcall(function() lib:sethotkeys(on and true or false) end);
end;

local SPOTS = {
	["Top Left"] = { Vector2.new(0, 0), UDim2.new(0, 10, 0, 10) },
	["Top Right"] = { Vector2.new(1, 0), UDim2.new(1, -10, 0, 10) },
	["Bottom Left"] = { Vector2.new(0, 1), UDim2.new(0, 10, 1, -10) },
	["Bottom Right"] = { Vector2.new(1, 1), UDim2.new(1, -10, 1, -10) },
};

NeverLose.SpotNames = { "Top Left", "Top Right", "Bottom Left", "Bottom Right" };

local function panelFor(wantsRight)
	for _, child in ipairs(lib.scr:GetChildren()) do
		if child:IsA("CanvasGroup") and child.ZIndex == 900
			and child.AutomaticSize == Enum.AutomaticSize.XY then
			local onRight = child.AnchorPoint.X > 0.5;

			if onRight == wantsRight then return child end;
		end;
	end;

	return nil;
end;

local marked, binded;

local function moveTo(panel, name)
	local spot = SPOTS[name];

	if not (panel and spot) then return end;

	panel.AnchorPoint = spot[1];
	panel.Position = spot[2];
end;

function NeverLose.SetWatermarkSpot(name)
	marked = (marked and marked.Parent) and marked or panelFor(true);

	moveTo(marked, name);
end;

function NeverLose.SetKeybindSpot(name)
	binded = (binded and binded.Parent) and binded or panelFor(false);

	moveTo(binded, name);
end;

function NeverLose:Unload()
	for _, signal in ipairs(NeverLose.GlobalSignals) do
		pcall(function() signal:Disconnect() end);
	end;

	table.clear(NeverLose.GlobalSignals);

	pcall(function() lib:unload() end);
end;

NeverLose.Unload = NeverLose.Unload;

local function tolerant(object)
	return setmetatable(object, {
		__index = function(_, key)
			if type(key) ~= "string" then return nil end;

			return function() end;
		end,
	});
end;

local function register(flag, item)
	if type(flag) ~= "string" or flag == "" then return item end;

	NeverLose.Flags[flag] = item;

	return item;
end;

local ELLIPSIS = lib.icons.ellipsis and ("rbxassetid://" .. lib.icons.ellipsis) or nil;

local function findDots(element)
	local row = element and element.row;

	if not ELLIPSIS or typeof(row) ~= "Instance" then return nil end;

	for _, child in ipairs(row:GetChildren()) do
		if (child:IsA("ImageButton") or child:IsA("ImageLabel")) and child.Image == ELLIPSIS then
			return child;
		end;
	end;

	return nil;
end;

local function retune(element)
	local row = element and element.row;

	if typeof(row) ~= "Instance" then return element end;

	local caption, pill;

	for _, child in ipairs(row:GetChildren()) do
		if child:IsA("TextLabel") and not caption then
			caption = child;
		elseif child:IsA("Frame") and child.ClipsDescendants then
			pill = child;
		end;
	end;

	if caption then
		caption.TextColor3 = lib.theme.text;
		caption.TextTransparency = 0.12;

		local needed = caption.TextBounds.X;

		if needed <= 0 then needed = #caption.Text * 7 end;

		local share = math.clamp((needed + 14) / math.max(1, row.AbsoluteSize.X), 0.3, 0.6);

		caption.Size = UDim2.new(share, -8, 1, 0);

		if pill then pill.Size = UDim2.new(1 - share, -5, 0, 22) end;
	elseif pill then
		pill.Size = UDim2.new(0.58, -5, 0, 22);
	end;

	return element;
end;

local function typable(element, minimum, maximum)
	local row = element and element.row;

	if typeof(row) ~= "Instance" or type(element.set) ~= "function" then return element end;

	local readout;

	for _, child in ipairs(row:GetChildren()) do
		if child:IsA("TextLabel") and child.TextXAlignment == Enum.TextXAlignment.Right then
			readout = child;
		end;
	end;

	if not readout then return element end;

	local box = Instance.new("TextBox");
	box.Name = "Typed";
	box.BackgroundColor3 = lib.theme.head;
	box.BackgroundTransparency = 0.1;
	box.BorderSizePixel = 0;
	box.AnchorPoint = readout.AnchorPoint;
	box.Position = readout.Position;
	box.Size = UDim2.fromOffset(math.max(44, readout.AbsoluteSize.X + 14), 16);
	box.Font = Enum.Font.GothamBold;
	box.TextSize = 12;
	box.TextColor3 = lib.theme.text;
	box.ClearTextOnFocus = true;
	box.Visible = false;
	box.ZIndex = readout.ZIndex + 2;
	box.Parent = row;

	local corner = Instance.new("UICorner", box);
	corner.CornerRadius = UDim.new(0, 4);

	local hit = Instance.new("TextButton");
	hit.Name = "TypeHit";
	hit.BackgroundTransparency = 1;
	hit.Text = "";
	hit.AnchorPoint = readout.AnchorPoint;
	hit.Position = readout.Position;
	hit.Size = UDim2.fromOffset(math.max(44, readout.AbsoluteSize.X + 14), 18);
	hit.ZIndex = readout.ZIndex + 1;
	hit.Parent = row;

	hit.MouseButton1Click:Connect(function()
		box.Text = tostring(element:get());
		box.Visible = true;

		box:CaptureFocus();
	end);

	box.FocusLost:Connect(function()
		box.Visible = false;

		local typed = tonumber((box.Text or ""):match("-?%d+%.?%d*"));

		if not typed then return end;

		if minimum then typed = math.max(minimum, typed) end;
		if maximum then typed = math.min(maximum, typed) end;

		element:set(typed);
	end);

	return element;
end;

local function stepOf(cfg)
	local digits = tonumber(cfg.Rounding or cfg.Round) or 0;

	return (digits > 0) and (1 / (10 ^ digits)) or 1;
end;

local silent = false;

local function report(flag, hook)
	return function(value, ...)
		if hook then hook(value, ...) end;

		local notify = NeverLose.OnToggleChanged;

		if notify then pcall(notify, value, flag, not silent) end;
	end;
end;

local function quietly(fn, ...)
	local was = silent;

	silent = true;

	local ok, err = pcall(fn, ...);

	silent = was;

	if not ok then error(err, 3) end;
end;

local function wrapValue(element, flag, extra)
	local item = { __el = element };

	function item:GetValue() return element:get() end;
	function item:SetValue(v) quietly(element.set, element, v) end;
	function item:Set(v) quietly(element.set, element, v) end;

	if extra then extra(item, element) end;

	return register(flag, tolerant(item));
end;

local function makeRow(section, caption)
	local row = { Name = caption, __section = section };

	local first = true;

	local dots;

	local function revealDots()
		if dots and dots.Parent then dots.Visible = true end;
	end;

	row.RevealOptions = revealDots;

	local function placeFor(kind)
		if first then
			first = false;

			return section.__sec, caption;
		end;

		local toggle = rawget(row, "__toggle");
		local panel = toggle and toggle.options;

		if panel then
			revealDots();

			return panel, kind;
		end;

		return section.__sec, caption;
	end;

	function row:AddToggle(cfg)
		cfg = cfg or {};

		local target, name = placeFor("Enabled");

		local element = target:toggle({
			name = name,
			default = cfg.Default and true or false,
			options = true,
			flag = cfg.Flag,
			callback = report(cfg.Flag, cfg.Callback),
		});

		row.__toggle = element;
		dots = findDots(element);

		if dots then dots.Visible = false end;

		return wrapValue(element, cfg.Flag);
	end;

	function row:AddSlider(cfg)
		cfg = cfg or {};

		local target, name = placeFor("Amount");

		local element = target:slider({
			name = name,
			min = tonumber(cfg.Min) or 0,
			max = tonumber(cfg.Max) or 100,
			default = cfg.Default,
			step = stepOf(cfg),
			suffix = (type(cfg.Type) == "string") and cfg.Type or "",
			flag = cfg.Flag,
			callback = report(cfg.Flag, cfg.Callback),
		});

		typable(element, tonumber(cfg.Min) or 0, tonumber(cfg.Max) or 100);

		return wrapValue(element, cfg.Flag);
	end;

	function row:AddDropdown(cfg)
		cfg = cfg or {};

		local target, name = placeFor("Mode");

		local element = target:combo({
			name = name,
			list = cfg.Values or {},
			default = cfg.Default,
			multi = cfg.Multi and true or false,
			flag = cfg.Flag,
			callback = report(cfg.Flag, cfg.Callback),
		});

		retune(element);

		return wrapValue(element, cfg.Flag, function(item)
			function item:SetValues(list)
				if element.setlist then element:setlist(list) end;
			end;

			function item:Generate() end;
		end);
	end;

	function row:AddColorPicker(cfg)
		cfg = cfg or {};

		local hook = cfg.Callback;

		local target, name = placeFor("Color");

		local element = target:color({
			name = name,
			default = cfg.Default,
			flag = cfg.Flag,
			callback = report(cfg.Flag, hook and function(colour) hook(colour, cfg.Transparency) end or nil),
		});

		return wrapValue(element, cfg.Flag);
	end;

	function row:AddKeybind(cfg)
		cfg = cfg or {};

		local target, name = placeFor("Key");

		local element = target:keybind({
			name = name,
			default = cfg.Default,
			flag = cfg.Flag,
			callback = report(cfg.Flag, cfg.Callback),
		});

		return wrapValue(element, cfg.Flag);
	end;

	function row:AddTextInput(cfg)
		cfg = cfg or {};

		local host = section.__sec.items;
		local frame = Instance.new("Frame");
		frame.Name = NeverLose.RandomString();
		frame.BackgroundTransparency = 1;
		frame.Size = UDim2.new(1, 0, 0, 26);
		frame.Parent = host;

		local box = Instance.new("TextBox");
		box.Name = "Input";
		box.BackgroundColor3 = lib.theme.head;
		box.BorderSizePixel = 0;
		box.Position = UDim2.new(0, 4, 0, 3);
		box.Size = UDim2.new(1, -8, 0, 20);
		box.Font = Enum.Font.GothamMedium;
		box.TextSize = 12;
		box.TextColor3 = lib.theme.text;
		box.PlaceholderText = cfg.Placeholder or caption;
		box.PlaceholderColor3 = lib.theme.dim;
		box.Text = cfg.Default or "";
		box.ClearTextOnFocus = false;
		box.Parent = frame;

		local corner = Instance.new("UICorner", box);
		corner.CornerRadius = UDim.new(0, 5);

		local item = { __box = box };

		local applying = false;

		function item:GetValue() return box.Text end;

		function item:SetValue(v)
			applying = true;

			box.Text = tostring(v or "");

			applying = false;
		end;

		NeverLose:AddSignal(box:GetPropertyChangedSignal("Text"):Connect(function()
			if applying or not cfg.Callback then return end;

			cfg.Callback(box.Text);
		end));

		if type(cfg.Flag) == "string" and cfg.Flag ~= "" then
			pcall(function()
				lib:hook(cfg.Flag, "string",
					function() return box.Text end,
					function(value) item:SetValue(value) end);
			end);
		end;

		return register(cfg.Flag, item);
	end;

	function row:AddOption()

		local toggle = rawget(row, "__toggle");
		local panel = toggle and toggle.options;

		if not panel then return section end;

		revealDots();

		local nested = { __sec = setmetatable({ items = section.__sec.items }, { __index = panel }) };

		function nested:AddLabel(name) return makeRow(nested, name) end;

		function nested:AddButton(cfg)
			cfg = cfg or {};

			panel:button({ name = cfg.Name or "Button", icon = cfg.Icon and NeverLose.IconName(cfg.Icon) or nil, callback = cfg.Callback });

			return {};
		end;

		nested.__sec = panel;
		nested.__sec.items = section.__sec.items;

		return nested;
	end;

	function row:SetText(value)
		if row.__label and row.__label.set then row.__label:set(value) end;
	end;

	return tolerant(row);
end;

local function wrapSection(sec)
	local section = { __sec = sec, Root = sec.items, Items = sec.items };

	function section:SetVisible(state)
		local panel = sec.panel;
		local curtain = typeof(panel) == "Instance" and panel.Parent or nil;
		local slot = typeof(curtain) == "Instance" and curtain.Parent or nil;

		if typeof(slot) ~= "Instance" then return end;

		slot.Visible = state and true or false;

		if state then
			local height = panel.AbsoluteSize.Y;

			if height > 2 then
				curtain.Size = UDim2.new(1, 0, 0, height);
				slot.Size = UDim2.new(1, 0, 0, height);
			end;
		end;
	end;

	function section:AddLabel(name, isStatus)
		local caption = tostring(name or "");

		if isStatus then
			local element = sec:label({ name = caption, wrap = true });
			local row = makeRow(section, caption);

			row.__label = element;

			function row:SetText(value)
				if element.set then element:set(value) end;
			end;

			return row;
		end;

		return makeRow(section, caption);
	end;

	function section:AddButton(cfg)
		cfg = cfg or {};

		local element = sec:button({
			name = cfg.Name or "Button",
			icon = cfg.Icon and NeverLose.IconName(cfg.Icon) or nil,
			callback = cfg.Callback,
		});

		return tolerant({ __el = element });
	end;

	return tolerant(section);
end;

local function pageSignal(node)
	local bindable = Instance.new("BindableEvent");
	local value = false;
	local previous = node.hit;

	node.hit = function(selected)
		value = selected and true or false;

		if previous then previous(selected) end;

		bindable:Fire(value);
	end;

	return {
		GetValue = function() return value end,
		SetValue = function(_, v) value = v; bindable:Fire(v) end,
		Connect = function(_, fn) return NeverLose:AddSignal(bindable.Event:Connect(fn)) end,
	};
end;

local function windowSize(fallback)
	if not NeverLose.Mobile then return fallback end;

	local camera = workspace.CurrentCamera;
	local view = (camera and camera.ViewportSize) or Vector2.new(640, 480);
	local scale = lib.scale;

	if type(scale) ~= "number" or scale <= 0 then scale = 1 end;

	local wide = math.clamp(view.X - 28, 300, 540);
	local tall = math.clamp(view.Y - 64, 320, 600);

	return UDim2.fromOffset(math.floor(wide / scale), math.floor(tall / scale));
end;

function NeverLose:CreateWindow(cfg)
	cfg = cfg or {};

	local win = lib:window({
		size = windowSize(cfg.Size or UDim2.fromOffset(640, 520)),

		side = NeverLose.Mobile and 124 or nil,
		bind = cfg.Keybind or "RightShift",
	});

	NeverLose.WindowFrame = win.shell;
	NeverLose.WindowRoot = win.root;

	local Window = {
		__win = win,
		Frame = win.shell,
		Tabs = {},
		CurrentTab = 1,
		Keybind = cfg.Keybind or "RightShift",
	};

	local function settleCards(page)
		if typeof(page) ~= "Instance" then return 0 end;

		local fixed = 0;

		for _, frame in ipairs(page:GetDescendants()) do
			if frame:IsA("Frame") and frame.ClipsDescendants then
				local inner = frame:FindFirstChildWhichIsA("Frame");

				if inner and inner.AutomaticSize == Enum.AutomaticSize.Y then
					local want = inner.AbsoluteSize.Y;

					if want > 2 and frame.AbsoluteSize.Y < want - 2 then
						frame.Size = UDim2.new(1, 0, 0, want);

						local slot = frame.Parent;

						if slot and slot:IsA("Frame") and slot.AbsoluteSize.Y < want - 2 then
							slot.Size = UDim2.new(1, 0, 0, want);
						end;

						fixed = fixed + 1;
					end;
				end;
			end;
		end;

		return fixed;
	end;

	local function settleSoon(page)
		task.defer(function() settleCards(page) end);
		task.delay(0.5, function() settleCards(page) end);
	end;

	local signalValue = true;
	local bindable = Instance.new("BindableEvent");

	Window.Signal = {
		GetValue = function() return signalValue end,
		SetValue = function(_, v) signalValue = v; bindable:Fire(v) end,
		Connect = function(_, fn) return NeverLose:AddSignal(bindable.Event:Connect(fn)) end,
	};

	function Window:ToggleInterface()
		signalValue = not signalValue;

		if win.setopen then win:setopen(signalValue) end;

		bindable:Fire(signalValue);
	end;

	NeverLose:AddSignal(game:GetService("RunService").Heartbeat:Connect(function()
		local open = lib.shown and true or false;

		if open ~= signalValue then
			signalValue = open;

			bindable:Fire(open);

			if open and win.active then settleSoon(win.active.page) end;
		end;
	end));

	function Window:GetPage()
		local live = win.active;

		if type(live) ~= "table" then return nil end;

		for _, tab in ipairs(win.list) do
			if tab == live then return tostring(tab.name) end;

			for _, sub in ipairs(tab.subs or {}) do
				if sub == live then return tostring(tab.name) .. "/" .. tostring(sub.name) end;
			end;
		end;

		return nil;
	end;

	function Window:SetPage(path)
		if type(path) ~= "string" or path == "" then return false end;

		local parent, child = string.match(path, "^([^/]+)/(.+)$");

		parent = parent or path;

		for _, tab in ipairs(win.list) do
			if tostring(tab.name) == parent then
				if child then
					for _, sub in ipairs(tab.subs or {}) do
						if tostring(sub.name) == child then
							pcall(function() sub.select() end);

							return true;
						end;
					end;
				end;

				pcall(function() tab.select() end);

				return true;
			end;
		end;

		return false;
	end;

	function Window:SetAccount() end;

	function Window:SetKeybind(value)
		if value == nil then return end;

		Window.Keybind = value;

		pcall(function() win:setbind(value) end);
	end;

	local settingsSection, settingsTab;

	local function settings()
		if not settingsTab then
			settingsTab = win:tab({ name = "SETTINGS", icon = "settings-2" });
		end;

		return settingsTab;
	end;

	function Window:AddConfigCard()
		local tab = settings();

		if type(tab.configs) == "function" then
			return tab:configs({ name = "Configs", side = "right" });
		end;

		return nil;
	end;

	function Window:AddSettingsSection(name, side)
		return wrapSection(settings():section({
			name = name or "section",
			side = (side == "right") and "right" or "left",
		}));
	end;

	Window.UserSettings = setmetatable({}, {
		__index = function(_, key)
			if not settingsSection then
				local tab = settings();

				settingsSection = wrapSection(tab:section({ name = "Menu", side = "left" }));

			end;

			local value = settingsSection[key];

			if type(value) ~= "function" then return value end;

			return function(_, ...) return value(settingsSection, ...) end;
		end,
	});

	do
		local panel = panelFor(true);

		if panel then
			local shrink = panel:FindFirstChildOfClass("UIScale")
				or Instance.new("UIScale", panel);

			shrink.Scale = NeverLose.Mobile and 0.7 or 1;
		end;

		if panel and NeverLose.Mobile then

			panel.Active = true;
			local lastWatermarkTap = 0;

			local function toggleFromWatermark()
				local now = os.clock();

				if now - lastWatermarkTap < 0.18 then return end;

				lastWatermarkTap = now;
				pcall(function() win:toggle() end);
			end;

			local UserInputService = game:GetService("UserInputService");
			local GuiService = game:GetService("GuiService");
			local pressedIn, pressedAt;

			local function pointer(input)
				if input.UserInputType == Enum.UserInputType.Touch then
					return Vector2.new(input.Position.X, input.Position.Y);
				end;

				return UserInputService:GetMouseLocation();
			end;

			local function over(at)
				local origin = panel.AbsolutePosition + Vector2.new(0, GuiService:GetGuiInset().Y);
				local size = panel.AbsoluteSize;

				return at.X >= origin.X and at.X <= origin.X + size.X
					and at.Y >= origin.Y and at.Y <= origin.Y + size.Y;
			end;

			local function pressable(input)
				return input.UserInputType == Enum.UserInputType.MouseButton1
					or input.UserInputType == Enum.UserInputType.Touch;
			end;

			NeverLose:AddSignal(UserInputService.InputBegan:Connect(function(input)
				if not pressable(input) then return end;
				if not (panel.Parent and panel.Visible and lib.watermark) then return end;

				local at = pointer(input);

				pressedIn, pressedAt = over(at) and at or nil, os.clock();
			end));

			NeverLose:AddSignal(UserInputService.InputEnded:Connect(function(input)
				if not pressable(input) then return end;

				local start = pressedIn;

				pressedIn = nil;

				if not start then return end;

				if (pointer(input) - start).Magnitude > 8 then return end;
				if os.clock() - pressedAt > 0.7 then return end;

				toggleFromWatermark();
			end));

			for _, child in ipairs(panel:GetChildren()) do
				if child:IsA("GuiObject") then
					child.Active = true;

					NeverLose:AddSignal(child.InputEnded:Connect(function(input)
						if not pressable(input) then return end;
						if not (panel.Parent and panel.Visible and lib.watermark) then return end;

						toggleFromWatermark();
					end));
				end;
			end;
		end;

		pcall(function() lib:setopener(false) end);

		local watermarkOn = true;

		function NeverLose.SetWatermark(on)
			watermarkOn = on and true or false;

			pcall(function() lib:setwatermark(watermarkOn) end);

			pcall(function() lib:setopener(NeverLose.Mobile and not watermarkOn) end);
		end;
	end;

	function Window:Watermark()
		local mark = {};

		function mark:AddBlock(icon, text)
			local block = { Icon = icon, Text = text, Visible = true };

			function block:Set(value) block.Text = value end;
			function block:SetText(value) block.Text = value end;
			function block:SetVisible(value) block.Visible = value and true or false end;
			function block:Input(fn) block.OnClick = fn end;

			return tolerant(block);
		end;

		return tolerant(mark);
	end;

	function Window:AddTab(config)
		config = config or {};

		local tab = win:tab({ name = config.Name or "Tab", icon = NeverLose.IconName(config.Icon) });

		local Tab = { __tab = tab, Name = config.Name, Signal = pageSignal(tab) };

		function Tab:AddSection(sectionConfig)
			sectionConfig = sectionConfig or {};

			return wrapSection(tab:section({
				name = sectionConfig.Name or "section",
				side = laneFor(sectionConfig.Position),
			}));
		end;

		function Tab.SetValue(value)
			if value and tab.select then tab:select() end;
		end;

		table.insert(Window.Tabs, Tab);

		return tolerant(Tab);
	end;

	function Window:AddGroup(name, icon, entries)
		local tab = win:tab({ name = name, icon = NeverLose.IconName(icon) });
		local group = { __tab = tab };

		for _, entry in ipairs(entries or {}) do
			local sub = tab:sub({ name = entry.Name, icon = NeverLose.IconName(entry.Icon) });
			local page = { __sub = sub, Name = entry.Name, Signal = pageSignal(sub) };

			function page:AddSection(sectionConfig)
				sectionConfig = sectionConfig or {};

				return wrapSection(sub:section({
					name = sectionConfig.Name or "section",
					side = laneFor(sectionConfig.Position),
				}));
			end;

			function page.SetValue(value)
				if value and sub.select then sub:select() end;
			end;

			function page:AddGallery(cfg)
				cfg = cfg or {};

				return sub:gallery({
					name = cfg.Name or "gallery",
					icon = cfg.Icon and NeverLose.IconName(cfg.Icon) or "image",
					side = laneFor(cfg.Position),
					height = cfg.Height or 260,
					list = cfg.Values or {},
					default = cfg.Default,
					multi = cfg.Multi and true or false,
					thumb = cfg.Thumb or "Asset",
					blank = cfg.Blank and NeverLose.IconName(cfg.Blank) or "image",
					cell = cfg.Cell or 76,
					search = cfg.Search ~= false,
					tools = cfg.Tools == true,
					buttons = cfg.Buttons,
					context = cfg.Context,
					empty = cfg.Empty or "nothing here",
					flag = cfg.Flag,
					callback = report(cfg.Flag, cfg.Callback),
				});
			end;

			group[entry.Name] = tolerant(page);

			table.insert(Window.Tabs, group[entry.Name]);
		end;

		local remembered = tab.subs and tab.subs[1] or nil;
		local bouncing = false;

		for _, sub in ipairs(tab.subs or {}) do
			local previous = sub.hit;

			sub.hit = function(selected)
				if selected then remembered = sub end;

				if previous then previous(selected) end;

				if selected then settleSoon(sub.page) end;
			end;
		end;

		local parentHit = tab.hit;

		tab.hit = function(selected)
			if parentHit then parentHit(selected) end;

			if selected then settleSoon(tab.page) end;

			if not (selected and remembered and not bouncing) then return end;

			bouncing = true;

			task.defer(function()
				bouncing = false;

				pcall(function() remembered:select() end);
			end);
		end;

		function group.Select()
			if remembered then pcall(function() remembered:select() end) end;
		end;

		if remembered and win.active == tab then
			task.defer(function() pcall(function() remembered:select() end) end);
		end;

		function group.Toggle()
			if tab.setopen then tab:setopen(not tab.open) end;

			return tab.open;
		end;

		function group.IsOpen() return tab.open end;

		return group;
	end;

	return tolerant(Window);
end;

return NeverLose;
]===], [===[
if not LPH_OBFUSCATED then
	local a = function() end
	local g = getgenv and getgenv() or _G
	g.LPH_ATTRIBUTES = a
	g.ENCRYPT, g.VM, g.PRESET, g.OPTIMIZE, g.TRANSFORM, g.ERROR_HANDLING = a, a, a, a, a, a
	g.UNROLL, g.INLINE, g.NO_UPVALUES = a, a, a
	g.NONE, g.OPAL, g.ONYX, g.FAST, g.BALANCED, g.SECURE = a, a, a, a, a, a
	g.EXTRACT, g.CONTROL_FLOW, g.REWRITE_NAMECALLS, g.GLOBALS, g.CONSTANTS = a, a, a, a, a
end

LPH_ATTRIBUTES(VM(NONE), TRANSFORM(EXTRACT))

cloneref = cloneref or function(o) return o end
gethui = gethui or get_hidden_gui
getcustomasset = getcustomasset or getsynasset
getgenv = getgenv or getfenv

do
	local rawHui = gethui or get_hidden_gui
	local function safeHui()
		if type(rawHui) == "function" then
			local ok, result = pcall(rawHui)
			if ok and typeof(result) == "Instance" then return result end
		end
	end

	gethui = safeHui
	get_hidden_gui = safeHui
end

local tws = cloneref(game:GetService("TweenService"))
local txs = cloneref(game:GetService("TextService"))
local uis = cloneref(game:GetService("UserInputService"))
local rs = cloneref(game:GetService("RunService"))
local plrs = cloneref(game:GetService("Players"))
local gus = cloneref(game:GetService("GuiService"))
local lp = plrs.LocalPlayer
local mouse = lp:GetMouse()
local clipput = setclipboard or toclipboard or (clipboard and clipboard.set)
local clipget = getclipboard or readclipboard or (clipboard and clipboard.get)
local hui = gethui and gethui()

if not hui then
	local ok, core = pcall(function() return cloneref(game:GetService("CoreGui")) end)
	hui = ok and core or nil
end

hui = hui or lp:WaitForChild("PlayerGui")
local prot = protect_gui or protectgui or (syn and syn.protect_gui) or function(g) return g end

local shitaroebet = {}

shitaroebet.ver = "67"
shitaroebet.wins = {}
shitaroebet.conns = {}

local drawmask = getgenv().shitaro_drawmask

if type(drawmask) ~= "table" then
	drawmask = {}
	getgenv().shitaro_drawmask = drawmask
end

shitaroebet.drawmask = drawmask

local function maskdel(f)
	for i = #drawmask, 1, -1 do
		if drawmask[i] == f then
			table.remove(drawmask, i)
		end
	end
end

local function maskadd(f)
	for i = #drawmask, 1, -1 do
		local e = drawmask[i]

		if e == f or typeof(e) ~= "Instance" or not e.Parent then
			table.remove(drawmask, i)
		end
	end

	drawmask[#drawmask + 1] = f
end

shitaroebet.layout = "auto"

local touch = uis.TouchEnabled
local keyboard = uis.KeyboardEnabled
local mouse = uis.MouseEnabled

shitaroebet.mobile = touch and not keyboard and not mouse
shitaroebet.scale = shitaroebet.mobile and 0.85 or 1

local sc = shitaroebet.scale

shitaroebet.theme = {
	bg = Color3.fromRGB(6, 6, 8),
	side = Color3.fromRGB(12, 12, 15),
	panel = Color3.fromRGB(11, 11, 14),
	head = Color3.fromRGB(15, 15, 18),
	line = Color3.fromRGB(52, 52, 64),
	glow = Color3.fromRGB(150, 152, 175),
	text = Color3.fromRGB(240, 240, 245),
	dim = Color3.fromRGB(122, 122, 134),
	accent = Color3.fromRGB(255, 255, 255),
}

shitaroebet.icons = {
	activity = 137527339160230,
	banknote = 113703117675594,
	bell = 84691420588185,
	book = 74111869099427,
	bot = 70979486241131,
	box = 117371753006597,
	boxes = 95055252135506,
	brain = 116902501990569,
	bug = 75649814233484,
	car = 91451724283877,
	["car-front"] = 79993076477613,
	check = 86817768619372,
	["chevron-down"] = 71457658246709,
	["chevron-right"] = 101007429951147,
	["chevron-up"] = 98648581502859,
	["circle-dot"] = 122878673716704,
	["clipboard-paste"] = 79192963603923,
	clock = 136533241128438,
	code = 75851496262862,
	copy = 116378866141355,
	pipette = 104047428948587,
	cog = 123222732420633,
	coins = 117341212186115,
	compass = 73836660434977,
	crosshair = 83752373575368,
	crown = 92253403464658,
	database = 99154172590159,
	dices = 116678154854810,
	ellipsis = 101330725759187,
	eye = 127234874352422,
	["eye-off"] = 85207295981701,
	["file-text"] = 92774566080911,
	fish = 114555142566431,
	flame = 125012650497883,
	folder = 77937190465422,
	footprints = 80792036653047,
	["gamepad-2"] = 99293705721130,
	gauge = 128279962545721,
	ghost = 132705178126217,
	globe = 125685532120024,
	hand = 83088528355903,
	heart = 88525382655929,
	home = 109841253338329,
	image = 114022611279795,
	info = 120620848266512,
	key = 83474888140571,
	keyboard = 121978468376124,
	layers = 114499998778667,
	link = 86131768436965,
	list = 101699539545687,
	lock = 119765975153029,
	["log-out"] = 140299936053191,
	map = 131325044235094,
	["map-pin"] = 137091405832737,
	minus = 95070996149109,
	monitor = 70520152532392,
	move = 77028714324861,
	["mouse-pointer"] = 113428527051320,
	package = 106101842173393,
	palette = 127369887384101,
	["person-standing"] = 101118444346965,
	pickaxe = 111300940329486,
	plus = 101123124881873,
	power = 89331085993646,
	radar = 132868138496209,
	["refresh-cw"] = 106497040962250,
	rocket = 109537053598807,
	save = 122894934359450,
	["scan-eye"] = 109514269737059,
	search = 72296609649861,
	send = 94849431195865,
	settings = 106205298246017,
	["settings-2"] = 109485777305919,
	shield = 106509993556171,
	["shield-check"] = 71867984579031,
	shirt = 128162112866809,
	["shopping-cart"] = 79435149356304,
	skull = 101060850237115,
	["sliders-horizontal"] = 125396339381135,
	sparkles = 105634041692696,
	star = 72669221096319,
	["swatch-book"] = 70990631477660,
	sword = 121406454377051,
	swords = 99199363807265,
	target = 121091323240554,
	terminal = 102379915564176,
	["toggle-right"] = 129483325318573,
	["trash-2"] = 126010725826757,
	user = 114567720540659,
	users = 85332511060401,
	["users-round"] = 103880524805720,
	video = 99411215690870,
	["volume-2"] = 129861259578431,
	["wand-sparkles"] = 115623066336607,
	wifi = 104941258142372,
	wrench = 85345725497834,
	x = 116396312853810,
	zap = 109718589733073,
}

local function icon(v)
	if type(v) == "number" then
		return "rbxassetid://" .. v
	end

	if type(v) ~= "string" or v == "" then
		return ""
	end

	if string.find(v, "://", 1, true) then
		return v
	end

	if string.match(v, "^%d+$") then
		return "rbxassetid://" .. v
	end

	local id = shitaroebet.icons[string.lower(v)]

	return id and ("rbxassetid://" .. id) or ""
end

local shots = {
	asset = "rbxthumb://type=Asset&id=%d&w=150&h=150",
	bundlethumbnail = "rbxthumb://type=BundleThumbnail&id=%d&w=150&h=150",
	avatarheadshot = "rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150",
	avatar = "rbxthumb://type=Avatar&id=%d&w=352&h=352",
	avatarbust = "rbxthumb://type=AvatarBust&id=%d&w=150&h=150",
	gameicon = "rbxthumb://type=GameIcon&id=%d&w=150&h=150",
	gamepass = "rbxthumb://type=GamePass&id=%d&w=150&h=150",
	badgeicon = "rbxthumb://type=BadgeIcon&id=%d&w=150&h=150",
	outfit = "rbxthumb://type=Outfit&id=%d&w=150&h=150",
	group = "rbxthumb://type=GroupIcon&id=%d&w=150&h=150",
}

local terse = {
	LeftAlt = "LAlt",
	RightAlt = "RAlt",
	LeftShift = "LShift",
	RightShift = "RShift",
	LeftControl = "LCtrl",
	RightControl = "RCtrl",
	LeftSuper = "LWin",
	RightSuper = "RWin",
	LeftMeta = "LMeta",
	RightMeta = "RMeta",
	Backspace = "Bksp",
	CapsLock = "Caps",
	Insert = "Ins",
	Delete = "Del",
	PageUp = "PgUp",
	PageDown = "PgDn",
	Escape = "Esc",
	Return = "Enter",
	PrintScreen = "PrtSc",
	ScrollLock = "ScrLk",
	NumLock = "NumLk",
	Semicolon = ";",
	Comma = ",",
	Period = ".",
	Slash = "/",
	BackSlash = "\\",
	Quote = "'",
	LeftBracket = "[",
	RightBracket = "]",
	Minus = "-",
	Equals = "=",
	Backquote = "`",
	Unknown = "None",
}

local function keyname(k)
	if typeof(k) ~= "EnumItem" then
		return "None"
	end

	local n = k.Name

	if terse[n] then
		return terse[n]
	end

	local pad = string.match(n, "^Keypad(.+)$")

	if pad then
		return "Num" .. pad
	end

	return n
end

local med = TweenInfo.new(0.18)
local quick = TweenInfo.new(0.09, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local glide = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local soft = TweenInfo.new(0.24, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

local function rnd()
	local t = table.create(12)
	for i = 1, 12 do
		t[i] = string.char(math.random(97, 122))
	end
	return table.concat(t)
end

local function new(cls, props, parent)
	local o = Instance.new(cls)
	if cls == "ImageButton" or cls == "TextButton" then
		o.AutoButtonColor = false
		o.Selectable = false
	end
	for k, v in next, props do
		o[k] = v
	end
	if parent then
		o.Parent = parent
	end
	return o
end

local function conn(sig, fn)
	local c = sig:Connect(fn)
	table.insert(shitaroebet.conns, c)
	return c
end

local function anim(o, info, props)
	local t = tws:Create(o, info, props)
	t:Play()
	return t
end

local function shrink(o)
	if sc ~= 1 then
		new("UIScale", { Scale = sc }, o)
	end

	return o
end

local function apos(o)
	return o.AbsolutePosition / sc
end

local function asz(o)
	return o.AbsoluteSize / sc
end

local function acs(o)
	return o.AbsoluteContentSize / sc
end

local rides = setmetatable({}, { __mode = "k" })
local skip = setmetatable({}, { __mode = "k" })

local function outq(t)
	return 1 - (1 - t) ^ 5
end

local function inq(t)
	return t * t
end

local function flow(o, dur, curve, step, lag)
	local prev = rides[o]

	if prev then
		prev:Disconnect()
		rides[o] = nil
	end

	local t = -(lag or 0)
	local c

	c = rs.RenderStepped:Connect(function(dt)
		if not o.Parent then
			c:Disconnect()

			if rides[o] == c then
				rides[o] = nil
			end

			return
		end

		t = math.min(t + dt, dur)

		if t < 0 then
			step(0)

			return
		end

		step(curve(t / dur))

		if t >= dur then
			c:Disconnect()

			if rides[o] == c then
				rides[o] = nil
			end
		end
	end)

	rides[o] = c

	return c
end

local function round(o, r)
	return new("UICorner", { CornerRadius = UDim.new(0, r) }, o)
end

local function hexof(c)
	return string.format("#%02X%02X%02X", math.floor(c.R * 255 + 0.5), math.floor(c.G * 255 + 0.5), math.floor(c.B * 255 + 0.5))
end

local function fromhex(s)
	if type(s) ~= "string" then
		return nil
	end

	local raw = string.gsub(s, "[^%x]", "")

	if #raw == 3 then
		raw = string.gsub(raw, "%x", "%1%1")
	end

	if #raw ~= 6 then
		return nil
	end

	local n = tonumber(raw, 16)

	if not n then
		return nil
	end

	return Color3.fromRGB(math.floor(n / 65536) % 256, math.floor(n / 256) % 256, n % 256)
end

local function fade(o, rot, keys)
	return new("UIGradient", {
		Rotation = rot,
		Transparency = NumberSequence.new(keys),
	}, o)
end

local nooks = {
	Vector3.new(1, 1, 1),
	Vector3.new(1, 1, -1),
	Vector3.new(1, -1, 1),
	Vector3.new(1, -1, -1),
	Vector3.new(-1, 1, 1),
	Vector3.new(-1, 1, -1),
	Vector3.new(-1, -1, 1),
	Vector3.new(-1, -1, -1),
}

local function pullasset(name)
	local grab = getgenv().shitaro_asset

	if type(grab) ~= "function" or type(name) ~= "string" or name == "" then
		return nil
	end

	local ok, res = pcall(grab, name)

	if ok and type(res) == "string" and res ~= "" then
		return res
	end
end

local function pulllist(prefix)
	local names = getgenv().shitaro_assetlist

	if type(names) ~= "function" then
		return {}
	end

	local ok, res = pcall(names, prefix)

	if ok and type(res) == "table" then
		return res
	end

	return {}
end

local function asset(paths)
	if getcustomasset and isfile then
		for _, p in next, paths do
			local ok, res = pcall(function()
				return isfile(p) and getcustomasset(p) or nil
			end)
			if ok and res then
				return res
			end
		end
	end
	local got = pullasset(string.match(tostring(paths[1] or ""), "([^/\\]+)$"))
	if got then
		return got
	end
	return ""
end

local locks = 0

local function latch(d)
	locks = math.max(locks + d, 0)
end

local sky = nil
local skyzone = nil
local overkeys = nil

local function inset()
	local ok, v = pcall(function()
		return gus:GetGuiInset()
	end)

	if ok and typeof(v) == "Vector2" then
		return v
	end

	return Vector2.zero
end

local function inside(frame, slack)
	if not frame or not frame.Parent or not frame.Visible then
		return false
	end

	local s = frame.AbsoluteSize

	if s.X <= 0 or s.Y <= 0 then
		return false
	end

	local p = frame.AbsolutePosition + inset()

	slack = slack or 0

	local m = uis:GetMouseLocation()

	return m.X >= p.X - slack and m.X <= p.X + s.X + slack and m.Y >= p.Y - slack and m.Y <= p.Y + s.Y + slack
end

local function sink()
	local s = sky

	if not s then
		return
	end

	sky = nil
	skyzone = nil

	s()
end

conn(uis.InputBegan, function(i, typing)
	if not sky or typing then
		return
	end

	if locks > 0 then
		return
	end

	if overkeys and overkeys() then
		return
	end

	if skyzone and inside(skyzone, 2) then
		return
	end

	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		sink()
	end
end)

local function drag(handle, target, speed)
	local info = TweenInfo.new(speed or 0.13, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	local held, origin, base = false, nil, nil

	conn(handle.InputBegan, function(i)
		if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local spot, seat = i.Position, target.Position

		task.wait()

		if locks > 0 or i.UserInputState == Enum.UserInputState.End then
			return
		end

		held, origin, base = true, spot, seat

		local stop
		stop = i.Changed:Connect(function()
			if i.UserInputState == Enum.UserInputState.End then
				held = false
				stop:Disconnect()
			end
		end)
	end)

	conn(uis.InputEnded, function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			held = false
		end
	end)

	conn(uis.InputChanged, function(i)
		if not held or locks > 0 then
			return
		end
		if i.UserInputType ~= Enum.UserInputType.MouseMovement and i.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		local d = i.Position - origin

		anim(target, info, {
			Position = UDim2.new(
				base.X.Scale,
				math.floor(base.X.Offset + d.X),
				base.Y.Scale,
				math.floor(base.Y.Offset + d.Y)
			),
		})
	end)
end

local function net(parent, count, reach, speed, zi)
	local th = shitaroebet.theme

	local layer = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = zi,
	}, parent)

	local api = { layer = layer, on = true, veil = 0, marks = {} }
	local dots, link, hook = {}, {}, {}

	skip[layer] = true

	local function strand(alpha)
		local o = new("Frame", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = th.glow,
			BackgroundTransparency = alpha,
			BorderSizePixel = 0,
			Size = UDim2.fromOffset(0, 1),
			Visible = false,
			ZIndex = zi,
		}, layer)

		skip[o] = true

		return o
	end

	for i = 1, count do
		local s = math.random(2, 4)
		local base = 0.2 + math.random() * 0.3

		local o = new("Frame", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0.5, 0.5),
			BackgroundColor3 = th.glow,
			BackgroundTransparency = base,
			BorderSizePixel = 0,
			Size = UDim2.fromOffset(s, s),
			ZIndex = zi + 1,
		}, layer)

		new("UICorner", { CornerRadius = UDim.new(1, 0) }, o)

		skip[o] = true

		dots[i] = {
			o = o,
			base = base,
			x = math.random(),
			y = math.random(),
			vx = (math.random() - 0.5) * speed,
			vy = (math.random() - 0.5) * speed,
			px = 0,
			py = 0,
			jam = 0,
		}
	end

	for i = 1, count do
		link[i] = {}

		for j = i + 1, count do
			link[i][j] = strand(1)
		end

		hook[i] = strand(1)
	end

	local function put(l, ax, ay, bx, by, span)
		local dx, dy = bx - ax, by - ay
		local dist = math.sqrt(dx * dx + dy * dy)

		if dist >= span or dist < 2 then
			if l.Visible then
				l.Visible = false
			end

			return
		end

		local t = dist / span
		local base = 0.35 + 0.6 * t * t

		l.Size = UDim2.fromOffset(dist, 1)
		l.Position = UDim2.fromOffset((ax + bx) * 0.5, (ay + by) * 0.5)
		l.Rotation = math.deg(math.atan2(dy, dx))
		l.BackgroundTransparency = base + (1 - base) * api.veil
		l.Visible = true
	end

	local rects, pts = {}, {}

	api.conn = conn(rs.RenderStepped, function(dt)
		if not api.on then
			return
		end

		local size = asz(layer)
		local w, h = size.X, size.Y

		if w < 1 or h < 1 then
			return
		end

		local step = math.min(dt, 0.05)
		local span = reach * math.min(w, h)
		local origin = apos(layer)

		table.clear(rects)
		table.clear(pts)

		for _, m in next, api.marks do
			if m.Parent and m.Visible then
				local p = apos(m) - origin
				local s = asz(m)
				local x1, y1, x2, y2 = p.X, p.Y, p.X + s.X, p.Y + s.Y

				table.insert(rects, { x1 - 3, y1 - 3, x2 + 3, y2 + 3 })

				for _, c in next, { { x1, y1 }, { x2, y1 }, { x1, y2 }, { x2, y2 } } do
					if c[1] > 3 and c[1] < w - 3 and c[2] > 3 and c[2] < h - 3 then
						table.insert(pts, c)
					end
				end
			end
		end

		for _, d in next, dots do
			d.x += d.vx * step
			d.y += d.vy * step

			if d.x < 0.015 or d.x > 0.985 then
				d.vx = -d.vx
				d.x = math.clamp(d.x, 0.015, 0.985)
			end

			if d.y < 0.015 or d.y > 0.985 then
				d.vy = -d.vy
				d.y = math.clamp(d.y, 0.015, 0.985)
			end

			d.px, d.py = d.x * w, d.y * h
			d.hit = false

			for _, rc in next, rects do
				if d.px > rc[1] and d.px < rc[3] and d.py > rc[2] and d.py < rc[4] then
					local l, r = d.px - rc[1], rc[3] - d.px
					local t, b = d.py - rc[2], rc[4] - d.py
					local m = math.min(l, r, t, b)
					local sp = math.max(math.abs(d.vx), math.abs(d.vy), speed * 0.75)

					if m == l and rc[1] > 4 then
						d.vx = -sp
					elseif m == r and rc[3] < w - 4 then
						d.vx = sp
					elseif m == t and rc[2] > 4 then
						d.vy = -sp
					elseif m == b and rc[4] < h - 4 then
						d.vy = sp
					else
						d.vx = (d.x < 0.5) and sp or -sp
						d.vy = (d.y < 0.5) and sp or -sp
					end

					d.hit = true
				end
			end

			if d.hit then
				d.jam += step

				if d.jam > 2.5 then
					d.jam = 0
					d.x, d.y = 0.2 + math.random() * 0.6, 0.2 + math.random() * 0.6
					d.vx = (math.random() - 0.5) * speed
					d.vy = (math.random() - 0.5) * speed
					d.px, d.py = d.x * w, d.y * h
					d.hit = false
				end
			else
				d.jam = 0
			end

			d.o.Position = UDim2.fromOffset(d.px, d.py)
			d.o.BackgroundTransparency = d.base + (1 - d.base) * api.veil
		end

		for i = 1, count do
			local a = dots[i]
			local row = link[i]

			for j = i + 1, count do
				local b = dots[j]

				put(row[j], a.px, a.py, b.px, b.py, span)
			end

			local best, bx, by = math.huge, 0, 0

			if not a.hit then
				for _, p in next, pts do
					local dx, dy = p[1] - a.px, p[2] - a.py
					local d2 = dx * dx + dy * dy

					if d2 < best then
						best, bx, by = d2, p[1], p[2]
					end
				end
			end

			if best < math.huge then
				put(hook[i], a.px, a.py, bx, by, span * 0.8)
			elseif hook[i].Visible then
				hook[i].Visible = false
			end
		end
	end)

	function api:mark(o)
		table.insert(api.marks, o)
	end

	return api
end

local function params(cfg, def)
	cfg = cfg or {}
	for k, v in next, def do
		if cfg[k] == nil then
			cfg[k] = v
		end
	end
	return cfg
end

shitaroebet.logo = asset({ "logous.png", "assets/logous.png", "shitaroebet/logous.png" })

local scr = new("ScreenGui", {
	Name = rnd(),
	IgnoreGuiInset = true,
	ResetOnSpawn = false,
	ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
	DisplayOrder = 1000,
})

pcall(prot, scr)

local attached = pcall(function() scr.Parent = hui end)

if not attached or not scr.Parent then
	pcall(function() scr.Parent = lp:WaitForChild("PlayerGui") end)
end

shitaroebet.scr = scr

local flock = {}

conn(scr.DescendantAdded, function(o)
	if o:IsA("GuiObject") or o:IsA("UIStroke") or o:IsA("UIShadow") then
		table.insert(flock, o)
	end
end)

function shitaroebet:recolor(key, c)
	local old = shitaroebet.theme[key]

	if typeof(c) ~= "Color3" or typeof(old) ~= "Color3" or c == old then
		return
	end

	shitaroebet.theme[key] = c

	for i = #flock, 1, -1 do
		local o = flock[i]

		if not o.Parent then
			table.remove(flock, i)
		elseif o:IsA("UIStroke") or o:IsA("UIShadow") then
			if o.Color == old then
				o.Color = c
			end
		else
			if o.BackgroundColor3 == old then
				o.BackgroundColor3 = c
			end

			if o:IsA("TextLabel") or o:IsA("TextButton") or o:IsA("TextBox") then
				if o.TextColor3 == old then
					o.TextColor3 = c
				end
			elseif o:IsA("ImageLabel") or o:IsA("ImageButton") then
				if o.ImageColor3 == old then
					o.ImageColor3 = c
				end
			end
		end
	end
end

shitaroebet.dir = "shitarocfgs"
shitaroebet.pool = {}
shitaroebet.order = {}
shitaroebet.alive = true

local abc = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/"
local rev = {}

for i = 1, 64 do
	rev[string.sub(abc, i, i)] = i - 1
end

local salt = "sh1t4r0::cfg::v1"

local function mask(raw)
	local out = table.create(#raw)

	for i = 1, #raw do
		local k = (string.byte(salt, (i - 1) % #salt + 1) + i * 31 + 91) % 256

		out[i] = string.char(bit32.bxor(string.byte(raw, i), k))
	end

	return table.concat(out)
end

local function pack(raw)
	local out = {}
	local i = 1

	while i <= #raw do
		local a = string.byte(raw, i)
		local b = string.byte(raw, i + 1)
		local c = string.byte(raw, i + 2)
		local v = a * 65536 + (b or 0) * 256 + (c or 0)
		local q = { math.floor(v / 262144) % 64, math.floor(v / 4096) % 64, math.floor(v / 64) % 64, v % 64 }

		out[#out + 1] = string.sub(abc, q[1] + 1, q[1] + 1)
		out[#out + 1] = string.sub(abc, q[2] + 1, q[2] + 1)
		out[#out + 1] = b and string.sub(abc, q[3] + 1, q[3] + 1) or "="
		out[#out + 1] = c and string.sub(abc, q[4] + 1, q[4] + 1) or "="

		i = i + 3
	end

	return table.concat(out)
end

local function peel(txt)
	txt = string.gsub(txt, "[^%w%+/=]", "")

	local out = {}
	local i = 1

	while i < #txt do
		local v, gap = 0, 0

		for j = 0, 3 do
			local ch = string.sub(txt, i + j, i + j)

			if ch == "=" or ch == "" then
				v = v * 64
				gap = gap + 1
			else
				v = v * 64 + (rev[ch] or 0)
			end
		end

		out[#out + 1] = string.char(math.floor(v / 65536) % 256)

		if gap < 2 then
			out[#out + 1] = string.char(math.floor(v / 256) % 256)
		end

		if gap < 1 then
			out[#out + 1] = string.char(v % 256)
		end

		i = i + 4
	end

	return table.concat(out)
end

local function esc(s)
	return (string.gsub(tostring(s), "[%%\1\2\r\n]", function(ch)
		return string.format("%%%02X", string.byte(ch))
	end))
end

local function unesc(s)
	return (string.gsub(s, "%%(%x%x)", function(h)
		return string.char(tonumber(h, 16))
	end))
end

local function slap(fn, ...)
	if type(fn) ~= "function" then
		return nil
	end

	local ok, res = pcall(fn, ...)

	if ok then
		return res
	end
end

local function vault()
	if type(isfolder) ~= "function" or type(makefolder) ~= "function" then
		return false
	end

	if not slap(isfolder, shitaroebet.dir) then
		slap(makefolder, shitaroebet.dir)
	end

	return slap(isfolder, shitaroebet.dir) and true or false
end

local function tidy(name)
	if type(name) ~= "string" then
		return nil
	end

	name = string.gsub(name, "[^%w%s%-_%.]", "")
	name = string.match(name, "^%s*(.-)%s*$") or ""

	if #name == 0 or #name > 32 then
		return nil
	end

	return name
end

local function slot(name)
	return shitaroebet.dir .. "/" .. name .. ".yan"
end

function shitaroebet:hook(id, kind, get, set)
	if type(id) ~= "string" or id == "" then
		return
	end

	if not shitaroebet.pool[id] then
		table.insert(shitaroebet.order, id)
	end

	shitaroebet.pool[id] = { kind = kind, get = get, set = set }
end

function shitaroebet:unhook(id)
	if type(id) ~= "string" or not shitaroebet.pool[id] then
		return
	end

	shitaroebet.pool[id] = nil

	local at = table.find(shitaroebet.order, id)

	if at then
		table.remove(shitaroebet.order, at)
	end
end

function shitaroebet:freeze()
	local rows = {}

	for _, id in next, shitaroebet.order do
		local e = shitaroebet.pool[id]

		if e then
			local v = slap(e.get)
			local t = nil

			if typeof(v) == "Color3" then
				t, v = "c", hexof(v)
			elseif type(v) == "boolean" then
				t, v = "b", v and "1" or "0"
			elseif type(v) == "number" then
				t, v = "n", tostring(v)
			elseif type(v) == "string" then
				t = "s"
			end

			if t then
				rows[#rows + 1] = "f\1" .. esc(id) .. "\1" .. t .. "\1" .. esc(v)
			end
		end
	end

	for k, v in next, shitaroebet.theme do
		if typeof(v) == "Color3" then
			rows[#rows + 1] = "t\1" .. esc(k) .. "\1c\1" .. hexof(v)
		end
	end

	return "SHC1" .. pack(mask(table.concat(rows, "\2")))
end

function shitaroebet:thaw(blob)
	if type(blob) ~= "string" or string.sub(blob, 1, 4) ~= "SHC1" then
		return nil
	end

	local raw = mask(peel(string.sub(blob, 5)))
	local flags, tint = {}, {}

	for chunk in string.gmatch(raw, "[^\2]+") do
		local kind, id, t, v = string.match(chunk, "^(%a)\1([^\1]*)\1(%a)\1(.*)$")

		if kind then
			id = unesc(id)
			v = unesc(v)

			if t == "b" then
				v = v == "1"
			elseif t == "n" then
				v = tonumber(v)
			end

			if v ~= nil then
				if kind == "f" then
					flags[id] = v
				elseif kind == "t" then
					tint[id] = v
				end
			end
		end
	end

	return { flags = flags, theme = tint }
end

function shitaroebet:apply(data)
	if type(data) ~= "table" then
		return false
	end

	shitaroebet.quiet = true

	if type(data.theme) == "table" then
		for k, v in next, data.theme do
			local c = fromhex(v)

			if c and not shitaroebet.pool["theme|" .. k] then
				shitaroebet:recolor(k, c)
			end
		end
	end

	if type(data.flags) == "table" then
		for _, id in next, shitaroebet.order do
			local e = shitaroebet.pool[id]
			local v = data.flags[id]

			if e and v ~= nil then
				slap(e.set, v)
			end
		end
	end

	shitaroebet.quiet = false

	return true
end

function shitaroebet:roster()
	local out = {}

	if type(listfiles) ~= "function" or not vault() then
		return out
	end

	for _, f in next, slap(listfiles, shitaroebet.dir) or {} do
		local nm = string.match(string.gsub(tostring(f), "\\", "/"), "([^/]+)%.yan$")

		if nm then
			table.insert(out, nm)
		end
	end

	table.sort(out, function(a, b)
		return string.lower(a) < string.lower(b)
	end)

	return out
end

function shitaroebet:store(name)
	name = tidy(name)

	if not name or type(writefile) ~= "function" or not vault() then
		return nil
	end

	local ok, blob = pcall(shitaroebet.freeze, shitaroebet)

	if not ok or type(blob) ~= "string" then
		return nil
	end

	if not pcall(writefile, slot(name), blob) then
		return nil
	end

	return name
end

function shitaroebet:fetch(name)
	name = tidy(name)

	if not name or type(readfile) ~= "function" then
		return nil
	end

	local ok, blob = pcall(readfile, slot(name))

	if not ok or type(blob) ~= "string" then
		return nil
	end

	local fine, data = pcall(shitaroebet.thaw, shitaroebet, blob)

	if not fine or not data then
		return nil
	end

	return shitaroebet:apply(data) and name or nil
end

function shitaroebet:erase(name)
	name = tidy(name)

	local kill = delfile or delete_file

	if not name or type(kill) ~= "function" then
		return nil
	end

	if not pcall(kill, slot(name)) then
		return nil
	end

	return name
end

function shitaroebet:retitle(from, to)
	from, to = tidy(from), tidy(to)

	if not from or not to or type(readfile) ~= "function" or type(writefile) ~= "function" then
		return nil
	end

	if from == to then
		return to
	end

	local ok, blob = pcall(readfile, slot(from))

	if not ok or type(blob) ~= "string" then
		return nil
	end

	if not pcall(writefile, slot(to), blob) then
		return nil
	end

	shitaroebet:erase(from)

	return to
end

local eyes = {}
local stamp = nil

local function sweep()
	local ls = shitaroebet:roster()
	local sig = table.concat(ls, "\1")

	if sig == stamp then
		return
	end

	stamp = sig

	for _, fn in next, eyes do
		task.spawn(fn, ls)
	end
end

function shitaroebet:watch(fn)
	local ls = shitaroebet:roster()

	stamp = table.concat(ls, "\1")

	table.insert(eyes, fn)

	task.spawn(fn, ls)
end

task.spawn(function()
	while shitaroebet.alive do
		task.wait(1.25)

		if #eyes > 0 then
			sweep()
		end
	end
end)

shitaroebet.shown = false

local reel = {
	Click = "click",
	Bubble = "bubble",
	Hentai = "hentai1",
}

shitaroebet.tonelist = { "Click", "Bubble", "Hentai" }
shitaroebet.tones = {}
shitaroebet.tone = "Click"
shitaroebet.sound = false

local spare = "rbxasset://sounds/electronicpingshort.wav"
local barns = { "shitaroebet/", "shitarosnd/", "assets/", "" }
local looked = {}

local function lift(file)
	if type(isfile) == "function" and type(getcustomasset) == "function" then
		for _, dir in next, barns do
			for _, ext in next, { ".mp3", ".wav", ".ogg" } do
				local p = dir .. file .. ext

				if slap(isfile, p) then
					local asset = slap(getcustomasset, p)

					if type(asset) == "string" and asset ~= "" then
						return asset
					end
				end
			end
		end
	end

	for _, entry in next, pulllist("") do
		local stem, ext = string.match(entry, "^([^/]+)(%.[^%.]+)$")

		if stem == file and (ext == ".mp3" or ext == ".wav" or ext == ".ogg") then
			local got = pullasset(entry)

			if got then
				return got
			end
		end
	end
end

local function seek(name)
	if looked[name] ~= nil then
		return looked[name] or nil
	end

	local file = reel[name]
	local got = file and lift(file) or nil

	looked[name] = got or false

	return got
end

local bells = {}
local turnbell = 0

for i = 1, 4 do
	bells[i] = new("Sound", {
		Name = rnd(),
		SoundId = spare,
		Volume = 0.34,
	}, scr)
end

local grades = {
	on = { 1.08, 0.4 },
	off = { 0.86, 0.34 },
	tab = { 1, 0.32 },
	flip = { 1.18, 0.22 },
	open = { 0.8, 0.42 },
	close = { 1.32, 0.3 },
	tap = { 1.22, 0.26 },
}

function shitaroebet:chime(kind)
	if not shitaroebet.sound or shitaroebet.quiet then
		return
	end

	local g = grades[kind] or grades.tap

	turnbell = turnbell % #bells + 1

	local s = bells[turnbell]

	s.PlaybackSpeed = g[1]
	s.Volume = g[2]
	s.TimePosition = 0

	pcall(s.Play, s)
end

local function stock(id)
	for _, s in next, bells do
		if s.SoundId ~= id then
			s.SoundId = id
		end
	end
end

function shitaroebet:settone(name)
	if not reel[name] then
		return
	end

	shitaroebet.tone = name

	local set = shitaroebet.tones[name]

	if set then
		stock(set)

		return
	end

	task.spawn(function()
		local got = seek(name)

		if shitaroebet.tone ~= name then
			return
		end

		shitaroebet.tones[name] = got or spare

		stock(shitaroebet.tones[name])
	end)
end

function shitaroebet:setsound(v)
	shitaroebet.sound = v and true or false
end

shitaroebet.cursors = {}
shitaroebet.cursorlist = {}
shitaroebet.style = nil
shitaroebet.cursor = false

for _, entry in next, pulllist("cursors/") do
	local nm = string.match(entry, "([^/]+)%.png$")

	if nm and not shitaroebet.cursors[nm] then
		local got = pullasset(entry)

		if got then
			shitaroebet.cursors[nm] = got

			table.insert(shitaroebet.cursorlist, nm)
		end
	end
end

for _, dir in next, { "shitaroebet/cursors", "cursors" } do
	if slap(isfolder, dir) and type(listfiles) == "function" and type(getcustomasset) == "function" then
		for _, f in next, slap(listfiles, dir) or {} do
			local nm = string.match(string.gsub(tostring(f), "\\", "/"), "([^/]+)%.png$")

			if nm and not shitaroebet.cursors[nm] then
				local asset = slap(getcustomasset, dir .. "/" .. nm .. ".png")

				if type(asset) == "string" and asset ~= "" then
					shitaroebet.cursors[nm] = asset

					table.insert(shitaroebet.cursorlist, nm)
				end
			end
		end
	end
end

table.sort(shitaroebet.cursorlist, function(a, b)
	return string.lower(a) < string.lower(b)
end)

shitaroebet.style = shitaroebet.cursorlist[1]

local claw = new("ImageLabel", {
	Name = rnd(),
	AnchorPoint = Vector2.new(0.5, 0.5),
	Size = UDim2.fromOffset(64, 64),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Image = "",
	ScaleType = Enum.ScaleType.Stretch,
	Visible = false,
	ZIndex = 2147483647,
}, scr)

pcall(function()
	claw.ResampleMode = Enum.ResamplerMode.Pixelated
end)

local leash = nil
local kept = nil

local function trace()
	local p = uis:GetMouseLocation()

	claw.Position = UDim2.fromOffset(p.X, p.Y)

	if uis.MouseIconEnabled then
		uis.MouseIconEnabled = false
	end
end

local function rouse()
	local art = shitaroebet.cursors[shitaroebet.style]
	local go = shitaroebet.cursor and shitaroebet.shown and not shitaroebet.mobile and art ~= nil

	if go == (leash ~= nil) then
		if go then
			claw.Image = art
		end

		return
	end

	if go then
		kept = uis.MouseIconEnabled
		claw.Image = art

		trace()

		claw.Visible = true
		leash = rs.RenderStepped:Connect(trace)

		return
	end

	leash:Disconnect()
	leash = nil

	claw.Visible = false

	if kept ~= nil then
		uis.MouseIconEnabled = kept
		kept = nil
	end
end

function shitaroebet:setstyle(name)
	if not shitaroebet.cursors[name] then
		return
	end

	shitaroebet.style = name

	rouse()
end

function shitaroebet:setcursor(v)
	shitaroebet.cursor = v and true or false

	rouse()
end

function shitaroebet:wake()
	rouse()
end

local th = shitaroebet.theme

local ear, quit = nil, nil

local function capture(fn, off)
	if quit then
		local prev = quit

		quit = nil

		prev()
	end

	if ear then
		ear:Disconnect()
		ear = nil
	end

	if not fn then
		shitaroebet.capturing = false

		return
	end

	quit = off
	shitaroebet.capturing = true

	ear = uis.InputBegan:Connect(function(i)
		if i.UserInputType ~= Enum.UserInputType.Keyboard or i.KeyCode == Enum.KeyCode.Unknown then
			return
		end

		local k = i.KeyCode

		quit = nil

		capture(nil)

		fn(k ~= Enum.KeyCode.Escape and k or nil)
	end)
end

shitaroebet.hotkeys = true

local hive = {}

local function hush(skip)
	for i = #hive, 1, -1 do
		local bd = hive[i]

		if bd ~= skip then
			bd:setopen(false)
		end
	end
end

local function gauge(txt, size)
	local ok, sz = pcall(function()
		return txs:GetTextSize(txt, size, Enum.Font.GothamBold, Vector2.new(9e9, 9e9))
	end)

	if ok and sz then
		return math.ceil(sz.X)
	end

	return math.ceil(#tostring(txt) * size * 0.6)
end

local deep = pcall(Instance.new, "UIShadow")

local hutch = new("CanvasGroup", {
	Name = rnd(),
	AnchorPoint = Vector2.new(0, 0.5),
	Position = UDim2.new(0, 8, 0.5, 0),
	Size = UDim2.fromOffset(0, 0),
	AutomaticSize = Enum.AutomaticSize.XY,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ZIndex = 900,
}, scr)

new("UIListLayout", {
	FillDirection = Enum.FillDirection.Vertical,
	HorizontalAlignment = Enum.HorizontalAlignment.Left,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 3),
}, hutch)

new("UIPadding", {
	PaddingTop = UDim.new(0, 10),
	PaddingBottom = UDim.new(0, 10),
	PaddingLeft = UDim.new(0, 10),
	PaddingRight = UDim.new(0, 10),
}, hutch)

hutch.Visible = false
hutch.GroupTransparency = 1

shrink(hutch)

local function plate(parent, order, pad, gap, lift)
	local card = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromOffset(0, 0),
		BackgroundColor3 = th.panel,
		BackgroundTransparency = 0.16,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		LayoutOrder = order,
		ZIndex = 2,
	}, parent)

	round(card, 8)

	local edge = new("UIStroke", {
		Color = th.line,
		Thickness = 1,
		Transparency = 0.45,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		LineJoinMode = Enum.LineJoinMode.Round,
	}, card)

	if lift and deep then
		new("UIShadow", {
			Color = th.bg,
			BlurRadius = UDim.new(0, lift),
			Offset = UDim2.fromOffset(0, 2),
			Spread = UDim2.fromOffset(-2, -2),
			Transparency = 0.6,
			ZIndex = -1,
		}, card)
	end

	local skin = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = th.glow,
		BackgroundTransparency = 0.82,
		BorderSizePixel = 0,
		ZIndex = 2,
	}, card)

	round(skin, 8)

	fade(skin, 90, {
		NumberSequenceKeypoint.new(0, 0.5),
		NumberSequenceKeypoint.new(0.6, 0.82),
		NumberSequenceKeypoint.new(1, 0.9),
	})

	local gloss = new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 1),
		Size = UDim2.new(1, -14, 0, 1),
		BackgroundColor3 = th.glow,
		BackgroundTransparency = 0.7,
		BorderSizePixel = 0,
		ZIndex = 3,
	}, card)

	fade(gloss, 0, {
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0.1),
		NumberSequenceKeypoint.new(1, 1),
	})

	local hold = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 3,
	}, card)

	if pad then
		new("UIPadding", {
			PaddingLeft = UDim.new(0, pad),
			PaddingRight = UDim.new(0, pad),
		}, hold)
	end

	if gap then
		new("UIListLayout", {
			FillDirection = Enum.FillDirection.Horizontal,
			HorizontalAlignment = Enum.HorizontalAlignment.Center,
			VerticalAlignment = Enum.VerticalAlignment.Center,
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, gap),
		}, hold)
	end

	return card, edge, skin, hold
end

local crown, crownedge, crownskin, crownhold = plate(hutch, 0, 14, 8, 10)

crown.Active = true

local crownart = new("ImageLabel", {
	Name = rnd(),
	Size = UDim2.fromOffset(17, 17),
	BackgroundTransparency = 1,
	Image = icon("keyboard"),
	ImageColor3 = th.dim,
	ImageTransparency = 0,
	LayoutOrder = 1,
	ScaleType = Enum.ScaleType.Fit,
	ZIndex = 4,
}, crownhold)

local crowntag = new("TextLabel", {
	Name = rnd(),
	AutomaticSize = Enum.AutomaticSize.X,
	Size = UDim2.fromOffset(0, 20),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamMedium,
	Text = "hotkeys",
	TextColor3 = th.text,
	TextSize = 14,
	LayoutOrder = 2,
	ZIndex = 4,
}, crownhold)

local brief = 53 + gauge("hotkeys", 14)

drag(crown, hutch, 0.12)

local roost, ranks = {}, {}
local aired, span = false, nil

local function crest()
	local wide = brief

	for i = 1, #ranks do
		local p = roost[ranks[i]]

		if p and p.span and p.span > wide then
			wide = p.span
		end
	end

	if wide == span then
		return
	end

	if span == nil then
		span = wide
		crown.Size = UDim2.fromOffset(wide, 36)

		return
	end

	span = wide

	anim(crown, soft, { Size = UDim2.fromOffset(wide, 36) })
end

local function sort()
	table.sort(ranks, function(a, b)
		local pa, pb = roost[a], roost[b]

		if not pa or not pb then
			return false
		end

		if pa.tw ~= pb.tw then
			return pa.tw < pb.tw
		end

		return pa.name < pb.name
	end)

	for i = 1, #ranks do
		local p = roost[ranks[i]]

		if p then
			p.row.LayoutOrder = i
		end
	end
end

local function air()
	local want = shitaroebet.hotkeys and #ranks > 0

	if want == aired then
		return
	end

	aired = want

	crest()

	if want then
		hutch.Visible = true
	end

	local from = hutch.GroupTransparency
	local to = want and 0 or 1

	flow(hutch, want and 0.3 or 0.22, want and outq or inq, function(k)
		hutch.GroupTransparency = from + (to - from) * k

		if k >= 1 and not aired then
			hutch.Visible = false
		end
	end)
end

local function knob(p, on)
	on = on and true or false

	if not p.rail or p.on == on then
		return
	end

	p.on = on

	anim(p.rail, soft, { BackgroundColor3 = on and th.accent or th.bg })
	anim(p.bead, soft, {
		Position = UDim2.new(on and 0.68 or 0.32, 0, 0.5, 0),
		BackgroundColor3 = on and th.bg or Color3.new(1, 1, 1),
		BackgroundTransparency = on and 0 or 0.45,
	})
end

local function tally(p)
	local wide = 28 + p.tw

	if p.worth then
		wide = wide + p.vw + 10
	end

	local slim = math.max(24 + p.kw, 32)

	if wide == p.iw and slim == p.kwide then
		return
	end

	p.iw = wide
	p.kwide = slim
	p.span = wide + 5 + slim + (p.tumb and 37 or 0) + 4

	if p.born then
		anim(p.info, soft, { Size = UDim2.fromOffset(wide, 32) })
		anim(p.cue, soft, { Size = UDim2.fromOffset(slim, 32) })
		anim(p.row, soft, { Size = UDim2.fromOffset(p.span, 36) })
	else
		p.info.Size = UDim2.fromOffset(wide, 32)
		p.cue.Size = UDim2.fromOffset(slim, 32)
		p.row.Size = UDim2.fromOffset(p.span, 36)
	end
end

local function dawn(p)
	if p.gone or p.open then
		return
	end

	p.open = true

	p.row.Visible = true

	local from = p.row.GroupTransparency

	flow(p.row, 0.28, outq, function(k)
		p.row.GroupTransparency = from * (1 - k)
	end)
end

local function dusk(p, kill)
	if p.gone or (not p.open and not kill) then
		return
	end

	p.gone = kill and true or false
	p.open = false

	local from = p.row.GroupTransparency

	flow(p.row, 0.22, inq, function(k)
		p.row.GroupTransparency = from + (1 - from) * k

		if k < 1 then
			return
		end

		if p.gone then
			if p.row and p.row.Parent then
				p.row:Destroy()
			end

			return
		end

		p.row.Visible = false
	end)
end

local function perch(id, spec)
	local p = roost[id]

	if p then
		p.name = spec.name
		p.tw = gauge(spec.name, 14)
		p.kw = gauge(spec.key, 14)

		p.tag.Text = spec.name
		p.keyl.Text = spec.key

		if p.worth then
			p.worth.Text = spec.worth or ""
			p.vw = gauge(p.worth.Text, 14)
		end

		tally(p)
		knob(p, spec.lit)
		sort()
		crest()
		dawn(p)

		return
	end

	p = { name = spec.name, tw = gauge(spec.name, 14), kw = gauge(spec.key, 14), vw = 0 }

	p.row = new("CanvasGroup", {
		Name = rnd(),
		Size = UDim2.fromOffset(0, 36),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		GroupTransparency = 1,
		Visible = false,
		ZIndex = 2,
	}, hutch)

	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 5),
	}, p.row)

	new("UIPadding", {
		PaddingTop = UDim.new(0, 2),
		PaddingBottom = UDim.new(0, 2),
		PaddingLeft = UDim.new(0, 2),
		PaddingRight = UDim.new(0, 2),
	}, p.row)

	if spec.art then
		p.tumb, p.tumbedge, p.tumbskin = plate(p.row, 1)

		p.tumb.Size = UDim2.fromOffset(32, 32)

		p.rail = new("Frame", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(24, 13),
			BackgroundColor3 = th.bg,
			BorderSizePixel = 0,
			ZIndex = 4,
		}, p.tumb)

		new("UICorner", { CornerRadius = UDim.new(1, 0) }, p.rail)

		p.bead = new("Frame", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.new(0.3, 0, 0.5, 0),
			Size = UDim2.fromOffset(9, 9),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BackgroundTransparency = 0.45,
			BorderSizePixel = 0,
			ZIndex = 5,
		}, p.rail)

		new("UICorner", { CornerRadius = UDim.new(1, 0) }, p.bead)

		if spec.press then
			p.hit = new("ImageButton", {
				Name = rnd(),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ImageTransparency = 1,
				ZIndex = 6,
			}, p.tumb)

			conn(p.hit.MouseButton1Click, function()
				spec.press()
			end)
		end
	end

	local hold

	p.info, p.infoedge, p.infoskin, hold = plate(p.row, 2, 14, 10)

	p.tag = new("TextLabel", {
		Name = rnd(),
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.fromOffset(0, 20),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		Text = spec.name,
		TextColor3 = th.text,
		TextSize = 14,
		TextTransparency = 0.05,
		LayoutOrder = 1,
		ZIndex = 4,
	}, hold)

	if spec.worth then
		p.worth = new("TextLabel", {
			Name = rnd(),
			AutomaticSize = Enum.AutomaticSize.X,
			Size = UDim2.fromOffset(0, 20),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamMedium,
			Text = spec.worth,
			TextColor3 = th.dim,
			TextSize = 14,
			TextTransparency = 0.25,
			LayoutOrder = 2,
			ZIndex = 4,
		}, hold)

		p.vw = gauge(spec.worth, 14)
	end

	local perchhold

	p.cue, p.cueedge, p.cueskin, perchhold = plate(p.row, 3, 12, 0)

	p.keyl = new("TextLabel", {
		Name = rnd(),
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.fromOffset(0, 20),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		Text = spec.key,
		TextColor3 = th.accent,
		TextSize = 14,
		TextTransparency = 0.1,
		LayoutOrder = 1,
		ZIndex = 4,
	}, perchhold)

	roost[id] = p

	table.insert(ranks, id)

	tally(p)
	knob(p, spec.lit)
	sort()
	air()
	crest()

	p.born = true

	task.spawn(function()
		rs.Heartbeat:Wait()

		if p.row.Parent then
			dawn(p)
		end
	end)
end

local function unperch(id)
	local p = roost[id]

	if not p then
		return
	end

	roost[id] = nil

	local at = table.find(ranks, id)

	if at then
		table.remove(ranks, at)
	end

	sort()
	air()
	crest()
	dusk(p, true)
end

local function relight(id, lit)
	local p = roost[id]

	if p then
		knob(p, lit)
	end
end

function overkeys()
	return inside(hutch, 6)
end

function shitaroebet:sethotkeys(v)
	shitaroebet.hotkeys = v and true or false

	air()
end

function shitaroebet:hotkeyspot(v)
	if typeof(v) == "UDim2" then
		hutch.Position = v
	end
end

crest()

shitaroebet.watermark = true

local function spotof(v)
	return string.format(
		"%.4f,%d,%.4f,%d",
		v.X.Scale,
		math.floor(v.X.Offset + 0.5),
		v.Y.Scale,
		math.floor(v.Y.Offset + 0.5)
	)
end

local function readspot(v)
	if type(v) ~= "string" then
		return nil
	end

	local xs, xo, ys, yo = string.match(v, "^(-?[%d%.]+),(-?%d+),(-?[%d%.]+),(-?%d+)$")

	if not xs then
		return nil
	end

	return UDim2.new(tonumber(xs), tonumber(xo), tonumber(ys), tonumber(yo))
end

local nest = new("CanvasGroup", {
	Name = rnd(),
	AnchorPoint = Vector2.new(1, 0),
	Position = UDim2.new(1, -8, 0, 8),
	Size = UDim2.fromOffset(0, 0),
	AutomaticSize = Enum.AutomaticSize.XY,
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	ZIndex = 900,
}, scr)

new("UIListLayout", {
	FillDirection = Enum.FillDirection.Horizontal,
	HorizontalAlignment = Enum.HorizontalAlignment.Right,
	VerticalAlignment = Enum.VerticalAlignment.Center,
	SortOrder = Enum.SortOrder.LayoutOrder,
	Padding = UDim.new(0, 8),
}, nest)

new("UIPadding", {
	PaddingTop = UDim.new(0, 10),
	PaddingBottom = UDim.new(0, 10),
	PaddingLeft = UDim.new(0, 10),
	PaddingRight = UDim.new(0, 10),
}, nest)

nest.Visible = false
nest.GroupTransparency = 1

shrink(nest)

local function pod(order, pad, gap)
	local card = new("Frame", {
		Name = rnd(),
		Active = true,
		Size = UDim2.fromOffset(0, 30),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundColor3 = th.panel,
		BackgroundTransparency = 0.16,
		BorderSizePixel = 0,
		LayoutOrder = order,
		ZIndex = 2,
	}, nest)

	round(card, 8)

	new("UIStroke", {
		Color = th.line,
		Thickness = 1,
		Transparency = 0.45,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		LineJoinMode = Enum.LineJoinMode.Round,
	}, card)

	if deep then
		new("UIShadow", {
			Color = th.bg,
			BlurRadius = UDim.new(0, 10),
			Offset = UDim2.fromOffset(0, 2),
			Spread = UDim2.fromOffset(-2, -2),
			Transparency = 0.6,
			ZIndex = -1,
		}, card)
	end

	local skin = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = th.glow,
		BackgroundTransparency = 0.82,
		BorderSizePixel = 0,
		ZIndex = 2,
	}, card)

	round(skin, 8)

	fade(skin, 90, {
		NumberSequenceKeypoint.new(0, 0.5),
		NumberSequenceKeypoint.new(0.6, 0.82),
		NumberSequenceKeypoint.new(1, 0.9),
	})

	local gloss = new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 1),
		Size = UDim2.new(1, -14, 0, 1),
		BackgroundColor3 = th.glow,
		BackgroundTransparency = 0.7,
		BorderSizePixel = 0,
		ZIndex = 3,
	}, card)

	fade(gloss, 0, {
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0.1),
		NumberSequenceKeypoint.new(1, 1),
	})

	local hold = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromOffset(0, 30),
		AutomaticSize = Enum.AutomaticSize.X,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 3,
	}, card)

	new("UIPadding", {
		PaddingLeft = UDim.new(0, pad),
		PaddingRight = UDim.new(0, pad),
	}, hold)

	new("UIListLayout", {
		FillDirection = Enum.FillDirection.Horizontal,
		VerticalAlignment = Enum.VerticalAlignment.Center,
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, gap),
	}, hold)

	drag(card, nest, 0.12)

	return card, hold
end

local badge, badgehold = pod(1, 13, 8)

new("ImageLabel", {
	Name = rnd(),
	Size = UDim2.fromOffset(16, 16),
	BackgroundTransparency = 1,
	Image = icon("code"),
	ImageColor3 = th.dim,
	ImageTransparency = 0,
	LayoutOrder = 1,
	ScaleType = Enum.ScaleType.Fit,
	ZIndex = 4,
}, badgehold)

new("TextLabel", {
	Name = rnd(),
	AutomaticSize = Enum.AutomaticSize.X,
	Size = UDim2.fromOffset(0, 20),
	BackgroundTransparency = 1,
	Font = Enum.Font.GothamMedium,
	Text = "shitaro.lol",
	TextColor3 = th.text,
	TextSize = 14,
	TextTransparency = 0.05,
	LayoutOrder = 2,
	ZIndex = 4,
}, badgehold)

local stat, stathold = pod(2, 13, 8)

local face = new("ImageLabel", {
	Name = rnd(),
	Size = UDim2.fromOffset(22, 22),
	BackgroundColor3 = th.bg,
	BackgroundTransparency = 0.3,
	BorderSizePixel = 0,
	Image = shitaroebet.logo ~= "" and shitaroebet.logo
		or string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", lp.UserId),
	ImageTransparency = 0.02,
	LayoutOrder = 10,
	ScaleType = Enum.ScaleType.Crop,
	ZIndex = 4,
}, stathold)

new("UICorner", { CornerRadius = UDim.new(1, 0) }, face)

new("UIStroke", {
	Color = th.line,
	Thickness = 1,
	Transparency = 0.35,
	ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
}, face)

local function chip(order, art, txt, lead)
	if not lead then
		local rail = new("Frame", {
			Name = rnd(),
			Size = UDim2.fromOffset(14, 16),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			LayoutOrder = order,
			ZIndex = 4,
		}, stathold)

		local line = new("Frame", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.fromOffset(1, 16),
			BackgroundColor3 = th.glow,
			BackgroundTransparency = 0.62,
			BorderSizePixel = 0,
			ZIndex = 4,
		}, rail)

		fade(line, 90, {
			NumberSequenceKeypoint.new(0, 0.85),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(1, 0.85),
		})
	end

	if art then
		new("ImageLabel", {
			Name = rnd(),
			Size = UDim2.fromOffset(15, 15),
			BackgroundTransparency = 1,
			Image = icon(art),
			ImageColor3 = th.text,
			ImageTransparency = 0.25,
			LayoutOrder = order + 1,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 4,
		}, stathold)
	end

	return new("TextLabel", {
		Name = rnd(),
		AutomaticSize = Enum.AutomaticSize.X,
		Size = UDim2.fromOffset(0, 20),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		Text = txt,
		TextColor3 = th.text,
		TextSize = 14,
		TextTransparency = 0.05,
		LayoutOrder = order + 2,
		ZIndex = 4,
	}, stathold)
end

local whotag = chip(20, nil, lp.Name, true)
local ratetag = chip(30, "layers", "0")
local lagtag = chip(40, "wifi", "0ms")
local timetag = chip(50, "clock", "00:00")

for tag, wide in next, {
	[ratetag] = gauge("999", 14),
	[lagtag] = gauge("999ms", 14),
	[timetag] = gauge("00:00", 14),
} do
	tag.AutomaticSize = Enum.AutomaticSize.None
	tag.Size = UDim2.fromOffset(wide, 20)
	tag.TextXAlignment = Enum.TextXAlignment.Left
end

local keyszone = overkeys

function overkeys()
	return (keyszone and keyszone()) or inside(nest, 6)
end

local marked = false

local function flare()
	local want = shitaroebet.watermark and true or false

	if want == marked then
		return
	end

	marked = want

	if want then
		nest.Visible = true
	end

	local from = nest.GroupTransparency
	local to = want and 0 or 1

	flow(nest, want and 0.3 or 0.22, want and outq or inq, function(k)
		nest.GroupTransparency = from + (to - from) * k

		if k >= 1 and not marked then
			nest.Visible = false
		end
	end)
end

local meter = nil

pcall(function()
	meter = cloneref(game:GetService("Stats"))
end)

local function lagof()
	if not meter then
		return 0
	end

	local ok, v = pcall(function()
		return meter.Network.ServerStatsItem["Data Ping"]:GetValue()
	end)

	if not ok or type(v) ~= "number" then
		return 0
	end

	return math.floor(v + 0.5)
end

local beats, drift = 0, 0

conn(rs.RenderStepped, function(dt)
	beats += 1
	drift += dt

	if drift < 0.5 then
		return
	end

	local rate = math.floor(beats / drift + 0.5)

	beats, drift = 0, 0

	if not nest.Visible then
		return
	end

	if whotag.Text ~= lp.Name then
		whotag.Text = lp.Name
	end

	ratetag.Text = tostring(rate)
	lagtag.Text = tostring(lagof()) .. "ms"
	timetag.Text = os.date("%H:%M")
end)

shitaroebet:hook("menu|hotkeyspot", "string", function()
	return spotof(hutch.Position)
end, function(v)
	local p = readspot(v)

	if p then
		hutch.Position = p
	end
end)

shitaroebet:hook("menu|markspot2", "string", function()
	return spotof(nest.Position)
end, function(v)
	local p = readspot(v)

	if p then
		nest.Position = p
	end
end)

function shitaroebet:setwatermark(v)
	shitaroebet.watermark = v and true or false

	flare()
end

function shitaroebet:watermarkspot(v)
	if typeof(v) == "UDim2" then
		nest.Position = v
	end
end

timetag.Text = os.date("%H:%M")

flare()

shitaroebet.opener = shitaroebet.mobile

local knock = new("ImageButton", {
	Name = rnd(),
	AnchorPoint = Vector2.new(1, 0.5),
	Position = UDim2.new(1, -10, 0.5, 0),
	Size = UDim2.fromOffset(54, 54),
	BackgroundTransparency = 1,
	BorderSizePixel = 0,
	Image = shitaroebet.logo,
	ImageColor3 = th.accent,
	ScaleType = Enum.ScaleType.Fit,
	Visible = shitaroebet.opener,
	Active = true,
	ZIndex = 950,
}, scr)

drag(knock, knock, 0.1)

local rap, rapt = nil, 0

conn(knock.InputBegan, function(i)
	if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
		rap, rapt = i.Position, os.clock()
	end
end)

conn(knock.InputEnded, function(i)
	if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then
		return
	end

	local from = rap

	rap = nil

	if not from or locks > 0 then
		return
	end

	if (i.Position - from).Magnitude > 8 or os.clock() - rapt > 0.7 then
		return
	end

	for _, w in next, shitaroebet.wins do
		pcall(function()
			w:toggle()
		end)
	end
end)

shitaroebet:hook("menu|openerspot", "string", function()
	return spotof(knock.Position)
end, function(v)
	local p = readspot(v)

	if p then
		knock.Position = p
	end
end)

function shitaroebet:setopener(v)
	shitaroebet.opener = v and true or false

	knock.Visible = shitaroebet.opener
end

function shitaroebet:openerspot(v)
	if typeof(v) == "UDim2" then
		knock.Position = v
	end
end

function shitaroebet:openericon(v)
	knock.Image = tostring(v)
end

local shelf = new("Frame", {
	Name = rnd(),
	AnchorPoint = Vector2.new(0, 0),
	Position = UDim2.new(0, 18, 0, 18),
	Size = UDim2.fromOffset(268, 0),
	AutomaticSize = Enum.AutomaticSize.Y,
	BackgroundTransparency = 1,
	ZIndex = 400,
}, scr)

shrink(shelf)

local puffs = {}
local puffn = 0

local function stack(fresh)
	local y = 0

	for i = 1, #puffs do
		local p = puffs[i]
		local card = p.husk

		if card and card.Parent then
			local at = UDim2.fromOffset(0, y)

			if p == fresh or p.spot == nil then
				card.Position = at
			elseif p.spot ~= y then
				anim(card, soft, { Position = at })
			end

			p.spot = y

			y += (p.tall or card.Size.Y.Offset) + 8
		end
	end
end

shitaroebet.notices = true
shitaroebet.noticecap = 5

function shitaroebet:setnotices(v)
	shitaroebet.notices = v and true or false
end

function shitaroebet:notify(cfg)
	if not shitaroebet.alive or not shitaroebet.notices then
		return
	end

	cfg = params(cfg, {
		title = "shitaro",
		text = "",
		icon = "info",
		life = 5,
		tone = nil,
	})

	local th = shitaroebet.theme
	local wide = 268
	local head = tostring(cfg.title or "")
	local body = tostring(cfg.text or "")
	local tint = (typeof(cfg.tone) == "Color3") and cfg.tone or th.accent
	local rows = 0

	if body ~= "" then
		rows = math.clamp(math.ceil(gauge(body, 11) / (wide - 52)), 1, 4)
	end

	local tall = 27 + (rows > 0 and (rows * 12 + 3) or 0)

	puffn += 1

	local husk = new("CanvasGroup", {
		Name = rnd(),
		Size = UDim2.fromOffset(wide, tall),
		BackgroundColor3 = th.panel,
		BackgroundTransparency = 0,
		BorderSizePixel = 0,
		GroupTransparency = 1,
		LayoutOrder = puffn,
		ZIndex = 400,
	}, shelf)

	round(husk, 7)

	new("UIStroke", {
		Color = th.line,
		Thickness = 1,
		Transparency = 0.45,
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		LineJoinMode = Enum.LineJoinMode.Round,
	}, husk)

	if deep then
		new("UIShadow", {
			Color = th.bg,
			BlurRadius = UDim.new(0, 14),
			Offset = UDim2.fromOffset(0, 3),
			Spread = UDim2.fromOffset(-2, -2),
			Transparency = 0.3,
			ZIndex = -1,
		}, husk)
	end

	local sheen = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = th.glow,
		BackgroundTransparency = 0.82,
		BorderSizePixel = 0,
		ZIndex = 400,
	}, husk)

	round(sheen, 7)

	fade(sheen, 90, {
		NumberSequenceKeypoint.new(0, 0.5),
		NumberSequenceKeypoint.new(0.6, 0.82),
		NumberSequenceKeypoint.new(1, 0.9),
	})

	local gloss = new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 1),
		Size = UDim2.new(1, -14, 0, 1),
		BackgroundColor3 = th.glow,
		BackgroundTransparency = 0.7,
		BorderSizePixel = 0,
		ZIndex = 402,
	}, husk)

	fade(gloss, 0, {
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0.1),
		NumberSequenceKeypoint.new(1, 1),
	})

	local bar = new("Frame", {
		Name = rnd(),
		Size = UDim2.new(0, 2, 1, 0),
		BackgroundColor3 = tint,
		BackgroundTransparency = 0.15,
		BorderSizePixel = 0,
		ZIndex = 402,
	}, husk)

	fade(bar, 90, {
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.12, 0.2),
		NumberSequenceKeypoint.new(0.5, 0),
		NumberSequenceKeypoint.new(0.88, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	})

	new("ImageLabel", {
		Name = rnd(),
		Position = UDim2.fromOffset(11, 7),
		Size = UDim2.fromOffset(13, 13),
		BackgroundTransparency = 1,
		Image = icon(cfg.icon),
		ImageColor3 = tint,
		ImageTransparency = 0.05,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 402,
	}, husk)

	new("TextLabel", {
		Name = rnd(),
		Position = UDim2.fromOffset(31, 5),
		Size = UDim2.new(1, -46, 0, 17),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		Text = head,
		TextColor3 = th.text,
		TextSize = 13,
		TextTransparency = 0.05,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 402,
	}, husk)

	if rows > 0 then
		new("TextLabel", {
			Name = rnd(),
			Position = UDim2.fromOffset(31, 21),
			Size = UDim2.new(1, -42, 0, rows * 12),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamMedium,
			Text = body,
			TextColor3 = th.dim,
			TextSize = 11,
			TextTransparency = 0.15,
			TextWrapped = true,
			TextXAlignment = Enum.TextXAlignment.Left,
			TextYAlignment = Enum.TextYAlignment.Top,
			ZIndex = 402,
		}, husk)
	end

	local fuse = new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 2),
		BackgroundColor3 = tint,
		BackgroundTransparency = 0.35,
		BorderSizePixel = 0,
		ZIndex = 403,
	}, husk)

	fade(fuse, 0, {
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.12, 0.2),
		NumberSequenceKeypoint.new(0.5, 0),
		NumberSequenceKeypoint.new(0.88, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	})

	local shut = new("ImageButton", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		ZIndex = 404,
	}, husk)

	local function drift(inn, done)
		local a0 = husk.GroupTransparency
		local a1 = inn and 0 or 1

		flow(husk, inn and 0.3 or 0.22, inn and outq or inq, function(k)
			husk.GroupTransparency = a0 + (a1 - a0) * k

			if k >= 1 and done then
				done()
			end
		end)
	end

	local puff = { husk = husk, tall = tall, dead = false }

	function puff:close()
		if puff.dead then
			return
		end

		puff.dead = true

		drift(false, function()
			local at = table.find(puffs, puff)

			if at then
				table.remove(puffs, at)
			end

			husk:Destroy()

			stack()
		end)
	end

	table.insert(puffs, puff)

	stack(puff)

	local seen = 0
	local cap = math.max(shitaroebet.noticecap, 1)

	for i = #puffs, 1, -1 do
		local p = puffs[i]

		if not p.dead then
			seen += 1

			if seen > cap then
				p:close()
			end
		end
	end

	conn(shut.MouseButton1Click, function()
		shitaroebet:chime("tap")

		puff:close()
	end)

	conn(shut.MouseEnter, function()
		anim(sheen, soft, { BackgroundTransparency = 0.65 })
	end)

	conn(shut.MouseLeave, function()
		anim(sheen, soft, { BackgroundTransparency = 0.82 })
	end)

	drift(true)

	local life = math.max(tonumber(cfg.life) or 5, 0.4)

	anim(fuse, TweenInfo.new(life, Enum.EasingStyle.Linear), { Size = UDim2.new(0, 0, 0, 2) })

	task.delay(life, function()
		puff:close()
	end)

	return puff
end

function shitaroebet:window(cfg)
	cfg = params(cfg, {
		logo = shitaroebet.logo,
		size = UDim2.fromOffset(528, 540),
		side = 153,
		radius = 9,
		bind = "RightShift",
	})

	local th = shitaroebet.theme
	local r = cfg.radius
	local sw = cfg.side

	local win = {
		size = cfg.size,
		open = true,
		list = {},
		bind = typeof(cfg.bind) == "EnumItem" and cfg.bind or Enum.KeyCode[cfg.bind],
	}

	local shell = new("Frame", {
		Name = rnd(),
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = cfg.size,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
	}, scr)

	shrink(shell)

	local aura, halo = {}, {}
	local native = pcall(Instance.new, "UIShadow")

	if native then
		local lamp = new("Frame", {
			Name = rnd(),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 1,
		}, shell)

		round(lamp, r)

		for i, spec in next, {
			{ UDim.new(0, 16), UDim2.fromOffset(2, 2), 0.2 },
			{ UDim.new(0, 38), UDim2.fromOffset(12, 12), 0.45 },
		} do
			aura[i] = new("UIShadow", {
				Color = th.bg,
				BlurRadius = spec[1],
				Spread = spec[2],
				Offset = UDim2.new(),
				Transparency = 1,
				ZIndex = -i,
			}, lamp)

			halo[i] = spec[3]
		end
	else
		for i, alpha in next, { 0.35, 0.55, 0.72 } do
			local ring = new("Frame", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.new(1, i * 5, 1, i * 5),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = 1,
			}, shell)

			round(ring, r + i * 3)

			aura[i] = new("UIStroke", {
				Color = th.bg,
				Thickness = 3,
				Transparency = 1,
			}, ring)

			halo[i] = alpha
		end
	end

	local root = new("CanvasGroup", {
		Name = rnd(),
		Active = true,
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = th.bg,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		GroupTransparency = 1,
		ZIndex = 2,
	}, shell)

	round(root, r)

	local rim = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 20,
	}, root)

	round(rim, r)
	new("UIStroke", { Color = th.line, Transparency = 0.6 }, rim)

	local furySheets = {}
	for i = 1, 3 do
		local image = asset({
			"assets/furynew_sheet_" .. i .. ".png",
			"furynew_sheet_" .. i .. ".png",
			"shitaroebet/furynew_sheet_" .. i .. ".png",
		})
		if image ~= "" then
			table.insert(furySheets, image)
		end
	end

	local fury = nil
	local furyEnabled = true

	function win:setfury(v)
		furyEnabled = v and true or false
		if fury then
			fury.Visible = furyEnabled
			fury.ImageTransparency = furyEnabled and root.GroupTransparency or 1
		end
	end

	if #furySheets == 3 then
		fury = new("ImageLabel", {
			Name = rnd(),
			Active = false,
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.new(0, math.floor(sw / 2), 0, 18),
			Size = UDim2.fromOffset(176, 176),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Image = furySheets[1],
			ImageTransparency = 1,
			ImageRectOffset = Vector2.zero,
			ImageRectSize = Vector2.new(256, 256),
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 24,
		}, shell)

		conn(root:GetPropertyChangedSignal("GroupTransparency"), function()
			if furyEnabled then
				fury.ImageTransparency = root.GroupTransparency
			end
		end)

		task.spawn(function()
			pcall(game:GetService("ContentProvider").PreloadAsync, game:GetService("ContentProvider"), furySheets)
		end)

		local furyFrame = 0
		local furyClock = 0
		conn(rs.RenderStepped, function(dt)
			if not furyEnabled or not shell.Visible or fury.ImageTransparency >= 0.999 then
				return
			end
			furyClock += dt
			local steps = math.floor(furyClock * 12)
			if steps < 1 then
				return
			end
			furyClock -= steps / 12
			furyFrame = (furyFrame + steps) % 35
			local sheetIndex = math.floor(furyFrame / 12) + 1
			local localFrame = furyFrame % 12
			fury.Image = furySheets[sheetIndex]
			fury.ImageRectOffset = Vector2.new((localFrame % 4) * 256, math.floor(localFrame / 4) * 256)
		end)
	end

	local grip = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ZIndex = 0,
		Active = true,
	}, root)

	local body = new("Frame", {
		Name = rnd(),
		Position = UDim2.fromOffset(sw, 0),
		Size = UDim2.new(1, -sw, 1, 0),
		BackgroundColor3 = th.bg,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 1,
	}, root)

	round(body, r)

	new("Frame", {
		Name = rnd(),
		Size = UDim2.new(0, r, 1, 0),
		BackgroundColor3 = th.bg,
		BorderSizePixel = 0,
		ZIndex = 1,
	}, body)

	local bgnet = net(body, 13, 0.44, 0.11, 2)

	local pages = new("Frame", {
		Name = rnd(),
		Position = UDim2.fromOffset(16, 16),
		Size = UDim2.new(1, -32, 1, -32),
		BackgroundTransparency = 1,
		ZIndex = 4,
	}, body)

	local side = new("Frame", {
		Name = rnd(),
		Size = UDim2.new(0, sw, 1, 0),
		BackgroundColor3 = th.side,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 5,
	}, root)

	round(side, r)

	new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(1, 0),
		Position = UDim2.fromScale(1, 0),
		Size = UDim2.new(0, r, 1, 0),
		BackgroundColor3 = th.side,
		BorderSizePixel = 0,
		ZIndex = 5,
	}, side)

	local split = new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0, sw, 0.5, 0),
		Size = UDim2.new(0, 16, 1, 0),
		BackgroundTransparency = 1,
		ZIndex = 8,
	}, root)

	local splitGlow = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundColor3 = th.glow,
		BackgroundTransparency = 0.9,
		BorderSizePixel = 0,
		ZIndex = 8,
	}, split)

	fade(splitGlow, 0, {
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0.35),
		NumberSequenceKeypoint.new(1, 1),
	})

	local splitLine = new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(0, 1, 1, 0),
		BackgroundColor3 = th.line,
		BorderSizePixel = 0,
		ZIndex = 9,
	}, split)

	fade(splitLine, 90, {
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.12, 0.25),
		NumberSequenceKeypoint.new(0.88, 0.25),
		NumberSequenceKeypoint.new(1, 1),
	})

	local logo = new("ImageLabel", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 14),
		Size = UDim2.fromOffset(117, 117),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = cfg.logo,
		ImageColor3 = th.accent,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 7,
	}, side)

	local under = new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0, 140),
		Size = UDim2.new(1, -28, 0, 1),
		BackgroundColor3 = th.line,
		BackgroundTransparency = 0.35,
		BorderSizePixel = 0,
		ZIndex = 7,
	}, side)

	fade(under, 0, {
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	})

	local tabs = new("ScrollingFrame", {
		Name = rnd(),
		Active = false,
		Position = UDim2.fromOffset(6, 154),
		Size = UDim2.new(1, -12, 1, -222),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 0,
		CanvasSize = UDim2.new(),
		ZIndex = 7,
	}, side)

	local list = new("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 3),
	}, tabs)

	conn(list:GetPropertyChangedSignal("AbsoluteContentSize"), function()
		tabs.CanvasSize = UDim2.fromOffset(0, acs(list).Y + 2)
	end)

	local seam = new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, -60),
		Size = UDim2.new(1, -28, 0, 1),
		BackgroundColor3 = th.line,
		BackgroundTransparency = 0.35,
		BorderSizePixel = 0,
		ZIndex = 7,
	}, side)

	fade(seam, 0, {
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	})

	local badge = new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0.5, 1),
		Position = UDim2.new(0.5, 0, 1, -8),
		Size = UDim2.new(1, -12, 0, 44),
		BackgroundColor3 = th.head,
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0,
		ZIndex = 7,
	}, side)

	round(badge, 8)

	new("UIStroke", { Color = th.line, Transparency = 0.72 }, badge)

	local face = new("ImageLabel", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 6, 0.5, 0),
		Size = UDim2.fromOffset(32, 32),
		BackgroundColor3 = th.panel,
		BorderSizePixel = 0,
		Image = string.format("rbxthumb://type=AvatarHeadShot&id=%d&w=150&h=150", lp.UserId),
		ScaleType = Enum.ScaleType.Crop,
		ZIndex = 8,
	}, badge)

	new("UICorner", { CornerRadius = UDim.new(1, 0) }, face)

	new("UIStroke", { Color = th.line, Transparency = 0.45 }, face)

	local nick = new("TextLabel", {
		Name = rnd(),
		Position = UDim2.fromOffset(45, 6),
		Size = UDim2.new(1, -51, 0, 15),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		Text = lp.DisplayName,
		TextColor3 = th.text,
		TextSize = 13,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 8,
	}, badge)

	local handle = new("TextLabel", {
		Name = rnd(),
		Position = UDim2.fromOffset(45, 22),
		Size = UDim2.new(1, -51, 0, 13),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		Text = "@" .. lp.Name,
		TextColor3 = th.dim,
		TextSize = 11,
		TextTransparency = 0.3,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 8,
	}, badge)

	conn(lp:GetPropertyChangedSignal("DisplayName"), function()
		nick.Text = lp.DisplayName
	end)

	local order, live = 0, nil

	local function inlay(card, item, tail)
		local sv = new("Frame", {
			Name = rnd(),
			Active = true,
			Position = UDim2.fromOffset(10, 40),
			Size = UDim2.new(1, -20, 0, 98),
			BackgroundColor3 = Color3.fromHSV(0, 1, 1),
			BorderSizePixel = 0,
			ZIndex = 6,
		}, card)

		round(sv, 6)

		local tintw = new("Frame", {
			Name = rnd(),
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0,
			ZIndex = 30,
		}, sv)

		round(tintw, 6)

		new("UIGradient", {
			Color = ColorSequence.new(Color3.new(1, 1, 1)),
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, 1),
			}),
		}, tintw)

		local tintb = new("Frame", {
			Name = rnd(),
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = Color3.new(),
			BorderSizePixel = 0,
			ZIndex = 30,
		}, sv)

		round(tintb, 6)

		new("UIGradient", {
			Color = ColorSequence.new(Color3.new()),
			Rotation = 90,
			Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(1, 0),
			}),
		}, tintb)

		new("UIStroke", { Color = th.panel, Thickness = 1.5 }, sv)

		local dot = new("Frame", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Size = UDim2.fromOffset(9, 9),
			BackgroundColor3 = th.accent,
			BorderSizePixel = 0,
			ZIndex = 31,
		}, sv)

		new("UICorner", { CornerRadius = UDim.new(1, 0) }, dot)
		new("UIStroke", { Color = th.bg, Transparency = 0.25 }, dot)

		local bar = new("Frame", {
			Name = rnd(),
			Active = true,
			Position = UDim2.fromOffset(10, 146),
			Size = UDim2.new(1, -20, 0, 10),
			BackgroundColor3 = Color3.new(1, 1, 1),
			BorderSizePixel = 0,
			ZIndex = 6,
		}, card)

		round(bar, 5)
		new("UIStroke", { Color = th.panel, Thickness = 1.5 }, bar)

		local keys = {}

		for i = 0, 6 do
			table.insert(keys, ColorSequenceKeypoint.new(i / 6, Color3.fromHSV(i / 6, 1, 1)))
		end

		new("UIGradient", { Color = ColorSequence.new(keys) }, bar)

		local pin = new("Frame", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0, 0.5),
			Size = UDim2.fromOffset(4, 16),
			BackgroundColor3 = th.accent,
			BorderSizePixel = 0,
			ZIndex = 31,
		}, bar)

		new("UICorner", { CornerRadius = UDim.new(1, 0) }, pin)
		new("UIStroke", { Color = th.bg, Transparency = 0.25 }, pin)

		local field = new("TextBox", {
			Name = rnd(),
			Position = UDim2.fromOffset(10, 164),
			Size = UDim2.new(1, -66, 0, 22),
			BackgroundColor3 = th.head,
			BorderSizePixel = 0,
			ClearTextOnFocus = false,
			Font = Enum.Font.GothamBold,
			Text = hexof(item.color),
			TextColor3 = th.text,
			TextSize = 13,
			ZIndex = 6,
		}, card)

		round(field, 5)

		local st = { h = 0, s = 1, v = 1 }

		st.h, st.s, st.v = Color3.toHSV(item.color)

		local function paint(fire, snap)
			local c = Color3.fromHSV(st.h, st.s, st.v)
			local spot = UDim2.fromScale(st.s, 1 - st.v)
			local slide = UDim2.new(st.h, 0, 0.5, 0)

			if snap then
				dot.Position = spot
				pin.Position = slide
				dot.BackgroundColor3 = c
				sv.BackgroundColor3 = Color3.fromHSV(st.h, 1, 1)

				if item.chip then
					item.chip.BackgroundColor3 = c
				end
			else
				anim(dot, quick, { Position = spot, BackgroundColor3 = c })
				anim(pin, quick, { Position = slide })
				anim(sv, quick, { BackgroundColor3 = Color3.fromHSV(st.h, 1, 1) })

				if item.chip then
					anim(item.chip, quick, { BackgroundColor3 = c })
				end
			end

			if not field:IsFocused() then
				field.Text = hexof(c)
			end

			item.apply(c, fire)
		end

		local function reel()
			local o = card.Parent

			while o and o ~= scr do
				if o:IsA("ScrollingFrame") then
					return o
				end

				o = o.Parent
			end
		end

		local roll = reel()

		local function graze(frame, apply)
			conn(frame.InputBegan, function(i)
				if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				if st.hold then
					return
				end

				st.hold = true

				latch(1)

				if roll then
					roll.ScrollingEnabled = false
				end

				while st.hold and (uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or i.UserInputState ~= Enum.UserInputState.End) do
					apply()
					paint(true)

					task.wait()
				end

				st.hold = false

				if roll then
					roll.ScrollingEnabled = true
				end

				latch(-1)
			end)

			conn(frame.InputEnded, function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
					st.hold = false
				end
			end)
		end

		graze(sv, function()
			local p, s = sv.AbsolutePosition, sv.AbsoluteSize

			st.s = math.clamp((mouse.X - p.X) / s.X, 0, 1)
			st.v = 1 - math.clamp((mouse.Y - p.Y) / s.Y, 0, 1)
		end)

		graze(bar, function()
			local p, s = bar.AbsolutePosition, bar.AbsoluteSize

			st.h = math.clamp((mouse.X - p.X) / s.X, 0, 1)
		end)

		conn(uis.InputEnded, function(i)
			if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
				st.hold = false
			end
		end)

		conn(field.FocusLost, function()
			local c = fromhex(field.Text)

			if c then
				st.h, st.s, st.v = Color3.toHSV(c)
			end

			paint(true)
		end)

		function tail.pull(c)
			st.h, st.s, st.v = Color3.toHSV(c)

			paint(true)
		end

		paint(false, true)
	end

	local function attach(pg, trail)
		local cols = {}
		local cards = {}
		local lip = 34

		trail = trail or "root"

		for i = 1, 2 do
			local col = new("ScrollingFrame", {
				Name = rnd(),
				Position = UDim2.new(0.5 * (i - 1), (i == 1) and 0 or 4, 0, lip),
				Size = UDim2.new(0.5, -4, 1, -lip),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				CanvasSize = UDim2.new(),
				ScrollBarThickness = 0,
				ZIndex = 5,
			}, pg)

			local cl = new("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 9),
			}, col)

			conn(cl:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				col.CanvasSize = UDim2.fromOffset(0, acs(cl).Y + 4)
			end)

			cols[i] = { frame = col, slots = {}, n = 0 }
		end

		local function lane(side)
			if side == "full" or side == 3 then
				if not cols[3] then
					local col = new("ScrollingFrame", {
						Name = rnd(),
						Position = UDim2.fromOffset(0, lip),
						Size = UDim2.new(1, 0, 1, -lip),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						CanvasSize = UDim2.new(),
						ScrollBarThickness = 0,
						ZIndex = 5,
					}, pg)

					local cl = new("UIListLayout", {
						SortOrder = Enum.SortOrder.LayoutOrder,
						Padding = UDim.new(0, 9),
					}, col)

					conn(cl:GetPropertyChangedSignal("AbsoluteContentSize"), function()
						col.CanvasSize = UDim2.fromOffset(0, acs(cl).Y + 4)
					end)

					cols[3] = { frame = col, slots = {}, n = 0 }

					cols[1].frame.Visible = false
					cols[2].frame.Visible = false
				end

				return cols[3]
			end

			return cols[(side == "right" or side == 2) and 2 or 1]
		end

		local quest = new("Frame", {
			Name = rnd(),
			Position = UDim2.fromOffset(-16, -16),
			Size = UDim2.new(1, 32, 0, 42),
			BackgroundColor3 = th.bg,
			BorderSizePixel = 0,
			ZIndex = 6,
		}, pg)

		local seam = new("Frame", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 0, 1, 0),
			Size = UDim2.new(1, 0, 0, 16),
			BackgroundTransparency = 1,
			ZIndex = 6,
		}, quest)

		local seamGlow = new("Frame", {
			Name = rnd(),
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = th.glow,
			BackgroundTransparency = 0.9,
			BorderSizePixel = 0,
			ZIndex = 6,
		}, seam)

		fade(seamGlow, 90, {
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.5, 0.35),
			NumberSequenceKeypoint.new(1, 1),
		})

		local seamLine = new("Frame", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0.5, 0.5),
			Position = UDim2.fromScale(0.5, 0.5),
			Size = UDim2.new(1, 0, 0, 1),
			BackgroundColor3 = th.line,
			BorderSizePixel = 0,
			ZIndex = 7,
		}, seam)

		fade(seamLine, 0, {
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.12, 0.25),
			NumberSequenceKeypoint.new(0.88, 0.25),
			NumberSequenceKeypoint.new(1, 1),
		})

		local tally = new("TextLabel", {
			Name = rnd(),
			Position = UDim2.fromOffset(17, 3),
			Size = UDim2.new(1, -110, 1, -8),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			Text = "",
			TextColor3 = th.dim,
			TextSize = 14,
			TextTransparency = 1,
			TextTruncate = Enum.TextTruncate.AtEnd,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 7,
		}, quest)

		local probe = new("TextBox", {
			Name = rnd(),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -44, 0.5, -1),
			Size = UDim2.new(0, 0, 0, 27),
			BackgroundColor3 = th.head,
			BorderSizePixel = 0,
			ClearTextOnFocus = false,
			ClipsDescendants = true,
			Font = Enum.Font.GothamBold,
			PlaceholderColor3 = th.dim,
			PlaceholderText = "search",
			Text = "",
			TextColor3 = th.text,
			TextSize = 14,
			TextTransparency = 1,
			TextXAlignment = Enum.TextXAlignment.Left,
			Visible = false,
			ZIndex = 7,
		}, quest)

		round(probe, 8)

		new("UIPadding", { PaddingLeft = UDim.new(0, 12), PaddingRight = UDim.new(0, 12) }, probe)

		local hem = new("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = th.line,
			Transparency = 0.55,
		}, probe)

		local glint = new("Frame", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0.5, 1),
			Position = UDim2.fromScale(0.5, 1),
			Size = UDim2.new(1, 6, 0, 1),
			BackgroundColor3 = th.accent,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 8,
		}, probe)

		fade(glint, 0, {
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.5, 0),
			NumberSequenceKeypoint.new(1, 1),
		})

		local lens = new("ImageButton", {
			Name = rnd(),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -17, 0.5, 2),
			Size = UDim2.fromOffset(22, 22),
			BackgroundColor3 = th.head,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Image = icon("search"),
			ImageColor3 = th.dim,
			ImageTransparency = 0.2,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 8,
		}, quest)

		round(lens, 6)

		local function sift(raw)
			local q = string.match(string.lower(raw or ""), "^%s*(.-)%s*$") or ""
			local hits = 0

			for _, cd in next, cards do
				local own = q == "" or string.find(string.lower(cd.name), q, 1, true) ~= nil
				local any, moved = false, false

				for _, rw in next, cd.rows do
					local direct = q ~= "" and string.find(string.lower(rw.name), q, 1, true) ~= nil
					local ok = own or direct

					if rw.row.Visible ~= ok then
						rw.row.Visible = ok
						moved = true
					end

					any = any or ok

					if direct then
						hits += 1
					end
				end

				if cd.gate then
					cd.gate(q ~= "" and any or nil)
				end

				if moved and cd.fit then
					cd.fit()
				end

				if own and q ~= "" then
					hits += 1
				end

				cd.slot.show(own or any)
			end

			return hits
		end

		local lit, shut = false, 0

		local function flick(v)
			if lit == v then
				return
			end

			lit = v

			if v then
				probe.Visible = true
				lens.Image = icon("x")

				anim(probe, soft, { Size = UDim2.new(0.66, -44, 0, 27), TextTransparency = 0 })
				anim(hem, soft, { Transparency = 0.35 })
				anim(glint, soft, { BackgroundTransparency = 0.35 })
				anim(lens, soft, { ImageTransparency = 0, ImageColor3 = th.text, BackgroundTransparency = 0.45 })

				task.delay(0.12, function()
					if lit then
						probe:CaptureFocus()
					end
				end)
			else
				shut = os.clock()

				lens.Image = icon("search")

				probe:ReleaseFocus()

				if probe.Text ~= "" then
					probe.Text = ""
				end

				anim(probe, soft, { Size = UDim2.new(0, 0, 0, 27), TextTransparency = 1 })
				anim(hem, soft, { Transparency = 0.55 })
				anim(glint, soft, { BackgroundTransparency = 1 })
				anim(lens, soft, { ImageTransparency = 0.2, ImageColor3 = th.dim, BackgroundTransparency = 1 })

				task.delay(0.28, function()
					if not lit then
						probe.Visible = false
					end
				end)
			end
		end

		conn(lens.MouseButton1Click, function()
			if not lit and os.clock() - shut < 0.25 then
				return
			end

			flick(not lit)
		end)

		conn(lens.MouseEnter, function()
			anim(lens, soft, { ImageTransparency = 0, ImageColor3 = th.text, BackgroundTransparency = 0.45 })
		end)

		conn(lens.MouseLeave, function()
			if not lit then
				anim(lens, soft, { ImageTransparency = 0.2, ImageColor3 = th.dim, BackgroundTransparency = 1 })
			end
		end)

		conn(probe:GetPropertyChangedSignal("Text"), function()
			local hits = sift(probe.Text)
			local busy = string.match(probe.Text, "%S") ~= nil

			tally.Text = busy and (hits .. (hits == 1 and " result" or " results")) or ""

			anim(tally, soft, { TextTransparency = busy and 0.2 or 1 })
		end)

		conn(probe.FocusLost, function()
			if not string.match(probe.Text, "%S") then
				flick(false)
			end
		end)

		local api = {}

		local function crate(col, fixed)
			col.n += 1

			local slot = new("Frame", {
				Name = rnd(),
				Size = UDim2.new(1, 0, 0, fixed or 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				LayoutOrder = col.n,
				ZIndex = 5,
			}, col.frame)

			local curtain = new("Frame", {
				Name = rnd(),
				Size = UDim2.new(1, 0, 0, fixed or 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				ZIndex = 5,
			}, slot)

			local skin = new("Frame", {
				Name = rnd(),
				Size = fixed and UDim2.new(1, 0, 0, fixed) or UDim2.new(1, 0, 0, 0),
				AutomaticSize = (not fixed) and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
				BackgroundColor3 = th.panel,
				BorderSizePixel = 0,
				ZIndex = 5,
			}, curtain)

			round(skin, 7)

			new("UIGradient", {
				Rotation = 90,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 178, 190)),
				}),
			}, skin)

			if native then
				new("UIShadow", {
					Color = th.bg,
					BlurRadius = UDim.new(0, 12),
					Offset = UDim2.fromOffset(0, 3),
					Spread = UDim2.fromOffset(-2, -2),
					Transparency = 0.45,
					ZIndex = -1,
				}, skin)
			end

			local rec = { frame = slot, curtain = curtain, panel = skin, live = true }

			function rec.show(v)
				v = v and true or false

				if rec.live == v then
					return
				end

				rec.live = v

				if v then
					slot.Visible = true
				end

				flow(curtain, 0.26, v and outq or inq, function(k)
					local h = asz(skin).Y
					local p = v and k or (1 - k)
					local a = math.floor(h * p + 0.5)

					slot.Size = UDim2.new(1, 0, 0, a)
					curtain.Size = UDim2.new(1, 0, 0, a)
					skin.Position = UDim2.fromOffset(0, -math.floor(math.min(18, h) * (1 - p) + 0.5))

					if k >= 1 then
						skin.Position = UDim2.new()
						slot.Visible = v

						if v then
							slot.Size = UDim2.new(1, 0, 0, h)
							curtain.Size = UDim2.new(1, 0, 0, h)
						end
					end
				end)
			end

			table.insert(col.slots, rec)

			conn(skin:GetPropertyChangedSignal("AbsoluteSize"), function()
				local h = asz(skin).Y

				if not rec.live then
					return
				end

				slot.Size = UDim2.new(1, 0, 0, h)

				if not rides[curtain] then
					curtain.Size = UDim2.new(1, 0, 0, h)
				end
			end)

			return skin, rec
		end

		function api.reveal()
			local order = 0

			for _, c in next, cols do
				for _, s in next, c.slots do
					if s.live then
						local prev = rides[s.curtain]

						if prev then
							prev:Disconnect()
							rides[s.curtain] = nil
						end

						local lag = math.min(order * 0.03, 0.24)

						order = order + 1

						s.panel.Position = UDim2.fromOffset(0, 12)

						flow(s.curtain, 0.24, outq, function(k)
							local h = asz(s.panel).Y

							s.frame.Size = UDim2.new(1, 0, 0, h)
							s.curtain.Size = UDim2.new(1, 0, 0, h)
							s.panel.Position = UDim2.fromOffset(0, math.floor(12 * (1 - k) + 0.5))

							if k >= 1 then
								s.panel.Position = UDim2.new()
							end
						end, lag)
					end
				end
			end
		end

		function api.settle()
			for _, c in next, cols do
				for _, s in next, c.slots do
					if s.live then
						local prev = rides[s.curtain]

						if prev then
							prev:Disconnect()
							rides[s.curtain] = nil
						end

						s.panel.Position = UDim2.new()
						s.curtain.Size = UDim2.new(1, 0, 0, asz(s.panel).Y)
					end
				end
			end
		end

		local function bindpod(anchor, title, vue, keep, opt)
			local bd = { on = false, live = false, key = nil, mode = "toggle", value = 0, w = 198, h = 0 }
			local slot = opt.value

			if slot then
				bd.value = tonumber(slot.default) or slot.min or 0
			end

			local veil = new("ImageButton", {
				Name = rnd(),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ImageTransparency = 1,
				Visible = false,
				ZIndex = 33,
			}, root)

			local pit = native and new("Frame", {
				Name = rnd(),
				Size = UDim2.fromOffset(0, 0),
				BackgroundColor3 = th.panel,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Visible = false,
				ZIndex = 34,
			}, root) or nil

			local cast = pit and new("UIShadow", {
				Color = th.bg,
				BlurRadius = UDim.new(0, 16),
				Offset = UDim2.fromOffset(0, 5),
				Spread = UDim2.fromOffset(-3, -3),
				Transparency = 1,
				ZIndex = -1,
			}, pit) or nil

			if pit then
				round(pit, 8)
			end

			local hull = new("CanvasGroup", {
				Name = rnd(),
				Size = UDim2.fromOffset(0, 0),
				BackgroundColor3 = th.panel,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				GroupTransparency = 1,
				Visible = false,
				ZIndex = 35,
			}, root)

			round(hull, 8)

			new("UIGradient", {
				Rotation = 90,
				Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 178, 190)),
				}),
			}, hull)

			new("ImageButton", {
				Name = rnd(),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ImageTransparency = 1,
				ZIndex = 1,
			}, hull)

			local brim = new("Frame", {
				Name = rnd(),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = 44,
			}, hull)

			round(brim, 8)

			new("UIStroke", { Color = th.line, Transparency = 0.6 }, brim)

			local cap = new("Frame", {
				Name = rnd(),
				Size = UDim2.new(1, 0, 0, 31),
				BackgroundColor3 = th.head,
				BorderSizePixel = 0,
				ZIndex = 36,
			}, hull)

			round(cap, 8)

			new("Frame", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0, 1),
				Position = UDim2.fromScale(0, 1),
				Size = UDim2.new(1, 0, 0, 8),
				BackgroundColor3 = th.head,
				BorderSizePixel = 0,
				ZIndex = 36,
			}, cap)

			local mast = new("Frame", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.new(1, -20, 1, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = 37,
			}, cap)

			new("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				HorizontalAlignment = Enum.HorizontalAlignment.Center,
				VerticalAlignment = Enum.VerticalAlignment.Center,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 7),
			}, mast)

			new("ImageLabel", {
				Name = rnd(),
				Size = UDim2.fromOffset(13, 13),
				BackgroundTransparency = 1,
				Image = icon("keyboard"),
				ImageColor3 = th.accent,
				ImageTransparency = 0.12,
				LayoutOrder = 1,
				ScaleType = Enum.ScaleType.Fit,
				ZIndex = 38,
			}, mast)

			new("TextLabel", {
				Name = rnd(),
				AutomaticSize = Enum.AutomaticSize.X,
				Size = UDim2.fromOffset(0, 16),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = title,
				TextColor3 = th.text,
				TextSize = 13,
				TextTruncate = Enum.TextTruncate.AtEnd,
				LayoutOrder = 2,
				ZIndex = 38,
			}, mast)

			local rule = new("Frame", {
				Name = rnd(),
				Position = UDim2.fromOffset(0, 31),
				Size = UDim2.new(1, 0, 0, 1),
				BackgroundColor3 = th.line,
				BackgroundTransparency = 0.25,
				BorderSizePixel = 0,
				ZIndex = 37,
			}, hull)

			fade(rule, 0, {
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.18, 0.15),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.82, 0.15),
				NumberSequenceKeypoint.new(1, 1),
			})

			local slab = new("Frame", {
				Name = rnd(),
				Position = UDim2.fromOffset(0, 34),
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = 36,
			}, hull)

			new("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 4),
			}, slab)

			new("UIPadding", {
				PaddingTop = UDim.new(0, 7),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 7),
				PaddingRight = UDim.new(0, 7),
			}, slab)

			local tier = 0

			local function bunk(h)
				tier += 1

				return new("Frame", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, h),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = tier,
					ZIndex = 36,
				}, slab)
			end

			local function stub(host, text, y, w)
				return new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(5, y),
					Size = UDim2.new(w or 0.4, -8, 0, 15),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = text,
					TextColor3 = th.dim,
					TextSize = 11,
					TextTransparency = 0.4,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 37,
				}, host)
			end

			local keybunk = bunk(22)

			stub(keybunk, "bind", 4)

			local wipe = new("ImageButton", {
				Name = rnd(),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -5, 0.5, 0),
				Size = UDim2.fromOffset(20, 20),
				BackgroundColor3 = th.head,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Image = "",
				ZIndex = 38,
			}, keybunk)

			round(wipe, 5)

			local wipepip = new("ImageLabel", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(11, 11),
				BackgroundTransparency = 1,
				Image = icon("trash-2"),
				ImageColor3 = th.dim,
				ImageTransparency = 0.65,
				ScaleType = Enum.ScaleType.Fit,
				ZIndex = 39,
			}, wipe)

			local pill = new("Frame", {
				Name = rnd(),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -28, 0.5, 0),
				Size = UDim2.new(0.6, -33, 0, 21),
				BackgroundColor3 = th.head,
				BackgroundTransparency = 0.12,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				ZIndex = 37,
			}, keybunk)

			round(pill, 6)

			local ring = new("UIStroke", { Color = th.line, Transparency = 0.62 }, pill)

			local shown = new("TextLabel", {
				Name = rnd(),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = "None",
				TextColor3 = th.text,
				TextSize = 12,
				TextTransparency = 0.1,
				TextTruncate = Enum.TextTruncate.AtEnd,
				ZIndex = 38,
			}, pill)

			local beam = new("Frame", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0.5, 1),
				Position = UDim2.fromScale(0.5, 1),
				Size = UDim2.new(1, 0, 0, 1),
				BackgroundColor3 = th.accent,
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = 39,
			}, pill)

			fade(beam, 0, {
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(1, 1),
			})

			local hit = new("ImageButton", {
				Name = rnd(),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ImageTransparency = 1,
				ZIndex = 40,
			}, pill)

			local dial, fill, worth, grab = nil, nil, nil, nil

			if slot then
				local valbunk = bunk(34)

				stub(valbunk, "value", 1)

				worth = new("TextLabel", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0),
					Position = UDim2.new(1, -5, 0, 1),
					Size = UDim2.fromOffset(70, 15),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = "",
					TextColor3 = th.text,
					TextSize = 12,
					TextTransparency = 0.15,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Right,
					ZIndex = 37,
				}, valbunk)

				dial = new("Frame", {
					Name = rnd(),
					Position = UDim2.fromOffset(5, 23),
					Size = UDim2.new(1, -10, 0, 6),
					BackgroundColor3 = th.head,
					BackgroundTransparency = 0.12,
					BorderSizePixel = 0,
					ZIndex = 37,
				}, valbunk)

				new("UICorner", { CornerRadius = UDim.new(1, 0) }, dial)

				fill = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(0, 6, 1, 0),
					BackgroundColor3 = th.accent,
					BackgroundTransparency = 0.1,
					BorderSizePixel = 0,
					ZIndex = 38,
				}, dial)

				new("UICorner", { CornerRadius = UDim.new(1, 0) }, fill)

				grab = new("Frame", {
					Name = rnd(),
					Active = true,
					Position = UDim2.fromOffset(0, 18),
					Size = UDim2.new(1, 0, 0, 16),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 39,
				}, valbunk)
			end

			local picks, glider = {}, nil

			if opt.mode then
				local segbunk = bunk(24)

				local seg = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.new(1, -10, 0, 22),
					BackgroundColor3 = th.head,
					BackgroundTransparency = 0.12,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ZIndex = 37,
				}, segbunk)

				round(seg, 6)

				new("UIStroke", { Color = th.line, Transparency = 0.62 }, seg)

				glider = new("Frame", {
					Name = rnd(),
					Position = UDim2.new(0, 2, 0, 2),
					Size = UDim2.new(0.5, -3, 1, -4),
					BackgroundColor3 = th.accent,
					BackgroundTransparency = 0.82,
					BorderSizePixel = 0,
					ZIndex = 38,
				}, seg)

				round(glider, 5)

				fade(glider, 90, {
					NumberSequenceKeypoint.new(0, 0),
					NumberSequenceKeypoint.new(1, 0.55),
				})

				new("UIStroke", { Color = th.accent, Transparency = 0.72 }, glider)

				for i, name in next, { "toggle", "hold" } do
					local o = { name = name, warm = false, slot = i }

					o.btn = new("ImageButton", {
						Name = rnd(),
						Position = UDim2.new(0.5 * (i - 1), 0, 0, 0),
						Size = UDim2.new(0.5, 0, 1, 0),
						BackgroundTransparency = 1,
						ImageTransparency = 1,
						ZIndex = 40,
					}, seg)

					o.lbl = new("TextLabel", {
						Name = rnd(),
						Size = UDim2.fromScale(1, 1),
						BackgroundTransparency = 1,
						Font = Enum.Font.GothamBold,
						Text = name,
						TextColor3 = th.dim,
						TextSize = 12,
						TextTransparency = 0.45,
						ZIndex = 39,
					}, o.btn)

					picks[i] = o
				end
			end

			local step = slot and math.max(tonumber(slot.step) or 1, 0) or 0
			local dec = slot and slot.dec or 0
			local live = false

			local function tag(v)
				if dec > 0 then
					return string.format("%." .. dec .. "f", v) .. (slot.suffix or "")
				end

				return string.format("%d", math.floor(v + 0.5)) .. (slot.suffix or "")
			end

			local function snap(v)
				v = math.clamp(v, slot.min, slot.max)

				if step > 0 then
					v = slot.min + math.floor((v - slot.min) / step + 0.5) * step
				end

				if dec > 0 then
					v = tonumber(string.format("%." .. dec .. "f", v)) or v
				end

				return math.clamp(v, slot.min, slot.max)
			end

			local function meter()
				if not slot then
					return
				end

				local range = slot.max - slot.min
				local k = (range > 0) and (bd.value - slot.min) / range or 0

				worth.Text = tag(bd.value)

				anim(fill, live and glide or quick, {
					Size = UDim2.new(k, math.floor(6 * (1 - k) + 0.5), 1, 0),
				})
			end

			local function shade()
				for i = 1, #picks do
					local o = picks[i]
					local sel = bd.mode == o.name

					anim(o.lbl, quick, {
						TextTransparency = sel and 0 or (o.warm and 0.2 or 0.45),
						TextColor3 = sel and th.text or th.dim,
					})

					if sel and glider then
						anim(glider, soft, { Position = UDim2.new(0.5 * (o.slot - 1), 2, 0, 2) })
					end
				end
			end

			local function tint()
				shown.Text = bd.hunting and "..." or keyname(bd.key)

				anim(pill, soft, { BackgroundTransparency = bd.hunting and 0 or 0.12 })
				anim(ring, soft, { Transparency = bd.hunting and 0.22 or 0.62 })
				anim(beam, soft, { BackgroundTransparency = bd.hunting and 0.25 or 1 })
				anim(shown, soft, {
					TextTransparency = bd.key and 0.05 or 0.35,
					TextColor3 = bd.hunting and th.accent or (bd.key and th.text or th.dim),
				})
				anim(wipepip, soft, { ImageTransparency = bd.key and 0.25 or 0.7 })
			end

			local function post()
				if not bd.key then
					unperch(opt.id)

					return
				end

				perch(opt.id, {
					name = title,
					key = keyname(bd.key),
					art = opt.art,
					press = opt.press,
					worth = opt.show and opt.show() or nil,
					lit = opt.state and opt.state() or false,
				})
			end

			local function tall()
				return 34 + math.max(math.floor(asz(slab).Y + 0.5), 24)
			end

			local function place()
				local rp, rz = apos(root), asz(root)
				local pp, ps = apos(vue), asz(vue)
				local ap, as = apos(anchor), asz(anchor)
				local rightx = pp.X - rp.X + ps.X + 8
				local leftx = pp.X - rp.X - bd.w - 8
				local x = rightx

				if rightx + bd.w > rz.X - 8 then
					x = (leftx >= 8) and leftx or math.max(8, rz.X - 8 - bd.w)
				end

				local y = math.clamp(
					ap.Y - rp.Y + as.Y * 0.5 - bd.h * 0.5,
					8,
					math.max(8, rz.Y - bd.h - 8)
				)

				hull.Position = UDim2.fromOffset(math.floor(x + 0.5), math.floor(y + 0.5))

				if pit then
					pit.Position = hull.Position
				end
			end

			local function fit()
				bd.h = tall()

				hull.Size = UDim2.fromOffset(bd.w, bd.h)

				if pit then
					pit.Size = hull.Size
				end
			end

			local function slide()
				local from = hull.GroupTransparency
				local to = bd.on and 0 or 1

				flow(hull, bd.on and 0.34 or 0.26, bd.on and outq or inq, function(k)
					local a = from + (to - from) * k

					hull.GroupTransparency = a

					if pit then
						pit.BackgroundTransparency = a
						cast.Transparency = 0.35 + 0.65 * a
					end

					if k >= 1 then
						hull.Visible = bd.on

						if pit then
							pit.Visible = bd.on
						end
					end
				end)
			end

			local track = nil

			local function untrack()
				if track then
					track:Disconnect()
					track = nil
				end
			end

			local function shut()
				bd:setopen(false)
			end

			local function follow()
				if locks > 0 then
					place()

					return
				end

				if not win.open or not pg.Visible or not anchor.Visible then
					bd:setopen(false)

					return
				end

				local vp, vs = vue.AbsolutePosition, vue.AbsoluteSize
				local hp, hs = keep.AbsolutePosition, keep.AbsoluteSize
				local ap, as = anchor.AbsolutePosition, anchor.AbsoluteSize
				local mid = ap.Y + as.Y * 0.5

				if mid < vp.Y or mid > vp.Y + vs.Y or mid < hp.Y or mid > hp.Y + hs.Y then
					bd:setopen(false)

					return
				end

				place()
			end

			function bd:setopen(v)
				v = v and true or false

				if bd.on == v then
					return
				end

				bd.on = v

				if v then
					sink()
					hush(bd)
					fit()

					veil.Visible = true
					hull.Visible = true

					if pit then
						pit.Visible = true
					end

					place()

					sky = shut
					skyzone = hull

					untrack()

					track = rs.RenderStepped:Connect(follow)
				else
					untrack()

					veil.Visible = false

					if bd.hunting then
						bd.hunting = false

						capture(nil)
						tint()
					end

					if sky == shut then
						sky = nil
						skyzone = nil
					end
				end

				slide()
			end

			local flick = 0

			function bd:flip()
				local now = os.clock()

				if now - flick < 0.2 then
					return false
				end

				flick = now

				if bd.on and (inside(hull, 2) or (pit and inside(pit, 2))) then
					return false
				end

				bd:setopen(not bd.on)

				return true
			end

			local function shed()
				if overkeys() then
					return
				end

				flick = os.clock()

				bd:setopen(false)
			end

			conn(veil.MouseButton1Click, shed)
			conn(veil.MouseButton2Click, shed)

			function bd:setkey(v)
				local k = v

				if type(k) == "string" then
					k = select(2, pcall(function()
						return Enum.KeyCode[v]
					end))
				end

				if typeof(k) ~= "EnumItem" or k == Enum.KeyCode.Unknown then
					k = nil
				end

				if bd.key == k then
					return
				end

				if bd.live then
					bd.live = false

					opt.fire(false)
				end

				bd.key = k

				tint()
				post()
			end

			function bd:setmode(m)
				if m ~= "toggle" and m ~= "hold" then
					return
				end

				if bd.mode == m then
					return
				end

				if bd.live then
					bd.live = false

					opt.fire(false)
				end

				bd.mode = m

				shade()
			end

			function bd:setvalue(v)
				if not slot then
					return
				end

				v = snap(tonumber(v) or slot.min)

				if bd.value == v then
					return
				end

				bd.value = v

				meter()

				if bd.key then
					post()
				end
			end

			function bd:sync(v)
				bd.live = v and true or false
			end

			function bd:lit(v)
				relight(opt.id, v)
			end

			bd.fire = opt.fire

			local function halt()
				bd.hunting = false

				tint()
			end

			conn(hit.MouseButton1Click, function()
				if bd.hunting then
					capture(nil)
					halt()

					return
				end

				bd.hunting = true

				tint()

				shitaroebet:chime("flip")

				capture(function(k)
					halt()

					if k then
						bd:setkey(k)

						shitaroebet:chime("tap")
					end
				end, halt)
			end)

			conn(wipe.MouseButton1Click, function()
				if bd.hunting then
					capture(nil)
					halt()
				end

				if not bd.key then
					return
				end

				bd:setkey(nil)

				wipepip.ImageColor3 = th.accent

				anim(wipepip, soft, { ImageColor3 = th.dim })

				shitaroebet:chime("off")
			end)

			conn(wipe.MouseEnter, function()
				anim(wipe, soft, { BackgroundTransparency = 0.4 })
				anim(wipepip, soft, { ImageTransparency = 0, ImageColor3 = th.text })
			end)

			conn(wipe.MouseLeave, function()
				anim(wipe, soft, { BackgroundTransparency = 1 })
				anim(wipepip, soft, {
					ImageTransparency = bd.key and 0.25 or 0.7,
					ImageColor3 = th.dim,
				})
			end)

			for i = 1, #picks do
				local o = picks[i]

				conn(o.btn.MouseEnter, function()
					o.warm = true

					shade()
				end)

				conn(o.btn.MouseLeave, function()
					o.warm = false

					shade()
				end)

				conn(o.btn.MouseButton1Click, function()
					bd:setmode(o.name)

					shitaroebet:chime("tap")
				end)
			end

			shade()

			if slot then
				conn(grab.InputBegan, function(i)
					if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then
						return
					end

					if live then
						return
					end

					live = true

					latch(1)

					shitaroebet:chime("tap")

					while live and (uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or i.UserInputState ~= Enum.UserInputState.End) do
						local p, s = dial.AbsolutePosition, dial.AbsoluteSize

						if s.X > 0 then
							bd:setvalue(slot.min + (slot.max - slot.min) * math.clamp((mouse.X - p.X) / s.X, 0, 1))
						end

						task.wait()
					end

					live = false

					latch(-1)
					meter()
				end)

				conn(grab.InputEnded, function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						live = false
					end
				end)

				conn(uis.InputEnded, function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						live = false
					end
				end)

				bd.value = snap(bd.value)

				meter()
			end

			conn(slab:GetPropertyChangedSignal("AbsoluteSize"), function()
				if bd.on then
					fit()
					place()
				end
			end)

			conn(uis.InputBegan, function(i)
				if not bd.on or locks > 0 or overkeys() then
					return
				end

				if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				if inside(hull, 2) or (pit and inside(pit, 2)) then
					return
				end

				task.defer(function()
					if bd.on then
						bd:setopen(false)
					end
				end)
			end)

			conn(uis.InputBegan, function(i, typing)
				if typing or shitaroebet.capturing or not bd.key or not shitaroebet.alive then
					return
				end

				if i.UserInputType ~= Enum.UserInputType.Keyboard or i.KeyCode ~= bd.key then
					return
				end

				if not opt.mode then
					opt.fire(true)

					return
				end

				if bd.mode == "hold" then
					if bd.live then
						return
					end

					bd.live = true

					opt.fire(true)
				else
					bd.live = not bd.live

					opt.fire(bd.live)
				end
			end)

			conn(uis.InputEnded, function(i)
				if bd.mode ~= "hold" or not bd.key or not bd.live then
					return
				end

				if i.UserInputType ~= Enum.UserInputType.Keyboard or i.KeyCode ~= bd.key then
					return
				end

				bd.live = false

				opt.fire(false)
			end)

			tint()

			table.insert(hive, bd)

			shitaroebet:hook(opt.id .. "|bind", "key", function()
				return bd.key and bd.key.Name or nil
			end, function(v)
				bd:setkey(v)
			end)

			if opt.mode then
				shitaroebet:hook(opt.id .. "|bindmode", "list", function()
					return bd.mode
				end, function(v)
					bd:setmode(v)
				end)
			end

			if slot then
				shitaroebet:hook(opt.id .. "|bindvalue", "number", function()
					return bd.value
				end, function(v)
					bd:setvalue(v)
				end)
			end

			return bd
		end

		function api:section(cfg)
			cfg = params(cfg, {
				name = "section",
				side = "left",
			})

			local col = lane(cfg.side)
			local panel, rec = crate(col)
			local seek = { slot = rec, name = cfg.name, rows = {} }
			local base = trail .. "|" .. cfg.name

			table.insert(cards, seek)

			new("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 0),
			}, panel)

			local top = new("Frame", {
				Name = rnd(),
				Size = UDim2.new(1, 0, 0, 32),
				BackgroundColor3 = th.head,
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				LayoutOrder = 1,
				ZIndex = 5,
			}, panel)

			round(top, 7)

			new("Frame", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0, 1),
				Position = UDim2.fromScale(0, 1),
				Size = UDim2.new(1, 0, 0, 8),
				BackgroundColor3 = th.head,
				BackgroundTransparency = 0,
				BorderSizePixel = 0,
				ZIndex = 5,
			}, top)

			new("TextLabel", {
				Name = rnd(),
				Position = UDim2.fromOffset(10, 0),
				Size = UDim2.new(1, -38, 1, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = cfg.name,
				TextColor3 = th.text,
				TextSize = 13,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 6,
			}, top)

			local caret = new("ImageLabel", {
				Name = rnd(),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -9, 0.5, 0),
				Size = UDim2.fromOffset(13, 13),
				BackgroundTransparency = 1,
				Image = icon("chevron-down"),
				ImageColor3 = th.dim,
				ImageTransparency = 0.35,
				Rotation = 180,
				ZIndex = 6,
			}, top)

			local grab = new("ImageButton", {
				Name = rnd(),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ImageTransparency = 1,
				ZIndex = 7,
			}, top)

			local rule = new("Frame", {
				Name = rnd(),
				Size = UDim2.new(1, 0, 0, 2),
				BackgroundColor3 = th.accent,
				BackgroundTransparency = 0.45,
				BorderSizePixel = 0,
				LayoutOrder = 2,
				ZIndex = 6,
			}, panel)

			fade(rule, 0, {
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.12, 0.2),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.88, 0.2),
				NumberSequenceKeypoint.new(1, 1),
			})

			local hold = new("Frame", {
				Name = rnd(),
				Size = UDim2.new(1, 0, 0, 0),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				LayoutOrder = 3,
				ZIndex = 5,
			}, panel)

			local items = new("Frame", {
				Name = rnd(),
				Size = UDim2.new(1, 0, 0, 0),
				AutomaticSize = Enum.AutomaticSize.Y,
				BackgroundTransparency = 1,
				ZIndex = 5,
			}, hold)

			new("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 1),
			}, items)

			new("UIPadding", {
				PaddingTop = UDim.new(0, 6),
				PaddingBottom = UDim.new(0, 8),
				PaddingLeft = UDim.new(0, 5),
				PaddingRight = UDim.new(0, 5),
			}, items)

			local sec = { panel = panel, items = items, n = 0, open = true }

			conn(items:GetPropertyChangedSignal("AbsoluteSize"), function()
				if sec.open and not sec.glide then
					hold.Size = UDim2.new(1, 0, 0, asz(items).Y)
				end
			end)

			function sec.refit()
				local h0 = hold.Size.Y.Offset

				sec.glide = true

				task.defer(function()
					local h1 = sec.open and asz(items).Y or 0

					flow(hold, 0.32, (h1 >= h0) and outq or inq, function(k)
						hold.Size = UDim2.new(1, 0, 0, math.floor(h0 + (h1 - h0) * k + 0.5))

						if k >= 1 then
							sec.glide = false
							hold.Size = UDim2.new(1, 0, 0, sec.open and asz(items).Y or 0)
						end
					end)
				end)
			end

			function sec:setopen(v)
				sec.open = v and true or false

				local r0, r1 = caret.Rotation, sec.open and 180 or 0

				flow(caret, 0.34, outq, function(k)
					caret.Rotation = r0 + (r1 - r0) * k
				end)

				sec.refit()
			end

			seek.fit = sec.refit

			seek.gate = function(v)
				if v == nil then
					if seek.kept ~= nil then
						local back = seek.kept

						seek.kept = nil

						if sec.open ~= back then
							sec:setopen(back)
						end
					end

					return
				end

				if v and not sec.open then
					if seek.kept == nil then
						seek.kept = false
					end

					sec:setopen(true)
				end
			end

			conn(grab.MouseButton1Click, function()
				sec:setopen(not sec.open)

				shitaroebet:chime("flip")
			end)

			conn(grab.MouseEnter, function()
				anim(caret, soft, { ImageTransparency = 0.1 })
			end)

			conn(grab.MouseLeave, function()
				anim(caret, soft, { ImageTransparency = 0.35 })
			end)

			local host = { frame = items, va = col.frame, vb = hold }
			local kits = { "toggle", "slider", "keybind", "dropdown", "combo", "color", "button", "label" }

			local function branch(nest, va, vb)
				local sub = {}

				for _, k in next, kits do
					sub[k] = function(_, cfg)
						local pf, pa, pb = host.frame, host.va, host.vb

						host.frame, host.va, host.vb = nest, va, vb

						local ok, res = pcall(sec[k], sec, cfg)

						host.frame, host.va, host.vb = pf, pa, pb

						if not ok then
							error(res, 2)
						end

						table.remove(seek.rows)

						return res
					end
				end

				return sub
			end

			local function bloom(anchor, title, vue, keep)
				local pod = { on = false, w = 0, h = 0 }

				local veil = new("ImageButton", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					Visible = false,
					ZIndex = 22,
				}, root)

				local pit = native and new("Frame", {
					Name = rnd(),
					Size = UDim2.fromOffset(0, 0),
					BackgroundColor3 = th.panel,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Visible = false,
					ZIndex = 23,
				}, root) or nil

				local cast = pit and new("UIShadow", {
					Color = th.bg,
					BlurRadius = UDim.new(0, 14),
					Offset = UDim2.fromOffset(0, 4),
					Spread = UDim2.fromOffset(-2, -2),
					Transparency = 1,
					ZIndex = -1,
				}, pit) or nil

				if pit then
					round(pit, 7)
				end

				local husk = new("CanvasGroup", {
					Name = rnd(),
					Size = UDim2.fromOffset(0, 0),
					BackgroundColor3 = th.panel,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					GroupTransparency = 1,
					Visible = false,
					ZIndex = 24,
				}, root)

				round(husk, 7)

				new("UIGradient", {
					Rotation = 90,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 178, 190)),
					}),
				}, husk)

				local brim = new("Frame", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 26,
				}, husk)

				round(brim, 7)

				new("UIStroke", { Color = th.line, Transparency = 0.6 }, brim)

				local pane = new("Frame", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 24,
				}, husk)

				local cap = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, 30),
					BackgroundColor3 = th.head,
					BorderSizePixel = 0,
					ZIndex = 24,
				}, pane)

				round(cap, 7)

				new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0, 1),
					Position = UDim2.fromScale(0, 1),
					Size = UDim2.new(1, 0, 0, 8),
					BackgroundColor3 = th.head,
					BorderSizePixel = 0,
					ZIndex = 24,
				}, cap)

				new("ImageLabel", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 10, 0.5, 0),
					Size = UDim2.fromOffset(12, 12),
					BackgroundTransparency = 1,
					Image = icon("sliders-horizontal"),
					ImageColor3 = th.dim,
					ImageTransparency = 0.3,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 25,
				}, cap)

				new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(28, 0),
					Size = UDim2.new(1, -36, 1, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = title,
					TextColor3 = th.text,
					TextSize = 13,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 25,
				}, cap)

				local rule = new("Frame", {
					Name = rnd(),
					Position = UDim2.fromOffset(0, 30),
					Size = UDim2.new(1, 0, 0, 2),
					BackgroundColor3 = th.accent,
					BackgroundTransparency = 0.45,
					BorderSizePixel = 0,
					ZIndex = 25,
				}, pane)

				fade(rule, 0, {
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(0.12, 0.2),
					NumberSequenceKeypoint.new(0.5, 0),
					NumberSequenceKeypoint.new(0.88, 0.2),
					NumberSequenceKeypoint.new(1, 1),
				})

				local roll = new("ScrollingFrame", {
					Name = rnd(),
					Active = false,
					Position = UDim2.fromOffset(0, 32),
					Size = UDim2.new(1, 0, 1, -32),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(),
					ScrollBarThickness = 0,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					ZIndex = 24,
				}, pane)

				local slab = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 24,
				}, roll)

				new("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 1),
				}, slab)

				new("UIPadding", {
					PaddingTop = UDim.new(0, 6),
					PaddingBottom = UDim.new(0, 8),
					PaddingLeft = UDim.new(0, 5),
					PaddingRight = UDim.new(0, 5),
				}, slab)

				local function gauge()
					local rz = asz(root)
					local wide = math.floor(asz(vue).X + 0.5)

					return math.clamp(wide, 160, math.max(math.floor(rz.X) - 24, 160))
				end

				local function tall()
					local rz = asz(root)
					local body = math.max(math.floor(asz(slab).Y + 0.5), 26)

					return math.clamp(32 + body, 64, math.max(math.floor(rz.Y) - 24, 64))
				end

				local function place()
					local rp, rz = apos(root), asz(root)
					local pp, ps = apos(vue), asz(vue)
					local ap, as = apos(anchor), asz(anchor)
					local rightx = pp.X - rp.X + ps.X + 8
					local leftx = pp.X - rp.X - pod.w - 8
					local x = rightx

					if rightx + pod.w > rz.X - 8 then
						x = (leftx >= 8) and leftx or math.max(8, rz.X - 8 - pod.w)
					end

					local y = math.clamp(
						ap.Y - rp.Y + as.Y * 0.5 - pod.h * 0.5,
						8,
						math.max(8, rz.Y - pod.h - 8)
					)

					husk.Position = UDim2.fromOffset(math.floor(x + 0.5), math.floor(y + 0.5))

					if pit then
						pit.Position = husk.Position
					end
				end

				local function slide()
					local from = husk.GroupTransparency
					local to = pod.on and 0 or 1

					flow(husk, pod.on and 0.34 or 0.26, pod.on and outq or inq, function(k)
						local a = from + (to - from) * k

						husk.GroupTransparency = a

						if pit then
							pit.BackgroundTransparency = a
							cast.Transparency = 0.4 + 0.6 * a
						end

						if k >= 1 then
							husk.Visible = pod.on

							if pit then
								pit.Visible = pod.on
							end
						end
					end)
				end

				local function fit()
					pod.w = gauge()
					pod.h = tall()

					husk.Size = UDim2.fromOffset(pod.w, pod.h)

					if pit then
						pit.Size = husk.Size
					end
				end

				local track = nil

				local function untrack()
					if track then
						track:Disconnect()
						track = nil
					end
				end

				local function follow()
					if locks > 0 then
						place()

						return
					end

					if not win.open or not pg.Visible or not anchor.Visible then
						pod:setopen(false)

						return
					end

					local vp, vs = vue.AbsolutePosition, vue.AbsoluteSize
					local hp, hs = keep.AbsolutePosition, keep.AbsoluteSize
					local ap, as = anchor.AbsolutePosition, anchor.AbsoluteSize
					local mid = ap.Y + as.Y * 0.5

					if mid < vp.Y or mid > vp.Y + vs.Y or mid < hp.Y or mid > hp.Y + hs.Y then
						pod:setopen(false)

						return
					end

					place()
				end

				function pod:setopen(v)
					v = v and true or false

					if pod.on == v then
						return
					end

					pod.on = v

					if v then
						fit()

						husk.Visible = true
						veil.Visible = true
						roll.CanvasPosition = Vector2.new()

						if pit then
							pit.Visible = true
						end

						place()
						untrack()
						maskadd(husk)

						track = rs.RenderStepped:Connect(follow)
					else
						untrack()
						sink()
						maskdel(husk)

						veil.Visible = false
					end

					slide()
				end

				conn(slab:GetPropertyChangedSignal("AbsoluteSize"), function()
					roll.CanvasSize = UDim2.fromOffset(0, math.floor(asz(slab).Y + 0.5))

					if pod.on then
						fit()
						place()
					end
				end)

				conn(veil.MouseButton1Click, function()
					if locks > 0 then
						return
					end

					pod:setopen(false)
				end)

				pod.frame = husk
				pod.body = slab
				pod.api = branch(slab, roll, roll)

				return pod
			end

			function sec:toggle(t)
				t = params(t, {
					name = "toggle",
					default = false,
					options = false,
					flag = nil,
					callback = nil,
				})

				sec.n += 1

				local nest, vue, keep = host.frame, host.va, host.vb

				local row = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, 26),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = sec.n,
					ZIndex = 5,
				}, nest)

				local box = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 5, 0.5, 0),
					Size = UDim2.fromOffset(16, 16),
					BackgroundColor3 = th.accent,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 6,
				}, row)

				round(box, 4)

				local edge = new("UIStroke", { Color = th.line, Transparency = 0.2 }, box)

				local tick = new("ImageLabel", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromOffset(6, 6),
					BackgroundTransparency = 1,
					Image = icon("check"),
					ImageColor3 = th.bg,
					ImageTransparency = 1,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 7,
				}, box)

				local lbl = new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(29, 0),
					Size = UDim2.new(1, t.options and -60 or -35, 1, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = t.name,
					TextColor3 = th.dim,
					TextSize = 13,
					TextTransparency = 0.35,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 6,
				}, row)

				local btn = new("ImageButton", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					ZIndex = 8,
				}, row)

				local grip = new("ImageButton", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 2, 0.5, 0),
					Size = UDim2.fromOffset(22, 22),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					ZIndex = 9,
				}, row)

				local dots = t.options and new("ImageButton", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -5, 0.5, 0),
					Size = UDim2.fromOffset(21, 21),
					BackgroundColor3 = th.head,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Image = icon("ellipsis"),
					ImageColor3 = th.dim,
					ImageTransparency = 0.35,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 10,
				}, row) or nil

				if dots then
					round(dots, 6)
				end

				table.insert(seek.rows, { row = row, name = t.name })

				local item = { row = row, on = false }
				local warm = false

				if dots then
					local pod = bloom(row, t.name, vue, keep)

					item.pod = pod
					item.options = pod.api

					function item:setoptions(v)
						pod:setopen(v)
					end

					conn(dots.MouseButton1Click, function()
						pod:setopen(not pod.on)

						shitaroebet:chime("flip")
					end)

					conn(dots.MouseEnter, function()
						anim(dots, soft, { ImageTransparency = 0, ImageColor3 = th.text, BackgroundTransparency = 0.45 })
					end)

					conn(dots.MouseLeave, function()
						anim(dots, soft, { ImageTransparency = 0.35, ImageColor3 = th.dim, BackgroundTransparency = 1 })
					end)
				end

				local function paint()
					anim(box, soft, { BackgroundTransparency = item.on and 0.05 or (warm and 0.88 or 1) })
					anim(edge, soft, { Transparency = item.on and 1 or (warm and 0.05 or 0.2) })
					anim(tick, soft, {
						ImageTransparency = item.on and 0 or 1,
						Size = UDim2.fromOffset(item.on and 12 or 6, item.on and 12 or 6),
					})
					anim(lbl, soft, {
						TextTransparency = item.on and 0 or 0.35,
						TextColor3 = item.on and th.text or th.dim,
					})
				end

				function item:set(v, quiet)
					v = v and true or false

					if item.on == v then
						return
					end

					item.on = v
					paint()

					if item.bind then
						item.bind:sync(v)
						item.bind:lit(v)
					end

					if not quiet then
						shitaroebet:chime(v and "on" or "off")

						if t.callback then
							task.spawn(t.callback, v)
						end
					end
				end

				function item:get()
					return item.on
				end

				conn(btn.MouseButton1Click, function()
					item:set(not item.on)
				end)

				conn(grip.MouseButton1Click, function()
					item:set(not item.on)
				end)

				conn(grip.MouseEnter, function()
					warm = true
					paint()
				end)

				conn(grip.MouseLeave, function()
					warm = false
					paint()
				end)

				if t.default then
					item.on = true
					paint()
				end

				local id = t.flag or (base .. "|" .. t.name)

				local bind = bindpod(row, t.name, vue, keep, {
					id = id,
					art = "toggle-right",
					mode = true,
					fire = function(v)
						item:set(v)
					end,
					press = function()
						item:set(not item.on)
					end,
					state = function()
						return item.on
					end,
				})

				item.bind = bind

				bind:lit(item.on)

				conn(btn.MouseButton2Click, function()
					if not bind:flip() then
						return
					end

					shitaroebet:chime("flip")
				end)

				conn(grip.MouseButton2Click, function()
					if not bind:flip() then
						return
					end

					shitaroebet:chime("flip")
				end)

				shitaroebet:hook(id, "toggle", function()
					return item.on
				end, function(v)
					item:set(v == true or v == "true" or v == 1)
				end)

				return item
			end

			function sec:slider(t)
				t = params(t, {
					name = "slider",
					min = 0,
					max = 100,
					default = nil,
					step = 1,
					suffix = "",
					flag = nil,
					callback = nil,
				})

				sec.n += 1

				local nest, vue, keep = host.frame, host.va, host.vb
				local step = math.max(tonumber(t.step) or 1, 0)
				local dec = (step > 0 and step < 1) and #(string.match(tostring(step), "%.(%d+)") or "") or 0

				local row = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, 32),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = sec.n,
					ZIndex = 5,
				}, nest)

				local lbl = new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(5, 1),
					Size = UDim2.new(1, -74, 0, 16),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = t.name,
					TextColor3 = th.dim,
					TextSize = 13,
					TextTransparency = 0.35,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 6,
				}, row)

				local val = new("TextLabel", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0),
					Position = UDim2.new(1, -5, 0, 1),
					Size = UDim2.fromOffset(64, 16),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = "",
					TextColor3 = th.text,
					TextSize = 12,
					TextTransparency = 0.2,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Right,
					ZIndex = 6,
				}, row)

				local track = new("Frame", {
					Name = rnd(),
					Position = UDim2.fromOffset(5, 22),
					Size = UDim2.new(1, -10, 0, 6),
					BackgroundColor3 = th.head,
					BackgroundTransparency = 0.12,
					BorderSizePixel = 0,
					ZIndex = 6,
				}, row)

				new("UICorner", { CornerRadius = UDim.new(1, 0) }, track)

				local fill = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(0, 6, 1, 0),
					BackgroundColor3 = th.accent,
					BackgroundTransparency = 0.1,
					BorderSizePixel = 0,
					ZIndex = 7,
				}, track)

				new("UICorner", { CornerRadius = UDim.new(1, 0) }, fill)

				local grab = new("Frame", {
					Name = rnd(),
					Active = true,
					Position = UDim2.fromOffset(0, 15),
					Size = UDim2.new(1, 0, 0, 17),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 8,
				}, row)

				local item = { row = row, value = t.min }
				local warm, live = false, false

				table.insert(seek.rows, { row = row, name = t.name })

				local function tag(v)
					if dec > 0 then
						return string.format("%." .. dec .. "f", v) .. t.suffix
					end

					return string.format("%d", math.floor(v + 0.5)) .. t.suffix
				end

				local function snap(v)
					v = math.clamp(v, t.min, t.max)

					if step > 0 then
						v = t.min + math.floor((v - t.min) / step + 0.5) * step
					end

					if dec > 0 then
						v = tonumber(string.format("%." .. dec .. "f", v)) or v
					end

					return math.clamp(v, t.min, t.max)
				end

				local function span(k)
					return UDim2.new(k, math.floor(6 * (1 - k) + 0.5), 1, 0)
				end

				local function paint()
					local range = t.max - t.min
					local k = (range > 0) and (item.value - t.min) / range or 0

					val.Text = tag(item.value)

					anim(fill, live and glide or quick, { Size = span(k) })
				end

				local function glow()
					anim(track, soft, { BackgroundTransparency = (live or warm) and 0 or 0.12 })
					anim(fill, soft, { BackgroundTransparency = live and 0 or (warm and 0.04 or 0.1) })
					anim(lbl, soft, { TextTransparency = (live or warm) and 0.1 or 0.35 })
					anim(val, soft, { TextTransparency = (live or warm) and 0 or 0.2 })
				end

				function item:set(v, quiet)
					v = snap(tonumber(v) or t.min)

					if item.value == v then
						return
					end

					item.value = v

					paint()

					if not quiet and t.callback then
						task.spawn(t.callback, v)
					end
				end

				function item:get()
					return item.value
				end

				local function reach()
					local p, s = track.AbsolutePosition, track.AbsoluteSize

					if s.X <= 0 then
						return item.value
					end

					return t.min + (t.max - t.min) * math.clamp((mouse.X - p.X) / s.X, 0, 1)
				end

				conn(grab.InputBegan, function(i)
					if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then
						return
					end

					if live then
						return
					end

					live = true

					latch(1)
					glow()

					vue.ScrollingEnabled = false

					shitaroebet:chime("tap")

					while live and (uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or i.UserInputState ~= Enum.UserInputState.End) do
						item:set(reach())

						task.wait()
					end

					live = false

					vue.ScrollingEnabled = true

					latch(-1)
					paint()
					glow()
				end)

				conn(grab.InputEnded, function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						live = false
					end
				end)

				conn(uis.InputEnded, function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						live = false
					end
				end)

				conn(row.MouseEnter, function()
					warm = true

					glow()
				end)

				conn(row.MouseLeave, function()
					warm = false

					glow()
				end)

				item.value = snap(tonumber(t.default) or t.min)

				paint()

				local id = t.flag or (base .. "|" .. t.name)
				local kept = nil
				local bind

				bind = bindpod(row, t.name, vue, keep, {
					id = id,
					art = "sliders-horizontal",
					mode = true,
					value = {
						min = t.min,
						max = t.max,
						step = step,
						dec = dec,
						suffix = t.suffix,
						default = item.value,
					},
					show = function()
						return tag(bind.value)
					end,
					fire = function(v)
						if v then
							if kept == nil then
								kept = item.value
							end

							item:set(bind.value)
						elseif kept ~= nil then
							item:set(kept)

							kept = nil
						end

						bind:lit(kept ~= nil)
					end,
					press = function()
						bind.live = not bind.live

						bind.fire(bind.live)
					end,
					state = function()
						return kept ~= nil
					end,
				})

				item.bind = bind

				local snoop = new("ImageButton", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, 15),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					ZIndex = 7,
				}, row)

				local function pop()
					if not bind:flip() then
						return
					end

					shitaroebet:chime("flip")
				end

				conn(snoop.MouseButton2Click, pop)

				conn(grab.InputBegan, function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton2 then
						pop()
					end
				end)

				shitaroebet:hook(id, "number", function()
					return item.value
				end, function(v)
					item:set(v)
				end)

				return item
			end

			function sec:keybind(t)
				t = params(t, {
					name = "keybind",
					default = nil,
					flag = nil,
					callback = nil,
				})

				sec.n += 1

				local nest = host.frame

				local row = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, 26),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = sec.n,
					ZIndex = 5,
				}, nest)

				local lbl = new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(5, 0),
					Size = UDim2.new(0.56, -8, 1, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = t.name,
					TextColor3 = th.dim,
					TextSize = 13,
					TextTransparency = 0.35,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 6,
				}, row)

				local pill = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -5, 0.5, 0),
					Size = UDim2.new(0.42, -5, 0, 21),
					BackgroundColor3 = th.head,
					BackgroundTransparency = 0.12,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ZIndex = 6,
				}, row)

				round(pill, 6)

				local ring = new("UIStroke", { Color = th.line, Transparency = 0.62 }, pill)

				local nib = new("ImageLabel", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 5, 0.5, 0),
					Size = UDim2.fromOffset(12, 12),
					BackgroundTransparency = 1,
					Image = icon("keyboard"),
					ImageColor3 = th.dim,
					ImageTransparency = 0.3,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 7,
				}, pill)

				local slit = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.new(0, 22, 0.5, 0),
					Size = UDim2.new(0, 1, 0, 13),
					BackgroundColor3 = th.line,
					BackgroundTransparency = 0.35,
					BorderSizePixel = 0,
					ZIndex = 7,
				}, pill)

				fade(slit, 90, {
					NumberSequenceKeypoint.new(0, 0.85),
					NumberSequenceKeypoint.new(0.5, 0),
					NumberSequenceKeypoint.new(1, 0.85),
				})

				local val = new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(28, 0),
					Size = UDim2.new(1, -33, 1, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = "None",
					TextColor3 = th.text,
					TextSize = 12,
					TextTransparency = 0.1,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Center,
					ZIndex = 7,
				}, pill)

				local beam = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0.5, 1),
					Position = UDim2.fromScale(0.5, 1),
					Size = UDim2.new(1, 0, 0, 1),
					BackgroundColor3 = th.accent,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 8,
				}, pill)

				fade(beam, 0, {
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(0.5, 0),
					NumberSequenceKeypoint.new(1, 1),
				})

				local tap = new("ImageButton", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					ZIndex = 9,
				}, row)

				local pin = { row = row, key = nil, live = false }
				local warm = false

				table.insert(seek.rows, { row = row, name = t.name })

				local function show()
					val.Text = pin.live and "..." or keyname(pin.key)
				end

				local function paint()
					anim(pill, soft, { BackgroundTransparency = pin.live and 0 or (warm and 0.04 or 0.12) })
					anim(ring, soft, { Transparency = pin.live and 0.22 or (warm and 0.45 or 0.62) })
					anim(beam, soft, { BackgroundTransparency = pin.live and 0.25 or 1 })
					anim(slit, soft, { BackgroundTransparency = pin.live and 0.1 or 0.35 })
					anim(val, soft, {
						TextTransparency = pin.live and 0 or 0.1,
						TextColor3 = pin.live and th.accent or th.text,
					})
					anim(nib, soft, {
						ImageTransparency = pin.live and 0 or (warm and 0.1 or 0.3),
						ImageColor3 = pin.live and th.accent or th.dim,
					})
					anim(lbl, soft, { TextTransparency = (pin.live or warm) and 0.1 or 0.35 })
				end

				function pin:set(v, quiet)
					local k = v

					if type(k) == "string" then
						k = select(2, pcall(function()
							return Enum.KeyCode[v]
						end))
					end

					if typeof(k) ~= "EnumItem" or k == pin.key then
						return
					end

					pin.key = k

					show()

					if not quiet and t.callback then
						task.spawn(t.callback, k.Name)
					end
				end

				function pin:get()
					return pin.key and pin.key.Name or nil
				end

				local function halt()
					pin.live = false

					show()
					paint()
				end

				conn(tap.MouseButton1Click, function()
					if pin.live then
						capture(nil)

						halt()

						return
					end

					pin.live = true

					show()
					paint()

					shitaroebet:chime("flip")

					capture(function(k)
						halt()

						if k then
							pin:set(k)

							shitaroebet:chime("tap")
						end
					end, halt)
				end)

				conn(tap.MouseEnter, function()
					warm = true

					paint()
				end)

				conn(tap.MouseLeave, function()
					warm = false

					paint()
				end)

				pin:set(t.default)

				show()
				paint()

				shitaroebet:hook(t.flag or (base .. "|" .. t.name), "key", function()
					return pin:get()
				end, function(v)
					pin:set(v)
				end)

				return pin
			end

			function sec:dropdown(t)
				t = params(t, {
					name = "dropdown",
					list = {},
					default = nil,
					flag = nil,
					callback = nil,
				})

				sec.n += 1

				local nest = host.frame

				local wrap = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, 26),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					LayoutOrder = sec.n,
					ZIndex = 5,
				}, nest)

				local hood = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, 26),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 5,
				}, wrap)

				local lbl = new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(5, 0),
					Size = UDim2.new(0.44, -8, 1, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = t.name,
					TextColor3 = th.dim,
					TextSize = 13,
					TextTransparency = 0.35,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 6,
				}, hood)

				local pill = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -5, 0.5, 0),
					Size = UDim2.new(0.56, -5, 0, 21),
					BackgroundColor3 = th.head,
					BackgroundTransparency = 0.12,
					BorderSizePixel = 0,
					ZIndex = 6,
				}, hood)

				round(pill, 6)

				local ring = new("UIStroke", { Color = th.line, Transparency = 0.62 }, pill)

				local val = new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(9, 0),
					Size = UDim2.new(1, -27, 1, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = "",
					TextColor3 = th.text,
					TextSize = 12,
					TextTransparency = 0.1,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 7,
				}, pill)

				local caret = new("ImageLabel", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -6, 0.5, 0),
					Size = UDim2.fromOffset(11, 11),
					BackgroundTransparency = 1,
					Image = icon("chevron-down"),
					ImageColor3 = th.dim,
					ImageTransparency = 0.3,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 7,
				}, pill)

				local tap = new("ImageButton", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					ZIndex = 9,
				}, hood)

				local cage = new("Frame", {
					Name = rnd(),
					Position = UDim2.fromOffset(5, 28),
					Size = UDim2.new(1, -10, 0, 0),
					BackgroundColor3 = th.bg,
					BackgroundTransparency = 0.28,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ZIndex = 6,
				}, wrap)

				round(cage, 6)

				new("UIStroke", { Color = th.line, Transparency = 0.74 }, cage)

				local crop = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, 0),
					AutomaticSize = Enum.AutomaticSize.Y,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 6,
				}, cage)

				new("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 1),
				}, crop)

				new("UIPadding", {
					PaddingTop = UDim.new(0, 4),
					PaddingBottom = UDim.new(0, 4),
					PaddingLeft = UDim.new(0, 4),
					PaddingRight = UDim.new(0, 4),
				}, crop)

				local drop = { row = wrap, on = false, pick = nil, leaf = {} }

				table.insert(seek.rows, { row = wrap, name = t.name })

				local function shade(o)
					local sel = drop.pick == o.name

					anim(o.tint, quick, { BackgroundTransparency = sel and 0.12 or (o.warm and 0.5 or 1) })
					anim(o.dot, quick, {
						BackgroundTransparency = sel and 0.05 or 1,
						Size = UDim2.fromOffset(sel and 7 or 4, sel and 7 or 4),
					})
					anim(o.lbl, quick, {
						TextTransparency = sel and 0 or (o.warm and 0.18 or 0.45),
						TextColor3 = sel and th.text or th.dim,
					})
				end

				local function slide()
					local h0 = cage.Size.Y.Offset
					local h1 = drop.on and (asz(crop).Y) or 0
					local w0 = wrap.Size.Y.Offset
					local w1 = 26 + (drop.on and (h1 + 6) or 0)
					local r0 = caret.Rotation
					local r1 = drop.on and 180 or 0

					flow(cage, 0.3, drop.on and outq or inq, function(k)
						cage.Size = UDim2.new(1, -10, 0, math.floor(h0 + (h1 - h0) * k + 0.5))
						wrap.Size = UDim2.new(1, 0, 0, math.floor(w0 + (w1 - w0) * k + 0.5))
					end)

					flow(caret, 0.3, outq, function(k)
						caret.Rotation = r0 + (r1 - r0) * k
					end)

					anim(ring, soft, { Transparency = drop.on and 0.38 or 0.62 })
				end

				function drop:setopen(v)
					drop.on = v and true or false

					slide()
				end

				function drop:set(v, quiet)
					if type(v) ~= "string" or v == drop.pick then
						return
					end

					if not table.find(t.list, v) then
						return
					end

					drop.pick = v
					val.Text = v

					for _, o in next, drop.leaf do
						shade(o)
					end

					if not quiet and t.callback then
						task.spawn(t.callback, v)
					end
				end

				function drop:get()
					return drop.pick
				end

				for i, name in next, t.list do
					local o = { name = name, warm = false }

					o.head = new("Frame", {
						Name = rnd(),
						Size = UDim2.new(1, 0, 0, 21),
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						LayoutOrder = i,
						ZIndex = 6,
					}, crop)

					o.tint = new("Frame", {
						Name = rnd(),
						Size = UDim2.fromScale(1, 1),
						BackgroundColor3 = th.panel,
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						ZIndex = 6,
					}, o.head)

					round(o.tint, 5)

					fade(o.tint, 0, {
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(0.7, 0.25),
						NumberSequenceKeypoint.new(1, 0.55),
					})

					o.dot = new("Frame", {
						Name = rnd(),
						AnchorPoint = Vector2.new(0, 0.5),
						Position = UDim2.new(0, 8, 0.5, 0),
						Size = UDim2.fromOffset(4, 4),
						BackgroundColor3 = th.accent,
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						ZIndex = 7,
					}, o.head)

					new("UICorner", { CornerRadius = UDim.new(1, 0) }, o.dot)

					o.lbl = new("TextLabel", {
						Name = rnd(),
						Position = UDim2.fromOffset(22, 0),
						Size = UDim2.new(1, -30, 1, 0),
						BackgroundTransparency = 1,
						Font = Enum.Font.GothamBold,
						Text = name,
						TextColor3 = th.dim,
						TextSize = 12,
						TextTransparency = 0.45,
						TextTruncate = Enum.TextTruncate.AtEnd,
						TextXAlignment = Enum.TextXAlignment.Left,
						ZIndex = 7,
					}, o.head)

					o.btn = new("ImageButton", {
						Name = rnd(),
						Size = UDim2.fromScale(1, 1),
						BackgroundTransparency = 1,
						ImageTransparency = 1,
						ZIndex = 8,
					}, o.head)

					conn(o.btn.MouseEnter, function()
						o.warm = true

						shade(o)
					end)

					conn(o.btn.MouseLeave, function()
						o.warm = false

						shade(o)
					end)

					conn(o.btn.MouseButton1Click, function()
						drop:set(o.name)
						drop:setopen(false)

						shitaroebet:chime("tap")
					end)

					drop.leaf[i] = o
				end

				conn(tap.MouseButton1Click, function()
					drop:setopen(not drop.on)

					shitaroebet:chime("flip")
				end)

				conn(tap.MouseEnter, function()
					anim(lbl, soft, { TextTransparency = 0.1 })
					anim(caret, soft, { ImageTransparency = 0.05 })
					anim(pill, soft, { BackgroundTransparency = 0 })
				end)

				conn(tap.MouseLeave, function()
					anim(lbl, soft, { TextTransparency = 0.35 })
					anim(caret, soft, { ImageTransparency = 0.3 })
					anim(pill, soft, { BackgroundTransparency = 0.12 })
				end)

				drop:set(t.default or t.list[1])

				shitaroebet:hook(t.flag or (base .. "|" .. t.name), "list", function()
					return drop.pick
				end, function(v)
					drop:set(v)
				end)

				return drop
			end

			function sec:combo(t)
				t = params(t, {
					name = "combo",
					list = {},
					default = nil,
					max = 8,
					multi = false,
					flag = nil,
					callback = nil,
				})

				sec.n += 1

				local nest, vue, keep = host.frame, host.va, host.vb
				local pitch = 27
				local cap = math.max(math.floor(tonumber(t.max) or 8), 1)

				local row = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, 26),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = sec.n,
					ZIndex = 5,
				}, nest)

				local lbl = new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(5, 0),
					Size = UDim2.new(0.42, -8, 1, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = t.name,
					TextColor3 = th.dim,
					TextSize = 13,
					TextTransparency = 0.35,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 6,
				}, row)

				local pill = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -5, 0.5, 0),
					Size = UDim2.new(0.58, -5, 0, 22),
					BackgroundColor3 = th.head,
					BackgroundTransparency = 0.12,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ZIndex = 6,
				}, row)

				round(pill, 6)

				local ring = new("UIStroke", { Color = th.line, Transparency = 0.62 }, pill)

				local val = new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(9, 0),
					Size = UDim2.new(1, -28, 1, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = "",
					TextColor3 = th.text,
					TextSize = 12,
					TextTransparency = 0.1,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 7,
				}, pill)

				local beam = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0.5, 1),
					Position = UDim2.fromScale(0.5, 1),
					Size = UDim2.new(1, 0, 0, 1),
					BackgroundColor3 = th.accent,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 9,
				}, pill)

				fade(beam, 0, {
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(0.5, 0),
					NumberSequenceKeypoint.new(1, 1),
				})

				local caret = new("ImageLabel", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -7, 0.5, 0),
					Size = UDim2.fromOffset(12, 12),
					BackgroundTransparency = 1,
					Image = icon("chevron-down"),
					ImageColor3 = th.dim,
					ImageTransparency = 0.3,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 7,
				}, pill)

				local tap = new("ImageButton", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					ZIndex = 10,
				}, pill)

				local veil = new("ImageButton", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					Visible = false,
					ZIndex = 29,
				}, root)

				local pit = native and new("Frame", {
					Name = rnd(),
					Size = UDim2.fromOffset(0, 0),
					BackgroundColor3 = th.panel,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Visible = false,
					ZIndex = 30,
				}, root) or nil

				local cast = pit and new("UIShadow", {
					Color = th.bg,
					BlurRadius = UDim.new(0, 16),
					Offset = UDim2.fromOffset(0, 5),
					Spread = UDim2.fromOffset(-3, -3),
					Transparency = 1,
					ZIndex = -1,
				}, pit) or nil

				if pit then
					round(pit, 8)
				end

				local hull = new("CanvasGroup", {
					Name = rnd(),
					Size = UDim2.fromOffset(0, 0),
					BackgroundColor3 = th.panel,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					GroupTransparency = 1,
					Visible = false,
					ZIndex = 31,
				}, root)

				round(hull, 8)

				new("UIGradient", {
					Rotation = 90,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 178, 190)),
					}),
				}, hull)

				new("ImageButton", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					ZIndex = 1,
				}, hull)

				local brim = new("Frame", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 40,
				}, hull)

				round(brim, 8)

				new("UIStroke", { Color = th.line, Transparency = 0.6 }, brim)

				local roll = new("ScrollingFrame", {
					Name = rnd(),
					Active = false,
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					CanvasSize = UDim2.new(),
					ScrollBarThickness = 0,
					ScrollingDirection = Enum.ScrollingDirection.Y,
					ZIndex = 32,
				}, hull)

				local lay = new("UIListLayout", {
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 2),
				}, roll)

				new("UIPadding", {
					PaddingTop = UDim.new(0, 6),
					PaddingBottom = UDim.new(0, 6),
					PaddingLeft = UDim.new(0, 6),
					PaddingRight = UDim.new(0, 6),
				}, roll)

				local drop = { row = row, on = false, pick = nil, tick = {}, leaf = {}, up = false, w = 0, h = 0 }
				local warm, cue = false, 0

				table.insert(seek.rows, { row = row, name = t.name })

				local function hot(name)
					if t.multi then
						return drop.tick[name] == true
					end

					return drop.pick == name
				end

				local function chosen()
					local out = {}

					for i = 1, #t.list do
						if drop.tick[t.list[i]] then
							table.insert(out, t.list[i])
						end
					end

					return out
				end

				local function shade(o, snap)
					local sel = hot(o.name)
					local aim = o.warm or drop.leaf[cue] == o
					local tw = snap and quick or soft

					anim(o.head, tw, { BackgroundTransparency = sel and 0.08 or (aim and 0.4 or 1) })
					anim(o.edge, tw, { Transparency = sel and 0.7 or 1 })
					anim(o.tint, tw, { BackgroundTransparency = sel and 0.86 or 1 })
					anim(o.bar, tw, {
						Size = UDim2.new(0, 3, 0, sel and 13 or 0),
						BackgroundTransparency = sel and 0.05 or 1,
					})
					anim(o.lbl, tw, {
						TextTransparency = sel and 0 or (aim and 0.15 or 0.45),
						TextColor3 = sel and th.text or th.dim,
					})

					if t.multi then
						anim(o.knob, tw, { BackgroundTransparency = sel and 0.05 or 1 })
						anim(o.pin, tw, { Transparency = sel and 1 or (aim and 0.05 or 0.3) })
						anim(o.nod, tw, {
							ImageTransparency = sel and 0 or 1,
							Size = UDim2.fromOffset(sel and 10 or 4, sel and 10 or 4),
						})
					else
						anim(o.mark, tw, {
							ImageTransparency = sel and 0 or 1,
							Size = UDim2.fromOffset(sel and 12 or 7, sel and 12 or 7),
						})
					end
				end

				local function show()
					if not t.multi then
						val.Text = drop.pick or "None"

						return
					end

					local out = chosen()

					val.Text = #out > 0 and table.concat(out, ", ") or "None"
				end

				local function paint()
					anim(pill, soft, { BackgroundTransparency = (drop.on or warm) and 0 or 0.12 })
					anim(ring, soft, { Transparency = drop.on and 0.3 or (warm and 0.45 or 0.62) })
					anim(beam, soft, { BackgroundTransparency = drop.on and 0.2 or 1 })
					anim(lbl, soft, { TextTransparency = (drop.on or warm) and 0.1 or 0.35 })
					anim(caret, soft, {
						ImageTransparency = (drop.on or warm) and 0.05 or 0.3,
						ImageColor3 = drop.on and th.text or th.dim,
					})
				end

				local function repaint()
					show()

					for i = 1, #drop.leaf do
						shade(drop.leaf[i], true)
					end
				end

				local function tallness()
					return math.clamp(#drop.leaf, 1, cap) * pitch + 10
				end

				local function wideness()
					local wide = 0

					for i = 1, #t.list do
						local ok, sz = pcall(function()
							return txs:GetTextSize(t.list[i], 12, Enum.Font.GothamBold, Vector2.new(4096, 24))
						end)

						if ok and sz then
							wide = math.max(wide, sz.X)
						end
					end

					return math.ceil(wide) + (t.multi and 56 or 52)
				end

				local function place()
					local rp, rz = apos(root), asz(root)
					local pp, ps = apos(pill), asz(pill)
					local x = pp.X - rp.X
					local y = drop.up and (pp.Y - rp.Y - 6) or (pp.Y - rp.Y + ps.Y + 6)

					if x + drop.w > rz.X - 8 then
						x = math.max(8, pp.X - rp.X + ps.X - drop.w)
					end

					hull.Position = UDim2.fromOffset(math.floor(x + 0.5), math.floor(y + 0.5))

					if pit then
						pit.Position = hull.Position
					end
				end

				local function refit()
					drop.h = tallness()

					hull.Size = UDim2.fromOffset(drop.w, drop.h)

					if pit then
						pit.Size = hull.Size
					end

					place()
				end

				local function slide()
					local from = hull.GroupTransparency
					local to = drop.on and 0 or 1
					local r0, r1 = caret.Rotation, drop.on and 180 or 0

					flow(hull, drop.on and 0.34 or 0.26, drop.on and outq or inq, function(k)
						local a = from + (to - from) * k

						hull.GroupTransparency = a

						if pit then
							pit.BackgroundTransparency = a
							cast.Transparency = 0.35 + 0.65 * a
						end

						if k >= 1 then
							hull.Visible = drop.on

							if pit then
								pit.Visible = drop.on
							end
						end
					end)

					flow(caret, 0.3, outq, function(k)
						caret.Rotation = r0 + (r1 - r0) * k
					end)
				end

				local function reveal(o)
					local view = roll.AbsoluteWindowSize.Y / sc
					local full = acs(lay).Y + 12
					local idx = table.find(drop.leaf, o)

					if not idx or view <= 0 or full <= view then
						return
					end

					local y = 6 + (idx - 1) * pitch
					local at = roll.CanvasPosition.Y

					if y < at then
						roll.CanvasPosition = Vector2.new(0, math.max(y - 6, 0))
					elseif y + 25 > at + view then
						roll.CanvasPosition = Vector2.new(0, y + 31 - view)
					end
				end

				local function mark(i)
					local was = drop.leaf[cue]

					cue = i

					if was then
						shade(was, true)
					end

					local now = drop.leaf[cue]

					if now then
						shade(now, true)
						reveal(now)
					end
				end

				local function nudge(d)
					if #drop.leaf == 0 then
						return
					end

					local i = cue + d

					if i < 1 then
						i = #drop.leaf
					elseif i > #drop.leaf then
						i = 1
					end

					mark(i)

					shitaroebet:chime("tap")
				end

				local function commit(o)
					if not o then
						return
					end

					if t.multi then
						drop.tick[o.name] = not drop.tick[o.name] or nil

						repaint()

						shitaroebet:chime(drop.tick[o.name] and "on" or "off")

						if t.callback then
							task.spawn(t.callback, drop:get())
						end

						return
					end

					drop:set(o.name)
					drop:setopen(false)

					shitaroebet:chime("tap")
				end

				local function build()
					for i = 1, #drop.leaf do
						local o = drop.leaf[i]

						for _, c in next, o.cx do
							c:Disconnect()
						end

						o.head:Destroy()
					end

					table.clear(drop.leaf)

					local lead = t.multi and 30 or 11
					local trail = t.multi and 10 or 28

					for i = 1, #t.list do
						local name = t.list[i]
						local o = { name = name, warm = false, cx = {} }

						o.head = new("Frame", {
							Name = rnd(),
							Size = UDim2.new(1, 0, 0, 25),
							BackgroundColor3 = th.head,
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							LayoutOrder = i,
							ZIndex = 32,
						}, roll)

						round(o.head, 6)

						o.edge = new("UIStroke", { Color = th.line, Transparency = 1 }, o.head)

						o.tint = new("Frame", {
							Name = rnd(),
							Size = UDim2.fromScale(1, 1),
							BackgroundColor3 = th.accent,
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							ZIndex = 32,
						}, o.head)

						round(o.tint, 6)

						fade(o.tint, 0, {
							NumberSequenceKeypoint.new(0, 0),
							NumberSequenceKeypoint.new(0.55, 0.62),
							NumberSequenceKeypoint.new(1, 1),
						})

						o.bar = new("Frame", {
							Name = rnd(),
							AnchorPoint = Vector2.new(0, 0.5),
							Position = UDim2.new(0, 1, 0.5, 0),
							Size = UDim2.new(0, 3, 0, 0),
							BackgroundColor3 = th.accent,
							BackgroundTransparency = 1,
							BorderSizePixel = 0,
							ZIndex = 33,
						}, o.head)

						new("UICorner", { CornerRadius = UDim.new(1, 0) }, o.bar)

						if t.multi then
							o.knob = new("Frame", {
								Name = rnd(),
								AnchorPoint = Vector2.new(0, 0.5),
								Position = UDim2.new(0, 9, 0.5, 0),
								Size = UDim2.fromOffset(14, 14),
								BackgroundColor3 = th.accent,
								BackgroundTransparency = 1,
								BorderSizePixel = 0,
								ZIndex = 33,
							}, o.head)

							round(o.knob, 4)

							o.pin = new("UIStroke", { Color = th.line, Transparency = 0.3 }, o.knob)

							o.nod = new("ImageLabel", {
								Name = rnd(),
								AnchorPoint = Vector2.new(0.5, 0.5),
								Position = UDim2.fromScale(0.5, 0.5),
								Size = UDim2.fromOffset(4, 4),
								BackgroundTransparency = 1,
								Image = icon("check"),
								ImageColor3 = th.bg,
								ImageTransparency = 1,
								ScaleType = Enum.ScaleType.Fit,
								ZIndex = 34,
							}, o.knob)
						else
							o.mark = new("ImageLabel", {
								Name = rnd(),
								AnchorPoint = Vector2.new(1, 0.5),
								Position = UDim2.new(1, -9, 0.5, 0),
								Size = UDim2.fromOffset(7, 7),
								BackgroundTransparency = 1,
								Image = icon("check"),
								ImageColor3 = th.accent,
								ImageTransparency = 1,
								ScaleType = Enum.ScaleType.Fit,
								ZIndex = 33,
							}, o.head)
						end

						o.lbl = new("TextLabel", {
							Name = rnd(),
							Position = UDim2.fromOffset(lead, 0),
							Size = UDim2.new(1, -lead - trail, 1, 0),
							BackgroundTransparency = 1,
							Font = Enum.Font.GothamBold,
							Text = name,
							TextColor3 = th.dim,
							TextSize = 12,
							TextTransparency = 0.45,
							TextTruncate = Enum.TextTruncate.AtEnd,
							TextXAlignment = Enum.TextXAlignment.Left,
							ZIndex = 33,
						}, o.head)

						o.btn = new("ImageButton", {
							Name = rnd(),
							Size = UDim2.fromScale(1, 1),
							BackgroundTransparency = 1,
							ImageTransparency = 1,
							ZIndex = 34,
						}, o.head)

						table.insert(o.cx, o.btn.MouseEnter:Connect(function()
							local was = drop.leaf[cue]

							o.warm = true
							cue = 0

							if was and was ~= o then
								shade(was, true)
							end

							shade(o, true)
						end))

						table.insert(o.cx, o.btn.MouseLeave:Connect(function()
							o.warm = false

							shade(o, true)
						end))

						table.insert(o.cx, o.btn.MouseButton1Click:Connect(function()
							commit(o)
						end))

						drop.leaf[i] = o

						shade(o, true)
					end
				end

				local track, ears = nil, nil

				local function untrack()
					if track then
						track:Disconnect()
						track = nil
					end
				end

				local function unears()
					if ears then
						ears:Disconnect()
						ears = nil
					end
				end

				local function shut()
					drop:setopen(false)
				end

				local function follow()
					if locks > 0 then
						place()

						return
					end

					if not win.open or not pg.Visible or not row.Visible then
						shut()

						return
					end

					local vp, vs = vue.AbsolutePosition, vue.AbsoluteSize
					local hp, hs = keep.AbsolutePosition, keep.AbsoluteSize
					local pp, ps = pill.AbsolutePosition, pill.AbsoluteSize
					local mid = pp.Y + ps.Y * 0.5

					if mid < vp.Y or mid > vp.Y + vs.Y or mid < hp.Y or mid > hp.Y + hs.Y then
						shut()

						return
					end

					place()
				end

				local function pilot(i)
					if shitaroebet.capturing or i.UserInputType ~= Enum.UserInputType.Keyboard then
						return
					end

					local k = i.KeyCode

					if k == Enum.KeyCode.Down then
						nudge(1)
					elseif k == Enum.KeyCode.Up then
						nudge(-1)
					elseif k == Enum.KeyCode.Return or k == Enum.KeyCode.KeypadEnter then
						commit(drop.leaf[cue])
					elseif k == Enum.KeyCode.Escape then
						shut()
					end
				end

				function drop:setopen(v)
					v = v and true or false

					if drop.on == v then
						return
					end

					drop.on = v

					if v then
						sink()

						local rp, rz = apos(root), asz(root)
						local pp, ps = apos(pill), asz(pill)

						drop.w = math.clamp(
							math.max(wideness(), math.floor(ps.X + 0.5)),
							130,
							math.max(math.floor(rz.X) - 16, 130)
						)
						drop.h = tallness()

						local under = rz.Y - (pp.Y - rp.Y + ps.Y + 6) - 6
						local over = pp.Y - rp.Y - 12

						drop.up = under < drop.h and over > under

						hull.AnchorPoint = Vector2.new(0, drop.up and 1 or 0)
						hull.Visible = true
						veil.Visible = true
						roll.CanvasPosition = Vector2.new()

						if pit then
							pit.AnchorPoint = hull.AnchorPoint
							pit.Visible = true
						end

						refit()
						repaint()

						if not t.multi then
							for i = 1, #drop.leaf do
								if drop.leaf[i].name == drop.pick then
									cue = i

									shade(drop.leaf[i], true)
									reveal(drop.leaf[i])

									break
								end
							end
						end

						sky = shut
						skyzone = hull

						untrack()
						unears()

						track = rs.RenderStepped:Connect(follow)
						ears = uis.InputBegan:Connect(pilot)
					else
						untrack()
						unears()

						veil.Visible = false
						cue = 0

						if sky == shut then
							sky = nil
							skyzone = nil
						end

						for i = 1, #drop.leaf do
							drop.leaf[i].warm = false

							shade(drop.leaf[i], true)
						end
					end

					paint()
					slide()
				end

				function drop:get()
					if not t.multi then
						return drop.pick
					end

					return chosen()
				end

				function drop:set(v, quiet)
					if t.multi then
						local want = {}

						if type(v) == "table" then
							for _, n in next, v do
								want[n] = true
							end
						elseif type(v) == "string" then
							for n in string.gmatch(v, "[^,]+") do
								want[string.match(n, "^%s*(.-)%s*$")] = true
							end
						else
							return
						end

						table.clear(drop.tick)

						for i = 1, #t.list do
							if want[t.list[i]] then
								drop.tick[t.list[i]] = true
							end
						end

						repaint()

						if not quiet and t.callback then
							task.spawn(t.callback, drop:get())
						end

						return
					end

					if type(v) ~= "string" or v == drop.pick or not table.find(t.list, v) then
						return
					end

					drop.pick = v

					repaint()

					if not quiet and t.callback then
						task.spawn(t.callback, v)
					end
				end

				function drop:setlist(ls)
					if type(ls) ~= "table" then
						return
					end

					local held = t.multi and drop:get() or drop.pick

					t.list = ls
					drop.pick = nil

					table.clear(drop.tick)
					build()

					if t.multi then
						drop:set(held, true)
					elseif held and table.find(ls, held) then
						drop:set(held, true)
					else
						drop:set(ls[1], true)
					end

					show()

					if not drop.on then
						return
					end

					if #ls == 0 then
						shut()

						return
					end

					refit()
				end

				conn(lay:GetPropertyChangedSignal("AbsoluteContentSize"), function()
					roll.CanvasSize = UDim2.fromOffset(0, acs(lay).Y + 12)
				end)

				conn(veil.MouseButton1Click, shut)

				conn(tap.MouseButton1Click, function()
					if #t.list == 0 then
						return
					end

					drop:setopen(not drop.on)

					shitaroebet:chime("flip")
				end)

				conn(tap.MouseEnter, function()
					warm = true

					paint()
				end)

				conn(tap.MouseLeave, function()
					warm = false

					paint()
				end)

				build()

				if t.multi then
					if t.default ~= nil then
						drop:set(t.default)
					end
				else
					drop:set(t.default or t.list[1])
				end

				show()
				paint()

				shitaroebet:hook(t.flag or (base .. "|" .. t.name), "list", function()
					if t.multi then
						return table.concat(drop:get(), ", ")
					end

					return drop.pick
				end, function(v)
					drop:set(v)
				end)

				return drop
			end

			function sec:button(t)
				t = params(t, {
					name = "button",
					icon = nil,
					flag = nil,
					callback = nil,
				})

				sec.n += 1

				local nest, vue, keep = host.frame, host.va, host.vb

				local row = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, 28),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = sec.n,
					ZIndex = 5,
				}, nest)

				local slab = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.new(1, -10, 0, 24),
					BackgroundColor3 = th.head,
					BackgroundTransparency = 0.12,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					ZIndex = 6,
				}, row)

				round(slab, 6)

				local ring = new("UIStroke", { Color = th.line, Transparency = 0.62 }, slab)

				local wash = new("Frame", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundColor3 = th.accent,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 6,
				}, slab)

				round(wash, 6)

				fade(wash, 0, {
					NumberSequenceKeypoint.new(0, 0),
					NumberSequenceKeypoint.new(0.55, 0.62),
					NumberSequenceKeypoint.new(1, 1),
				})

				local art = t.icon and new("ImageLabel", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 9, 0.5, 0),
					Size = UDim2.fromOffset(13, 13),
					BackgroundTransparency = 1,
					Image = icon(t.icon),
					ImageColor3 = th.dim,
					ImageTransparency = 0.25,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 7,
				}, slab) or nil

				local lbl = new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(t.icon and 27 or 9, 0),
					Size = UDim2.new(1, t.icon and -36 or -18, 1, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = t.name,
					TextColor3 = th.dim,
					TextSize = 13,
					TextTransparency = 0.25,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = t.icon and Enum.TextXAlignment.Left or Enum.TextXAlignment.Center,
					ZIndex = 7,
				}, slab)

				local beam = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0.5, 1),
					Position = UDim2.fromScale(0.5, 1),
					Size = UDim2.new(1, 0, 0, 1),
					BackgroundColor3 = th.accent,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 8,
				}, slab)

				fade(beam, 0, {
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(0.5, 0),
					NumberSequenceKeypoint.new(1, 1),
				})

				local tap = new("ImageButton", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					ZIndex = 9,
				}, slab)

				table.insert(seek.rows, { row = row, name = t.name })

				local item = { row = row }
				local warm = false

				local function glow()
					anim(slab, soft, { BackgroundTransparency = warm and 0 or 0.12 })
					anim(ring, soft, { Transparency = warm and 0.4 or 0.62 })
					anim(wash, soft, { BackgroundTransparency = warm and 0.88 or 1 })
					anim(lbl, soft, {
						TextTransparency = warm and 0 or 0.25,
						TextColor3 = warm and th.text or th.dim,
					})

					if art then
						anim(art, soft, {
							ImageTransparency = warm and 0 or 0.25,
							ImageColor3 = warm and th.text or th.dim,
						})
					end
				end

				function item:fire()
					wash.BackgroundTransparency = 0.72
					beam.BackgroundTransparency = 0.15

					anim(wash, soft, { BackgroundTransparency = warm and 0.88 or 1 })
					anim(beam, soft, { BackgroundTransparency = 1 })

					shitaroebet:chime("tap")

					if t.callback then
						task.spawn(t.callback)
					end
				end

				conn(tap.MouseButton1Click, function()
					item:fire()
				end)

				conn(tap.MouseEnter, function()
					warm = true

					glow()
				end)

				conn(tap.MouseLeave, function()
					warm = false

					glow()
				end)

				local bind = bindpod(row, t.name, vue, keep, {
					id = t.flag or (base .. "|" .. t.name),
					art = nil,
					mode = false,
					fire = function(v)
						if v then
							item:fire()
						end
					end,
				})

				item.bind = bind

				conn(tap.MouseButton2Click, function()
					if not bind:flip() then
						return
					end

					shitaroebet:chime("flip")
				end)

				glow()

				return item
			end

			function sec:label(t)
				if type(t) == "string" then
					t = { name = t }
				end

				t = params(t, {
					name = "label",
					icon = nil,
					wrap = false,
					tone = nil,
				})

				sec.n += 1

				local nest = host.frame

				local row = new("Frame", {
					Name = rnd(),
					Size = t.wrap and UDim2.new(1, 0, 0, 0) or UDim2.new(1, 0, 0, 22),
					AutomaticSize = t.wrap and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = sec.n,
					ZIndex = 5,
				}, nest)

				table.insert(seek.rows, { row = row, name = t.name })

				local lead = 5

				if t.icon then
					lead = 24

					new("ImageLabel", {
						Name = rnd(),
						AnchorPoint = Vector2.new(0, 0),
						Position = UDim2.fromOffset(5, 5),
						Size = UDim2.fromOffset(12, 12),
						BackgroundTransparency = 1,
						Image = icon(t.icon),
						ImageColor3 = th.dim,
						ImageTransparency = 0.3,
						ScaleType = Enum.ScaleType.Fit,
						ZIndex = 6,
					}, row)
				end

				local lbl = new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(lead, 0),
					Size = t.wrap and UDim2.new(1, -(lead + 8), 0, 0) or UDim2.new(1, -(lead + 8), 1, 0),
					AutomaticSize = t.wrap and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = tostring(t.name),
					TextColor3 = t.tone or th.dim,
					TextSize = 12,
					TextTransparency = 0.15,
					TextTruncate = (not t.wrap) and Enum.TextTruncate.AtEnd or Enum.TextTruncate.None,
					TextWrapped = t.wrap and true or false,
					TextXAlignment = Enum.TextXAlignment.Left,
					TextYAlignment = t.wrap and Enum.TextYAlignment.Top or Enum.TextYAlignment.Center,
					ZIndex = 6,
				}, row)

				if t.wrap then
					new("UIPadding", {
						PaddingTop = UDim.new(0, 4),
						PaddingBottom = UDim.new(0, 4),
					}, row)
				end

				local item = { row = row, text = lbl }

				function item:set(v)
					lbl.Text = tostring(v)
				end

				function item:get()
					return lbl.Text
				end

				function item:settone(c)
					if typeof(c) == "Color3" then
						lbl.TextColor3 = c
					end
				end

				return item
			end

			function sec:color(t)
				t = params(t, {
					name = "color",
					default = th.accent,
					flag = nil,
					callback = nil,
				})

				if t.key and typeof(th[t.key]) == "Color3" then
					local hook = t.callback

					t.default = th[t.key]

					t.callback = function(c)
						shitaroebet:recolor(t.key, c)

						if hook then
							hook(c)
						end
					end
				end

				sec.n += 1

				local nest, vue, keep = host.frame, host.va, host.vb
				local wide, tall = 178, 178

				local row = new("Frame", {
					Name = rnd(),
					Size = UDim2.new(1, 0, 0, 26),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					LayoutOrder = sec.n,
					ZIndex = 5,
				}, nest)

				local lbl = new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(5, 0),
					Size = UDim2.new(1, -42, 1, 0),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = t.name,
					TextColor3 = th.dim,
					TextSize = 13,
					TextTransparency = 0.35,
					TextTruncate = Enum.TextTruncate.AtEnd,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 6,
				}, row)

				local swatch = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -5, 0.5, 0),
					Size = UDim2.fromOffset(26, 16),
					BackgroundColor3 = t.default,
					BorderSizePixel = 0,
					ZIndex = 6,
				}, row)

				round(swatch, 4)

				local ring = new("UIStroke", { Color = th.line, Transparency = 0.25 }, swatch)

				local sheen = new("Frame", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 7,
				}, swatch)

				round(sheen, 4)

				fade(sheen, 90, {
					NumberSequenceKeypoint.new(0, 0.72),
					NumberSequenceKeypoint.new(1, 1),
				})

				local tap = new("ImageButton", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -3, 0.5, 0),
					Size = UDim2.fromOffset(32, 22),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					ZIndex = 9,
				}, row)

				local veil = new("ImageButton", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					Visible = false,
					ZIndex = 29,
				}, root)

				local pit = native and new("Frame", {
					Name = rnd(),
					Size = UDim2.fromOffset(0, 0),
					BackgroundColor3 = th.panel,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Visible = false,
					ZIndex = 30,
				}, root) or nil

				local cast = pit and new("UIShadow", {
					Color = th.bg,
					BlurRadius = UDim.new(0, 16),
					Offset = UDim2.fromOffset(0, 5),
					Spread = UDim2.fromOffset(-3, -3),
					Transparency = 1,
					ZIndex = -1,
				}, pit) or nil

				if pit then
					round(pit, 8)
				end

				local hull = new("CanvasGroup", {
					Name = rnd(),
					Size = UDim2.fromOffset(0, 0),
					BackgroundColor3 = th.panel,
					BorderSizePixel = 0,
					ClipsDescendants = true,
					GroupTransparency = 1,
					Visible = false,
					ZIndex = 31,
				}, root)

				round(hull, 8)

				new("UIGradient", {
					Rotation = 90,
					Color = ColorSequence.new({
						ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
						ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 178, 190)),
					}),
				}, hull)

				new("ImageButton", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					ZIndex = 1,
				}, hull)

				local brim = new("Frame", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 40,
				}, hull)

				round(brim, 8)

				new("UIStroke", { Color = th.line, Transparency = 0.6 }, brim)

				local sv = new("Frame", {
					Name = rnd(),
					Active = true,
					Position = UDim2.fromOffset(10, 10),
					Size = UDim2.new(1, -20, 0, 110),
					BackgroundColor3 = Color3.fromHSV(0, 1, 1),
					BorderSizePixel = 0,
					ZIndex = 32,
				}, hull)

				round(sv, 6)

				local tintw = new("Frame", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BorderSizePixel = 0,
					ZIndex = 33,
				}, sv)

				round(tintw, 6)

				new("UIGradient", {
					Color = ColorSequence.new(Color3.new(1, 1, 1)),
					Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(1, 1),
					}),
				}, tintw)

				local tintb = new("Frame", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundColor3 = Color3.new(),
					BorderSizePixel = 0,
					ZIndex = 33,
				}, sv)

				round(tintb, 6)

				new("UIGradient", {
					Color = ColorSequence.new(Color3.new()),
					Rotation = 90,
					Transparency = NumberSequence.new({
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(1, 0),
					}),
				}, tintb)

				new("UIStroke", { Color = th.panel, Thickness = 1.5 }, sv)

				local dot = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Size = UDim2.fromOffset(9, 9),
					BackgroundColor3 = th.accent,
					BorderSizePixel = 0,
					ZIndex = 34,
				}, sv)

				new("UICorner", { CornerRadius = UDim.new(1, 0) }, dot)
				new("UIStroke", { Color = th.bg, Transparency = 0.25 }, dot)

				local bar = new("Frame", {
					Name = rnd(),
					Active = true,
					Position = UDim2.fromOffset(10, 128),
					Size = UDim2.new(1, -20, 0, 10),
					BackgroundColor3 = Color3.new(1, 1, 1),
					BorderSizePixel = 0,
					ZIndex = 32,
				}, hull)

				round(bar, 5)

				new("UIStroke", { Color = th.panel, Thickness = 1.5 }, bar)

				local keys = {}

				for i = 0, 6 do
					table.insert(keys, ColorSequenceKeypoint.new(i / 6, Color3.fromHSV(i / 6, 1, 1)))
				end

				new("UIGradient", { Color = ColorSequence.new(keys) }, bar)

				local pin = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0, 0.5),
					Size = UDim2.fromOffset(4, 16),
					BackgroundColor3 = th.accent,
					BorderSizePixel = 0,
					ZIndex = 34,
				}, bar)

				new("UICorner", { CornerRadius = UDim.new(1, 0) }, pin)
				new("UIStroke", { Color = th.bg, Transparency = 0.25 }, pin)

				local field = new("TextBox", {
					Name = rnd(),
					Position = UDim2.fromOffset(10, 146),
					Size = UDim2.new(1, -78, 0, 22),
					BackgroundColor3 = th.head,
					BorderSizePixel = 0,
					ClearTextOnFocus = false,
					ClipsDescendants = true,
					Font = Enum.Font.GothamBold,
					Text = hexof(t.default),
					TextColor3 = th.text,
					TextSize = 13,
					ZIndex = 32,
				}, hull)

				round(field, 5)

				local hem = new("UIStroke", {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = th.line,
					Transparency = 0.65,
				}, field)

				local function nib(x, art)
					local b = new("ImageButton", {
						Name = rnd(),
						AnchorPoint = Vector2.new(1, 0),
						Position = UDim2.new(1, x, 0, 147),
						Size = UDim2.fromOffset(20, 20),
						BackgroundColor3 = th.head,
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						Image = icon(art),
						ImageColor3 = th.dim,
						ImageTransparency = 0.25,
						ScaleType = Enum.ScaleType.Fit,
						ZIndex = 32,
					}, hull)

					round(b, 5)

					conn(b.MouseEnter, function()
						anim(b, soft, { ImageTransparency = 0, ImageColor3 = th.text, BackgroundTransparency = 0.4 })
					end)

					conn(b.MouseLeave, function()
						anim(b, soft, { ImageTransparency = 0.25, ImageColor3 = th.dim, BackgroundTransparency = 1 })
					end)

					return b
				end

				local copier = nib(-34, "copy")
				local paster = nib(-10, "clipboard-paste")

				local item = { row = row, on = false, color = t.default, up = false }
				local st = { h = 0, s = 1, v = 1, hold = false }
				local warm = false

				table.insert(seek.rows, { row = row, name = t.name })

				st.h, st.s, st.v = Color3.toHSV(t.default)

				local function glow()
					anim(ring, soft, { Transparency = (item.on or warm) and 0 or 0.25 })
					anim(lbl, soft, { TextTransparency = (item.on or warm) and 0.1 or 0.35 })
					anim(swatch, soft, {
						Size = UDim2.fromOffset((item.on or warm) and 28 or 26, (item.on or warm) and 17 or 16),
					})
				end

				local function paint(fire, snap)
					local c = Color3.fromHSV(st.h, st.s, st.v)
					local spot = UDim2.fromScale(st.s, 1 - st.v)
					local seat = UDim2.new(st.h, 0, 0.5, 0)

					if snap then
						dot.Position = spot
						pin.Position = seat
						dot.BackgroundColor3 = c
						sv.BackgroundColor3 = Color3.fromHSV(st.h, 1, 1)
						swatch.BackgroundColor3 = c
					else
						anim(dot, quick, { Position = spot, BackgroundColor3 = c })
						anim(pin, quick, { Position = seat })
						anim(sv, quick, { BackgroundColor3 = Color3.fromHSV(st.h, 1, 1) })
						anim(swatch, quick, { BackgroundColor3 = c })
					end

					if not field:IsFocused() then
						field.Text = hexof(c)
					end

					item.color = c

					if fire and t.callback then
						task.spawn(t.callback, c)
					end
				end

				local function place()
					local rp, rz = apos(root), asz(root)
					local sp, ss = apos(swatch), asz(swatch)
					local x = sp.X - rp.X + ss.X - wide
					local y = item.up and (sp.Y - rp.Y - 6) or (sp.Y - rp.Y + ss.Y + 6)

					if x + wide > rz.X - 8 then
						x = rz.X - 8 - wide
					end

					hull.Position = UDim2.fromOffset(math.floor(math.max(x, 8) + 0.5), math.floor(y + 0.5))

					if pit then
						pit.Position = hull.Position
					end
				end

				local function slide()
					local from = hull.GroupTransparency
					local to = item.on and 0 or 1

					flow(hull, item.on and 0.34 or 0.26, item.on and outq or inq, function(k)
						local a = from + (to - from) * k

						hull.GroupTransparency = a

						if pit then
							pit.BackgroundTransparency = a
							cast.Transparency = 0.35 + 0.65 * a
						end

						if k >= 1 then
							hull.Visible = item.on

							if pit then
								pit.Visible = item.on
							end
						end
					end)
				end

				local track = nil

				local function untrack()
					if track then
						track:Disconnect()
						track = nil
					end
				end

				local function shut()
					if locks > 0 then
						return
					end

					item:setopen(false)
				end

				local function follow()
					if locks > 0 then
						place()

						return
					end

					if not win.open or not pg.Visible or not row.Visible then
						item:setopen(false)

						return
					end

					local vp, vs = vue.AbsolutePosition, vue.AbsoluteSize
					local hp, hs = keep.AbsolutePosition, keep.AbsoluteSize
					local sp, ss = swatch.AbsolutePosition, swatch.AbsoluteSize
					local mid = sp.Y + ss.Y * 0.5

					if mid < vp.Y or mid > vp.Y + vs.Y or mid < hp.Y or mid > hp.Y + hs.Y then
						item:setopen(false)

						return
					end

					place()
				end

				function item:setopen(v)
					v = v and true or false

					if item.on == v then
						return
					end

					item.on = v

					if v then
						sink()

						local rp, rz = apos(root), asz(root)
						local sp, ss = apos(swatch), asz(swatch)
						local under = rz.Y - (sp.Y - rp.Y + ss.Y + 6) - 6
						local over = sp.Y - rp.Y - 12

						item.up = under < tall and over > under

						hull.AnchorPoint = Vector2.new(0, item.up and 1 or 0)
						hull.Size = UDim2.fromOffset(wide, tall)
						hull.Visible = true
						veil.Visible = true

						if pit then
							pit.AnchorPoint = hull.AnchorPoint
							pit.Size = hull.Size
							pit.Visible = true
						end

						place()

						sky = shut
						skyzone = hull

						untrack()

						track = rs.RenderStepped:Connect(follow)
					else
						untrack()

						veil.Visible = false

						if sky == shut then
							sky = nil
							skyzone = nil
						end

						if field:IsFocused() then
							field:ReleaseFocus()
						end
					end

					glow()
					slide()
				end

				function item:set(c)
					if typeof(c) == "string" then
						c = fromhex(c)
					end

					if typeof(c) ~= "Color3" then
						return
					end

					st.h, st.s, st.v = Color3.toHSV(c)

					paint(true)
				end

				function item:get()
					return item.color
				end

				local function graze(frame, apply)
					conn(frame.InputBegan, function(i)
						if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then
							return
						end

						if st.hold then
							return
						end

						st.hold = true

						latch(1)

						vue.ScrollingEnabled = false

						while st.hold and (uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or i.UserInputState ~= Enum.UserInputState.End) do
							apply()
							paint(true)

							task.wait()
						end

						st.hold = false

						vue.ScrollingEnabled = true

						latch(-1)
					end)

					conn(frame.InputEnded, function(i)
						if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
							st.hold = false
						end
					end)
				end

				graze(sv, function()
					local p, s = sv.AbsolutePosition, sv.AbsoluteSize

					st.s = math.clamp((mouse.X - p.X) / s.X, 0, 1)
					st.v = 1 - math.clamp((mouse.Y - p.Y) / s.Y, 0, 1)
				end)

				graze(bar, function()
					local p, s = bar.AbsolutePosition, bar.AbsoluteSize

					st.h = math.clamp((mouse.X - p.X) / s.X, 0, 1)
				end)

				conn(uis.InputEnded, function(i)
					if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
						st.hold = false
					end
				end)

				conn(field.Focused, function()
					latch(1)

					anim(hem, soft, { Transparency = 0.35 })
				end)

				conn(field.FocusLost, function()
					latch(-1)

					anim(hem, soft, { Transparency = 0.65 })

					local c = fromhex(field.Text)

					if c then
						st.h, st.s, st.v = Color3.toHSV(c)
					end

					paint(true)
				end)

				local function blink(b)
					b.ImageColor3 = th.accent
					b.ImageTransparency = 0

					anim(b, soft, { ImageColor3 = th.dim, ImageTransparency = 0.25 })
				end

				conn(copier.MouseButton1Click, function()
					if clipput then
						pcall(clipput, hexof(item.color))
					end

					blink(copier)

					shitaroebet:chime("tap")
				end)

				conn(paster.MouseButton1Click, function()
					local grab = clipget and select(2, pcall(clipget))
					local c = fromhex(grab)

					if c then
						st.h, st.s, st.v = Color3.toHSV(c)

						paint(true)
						blink(paster)

						shitaroebet:chime("tap")
					end
				end)

				conn(veil.MouseButton1Click, shut)

				conn(tap.MouseButton1Click, function()
					item:setopen(not item.on)

					shitaroebet:chime("flip")
				end)

				conn(tap.MouseEnter, function()
					warm = true

					glow()
				end)

				conn(tap.MouseLeave, function()
					warm = false

					glow()
				end)

				paint(false, true)
				glow()

				shitaroebet:hook(t.flag or (t.key and ("theme|" .. t.key)) or (base .. "|" .. t.name), "color", function()
					return item.color
				end, function(v)
					item:set(v)
				end)

				return item
			end

			return sec
		end

		function api:color(cfg)
			cfg = params(cfg, {
				name = "color",
				default = th.accent,
				side = "left",
				flag = nil,
				callback = nil,
			})

			if cfg.key and typeof(th[cfg.key]) == "Color3" then
				local hook = cfg.callback

				cfg.default = th[cfg.key]

				cfg.callback = function(c)
					shitaroebet:recolor(cfg.key, c)

					if hook then
						hook(c)
					end
				end
			end

			local col = lane(cfg.side)
			local card, rec = crate(col, 196)

			table.insert(cards, { slot = rec, name = cfg.name, rows = {} })

			local strip = new("Frame", {
				Name = rnd(),
				Size = UDim2.new(1, 0, 0, 28),
				BackgroundColor3 = th.head,
				BorderSizePixel = 0,
				ZIndex = 6,
			}, card)

			round(strip, 7)

			new("Frame", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0, 1),
				Position = UDim2.fromScale(0, 1),
				Size = UDim2.new(1, 0, 0, 8),
				BackgroundColor3 = th.head,
				BorderSizePixel = 0,
				ZIndex = 6,
			}, strip)

			local rule = new("Frame", {
				Name = rnd(),
				Position = UDim2.fromOffset(0, 28),
				Size = UDim2.new(1, 0, 0, 2),
				BackgroundColor3 = th.accent,
				BackgroundTransparency = 0.45,
				BorderSizePixel = 0,
				ZIndex = 7,
			}, card)

			fade(rule, 0, {
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.12, 0.2),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.88, 0.2),
				NumberSequenceKeypoint.new(1, 1),
			})

			new("TextLabel", {
				Name = rnd(),
				Position = UDim2.fromOffset(28, 0),
				Size = UDim2.new(1, -38, 1, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = cfg.name,
				TextColor3 = th.text,
				TextSize = 13,
				TextTruncate = Enum.TextTruncate.AtEnd,
				ZIndex = 7,
			}, strip)

			local chip = new("Frame", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 10, 0.5, 0),
				Size = UDim2.fromOffset(12, 12),
				BackgroundColor3 = cfg.default,
				BorderSizePixel = 0,
				ZIndex = 7,
			}, strip)

			new("UICorner", { CornerRadius = UDim.new(1, 0) }, chip)
			new("UIStroke", { Color = th.line, Transparency = 0.35 }, chip)

			local item = { card = card, color = cfg.default, chip = chip }
			local tail = {}

			function item.apply(c, fire)
				item.color = c

				if fire and cfg.callback then
					task.spawn(cfg.callback, c)
				end
			end

			function item:set(c)
				if typeof(c) == "string" then
					c = fromhex(c)
				end

				if typeof(c) == "Color3" then
					tail.pull(c)
				end
			end

			function item:get()
				return item.color
			end

			local function nib(x, art)
				local b = new("ImageButton", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, x, 0, 175),
					Size = UDim2.fromOffset(20, 20),
					BackgroundColor3 = th.head,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Image = icon(art),
					ImageColor3 = th.dim,
					ImageTransparency = 0.25,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 7,
				}, card)

				round(b, 5)

				conn(b.MouseEnter, function()
					anim(b, soft, { ImageTransparency = 0, ImageColor3 = th.text, BackgroundTransparency = 0.4 })
				end)

				conn(b.MouseLeave, function()
					anim(b, soft, { ImageTransparency = 0.25, ImageColor3 = th.dim, BackgroundTransparency = 1 })
				end)

				return b
			end

			local copier = nib(-32, "copy")
			local paster = nib(-10, "clipboard-paste")

			local function blink(b)
				b.ImageColor3 = th.accent
				b.ImageTransparency = 0

				anim(b, soft, { ImageColor3 = th.dim, ImageTransparency = 0.25 })
			end

			conn(copier.MouseButton1Click, function()
				if clipput then
					pcall(clipput, hexof(item.color))
				end

				blink(copier)
			end)

			conn(paster.MouseButton1Click, function()
				local grab = clipget and select(2, pcall(clipget))
				local c = fromhex(grab)

				if c then
					tail.pull(c)
					blink(paster)
				end
			end)

			inlay(card, item, tail)

			shitaroebet:hook(cfg.flag or (cfg.key and ("theme|" .. cfg.key)) or (trail .. "|" .. cfg.name), "color", function()
				return item.color
			end, function(v)
				item:set(v)
			end)

			return item
		end

		function api:configs(cfg)
			cfg = params(cfg, {
				name = "Configs",
				side = "left",
			})

			local col = lane(cfg.side)
			local card, rec = crate(col, 266)

			table.insert(cards, { slot = rec, name = cfg.name, rows = {} })

			local strip = new("Frame", {
				Name = rnd(),
				Size = UDim2.new(1, 0, 0, 28),
				BackgroundColor3 = th.head,
				BorderSizePixel = 0,
				ZIndex = 6,
			}, card)

			round(strip, 7)

			new("Frame", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0, 1),
				Position = UDim2.fromScale(0, 1),
				Size = UDim2.new(1, 0, 0, 8),
				BackgroundColor3 = th.head,
				BorderSizePixel = 0,
				ZIndex = 6,
			}, strip)

			new("ImageLabel", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 10, 0.5, 0),
				Size = UDim2.fromOffset(13, 13),
				BackgroundTransparency = 1,
				Image = icon("save"),
				ImageColor3 = th.dim,
				ImageTransparency = 0.25,
				ScaleType = Enum.ScaleType.Fit,
				ZIndex = 7,
			}, strip)

			new("TextLabel", {
				Name = rnd(),
				Position = UDim2.fromOffset(30, 0),
				Size = UDim2.new(1, -40, 1, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = cfg.name,
				TextColor3 = th.text,
				TextSize = 13,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 7,
			}, strip)

			local rule = new("Frame", {
				Name = rnd(),
				Position = UDim2.fromOffset(0, 28),
				Size = UDim2.new(1, 0, 0, 2),
				BackgroundColor3 = th.accent,
				BackgroundTransparency = 0.45,
				BorderSizePixel = 0,
				ZIndex = 7,
			}, card)

			fade(rule, 0, {
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.12, 0.2),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.88, 0.2),
				NumberSequenceKeypoint.new(1, 1),
			})

			local list = new("ScrollingFrame", {
				Name = rnd(),
				Position = UDim2.fromOffset(10, 38),
				Size = UDim2.new(1, -20, 0, 128),
				BackgroundColor3 = th.bg,
				BackgroundTransparency = 0.3,
				BorderSizePixel = 0,
				CanvasSize = UDim2.new(),
				ScrollBarThickness = 0,
				ZIndex = 6,
			}, card)

			round(list, 6)

			new("UIStroke", { Color = th.line, Transparency = 0.74 }, list)

			local lay = new("UIListLayout", {
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 2),
			}, list)

			new("UIPadding", {
				PaddingTop = UDim.new(0, 4),
				PaddingBottom = UDim.new(0, 4),
				PaddingLeft = UDim.new(0, 4),
				PaddingRight = UDim.new(0, 4),
			}, list)

			conn(lay:GetPropertyChangedSignal("AbsoluteContentSize"), function()
				list.CanvasSize = UDim2.fromOffset(0, acs(lay).Y + 8)
			end)

			local void = new("TextLabel", {
				Name = rnd(),
				Position = UDim2.fromOffset(10, 38),
				Size = UDim2.new(1, -20, 0, 128),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = "no configs yet",
				TextColor3 = th.dim,
				TextSize = 12,
				TextTransparency = 0.5,
				Visible = false,
				ZIndex = 7,
			}, card)

			local field = new("TextBox", {
				Name = rnd(),
				Position = UDim2.fromOffset(10, 174),
				Size = UDim2.new(1, -20, 0, 26),
				BackgroundColor3 = th.head,
				BorderSizePixel = 0,
				ClearTextOnFocus = false,
				ClipsDescendants = true,
				Font = Enum.Font.GothamBold,
				PlaceholderColor3 = th.dim,
				PlaceholderText = "config name",
				Text = "",
				TextColor3 = th.text,
				TextSize = 13,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 6,
			}, card)

			round(field, 6)

			new("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }, field)

			local brim = new("UIStroke", {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = th.line,
				Transparency = 0.6,
			}, field)

			local deck = new("Frame", {
				Name = rnd(),
				Position = UDim2.fromOffset(10, 208),
				Size = UDim2.new(1, -20, 0, 28),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				ZIndex = 6,
			}, card)

			new("UIListLayout", {
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 6),
			}, deck)

			local note = new("TextLabel", {
				Name = rnd(),
				Position = UDim2.fromOffset(11, 242),
				Size = UDim2.new(1, -22, 0, 14),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = "",
				TextColor3 = th.dim,
				TextSize = 11,
				TextTransparency = 1,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 7,
			}, card)

			local turn, hint = 0, false

			local function say(txt, tone, stay)
				turn += 1
				hint = stay and true or false

				local mine = turn

				note.Text = txt
				note.TextColor3 = tone or th.dim

				anim(note, quick, { TextTransparency = 0.2 })

				if stay then
					return
				end

				task.delay(1.9, function()
					if turn == mine then
						anim(note, soft, { TextTransparency = 1 })
					end
				end)
			end

			local function hush()
				if not hint then
					return
				end

				turn += 1
				hint = false

				anim(note, soft, { TextTransparency = 1 })
			end

			local rows, mark, hail = {}, nil, nil

			local function polish(r)
				local sel = mark == r.name

				anim(r.head, soft, { BackgroundTransparency = sel and 0.02 or 0.06 })
				anim(r.tint, soft, { BackgroundTransparency = sel and 0.12 or (r.warm and 0.5 or 1) })
				anim(r.edge, soft, { Transparency = sel and 0.72 or 1 })
				anim(r.bar, soft, {
					Size = UDim2.new(0, 3, 0, sel and 13 or 0),
					BackgroundTransparency = sel and 0.05 or 1,
				})
				anim(r.img, soft, {
					ImageTransparency = sel and 0 or (r.warm and 0.15 or 0.4),
					ImageColor3 = sel and th.text or th.dim,
				})
				anim(r.lbl, soft, {
					TextTransparency = sel and 0 or (r.warm and 0.15 or 0.4),
					TextColor3 = sel and th.text or th.dim,
				})
			end

			local function repaint()
				for _, r in next, rows do
					polish(r)
				end
			end

			local function pin(name)
				mark = name
				field.Text = name or ""

				repaint()
			end

			local function keep()
				local nm = tidy(field.Text) or mark

				if not nm then
					say("type a name first")

					return
				end

				if shitaroebet:store(nm) then
					mark = nm

					say("saved " .. nm, th.text)
					sweep()
				else
					say("could not write the file")
				end
			end

			local function draw(name)
				local nm = tidy(name) or mark

				if not nm then
					say("select a config first")

					return
				end

				if shitaroebet:fetch(nm) then
					pin(nm)

					say("loaded " .. nm, th.text)
				else
					say("could not read the file")
				end
			end

			local function toss()
				local nm = mark or tidy(field.Text)

				if not nm then
					say("select a config first")

					return
				end

				if shitaroebet:erase(nm) then
					mark = nil
					field.Text = ""

					say("deleted " .. nm, th.text)
					sweep()
				else
					say("could not delete the file")
				end
			end

			local function brand()
				local nm = tidy(field.Text)

				if not mark then
					say("select a config first")

					return
				end

				if not nm then
					say("type a new name")

					return
				end

				local res = shitaroebet:retitle(mark, nm)

				if res then
					pin(res)

					say("renamed to " .. res, th.text)
					sweep()
				else
					say("could not rename the file")
				end
			end

			local function fill(ls)
				for _, r in next, rows do
					for _, c in next, r.cx do
						c:Disconnect()
					end

					r.head:Destroy()
				end

				table.clear(rows)

				if mark and not table.find(ls, mark) then
					mark = nil
				end

				void.Visible = #ls == 0

				for i, name in next, ls do
					local r = { name = name, warm = false, cx = {} }

					r.head = new("Frame", {
						Name = rnd(),
						Size = UDim2.new(1, 0, 0, 25),
						BackgroundColor3 = th.side,
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						LayoutOrder = i,
						ZIndex = 6,
					}, list)

					round(r.head, 6)

					r.edge = new("UIStroke", { Color = th.line, Transparency = 1 }, r.head)

					r.tint = new("Frame", {
						Name = rnd(),
						Size = UDim2.fromScale(1, 1),
						BackgroundColor3 = th.panel,
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						ZIndex = 6,
					}, r.head)

					round(r.tint, 6)

					fade(r.tint, 0, {
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(0.7, 0.25),
						NumberSequenceKeypoint.new(1, 0.55),
					})

					r.bar = new("Frame", {
						Name = rnd(),
						AnchorPoint = Vector2.new(0, 0.5),
						Position = UDim2.new(0, 1, 0.5, 0),
						Size = UDim2.new(0, 3, 0, 0),
						BackgroundColor3 = th.accent,
						BackgroundTransparency = 1,
						BorderSizePixel = 0,
						ZIndex = 7,
					}, r.head)

					new("UICorner", { CornerRadius = UDim.new(1, 0) }, r.bar)

					r.img = new("ImageLabel", {
						Name = rnd(),
						AnchorPoint = Vector2.new(0, 0.5),
						Position = UDim2.new(0, 9, 0.5, 0),
						Size = UDim2.fromOffset(12, 12),
						BackgroundTransparency = 1,
						Image = icon("file-text"),
						ImageColor3 = th.dim,
						ImageTransparency = 1,
						ScaleType = Enum.ScaleType.Fit,
						ZIndex = 7,
					}, r.head)

					r.lbl = new("TextLabel", {
						Name = rnd(),
						Position = UDim2.fromOffset(28, 0),
						Size = UDim2.new(1, -36, 1, 0),
						BackgroundTransparency = 1,
						Font = Enum.Font.GothamBold,
						Text = name,
						TextColor3 = th.dim,
						TextSize = 12,
						TextTransparency = 1,
						TextTruncate = Enum.TextTruncate.AtEnd,
						TextXAlignment = Enum.TextXAlignment.Left,
						ZIndex = 7,
					}, r.head)

					r.btn = new("ImageButton", {
						Name = rnd(),
						Size = UDim2.fromScale(1, 1),
						BackgroundTransparency = 1,
						ImageTransparency = 1,
						ZIndex = 8,
					}, r.head)

					table.insert(r.cx, r.btn.MouseEnter:Connect(function()
						r.warm = true

						polish(r)
					end))

					table.insert(r.cx, r.btn.MouseLeave:Connect(function()
						r.warm = false

						polish(r)
					end))

					table.insert(r.cx, r.btn.MouseButton1Click:Connect(function()
						local now = os.clock()

						if mark == r.name and now - (hail or 0) < 0.4 then
							hail = nil

							draw(r.name)

							return
						end

						hail = now

						pin(r.name)
					end))

					rows[i] = r

					task.delay((i - 1) * 0.03, function()
						if r.head.Parent then
							polish(r)
						end
					end)
				end
			end

			local ord = 0

			local function nub(art, label, fn)
				ord += 1

				local b = new("ImageButton", {
					Name = rnd(),
					Size = UDim2.new(0.25, -4.5, 1, 0),
					BackgroundColor3 = th.head,
					BackgroundTransparency = 0.12,
					BorderSizePixel = 0,
					Image = "",
					LayoutOrder = ord,
					ZIndex = 6,
				}, deck)

				round(b, 6)

				local ring = new("UIStroke", { Color = th.line, Transparency = 0.78 }, b)

				local pip = new("ImageLabel", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromOffset(15, 15),
					BackgroundTransparency = 1,
					Image = icon(art),
					ImageColor3 = th.dim,
					ImageTransparency = 0.25,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 7,
				}, b)

				conn(b.MouseEnter, function()
					anim(b, soft, { BackgroundTransparency = 0 })
					anim(ring, soft, { Transparency = 0.45 })
					anim(pip, soft, { ImageTransparency = 0, ImageColor3 = th.text })

					say(label, th.dim, true)
				end)

				conn(b.MouseLeave, function()
					anim(b, soft, { BackgroundTransparency = 0.12 })
					anim(ring, soft, { Transparency = 0.78 })
					anim(pip, soft, { ImageTransparency = 0.25, ImageColor3 = th.dim })

					hush()
				end)

				conn(b.MouseButton1Click, function()
					pip.ImageColor3 = th.accent

					anim(pip, soft, { ImageColor3 = th.text })

					shitaroebet:chime("tap")

					fn()
				end)

				return b
			end

			nub("save", "save current settings", keep)
			nub("folder", "load selected config", draw)
			nub("file-text", "rename selected config", brand)
			nub("trash-2", "delete selected config", toss)

			conn(field.Focused, function()
				anim(brim, soft, { Transparency = 0.35 })
			end)

			conn(field.FocusLost, function(enter)
				anim(brim, soft, { Transparency = 0.6 })

				if enter then
					keep()
				end
			end)

			shitaroebet:watch(fill)

			local box = {
				card = card,
				list = list,
				refresh = function()
					fill(shitaroebet:roster())
				end,
			}

			function box:get()
				return mark
			end

			function box:select(name)
				pin(tidy(name))
			end

			return box
		end

		function api:gallery(cfg)
			cfg = params(cfg, {
				name = "Gallery",
				icon = "image",
				side = "left",
				height = 250,
				list = {},
				default = nil,
				multi = false,
				thumb = "Asset",
				blank = "image",
				cell = 76,
				gap = 6,
				search = true,
				tools = true,
				reset = false,
				buttons = nil,
				action = nil,
				context = nil,
				empty = "nothing here",
				flag = nil,
				callback = nil,
			})

			local tall = math.clamp(math.floor(tonumber(cfg.height) or 250), 110, 560)
			local hunt = cfg.search and true or false
			local extra = type(cfg.buttons) == "table" and cfg.buttons or {}
			local deckon = (cfg.tools and true or false) or #extra > 0
			local shape = shots[string.lower(tostring(cfg.thumb))]
			local gy = 38 + (hunt and 32 or 0)
			local dy = gy + tall + 8
			local ny = dy + (deckon and 34 or 0)

			local col = lane(cfg.side)
			local card, rec = crate(col, ny + 20)

			table.insert(cards, { slot = rec, name = cfg.name, rows = {} })

			local strip = new("Frame", {
				Name = rnd(),
				Size = UDim2.new(1, 0, 0, 28),
				BackgroundColor3 = th.head,
				BorderSizePixel = 0,
				ZIndex = 6,
			}, card)

			round(strip, 7)

			new("Frame", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0, 1),
				Position = UDim2.fromScale(0, 1),
				Size = UDim2.new(1, 0, 0, 8),
				BackgroundColor3 = th.head,
				BorderSizePixel = 0,
				ZIndex = 6,
			}, strip)

			new("ImageLabel", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 10, 0.5, 0),
				Size = UDim2.fromOffset(13, 13),
				BackgroundTransparency = 1,
				Image = icon(cfg.icon),
				ImageColor3 = th.dim,
				ImageTransparency = 0.25,
				ScaleType = Enum.ScaleType.Fit,
				ZIndex = 7,
			}, strip)

			new("TextLabel", {
				Name = rnd(),
				Position = UDim2.fromOffset(30, 0),
				Size = UDim2.new(1, -96, 1, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = cfg.name,
				TextColor3 = th.text,
				TextSize = 13,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 7,
			}, strip)

			local count = new("TextLabel", {
				Name = rnd(),
				AnchorPoint = Vector2.new(1, 0.5),
				Position = UDim2.new(1, -10, 0.5, 0),
				Size = UDim2.fromOffset(60, 14),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = "0",
				TextColor3 = th.dim,
				TextSize = 11,
				TextTransparency = 0.3,
				TextXAlignment = Enum.TextXAlignment.Right,
				ZIndex = 7,
			}, strip)

			local rule = new("Frame", {
				Name = rnd(),
				Position = UDim2.fromOffset(0, 28),
				Size = UDim2.new(1, 0, 0, 2),
				BackgroundColor3 = th.accent,
				BackgroundTransparency = 0.45,
				BorderSizePixel = 0,
				ZIndex = 7,
			}, card)

			fade(rule, 0, {
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.12, 0.2),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.88, 0.2),
				NumberSequenceKeypoint.new(1, 1),
			})

			local field, brim = nil, nil

			if hunt then
				field = new("TextBox", {
					Name = rnd(),
					Position = UDim2.fromOffset(10, 38),
					Size = UDim2.new(1, -20, 0, 26),
					BackgroundColor3 = th.head,
					BorderSizePixel = 0,
					ClearTextOnFocus = false,
					ClipsDescendants = true,
					Font = Enum.Font.GothamBold,
					PlaceholderColor3 = th.dim,
					PlaceholderText = "search",
					Text = "",
					TextColor3 = th.text,
					TextSize = 13,
					TextXAlignment = Enum.TextXAlignment.Left,
					ZIndex = 6,
				}, card)

				round(field, 6)

				new("UIPadding", { PaddingLeft = UDim.new(0, 30), PaddingRight = UDim.new(0, 10) }, field)

				brim = new("UIStroke", {
					ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
					Color = th.line,
					Transparency = 0.6,
				}, field)

				new("ImageLabel", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0, 0.5),
					Position = UDim2.new(0, 20, 0, 51),
					Size = UDim2.fromOffset(13, 13),
					BackgroundTransparency = 1,
					Image = icon("search"),
					ImageColor3 = th.dim,
					ImageTransparency = 0.3,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 8,
				}, card)
			end

			local list = new("ScrollingFrame", {
				Name = rnd(),
				Position = UDim2.fromOffset(10, gy),
				Size = UDim2.new(1, -20, 0, tall),
				BackgroundColor3 = th.bg,
				BackgroundTransparency = 0.3,
				BorderSizePixel = 0,
				CanvasSize = UDim2.new(),
				ClipsDescendants = true,
				ScrollBarThickness = 0,
				ScrollingDirection = Enum.ScrollingDirection.Y,
				ZIndex = 6,
			}, card)

			round(list, 6)

			local ring = new("UIStroke", { Color = th.line, Transparency = 0.74 }, list)

			local void = new("TextLabel", {
				Name = rnd(),
				Position = UDim2.fromOffset(10, gy),
				Size = UDim2.new(1, -20, 0, tall),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = cfg.empty,
				TextColor3 = th.dim,
				TextSize = 12,
				TextTransparency = 0.5,
				Visible = false,
				ZIndex = 7,
			}, card)

			local deck, note = nil, nil

			if deckon then
				deck = new("Frame", {
					Name = rnd(),
					Position = UDim2.fromOffset(10, dy),
					Size = UDim2.new(1, -20, 0, 28),
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 6,
				}, card)

				new("UIListLayout", {
					FillDirection = Enum.FillDirection.Horizontal,
					SortOrder = Enum.SortOrder.LayoutOrder,
					Padding = UDim.new(0, 6),
				}, deck)
			end

			note = new("TextLabel", {
				Name = rnd(),
				Position = UDim2.fromOffset(11, ny),
				Size = UDim2.new(1, -22, 0, 14),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = "",
				TextColor3 = th.dim,
				TextSize = 11,
				TextTransparency = 1,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 7,
			}, card)

			local turn, stick = 0, false

			local function say(txt, tone, stay)
				turn += 1
				stick = stay and true or false

				local mine = turn

				note.Text = txt
				note.TextColor3 = tone or th.dim

				anim(note, quick, { TextTransparency = 0.2 })

				if stay then
					return
				end

				task.delay(1.9, function()
					if turn == mine then
						anim(note, soft, { TextTransparency = 1 })
					end
				end)
			end

			local function mute()
				if not stick then
					return
				end

				turn += 1
				stick = false

				anim(note, soft, { TextTransparency = 1 })
			end

			local item
			local data, view = {}, {}
			local pick, bag = nil, {}
			local pool, live = {}, 0
			local span, held = 0, {}
			local want = math.clamp(math.floor(tonumber(cfg.cell) or 76), 44, 220)
			local gap = math.max(math.floor(tonumber(cfg.gap) or 6), 2)
			local pad = 5
			local lane, cw, chh, rowh = 1, want, want + 14, want + 20
			local query = ""
			local dirty, tick = true, false

			local function melt(v)
				if type(v) == "string" then
					if v == "" then
						return nil
					end

					return { name = v, label = v }
				end

				if type(v) ~= "table" then
					return nil
				end

				local nm = v.name or v.Name or v.label or v.Label or v.id or v.Id
				if nm == nil then
					return nil
				end

				nm = tostring(nm)

				local id = tonumber(v.id or v.Id or v.ID or v.asset or v.Asset or v.assetid or v.AssetId or v.userid or v.UserId)
				local art = v.image or v.Image or v.icon or v.Icon or v.art or v.thumb or v.Thumb

				return {
					name = nm,
					label = tostring(v.display or v.Display or v.label or v.Label or nm),
					id = id,
					art = (type(art) == "string" or type(art) == "number") and art or nil,
				}
			end

			local function pull(e)
				if e.art then
					return icon(e.art)
				end

				if shape and e.id and e.id > 0 then
					return string.format(shape, e.id)
				end

				return ""
			end

			local function chosen(nm)
				if cfg.multi then
					return bag[nm] == true
				end

				return pick == nm
			end

			local function total()
				if not cfg.multi then
					return pick and 1 or 0
				end

				local n = 0

				for _ in next, bag do
					n += 1
				end

				return n
			end

			local function tag()
				local n = #view
				local all = #data

				if n == all then
					count.Text = (cfg.multi and (total() .. "/" .. all)) or tostring(all)
				else
					count.Text = n .. "/" .. all
				end
			end

			local function value()
				if not cfg.multi then
					return pick
				end

				local out = {}

				for i = 1, #data do
					local nm = data[i].name

					if bag[nm] then
						out[#out + 1] = nm
					end
				end

				return out
			end

			local function shout()
				if cfg.callback and not shitaroebet.quiet then
					task.spawn(cfg.callback, value())
				end
			end

			local function dress(t, instant)
				if not t.head.Visible and not instant then
					return
				end

				local sel = t.name ~= nil and chosen(t.name)
				local hot = t.warm and not sel

				local bt = sel and 0.02 or 0.07
				local tt = sel and 0.1 or (hot and 0.45 or 1)
				local et = sel and 0.35 or (hot and 0.6 or 1)
				local ec = sel and th.accent or th.line
				local lt = sel and 0 or (hot and 0.12 or 0.4)
				local lc = sel and th.text or th.dim
				local it = sel and 0 or (hot and 0.06 or 0.22)

				t.mark.Visible = sel

				if instant then
					t.head.BackgroundTransparency = bt
					t.tint.BackgroundTransparency = tt
					t.edge.Transparency = et
					t.edge.Color = ec
					t.lbl.TextTransparency = lt
					t.lbl.TextColor3 = lc
					t.shot.ImageTransparency = it

					return
				end

				anim(t.head, soft, { BackgroundTransparency = bt })
				anim(t.tint, soft, { BackgroundTransparency = tt })
				anim(t.edge, soft, { Transparency = et, Color = ec })
				anim(t.lbl, soft, { TextTransparency = lt, TextColor3 = lc })
				anim(t.shot, soft, { ImageTransparency = it })
			end

			local function tap(t)
				if not t.name then
					return
				end

				shitaroebet:chime("tap")

				if cfg.multi then
					if bag[t.name] then
						bag[t.name] = nil
					else
						bag[t.name] = true
					end
				else
					if pick == t.name and cfg.reset then
						pick = nil
					else
						pick = t.name
					end
				end

				for i = 1, live do
					dress(pool[i])
				end

				tag()
				shout()
			end

			local function forge()
				local t = { warm = false }

				t.head = new("Frame", {
					Name = rnd(),
					Size = UDim2.fromOffset(cw, chh),
					BackgroundColor3 = th.side,
					BackgroundTransparency = 0.07,
					BorderSizePixel = 0,
					Visible = false,
					ZIndex = 6,
				}, list)

				round(t.head, 6)

				t.edge = new("UIStroke", { Color = th.line, Transparency = 1 }, t.head)

				t.tint = new("Frame", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundColor3 = th.panel,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					ZIndex = 6,
				}, t.head)

				round(t.tint, 6)

				fade(t.tint, 90, {
					NumberSequenceKeypoint.new(0, 0.1),
					NumberSequenceKeypoint.new(0.7, 0.3),
					NumberSequenceKeypoint.new(1, 0.6),
				})

				t.shot = new("ImageLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(4, 4),
					Size = UDim2.fromOffset(cw - 8, cw - 8),
					BackgroundColor3 = th.bg,
					BackgroundTransparency = 0.45,
					BorderSizePixel = 0,
					Image = "",
					ImageColor3 = Color3.new(1, 1, 1),
					ImageTransparency = 0.22,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 7,
				}, t.head)

				round(t.shot, 5)

				t.mark = new("Frame", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0),
					Position = UDim2.new(1, -6, 0, 6),
					Size = UDim2.fromOffset(14, 14),
					BackgroundColor3 = th.accent,
					BorderSizePixel = 0,
					Visible = false,
					ZIndex = 8,
				}, t.head)

				new("UICorner", { CornerRadius = UDim.new(1, 0) }, t.mark)

				new("ImageLabel", {
					Name = rnd(),
					AnchorPoint = Vector2.new(0.5, 0.5),
					Position = UDim2.fromScale(0.5, 0.5),
					Size = UDim2.fromOffset(9, 9),
					BackgroundTransparency = 1,
					Image = icon("check"),
					ImageColor3 = th.bg,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 9,
				}, t.mark)

				t.lbl = new("TextLabel", {
					Name = rnd(),
					Position = UDim2.fromOffset(4, cw - 3),
					Size = UDim2.new(1, -8, 0, 15),
					BackgroundTransparency = 1,
					Font = Enum.Font.GothamBold,
					Text = "",
					TextColor3 = th.dim,
					TextSize = 11,
					TextTransparency = 0.4,
					TextTruncate = Enum.TextTruncate.AtEnd,
					ZIndex = 7,
				}, t.head)

				t.btn = new("ImageButton", {
					Name = rnd(),
					Size = UDim2.fromScale(1, 1),
					BackgroundTransparency = 1,
					ImageTransparency = 1,
					ZIndex = 9,
				}, t.head)

				conn(t.btn.MouseEnter, function()
					t.warm = true

					dress(t)

					if t.name then
						say(t.label or t.name, th.dim, true)
					end
				end)

				conn(t.btn.MouseLeave, function()
					t.warm = false

					dress(t)
					mute()
				end)

				conn(t.btn.MouseButton1Click, function()
					if t.skip then
						t.skip = nil

						return
					end

					tap(t)
				end)

				if type(cfg.context) == "function" then
					local function fire()
						if not t.name then
							return
						end

						shitaroebet:chime("tap")

						local at = t.head.AbsolutePosition + inset()

						task.spawn(cfg.context, t.name, item, at.X + t.head.AbsoluteSize.X * 0.5, at.Y + 12, t.head)
					end

					conn(t.btn.MouseButton2Click, fire)

					conn(t.btn.InputBegan, function(i)
						if i.UserInputType ~= Enum.UserInputType.Touch then
							return
						end

						local mine = os.clock()

						t.hold = mine

						task.delay(0.35, function()
							if t.hold == mine then
								t.hold = nil
								t.skip = true

								fire()
							end
						end)
					end)

					conn(t.btn.InputChanged, function(i)
						if i.UserInputType == Enum.UserInputType.Touch then
							t.hold = nil
						end
					end)

					conn(t.btn.InputEnded, function(i)
						if i.UserInputType == Enum.UserInputType.Touch then
							t.hold = nil
						end
					end)
				end

				if type(cfg.action) == "table" then
					t.act = new("ImageButton", {
						Name = rnd(),
						Position = UDim2.fromOffset(5, 5),
						Size = UDim2.fromOffset(19, 19),
						BackgroundColor3 = th.bg,
						BackgroundTransparency = 0.2,
						BorderSizePixel = 0,
						Image = "",
						ZIndex = 10,
					}, t.head)

					round(t.act, 5)

					new("UIStroke", { Color = th.line, Transparency = 0.6 }, t.act)

					local pin = new("ImageLabel", {
						Name = rnd(),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.fromScale(0.5, 0.5),
						Size = UDim2.fromOffset(12, 12),
						BackgroundTransparency = 1,
						Image = icon(cfg.action.icon or "sliders-horizontal"),
						ImageColor3 = th.text,
						ImageTransparency = 0.15,
						ScaleType = Enum.ScaleType.Fit,
						ZIndex = 11,
					}, t.act)

					conn(t.act.MouseEnter, function()
						anim(t.act, soft, { BackgroundTransparency = 0 })
						anim(pin, soft, { ImageTransparency = 0, ImageColor3 = th.accent })
					end)

					conn(t.act.MouseLeave, function()
						anim(t.act, soft, { BackgroundTransparency = 0.2 })
						anim(pin, soft, { ImageTransparency = 0.15, ImageColor3 = th.text })
					end)

					conn(t.act.MouseButton1Click, function()
						if not t.name then
							return
						end

						shitaroebet:chime("tap")

						local fn = cfg.action.callback

						if type(fn) == "function" then
							local at = t.head.AbsolutePosition + inset()

							task.spawn(fn, t.name, item, at.X + 22, at.Y + 20, t.head)
						end
					end)
				end

				return t
			end

			local function shell(t)
				t.head.Size = UDim2.fromOffset(cw, chh)
				t.shot.Size = UDim2.fromOffset(cw - 8, cw - 8)
				t.lbl.Position = UDim2.fromOffset(4, cw - 3)
			end

			local function metrics()
				local w = asz(list).X - pad * 2

				if w < 20 then
					return false
				end

				local n = math.max(math.floor((w + gap) / (want + gap)), 1)
				local c = math.max(math.floor((w - gap * (n - 1)) / n), 30)

				if n == lane and c == cw then
					return false
				end

				lane, cw = n, c
				chh = cw + 14
				rowh = chh + gap

				for i = 1, #pool do
					shell(pool[i])
				end

				return true
			end

			local function draw()
				local n = #view

				list.CanvasSize = UDim2.fromOffset(0, math.max(math.ceil(n / lane) * rowh - gap + pad * 2, 0))

				local top = list.CanvasPosition.Y
				local seen = asz(list).Y
				local first = math.max(math.floor((top - pad) / rowh), 0)
				local last = math.max(math.ceil((top + seen - pad) / rowh), first + 1)
				local a = first * lane + 1
				local b = math.min(last * lane, n)
				local cap = lane * math.max(last - first + 2, 3)

				if cap ~= span then
					span = cap

					for i = 1, #pool do
						pool[i].name = nil
						pool[i].head.Visible = false
					end
				end

				table.clear(held)

				for i = a, b do
					local e = view[i]

					if e then
						local s = (i - 1) % cap + 1
						local t = pool[s]

						if not t then
							t = forge()
							pool[s] = t
						end

						held[s] = true

						local fresh = t.name ~= e.name
						local r = math.floor((i - 1) / lane)
						local c = (i - 1) % lane

						t.name = e.name
						t.label = e.label

						t.head.Position = UDim2.fromOffset(pad + c * (cw + gap), pad + r * rowh)

						if fresh then
							t.lbl.Text = e.label
							t.shot.Image = pull(e)

							if t.shot.Image == "" then
								t.shot.Image = icon(cfg.blank)
								t.shot.ImageColor3 = th.dim
							else
								t.shot.ImageColor3 = Color3.new(1, 1, 1)
							end
						end

						if not t.head.Visible then
							t.head.Visible = true
						end

						dress(t, fresh)
					end
				end

				for i = 1, #pool do
					if not held[i] then
						local t = pool[i]

						t.name = nil
						t.head.Visible = false
					end
				end

				live = #pool
			end

			local function stir()
				if tick then
					return
				end

				tick = true

				task.defer(function()
					tick = false

					if not rec.live then
						dirty = true

						return
					end

					dirty = false

					metrics()
					draw()
				end)
			end

			local function sieve()
				table.clear(view)

				if query == "" then
					for i = 1, #data do
						view[i] = data[i]
					end
				else
					for i = 1, #data do
						local e = data[i]

						if string.find(string.lower(e.label), query, 1, true) or string.find(string.lower(e.name), query, 1, true) then
							view[#view + 1] = e
						end
					end
				end

				void.Visible = #view == 0
				list.CanvasPosition = Vector2.new(0, math.min(list.CanvasPosition.Y, math.max(math.ceil(#view / math.max(lane, 1)) * rowh - asz(list).Y, 0)))

				tag()
				stir()
			end

			local function soak(ls)
				table.clear(data)

				local seen = {}

				if type(ls) == "table" then
					for _, v in next, ls do
						local e = melt(v)

						if e and not seen[e.name] then
							seen[e.name] = true
							data[#data + 1] = e
						end
					end
				end

				if cfg.multi then
					for nm in next, bag do
						if not seen[nm] then
							bag[nm] = nil
						end
					end
				elseif pick and not seen[pick] then
					pick = nil
				end

				sieve()
			end

			conn(list:GetPropertyChangedSignal("CanvasPosition"), stir)
			conn(list:GetPropertyChangedSignal("AbsoluteSize"), stir)

			conn(list.MouseEnter, function()
				anim(ring, soft, { Transparency = 0.5 })
			end)

			conn(list.MouseLeave, function()
				anim(ring, soft, { Transparency = 0.74 })
			end)

			if field then
				conn(field.Focused, function()
					anim(brim, soft, { Transparency = 0.35 })
				end)

				conn(field.FocusLost, function()
					anim(brim, soft, { Transparency = 0.6 })
				end)

				conn(field:GetPropertyChangedSignal("Text"), function()
					local q = string.lower(string.match(field.Text, "^%s*(.-)%s*$") or "")

					if q == query then
						return
					end

					query = q

					sieve()
				end)
			end

			item = { card = card, list = list, data = data }

			function item:get()
				return value()
			end

			function item:set(v, quiet)
				if cfg.multi then
					table.clear(bag)

					if type(v) == "table" then
						for k, s in next, v do
							if s == true and type(k) == "string" then
								bag[k] = true
							elseif type(s) == "string" and s ~= "" then
								bag[s] = true
							end
						end
					elseif type(v) == "string" and v ~= "" then
						for s in string.gmatch(v, "[^,]+") do
							local nm = string.match(s, "^%s*(.-)%s*$")

							if nm ~= "" then
								bag[nm] = true
							end
						end
					end
				else
					if type(v) == "table" then
						v = v.name or v.Name
					end

					pick = (type(v) == "string" and v ~= "") and v or nil
				end

				for i = 1, live do
					dress(pool[i])
				end

				tag()

				if not quiet then
					shout()
				end
			end

			function item:setdata(ls)
				soak(ls)
			end

			function item:setdefault(v)
				item:set(v, true)
			end

			function item:clear()
				table.clear(bag)

				pick = nil

				for i = 1, live do
					dress(pool[i])
				end

				tag()
				shout()
			end

			function item:all()
				if not cfg.multi then
					return
				end

				for i = 1, #view do
					bag[view[i].name] = true
				end

				for i = 1, live do
					dress(pool[i])
				end

				tag()
				shout()
			end

			function item:refresh()
				sieve()
			end

			function item:values()
				local out = {}

				for i = 1, #data do
					out[i] = data[i].name
				end

				return out
			end

			function item:search(q)
				if field then
					field.Text = tostring(q or "")
				end
			end

			if deck then
				local ord = 0
				local slots = {}

				if cfg.multi then
					slots[#slots + 1] = { icon = "check", tip = "select everything shown", callback = function()
						item:all()
					end }
					slots[#slots + 1] = { icon = "x", tip = "clear selection", callback = function()
						item:clear()
					end }
				elseif cfg.tools then
					slots[#slots + 1] = { icon = "x", tip = "clear selection", callback = function()
						item:clear()
					end }
				end

				if cfg.tools then
					slots[#slots + 1] = { icon = "refresh-cw", tip = "reload the list", callback = function()
						sieve()
					end }
				end

				for _, b in next, extra do
					if type(b) == "table" then
						slots[#slots + 1] = b
					end
				end

				local span = math.max(#slots, 1)

				for _, b in next, slots do
					ord += 1

					local hit = new("ImageButton", {
						Name = rnd(),
						Size = UDim2.new(1 / span, -(gap * (span - 1)) / span, 1, 0),
						BackgroundColor3 = th.head,
						BackgroundTransparency = 0.12,
						BorderSizePixel = 0,
						Image = "",
						LayoutOrder = ord,
						ZIndex = 6,
					}, deck)

					round(hit, 6)

					local band = new("UIStroke", { Color = th.line, Transparency = 0.78 }, hit)

					local pip = new("ImageLabel", {
						Name = rnd(),
						AnchorPoint = Vector2.new(0.5, 0.5),
						Position = UDim2.fromScale(0.5, 0.5),
						Size = UDim2.fromOffset(15, 15),
						BackgroundTransparency = 1,
						Image = icon(b.icon or b.Icon or "circle-dot"),
						ImageColor3 = th.dim,
						ImageTransparency = 0.25,
						ScaleType = Enum.ScaleType.Fit,
						ZIndex = 7,
					}, hit)

					local hint = b.tip or b.Tip or b.name or b.Name

					conn(hit.MouseEnter, function()
						anim(hit, soft, { BackgroundTransparency = 0 })
						anim(band, soft, { Transparency = 0.45 })
						anim(pip, soft, { ImageTransparency = 0, ImageColor3 = th.text })

						if hint then
							say(hint, th.dim, true)
						end
					end)

					conn(hit.MouseLeave, function()
						anim(hit, soft, { BackgroundTransparency = 0.12 })
						anim(band, soft, { Transparency = 0.78 })
						anim(pip, soft, { ImageTransparency = 0.25, ImageColor3 = th.dim })

						mute()
					end)

					conn(hit.MouseButton1Click, function()
						pip.ImageColor3 = th.accent

						anim(pip, soft, { ImageColor3 = th.text })

						shitaroebet:chime("tap")

						local fn = b.callback or b.Callback

						if type(fn) == "function" then
							task.spawn(fn, item)
						end
					end)
				end
			end

			conn(rec.frame:GetPropertyChangedSignal("Visible"), function()
				if rec.frame.Visible and dirty then
					stir()
				end
			end)

			soak(cfg.list)

			if cfg.default ~= nil then
				item:set(cfg.default, true)
			end

			shitaroebet:hook(cfg.flag or (trail .. "|" .. cfg.name), cfg.multi and "list" or "string", function()
				if cfg.multi then
					return table.concat(value(), ", ")
				end

				return pick or ""
			end, function(v)
				item:set(v, true)

				if cfg.callback then
					task.spawn(cfg.callback, value())
				end
			end)

			task.defer(stir)

			return item
		end

		function api:clone(cfg)
			cfg = params(cfg, {
				name = "Clone",
				icon = "person-standing",
				side = "left",
				height = 208,
				fov = 45,
				zoom = 1,
				yaw = 18,
				pitch = -6,
				spin = 24,
				delay = 0.45,
				warm = 1.1,
				sens = 0.5,
				rotate = true,
				reset = true,
				callback = nil,
			})

			local tall = math.clamp(math.floor(tonumber(cfg.height) or 208), 90, 560)
			local col = lane(cfg.side)
			local card, rec = crate(col, tall + 48)

			table.insert(cards, { slot = rec, name = cfg.name, rows = {} })

			local strip = new("Frame", {
				Name = rnd(),
				Size = UDim2.new(1, 0, 0, 28),
				BackgroundColor3 = th.head,
				BorderSizePixel = 0,
				ZIndex = 6,
			}, card)

			round(strip, 7)

			new("Frame", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0, 1),
				Position = UDim2.fromScale(0, 1),
				Size = UDim2.new(1, 0, 0, 8),
				BackgroundColor3 = th.head,
				BorderSizePixel = 0,
				ZIndex = 6,
			}, strip)

			new("ImageLabel", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0, 0.5),
				Position = UDim2.new(0, 10, 0.5, 0),
				Size = UDim2.fromOffset(13, 13),
				BackgroundTransparency = 1,
				Image = icon(cfg.icon),
				ImageColor3 = th.dim,
				ImageTransparency = 0.25,
				ScaleType = Enum.ScaleType.Fit,
				ZIndex = 7,
			}, strip)

			new("TextLabel", {
				Name = rnd(),
				Position = UDim2.fromOffset(30, 0),
				Size = UDim2.new(1, -66, 1, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = cfg.name,
				TextColor3 = th.text,
				TextSize = 13,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 7,
			}, strip)

			local rule = new("Frame", {
				Name = rnd(),
				Position = UDim2.fromOffset(0, 28),
				Size = UDim2.new(1, 0, 0, 2),
				BackgroundColor3 = th.accent,
				BackgroundTransparency = 0.45,
				BorderSizePixel = 0,
				ZIndex = 7,
			}, card)

			fade(rule, 0, {
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.12, 0.2),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.88, 0.2),
				NumberSequenceKeypoint.new(1, 1),
			})

			local stage = new("Frame", {
				Name = rnd(),
				Position = UDim2.fromOffset(10, 38),
				Size = UDim2.new(1, -20, 0, tall),
				BackgroundColor3 = th.bg,
				BackgroundTransparency = 0.3,
				BorderSizePixel = 0,
				ClipsDescendants = true,
				ZIndex = 6,
			}, card)

			round(stage, 6)

			local ring = new("UIStroke", { Color = th.line, Transparency = 0.74 }, stage)

			local haze = new("Frame", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0, 1),
				Position = UDim2.fromScale(0, 1),
				Size = UDim2.new(1, 0, 0.6, 0),
				BackgroundColor3 = th.glow,
				BackgroundTransparency = 0.88,
				BorderSizePixel = 0,
				ZIndex = 6,
			}, stage)

			round(haze, 6)

			fade(haze, 90, {
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(1, 0.3),
			})

			local view = new("ViewportFrame", {
				Name = rnd(),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				BorderSizePixel = 0,
				Ambient = Color3.fromRGB(148, 148, 160),
				LightColor = Color3.fromRGB(255, 255, 255),
				LightDirection = Vector3.new(-0.35, -1, -0.55),
				ZIndex = 7,
			}, stage)

			round(view, 6)

			local host = view

			if pcall(Instance.new, "WorldModel") then
				host = new("WorldModel", { Name = rnd() }, view)
			end

			local cam = new("Camera", {
				Name = rnd(),
				FieldOfView = math.clamp(tonumber(cfg.fov) or 45, 10, 100),
			}, view)

			view.CurrentCamera = cam

			local overlay = new("Frame", {
				Name = rnd(),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ClipsDescendants = true,
				ZIndex = 8,
			}, stage)

			local grab = new("ImageButton", {
				Name = rnd(),
				Size = UDim2.fromScale(1, 1),
				BackgroundTransparency = 1,
				ImageTransparency = 1,
				ZIndex = 9,
			}, stage)

			local item = {
				card = card,
				stage = stage,
				viewport = view,
				world = host,
				camera = cam,
				overlay = overlay,
				model = nil,
				root = nil,
				parts = {},
				active = false,
				yaw = tonumber(cfg.yaw) or 0,
				pitch = math.clamp(tonumber(cfg.pitch) or 0, -80, 80),
				zoom = math.clamp(tonumber(cfg.zoom) or 1, 0.35, 4),
			}

			local hooks = {}
			local bounds = Vector3.new(4, 5.5, 4)
			local center = Vector3.new(0, 2.75, 0)
			local pivot = Vector3.new(0, 2.75, 0)
			local reach, ready, held, wait0, watch = 12, false, false, 0, nil
			local drift, rest = 0, 0
			local dirty, dirty0 = false, 0

			local function fit()
				local tan = math.tan(math.rad(cam.FieldOfView * 0.5))
				local sz = view.AbsoluteSize
				local ratio = (sz.Y > 1) and (sz.X / sz.Y) or 1
				local drop = math.abs(center.Y - pivot.Y)
				local high = bounds.Y * 0.5 + drop
				local wide = math.sqrt(bounds.X * bounds.X + bounds.Z * bounds.Z) * 0.5

				reach = math.max(high / tan, wide / (tan * math.max(ratio, 0.05))) * 1.12
			end

			local function place()
				cam.CFrame = CFrame.new(pivot)
					* CFrame.fromEulerAnglesYXZ(math.rad(item.pitch), math.rad(item.yaw), 0)
					* CFrame.new(0, 0, reach * item.zoom)
			end

			local function nudge()
				local at = view.Parent

				if not at then
					return
				end

				view.Parent = nil
				view.Parent = at
			end

			local function bay()
				return view.AbsolutePosition + inset(), view.AbsoluteSize
			end

			local function cast(v3)
				local at, sz = bay()

				if sz.X < 1 or sz.Y < 1 then
					return 0, 0, false
				end

				local rel = cam.CFrame:PointToObjectSpace(v3)

				if rel.Z > -0.05 then
					return 0, 0, false
				end

				local tan = math.tan(math.rad(cam.FieldOfView * 0.5))
				local far = -rel.Z
				local nx = rel.X / (far * tan * (sz.X / sz.Y))
				local ny = rel.Y / (far * tan)

				return at.X + sz.X * (0.5 + nx * 0.5), at.Y + sz.Y * (0.5 - ny * 0.5), true
			end

			local function ping(dt)
				for i = #hooks, 1, -1 do
					local fn = hooks[i]

					if type(fn) ~= "function" then
						table.remove(hooks, i)
					elseif not pcall(fn, item, dt) then
						table.remove(hooks, i)
					end
				end
			end

			local function wipe()
				if watch then
					watch:Disconnect()
					watch = nil
				end

				if item.model then
					item.model:Destroy()
					item.model = nil
				end

				table.clear(item.parts)

				item.root = nil
				ready = false
			end

			local function twin(a, b, out)
				local ac, bc = a:GetChildren(), b:GetChildren()

				for i = 1, #ac do
					local x = ac[i]
					local y = bc[i]

					if not y or y.Name ~= x.Name or y.ClassName ~= x.ClassName then
						y = b:FindFirstChild(x.Name)
					end

					if y then
						if x:IsA("BasePart") and y:IsA("BasePart") then
							out[#out + 1] = { x, y }
						end

						twin(x, y, out)
					end
				end
			end

			local function scrub(m)
				for _, o in next, m:GetDescendants() do
					if o:IsA("BasePart") then
						o.Anchored = true
						o.CanCollide = false
						o.Massless = true
						o.CastShadow = false
						o.LocalTransparencyModifier = 0
					elseif o:IsA("Humanoid") then
						local motor = o:FindFirstChildOfClass("Animator")

						if motor then
							motor:Destroy()
						end

						pcall(function()
							o.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
							o.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
							o.NameDisplayDistance = 0
							o.HealthDisplayDistance = 0
							o.AutoRotate = false
							o.BreakJointsOnDeath = false
							o.RequiresNeck = false
							o.EvaluateStateMachine = false
							o.Health = o.MaxHealth
						end)
					elseif o:IsA("LuaSourceContainer") or o:IsA("Sound") or o:IsA("BodyMover") or o:IsA("Camera") or o:IsA("Fire") or o:IsA("Smoke") then
						o:Destroy()
					end
				end
			end
			local function stale()
				if not dirty then
					dirty = true
					dirty0 = os.clock()
				end

				wait0 = os.clock() + 0.35
			end

			local function raise()
				local char = lp.Character

				if not char or not char.Parent then
					return
				end

				local core = char.PrimaryPart
					or char:FindFirstChild("HumanoidRootPart")
					or char:FindFirstChild("UpperTorso")
					or char:FindFirstChild("Torso")
					or char:FindFirstChildWhichIsA("BasePart")

				if not core then
					return
				end

				local locked = {}
				local was = char.Archivable

				for _, o in next, char:GetDescendants() do
					if not o.Archivable then
						locked[#locked + 1] = o

						pcall(function()
							o.Archivable = true
						end)
					end
				end

				pcall(function()
					char.Archivable = true
				end)

				local ok, dup = pcall(function()
					return char:Clone()
				end)

				pcall(function()
					char.Archivable = was
				end)

				for _, o in next, locked do
					pcall(function()
						o.Archivable = false
					end)
				end

				if not ok or not dup then
					return
				end

				local map = {}

				twin(char, dup, map)
				scrub(dup)

				if #map == 0 then
					dup:Destroy()

					return
				end

				dup.Name = rnd()
				wipe()

				dup.Parent = host

				item.model = dup
				item.parts = map
				item.root = core

				local base = core.CFrame:Inverse()

				for i = 1, #map do
					local p = map[i]

					if p[1].Parent and p[2].Parent then
						p[2].CFrame = base * p[1].CFrame
					end
				end

				local okb, bcf, bsz = pcall(dup.GetBoundingBox, dup)

				if okb and typeof(bsz) == "Vector3" and bsz.Y > 0 then
					bounds = bsz
				end

				if okb and typeof(bcf) == "CFrame" then
					center = Vector3.new(0, bcf.Position.Y, 0)
					pivot = Vector3.new(0, center.Y - bounds.Y * 0.08, 0)
				end

				ready = true
				dirty = false

				fit()
				place()

				task.defer(nudge)

				watch = conn(char.DescendantAdded, function(o)
					if o:IsA("BasePart") or o:IsA("Accoutrement") or o:IsA("Clothing") or o:IsA("ShirtGraphic") or o:IsA("CharacterMesh") then
						stale()
					end
				end)

				if cfg.callback then
					task.spawn(cfg.callback, dup, item)
				end
			end

			local function pose()
				local core = item.root

				if not core or not core.Parent then
					stale()

					return
				end

				local base = core.CFrame:Inverse()
				local map = item.parts

				for i = 1, #map do
					local p = map[i]
					local a, b = p[1], p[2]

					if a.Parent and b.Parent then
						b.CFrame = base * a.CFrame
					end
				end
			end

			conn(view:GetPropertyChangedSignal("AbsoluteSize"), function()
				fit()

				if ready then
					place()
				end
			end)

			conn(rs.RenderStepped, function(dt)
				local go = shitaroebet.alive and win.open and pg.Visible and rec.live and true or false

				if go ~= item.active then
					item.active = go

					if go then
						task.defer(nudge)
					else
						ping(0)
					end
				end

				if not go then
					return
				end

				if not ready or not item.model or not item.model.Parent then
					if os.clock() >= wait0 then
						wait0 = os.clock() + 0.4

						raise()
					end

					return
				end
				if dirty and (os.clock() >= wait0 or os.clock() - dirty0 >= 2) then
					wait0 = os.clock() + 0.4

					raise()
				end

				pose()

				if held then
					rest = 0
					drift = math.max(drift - dt * 7, 0)
				else
					rest += dt

					if rest > cfg.delay then
						drift = math.min(drift + dt / math.max(cfg.warm, 0.05), 1)
					end
				end

				if cfg.spin ~= 0 and drift > 0 then
					local k = drift * drift * (3 - 2 * drift)

					item.yaw = (item.yaw + cfg.spin * k * dt) % 360
				end

				place()
				ping(dt)
			end)

			conn(grab.InputBegan, function(i)
				if not cfg.rotate or held then
					return
				end

				if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then
					return
				end

				held = true

				latch(1)

				col.frame.ScrollingEnabled = false

				shitaroebet:chime("tap")

				anim(ring, soft, { Transparency = 0.4 })

				local last = uis:GetMouseLocation()

				while held and (uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or i.UserInputState ~= Enum.UserInputState.End) do
					local now = uis:GetMouseLocation()
					local d = now - last

					last = now

					if d.X ~= 0 or d.Y ~= 0 then
						item.yaw = (item.yaw - d.X * cfg.sens) % 360
						item.pitch = math.clamp(item.pitch - d.Y * cfg.sens, -80, 80)

						if ready then
							place()
						end
					end

					task.wait()
				end

				held = false

				col.frame.ScrollingEnabled = true

				latch(-1)

				anim(ring, soft, { Transparency = 0.74 })
			end)

			conn(grab.InputEnded, function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
					held = false
				end
			end)

			conn(uis.InputEnded, function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
					held = false
				end
			end)

			conn(grab.MouseEnter, function()
				anim(ring, soft, { Transparency = 0.55 })
			end)

			conn(grab.MouseLeave, function()
				if not held then
					anim(ring, soft, { Transparency = 0.74 })
				end
			end)

			function item:set(y, p)
				if tonumber(y) then
					item.yaw = tonumber(y) % 360
				end

				if tonumber(p) then
					item.pitch = math.clamp(tonumber(p), -80, 80)
				end

				if ready then
					place()
				end
			end

			function item:get()
				return item.yaw, item.pitch, item.zoom
			end

			function item:setzoom(v)
				item.zoom = math.clamp(tonumber(v) or 1, 0.35, 4)

				if ready then
					place()
				end
			end

			function item:setspin(v)
				cfg.spin = tonumber(v) or 0
			end

			function item:setfov(v)
				cam.FieldOfView = math.clamp(tonumber(v) or 45, 10, 100)

				fit()

				if ready then
					place()
				end
			end

			function item:reset()
				item.yaw = tonumber(cfg.yaw) or 0
				item.pitch = math.clamp(tonumber(cfg.pitch) or 0, -80, 80)
				item.zoom = math.clamp(tonumber(cfg.zoom) or 1, 0.35, 4)

				fit()

				if ready then
					place()
				end
			end

			function item:refresh()
				wait0 = 0

				wipe()
			end

			function item:redraw()
				nudge()
			end

			function item:onrender(fn)
				if type(fn) ~= "function" then
					return function() end
				end

				table.insert(hooks, fn)

				return function()
					local at = table.find(hooks, fn)

					if at then
						table.remove(hooks, at)
					end
				end
			end

			function item:project(v3)
				if typeof(v3) ~= "Vector3" then
					return Vector2.new(), false
				end

				local x, y, front = cast(v3)

				if not front then
					return Vector2.new(), false
				end

				local at, sz = bay()

				return Vector2.new(x, y), x >= at.X and y >= at.Y and x <= at.X + sz.X and y <= at.Y + sz.Y
			end

			function item:rect(target, loose)
				local m = target or item.model

				if not item.active or not m or not m.Parent then
					return nil
				end

				local x1, y1, x2, y2 = math.huge, math.huge, -math.huge, -math.huge
				local hit = false

				local function chew(part)
					if part.Transparency >= 1 or part.Size.Magnitude <= 0 then
						return true
					end

					local half = part.Size * 0.5

					for i = 1, 8 do
						local x, y, front = cast(part.CFrame * (nooks[i] * half))

						if not front then
							return false
						end

						x1, y1 = math.min(x1, x), math.min(y1, y)
						x2, y2 = math.max(x2, x), math.max(y2, y)
					end

					hit = true

					return true
				end

				if m:IsA("BasePart") then
					if not chew(m) then
						return nil
					end
				elseif m == item.model then
					local map = item.parts

					for i = 1, #map do
						local part = map[i][2]

						if part.Parent and not chew(part) then
							return nil
						end
					end
				else
					for _, o in next, m:GetDescendants() do
						if o:IsA("BasePart") and not chew(o) then
							return nil
						end
					end
				end

				if not hit then
					return nil
				end

				if not loose then
					local at, sz = bay()

					x1, y1 = math.max(x1, at.X), math.max(y1, at.Y)
					x2, y2 = math.min(x2, at.X + sz.X), math.min(y2, at.Y + sz.Y)

					if x2 - x1 < 1 or y2 - y1 < 1 then
						return nil
					end
				end

				return x1, y1, x2 - x1, y2 - y1
			end

			function item:onscreen()
				local at, sz = bay()

				return at, sz, item.active
			end

			if cfg.reset then
				local nib = new("ImageButton", {
					Name = rnd(),
					AnchorPoint = Vector2.new(1, 0.5),
					Position = UDim2.new(1, -8, 0.5, 0),
					Size = UDim2.fromOffset(20, 20),
					BackgroundColor3 = th.head,
					BackgroundTransparency = 1,
					BorderSizePixel = 0,
					Image = icon("refresh-cw"),
					ImageColor3 = th.dim,
					ImageTransparency = 0.25,
					ScaleType = Enum.ScaleType.Fit,
					ZIndex = 8,
				}, strip)

				round(nib, 5)

				conn(nib.MouseEnter, function()
					anim(nib, soft, { ImageTransparency = 0, ImageColor3 = th.text, BackgroundTransparency = 0.4 })
				end)

				conn(nib.MouseLeave, function()
					anim(nib, soft, { ImageTransparency = 0.25, ImageColor3 = th.dim, BackgroundTransparency = 1 })
				end)

				conn(nib.MouseButton1Click, function()
					nib.ImageColor3 = th.accent

					anim(nib, soft, { ImageColor3 = th.dim })

					shitaroebet:chime("tap")

					item:reset()
					item:refresh()
				end)
			end

			conn(lp.CharacterAdded, stale)

			conn(lp.CharacterRemoving, stale)

			return item
		end

		return api
	end

	local function board(trail)
		local pg = new("Frame", {
			Name = rnd(),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Visible = false,
			ZIndex = 4,
		}, pages)

		return pg, attach(pg, trail)
	end

	local function pick(t)
		if live == t then
			return
		end

		if live then
			live.hit(false)

			shitaroebet:chime("tab")
		end

		live = t
		win.active = t
		t.hit(true)
	end

	local function row(parent, cfg, depth, ord)
		local deep = depth > 0
		local tall = (cfg.tip ~= "" and (deep and 32 or 40)) or (deep and 24 or 30)
		local pad = 8 + depth * 9
		local isz = deep and 13 or 16
		local tx = pad + isz + 7
		local r = { pad = 8 }

		r.head = new("Frame", {
			Name = rnd(),
			Size = UDim2.new(1, 0, 0, tall),
			BackgroundColor3 = th.side,
			BackgroundTransparency = 0.06,
			BorderSizePixel = 0,
			LayoutOrder = ord,
			ZIndex = 7,
		}, parent)

		round(r.head, 6)

		r.edge = new("UIStroke", { Color = th.line, Transparency = 1 }, r.head)

		r.tint = new("Frame", {
			Name = rnd(),
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = th.panel,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 7,
		}, r.head)

		round(r.tint, 6)

		fade(r.tint, 0, {
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.7, 0.25),
			NumberSequenceKeypoint.new(1, 0.55),
		})

		r.bar = new("Frame", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 1, 0.5, 0),
			Size = UDim2.new(0, 3, 0, 0),
			BackgroundColor3 = th.accent,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 8,
		}, r.head)

		new("UICorner", { CornerRadius = UDim.new(1, 0) }, r.bar)

		r.img = new("ImageLabel", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, pad, 0.5, 0),
			Size = UDim2.fromOffset(isz, isz),
			BackgroundTransparency = 1,
			Image = icon(cfg.icon),
			ImageColor3 = th.dim,
			ImageTransparency = 0.35,
			ZIndex = 8,
		}, r.head)

		if cfg.tip ~= "" then
			r.nm = new("TextLabel", {
				Name = rnd(),
				Position = UDim2.new(0, tx, 0, deep and 3 or 5),
				Size = UDim2.new(1, -tx - r.pad, 0, deep and 14 or 16),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = cfg.name,
				TextColor3 = th.dim,
				TextSize = deep and 12 or 13,
				TextTransparency = 0.4,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 8,
			}, r.head)

			r.ds = new("TextLabel", {
				Name = rnd(),
				Position = UDim2.new(0, tx, 0, deep and 16 or 21),
				Size = UDim2.new(1, -tx - r.pad, 0, 11),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = cfg.tip,
				TextColor3 = th.dim,
				TextSize = 9,
				TextTransparency = 0.7,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 8,
			}, r.head)
		else
			r.nm = new("TextLabel", {
				Name = rnd(),
				Position = UDim2.new(0, tx, 0, 0),
				Size = UDim2.new(1, -tx - r.pad, 1, 0),
				BackgroundTransparency = 1,
				Font = Enum.Font.GothamBold,
				Text = cfg.name,
				TextColor3 = th.dim,
				TextSize = deep and 12 or 13,
				TextTransparency = 0.4,
				TextTruncate = Enum.TextTruncate.AtEnd,
				TextXAlignment = Enum.TextXAlignment.Left,
				ZIndex = 8,
			}, r.head)
		end

		r.btn = new("ImageButton", {
			Name = rnd(),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ImageTransparency = 1,
			ZIndex = 9,
		}, r.head)

		function r.reserve(px)
			r.pad = px
			r.nm.Size = UDim2.new(1, -tx - px, r.nm.Size.Y.Scale, r.nm.Size.Y.Offset)

			if r.ds then
				r.ds.Size = UDim2.new(1, -tx - px, 0, 11)
			end
		end

		function r.paint(sel)
			r.sel = sel

			anim(r.tint, soft, { BackgroundTransparency = sel and 0.12 or 1 })
			anim(r.edge, soft, { Transparency = sel and 0.72 or 1 })
			anim(r.bar, soft, { Size = UDim2.new(0, 3, 0, sel and math.floor(tall * 0.55) or 0), BackgroundTransparency = sel and 0.05 or 1 })
			anim(r.img, soft, { ImageTransparency = sel and 0 or 0.35, ImageColor3 = sel and th.text or th.dim })
			anim(r.nm, soft, { TextTransparency = sel and 0 or 0.4, TextColor3 = sel and th.text or th.dim })

			if r.ds then
				anim(r.ds, soft, { TextTransparency = sel and 0.4 or 0.7 })
			end
		end

		conn(r.head.MouseEnter, function()
			if not r.sel then
				anim(r.tint, soft, { BackgroundTransparency = 0.55 })
				anim(r.nm, soft, { TextTransparency = 0.15 })
				anim(r.img, soft, { ImageTransparency = 0.15 })
			end
		end)

		conn(r.head.MouseLeave, function()
			if not r.sel then
				anim(r.tint, soft, { BackgroundTransparency = 1 })
				anim(r.nm, soft, { TextTransparency = 0.4 })
				anim(r.img, soft, { ImageTransparency = 0.35 })
			end
		end)

		return r
	end

	function win:tab(cfg)
		cfg = params(cfg, {
			name = "tab",
			icon = "",
			tip = "",
			open = false,
		})

		order += 1

		local holder = new("Frame", {
			Name = rnd(),
			Size = UDim2.new(1, 0, 0, 0),
			AutomaticSize = Enum.AutomaticSize.Y,
			BackgroundTransparency = 1,
			LayoutOrder = order,
			ZIndex = 7,
		}, tabs)

		new("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 2),
		}, holder)

		local r = row(holder, cfg, 0, 1)

		local arrow = new("ImageLabel", {
			Name = rnd(),
			AnchorPoint = Vector2.new(1, 0.5),
			Position = UDim2.new(1, -7, 0.5, 0),
			Size = UDim2.fromOffset(13, 13),
			BackgroundTransparency = 1,
			Image = icon("chevron-down"),
			ImageColor3 = th.dim,
			ImageTransparency = 1,
			Rotation = 0,
			Visible = false,
			ZIndex = 8,
		}, r.head)

		local kids = new("Frame", {
			Name = rnd(),
			Size = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			LayoutOrder = 2,
			ZIndex = 7,
		}, holder)

		local klist = new("UIListLayout", {
			SortOrder = Enum.SortOrder.LayoutOrder,
			Padding = UDim.new(0, 2),
		}, kids)

		local pg, px = board(cfg.name)

		local tab = {
			name = cfg.name,
			page = pg,
			subs = {},
			open = false,
			head = r.head,
		}

		function tab:section(c)
			return px:section(c)
		end

		function tab:color(c)
			return px:color(c)
		end

		function tab:configs(c)
			return px:configs(c)
		end

		function tab:clone(c)
			return px:clone(c)
		end

		function tab:gallery(c)
			return px:gallery(c)
		end

		tab.hit = function(sel)
			r.paint(sel)

			if sel then
				pg.Visible = true

				px.reveal()
			else
				pg.Visible = false

				px.settle()
			end
		end

		local function fit(instant)
			local h1 = tab.open and acs(klist).Y or 0

			if instant then
				kids.Size = UDim2.new(1, 0, 0, h1)

				return
			end

			local h0 = kids.Size.Y.Offset

			flow(kids, 0.34, tab.open and outq or inq, function(k)
				kids.Size = UDim2.new(1, 0, 0, h0 + (h1 - h0) * k)
			end)

		end

		conn(klist:GetPropertyChangedSignal("AbsoluteContentSize"), function()
			if tab.open then
				fit(true)
			end
		end)

		function tab:setopen(v)
			tab.open = v and true or false

			fit(false)

			local r0, r1 = arrow.Rotation, tab.open and 180 or 0

			flow(arrow, 0.36, outq, function(k)
				arrow.Rotation = r0 + (r1 - r0) * k
			end)
		end

		function tab:select()
			pick(tab)
		end

		function tab:sub(scfg)
			scfg = params(scfg, {
				name = "sub",
				icon = "",
				tip = "",
			})

			local sr = row(kids, scfg, 1, #tab.subs + 1)

			local spg, spx = board(cfg.name .. "|" .. scfg.name)

			local sub = {
				name = scfg.name,
				page = spg,
				head = sr.head,
			}

			function sub:section(c)
				return spx:section(c)
			end

			function sub:color(c)
				return spx:color(c)
			end

			function sub:configs(c)
				return spx:configs(c)
			end

			function sub:clone(c)
				return spx:clone(c)
			end

			function sub:gallery(c)
				return spx:gallery(c)
			end

			sub.hit = function(sel)
				sr.paint(sel)

				if sel then
					spg.Visible = true

					spx.reveal()
				else
					spg.Visible = false

					spx.settle()
				end
			end

			function sub:select()
				pick(sub)
			end

			conn(sr.btn.MouseButton1Click, function()
				pick(sub)
			end)

			table.insert(tab.subs, sub)

			if not arrow.Visible then
				arrow.Visible = true
				r.reserve(26)
				anim(arrow, soft, { ImageTransparency = 0.35 })
			end

			if cfg.open and not tab.open then
				tab:setopen(true)
			end

			return sub
		end

		conn(r.btn.MouseButton1Click, function()
			pick(tab)

			if #tab.subs > 0 then
				tab:setopen(not tab.open)
			end
		end)

		if not live then
			pick(tab)
		end

		table.insert(win.list, tab)

		return tab
	end

	bgnet:mark(split)

	drag(grip, shell, 0.14)

	win.shell = shell
	win.root = root
	win.side = side
	win.body = body
	win.pages = pages
	win.tabs = tabs
	win.net = bgnet

	function win:mark(o)
		bgnet:mark(o)
	end

	function win:render(v)
		win.open = v and true or false

		local from = root.GroupTransparency
		local to = win.open and 0 or 1

		shitaroebet.shown = win.open
		shitaroebet:chime(win.open and "open" or "close")
		shitaroebet:wake()

		if not win.open then

			local ride = rides[root]

			if ride then
				ride:Disconnect()
				rides[root] = nil
			end

			root.GroupTransparency = 1

			for i, s in next, aura do
				s.Transparency = 1
			end

			shell.Visible = false
			bgnet.on = false

			return
		end

		shell.Visible = true
		bgnet.on = true

		flow(root, 0.34, outq, function(k)
			local a = from + (to - from) * k

			root.GroupTransparency = a

			for i, s in next, aura do
				s.Transparency = halo[i] + (1 - halo[i]) * a
			end
		end)
	end

	function win:toggle()
		win:render(not win.open)
	end

	function win:setlogo(v)
		logo.Image = tostring(v)
	end

	function win:setsize(v)
		win.size = v

		if win.open then
			anim(shell, med, { Size = v })
		else
			shell.Size = v
		end
	end

	function win:setbind(v)
		if typeof(v) == "EnumItem" then
			win.bind = v

			return
		end

		if type(v) == "string" then
			local ok, k = pcall(function()
				return Enum.KeyCode[v]
			end)

			if ok and typeof(k) == "EnumItem" then
				win.bind = k
			end
		end
	end

	conn(uis.InputBegan, function(i, typing)
		if typing or shitaroebet.capturing or not win.bind then
			return
		end
		if i.KeyCode == win.bind then
			win:toggle()
		end
	end)

	conn(body.MouseEnter, function()
		shitaroebet.hover = true
	end)

	conn(body.MouseLeave, function()
		shitaroebet.hover = false
	end)

	table.insert(shitaroebet.wins, win)
	task.defer(win.render, win, true)

	return win
end

shitaroebet.browsers = {}

local shade = pcall(Instance.new, "UIShadow")

local decoder = nil

local function unb64(s)
	if decoder then
		local ok, res = pcall(decoder, s)

		return (ok and type(res) == "string") and res or nil
	end

	local env = getgenv()

	for _, fn in next, {
		crypt and crypt.base64decode,
		crypt and crypt.base64 and crypt.base64.decode,
		crypt and crypt.base64_decode,
		env.base64 and env.base64.decode,
		env.base64_decode,
		env.base64decode,
	} do
		if type(fn) == "function" then
			local ok, res = pcall(fn, s)

			if ok and type(res) == "string" then
				decoder = fn

				return res
			end
		end
	end

	return nil
end

local function socket(url)
	local env = getgenv()

	for _, fn in next, {
		env.WebSocket and env.WebSocket.connect,
		env.syn and env.syn.websocket and env.syn.websocket.connect,
		env.websocket and env.websocket.connect,
	} do
		if type(fn) == "function" then
			local ok, res = pcall(fn, url)

			if ok and res then
				return res
			end
		end
	end

	return nil
end

function shitaroebet:browser(cfg)
	local th = shitaroebet.theme

	cfg = params(cfg, {
		name = "browser",
		url = "https://shitaro.lol",
		size = Vector2.new(580, 430),
		min = Vector2.new(340, 260),
		host = "ws://127.0.0.1:8787",
		fps = 30,
		retry = 3,
		callback = nil,
	})

	local wide = math.max(math.floor(cfg.size.X), cfg.min.X)
	local high = math.max(math.floor(cfg.size.Y), cfg.min.Y)

	local shell = new("Frame", {
		Name = rnd(),
		Active = true,
		Position = UDim2.new(0.5, -math.floor(wide * 0.5), 0.5, -math.floor(high * 0.5)),
		Size = UDim2.fromOffset(wide, high),
		BackgroundColor3 = th.bg,
		BorderSizePixel = 0,
		Visible = false,
		ZIndex = 60,
	}, scr)

	shrink(shell)

	round(shell, 9)

	new("UIStroke", { Color = th.line, Transparency = 0.55 }, shell)

	if shade then
		new("UIShadow", {
			Color = th.bg,
			BlurRadius = UDim.new(0, 26),
			Offset = UDim2.fromOffset(0, 6),
			Spread = UDim2.fromOffset(-4, -4),
			Transparency = 0.4,
			ZIndex = -1,
		}, shell)
	end

	local head = new("Frame", {
		Name = rnd(),
		Active = true,
		Size = UDim2.new(1, 0, 0, 34),
		BackgroundColor3 = th.head,
		BorderSizePixel = 0,
		ZIndex = 61,
	}, shell)

	round(head, 9)

	new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 9),
		BackgroundColor3 = th.head,
		BorderSizePixel = 0,
		ZIndex = 61,
	}, head)

	local rule = new("Frame", {
		Name = rnd(),
		Position = UDim2.fromOffset(0, 34),
		Size = UDim2.new(1, 0, 0, 2),
		BackgroundColor3 = th.accent,
		BackgroundTransparency = 0.45,
		BorderSizePixel = 0,
		ZIndex = 62,
	}, shell)

	fade(rule, 0, {
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.12, 0.2),
		NumberSequenceKeypoint.new(0.5, 0),
		NumberSequenceKeypoint.new(0.88, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	})

	local function nib(x, art, side)
		local b = new("ImageButton", {
			Name = rnd(),
			AnchorPoint = Vector2.new(side and 1 or 0, 0.5),
			Position = UDim2.new(side and 1 or 0, x, 0.5, 0),
			Size = UDim2.fromOffset(22, 22),
			BackgroundColor3 = th.panel,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			Image = icon(art),
			ImageColor3 = th.dim,
			ImageTransparency = 0.25,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 63,
		}, head)

		round(b, 6)

		conn(b.MouseEnter, function()
			anim(b, soft, { ImageTransparency = 0, ImageColor3 = th.text, BackgroundTransparency = 0.35 })
		end)

		conn(b.MouseLeave, function()
			anim(b, soft, { ImageTransparency = 0.25, ImageColor3 = th.dim, BackgroundTransparency = 1 })
		end)

		return b
	end

	local rear = nib(8, "chevron-right")
	local fore = nib(32, "chevron-right")
	local spin = nib(56, "refresh-cw")
	local shut = nib(-8, "x", true)

	rear.Rotation = 180

	local bar = new("TextBox", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 82, 0.5, 0),
		Size = UDim2.new(1, -118, 0, 24),
		BackgroundColor3 = th.bg,
		BackgroundTransparency = 0.25,
		BorderSizePixel = 0,
		ClearTextOnFocus = false,
		Font = Enum.Font.GothamMedium,
		PlaceholderText = "type a link",
		PlaceholderColor3 = th.dim,
		Text = cfg.url,
		TextColor3 = th.text,
		TextSize = 13,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 63,
	}, head)

	round(bar, 6)

	pcall(function()
		bar.FontFace = Font.new("rbxasset://fonts/families/Inconsolata.json", Enum.FontWeight.Medium)
	end)

	new("UIPadding", { PaddingLeft = UDim.new(0, 9), PaddingRight = UDim.new(0, 9) }, bar)

	local brim = new("UIStroke", { Color = th.line, Transparency = 0.6 }, bar)

	local stage = new("Frame", {
		Name = rnd(),
		Position = UDim2.fromOffset(8, 42),
		Size = UDim2.new(1, -16, 1, -68),
		BackgroundColor3 = th.bg,
		BackgroundTransparency = 0.2,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		ZIndex = 61,
	}, shell)

	round(stage, 7)

	new("UIStroke", { Color = th.line, Transparency = 0.72 }, stage)

	local sheet = new("ImageLabel", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "",
		ImageTransparency = 1,
		ResampleMode = Enum.ResamplerMode.Default,
		ScaleType = Enum.ScaleType.Stretch,
		ZIndex = 62,
	}, stage)

	round(sheet, 7)

	local note = new("TextLabel", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.new(1, -40, 0, 40),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		Text = "host offline",
		TextColor3 = th.dim,
		TextSize = 12,
		TextTransparency = 0.25,
		TextWrapped = true,
		ZIndex = 63,
	}, stage)

	local veil = new("ImageButton", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		ImageTransparency = 1,
		ZIndex = 64,
	}, stage)

	local keys = new("TextBox", {
		Name = rnd(),
		Position = UDim2.fromOffset(-40, -40),
		Size = UDim2.fromOffset(10, 10),
		BackgroundTransparency = 1,
		ClearTextOnFocus = false,
		Text = "",
		TextTransparency = 1,
		ZIndex = 61,
	}, shell)

	local foot = new("TextLabel", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.new(0, 12, 1, -6),
		Size = UDim2.new(1, -46, 0, 14),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamMedium,
		Text = "idle",
		TextColor3 = th.dim,
		TextSize = 11,
		TextTransparency = 0.3,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 62,
	}, shell)

	local grip = new("ImageButton", {
		Name = rnd(),
		AnchorPoint = Vector2.new(1, 1),
		Position = UDim2.new(1, -4, 1, -4),
		Size = UDim2.fromOffset(18, 18),
		BackgroundTransparency = 1,
		Image = icon("move"),
		ImageColor3 = th.dim,
		ImageTransparency = 0.45,
		Rotation = 45,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 63,
	}, shell)

	local api = {
		shell = shell,
		stage = stage,
		image = sheet,
		url = cfg.url,
		open = false,
		live = false,
		host = cfg.host,
	}

	local sock, ed, want, hot, tick, moved = nil, nil, Vector2.zero, false, 0, 0
	local asvc = nil
	local mist, ghost = {}, nil

	local function tally(o)
		if o:IsA("UIStroke") or o:IsA("UIShadow") then
			table.insert(mist, { o = o, k = "Transparency", b = o.Transparency })
		elseif o:IsA("TextLabel") or o:IsA("TextBox") or o:IsA("TextButton") then
			table.insert(mist, { o = o, k = "BackgroundTransparency", b = o.BackgroundTransparency })
			table.insert(mist, { o = o, k = "TextTransparency", b = o.TextTransparency })
		elseif o:IsA("ImageLabel") or o:IsA("ImageButton") then
			table.insert(mist, { o = o, k = "BackgroundTransparency", b = o.BackgroundTransparency })

			local rec = { o = o, k = "ImageTransparency", b = o.ImageTransparency }

			table.insert(mist, rec)

			if o == sheet then
				ghost = rec
			end
		elseif o:IsA("GuiObject") then
			table.insert(mist, { o = o, k = "BackgroundTransparency", b = o.BackgroundTransparency })
		end
	end

	local function mask(a)
		for i = 1, #mist do
			local r = mist[i]

			if r.o.Parent then
				r.o[r.k] = r.b + (1 - r.b) * a
			end
		end
	end

	pcall(function()
		asvc = cloneref(game:GetService("AssetService"))
	end)

	local function tell(txt)
		if foot.Text ~= txt then
			foot.Text = txt
		end
	end

	local function push(msg)
		if not sock then
			return false
		end

		local ok = pcall(function()
			sock:Send(msg)
		end)

		if not ok then
			api.live = false
		end

		return ok
	end

	local function canvas(w, h)
		if not asvc then
			return false
		end

		local ok, res = pcall(function()
			return asvc:CreateEditableImage({ Size = Vector2.new(w, h) })
		end)

		if not ok or not res then
			return false
		end

		local bound = pcall(function()
			sheet.ImageContent = Content.fromObject(res)
		end)

		if not bound then
			bound = pcall(function()
				res.Parent = sheet
			end)
		end

		if not bound then
			pcall(function()
				res:Destroy()
			end)

			return false
		end

		if ed then
			pcall(function()
				ed:Destroy()
			end)
		end

		ed = res
		want = Vector2.new(w, h)

		sheet.ImageTransparency = 0
		note.Visible = false

		return true
	end

	local function blit(x, y, w, h, blob)
		if not ed then
			return
		end

		local raw = unb64(blob)
		local need = w * h * 4

		if not raw or #raw < need then
			return
		end

		if #raw > need then
			raw = string.sub(raw, 1, need)
		end

		pcall(function()
			ed:WritePixelsBuffer(Vector2.new(x, y), Vector2.new(w, h), buffer.fromstring(raw))
		end)
	end

	local function fitted()
		local s = stage.AbsoluteSize
		local w = math.clamp(math.floor(s.X / 8) * 8, 128, 1024)
		local h = math.clamp(math.floor(s.Y / 8) * 8, 128, 1024)

		return w, h
	end

	local function relay()
		local w, h = fitted()

		if want.X ~= w or want.Y ~= h then
			push("size\1" .. w .. "\1" .. h)
		end
	end

	local function eat(msg)
		local kind = string.match(msg, "^(%a+)")

		if kind == "f" then
			local x, y, w, h, blob = string.match(msg, "^f\1(%-?%d+)\1(%-?%d+)\1(%d+)\1(%d+)\1(.*)$")

			if blob then
				blit(tonumber(x), tonumber(y), tonumber(w), tonumber(h), blob)
			end
		elseif kind == "s" then
			local w, h = string.match(msg, "^s\1(%d+)\1(%d+)$")

			if w then
				canvas(tonumber(w), tonumber(h))
			end
		elseif kind == "u" then
			local u = string.sub(msg, 3)

			api.url = u

			if not bar:IsFocused() then
				bar.Text = u
			end
		elseif kind == "t" then
			tell(string.sub(msg, 3))
		elseif kind == "e" then
			tell(string.sub(msg, 3))
		end
	end

	local function drop()
		if sock then
			local dead = sock

			sock = nil

			pcall(function()
				dead:Close()
			end)
		end

		api.live = false
		want = Vector2.zero

		if ed then
			pcall(function()
				ed:Destroy()
			end)

			ed = nil
		end

		sheet.ImageTransparency = 1
		note.Visible = true
	end

	local function dial()
		if sock or not api.open then
			return
		end

		note.Text = "connecting to " .. api.host
		note.Visible = true

		local s = socket(api.host)

		if not s then
			note.Text = "no host at " .. api.host .. "\nstart webhost.py and reopen"

			return
		end

		sock = s
		api.live = true

		pcall(function()
			s.OnMessage:Connect(eat)
		end)

		pcall(function()
			s.OnClose:Connect(function()
				if sock == s then
					drop()

					note.Text = "host closed the link"
				end
			end)
		end)

		local w, h = fitted()

		push("fps\1" .. math.clamp(math.floor(cfg.fps), 1, 60))
		push("size\1" .. w .. "\1" .. h)
		push("nav\1" .. api.url)

		tell("linked")
	end

	local function place()
		local m = uis:GetMouseLocation()
		local at = sheet.AbsolutePosition + inset()
		local sz = sheet.AbsoluteSize

		if sz.X < 1 or sz.Y < 1 then
			return nil
		end

		return math.clamp((m.X - at.X) / sz.X, 0, 1), math.clamp((m.Y - at.Y) / sz.Y, 0, 1)
	end

	function api:go(u)
		u = tostring(u or "")

		if not string.match(u, "%S") then
			return
		end

		if not string.find(u, "://", 1, true) then
			u = (string.find(u, "%.") and not string.find(u, "%s")) and ("https://" .. u) or ("https://www.google.com/search?q=" .. (string.gsub(u, "%s+", "+")))
		end

		api.url = u
		bar.Text = u

		tell("loading")
		push("nav\1" .. u)
	end

	function api:render(v)
		v = v and true or false

		if api.open == v then
			return
		end

		api.open = v

		shitaroebet:chime(v and "open" or "close")

		if ghost then
			ghost.b = sheet.ImageTransparency
		end

		if v then
			mask(1)

			shell.Visible = true

			task.defer(dial)

			flow(shell, 0.34, outq, function(k)
				mask(1 - k)
			end)
		else
			flow(shell, 0.26, inq, function(k)
				mask(k)

				if k >= 1 then
					shell.Visible = false

					mask(0)
				end
			end)

			task.delay(0.26, drop)
		end

		if cfg.callback then
			task.spawn(cfg.callback, v)
		end
	end

	function api:toggle()
		api:render(not api.open)
	end

	function api:sethost(v)
		api.host = tostring(v or api.host)

		if api.open then
			drop()
			task.defer(dial)
		end
	end

	function api:kill()
		drop()

		shell:Destroy()
	end

	conn(shut.MouseButton1Click, function()
		api:render(false)
	end)

	conn(rear.MouseButton1Click, function()
		shitaroebet:chime("flip")

		push("back")
	end)

	conn(fore.MouseButton1Click, function()
		shitaroebet:chime("flip")

		push("fwd")
	end)

	conn(spin.MouseButton1Click, function()
		shitaroebet:chime("tap")

		push("reload")
	end)

	conn(bar.FocusLost, function(enter)
		anim(brim, soft, { Transparency = 0.6 })

		if enter then
			api:go(bar.Text)
		end
	end)

	conn(bar.Focused, function()
		anim(brim, soft, { Transparency = 0.3 })
	end)

	conn(veil.MouseButton1Click, function()
		local x, y = place()

		if x then
			shitaroebet:chime("tap")

			push("click\1" .. string.format("%.5f\1%.5f", x, y) .. "\1l")

			pcall(function()
				keys:CaptureFocus()
			end)
		end
	end)

	conn(veil.MouseButton2Click, function()
		local x, y = place()

		if x then
			push("click\1" .. string.format("%.5f\1%.5f", x, y) .. "\1r")
		end
	end)

	conn(veil.InputChanged, function(i)
		if not api.live then
			return
		end

		if i.UserInputType == Enum.UserInputType.MouseWheel then
			local x, y = place()

			if x then
				push("wheel\1" .. string.format("%.5f\1%.5f", x, y) .. "\1" .. (i.Position.Z > 0 and -120 or 120))
			end

			return
		end

		if i.UserInputType == Enum.UserInputType.MouseMovement then
			local now = os.clock()

			if now - moved < 0.06 then
				return
			end

			moved = now

			local x, y = place()

			if x then
				push("move\1" .. string.format("%.5f\1%.5f", x, y))
			end
		end
	end)

	conn(veil.InputBegan, function(i)
		if i.UserInputType ~= Enum.UserInputType.Touch or not api.live then
			return
		end

		local last = uis:GetMouseLocation()
		local born = os.clock()
		local slid = 0

		while i.UserInputState ~= Enum.UserInputState.End do
			local now = uis:GetMouseLocation()
			local d = now - last

			if math.abs(d.Y) >= 2 then
				local x, y = place()

				if x then
					push("wheel\1" .. string.format("%.5f\1%.5f", x, y) .. "\1" .. math.floor(-d.Y * 3))
				end

				slid += math.abs(d.Y)
				last = now
			end

			task.wait()
		end

		if slid < 6 and os.clock() - born < 0.5 then
			local x, y = place()

			if x then
				push("click\1" .. string.format("%.5f\1%.5f", x, y) .. "\1l")
			end
		end
	end)

	conn(keys:GetPropertyChangedSignal("Text"), function()
		local txt = keys.Text

		if txt == "" or not api.live then
			return
		end

		keys.Text = ""

		push("text\1" .. txt)
	end)

	conn(uis.InputBegan, function(i, typing)
		if not api.open or not api.live or not keys:IsFocused() then
			return
		end

		local name = keyname(i.KeyCode)

		if name == "Enter" or name == "Bksp" or name == "Tab" or name == "Del" or name == "Up" or name == "Down" or name == "Left" or name == "Right" then
			push("key\1" .. name)
		end
	end)

	conn(grip.InputBegan, function(i)
		if i.UserInputType ~= Enum.UserInputType.MouseButton1 and i.UserInputType ~= Enum.UserInputType.Touch then
			return
		end

		if hot then
			return
		end

		hot = true

		latch(1)

		local start = uis:GetMouseLocation()
		local base = asz(shell)
		local w0, h0 = base.X, base.Y
		local vp = (workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(1280, 720)) / sc

		anim(grip, soft, { ImageTransparency = 0, ImageColor3 = th.text })

		while hot and (uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) or i.UserInputState ~= Enum.UserInputState.End) do
			local d = (uis:GetMouseLocation() - start) / sc

			shell.Size = UDim2.fromOffset(
				math.clamp(w0 + d.X, cfg.min.X, math.max(cfg.min.X, vp.X - 16)),
				math.clamp(h0 + d.Y, cfg.min.Y, math.max(cfg.min.Y, vp.Y - 16))
			)

			task.wait()
		end

		hot = false

		latch(-1)

		anim(grip, soft, { ImageTransparency = 0.45, ImageColor3 = th.dim })

		relay()
	end)

	conn(grip.InputEnded, function(i)
		if i.UserInputType == Enum.UserInputType.MouseButton1 or i.UserInputType == Enum.UserInputType.Touch then
			hot = false
		end
	end)

	conn(rs.Heartbeat, function()
		if not api.open then
			return
		end

		local now = os.clock()

		if now - tick < cfg.retry then
			return
		end

		tick = now

		if not sock then
			dial()
		elseif not hot then
			relay()
		end
	end)

	tally(shell)

	for _, o in next, shell:GetDescendants() do
		tally(o)
	end

	mask(1)

	drag(head, shell, 0.1)

	table.insert(shitaroebet.browsers, api)

	return api
end

local popper = nil

function shitaroebet:closepopup()
	if popper then
		popper.kill()
		popper = nil
	end
end

function shitaroebet:popup(cfg)
	cfg = type(cfg) == "table" and cfg or {}

	local rows = type(cfg.items) == "table" and cfg.items or {}

	shitaroebet:closepopup()

	if #rows == 0 or not shitaroebet.alive then
		return
	end

	local vs = scr.AbsoluteSize
	local room = vs / sc
	local wide = math.clamp(math.floor(tonumber(cfg.width) or 170), 140, math.max(math.floor(room.X) - 24, 140))
	local crown = 32
	local body = #rows * 27 + 14
	local tall = math.clamp(crown + body, 64, math.max(math.floor(room.Y) - 24, 64))
	local m = uis:GetMouseLocation()
	local ax = math.floor(tonumber(cfg.x) or m.X)
	local ay = math.floor(tonumber(cfg.y) or m.Y)
	local px = math.clamp(ax, 8, math.max(vs.X - wide * sc - 8, 8))
	local py = math.clamp(ay, 8, math.max(vs.Y - tall * sc - 8, 8))

	local pit = deep and new("Frame", {
		Name = rnd(),
		Position = UDim2.fromOffset(px, py),
		Size = UDim2.fromOffset(wide, tall),
		BackgroundColor3 = th.panel,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 399,
	}, scr) or nil

	local cast = pit and new("UIShadow", {
		Color = th.bg,
		BlurRadius = UDim.new(0, 14),
		Offset = UDim2.fromOffset(0, 4),
		Spread = UDim2.fromOffset(-2, -2),
		Transparency = 1,
		ZIndex = -1,
	}, pit) or nil

	if pit then
		round(pit, 7)
		shrink(pit)
	end

	local husk = new("CanvasGroup", {
		Name = rnd(),
		Position = UDim2.fromOffset(px, py),
		Size = UDim2.fromOffset(wide, tall),
		BackgroundColor3 = th.panel,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		GroupTransparency = 1,
		ZIndex = 400,
	}, scr)

	round(husk, 7)
	shrink(husk)

	new("UIGradient", {
		Rotation = 90,
		Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 178, 190)),
		}),
	}, husk)

	local brim = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 406,
	}, husk)

	round(brim, 7)

	new("UIStroke", { Color = th.line, Transparency = 0.6 }, brim)

	local pane = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 401,
	}, husk)

	local cap = new("Frame", {
		Name = rnd(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = th.head,
		BorderSizePixel = 0,
		ZIndex = 401,
	}, pane)

	round(cap, 7)

	new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 8),
		BackgroundColor3 = th.head,
		BorderSizePixel = 0,
		ZIndex = 401,
	}, cap)

	new("ImageLabel", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 10, 0.5, 0),
		Size = UDim2.fromOffset(12, 12),
		BackgroundTransparency = 1,
		Image = icon(cfg.icon or "ellipsis"),
		ImageColor3 = th.dim,
		ImageTransparency = 0.3,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 402,
	}, cap)

	new("TextLabel", {
		Name = rnd(),
		Position = UDim2.fromOffset(28, 0),
		Size = UDim2.new(1, -36, 1, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		Text = tostring(cfg.title or ""),
		TextColor3 = th.text,
		TextSize = 13,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 402,
	}, cap)

	local rule = new("Frame", {
		Name = rnd(),
		Position = UDim2.fromOffset(0, 30),
		Size = UDim2.new(1, 0, 0, 2),
		BackgroundColor3 = th.accent,
		BackgroundTransparency = 0.45,
		BorderSizePixel = 0,
		ZIndex = 402,
	}, pane)

	fade(rule, 0, {
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.12, 0.2),
		NumberSequenceKeypoint.new(0.5, 0),
		NumberSequenceKeypoint.new(0.88, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	})

	local roll = new("ScrollingFrame", {
		Name = rnd(),
		Active = false,
		Position = UDim2.fromOffset(0, 32),
		Size = UDim2.new(1, 0, 1, -32),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		CanvasSize = UDim2.new(),
		ScrollBarThickness = 0,
		ScrollingDirection = Enum.ScrollingDirection.Y,
		ZIndex = 401,
	}, pane)

	local slab = new("Frame", {
		Name = rnd(),
		Size = UDim2.new(1, 0, 0, 0),
		AutomaticSize = Enum.AutomaticSize.Y,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 401,
	}, roll)

	new("UIListLayout", {
		SortOrder = Enum.SortOrder.LayoutOrder,
		Padding = UDim.new(0, 1),
	}, slab)

	new("UIPadding", {
		PaddingTop = UDim.new(0, 5),
		PaddingBottom = UDim.new(0, 8),
		PaddingLeft = UDim.new(0, 5),
		PaddingRight = UDim.new(0, 5),
	}, slab)

	local rec = { alive = true, frame = husk }

	local function shut(done)
		local from = husk.GroupTransparency

		flow(husk, 0.26, inq, function(k)
			local a = from + (1 - from) * k

			husk.GroupTransparency = a
			husk.Position = UDim2.fromOffset(px, py + math.floor(7 * k + 0.5))

			if pit then
				pit.BackgroundTransparency = a
				pit.Position = husk.Position
				cast.Transparency = 0.4 + 0.6 * a
			end

			if k >= 1 then
				husk.Visible = false

				if pit then
					pit.Visible = false
				end

				if done then
					done()
				end
			end
		end)
	end

	function rec.kill()
		if not rec.alive then
			return
		end

		rec.alive = false

		if rec.watch then
			pcall(function()
				rec.watch:Disconnect()
			end)

			rec.watch = nil
		end

		if rec.spin then
			pcall(function()
				rec.spin:Disconnect()
			end)

			rec.spin = nil
		end

		if rec.trail then
			pcall(function()
				rec.trail:Disconnect()
			end)

			rec.trail = nil
		end

		shut(function()
			pcall(function()
				husk:Destroy()
			end)

			if pit then
				pcall(function()
					pit:Destroy()
				end)
			end
		end)
	end

	for i = 1, #rows do
		local r = rows[i]
		local flip = r.on ~= nil
		local live = r.on == true

		local row = new("Frame", {
			Name = rnd(),
			Size = UDim2.new(1, 0, 0, 26),
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			LayoutOrder = i,
			ZIndex = 402,
		}, slab)

		local box = flip and new("Frame", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 5, 0.5, 0),
			Size = UDim2.fromOffset(16, 16),
			BackgroundColor3 = th.accent,
			BackgroundTransparency = live and 0.05 or 1,
			BorderSizePixel = 0,
			ZIndex = 403,
		}, row) or nil

		local edge = nil
		local tick = nil

		if box then
			round(box, 4)

			edge = new("UIStroke", { Color = th.line, Transparency = live and 1 or 0.2 }, box)

			tick = new("ImageLabel", {
				Name = rnd(),
				AnchorPoint = Vector2.new(0.5, 0.5),
				Position = UDim2.fromScale(0.5, 0.5),
				Size = UDim2.fromOffset(live and 12 or 6, live and 12 or 6),
				BackgroundTransparency = 1,
				Image = icon("check"),
				ImageColor3 = th.bg,
				ImageTransparency = live and 0 or 1,
				ScaleType = Enum.ScaleType.Fit,
				ZIndex = 404,
			}, box)
		end

		local art = (not flip) and new("ImageLabel", {
			Name = rnd(),
			AnchorPoint = Vector2.new(0, 0.5),
			Position = UDim2.new(0, 7, 0.5, 0),
			Size = UDim2.fromOffset(13, 13),
			BackgroundTransparency = 1,
			Image = icon(r.icon or "circle-dot"),
			ImageColor3 = th.dim,
			ImageTransparency = 0.3,
			ScaleType = Enum.ScaleType.Fit,
			ZIndex = 403,
		}, row) or nil

		local lbl = new("TextLabel", {
			Name = rnd(),
			Position = UDim2.fromOffset(29, 0),
			Size = UDim2.new(1, -35, 1, 0),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			Text = tostring(r.name or ""),
			TextColor3 = live and th.text or th.dim,
			TextSize = 13,
			TextTransparency = live and 0 or 0.35,
			TextTruncate = Enum.TextTruncate.AtEnd,
			TextXAlignment = Enum.TextXAlignment.Left,
			ZIndex = 403,
		}, row)

		local btn = new("ImageButton", {
			Name = rnd(),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ImageTransparency = 1,
			ZIndex = 405,
		}, row)

		local warm = false

		local function paint()
			if box then
				anim(box, soft, { BackgroundTransparency = live and 0.05 or (warm and 0.88 or 1) })
				anim(edge, soft, { Transparency = live and 1 or (warm and 0.05 or 0.2) })
				anim(tick, soft, {
					ImageTransparency = live and 0 or 1,
					Size = UDim2.fromOffset(live and 12 or 6, live and 12 or 6),
				})
			end

			if art then
				anim(art, soft, {
					ImageTransparency = warm and 0 or 0.3,
					ImageColor3 = warm and th.text or th.dim,
				})
			end

			anim(lbl, soft, {
				TextTransparency = (live or warm) and 0 or 0.35,
				TextColor3 = (live or warm) and th.text or th.dim,
			})
		end

		conn(btn.MouseEnter, function()
			warm = true

			paint()
		end)

		conn(btn.MouseLeave, function()
			warm = false

			paint()
		end)

		conn(btn.MouseButton1Click, function()
			local fn = r.callback

			if not flip then
				shitaroebet:chime("tap")

				if popper == rec then
					popper = nil
				end

				rec.kill()

				if type(fn) == "function" then
					task.spawn(fn, r)
				end

				return
			end

			shitaroebet:chime(live and "off" or "on")

			local res = nil

			if type(fn) == "function" then
				local ok, out = pcall(fn, r)

				if ok then
					res = out
				end
			end

			if type(res) == "boolean" then
				live = res
			else
				live = not live
			end

			r.on = live

			if not rec.alive then
				return
			end

			paint()
		end)
	end

	conn(slab:GetPropertyChangedSignal("AbsoluteSize"), function()
		roll.CanvasSize = UDim2.fromOffset(0, math.floor(asz(slab).Y + 0.5))
	end)

	roll.CanvasSize = UDim2.fromOffset(0, body)

	local function open()
		husk.Visible = true

		if pit then
			pit.Visible = true
		end

		flow(husk, 0.34, outq, function(k)
			local a = 1 - k

			husk.GroupTransparency = a
			husk.Position = UDim2.fromOffset(px, py + math.floor(7 * (1 - k) + 0.5))

			if pit then
				pit.BackgroundTransparency = a
				pit.Position = husk.Position
				cast.Transparency = 0.4 + 0.6 * a
			end
		end)
	end

	local born = os.clock()

	local function stray(kind)
		if not rec.alive or os.clock() - born < 0.2 then
			return false
		end

		if kind ~= Enum.UserInputType.MouseButton1 and kind ~= Enum.UserInputType.MouseButton2 and kind ~= Enum.UserInputType.Touch and kind ~= Enum.UserInputType.MouseWheel then
			return false
		end

		return not inside(husk, 4)
	end

	rec.watch = conn(uis.InputBegan, function(i)
		if not stray(i.UserInputType) then
			return
		end

		if popper == rec then
			popper = nil
		end

		rec.kill()
	end)

	rec.spin = conn(uis.InputChanged, function(i)
		if i.UserInputType ~= Enum.UserInputType.MouseWheel then
			return
		end

		if not stray(i.UserInputType) then
			return
		end

		if popper == rec then
			popper = nil
		end

		rec.kill()
	end)

	if typeof(cfg.follow) == "Instance" and cfg.follow:IsA("GuiObject") then
		local anchor = cfg.follow
		local base = anchor.AbsolutePosition

		rec.trail = conn(rs.RenderStepped, function()
			if not rec.alive then
				return
			end

			local gone = not anchor.Parent or not anchor.Visible

			if gone or (anchor.AbsolutePosition - base).Magnitude > 4 then
				if popper == rec then
					popper = nil
				end

				rec.kill()
			end
		end)
	end

	task.spawn(function()
		while rec.alive do
			if not shitaroebet.alive or not shitaroebet.shown then
				if popper == rec then
					popper = nil
				end

				rec.kill()

				break
			end

			task.wait(0.12)
		end
	end)

	popper = rec

	open()

	return rec
end

local asker = nil

function shitaroebet:closeask()
	if asker then
		asker.kill()
		asker = nil
	end
end

function shitaroebet:ask(cfg)
	cfg = params(cfg, {
		title = "input",
		icon = "keyboard",
		hint = "",
		text = "",
		accept = "ok",
		deny = "cancel",
		width = 268,
		callback = nil,
	})

	shitaroebet:closeask()
	shitaroebet:closepopup()

	if not shitaroebet.alive then
		return nil
	end

	local host = nil

	for _, w in next, shitaroebet.wins do
		if w.root and w.root.Parent and w.open then
			host = w
		end
	end

	if not host then
		return nil
	end

	local wide = math.clamp(math.floor(tonumber(cfg.width) or 268), 200, 420)
	local tall = 122

	local veil = new("ImageButton", {
		Name = rnd(),
		Active = true,
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		Image = "",
		ImageTransparency = 1,
		ZIndex = 40,
	}, host.shell or host.root)

	local pit = deep and new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(wide, tall),
		BackgroundColor3 = th.panel,
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 42,
	}, veil) or nil

	local cast = pit and new("UIShadow", {
		Color = th.bg,
		BlurRadius = UDim.new(0, 22),
		Offset = UDim2.fromOffset(0, 6),
		Spread = UDim2.fromOffset(-3, -3),
		Transparency = 1,
		ZIndex = -1,
	}, pit) or nil

	if pit then
		round(pit, 8)
	end

	local husk = new("CanvasGroup", {
		Name = rnd(),
		Active = true,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.fromScale(0.5, 0.5),
		Size = UDim2.fromOffset(wide, tall),
		BackgroundColor3 = th.panel,
		BorderSizePixel = 0,
		ClipsDescendants = true,
		GroupTransparency = 1,
		ZIndex = 43,
	}, veil)

	round(husk, 8)

	local brim = new("Frame", {
		Name = rnd(),
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ZIndex = 310,
	}, husk)

	round(brim, 8)

	new("UIStroke", { Color = th.line, Transparency = 0.55 }, brim)

	local cap = new("Frame", {
		Name = rnd(),
		Size = UDim2.new(1, 0, 0, 30),
		BackgroundColor3 = th.head,
		BorderSizePixel = 0,
		ZIndex = 303,
	}, husk)

	round(cap, 8)

	new("Frame", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0, 1),
		Position = UDim2.fromScale(0, 1),
		Size = UDim2.new(1, 0, 0, 8),
		BackgroundColor3 = th.head,
		BorderSizePixel = 0,
		ZIndex = 303,
	}, cap)

	new("ImageLabel", {
		Name = rnd(),
		AnchorPoint = Vector2.new(0, 0.5),
		Position = UDim2.new(0, 10, 0.5, 0),
		Size = UDim2.fromOffset(13, 13),
		BackgroundTransparency = 1,
		Image = icon(cfg.icon),
		ImageColor3 = th.dim,
		ImageTransparency = 0.25,
		ScaleType = Enum.ScaleType.Fit,
		ZIndex = 304,
	}, cap)

	new("TextLabel", {
		Name = rnd(),
		Position = UDim2.fromOffset(30, 0),
		Size = UDim2.new(1, -40, 1, 0),
		BackgroundTransparency = 1,
		Font = Enum.Font.GothamBold,
		Text = tostring(cfg.title),
		TextColor3 = th.text,
		TextSize = 13,
		TextTruncate = Enum.TextTruncate.AtEnd,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 304,
	}, cap)

	local rule = new("Frame", {
		Name = rnd(),
		Position = UDim2.fromOffset(0, 30),
		Size = UDim2.new(1, 0, 0, 2),
		BackgroundColor3 = th.accent,
		BackgroundTransparency = 0.45,
		BorderSizePixel = 0,
		ZIndex = 304,
	}, husk)

	fade(rule, 0, {
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.12, 0.2),
		NumberSequenceKeypoint.new(0.5, 0),
		NumberSequenceKeypoint.new(0.88, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	})

	local field = new("TextBox", {
		Name = rnd(),
		Position = UDim2.fromOffset(10, 42),
		Size = UDim2.new(1, -20, 0, 28),
		BackgroundColor3 = th.head,
		BackgroundTransparency = 0.12,
		BorderSizePixel = 0,
		ClearTextOnFocus = false,
		ClipsDescendants = true,
		Font = Enum.Font.GothamBold,
		PlaceholderColor3 = th.dim,
		PlaceholderText = tostring(cfg.hint),
		Text = tostring(cfg.text),
		TextColor3 = th.text,
		TextSize = 13,
		TextXAlignment = Enum.TextXAlignment.Left,
		ZIndex = 303,
	}, husk)

	round(field, 6)

	new("UIPadding", { PaddingLeft = UDim.new(0, 10), PaddingRight = UDim.new(0, 10) }, field)

	local edge = new("UIStroke", {
		ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
		Color = th.line,
		Transparency = 0.6,
	}, field)

	local rec = { alive = true, frame = husk, field = field }

	local function nib(x, w, text, lead)
		local slab = new("Frame", {
			Name = rnd(),
			Position = UDim2.fromOffset(x, 82),
			Size = UDim2.fromOffset(w, 28),
			BackgroundColor3 = th.head,
			BackgroundTransparency = 0.12,
			BorderSizePixel = 0,
			ClipsDescendants = true,
			ZIndex = 303,
		}, husk)

		round(slab, 6)

		local ring = new("UIStroke", { Color = th.line, Transparency = 0.62 }, slab)

		local wash = new("Frame", {
			Name = rnd(),
			Size = UDim2.fromScale(1, 1),
			BackgroundColor3 = th.accent,
			BackgroundTransparency = 1,
			BorderSizePixel = 0,
			ZIndex = 304,
		}, slab)

		round(wash, 6)

		fade(wash, 0, {
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.55, 0.62),
			NumberSequenceKeypoint.new(1, 1),
		})

		local lbl = new("TextLabel", {
			Name = rnd(),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Font = Enum.Font.GothamBold,
			Text = tostring(text),
			TextColor3 = lead and th.text or th.dim,
			TextSize = 13,
			TextTransparency = lead and 0.05 or 0.25,
			ZIndex = 305,
		}, slab)

		local tap = new("ImageButton", {
			Name = rnd(),
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			ImageTransparency = 1,
			ZIndex = 306,
		}, slab)

		local warm = false

		local function glow()
			anim(slab, soft, { BackgroundTransparency = warm and 0 or 0.12 })
			anim(ring, soft, { Transparency = warm and 0.4 or 0.62 })
			anim(wash, soft, { BackgroundTransparency = warm and 0.88 or 1 })
			anim(lbl, soft, {
				TextTransparency = warm and 0 or (lead and 0.05 or 0.25),
				TextColor3 = (warm or lead) and th.text or th.dim,
			})
		end

		conn(tap.MouseEnter, function()
			warm = true

			glow()
		end)

		conn(tap.MouseLeave, function()
			warm = false

			glow()
		end)

		return tap, wash
	end

	local gap = 6
	local half = math.floor((wide - 20 - gap) / 2)
	local deny, denywash = nib(10, half, cfg.deny, false)
	local okay, okaywash = nib(10 + half + gap, wide - 20 - half - gap, cfg.accept, true)

	local function paint(a)
		husk.GroupTransparency = a

		if pit then
			pit.BackgroundTransparency = a
			cast.Transparency = 0.35 + 0.65 * a
		end
	end

	local function shut(done)
		local from = husk.GroupTransparency

		flow(husk, 0.26, inq, function(k)
			paint(from + (1 - from) * k)

			if k >= 1 and done then
				done()
			end
		end)
	end

	function rec.kill()
		if not rec.alive then
			return
		end

		rec.alive = false

		latch(-1)

		if rec.watch then
			pcall(function()
				rec.watch:Disconnect()
			end)

			rec.watch = nil
		end

		if rec.guard then
			pcall(function()
				rec.guard:Disconnect()
			end)

			rec.guard = nil
		end

		pcall(function()
			field:ReleaseFocus(false)
		end)

		if asker == rec then
			asker = nil
		end

		shut(function()
			pcall(function()
				veil:Destroy()
			end)
		end)
	end

	local function refuse()
		edge.Color = th.accent
		edge.Transparency = 0.1

		anim(edge, soft, { Color = th.line, Transparency = 0.6 })

		flow(field, 0.26, outq, function(k)
			field.Position = UDim2.fromOffset(10 + math.floor(math.sin(k * math.pi * 3) * 4 * (1 - k) + 0.5), 42)
		end)

		task.defer(function()
			if rec.alive then
				field:CaptureFocus()
			end
		end)
	end

	local function submit()
		if not rec.alive then
			return
		end

		okaywash.BackgroundTransparency = 0.72

		anim(okaywash, soft, { BackgroundTransparency = 1 })

		shitaroebet:chime("tap")

		local text = string.match(field.Text, "^%s*(.-)%s*$") or ""

		if text == "" then
			refuse()

			return
		end

		if type(cfg.callback) == "function" then
			local ok, res = pcall(cfg.callback, text)

			if ok and res == false then
				refuse()

				return
			end
		end

		rec.kill()
	end

	local function drop()
		if not rec.alive then
			return
		end

		denywash.BackgroundTransparency = 0.72

		anim(denywash, soft, { BackgroundTransparency = 1 })

		shitaroebet:chime("tap")

		rec.kill()
	end

	conn(okay.MouseButton1Click, submit)
	conn(deny.MouseButton1Click, drop)

	conn(veil.MouseButton1Click, function()
		if inside(husk, 2) then
			return
		end

		drop()
	end)

	conn(field.Focused, function()
		anim(edge, soft, { Transparency = 0.3 })
	end)

	conn(field.FocusLost, function(enter)
		anim(edge, soft, { Transparency = 0.6 })

		if enter then
			submit()
		end
	end)

	rec.watch = conn(uis.InputBegan, function(i)
		if not rec.alive or i.KeyCode ~= Enum.KeyCode.Escape then
			return
		end

		drop()
	end)

	rec.guard = host.shell and conn(host.shell:GetPropertyChangedSignal("Visible"), function()
		if not host.shell.Visible then
			rec.kill()
		end
	end) or nil

	latch(1)

	paint(1)

	flow(husk, 0.34, outq, function(k)
		paint(1 - k)
	end)

	task.defer(function()
		if rec.alive then
			field:CaptureFocus()
		end
	end)

	asker = rec

	return rec
end

function shitaroebet:unload()
	shitaroebet:closeask()
	shitaroebet:closepopup()

	for _, b in next, shitaroebet.browsers do
		pcall(function()
			b:kill()
		end)
	end

	table.clear(shitaroebet.browsers)

	shitaroebet.alive = false
	shitaroebet.cursor = false
	shitaroebet.shown = false

	pcall(rouse)
	pcall(capture, nil)
	pcall(hush)

	table.clear(eyes)
	table.clear(hive)
	table.clear(shitaroebet.pool)
	table.clear(shitaroebet.order)

	for _, c in next, shitaroebet.conns do
		pcall(function()
			c:Disconnect()
		end)
	end

	table.clear(shitaroebet.conns)
	table.clear(shitaroebet.wins)

	if scr then
		scr:Destroy()
	end
end

getgenv().shitaroebet = shitaroebet

return shitaroebet
]===];
local ALIVE = true;

local TAG = "VisualsUI";

local ERRORS = {};

local MINIMAL = (getgenv and getgenv().VISUALS_MINIMAL) and true or false;

local function guard(name, fn)
	if MINIMAL and name ~= "core" then
		ERRORS[#ERRORS + 1] = name .. ": skipped (minimal mode)";
		return false;
	end;

	local ok, err = pcall(fn);

	if not ok then
		ERRORS[#ERRORS + 1] = name .. ": " .. tostring(err);
		warn("[visuals] " .. name .. " failed: " .. tostring(err));
	end;

	return ok;
end;

local CLEANUPS = {};

local function onUnload(name, fn)
	CLEANUPS[#CLEANUPS + 1] = { name = name, fn = fn };

	return fn;
end;

local function runCleanups()

	for index = #CLEANUPS, 1, -1 do
		local entry = CLEANUPS[index];
		local ok, err = pcall(entry.fn);

		if not ok then
			warn("[visuals] cleanup " .. tostring(entry.name) .. ": " .. tostring(err));
		end;
	end;

	table.clear(CLEANUPS);
end;

local function destroyAny(object)
	if not object then return end;
	pcall(function() object.Visible = false end);
	local destroyed = pcall(function() object:Destroy() end);
	if not destroyed then pcall(function() object:Remove() end) end;
end;

local Remote = {};

do
	local HttpService = game:GetService("HttpService");

	Remote.base = (getgenv and getgenv().VISUALS_REMOTE) or "";

	if Remote.base ~= "" and not string.find(Remote.base, "/$") then
		Remote.base = Remote.base .. "/";
	end;

	local grab = (syn and syn.request) or (http and http.request)
		or (getgenv and (rawget(getgenv(), "http_request") or rawget(getgenv(), "request")));

	local function download(url)
		if type(grab) == "function" then
			local ok, res = pcall(grab, { Url = url, Method = "GET" });

			if ok and type(res) == "table" and (tonumber(res.StatusCode) or 0) == 200 then
				return res.Body;
			end;
		end;

		local ok, body = pcall(function() return game:HttpGet(url, true) end);

		return ok and body or nil;
	end;

	Remote.download = download;

	local function urlPath(rel)
		local out = {};

		for piece in string.gmatch(rel, "[^/]+") do
			out[#out + 1] = (string.gsub(piece, "[^%w%-%._~]", function(c)
				return string.format("%%%02X", string.byte(c));
			end));
		end;

		return table.concat(out, "/");
	end;

	Remote.urlPath = urlPath;

	local STORE = "Salad Visuals/.data";

	local function slug(text)
		local hasher = rawget(getgenv(), "crypt");

		if hasher and hasher.hash then
			local ok, hex = pcall(hasher.hash, text, "sha256");

			if ok and type(hex) == "string" and #hex >= 32 then return string.sub(hex, 1, 28) end;
		end;

		local a, b = 0x1505, 0x7fff;

		for index = 1, #text do
			local byte = string.byte(text, index);

			a = (a * 33 + byte) % 0xFFFFFFFF;
			b = (b * 31 + byte * index) % 0xFFFFFFFF;
		end;

		return string.format("%08x%08x%04x", a, b, #text % 0xFFFF);
	end;

	local named = {};

	function Remote.store() return STORE end;
	function Remote.slug(text) return slug(text) end;

	function Remote.file(rel)
		local hit = named[rel];

		if hit then return hit end;

		local ext = string.match(rel, "%.([%w]+)$");
		local path = STORE .. "/" .. slug(rel) .. (ext and ("." .. string.lower(ext)) or "");

		named[rel] = path;

		return path;
	end;

	local function folderFor()
		if not isfolder("Salad Visuals") then makefolder("Salad Visuals") end;
		if not isfolder(STORE) then makefolder(STORE) end;
	end;

	local ids = {};

	local byPath = {};

	local bodies = {};

	local function isData(rel)
		local ext = string.lower(string.match(rel, "%.(%w+)$") or "");

		return ext == "json" or ext == "txt";
	end;

	local held = {};

	local function adopt(rel, body)
		if not (getcustomasset and writefile and delfile) then return nil end;

		local path = Remote.file(rel);

		local wrote = pcall(function()
			folderFor();
			writefile(path, body);
		end);

		if not wrote then return nil end;

		local ok, url = pcall(getcustomasset, path);

		if not (ok and type(url) == "string" and url ~= "") then
			pcall(delfile, path);

			return nil;
		end;

		local ext = string.lower(string.match(rel, "%.(%w+)$") or "");
		local probe;

		if ext == "ogg" or ext == "wav" or ext == "mp3" then
			probe = Instance.new("Sound");
			probe.SoundId = url;
		else
			probe = Instance.new("ImageLabel");
			probe.Image = url;
		end;

		held[#held + 1] = { path = path, probe = probe };

		ids[rel] = url;
		byPath[path] = url;

		return url;
	end;

	local function settle()
		for index = 1, #held do
			pcall(function() held[index].probe:Destroy() end);
		end;

		table.clear(held);
	end;

	local function fetch(rel)
		if Remote.base == "" then return nil end;

		local body = download(Remote.base .. urlPath(rel));

		return (type(body) == "string" and #body > 0) and body or nil;
	end;

	function Remote.asset(rel)
		local hit = ids[rel];

		if hit ~= nil then return hit or nil end;

		local body = fetch(rel);
		local url = body and adopt(rel, body) or nil;

		settle();

		if not url then ids[rel] = false end;

		return url;
	end;

	function Remote.body(rel)
		local hit = bodies[rel];

		if hit ~= nil then return hit or nil end;

		bodies[rel] = fetch(rel) or false;

		return bodies[rel] or nil;
	end;

	function Remote.ensure(rel)
		if isData(rel) then return Remote.body(rel) ~= nil end;

		return Remote.asset(rel) ~= nil;
	end;

	function Remote.repair(rel)
		ids[rel], bodies[rel] = nil, nil;

		return Remote.ensure(rel);
	end;

	function Remote.id(path)
		local hit = byPath[path];

		if hit ~= nil then return hit or nil end;

		if not (getcustomasset and isfile and isfile(path)) then return nil end;

		local ok, url = pcall(getcustomasset, path);

		byPath[path] = (ok and type(url) == "string" and url ~= "") and url or false;

		return byPath[path] or nil;
	end;

	function Remote.have(path)
		return Remote.id(path) ~= nil;
	end;

	function Remote.load()
		if Remote.manifest then return Remote.manifest end;
		if Remote.base == "" then return nil end;

		local body = download(Remote.base .. "index.json");

		if type(body) ~= "string" then return nil end;

		local ok, decoded = pcall(function() return HttpService:JSONDecode(body) end);

		if ok and type(decoded) == "table" then Remote.manifest = decoded end;

		return Remote.manifest;
	end;

	function Remote.under(prefix)
		local manifest = Remote.load();
		local out = {};

		if not (manifest and type(manifest.files) == "table") then return out end;

		for rel in pairs(manifest.files) do
			if string.sub(rel, 1, #prefix) == prefix then out[#out + 1] = rel end;
		end;

		table.sort(out);

		return out;
	end;

	function Remote.sync(report)
		if Remote.base == "" then return 0, 0 end;

		local blob = download(Remote.base .. "bundle.pack");

		if type(blob) ~= "string" or #blob < 8 or string.sub(blob, 1, 4) ~= "SVP1" then
			return 0, 1;
		end;

		local a, b, c, d = string.byte(blob, 5, 8);
		local headLen = a + b * 256 + c * 65536 + d * 16777216;

		local ok, head = pcall(function()
			return HttpService:JSONDecode(string.sub(blob, 9, 8 + headLen));
		end);

		if not (ok and type(head) == "table" and type(head.e) == "table") then
			return 0, 1;
		end;

		local list = head.e;
		local at = 8 + headLen;
		local total = #list;
		local done, failed, lastPct = 0, 0, 0;

		for index = 1, total do
			local entry = list[index];
			local rel, offset, size = entry[1], entry[2], entry[3];
			local body = string.sub(blob, at + offset + 1, at + offset + size);

			local kept;

			if isData(rel) then
				bodies[rel] = body;
				kept = true;
			else
				kept = adopt(rel, body) ~= nil;
			end;

			if kept then done = done + 1 else failed = failed + 1 end;

			local pct = math.floor(index / total * 10);

			if pct > lastPct then
				lastPct = pct;

				if report then report(index, total) end;

				task.wait();
			end;
		end;

		settle();

		return done, failed;
	end;
end;

if Remote.base ~= "" then
	local started = os.clock();

	local ok, done, failed = pcall(Remote.sync, function(at, total)
		warn(("[visuals] assets %d/%d"):format(at, total));
	end);

	if ok and (done > 0 or failed > 0) then
		warn(("[visuals] assets: %d fetched, %d failed, %.0fs"):format(done, failed, os.clock() - started));
	end;
end;

if getgenv and getgenv().Visuals then
	pcall(getgenv().Visuals.Unload);
end;

if type(SOURCE) ~= "string" and readfile and isfile and isfile("UI-lib/adapter.luau") then
	SOURCE = readfile("UI-lib/adapter.luau");
end;

if type(LIBRARY_SOURCE) ~= "string" and readfile and isfile and isfile("UI-lib/shitaroebet.luau") then
	LIBRARY_SOURCE = readfile("UI-lib/shitaroebet.luau");
end;

assert(type(SOURCE) == "string" and SOURCE ~= "",
	"no UI source. This is the unbuilt main.lua - it takes the adapter and the "
	.. "library as chunk arguments. Run build_clean.py and ship dist/main.lua, "
	.. "which has both folded in and needs no arguments.");
local libraryChunk, libraryError = loadstring(SOURCE, "@adapter");

assert(libraryChunk, libraryError);

local NeverLose = libraryChunk(LIBRARY_SOURCE);

SOURCE, LIBRARY_SOURCE = nil, nil;

NeverLose.UnloadEnabled = true;

do
	local okRegular, regular = pcall(function() return Font.fromEnum(Enum.Font.GothamMedium) end);
	local okBold, bold = pcall(function() return Font.fromEnum(Enum.Font.GothamBold) end);
	if okRegular and regular then NeverLose.BuiltInRegular = regular end;
	if okBold and bold then NeverLose.BuiltInBold = bold end;
end;

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local LocalPlayer = Players.LocalPlayer;

do
	local gui = NeverLose.ScreenGui;
	if gui and gui.Parent then
		for _, other in ipairs(gui.Parent:GetChildren()) do
			if other ~= gui and other:GetAttribute(TAG) then
				other:Destroy();
			end;
		end;
	end;
	if gui then gui:SetAttribute(TAG, true); end;
end;

local Notification = NeverLose:CreateNotification();
local Logging = NeverLose:CreateLogger();
local Indicator = NeverLose:CreateIndicator();

local Window = NeverLose:CreateWindow({
	Logo = NeverLose.GlobalLogo,
	Name = "visuals",
	Content = "Roblox",
	Size = UDim2.fromOffset(660, 540),
	ConfigFolder = "Salad Visuals/Config",
	Enable3DRenderer = false,
	Keybind = "RightShift",
});

local okThumb, thumb = pcall(function()
	return Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100);
end);

Window:SetAccount({
	Username = LocalPlayer.Name,
	Profile = okThumb and thumb or nil,
	Expires = "lifetime",
});

local Watermark = Window:Watermark();
local fpsBlock = Watermark:AddBlock("chart-four-vertical-bars", "0 FPS");
local pingBlock = Watermark:AddBlock("signal-exclamation", "0 MS");
local nameBlock = Watermark:AddBlock("cube-vertexes", "visuals");

nameBlock:Input(function()
	Window:ToggleInterface();
end);

local Tabs, Sections = {}, {};

local function makeGroup(title, icon, entries)
	local group = Window:AddGroup(title, icon, entries);

	for _, entry in ipairs(entries) do
		group[entry.Name] = group[entry.Name] or {};
	end;

	return group;
end;

local Visuals = makeGroup("VISUALS", "eye", {
	{ Icon = "person", Name = "ESP" },
	{ Icon = "globe-simplified", Name = "World" },
	{ Icon = "frame-corners", Name = "Screen" },
	{ Icon = "sword", Name = "Skins" },
	{ Icon = "shirt", Name = "Models" },
});

Tabs.Visuals = Visuals;

local MiscGroup = makeGroup("MISC", "gear", {
	{ Icon = "person-play", Name = "Emotes" },
	{ Icon = "person-running", Name = "Animations" },
	{ Icon = "hammer-code", Name = "Helpers" },
	{ Icon = "three-sliders-horizontal", Name = "Menu" },
	{ Icon = "music", Name = "Music" },
});

Tabs.Misc = MiscGroup;

Sections.Emotes = MiscGroup.Emotes:AddSection({ Name = "Emotes", Position = "left" });
Sections.EmoteOptions = MiscGroup.Emotes:AddSection({ Name = "Playback", Position = "right" });
Sections.Animations = MiscGroup.Animations:AddSection({ Name = "Animations", Position = "left" });
Sections.AnimationOptions = MiscGroup.Animations:AddSection({ Name = "Playback", Position = "right" });
Sections.Helpers = MiscGroup.Helpers:AddSection({ Name = "Helpers", Position = "left" });
Sections.Anti = MiscGroup.Helpers:AddSection({ Name = "Anti", Position = "right" });
Sections.Trade = MiscGroup.Helpers:AddSection({ Name = "Trade", Position = "right" });
Sections.MenuSounds = MiscGroup.Menu:AddSection({ Name = "Menu Sounds", Position = "left" });
Sections.MenuSticker = MiscGroup.Menu:AddSection({ Name = "Menu Sticker", Position = "right" });
Sections.Music = MiscGroup.Music:AddSection({ Name = "Player", Position = "left" });
Sections.MusicHud = MiscGroup.Music:AddSection({ Name = "HUD", Position = "right" });
Sections.Spotify = MiscGroup.Music:AddSection({ Name = "Spotify", Position = "left" });
Sections.SoundCloud = MiscGroup.Music:AddSection({ Name = "SoundCloud", Position = "left" });
Sections.Vk = MiscGroup.Music:AddSection({ Name = "VK", Position = "left" });

Sections.ESP = Visuals.ESP:AddSection({ Name = "ESP", Position = "left" });
Sections.Chams = Visuals.ESP:AddSection({ Name = "Chams", Position = "right" });

Sections.Guns = Visuals.ESP:AddSection({ Name = "Gun Chams", Position = "left" });

local S = {
	Enabled = false, Target = "Other",

	Skeleton = false, SkeletonColor = Color3.fromRGB(255, 255, 255),
	Arrows = false, ArrowColor = Color3.fromRGB(255, 255, 255),
	ArrowSize = 22, ArrowRadius = 180, ArrowImage = "Triangle", ArrowTurn = 0,

	Name = false, NameColor = Color3.fromRGB(255, 255, 255), Distance = false,
	Box = false, BoxStyle = "Full", BoxColor = Color3.fromRGB(255, 255, 255),
	BoxThickness = 1, BoxFilled = false, BoxFillOpacity = 20,

	Tracer = false, TracerFrom = "Bottom", TracerColor = Color3.fromRGB(78, 127, 252),
	TracerThickness = 1,

	Chams = false, ChamsTarget = "Other",
	ChamsFill = Color3.fromRGB(78, 127, 252), ChamsFillT = 50,
	ChamsOutline = Color3.fromRGB(255, 255, 255), ChamsOutlineT = 0,

	MatChams = false, MatType = "Material",

	MatStyle = "Chromatic", MatMaterial = "ForceField",
	MatTransparency = 0, MatBloom = 0,
	MatColor = Color3.fromRGB(120, 200, 255),

	MatColor2 = Color3.fromRGB(255, 125, 245), MatChroma = false,
	MatVisColor = Color3.fromRGB(255, 255, 255), MatVisT = 0,
	MatOccColor = Color3.fromRGB(0, 0, 255), MatOccT = 0,

	ItemChams = false, ItemStyle = "ForceField", ItemTarget = "Other",
	ItemColor = Color3.fromRGB(255, 170, 60),
};

local ESP = { Settings = S };

local Render = {};

do
	local camera = workspace.CurrentCamera;

	function Render.camera()
		local current = workspace.CurrentCamera;

		if current ~= camera then camera = current end;

		return camera;
	end;

	function Render.basis()
		local cam = Render.camera();

		if not cam then return nil end;

		local cf = cam.CFrame;
		local viewport = cam.ViewportSize;
		local half = math.tan(math.rad(cam.FieldOfView) * 0.5);

		return {
			pos = cf.Position,
			look = cf.LookVector,
			right = cf.RightVector,
			up = cf.UpVector,
			midX = viewport.X * 0.5,
			midY = viewport.Y * 0.5,
			scale = (viewport.Y * 0.5) / half,
			viewport = viewport,
		};
	end;

	local NEAR = 0.6;

	function Render.segment(basis, a, b)
		local function depthOf(p)
			return (p.X - basis.pos.X) * basis.look.X
				+ (p.Y - basis.pos.Y) * basis.look.Y
				+ (p.Z - basis.pos.Z) * basis.look.Z;
		end;

		local da, db = depthOf(a), depthOf(b);

		if da < NEAR and db < NEAR then return nil end;

		if da < NEAR then
			a = a:Lerp(b, (NEAR - da) / (db - da));
			da = NEAR;
		elseif db < NEAR then
			b = b:Lerp(a, (NEAR - db) / (da - db));
			db = NEAR;
		end;

		local ax, ay = Render.project(basis, a);
		local bx, by = Render.project(basis, b);

		return ax, ay, bx, by, (da + db) * 0.5;
	end;

	function Render.project(basis, point)
		local dx = point.X - basis.pos.X;
		local dy = point.Y - basis.pos.Y;
		local dz = point.Z - basis.pos.Z;
		local depth = dx * basis.look.X + dy * basis.look.Y + dz * basis.look.Z;

		if depth <= 0.05 then return 0, 0, depth end;

		local inv = basis.scale / depth;

		return basis.midX + (dx * basis.right.X + dy * basis.right.Y + dz * basis.right.Z) * inv,
			basis.midY - (dx * basis.up.X + dy * basis.up.Y + dz * basis.up.Z) * inv,
			depth;
	end;

	function Render.pool(class, setup)
		local items, used = {}, 0;
		local pool = {};

		function pool.take()
			used = used + 1;

			local item = items[used];

			if not item then
				item = Drawing.new(class);

				if setup then setup(item) end;

				items[used] = item;
			end;

			return item;
		end;

		function pool.reset() used = 0 end;

		function pool.done()
			for index = used + 1, #items do
				local item = items[index];

				if item and item.Visible then item.Visible = false end;
			end;
		end;

		function pool.wipe()
			for index = 1, #items do destroyAny(items[index]) end;

			table.clear(items);

			used = 0;
		end;

		function pool.count() return used end;

		return pool;
	end;

	function Render.gui(label, order)
		local gui = Instance.new("ScreenGui");
		gui.Name = NeverLose.RandomString();
		gui.ResetOnSpawn = false;
		gui.IgnoreGuiInset = true;
		gui.DisplayOrder = order or 0;
		gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;

		pcall(function() gui:SetAttribute(TAG, true) end);

		local parent = NeverLose.ScreenGui and NeverLose.ScreenGui.Parent;

		gui.Parent = parent or ((gethui and gethui()) or game:GetService("CoreGui"));

		onUnload("gui:" .. tostring(label), function()
			if gui then gui:Destroy() end;
		end);

		return gui;
	end;
end;

ESP.Render = Render;

function ESP.Grad(c1, c2, p, off)
	return c1:Lerp(c2, math.sin((p or 0) * math.pi + os.clock() * 2 + (off or 0) * 6.283) * 0.5 + 0.5);
end;

do
	local Camera = workspace.CurrentCamera;
	local bundles, highlights = {}, {};

	local function inTarget(target, isSelf)
		return target == "All" or (isSelf and target == "Self") or (not isSelf and target == "Other");
	end;

	ESP.Wants = inTarget;

	local ARROW_SKINS = {
		Triangle = { file = Remote.file("images/triangle.png"), rotation = 90, scale = 1,
			rectOffset = Vector2.new(82, 87), rectSize = Vector2.new(638, 638) },
		["Triangle 2"] = { file = Remote.file("images/triangle2.png"), rotation = 90, scale = 1,
			rectOffset = Vector2.new(66, 76), rectSize = Vector2.new(380, 380) },
		Arrows = { file = Remote.file("images/arrows.png"), rotation = 90, scale = 1,
			rectOffset = Vector2.new(5, 6), rectSize = Vector2.new(110, 110) },
		White = { file = Remote.file("images/white.png"), rotation = 0, scale = 1,
			rectOffset = Vector2.new(38, 28), rectSize = Vector2.new(967, 967) },

		["Arrows 2"] = { file = Remote.file("images/arrows2.png"), rotation = -90, scale = 1,
			rectOffset = Vector2.new(6, 11), rectSize = Vector2.new(489, 489) },

		["Arrow 3"] = { file = Remote.file("images/arrow3.png"), rotation = 90, scale = 1,
			rectOffset = Vector2.new(73, 78), rectSize = Vector2.new(87, 87) },
	};

	ESP.ArrowSkins = ARROW_SKINS;

	local arrowUrls = {};

	local function arrowSkin()
		local skin = ARROW_SKINS[S.ArrowImage] or ARROW_SKINS.Triangle;

		if arrowUrls[skin.file] == nil then
			arrowUrls[skin.file] = false;

			pcall(function()
				if getcustomasset and isfile and isfile(skin.file) then
					arrowUrls[skin.file] = getcustomasset(skin.file);
				end;
			end);
		end;

		return arrowUrls[skin.file] or "rbxassetid://4918373417", skin;
	end;

	ESP.ArrowSkin = arrowSkin;

	local arrowGui = Instance.new("ScreenGui");
	arrowGui.Name = NeverLose.RandomString();
	arrowGui.ResetOnSpawn = false;
	arrowGui.IgnoreGuiInset = true;
	arrowGui.DisplayOrder = -4;
	arrowGui:SetAttribute(TAG, true);
	pcall(function() arrowGui.Parent = NeverLose.ScreenGui.Parent end);

	ESP.ArrowGui = arrowGui;

	local function arrowImage()
		local image = Instance.new("ImageLabel");
		image.Name = NeverLose.RandomString();
		image.Parent = arrowGui;
		image.AnchorPoint = Vector2.new(0.5, 0.5);
		image.BackgroundTransparency = 1;
		image.BorderSizePixel = 0;
		image.Visible = false;
		image.Image = arrowSkin();

		return image;
	end;

	local function square(filled)
		local sq = Drawing.new("Square");
		sq.Thickness = 1;
		sq.Filled = filled;
		sq.Visible = false;
		return sq;
	end;

	local function bundleOf(player)
		if bundles[player] then return bundles[player] end;

		local b = {
			name = Drawing.new("Text"),
			arrow = arrowImage(),
			bones = {},
			tracer = Drawing.new("Line"),
			fill = square(true),
			bars = {},
			outlines = {},
			edges = {},
		};

		b.tracer.Thickness = 1;
		b.tracer.Visible = false;

		b.name.Size = 13;
		b.name.Center = true;
		b.name.Outline = true;
		b.name.Font = 2;
		b.name.Visible = false;

		b.player = player;
		bundles[player] = b;

		return b;
	end;

	local function hideSkeleton(b)
		for _, bone in ipairs(b.bones) do bone.Visible = false end;
	end;

	local function hideBox(b)
		b.name.Visible = false;
		b.fill.Visible = false;

		for _, piece in ipairs(b.bars) do piece.Visible = false end;
		for _, piece in ipairs(b.outlines) do piece.Visible = false end;
		for _, piece in ipairs(b.edges) do piece.Visible = false end;
	end;

	local extents = setmetatable({}, { __mode = "k" });

	local function getExtents(char, root)
		local held = extents[char];

		if held and os.clock() - held.at < 0.5 then return held end;

		local inv = root.CFrame:Inverse();
		local lo = Vector3.new(math.huge, math.huge, math.huge);
		local hi = Vector3.new(-math.huge, -math.huge, -math.huge);
		local any = false;

		for _, part in ipairs(char:GetChildren()) do
			if part:IsA("BasePart") then
				local cf = inv * part.CFrame;
				local half = part.Size * 0.5;
				local rv, uv, lv = cf.RightVector, cf.UpVector, cf.LookVector;

				local spread = Vector3.new(
					math.abs(rv.X) * half.X + math.abs(uv.X) * half.Y + math.abs(lv.X) * half.Z,
					math.abs(rv.Y) * half.X + math.abs(uv.Y) * half.Y + math.abs(lv.Y) * half.Z,
					math.abs(rv.Z) * half.X + math.abs(uv.Z) * half.Y + math.abs(lv.Z) * half.Z
				);

				lo = lo:Min(cf.Position - spread);
				hi = hi:Max(cf.Position + spread);
				any = true;
			end;
		end;

		if not any then return nil end;

		local half = (hi - lo) * 0.5;

		half = Vector3.new(math.min(half.X, 12), math.min(half.Y, 12), math.min(half.Z, 12));

		held = { at = os.clock(), center = (lo + hi) * 0.5, half = half };
		extents[char] = held;

		return held;
	end;

	local CORNERS = {
		Vector3.new(-1, -1, -1), Vector3.new(1, -1, -1), Vector3.new(1, -1, 1), Vector3.new(-1, -1, 1),
		Vector3.new(-1, 1, -1), Vector3.new(1, 1, -1), Vector3.new(1, 1, 1), Vector3.new(-1, 1, 1),
	};

	local screenCorners = {};

	local function screenBox(char)
		local root = char:FindFirstChild("HumanoidRootPart");
		if not root then return nil end;

		local box = getExtents(char, root);
		if not box then return nil end;

		local cf = root.CFrame;
		local mid = Camera:WorldToViewportPoint(cf * box.center);

		if mid.Z <= 0 then return nil end;

		local half = box.half;
		local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge;
		local whole = true;

		for index = 1, 8 do
			local corner = CORNERS[index];
			local offset = Vector3.new(corner.X * half.X, corner.Y * half.Y, corner.Z * half.Z);
			local point = Camera:WorldToViewportPoint(cf * (box.center + offset));

			if point.Z <= 0 then point = mid; whole = false end;

			local x, y = point.X, point.Y;

			screenCorners[index] = Vector2.new(x, y);

			if x < minX then minX = x end;
			if x > maxX then maxX = x end;
			if y < minY then minY = y end;
			if y > maxY then maxY = y end;
		end;

		local width, height = maxX - minX, maxY - minY;

		if width ~= width or height ~= height then return nil end;
		if width < 1 or height < 1 or width > 20000 or height > 20000 then return nil end;

		return Vector2.new(minX, minY), Vector2.new(width, height), whole and screenCorners or nil;
	end;

	local R15_BONES = {
		{ "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" },
		{ "UpperTorso", "LeftUpperArm" }, { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
		{ "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" }, { "RightLowerArm", "RightHand" },
		{ "LowerTorso", "LeftUpperLeg" }, { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
		{ "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" }, { "RightLowerLeg", "RightFoot" },
	};

	local R6_BONES = {
		{ "Head", "Torso" },
		{ "Torso", "Left Arm" }, { "Torso", "Right Arm" },
		{ "Torso", "Left Leg" }, { "Torso", "Right Leg" },
	};

	local function getBone(b, index)
		if not b.bones[index] then
			local line = Drawing.new("Line");
			line.Thickness = 1;
			line.Visible = false;
			b.bones[index] = line;
		end;

		return b.bones[index];
	end;

	local function drawSkeleton(b, char)
		local bones = char:FindFirstChild("UpperTorso") and R15_BONES or R6_BONES;

		for i, pair in ipairs(bones) do
			local from = char:FindFirstChild(pair[1]);
			local to = char:FindFirstChild(pair[2]);
			local line = getBone(b, i);

			if from and to and line then
				local a = Camera:WorldToViewportPoint(from.Position);
				local c = Camera:WorldToViewportPoint(to.Position);

				local onScreen = a.Z > 0 and c.Z > 0
					and math.abs(a.X) < 10000 and math.abs(a.Y) < 10000
					and math.abs(c.X) < 10000 and math.abs(c.Y) < 10000;

				if onScreen then
					line.From = Vector2.new(a.X, a.Y);
					line.To = Vector2.new(c.X, c.Y);
					line.Color = S.SkeletonColor;
					line.Visible = true;
				else
					line.Visible = false;
				end;
			elseif line then
				line.Visible = false;
			end;
		end;

		for i = #bones + 1, #b.bones do
			b.bones[i].Visible = false;
		end;
	end;

	local function drawArrow(b, root)
		local viewport = Camera.ViewportSize;
		local center = Vector2.new(viewport.X / 2, viewport.Y / 2);
		local point = Camera:WorldToViewportPoint(root.Position);
		local direction = Vector2.new(point.X, point.Y) - center;

		if point.Z < 0 then direction = -direction end;

		local length = direction.Magnitude;

		if length < 1 or length ~= length or length == math.huge then
			b.arrow.Visible = false;
			return;
		end;

		local unit = direction / length;
		local at = center + unit * S.ArrowRadius;

		local url, skin = arrowSkin();
		local size = S.ArrowSize * skin.scale;

		b.arrow.Image = url;
		b.arrow.ImageRectOffset = skin.rectOffset or Vector2.zero;
		b.arrow.ImageRectSize = skin.rectSize or Vector2.zero;
		b.arrow.Position = UDim2.fromOffset(at.X, at.Y);
		b.arrow.Size = UDim2.fromOffset(size, size);
		b.arrow.Rotation = math.deg(math.atan2(unit.Y, unit.X)) + skin.rotation + S.ArrowTurn;
		b.arrow.ImageColor3 = S.ArrowColor;
		b.arrow.Visible = true;
	end;

	local function rect(pool, index, at, size, color, thickness)
		local piece = pool[index];

		if not piece then
			piece = Drawing.new("Square");
			piece.Filled = true;
			piece.Thickness = 1;
			pool[index] = piece;
		end;

		piece.Position = at;
		piece.Size = size;
		piece.Color = color;
		piece.Visible = true;

		return index + 1;
	end;

	local function line(pool, index, from, to, color, thickness)
		local piece = pool[index];

		if not piece then
			piece = Drawing.new("Line");
			pool[index] = piece;
		end;

		piece.From = from;
		piece.To = to;
		piece.Color = color;
		piece.Thickness = thickness;
		piece.Visible = true;

		return index + 1;
	end;

	local function hidePool(pool, from)
		for i = from, #pool do pool[i].Visible = false end;
	end;

	local EDGES = {
		{ 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 1 },
		{ 5, 6 }, { 6, 7 }, { 7, 8 }, { 8, 5 },
		{ 1, 5 }, { 2, 6 }, { 3, 7 }, { 4, 8 },
	};

	local DARK = Color3.fromRGB(0, 0, 0);

	local function drawBox(b, at, size, corners)
		local x1, y1 = math.floor(at.X), math.floor(at.Y);
		local x2, y2 = math.floor(at.X + size.X), math.floor(at.Y + size.Y);
		local w, h = x2 - x1, y2 - y1;

		if w <= 0 or h <= 0 then
			hidePool(b.bars, 1);
			hidePool(b.outlines, 1);
			hidePool(b.edges, 1);
			b.fill.Visible = false;
			return;
		end;

		b.fill.Visible = S.BoxFilled;
		b.fill.Position, b.fill.Size = Vector2.new(x1, y1), Vector2.new(w, h);
		b.fill.Color = S.BoxColor;
		b.fill.Transparency = S.BoxFillOpacity / 100;

		local thick = S.BoxThickness;
		local color = S.BoxColor;
		local style = S.BoxStyle;
		local i, o, e = 1, 1, 1;

		if style == "3D" and corners then

			for pass = 1, 2 do
				local shade = (pass == 1) and DARK or color;
				local weight = (pass == 1) and (thick + 2) or thick;

				for _, edge in ipairs(EDGES) do
					e = line(b.edges, e, corners[edge[1]], corners[edge[2]], shade, weight);
				end;
			end;
		elseif style == "Corner" or style == "Bracket" then

			local tall = style == "Bracket";
			local lx = math.max(1, math.floor(w * 0.28));
			local ly = tall and h or math.max(1, math.floor(h * 0.28));

			o = rect(b.outlines, o, Vector2.new(x1 - 1, y1 - 1), Vector2.new(lx + 2, thick + 2), DARK);
			o = rect(b.outlines, o, Vector2.new(x2 - lx - 1, y1 - 1), Vector2.new(lx + 2, thick + 2), DARK);
			o = rect(b.outlines, o, Vector2.new(x1 - 1, y2 - thick - 1), Vector2.new(lx + 2, thick + 2), DARK);
			o = rect(b.outlines, o, Vector2.new(x2 - lx - 1, y2 - thick - 1), Vector2.new(lx + 2, thick + 2), DARK);
			o = rect(b.outlines, o, Vector2.new(x1 - 1, y1 - 1), Vector2.new(thick + 2, ly + 2), DARK);
			o = rect(b.outlines, o, Vector2.new(x2 - thick - 1, y1 - 1), Vector2.new(thick + 2, ly + 2), DARK);

			i = rect(b.bars, i, Vector2.new(x1, y1), Vector2.new(lx, thick), color);
			i = rect(b.bars, i, Vector2.new(x2 - lx, y1), Vector2.new(lx, thick), color);
			i = rect(b.bars, i, Vector2.new(x1, y2 - thick), Vector2.new(lx, thick), color);
			i = rect(b.bars, i, Vector2.new(x2 - lx, y2 - thick), Vector2.new(lx, thick), color);
			i = rect(b.bars, i, Vector2.new(x1, y1), Vector2.new(thick, ly), color);
			i = rect(b.bars, i, Vector2.new(x2 - thick, y1), Vector2.new(thick, ly), color);

			if not tall then
				o = rect(b.outlines, o, Vector2.new(x1 - 1, y2 - ly - 1), Vector2.new(thick + 2, ly + 2), DARK);
				o = rect(b.outlines, o, Vector2.new(x2 - thick - 1, y2 - ly - 1), Vector2.new(thick + 2, ly + 2), DARK);

				i = rect(b.bars, i, Vector2.new(x1, y2 - ly), Vector2.new(thick, ly), color);
				i = rect(b.bars, i, Vector2.new(x2 - thick, y2 - ly), Vector2.new(thick, ly), color);
			end;
		else
			o = rect(b.outlines, o, Vector2.new(x1 - 1, y1 - 1), Vector2.new(w + 2, thick + 2), DARK);
			o = rect(b.outlines, o, Vector2.new(x1 - 1, y2 - thick - 1), Vector2.new(w + 2, thick + 2), DARK);
			o = rect(b.outlines, o, Vector2.new(x1 - 1, y1 - 1), Vector2.new(thick + 2, h + 2), DARK);
			o = rect(b.outlines, o, Vector2.new(x2 - thick - 1, y1 - 1), Vector2.new(thick + 2, h + 2), DARK);

			i = rect(b.bars, i, Vector2.new(x1, y1), Vector2.new(w, thick), color);
			i = rect(b.bars, i, Vector2.new(x1, y2 - thick), Vector2.new(w, thick), color);
			i = rect(b.bars, i, Vector2.new(x1, y1), Vector2.new(thick, h), color);
			i = rect(b.bars, i, Vector2.new(x2 - thick, y1), Vector2.new(thick, h), color);
		end;

		hidePool(b.bars, i);
		hidePool(b.outlines, o);
		hidePool(b.edges, e);
	end;

	local clearChromatic, clearOcclusion;
	local itemHighlights, itemHeld = {}, {};
	local matClock = {};
	local itemClock = {};

	local seenChar = {};

	local function charChanged(player, char)
		if seenChar[player] == char then return false end;

		seenChar[player] = char;

		return true;
	end;
	local function drop(player)
		local b = bundles[player];

		if player.Character then
			pcall(ESP.Restore, player.Character);
		end;

		if type(clearChromatic) == "function" then clearChromatic(player) end;
		if type(clearOcclusion) == "function" then clearOcclusion(player) end;
		matClock[player] = nil;
		itemClock[player] = nil;
		seenChar[player] = nil;

		if itemHighlights[player] then
			itemHighlights[player]:Destroy();
			itemHighlights[player] = nil;
		end;

		if itemHeld[player] then
			if type(clearChromatic) == "function" then clearChromatic(itemHeld[player]) end;
			pcall(ESP.Restore, itemHeld[player]);
			itemHeld[player] = nil;
		end;

		if b then
			destroyAny(b.name);
			destroyAny(b.tracer);
			destroyAny(b.arrow);

			for _, bone in ipairs(b.bones) do destroyAny(bone) end;
			destroyAny(b.fill);

			for _, piece in ipairs(b.bars) do destroyAny(piece) end;
			for _, piece in ipairs(b.outlines) do destroyAny(piece) end;
			for _, piece in ipairs(b.edges) do destroyAny(piece) end;

			bundles[player] = nil;
		end;

		if highlights[player] then
			highlights[player]:Destroy();
			highlights[player] = nil;
		end;
	end;

	local MATERIAL_STYLES = {
		ForceField = { material = Enum.Material.ForceField, reflectance = 0, transparency = 0, tint = true },
		Flat = { material = Enum.Material.SmoothPlastic, reflectance = 0, transparency = 0, tint = true },
		Glass = { material = Enum.Material.Glass, reflectance = 0.3, transparency = 0.4, tint = true },
		Ice = { material = Enum.Material.Ice, reflectance = 0.2, transparency = 0.2, tint = true },
		Ghost = { material = Enum.Material.SmoothPlastic, reflectance = 0, transparency = 0.65, tint = true },

		Marble = { material = Enum.Material.Marble, reflectance = 0, transparency = 0, tint = true },
		Foil = { material = Enum.Material.Foil, reflectance = 0.4, transparency = 0, tint = true },
		Metal = { material = Enum.Material.DiamondPlate, reflectance = 0.5, transparency = 0, tint = true },
		Wood = { material = Enum.Material.WoodPlanks, reflectance = 0, transparency = 0, tint = true },
	};

	ESP.MaterialStyles = MATERIAL_STYLES;

	ESP.MaterialOrder = { "ForceField", "Flat", "Glass", "Ice", "Ghost", "Marble", "Foil", "Metal", "Wood" };

	ESP.ChromaticOrder = { "Chromatic" };

	ESP.StyleOrder = {};

	for _, name in ipairs(ESP.MaterialOrder) do ESP.StyleOrder[#ESP.StyleOrder + 1] = name end;
	for _, name in ipairs(ESP.ChromaticOrder) do ESP.StyleOrder[#ESP.StyleOrder + 1] = name end;

	local cache = {};

	local function entry(model)
		if not cache[model] then
			cache[model] = { parts = {}, hidden = {}, meshes = {} };
		end;

		return cache[model];
	end;

	ESP.PaintCache = function(model) return cache[model] end;

	local function restore(model)
		local data = cache[model];
		if not data then return end;

		for part, orig in pairs(data.parts) do
			if part.Parent then
				part.Material = orig.Material;
				part.Color = orig.Color;
				part.Transparency = orig.Transparency;
				part.Reflectance = orig.Reflectance;

				if orig.TextureID then
					pcall(function() part.TextureID = orig.TextureID end);
				end;
			end;
		end;

		for mesh, texture in pairs(data.meshes or {}) do
			if mesh.Parent then pcall(function() mesh.TextureId = texture end) end;
		end;

		for inst, parent in pairs(data.hidden) do
			pcall(function() inst.Parent = parent end);
		end;

		cache[model] = nil;
	end;

	local function paint(model, styleName, color)
		local style = (type(styleName) == "table" and styleName) or MATERIAL_STYLES[styleName];

		if not style then
			restore(model);
			return;
		end;

		local data = entry(model);

		for _, inst in ipairs(model:GetDescendants()) do
			if inst:IsA("BasePart") then
				if not data.parts[inst] then
					data.parts[inst] = {
						Material = inst.Material,
						Color = inst.Color,
						Transparency = inst.Transparency,
						Reflectance = inst.Reflectance,
						TextureID = inst:IsA("MeshPart") and inst.TextureID or nil,
					};
				end;

				if data.parts[inst].Transparency < 1 then

					data.parts[inst].Wanted = style.material or data.parts[inst].Material;

					inst.Material = style.material or data.parts[inst].Material;
					inst.Reflectance = style.reflectance;
					inst.Transparency = style.transparency;

					inst.Color = style.tint and color or data.parts[inst].Color;
					if inst:IsA("MeshPart") and not style.keepTexture then
						pcall(function() inst.TextureID = "" end);
					end;

					if not style.keepTexture then
						local mesh = inst:FindFirstChildOfClass("SpecialMesh");

						if mesh then
							if data.meshes[mesh] == nil then data.meshes[mesh] = mesh.TextureId end;

							if mesh.TextureId ~= "" then
								pcall(function() mesh.TextureId = "" end);
							end;
						end;
					end;
				end;
			elseif not style.keepTexture and (inst:IsA("Shirt") or inst:IsA("Pants") or inst:IsA("ShirtGraphic")
				or inst:IsA("Decal") or inst:IsA("Texture") or inst:IsA("SurfaceAppearance")) then

				if data.hidden[inst] == nil and inst.Parent then
					data.hidden[inst] = inst.Parent;
					pcall(function() inst.Parent = nil end);
				end;
			end;
		end;
	end;

	ESP.Paint = paint;
	ESP.Restore = restore;

	local revision, applied, painted = 0, {}, {};

	ESP.Restyle = function() revision = revision + 1 end;

	local CHROM_STATE_STRIDE = 3;
	local CHROM_PAD_X = 180;
	local CHROM_PAD_Y = 220;
	local CHROM_HIDE_DELAY = 90;
	local CHROM_SHOW_BUDGET = 2;

	local CHROM_SCALE, CHROM_ALPHA = 1.012, 0.025;

	local CHROMATIC_PRESETS = {
		Chromatic = {
			{ Scale = CHROM_SCALE, Alpha = CHROM_ALPHA, Material = Enum.Material.Foil, Reflectance = 0.12, ColorMode = "Base" },
		},
	};

	ESP.ChromaticPresets = CHROMATIC_PRESETS;

	local R15_PARTS = {
		Head = true, UpperTorso = true, LowerTorso = true,
		LeftUpperArm = true, LeftLowerArm = true, LeftHand = true,
		RightUpperArm = true, RightLowerArm = true, RightHand = true,
		LeftUpperLeg = true, LeftLowerLeg = true, LeftFoot = true,
		RightUpperLeg = true, RightLowerLeg = true, RightFoot = true,
		Torso = true, ["Left Arm"] = true, ["Right Arm"] = true,
		["Left Leg"] = true, ["Right Leg"] = true,
	};

	local function isBP(name)
		return R15_PARTS[name] == true;
	end;

	local function isCP(part)
		return part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" and part.Name ~= "GlowShell";
	end;

	local function isDeformable(part)
		if part:FindFirstChildWhichIsA("WrapLayer") then return true end;
		if isBP(part.Name) then return false end;
		if part:FindFirstChildWhichIsA("Bone") then return true end;

		local ok, skinned = pcall(function() return part.HasSkinnedMesh end);

		return ok and skinned == true;
	end;

	local function tryClone(inst)
		local archivable = inst.Archivable;

		if not archivable then
			if not pcall(function() inst.Archivable = true end) then return nil end;
		end;

		local ok, clone = pcall(inst.Clone, inst);

		if not archivable then
			pcall(function() inst.Archivable = archivable end);
		end;

		if not ok then return nil end;

		return clone;
	end;

	local chromGui = Instance.new("ScreenGui");
	chromGui.Name = NeverLose.RandomString();
	chromGui.ResetOnSpawn = false;
	chromGui.IgnoreGuiInset = true;
	chromGui.DisplayOrder = -5;
	chromGui:SetAttribute(TAG, true);
	pcall(function() chromGui.Parent = NeverLose.ScreenGui.Parent end);

	ESP.ChromaticGui = chromGui;

	local Chromatic = { Presets = CHROMATIC_PRESETS };
	local frameId = 0;

	function Chromatic:Ensure(count)
		local worlds = self.Worlds;

		if not worlds then
			worlds = {};
			self.Worlds = worlds;
			self.Views = {};
		end;

		local have = #worlds;
		if have >= count then return end;

		local sky = game:GetService("Lighting"):FindFirstChildOfClass("Sky");

		for i = have + 1, count do
			local view = Instance.new("ViewportFrame");
			view.Name = "ChromaticLayer" .. i;
			view.Size = UDim2.fromScale(1, 1);
			view.BackgroundTransparency = 1;
			view.BorderSizePixel = 0;
			view.ZIndex = i;
			view.Ambient = Color3.new(1, 1, 1);
			view.LightColor = Color3.new(1, 1, 1);
			view.LightDirection = Vector3.new(-1, -1, -1);
			view.CurrentCamera = workspace.CurrentCamera;
			view.Parent = chromGui;

			if sky then sky:Clone().Parent = view end;

			local world = Instance.new("WorldModel");
			world.Name = "ChromaticWorld";
			world.Parent = view;

			self.Views[i] = view;
			self.Worlds[i] = world;
		end;
	end;

	function Chromatic:BeginFrame()
		if self.Frame == frameId then return self.Camera end;

		self.Frame = frameId;
		self.ShowBudget = CHROM_SHOW_BUDGET;

		local camera = workspace.CurrentCamera;
		self.Camera = camera;

		if not camera then return nil end;

		self.Origin = camera.CFrame.Position;

		local size = camera.ViewportSize;
		self.MaxX = size.X + CHROM_PAD_X;
		self.MaxY = size.Y + CHROM_PAD_Y;

		local views = self.Views;

		if views then
			for i = 1, #views do
				if views[i].CurrentCamera ~= camera then
					views[i].CurrentCamera = camera;
				end;
			end;
		end;

		return camera;
	end;

	function Chromatic:TakeShow()
		local budget = self.ShowBudget;
		if not budget or budget <= 0 then return false end;
		self.ShowBudget = budget - 1;
		return true;
	end;

	local TINT_MIX = { Pearl = 0.45, Highlight = 0.68, Candy = 0.38 };

	local function chromaticColor(color, config, secondary, chroma, phase)
		local mix = TINT_MIX[config.ColorMode];

		if not mix then return color end;

		local other = secondary or (
			config.ColorMode == "Pearl" and Color3.fromRGB(255, 125, 245)
			or config.ColorMode == "Highlight" and Color3.new(1, 1, 1)
			or Color3.fromRGB(255, 55, 125)
		);

		if chroma then return ESP.Grad(color, other, phase or 0, 0) end;

		return color:Lerp(other, mix);
	end;

	ESP.ChromaticColor = chromaticColor;

	local function cloneChromaticPart(source, config, color)
		local clone = tryClone(source);
		if not clone then return nil end;

		local children = clone:GetChildren();

		for i = 1, #children do
			if not children[i]:IsA("DataModelMesh") then
				children[i]:Destroy();
			end;
		end;

		local mesh = clone:FindFirstChildWhichIsA("DataModelMesh");

		if mesh then
			mesh.Scale = mesh.Scale * config.Scale;
			if mesh:IsA("FileMesh") then mesh.TextureId = "" end;
		else
			clone.Size = clone.Size * config.Scale;
		end;

		if clone:IsA("MeshPart") then clone.TextureID = "" end;

		clone.MaterialVariant = "";
		clone.Anchored = true;
		clone.Massless = true;
		clone.CanCollide = false;
		clone.CanQuery = false;
		clone.CanTouch = false;
		clone.CastShadow = false;
		clone.LocalTransparencyModifier = 0;
		clone.Material = config.Material;
		clone.Reflectance = config.Reflectance;
		clone.Transparency = config.Alpha;
		clone.Color = chromaticColor(color, config, S.MatColor2, false);
		clone.CFrame = source.CFrame;

		return clone;
	end;

	local chrom = {};

	local function setChromaticParented(state, parented)
		if not state or state.Parented == parented then return end;

		state.Parented = parented;

		local models, parents = state.Models, state.Parents;

		for i = 1, #models do
			models[i].Parent = parented and parents[i] or nil;
		end;

		state.HideAt = nil;

		if parented then state.Tick = CHROM_STATE_STRIDE end;
	end;

	clearChromatic = function(player)
		local state = chrom[player];
		if not state then return end;

		for i = 1, #state.Models do
			state.Models[i]:Destroy();
		end;

		chrom[player] = nil;
	end;

	local function getParts(char)
		local parts, n = {}, 0;

		for _, inst in ipairs(char:GetDescendants()) do
			if isCP(inst) then
				n = n + 1;
				parts[n] = inst;
			end;
		end;

		return parts, n;
	end;

	local function applyChromatic(player, char, color, style)
		if not char then return end;

		style = CHROMATIC_PRESETS[style] and style or "Chromatic";

		local configs = CHROMATIC_PRESETS[style];
		local parts, partCount = getParts(char);
		local layerCount = #configs;
		local state = chrom[player];
		local rebuild = not state or state.Char ~= char or state.Count ~= partCount or state.Style ~= style;

		if rebuild then
			clearChromatic(player);
			Chromatic:Ensure(layerCount);

			local worlds = Chromatic.Worlds;
			local models, parents, layers, alphas = {}, {}, {}, {};

			state = {
				Char = char,
				Models = models,
				Parents = parents,
				Layers = layers,
				Alphas = alphas,
				Sources = {},
				Cframes = {},
				Hidden = {},
				N = 0,
				LayerCount = layerCount,
				Count = partCount,
				Color = color,
				Style = style,
				Configs = configs,
				Parented = false,
				Tick = CHROM_STATE_STRIDE,
			};

			for layer = 1, layerCount do
				local model = Instance.new("Model");
				model.Name = "ChromaticClone";

				models[layer] = model;
				parents[layer] = worlds[layer];
				layers[layer] = {};
				alphas[layer] = configs[layer].Alpha;
			end;

			local characterMeshes, meshCount = {}, 0;

			for _, child in ipairs(char:GetChildren()) do
				if child:IsA("CharacterMesh") then
					meshCount = meshCount + 1;
					characterMeshes[meshCount] = child;
				end;
			end;

			if meshCount > 0 then
				local sourceHumanoid = char:FindFirstChildOfClass("Humanoid");

				for layer = 1, layerCount do
					local humanoid = (sourceHumanoid and sourceHumanoid:Clone()) or Instance.new("Humanoid");
					humanoid:ClearAllChildren();
					humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
					humanoid.Parent = models[layer];

					for i = 1, meshCount do
						local mesh = characterMeshes[i]:Clone();
						mesh.BaseTextureId = 0;
						mesh.OverlayTextureId = 0;
						mesh.Parent = models[layer];
					end;
				end;
			end;

			local sources, cfs, hidden = state.Sources, state.Cframes, state.Hidden;
			local staged = {};
			local n = 0;

			for i = 1, partCount do
				local source = parts[i];

				if isCP(source) and not isDeformable(source) then
					local ok = true;

					for layer = 1, layerCount do
						local clone = cloneChromaticPart(source, configs[layer], color);
						staged[layer] = clone;

						if not clone then ok = false end;
					end;

					if ok then
						n = n + 1;
						sources[n] = source;
						cfs[n] = staged[1].CFrame;
						hidden[n] = false;

						for layer = 1, layerCount do
							staged[layer].Parent = models[layer];
							layers[layer][n] = staged[layer];
						end;
					else
						for layer = 1, layerCount do
							if staged[layer] then staged[layer]:Destroy() end;
						end;
					end;
				end;
			end;

			state.N = n;
			chrom[player] = state;
		elseif state.Color ~= color or state.Second ~= S.MatColor2 then
			state.Color = color;
			state.Second = S.MatColor2;

			for layer = 1, state.LayerCount do
				local clones = state.Layers[layer];
				local col = chromaticColor(color, configs[layer], S.MatColor2, false);

				for i = 1, state.N do
					clones[i].Color = col;
				end;
			end;
		end;
	end;

	local function renderChromatic(player)
		local state = chrom[player];
		if not state then return end;

		local camera = Chromatic:BeginFrame();

		if not camera then
			setChromaticParented(state, false);
			return;
		end;

		local char = state.Char;
		local root = state.Root;

		if not root or root.Parent ~= char then
			root = char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso")
				or char:FindFirstChildWhichIsA("BasePart");
			if root and not root:IsA("BasePart") then root = nil end;
			state.Root = root;
		end;

		if not root then
			setChromaticParented(state, false);
			return;
		end;

		local point = camera:WorldToViewportPoint(root.Position);
		local onScreen = point.Z > 0
			and point.X > -CHROM_PAD_X and point.X < Chromatic.MaxX
			and point.Y > -CHROM_PAD_Y and point.Y < Chromatic.MaxY;

		if onScreen then
			state.HideAt = nil;

			if not state.Parented then
				if not Chromatic:TakeShow() then return end;
				setChromaticParented(state, true);
			end;
		elseif state.Parented then
			local hideAt = state.HideAt;

			if not hideAt then
				state.HideAt = frameId + CHROM_HIDE_DELAY;
			elseif frameId >= hideAt then
				setChromaticParented(state, false);
				return;
			end;
		else
			return;
		end;

		local n = state.N;
		if n == 0 then return end;

		local tick = state.Tick + 1;
		local refresh = tick >= CHROM_STATE_STRIDE;
		state.Tick = refresh and 0 or tick;

		local sources, cfs, hidden = state.Sources, state.Cframes, state.Hidden;
		local layers, alphas, layerCount = state.Layers, state.Alphas, state.LayerCount;

		if refresh and S.MatChroma and state.Color then
			local configs = state.Configs;

			for layer = 1, layerCount do
				local col = chromaticColor(state.Color, configs[layer], S.MatColor2, true, (layer - 1) / math.max(1, layerCount));
				local clones = layers[layer];

				for i = 1, n do clones[i].Color = col end;
			end;
		end;

		for i = 1, n do
			local source = sources[i];
			local isHidden = hidden[i];

			if refresh then
				local nowHidden;

				if source.Parent then
					nowHidden = source.Transparency >= 1 or source.LocalTransparencyModifier >= 1;
				else
					nowHidden = true;
				end;

				if isHidden ~= nowHidden then
					isHidden = nowHidden;
					hidden[i] = nowHidden;

					for layer = 1, layerCount do
						layers[layer][i].Transparency = nowHidden and 1 or alphas[layer];
					end;
				end;
			end;

			if not isHidden then
				local cf = source.CFrame;

				if cfs[i] ~= cf then
					cfs[i] = cf;

					for layer = 1, layerCount do
						layers[layer][i].CFrame = cf;
					end;
				end;
			end;
		end;
	end;

	ESP.Chromatic = {
		Apply = applyChromatic,
		Render = renderChromatic,
		Clear = clearChromatic,
		Tick = function() frameId = frameId + 1 end,
		States = chrom,
	};

	local function items(player, char, enable)

		local now = os.clock();

		if itemClock[player] and now - itemClock[player] < 0.15 then
			if enable and CHROMATIC_PRESETS[S.ItemStyle] and char then
				local held = char:FindFirstChildWhichIsA("Tool");
				if held then renderChromatic(held) end;
			end;

			return;
		end;

		itemClock[player] = now;

		local tool = enable and char and char:FindFirstChildWhichIsA("Tool") or nil;
		local hl = itemHighlights[player];

		if itemHeld[player] and itemHeld[player] ~= tool then
			clearChromatic(itemHeld[player]);
			if itemHeld[player].Parent then restore(itemHeld[player]) end;
			itemHeld[player] = nil;
		end;

		if not tool then
			if hl then hl.Enabled = false end;
			return;
		end;

		if not hl then
			hl = Instance.new("Highlight");
			hl.Name = NeverLose.RandomString();
			hl.Parent = NeverLose.ScreenGui;
			itemHighlights[player] = hl;
		end;

		local material = MATERIAL_STYLES[S.ItemStyle];

		hl.Adornee = tool;
		hl.Enabled = true;
		hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
		hl.FillColor = S.ItemColor;
		hl.OutlineColor = S.ItemColor;

		hl.FillTransparency = material and 1 or 0.5;
		hl.OutlineTransparency = 1;

		itemHeld[player] = tool;

		if CHROMATIC_PRESETS[S.ItemStyle] then
			applyChromatic(tool, tool, S.ItemColor, S.ItemStyle);
			renderChromatic(tool);
		else
			clearChromatic(tool);
			paint(tool, material and S.ItemStyle or nil, S.ItemColor);
		end;
	end;

	local occl = {};

	clearOcclusion = function(player)
		local state = occl[player];
		if not state then return end;

		if state.Model then state.Model:Destroy() end;
		if state.Los then state.Los:Destroy() end;
		if state.Occ then state.Occ:Destroy() end;

		occl[player] = nil;
	end;

	local function applyOcclusion(player, char)
		if not (char and char:IsDescendantOf(workspace)) then
			clearOcclusion(player);
			return;
		end;

		local state = occl[player];

		if not state or state.Char ~= char or not state.Model or not state.Model.Parent then
			clearOcclusion(player);

			local model = Instance.new("Model");
			model.Name = "ChamsClone";

			for _, child in ipairs(char:GetDescendants()) do
				local cloned = (isCP(child) and not isDeformable(child)) and tryClone(child) or nil;

				if cloned then
					cloned:ClearAllChildren();
					cloned.Anchored = false;
					cloned.CanCollide = false;
					cloned.CanQuery = false;
					cloned.CanTouch = false;
					cloned.Massless = true;
					cloned.CastShadow = false;
					cloned.LocalTransparencyModifier = 0;

					if cloned:IsA("MeshPart") then pcall(function() cloned.TextureID = "" end) end;

					cloned.Size = cloned.Size * 0.99;
					cloned.CFrame = child.CFrame;
					cloned.Parent = model;

					local weld = Instance.new("WeldConstraint");
					weld.Part0 = cloned;
					weld.Part1 = child;
					weld.Parent = cloned;
				end;
			end;

			model.Parent = workspace;

			local los = Instance.new("Highlight");
			los.DepthMode = Enum.HighlightDepthMode.Occluded;
			los.OutlineTransparency = 1;
			los.Adornee = char;
			los.Parent = NeverLose.ScreenGui;

			local occ = Instance.new("Highlight");
			occ.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
			occ.OutlineTransparency = 1;
			occ.Adornee = model;
			occ.Parent = NeverLose.ScreenGui;

			state = { Model = model, Los = los, Occ = occ, Char = char };
			occl[player] = state;
		end;

		state.Los.FillColor = S.MatVisColor;
		state.Los.FillTransparency = S.MatVisT / 100;
		state.Occ.FillColor = S.MatOccColor;
		state.Occ.FillTransparency = S.MatOccT / 100;
	end;

	ESP.ClearOcclusion = clearOcclusion;

	for _, leftover in ipairs(workspace:GetChildren()) do
		if leftover.Name == "ChamsClone" and leftover:IsA("Model") then
			leftover:Destroy();
		end;
	end;

	do
		local host = NeverLose.ScreenGui.Parent;

		if host then
			for _, gui in ipairs(host:GetChildren()) do
				if gui ~= chromGui and gui:IsA("ScreenGui") then
					for _, child in ipairs(gui:GetChildren()) do
						if child:IsA("ViewportFrame") and string.match(child.Name, "^ChromaticLayer") then
							gui:Destroy();
							break;
						end;
					end;
				end;
			end;
		end;
	end;

	local function dropMaterials(player)
		if painted[player] then
			if painted[player].Parent then restore(painted[player]) end;
			painted[player], applied[player] = nil, nil;
		end;
	end;

	local function chams(player, char, enable)
		local hl = highlights[player];

		if not enable then
			if hl then hl.Enabled = false end;
			return;
		end;

		if not hl then
			hl = Instance.new("Highlight");
			hl.Name = NeverLose.RandomString();
			hl.Parent = NeverLose.ScreenGui;
			highlights[player] = hl;
		end;

		hl.Adornee = char;
		hl.Enabled = true;

		hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
		hl.FillColor = S.ChamsFill;
		hl.FillTransparency = S.ChamsFillT / 100;
		hl.OutlineColor = S.ChamsOutline;
		hl.OutlineTransparency = S.ChamsOutlineT / 100;
	end;

	local function matChams(player, char, enable)
		if not enable then
			clearChromatic(player);
			clearOcclusion(player);
			dropMaterials(player);
			matClock[player] = nil;
			seenChar[player] = nil;

			return;
		end;

		if painted[player] == char then
			local data = ESP.PaintCache and ESP.PaintCache(char);
			local stale = false;

			if data then
				local seen = 0;

				for part, orig in pairs(data.parts) do
					if part.Parent then
						seen = seen + 1;

						if orig.Wanted and part.Material ~= orig.Wanted then stale = true; break end;
					end;
				end;

				if not stale then
					local live = 0;

					for _, d in ipairs(char:GetDescendants()) do
						if d:IsA("BasePart") then live = live + 1 end;
					end;

					if live ~= seen then stale = true end;
				end;
			end;

			if stale then applied[player] = nil end;
		end;

		if charChanged(player, char) then
			matClock[player] = nil;
			itemClock[player] = nil;

			clearChromatic(player);
			clearOcclusion(player);
			dropMaterials(player);
		end;

		if S.MatType == "Chromatic" then
			local now = os.clock();

			if not matClock[player] or now - matClock[player] >= 0.15 then
				matClock[player] = now;

				clearOcclusion(player);
				dropMaterials(player);
				applyChromatic(player, char, S.MatColor, S.MatStyle);
			end;

			renderChromatic(player);

			return;
		end;

		local now = os.clock();
		if matClock[player] and now - matClock[player] < 0.15 then return end;
		matClock[player] = now;

		clearChromatic(player);

		if S.MatType == "Texture" then

			clearOcclusion(player);

			if painted[player] ~= char then
				if painted[player] and painted[player].Parent then restore(painted[player]) end;
				painted[player], applied[player] = char, nil;
			end;

			if applied[player] ~= revision then
				paint(char, {
					material = nil,
					reflectance = 0,
					transparency = 0,
					tint = true,
					keepTexture = true,
				}, S.MatColor);

				applied[player] = revision;
			end;

			return;
		end;

		if S.MatType == "Flat" then
			dropMaterials(player);
			applyOcclusion(player, char);

			return;
		end;

		clearOcclusion(player);

		if painted[player] ~= char then
			if painted[player] and painted[player].Parent then restore(painted[player]) end;
			painted[player], applied[player] = char, nil;
		end;

		if applied[player] ~= revision then

			local base = ESP.MaterialStyles[S.MatMaterial] or ESP.MaterialStyles.ForceField;

			paint(char, {
				material = base.material,
				reflectance = base.reflectance,
				transparency = math.clamp(S.MatTransparency or 0, 0, 1),
				tint = base.tint,
				keepTexture = base.keepTexture,
			}, S.MatColor);

			applied[player] = revision;
		end;
	end;

	local chamsBloom;

	function ESP.UpdateChamsBloom()
		local want = S.MatChams and (S.MatBloom or 0) > 0;

		if chamsBloom and chamsBloom.Parent == nil then chamsBloom = nil end;

		if want and not chamsBloom then
			chamsBloom = Instance.new("BloomEffect");
			chamsBloom.Name = NeverLose.RandomString();
			chamsBloom.Parent = game:GetService("Lighting");
		end;

		if not chamsBloom then return end;

		chamsBloom.Enabled = want and ALIVE or false;

		if want then
			chamsBloom.Intensity = S.MatBloom;
			chamsBloom.Size = 24;
			chamsBloom.Threshold = 0.9;
		end;
	end;

	task.spawn(function()
		while ALIVE do
			task.wait(1);

			if not ALIVE then break end;

			if chamsBloom and chamsBloom.Parent == nil then pcall(ESP.UpdateChamsBloom) end;
		end;
	end);

	onUnload("chams bloom", function()
		if chamsBloom then pcall(function() chamsBloom:Destroy() end); chamsBloom = nil end;
	end);

	local loopFailures = 0;
	local loopResume = 0;

	NeverLose:AddSignal(RunService.RenderStepped:Connect(function()

		if not NeverLose.ScreenGui.Parent then return end;
		Camera = workspace.CurrentCamera;
		if not Camera then return end;
		if loopFailures > 30 then
			if os.clock() < loopResume then return end;

			loopFailures = 0;
		end;

		local ok, err = pcall(function()

		frameId = frameId + 1;

		for _, player in ipairs(Players:GetPlayers()) do
			local isSelf = player == LocalPlayer;
			local char = player.Character;
			local root = char and char:FindFirstChild("HumanoidRootPart");
			local human = char and char:FindFirstChildWhichIsA("Humanoid");
			local alive = root and human and human.Health > 0;

			chams(player, char, S.Chams and alive and inTarget(S.ChamsTarget, isSelf));
			matChams(player, char, S.MatChams and alive and inTarget(S.ChamsTarget, isSelf));
			items(player, char, S.ItemChams and alive and inTarget(S.ItemTarget, isSelf));

			local b = bundleOf(player);
			local draw = S.Enabled and alive and inTarget(S.Target, isSelf);
			local at, size, corners;

			if draw and (S.Box or S.Tracer or S.Name) then
				at, size, corners = screenBox(char);
			end;

			if not draw then b.arrow.Visible = false end;

			if draw and S.Skeleton then
				drawSkeleton(b, char);
			else
				hideSkeleton(b);
			end;

			if draw and S.Arrows and root and not isSelf then
				local point = Camera:WorldToViewportPoint(root.Position);
				local onScreen = point.Z > 0
					and point.X >= 0 and point.X <= Camera.ViewportSize.X
					and point.Y >= 0 and point.Y <= Camera.ViewportSize.Y;

				if onScreen then
					b.arrow.Visible = false;
				else
					drawArrow(b, root);
				end;
			else
				b.arrow.Visible = false;
			end;

			if draw and S.Box and at then
				drawBox(b, at, size, corners);
			else
				hideBox(b);
			end;

			if draw and S.Name and at then

				local dist = (S.Distance and root)
					and math.round((root.Position - Camera.CFrame.Position).Magnitude) or nil;

				if b.nameDist ~= dist or b.nameFor ~= player.DisplayName then
					b.nameDist, b.nameFor = dist, player.DisplayName;

					b.name.Text = dist and (player.DisplayName .. "  " .. dist .. "m") or player.DisplayName;
				end;

				b.name.Color = S.NameColor;
				b.name.Position = Vector2.new(at.X + size.X / 2, at.Y - 16);
				b.name.Visible = true;
			else
				b.name.Visible = false;
			end;

			if draw and S.Tracer and at then
				local origin =
					(S.TracerFrom == "Top" and Vector2.new(Camera.ViewportSize.X / 2, 0))
					or (S.TracerFrom == "Center" and Camera.ViewportSize / 2)
					or Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y);

				b.tracer.Color = S.TracerColor;
				b.tracer.Thickness = S.TracerThickness;
				b.tracer.From = origin;
				b.tracer.To = Vector2.new(at.X + size.X / 2, at.Y + size.Y);
				b.tracer.Visible = true;
			else
				b.tracer.Visible = false;
			end;
		end;

		end);

		if ok then
			loopFailures = 0;
		else
			loopFailures = loopFailures + 1;
			loopResume = os.clock() + 2;

			if loopFailures == 1 then
				ERRORS[#ERRORS + 1] = "render: " .. tostring(err);

				warn("[visuals] render loop: " .. tostring(err));
			end;
		end;
	end));

	NeverLose:AddSignal(Players.PlayerRemoving:Connect(drop));

	ESP.Clear = function()
		for player in pairs(bundles) do drop(player) end;
		for player in pairs(highlights) do drop(player) end;
	end;
end;

Sections.ESP:AddLabel("Enabled"):AddToggle({
	Default = false, Flag = "esp",
	Callback = function(v) S.Enabled = v end,
});

Sections.ESP:AddLabel("Target"):AddDropdown({
	Default = "Other",
	Values = { "Other", "Self", "All" },
	Flag = "esp_target",
	Callback = function(v) S.Target = v end,
});

local espName = Sections.ESP:AddLabel("Name");
espName:AddToggle({ Default = false, Flag = "esp_name", Callback = function(v) S.Name = v end });
espName:AddColorPicker({ Default = S.NameColor, Flag = "esp_name_color", Callback = function(v) S.NameColor = v end });

Sections.ESP:AddLabel("Distance"):AddToggle({
	Default = false, Flag = "esp_distance",
	Callback = function(v) S.Distance = v end,
});

local espBox = Sections.ESP:AddLabel("Box");
espBox:AddToggle({ Default = false, Flag = "esp_box", Callback = function(v) S.Box = v end });
espBox:AddColorPicker({ Default = S.BoxColor, Flag = "esp_box_color", Callback = function(v) S.BoxColor = v end });

local boxOptions = espBox:AddOption(1);

boxOptions:AddLabel("Style"):AddDropdown({
	Default = "Full",
	Values = { "Full", "Corner", "Bracket", "3D" },
	Flag = "esp_box_style",
	Callback = function(v) S.BoxStyle = v end,
});

boxOptions:AddLabel("Thickness"):AddSlider({
	Min = 1, Max = 5, Default = 1, Rounding = 0, Size = 90,
	Flag = "esp_box_thickness",
	Callback = function(v) S.BoxThickness = v end,
});

local boxFill = boxOptions:AddLabel("Filled");
boxFill:AddToggle({ Default = false, Flag = "esp_box_filled", Callback = function(v) S.BoxFilled = v end });
boxFill:AddSlider({
	Min = 0, Max = 100, Default = 20, Type = "%", Size = 80,
	Flag = "esp_box_fill_opacity",
	Callback = function(v) S.BoxFillOpacity = v end,
});

local espSkeleton = Sections.ESP:AddLabel("Skeleton");
espSkeleton:AddToggle({ Default = false, Flag = "esp_skeleton", Callback = function(v) S.Skeleton = v end });
espSkeleton:AddColorPicker({ Default = S.SkeletonColor, Flag = "esp_skeleton_color", Callback = function(v) S.SkeletonColor = v end });

local espArrows = Sections.ESP:AddLabel("Off-screen Arrows");
espArrows:AddToggle({ Default = false, Flag = "esp_arrows", Callback = function(v) S.Arrows = v end });
espArrows:AddColorPicker({ Default = S.ArrowColor, Flag = "esp_arrow_color", Callback = function(v) S.ArrowColor = v end });

local arrowOptions = espArrows:AddOption(1);

arrowOptions:AddLabel("Size"):AddSlider({
	Min = 8, Max = 80, Default = 22, Rounding = 0, Size = 90,
	Flag = "esp_arrow_size",
	Callback = function(v) S.ArrowSize = v end,
});

arrowOptions:AddLabel("Rotation"):AddSlider({
	Min = 0, Max = 359, Default = 0, Rounding = 0, Size = 90, Type = "°",
	Flag = "esp_arrow_turn",
	Callback = function(v) S.ArrowTurn = v end,
});

arrowOptions:AddLabel("Skin"):AddDropdown({
	Default = "Triangle",
	Values = { "Triangle", "Triangle 2", "Arrows", "Arrows 2", "Arrow 3", "White" },
	Flag = "esp_arrow_skin",
	Callback = function(v) S.ArrowImage = v end,
});

arrowOptions:AddLabel("Radius"):AddSlider({
	Min = 60, Max = 500, Default = 180, Rounding = 0, Size = 90,
	Flag = "esp_arrow_radius",
	Callback = function(v) S.ArrowRadius = v end,
});

local espTracer = Sections.ESP:AddLabel("Tracer");
espTracer:AddToggle({ Default = false, Flag = "esp_tracer", Callback = function(v) S.Tracer = v end });
espTracer:AddColorPicker({ Default = S.TracerColor, Flag = "esp_tracer_color", Callback = function(v) S.TracerColor = v end });
local tracerOptions = espTracer:AddOption(1);

tracerOptions:AddLabel("From"):AddDropdown({
	Default = "Bottom",
	Values = { "Bottom", "Center", "Top" },
	Flag = "esp_tracer_from",
	Callback = function(v) S.TracerFrom = v end,
});

tracerOptions:AddLabel("Thickness"):AddSlider({
	Min = 1, Max = 6, Default = 1, Rounding = 0, Size = 90,
	Flag = "esp_tracer_thickness",
	Callback = function(v) S.TracerThickness = v end,
});

local Preview = {};

guard("gunchams", function()
	local G = {
		On = false,
		Outline = Color3.fromRGB(255, 190, 60),
		Fill = 0.75,
		Aura = true,
		AuraColor = Color3.fromRGB(255, 150, 40),
		Text = true,
		TextColor = Color3.fromRGB(255, 220, 140),
	};

	ESP.GunChams = G;

	local candidates, live = {}, {};
	local host = Render.gui("gunchams", -6);
	local shells = Instance.new("Folder");

	shells.Name = NeverLose.RandomString();
	shells.Parent = workspace.CurrentCamera;

	local conns = {};
	local sweep = 0;

	local function anchorPart(object)
		if object:IsA("BasePart") then return object end;
		if object:IsA("Model") then return object.PrimaryPart or object:FindFirstChildWhichIsA("BasePart", true) end;

		return object:FindFirstChild("Handle") or object:FindFirstChildWhichIsA("BasePart", true);
	end;

	local function ours(object)
		for _, player in ipairs(Players:GetPlayers()) do
			if player.Character and object:IsDescendantOf(player.Character) then return true end;
		end;

		return false;
	end;

	local function watch(object)
		if object.Name ~= "GunDrop" then return end;
		if object:IsA("BasePart") or object:IsA("Model") or object:IsA("Tool") then
			candidates[object] = true;
		end;
	end;

	local function forget(object)
		if object.Name == "GunDrop" then candidates[object] = nil end;
	end;

	local function seed()
		table.clear(candidates);

		for _, object in ipairs(workspace:GetDescendants()) do watch(object) end;
	end;

	local function drop(object)
		local entry = live[object];

		if not entry then return end;

		live[object] = nil;

		if entry.glow then pcall(function() entry.glow:Destroy() end) end;
		if entry.shell then pcall(function() entry.shell:Destroy() end) end;

		destroyAny(entry.label);
	end;

	local function clearAll()
		for object in pairs(live) do drop(object) end;
	end;

	local function makeShell(part)
		local archivable = part.Archivable;

		if not archivable and not pcall(function() part.Archivable = true end) then return nil end;

		local ok, clone = pcall(part.Clone, part);

		if not archivable then pcall(function() part.Archivable = archivable end) end;
		if not ok or not clone then return nil end;

		for _, child in ipairs(clone:GetChildren()) do
			if not child:IsA("DataModelMesh") then child:Destroy() end;
		end;

		local mesh = clone:FindFirstChildWhichIsA("DataModelMesh");

		if mesh then
			pcall(function() mesh.Scale = mesh.Scale * 1.08 end);
			pcall(function() mesh.TextureId = "" end);
		else
			clone.Size = clone.Size * 1.08;
		end;

		pcall(function() clone.TextureID = "" end);
		clone.Anchored = true;
		clone.CanCollide = false;
		clone.CanQuery = false;
		clone.CanTouch = false;
		clone.CastShadow = false;
		clone.Massless = true;

		return clone;
	end;

	local function found()
		local list = {};

		for object in pairs(candidates) do
			if object.Name == "GunDrop" and object.Parent and not ours(object) then
				local part = anchorPart(object);

				if part then
					list[#list + 1] = {
						object = object,
						part = part,
						adorn = (object:IsA("BasePart") or object:IsA("Model")) and object or part,
					};
				end;
			end;
		end;

		return list;
	end;

	local guns = {};

	local function step(dt)
		if not (ALIVE and G.On) then
			if next(live) then clearAll() end;

			return;
		end;

		sweep = sweep + dt;

		if sweep >= 0.25 then
			sweep = 0;
			guns = found();

			local seen = {};

			for _, entry in ipairs(guns) do seen[entry.object] = true end;
			for object in pairs(live) do
				if not seen[object] then drop(object) end;
			end;
		end;

		local camera = Render.camera();

		if not camera then return end;

		for _, entry in ipairs(guns) do
			local object, part = entry.object, entry.part;

			if not (object.Parent and part and part.Parent) then
				drop(object);
			else
				local record = live[object];

				if not record then record = {}; live[object] = record end;

				if not record.glow then
					local glow = Instance.new("Highlight");

					glow.DepthMode = Enum.HighlightDepthMode.Occluded;
					glow.Parent = host;

					record.glow = glow;
				end;

				record.glow.Adornee = entry.adorn;
				record.glow.OutlineColor = G.Outline;
				record.glow.OutlineTransparency = 0;
				record.glow.FillColor = G.Outline;
				record.glow.FillTransparency = math.clamp(G.Fill, 0, 1);
				record.glow.Enabled = true;

				if G.Aura then
					if not record.shell or not record.shell.Parent then
						record.shell = makeShell(part);

						if record.shell then record.shell.Parent = shells end;
					end;

					if record.shell then

						record.shell.CFrame = part.CFrame;
						record.shell.Color = G.AuraColor;
						record.shell.Material = Enum.Material.ForceField;
						record.shell.Reflectance = 0;
						record.shell.Transparency = 0.25;
						record.shell.LocalTransparencyModifier = 0;
					end;
				elseif record.shell then
					record.shell:Destroy();
					record.shell = nil;
				end;

				if G.Text then
					if not record.label then
						local text = Drawing.new("Text");

						text.Center = true;
						text.Outline = true;
						text.Size = 13;
						text.Font = 2;

						record.label = text;
					end;

					local at, onScreen = camera:WorldToViewportPoint(part.Position);

					if onScreen and at.Z > 0 then
						record.label.Text = "Gun";
						record.label.Color = G.TextColor;
						record.label.Position = Vector2.new(at.X, at.Y);
						record.label.Visible = true;
					else
						record.label.Visible = false;
					end;
				elseif record.label then
					record.label.Visible = false;
				end;
			end;
		end;
	end;

	local function start()
		if conns[1] then return end;

		seed();

		sweep = 0.25;

		conns[#conns + 1] = workspace.DescendantAdded:Connect(watch);
		conns[#conns + 1] = workspace.DescendantRemoving:Connect(forget);
	end;

	local function stop()
		for _, conn in ipairs(conns) do pcall(function() conn:Disconnect() end) end;

		table.clear(conns);
		table.clear(candidates);

		guns = {};

		clearAll();
	end;

	NeverLose:AddSignal(RunService.RenderStepped:Connect(step));

	local row = Sections.Guns:AddLabel("Dropped Gun");

	row:AddToggle({
		Name = "Dropped Gun",
		Default = false,
		Flag = "gun_chams",
		Callback = function(v)
			G.On = v;

			if v then start() else stop() end;
		end,
	});

	row:AddColorPicker({
		Default = G.Outline,
		Flag = "gun_chams_color",
		Callback = function(v) G.Outline = v end,
	});

	Sections.Guns:AddLabel("Fill"):AddSlider({
		Min = 0, Max = 100, Default = 75, Rounding = 0, Size = 100, Type = "%",
		Flag = "gun_chams_fill",
		Callback = function(v) G.Fill = v / 100 end,
	});

	local auraRow = Sections.Guns:AddLabel("Aura");

	auraRow:AddToggle({
		Name = "Aura",
		Default = true,
		Flag = "gun_chams_aura",
		Callback = function(v) G.Aura = v end,
	});

	auraRow:AddColorPicker({
		Default = G.AuraColor,
		Flag = "gun_chams_aura_color",
		Callback = function(v) G.AuraColor = v end,
	});

	local textRow = Sections.Guns:AddLabel("Label");

	textRow:AddToggle({
		Name = "Label",
		Default = true,
		Flag = "gun_chams_text",
		Callback = function(v) G.Text = v end,
	});

	textRow:AddColorPicker({
		Default = G.TextColor,
		Flag = "gun_chams_text_color",
		Callback = function(v) G.TextColor = v end,
	});

	ESP.ClearGunChams = onUnload("gunchams", function()
		G.On = false;

		stop();

		pcall(function() shells:Destroy() end);
	end);
end);

guard("preview", function()
	local UserInputService = game:GetService("UserInputService");

	local WindowFrame;

	local function windowFrame()
		if WindowFrame and WindowFrame.Parent then return WindowFrame end;

		if NeverLose.WindowFrame and NeverLose.WindowFrame.Parent then
			WindowFrame = NeverLose.WindowFrame;

			return WindowFrame;
		end;

		for _, child in ipairs(NeverLose.ScreenGui:GetChildren()) do
			if child:IsA("Frame") and child.Active and child.AnchorPoint == Vector2.new(0.5, 0.5) then
				WindowFrame = child;
			end;
		end;

		return WindowFrame;
	end;

	ESP.WindowFrame = windowFrame;

	local panel = Instance.new("Frame");
	panel.Name = NeverLose.RandomString();
	panel.Parent = NeverLose.ScreenGui;
	panel.BackgroundColor3 = Color3.fromRGB(8, 8, 13);
	panel.BackgroundTransparency = (NeverLose.EnabledBlur and 0.055) or 0.0255;
	panel.BorderSizePixel = 0;
	panel.ClipsDescendants = true;

	panel.Visible = not NeverLose.Mobile;
	panel.ZIndex = 1;

	local shadow = NeverLose:CreateShadow(panel);

	local corner = Instance.new("UICorner", panel);
	corner.CornerRadius = UDim.new(0, 8);

	NeverLose:CreateBlurModule(panel, Window.Signal);

	local header = Instance.new("Frame");
	header.Name = NeverLose.RandomString();
	header.Parent = panel;
	header.BackgroundTransparency = 1;
	header.Size = UDim2.new(1, 0, 0, 30);
	header.ZIndex = panel.ZIndex + 2;

	local hIcon = Instance.new("TextLabel");
	hIcon.Parent = header;
	hIcon.AnchorPoint = Vector2.new(0, 0.5);
	hIcon.BackgroundTransparency = 1;
	hIcon.Position = UDim2.new(0, 8, 0.5, 0);
	hIcon.Size = UDim2.fromOffset(20, 20);
	hIcon.ZIndex = header.ZIndex;
	NeverLose.ApplyIcon(hIcon, "person");
	hIcon.TextColor3 = NeverLose.AccentColor;
	hIcon.TextSize = 14;

	local hName = Instance.new("TextLabel");
	hName.Parent = header;
	hName.AnchorPoint = Vector2.new(0, 0.5);
	hName.BackgroundTransparency = 1;
	hName.Position = UDim2.new(0, 30, 0.5, 0);
	hName.Size = UDim2.new(1, -38, 0, 14);
	hName.ZIndex = header.ZIndex;
	hName.Font = Enum.Font.GothamBold;
	hName.Text = LocalPlayer.DisplayName;
	hName.TextColor3 = Color3.fromRGB(255, 255, 255);
	hName.TextSize = 12;
	hName.TextTransparency = 0.1;
	hName.TextXAlignment = Enum.TextXAlignment.Left;

	local line = Instance.new("Frame");
	line.Parent = panel;
	line.BackgroundColor3 = Color3.fromRGB(45, 48, 58);
	line.BackgroundTransparency = 0.5;
	line.BorderSizePixel = 0;
	line.Position = UDim2.new(0, 8, 0, 30);
	line.Size = UDim2.new(1, -16, 0, 1);
	line.ZIndex = panel.ZIndex + 2;

	local hint = Instance.new("TextLabel");
	hint.Parent = panel;
	hint.AnchorPoint = Vector2.new(0.5, 1);
	hint.BackgroundTransparency = 1;
	hint.Position = UDim2.new(0.5, 0, 1, -6);
	hint.Size = UDim2.new(1, -16, 0, 12);
	hint.ZIndex = panel.ZIndex + 2;
	hint.Font = Enum.Font.Gotham;
	hint.Text = "@" .. LocalPlayer.Name .. "  ·  drag to turn  ·  scroll to zoom";
	hint.TextColor3 = Color3.fromRGB(255, 255, 255);
	hint.TextSize = 10;
	hint.TextTransparency = 0.65;

	local stage = Instance.new("Frame");
	stage.Name = NeverLose.RandomString();
	stage.Parent = panel;
	stage.Position = UDim2.new(0, 0, 0, 31);
	stage.Size = UDim2.new(1, 0, 1, -51);
	stage.BackgroundColor3 = NeverLose.Lib.theme.panel;
	stage.BorderSizePixel = 0;
	stage.ClipsDescendants = true;
	stage.ZIndex = panel.ZIndex;

	local stageTint = Instance.new("UIGradient", stage);
	stageTint.Rotation = 90;
	stageTint.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 178, 190)),
	});

	local floorLine = Instance.new("Frame");
	floorLine.Name = NeverLose.RandomString();
	floorLine.Parent = stage;
	floorLine.AnchorPoint = Vector2.new(0.5, 0.5);
	floorLine.Position = UDim2.fromScale(0.5, 0.855);
	floorLine.Size = UDim2.new(1, -20, 0, 2);
	floorLine.BackgroundColor3 = NeverLose.AccentColor;
	floorLine.BackgroundTransparency = 0.45;
	floorLine.BorderSizePixel = 0;
	floorLine.ZIndex = stage.ZIndex + 1;

	local floorFade = Instance.new("UIGradient", floorLine);
	floorFade.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.12, 0.2),
		NumberSequenceKeypoint.new(0.5, 0),
		NumberSequenceKeypoint.new(0.88, 0.2),
		NumberSequenceKeypoint.new(1, 1),
	});

	local pad = Instance.new("Frame");
	pad.Name = NeverLose.RandomString();
	pad.Parent = stage;
	pad.AnchorPoint = Vector2.new(0.5, 0.5);
	pad.Position = UDim2.fromScale(0.5, 0.855);
	pad.Size = UDim2.new(0.42, 0, 0, 9);
	pad.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
	pad.BackgroundTransparency = 0.5;
	pad.BorderSizePixel = 0;
	pad.ZIndex = stage.ZIndex + 1;
	Instance.new("UICorner", pad).CornerRadius = UDim.new(1, 0);

	local padFade = Instance.new("UIGradient", pad);
	padFade.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.5, 0),
		NumberSequenceKeypoint.new(1, 1),
	});

	local view = Instance.new("ViewportFrame");
	view.Name = NeverLose.RandomString();
	view.Parent = panel;
	view.Position = UDim2.new(0, 0, 0, 31);
	view.Size = UDim2.new(1, 0, 1, -51);
	view.BackgroundTransparency = 1;
	view.BorderSizePixel = 0;
	view.ZIndex = stage.ZIndex + 5;

	view.Ambient = Color3.fromRGB(255, 255, 255);
	view.LightColor = Color3.fromRGB(255, 252, 245);
	view.LightDirection = Vector3.new(-0.35, -0.8, -0.6);

	local camera = Instance.new("Camera");
	camera.FieldOfView = 35;
	camera.Parent = view;
	view.CurrentCamera = camera;

	local model, yaw = nil, 0;
	local auraClone;

	local zoom = 1;

	local function aim()
		if not model then return end;

		local pivot, size = model:GetBoundingBox();

		local half = math.tan(math.rad(camera.FieldOfView / 2));
		local aspect = math.max(view.AbsoluteSize.X, 1) / math.max(view.AbsoluteSize.Y, 1);
		local dist = math.max(size.Y / 2 / half, size.X / 2 / (half * aspect)) * 1.15 * zoom;

		camera.CFrame = CFrame.new(pivot.Position + (CFrame.Angles(0, yaw, 0) * Vector3.new(0, 0, dist)), pivot.Position);

		local look = CFrame.Angles(0, yaw - 0.6, 0) * Vector3.new(0, 0, -1);

		view.LightDirection = Vector3.new(look.X, -0.8, look.Z);
	end;

	local function place()
		local wf = windowFrame();
		local camera = workspace.CurrentCamera;

		local size = (wf and wf.AbsoluteSize) or Vector2.new(640, 480);
		local at = (wf and wf.AbsolutePosition)
			or Vector2.new(camera.ViewportSize.X / 2 - 320, camera.ViewportSize.Y / 2 - 240);
		local width = math.floor(size.Y * 0.46);
		local height = size.Y;
		local x = at.X + size.X + 8;

		if x + width > camera.ViewportSize.X then
			x = at.X - width - 8;
		end;

		local origin = panel.AbsolutePosition - Vector2.new(panel.Position.X.Offset, panel.Position.Y.Offset);

		panel.Size = UDim2.fromOffset(width, height);
		panel.Position = UDim2.fromOffset(x - origin.X, at.Y - origin.Y);

		aim();
	end;

	function Preview.Refresh()
		if model then
			model:Destroy();
			model = nil;
		end;

		local char = LocalPlayer.Character;
		if not char then return end;

		local originalArchivable = char.Archivable;
		local ok, clone = pcall(function()
			char.Archivable = true;
			return char:Clone();
		end);
		pcall(function() char.Archivable = originalArchivable end);

		if not ok or not clone then return end;

		for _, d in ipairs(clone:GetDescendants()) do

			if d:IsA("BaseScript") or d:IsA("Sound") or d:IsA("ParticleEmitter") or d:IsA("Fire") or d:IsA("Smoke") then
				d:Destroy();
			elseif d:IsA("BasePart") then
				d.Anchored = true;
				d.CanCollide = false;
			elseif d:IsA("Humanoid") then
				d.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
			end;
		end;

		clone.Parent = view;

		pcall(function()
			clone:PivotTo(CFrame.new(clone:GetPivot().Position) * CFrame.Angles(0, math.pi, 0));
		end);

		model = clone;

		Preview.DressAura();

		aim();

		if Preview.Paint then Preview.Paint() end;
	end;

	function Preview.DressAura()
		if auraClone then auraClone:Destroy(); auraClone = nil end;

		Preview.AuraShown = false;

		local A = ESP.Aura;

		if not (model and A and A.On) then return end;
		if not (A.Target == "Self" or A.Target == "All") then return end;
		if not ESP.AuraSource then return end;

		local ok, source = pcall(ESP.AuraSource, A.Type);

		if not ok or not source then return end;

		local copied, dressed = pcall(source.Clone, source);

		if not copied or not dressed then return end;

		local shown = 0;

		for _, d in ipairs(dressed:GetDescendants()) do
			if d:IsA("BaseScript") or d:IsA("Sound") then
				d:Destroy();
			elseif d:IsA("BasePart") then
				d.Anchored = true;
				d.CanCollide = false;
				d.CanQuery = false;
				d.CanTouch = false;
				d.CastShadow = false;

				if d.Transparency < 1 then
					shown = shown + 1;

					if A.Tint then d.Color = A.Color end;
				end;
			end;
		end;

		if shown == 0 then
			dressed:Destroy();

			return;
		end;

		Preview.AuraShown = true;

		dressed.Name = "AuraPreview";

		local pivot = model:GetPivot();

		pcall(function() dressed:PivotTo(pivot) end);

		dressed.Parent = view;
		auraClone = dressed;
	end;

	local aura = { sprites = {}, live = {}, specs = {}, carry = 0 };

	local function auraSlot()
		for _, slot in ipairs(aura.sprites) do
			if not slot.busy then return slot end;
		end;

		if #aura.sprites >= 90 then return nil end;

		local image = Instance.new("ImageLabel");
		image.Name = NeverLose.RandomString();
		image.BackgroundTransparency = 1;
		image.AnchorPoint = Vector2.new(0.5, 0.5);
		image.ScaleType = Enum.ScaleType.Fit;
		image.ZIndex = view.ZIndex + 1;
		image.Visible = false;
		image.Parent = panel;

		local slot = { image = image, busy = false };
		aura.sprites[#aura.sprites + 1] = slot;

		return slot;
	end;

	function Preview.ReadAura()
		table.clear(aura.specs);

		local A = ESP.Aura;

		if not (A and A.On and ESP.AuraSource) then return end;
		if not (A.Target == "Self" or A.Target == "All") then return end;

		local ok, source = pcall(ESP.AuraSource, A.Type);

		if not ok or not source then return end;

		for _, d in ipairs(source:GetDescendants()) do
			if d:IsA("ParticleEmitter") and #aura.specs < 8 then
				local color = Color3.new(1, 1, 1);

				pcall(function()
					local keys = d.Color.Keypoints;

					if keys and keys[1] then color = keys[1].Value end;
				end);

				local size = 0;

				pcall(function()
					for _, key in ipairs(d.Size.Keypoints) do size = math.max(size, key.Value) end;
				end);

				aura.specs[#aura.specs + 1] = {
					texture = d.Texture,
					color = color,
					size = math.clamp(size, 0.2, 6),
					life = math.clamp((d.Lifetime.Min + d.Lifetime.Max) / 2, 0.25, 3),
					speed = math.clamp((d.Speed.Min + d.Speed.Max) / 2, 0, 14),
					spread = math.clamp(math.max(d.SpreadAngle.X, d.SpreadAngle.Y), 5, 180),
					light = d.LightEmission,
					spin = (d.RotSpeed.Min + d.RotSpeed.Max) / 2,
					rise = -d.Acceleration.Y,
				};
			end;
		end;
	end;

	local function auraEmit()
		local spec = aura.specs[math.random(1, #aura.specs)];
		local slot = auraSlot();

		if not slot then return end;

		local box = panel.AbsoluteSize;
		local perStud = math.max(8, (box.Y - 50) / 7);

		local spread = math.max(1, math.floor(spec.spread + 0.5));
		local angle = math.rad(math.random(-spread, spread) - 90);
		local speed = spec.speed * perStud;

		local A = ESP.Aura;
		local color = (A and A.Tint) and A.Color or spec.color;

		slot.busy = true;
		slot.image.Image = spec.texture ~= "" and spec.texture or "rbxasset://textures/particles/sparkles_main.dds";
		slot.image.ImageColor3 = color:Lerp(Color3.new(1, 1, 1), math.clamp(spec.light * 0.35, 0, 0.6));
		slot.image.Visible = true;

		aura.live[#aura.live + 1] = {
			slot = slot,
			t = 0,
			life = spec.life,
			x = box.X / 2 + math.random(-22, 22),
			y = 34 + (box.Y - 44) * 0.56 + math.random(-40, 40),
			vx = math.cos(angle) * speed,
			vy = math.sin(angle) * speed,
			gravity = -spec.rise * perStud * 0.35,

			size = math.min(spec.size * perStud * 0.45, box.X * 0.30),
			spin = spec.spin,
		};
	end;

	function Preview.StepAura(dt)
		for index = #aura.live, 1, -1 do
			local p = aura.live[index];

			p.t = p.t + dt;

			if p.t >= p.life or not panel.Visible then
				p.slot.busy = false;
				p.slot.image.Visible = false;

				table.remove(aura.live, index);
			else
				local k = p.t / p.life;

				p.vy = p.vy + p.gravity * dt;
				p.x = p.x + p.vx * dt;
				p.y = p.y + p.vy * dt;

				local size = p.size * (0.55 + 0.75 * k);
				local image = p.slot.image;

				image.Position = UDim2.fromOffset(p.x, p.y);
				image.Size = UDim2.fromOffset(size, size);

				image.ImageTransparency = math.clamp(0.35 + k * k * 0.65, 0, 1);
				image.Rotation = p.spin * p.t;
			end;
		end;

		if #aura.specs == 0 or not panel.Visible then return end;

		local A = ESP.Aura;

		if not (A and A.On) then return end;

		aura.carry = math.min(aura.carry + dt, 0.4);

		while aura.carry >= 1 / 14 do
			aura.carry = aura.carry - 1 / 14;

			auraEmit();
		end;
	end;

	local dragging, lastX = false, 0;

	NeverLose:AddSignal(view.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1 and input.UserInputType ~= Enum.UserInputType.Touch then return end;

		dragging, lastX = true, input.Position.X;
	end));

	do
		local ContextActionService = game:GetService("ContextActionService");
		local SINK = "VisualsPreviewWheel";
		local bound = false;

		local function wheel(_, state, input)
			if state == Enum.UserInputState.Change and input.Position.Z ~= 0 then
				zoom = math.clamp(zoom - input.Position.Z * 0.12, 0.55, 2.2);

				aim();
			end;

			return Enum.ContextActionResult.Sink;
		end;

		local function grab()
			if bound then return end;

			bound = true;

			pcall(function()
				ContextActionService:BindActionAtPriority(
					SINK, wheel, false,
					Enum.ContextActionPriority.High.Value,
					Enum.UserInputType.MouseWheel
				);
			end);
		end;

		local function release()
			if not bound then return end;

			bound = false;

			pcall(function() ContextActionService:UnbindAction(SINK) end);
		end;

		NeverLose:AddSignal(view.MouseEnter:Connect(grab));
		NeverLose:AddSignal(view.MouseLeave:Connect(release));
		NeverLose:AddSignal(panel:GetPropertyChangedSignal("Visible"):Connect(function()
			if not panel.Visible then release() end;
		end));

		onUnload("preview wheel", release);
	end;

	NeverLose:AddSignal(UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end;
		if input.UserInputType ~= Enum.UserInputType.MouseMovement and input.UserInputType ~= Enum.UserInputType.Touch then return end;

		yaw = yaw - (input.Position.X - lastX) * 0.015;
		lastX = input.Position.X;

		aim();
	end));

	NeverLose:AddSignal(UserInputService.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false;
		end;
	end));

	NeverLose:AddSignal(LocalPlayer.CharacterAdded:Connect(function()
		task.wait(1);

		if not ALIVE then return end;

		Preview.Refresh();
	end));
	NeverLose:AddSignal(LocalPlayer.CharacterAppearanceLoaded:Connect(function()
		task.defer(function() if ALIVE then Preview.Refresh() end end);
	end));
	NeverLose:AddSignal(LocalPlayer.CharacterRemoving:Connect(function()
		if auraClone then auraClone:Destroy(); auraClone = nil end;
		if model then model:Destroy(); model=nil end;
	end));

	do
		local wf = windowFrame();

		if wf then
			NeverLose:AddSignal(wf:GetPropertyChangedSignal("AbsolutePosition"):Connect(place));
			NeverLose:AddSignal(wf:GetPropertyChangedSignal("AbsoluteSize"):Connect(place));
		else

			NeverLose:AddSignal(NeverLose.ScreenGui.ChildAdded:Connect(function()
				local found = windowFrame();

				if found and not found:GetAttribute("PreviewHooked") then
					found:SetAttribute("PreviewHooked", true);
					NeverLose:AddSignal(found:GetPropertyChangedSignal("AbsolutePosition"):Connect(place));
					NeverLose:AddSignal(found:GetPropertyChangedSignal("AbsoluteSize"):Connect(place));
				end;

				place();
			end));
		end;
	end;

	NeverLose:AddSignal(Window.Signal:Connect(function(open)
		open = open and not NeverLose.Mobile;

		panel.Visible = open;
		shadow:Render(open);

		if open then place() end;
	end));

	local overlay = Instance.new("Frame");
	overlay.Name = NeverLose.RandomString();
	overlay.Parent = panel;
	overlay.BackgroundTransparency = 1;
	overlay.ClipsDescendants = true;
	overlay.Position = view.Position;
	overlay.Size = view.Size;
	overlay.ZIndex = view.ZIndex + 1;

	local function newFrame(parent)
		local f = Instance.new("Frame");
		f.Parent = parent or overlay;
		f.BorderSizePixel = 0;
		f.BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		f.Visible = false;
		f.ZIndex = overlay.ZIndex;
		return f;
	end;

	local boxFill = newFrame();
	local boxEdge = newFrame();
	boxEdge.BackgroundTransparency = 1;

	local edgeStroke = Instance.new("UIStroke", boxEdge);
	local cornerBars = {};
	for i = 1, 8 do cornerBars[i] = newFrame() end;

	local tracerLine = newFrame();
	tracerLine.AnchorPoint = Vector2.new(0.5, 0.5);

	local function hideOverlay()
		boxFill.Visible = false;
		boxEdge.Visible = false;
		tracerLine.Visible = false;

		for _, bar in ipairs(cornerBars) do bar.Visible = false end;
	end;

	local function project(world)
		local rel = camera.CFrame:PointToObjectSpace(world);
		local depth = -rel.Z;

		if depth <= 0.05 then return nil end;

		local size = view.AbsoluteSize;
		local halfTan = math.tan(math.rad(camera.FieldOfView / 2));
		local aspect = math.max(size.X, 1) / math.max(size.Y, 1);

		return Vector2.new(
			size.X / 2 + (rel.X / (depth * halfTan * aspect)) * size.X / 2,
			size.Y / 2 - (rel.Y / (depth * halfTan)) * size.Y / 2);
	end;

	local function drawOverlay()
		local root = model and model:FindFirstChild("HumanoidRootPart");

		if not (root and S.Enabled and (S.Box or S.Tracer)) then
			hideOverlay();
			return;
		end;

		local human = model:FindFirstChildWhichIsA("Humanoid");
		local scale = (human and human.RigType == Enum.HumanoidRigType.R6) and 0.85 or 1;
		local cf = root.CFrame;

		local top = project((cf * CFrame.new(0, 3.1 * scale, 0)).Position);
		local foot = project((cf * CFrame.new(0, -3.4 * scale, 0)).Position);

		if not (top and foot) then
			hideOverlay();
			return;
		end;

		local height = math.abs(foot.Y - top.Y);
		local width = height * 0.42;
		local at = Vector2.new((top.X + foot.X) / 2 - width / 2, math.min(top.Y, foot.Y));

		if S.Box then
			boxFill.Visible = S.BoxFilled;
			boxFill.BackgroundColor3 = S.BoxColor;
			boxFill.BackgroundTransparency = 1 - S.BoxFillOpacity / 100;
			boxFill.Position = UDim2.fromOffset(at.X, at.Y);
			boxFill.Size = UDim2.fromOffset(width, height);

			if S.BoxStyle == "Corner" then
				boxEdge.Visible = false;

				local cut = math.min(width, height) * 0.28;
				local t = S.BoxThickness;
				local bars = {
					{ at.X, at.Y, cut, t }, { at.X, at.Y, t, cut },
					{ at.X + width - cut, at.Y, cut, t }, { at.X + width - t, at.Y, t, cut },
					{ at.X, at.Y + height - t, cut, t }, { at.X, at.Y + height - cut, t, cut },
					{ at.X + width - cut, at.Y + height - t, cut, t }, { at.X + width - t, at.Y + height - cut, t, cut },
				};

				for i, bar in ipairs(bars) do
					local f = cornerBars[i];
					f.Visible = true;
					f.BackgroundColor3 = S.BoxColor;
					f.BackgroundTransparency = 0;
					f.Position = UDim2.fromOffset(bar[1], bar[2]);
					f.Size = UDim2.fromOffset(bar[3], bar[4]);
				end;
			else
				for _, bar in ipairs(cornerBars) do bar.Visible = false end;

				boxEdge.Visible = true;
				boxEdge.Position = UDim2.fromOffset(at.X, at.Y);
				boxEdge.Size = UDim2.fromOffset(width, height);
				edgeStroke.Color = S.BoxColor;
				edgeStroke.Thickness = S.BoxThickness;

			end;
		else
			boxFill.Visible = false;
			boxEdge.Visible = false;

			for _, bar in ipairs(cornerBars) do bar.Visible = false end;
		end;

		if S.Tracer then
			local size = view.AbsoluteSize;
			local from =
				(S.TracerFrom == "Top" and Vector2.new(size.X / 2, 0))
				or (S.TracerFrom == "Center" and size / 2)
				or Vector2.new(size.X / 2, size.Y);
			local to = Vector2.new(at.X + width / 2, at.Y + height);
			local delta = to - from;

			tracerLine.Visible = true;
			tracerLine.BackgroundColor3 = S.TracerColor;
			tracerLine.BackgroundTransparency = 0;
			tracerLine.Position = UDim2.fromOffset((from.X + to.X) / 2, (from.Y + to.Y) / 2);
			tracerLine.Size = UDim2.fromOffset(delta.Magnitude, 1);
			tracerLine.Rotation = math.deg(math.atan2(delta.Y, delta.X));
		else
			tracerLine.Visible = false;
		end;
	end;

	Preview.Draw = drawOverlay;

	local dirty = false;

	function Preview.Queue() dirty = true end;

	NeverLose:AddSignal(RunService.RenderStepped:Connect(function(dt)
		if dirty then
			dirty = false;

			if ALIVE then pcall(Preview.Refresh) end;
		end;

		if panel.Visible then
			floorLine.BackgroundColor3 = NeverLose.AccentColor;

			drawOverlay();
		end;

		Preview.StepAura(dt);
	end));

	Preview.Panel = panel;
	Preview.Viewport = view;
	Preview.Model = function() return model end;

	Preview.Refresh();
	place();
	shadow:Render(true);

	ESP.Preview = Preview;

	onUnload("preview", function()
		if auraClone then pcall(function() auraClone:Destroy() end) end;
		if model then pcall(function() model:Destroy() end) end;
		if panel then pcall(function() panel:Destroy() end) end;
	end);
end);

local function paintPreview()
	local model = Preview and Preview.Model and Preview.Model();
	if not model then return end;

	if S.MatChams and S.MatType == "Chromatic" then

		local preset = ESP.ChromaticPresets[S.MatStyle] or ESP.ChromaticPresets.Chromatic;
		local top = preset[#preset];

		ESP.Paint(model, {
			material = top.Material,
			reflectance = top.Reflectance,
			transparency = 0,
			tint = true,
		}, ESP.ChromaticColor(S.MatColor, top, S.MatColor2, S.MatChroma));
	elseif S.MatChams then

		local base = ESP.MaterialStyles[S.MatMaterial] or ESP.MaterialStyles.ForceField;

		ESP.Paint(model, {
			material = base.material,
			reflectance = base.reflectance,
			transparency = math.clamp(S.MatTransparency or 0, 0, 1),
			tint = base.tint,
			keepTexture = base.keepTexture,
		}, S.MatColor);
	elseif S.Chams and S.ChamsFillT < 100 then

		ESP.Paint(model, {
			material = Enum.Material.SmoothPlastic,
			reflectance = 0,
			transparency = S.ChamsFillT / 100,
			tint = true,
		}, S.ChamsFill);
	elseif ESP.Aura and ESP.Aura.On and not Preview.AuraShown
		and (ESP.Aura.Target == "Self" or ESP.Aura.Target == "All") then

		ESP.Paint(model, {
			material = Enum.Material.SmoothPlastic,
			reflectance = 0.08,
			transparency = 0,
			tint = true,
		}, ESP.Aura.Color);
	else
		ESP.Restore(model);
	end;

	local tool = model:FindFirstChildWhichIsA("Tool");

	if tool then
		ESP.Paint(tool, (S.ItemChams and ESP.MaterialStyles[S.ItemStyle]) and S.ItemStyle or nil, S.ItemColor);
	end;
end;

Preview.Paint = paintPreview;

local glow = Sections.Chams:AddLabel("Glow Chams");
glow:AddToggle({
	Default = false, Flag = "chams",
	Callback = function(v) S.Chams = v; paintPreview() end,
});

local glowOptions = glow:AddOption(1);

local glowFill = glowOptions:AddLabel("Fill");
glowFill:AddColorPicker({
	Default = S.ChamsFill, Flag = "chams_fill",
	Callback = function(v) S.ChamsFill = v; paintPreview() end,
});
glowFill:AddSlider({
	Min = 0, Max = 100, Default = 50, Type = "%", Size = 80,
	Flag = "chams_fill_t",
	Callback = function(v) S.ChamsFillT = v; paintPreview() end,
});

local glowOutline = glowOptions:AddLabel("Outline");
glowOutline:AddColorPicker({
	Default = S.ChamsOutline, Flag = "chams_outline",
	Callback = function(v) S.ChamsOutline = v end,
});
glowOutline:AddSlider({
	Min = 0, Max = 100, Default = 0, Type = "%", Size = 80,
	Flag = "chams_outline_t",
	Callback = function(v) S.ChamsOutlineT = v end,
});

local mat = Sections.Chams:AddLabel("Material Chams");
mat:AddToggle({
	Default = false, Flag = "mat_chams",
	Callback = function(v) S.MatChams = v; ESP.Restyle(); paintPreview(); if ESP.UpdateChamsBloom then ESP.UpdateChamsBloom() end end,
});

local matOptions = mat:AddOption(1);

local MAT_LIST = {};

for _, name in ipairs(ESP.MaterialOrder) do MAT_LIST[#MAT_LIST + 1] = name end;

MAT_LIST[#MAT_LIST + 1] = "Chromatic";

matOptions:AddLabel("Material"):AddDropdown({
	Default = "ForceField",
	Values = MAT_LIST,
	Flag = "mat_chams_material",
	Callback = function(v)

		if v == "Chromatic" then
			S.MatType = "Chromatic";
		else
			S.MatType = "Material";
			S.MatMaterial = v;
		end;

		ESP.Restyle();
		paintPreview();
	end,
});

matOptions:AddLabel("Color"):AddColorPicker({
	Default = S.MatColor, Flag = "mat_chams_color",
	Callback = function(v) S.MatColor = v; ESP.Restyle(); paintPreview() end,
});

matOptions:AddLabel("Transparency"):AddSlider({
	Min = 0, Max = 100, Default = 0, Type = "%", Size = 90,
	Flag = "mat_chams_transparency",
	Callback = function(v) S.MatTransparency = v / 100; ESP.Restyle(); paintPreview() end,
});

matOptions:AddLabel("Bloom"):AddSlider({
	Min = 0, Max = 300, Default = 0, Size = 90,
	Flag = "mat_chams_bloom",
	Callback = function(v) S.MatBloom = v / 100; if ESP.UpdateChamsBloom then ESP.UpdateChamsBloom() end end,
});

Sections.Chams:AddLabel("Target"):AddDropdown({
	Default = "Other",
	Values = { "Other", "Self", "All" },
	Flag = "chams_target",
	Callback = function(v) S.ChamsTarget = v; ESP.Restyle() end,
});

Sections.Items = Visuals.ESP:AddSection({ Name = "Item Chams", Position = "right" });

local itemsOn = Sections.Items:AddLabel("Enabled");
itemsOn:AddToggle({ Default = false, Flag = "item_chams", Callback = function(v) S.ItemChams = v end });
itemsOn:AddColorPicker({ Default = S.ItemColor, Flag = "item_chams_color", Callback = function(v) S.ItemColor = v end });

Sections.Items:AddLabel("Style"):AddDropdown({
	Default = "ForceField",
	Values = ESP.StyleOrder,
	Flag = "item_chams_style",
	Callback = function(v) S.ItemStyle = v end,
});

Sections.Items:AddLabel("Target"):AddDropdown({
	Default = "Other",
	Values = { "Other", "Self", "All" },
	Flag = "item_chams_target",
	Callback = function(v) S.ItemTarget = v end,
});

Sections.Shaders = Visuals.World:AddSection({ Name = "Shaders", Position = "left" });
Sections.Stars = Visuals.World:AddSection({ Name = "Constellations", Position = "left" });
Sections.Weather = Visuals.World:AddSection({ Name = "Weather", Position = "right" });
Sections.Aura = Visuals.World:AddSection({ Name = "Aura", Position = "left" });
Sections.Tracers = Visuals.World:AddSection({ Name = "Bullet Tracers", Position = "right" });
Sections.KillFx = Visuals.World:AddSection({ Name = "Kill Effects", Position = "left" });
Sections.Circles = Visuals.World:AddSection({ Name = "Jump / Land", Position = "right" });
Sections.Trail = Visuals.World:AddSection({ Name = "Trail", Position = "left" });
Sections.Glyphs = Visuals.World:AddSection({ Name = "Streaks", Position = "right" });
Sections.WorldMisc = Visuals.World:AddSection({ Name = "Sounds", Position = "right" });
Sections.Lighting = Visuals.World:AddSection({ Name = "Lighting", Position = "right" });
Sections.Screen = Visuals.Screen:AddSection({ Name = "Crosshair", Position = "left" });
Sections.ScreenInfo = Visuals.Screen:AddSection({ Name = "Info", Position = "right" });
Sections.Camera = Visuals.Screen:AddSection({ Name = "Camera", Position = "right" });
Sections.Models = Visuals.Models:AddSection({ Name = "Model Changer", Position = "right" });

guard("shaders", function()
	local Lighting = game:GetService("Lighting");

	local bloom, rays, blur, grade;
	local keepers = {};

	local function effect(class, props, adopt)
		local inst;

		local function make(old)
			local fresh = Instance.new(class);

			fresh.Name = NeverLose.RandomString();
			fresh.Enabled = false;

			for key, value in pairs(props) do fresh[key] = value end;

			if old then
				for key in pairs(props) do
					pcall(function() fresh[key] = old[key] end);
				end;

				pcall(function() fresh.Enabled = old.Enabled end);
			end;

			fresh.Parent = Lighting;

			return fresh;
		end;

		inst = make(nil);

		keepers[#keepers + 1] = function()
			if inst.Parent ~= Lighting then
				inst = make(inst);

				adopt(inst);
			end;
		end;

		return inst;
	end;

	bloom = effect("BloomEffect", { Intensity = 0.6, Size = 24, Threshold = 0.9 },
		function(v) bloom = v end);
	rays = effect("SunRaysEffect", { Intensity = 0.15, Spread = 0.9 },
		function(v) rays = v end);
	blur = effect("BlurEffect", { Size = 8 },
		function(v) blur = v end);
	grade = effect("ColorCorrectionEffect", { Brightness = 0, Contrast = 0.1, Saturation = 0.2, TintColor = Color3.fromRGB(255, 255, 255) },
		function(v) grade = v end);

	task.spawn(function()
		while ALIVE do
			task.wait(1);

			if not ALIVE then break end;

			for _, keeper in ipairs(keepers) do pcall(keeper) end;
		end;
	end);

	local AIR = {
		On = false, Density = 0.3, Haze = 0, Glare = 0,
		Color = Color3.fromRGB(199, 199, 199), Decay = Color3.fromRGB(106, 112, 125),
	};

	local airMine, airSaved;

	local function airInstance()
		local found = Lighting:FindFirstChildOfClass("Atmosphere");

		if not found then
			found = Instance.new("Atmosphere");
			found.Name = NeverLose.RandomString();
			found.Parent = Lighting;
			airMine = found;
		end;

		if not airSaved or airSaved.instance ~= found or not found.Parent then
			airSaved = {
				instance = found,
				Density = found.Density, Offset = found.Offset, Haze = found.Haze,
				Glare = found.Glare, Color = found.Color, Decay = found.Decay,
			};
		end;

		return found;
	end;

	local function applyAir()
		local fog = ESP.Fog;
		local fogOn = fog and fog.On;

        if not (AIR.On or fogOn) then

			if airSaved and airSaved.instance and airSaved.instance.Parent then
				local a = airSaved.instance;

				pcall(function()
					a.Density = airSaved.Density;
					a.Offset = airSaved.Offset;
					a.Haze = airSaved.Haze;
					a.Glare = airSaved.Glare;
					a.Color = airSaved.Color;
					a.Decay = airSaved.Decay;
				end);
			end;

			if airMine then pcall(function() airMine:Destroy() end); airMine = nil; airSaved = nil end;

			return;
		end;

		local a = airInstance();

		if not a then return end;

		if fogOn then
			a.Density = math.clamp(fog.Density / 100, 0, 1);
			a.Offset = math.clamp(fog.Offset or 0, -1, 1);
			a.Color = fog.Color;
		elseif AIR.On then
			a.Density = math.clamp(AIR.Density, 0, 1);
			a.Offset = airSaved and airSaved.Offset or 0;
			a.Color = AIR.Color;
		end;

		if AIR.On then
			a.Haze = math.clamp(AIR.Haze, 0, 10);
			a.Glare = math.clamp(AIR.Glare, 0, 10);
			a.Decay = AIR.Decay;
		elseif airSaved then
			a.Haze = airSaved.Haze;
			a.Glare = airSaved.Glare;
			a.Decay = airSaved.Decay;
		end;
	end;

	ESP.ApplyAir = applyAir;
	ESP.Air = AIR;

	onUnload("atmosphere", function()
		AIR.On = false;

		if ESP.Fog then ESP.Fog.On = false end;

		pcall(applyAir);
	end);

	ESP.Shaders = { bloom = bloom, rays = rays, blur = blur, grade = grade };

	ESP.ClearShaders = function()
		if ESP.RestoreFog then pcall(ESP.RestoreFog) end;
		if ESP.RestoreLighting then pcall(ESP.RestoreLighting) end;

		if ESP.RestoreSky then pcall(ESP.RestoreSky) end;

		bloom:Destroy();
		rays:Destroy();
		blur:Destroy();
		grade:Destroy();

		AIR.On = false;

		if ESP.Fog then ESP.Fog.On = false end;

		pcall(applyAir);
	end;

	local PRESETS = {
		Day = {
			bloom = { on = true, intensity = 0.35, size = 20, threshold = 1.1 },
			rays = { on = true, intensity = 0.08 },
			blur = { on = false, size = 8 },
			grade = { on = true, brightness = 0.02, contrast = 0.12, saturation = 0.15, tint = Color3.fromRGB(255, 252, 245) },
			air = { on = true, density = 0.25, haze = 0.6, color = Color3.fromRGB(205, 216, 226) },
		},
		Night = {
			bloom = { on = true, intensity = 0.75, size = 30, threshold = 0.75 },
			rays = { on = false, intensity = 0 },
			blur = { on = false, size = 8 },
			grade = { on = true, brightness = -0.04, contrast = 0.2, saturation = -0.2, tint = Color3.fromRGB(150, 175, 255) },
			air = { on = true, density = 0.42, haze = 1.2, color = Color3.fromRGB(70, 86, 120) },
		},
		Sunset = {
			bloom = { on = true, intensity = 0.9, size = 34, threshold = 0.8 },
			rays = { on = true, intensity = 0.3 },
			blur = { on = false, size = 8 },
			grade = { on = true, brightness = 0.03, contrast = 0.18, saturation = 0.35, tint = Color3.fromRGB(255, 196, 150) },
			air = { on = true, density = 0.38, haze = 1.8, color = Color3.fromRGB(255, 180, 140) },
		},
		Noir = {
			bloom = { on = true, intensity = 0.5, size = 26, threshold = 0.85 },
			rays = { on = false, intensity = 0 },
			blur = { on = false, size = 8 },
			grade = { on = true, brightness = -0.02, contrast = 0.45, saturation = -1, tint = Color3.fromRGB(255, 255, 255) },
			air = { on = true, density = 0.3, haze = 1, color = Color3.fromRGB(150, 150, 150) },
		},
		Vibrant = {
			bloom = { on = true, intensity = 0.6, size = 24, threshold = 0.95 },
			rays = { on = true, intensity = 0.15 },
			blur = { on = false, size = 8 },
			grade = { on = true, brightness = 0.05, contrast = 0.25, saturation = 0.6, tint = Color3.fromRGB(255, 255, 255) },
			air = { on = false, density = 0.3, haze = 0, color = Color3.fromRGB(199, 199, 199) },
		},
		Dream = {
			bloom = { on = true, intensity = 1.4, size = 40, threshold = 0.6 },
			rays = { on = true, intensity = 0.22 },
			blur = { on = true, size = 6 },
			grade = { on = true, brightness = 0.06, contrast = -0.05, saturation = 0.3, tint = Color3.fromRGB(255, 220, 245) },
			air = { on = true, density = 0.45, haze = 2.4, color = Color3.fromRGB(255, 215, 240) },
		},
		Horror = {
			bloom = { on = false, intensity = 0.3, size = 20, threshold = 1 },
			rays = { on = false, intensity = 0 },
			blur = { on = true, size = 3 },
			grade = { on = true, brightness = -0.12, contrast = 0.5, saturation = -0.55, tint = Color3.fromRGB(150, 170, 160) },
			air = { on = true, density = 0.55, haze = 3, color = Color3.fromRGB(40, 48, 44) },
		},
	};

	ESP.ShaderPresets = PRESETS;

	local function applyPreset(name)
		local preset = PRESETS[name];
		if not preset then return end;

		bloom.Enabled = preset.bloom.on;
		bloom.Intensity = preset.bloom.intensity;
		bloom.Size = preset.bloom.size;
		bloom.Threshold = preset.bloom.threshold;

		rays.Enabled = preset.rays.on;
		rays.Intensity = preset.rays.intensity;

		blur.Enabled = preset.blur.on;
		blur.Size = preset.blur.size;

		grade.Enabled = preset.grade.on;
		grade.Brightness = preset.grade.brightness;
		grade.Contrast = preset.grade.contrast;
		grade.Saturation = preset.grade.saturation;
		grade.TintColor = preset.grade.tint;

		AIR.Density = preset.air.density;
		AIR.Haze = preset.air.haze;
		AIR.Color = preset.air.color;
		AIR.On = preset.air.on;

		applyAir();
	end;

	ESP.ApplyShaderPreset = applyPreset;

	Sections.Shaders:AddLabel("Preset"):AddDropdown({
		Default = "Off",
		Values = { "Off", "Day", "Night", "Sunset", "Noir", "Vibrant", "Dream", "Horror" },
		Flag = "shader_preset",
		Callback = function(v)
			if v == "Off" then
				bloom.Enabled = false;
				rays.Enabled = false;
				blur.Enabled = false;
				grade.Enabled = false;
				AIR.On = false;

				applyAir();

				if ESP.ApplyGrade then pcall(ESP.ApplyGrade) end;

				return;
			end;

			applyPreset(v);
		end,
	});

	local SKYBOXES = {
		Jungle = {
			SkyboxBk = "rbxassetid://214399891", SkyboxDn = "rbxassetid://214399887",
			SkyboxFt = "rbxassetid://214399894", SkyboxLf = "rbxassetid://214405668",
			SkyboxRt = "rbxassetid://214399899", SkyboxUp = "rbxassetid://214399889",
		},
		Blossom = {
			SkyboxBk = "rbxassetid://271042516", SkyboxDn = "rbxassetid://271077243",
			SkyboxFt = "rbxassetid://271042556", SkyboxLf = "rbxassetid://271042310",
			SkyboxRt = "rbxassetid://271042467", SkyboxUp = "rbxassetid://271077958",
		},
		["Red Night"] = {
			SkyboxBk = "rbxassetid://401664839", SkyboxDn = "rbxassetid://401664862",
			SkyboxFt = "rbxassetid://401664960", SkyboxLf = "rbxassetid://401664881",
			SkyboxRt = "rbxassetid://401664901", SkyboxUp = "rbxassetid://401664936",
		},
		Purple = {
			SkyboxBk = "rbxassetid://13694952867", SkyboxDn = "rbxassetid://13694968325",
			SkyboxFt = "rbxassetid://13694980654", SkyboxLf = "rbxassetid://13694998113",
			SkyboxRt = "rbxassetid://13695002700", SkyboxUp = "rbxassetid://13695007103",
		},
	};

	local SKY_ASSETS = { Galaxy = 15983996673 };

	local SKY_ORDER = { "Off", "Jungle", "Blossom", "Red Night", "Purple", "Galaxy" };

	local SKY_FACES = { up = "SkyboxUp", dn = "SkyboxDn", lf = "SkyboxLf", rt = "SkyboxRt", ft = "SkyboxFt", bk = "SkyboxBk" };
	local function prettySkyName(value)
		local text = tostring(value or ""):gsub("[_%-]+", " "):gsub("(%l)(%u)", "%1 %2")
		text = text:gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")
		return (text:gsub("(%a)([%w']*)", function(first, rest)
			return first:upper() .. rest:lower()
		end))
	end;

	local function resolveSky(entry)
		if entry.__ready then return entry.__ready end;

		local faces = {};

		for face, property in pairs(SKY_FACES) do
			local rel = entry.files[face];

			if not rel then return nil end;

			local url = Remote.asset(rel);

			if not url then return nil end;

			faces[property] = url;
		end;

		entry.__ready = faces;

		return faces;
	end;

	ESP.ResolveSky = resolveSky;

	if isfile and getcustomasset then
		local groups = {};

		for _, rel in ipairs(Remote.under("skyboxes/")) do
			local file = string.match(rel, "([^/]+)$");
			local name, face = string.match(file or "", "^(.+)_(%a%a)%.[jp][pn]g$");

			if name and SKY_FACES[face] then
				groups[name] = groups[name] or {};
				groups[name][face] = rel;
			end;
		end;

		local manifest = Remote.manifest or (Remote.base ~= "" and Remote.load()) or nil;

		if manifest and type(manifest.skyboxes) == "table" then
			for name, faces in pairs(manifest.skyboxes) do
				groups[name] = groups[name] or {};

				for _, face in ipairs(faces) do
					if SKY_FACES[face] and not groups[name][face] then
						groups[name][face] = "skyboxes/" .. name .. "_" .. face .. ".jpg";
					end;
				end;
			end;
		end;

		for name in pairs(groups) do
			if string.lower(name):match("cloudy") or string.lower(name):match("foggy") then
				groups[name] = nil;
			end;
		end;

		local names = {};
		for name in pairs(groups) do names[#names + 1] = name end;
		table.sort(names);

		for _, name in ipairs(names) do
			local complete = true;

			for face in pairs(SKY_FACES) do
				if not groups[name][face] then complete = false end;
			end;

			if complete then

				local pretty = prettySkyName(name);
				if SKYBOXES[pretty] or SKY_ASSETS[pretty] or pretty == "Off" then pretty = pretty .. " (Local)" end;
				if SKYBOXES[pretty] then pretty = pretty .. " [" .. name .. "]" end;

				SKYBOXES[pretty] = { __sky = name, files = groups[name] };
				SKY_ORDER[#SKY_ORDER + 1] = pretty;
			end;
		end;
	end;

	table.sort(SKY_ORDER, function(a, b)
		if a == "Off" then return b ~= "Off" end;
		if b == "Off" then return false end;
		return a:lower() < b:lower();
	end);

	local SK = { Box = "Off", Body = "Default", Size = 21, Stars = 3000 };

	local mapSky, mapSkyParent, ourSky;
	local skyGeneration=0;

	local originals={};
	local bodyProperties={"StarCount","CelestialBodiesShown","SunAngularSize","MoonAngularSize","SunTextureId","MoonTextureId"};
	local function rememberBody(sky)
		if not sky or originals[sky] then return end;
		local values={}; for _,property in ipairs(bodyProperties) do values[property]=sky[property] end;
		originals[sky]=values;
	end;
	local function restoreBody(sky)
		if sky and originals[sky] then
			for property,value in pairs(originals[sky]) do pcall(function() sky[property]=value end) end;
		end;
	end;
	local function forgetBody(sky)
		if sky then originals[sky]=nil end;
	end;

	local function detachMap()
		if mapSky then return end;

		local existing = Lighting:FindFirstChildOfClass("Sky");

		if existing and existing ~= ourSky then
			mapSky, mapSkyParent = existing, existing.Parent;
			pcall(function() existing.Parent = nil end);
		end;
	end;

	local function dropOurs()
		if ourSky then
			forgetBody(ourSky);
			pcall(function() ourSky:Destroy() end);
			ourSky = nil;
		end;
	end;

	local function restoreSky()
		skyGeneration=skyGeneration+1;
		for sky in pairs(originals) do restoreBody(sky) end;
		table.clear(originals);
		dropOurs();

		if mapSky then
			pcall(function() mapSky.Parent = mapSkyParent or Lighting end);
			mapSky, mapSkyParent = nil, nil;
		end;
	end;

	local bodySky;

	local function applyBody()
		local sky = ourSky or Lighting:FindFirstChildOfClass("Sky");

		if not sky and SK.Body ~= "Default" then
			sky = Instance.new("Sky");
			sky.Name = NeverLose.RandomString();
			sky.Parent = Lighting;
			bodySky = sky;
		end;

		if not sky then return end;

		if bodySky and sky == bodySky and SK.Body == "Default" then
			pcall(function() bodySky:Destroy() end);

			bodySky = nil;

			return;
		end;

		rememberBody(sky); restoreBody(sky);

		sky.StarCount = SK.Stars;

		if SK.Body == "Default" then
			sky.CelestialBodiesShown = true;
			return;
		end;

		sky.CelestialBodiesShown = SK.Body ~= "None";

		if SK.Body == "Sun" then
			sky.SunAngularSize = SK.Size;
			sky.MoonAngularSize = 0;
		elseif SK.Body == "Moon" then
			sky.SunAngularSize = 0;
			sky.MoonAngularSize = SK.Size;
		elseif SK.Body == "Eclipse" then
			sky.SunTextureId = "rbxasset://sky/moon.jpg";
			sky.SunAngularSize = SK.Size;
			sky.MoonAngularSize = 0;
		else
			sky.SunAngularSize = 0;
			sky.MoonAngularSize = 0;
		end;
	end;

	onUnload("celestial", function()
		if bodySky then forgetBody(bodySky); pcall(function() bodySky:Destroy() end); bodySky = nil end;

		for sky in pairs(originals) do restoreBody(sky) end;

		table.clear(originals);
	end);

	local function applyFaces(faces)
		detachMap();
		dropOurs();

		local sky = Instance.new("Sky");
		sky.Name = NeverLose.RandomString();

		for property, value in pairs(faces) do
			pcall(function() sky[property] = value end);
		end;

		sky.Parent = Lighting;
		ourSky = sky;

		applyBody();
	end;

	local function applyAsset(id)
		local picked, epoch = SK.Box, skyGeneration;

		task.spawn(function()
			local ok, objects = pcall(game.GetObjects, game, "rbxassetid://" .. id);
			if not ok or type(objects) ~= "table" then return end;

			local found;

			for _, object in ipairs(objects) do
				if object:IsA("Sky") then
					found = object;
					break;
				end;

				local nested = object:FindFirstChildWhichIsA("Sky", true);

				if nested then
					found = nested;
					break;
				end;
			end;

			if not found or not ALIVE or SK.Box ~= picked or skyGeneration ~= epoch then
				for _, object in ipairs(objects) do object:Destroy() end;
				return;
			end;

			detachMap();
			dropOurs();

			found.Name = NeverLose.RandomString();
			found.Parent = Lighting;
			ourSky = found;
			for _, object in ipairs(objects) do if object ~= found then object:Destroy() end end;
			applyBody();
		end);
	end;

	local function applySky()
		skyGeneration=skyGeneration+1;
		if SK.Box == "Off" then
			restoreSky();
			return;
		end;

		if SKYBOXES[SK.Box] then
			local entry = SKYBOXES[SK.Box];

			if entry.files then
				local picked = SK.Box;

				task.spawn(function()
					local faces = resolveSky(entry);

					if faces and ALIVE and SK.Box == picked then applyFaces(faces) end;
				end);
			else
				applyFaces(entry);
			end;
		elseif SKY_ASSETS[SK.Box] then
			applyAsset(SKY_ASSETS[SK.Box]);
		end;
	end;

	ESP.Sky = SK;
	ESP.RestoreSky = restoreSky;

	Sections.Shaders:AddLabel("Skybox"):AddDropdown({
		Default = "Off",
		Values = SKY_ORDER,
		Flag = "sky_box",
		Callback = function(v) SK.Box = v; applySky() end,
	});

	local bodyRow = Sections.Shaders:AddLabel("Celestial");
	bodyRow:AddDropdown({
		Default = "Default",
		Values = { "Default", "Sun", "Moon", "Eclipse", "None" },
		Flag = "sky_body",
		Callback = function(v) SK.Body = v; applyBody() end,
	});

	local bodyOptions = bodyRow:AddOption(1);

	bodyOptions:AddLabel("Size"):AddSlider({
		Min = 0, Max = 60, Default = 21, Rounding = 0, Size = 90,
		Flag = "sky_size",
		Callback = function(v) SK.Size = v; applyBody() end,
	});

	bodyOptions:AddLabel("Stars"):AddSlider({
		Min = 0, Max = 12000, Default = 3000, Rounding = 0, Size = 90,
		Flag = "sky_stars",
		Callback = function(v) SK.Stars = v; applyBody() end,
	});

	local FOG = { On = false, Color = Color3.fromRGB(192, 192, 192), Density = 35, Offset = 0 };

	ESP.Fog = FOG;

	local function applyFog() applyAir() end;

	ESP.ApplyFog = applyFog;
	ESP.RestoreFog = function() FOG.On = false; applyAir() end;

	local elapsed = 0;

	NeverLose:AddSignal(RunService.Heartbeat:Connect(function(dt)
		elapsed = elapsed + dt;

		if elapsed < 1 or not ALIVE then return end;

		elapsed = 0;

		if not (FOG.On or AIR.On) then return end;

		local live = Lighting:FindFirstChildOfClass("Atmosphere");

		if not live then applyAir(); return end;

		local wantDensity = FOG.On and math.clamp(FOG.Density / 100, 0, 1) or AIR.Density;

		if math.abs(live.Density - wantDensity) > 0.01 then applyAir() end;
	end));

	local fogRow = Sections.Shaders:AddLabel("Fog");

	fogRow:AddToggle({
		Default = false, Flag = "fog",
		Callback = function(v) FOG.On = v; applyAir() end,
	});

	fogRow:AddColorPicker({
		Default = FOG.Color, Flag = "fog_color",
		Callback = function(v) FOG.Color = v; applyAir() end,
	});

	local fogOptions = fogRow:AddOption(1);

	fogOptions:AddLabel("Density"):AddSlider({
		Min = 0, Max = 100, Default = 35, Rounding = 0, Size = 90,
		Flag = "fog_density",
		Callback = function(v) FOG.Density = v; applyAir() end,
	});

	fogOptions:AddLabel("Height"):AddSlider({
		Min = -100, Max = 100, Default = 0, Rounding = 0, Size = 90,
		Flag = "fog_offset",
		Callback = function(v) FOG.Offset = v / 100; applyAir() end,
	});

	local bloomRow = Sections.Shaders:AddLabel("Bloom");
	bloomRow:AddToggle({ Default = false, Flag = "shader_bloom", Callback = function(v) bloom.Enabled = v end });

	local bloomOptions = bloomRow:AddOption(1);

	bloomOptions:AddLabel("Intensity"):AddSlider({
		Min = 0, Max = 200, Default = 60, Rounding = 0, Size = 90,
		Flag = "shader_bloom_intensity",
		Callback = function(v) bloom.Intensity = v / 100 end,
	});

	bloomOptions:AddLabel("Size"):AddSlider({
		Min = 1, Max = 56, Default = 24, Rounding = 0, Size = 90,
		Flag = "shader_bloom_size",
		Callback = function(v) bloom.Size = v end,
	});

	bloomOptions:AddLabel("Threshold"):AddSlider({
		Min = 0, Max = 200, Default = 90, Rounding = 0, Size = 90,
		Flag = "shader_bloom_threshold",
		Callback = function(v) bloom.Threshold = v / 100 end,
	});

	local raysRow = Sections.Shaders:AddLabel("Sun Rays");
	raysRow:AddToggle({ Default = false, Flag = "shader_rays", Callback = function(v) rays.Enabled = v end });
	raysRow:AddOption(1):AddLabel("Intensity"):AddSlider({
		Min = 0, Max = 100, Default = 15, Rounding = 0, Size = 90,
		Flag = "shader_rays_intensity",
		Callback = function(v) rays.Intensity = v / 100 end,
	});

	local blurRow = Sections.Shaders:AddLabel("Blur");
	blurRow:AddToggle({ Default = false, Flag = "shader_blur", Callback = function(v) blur.Enabled = v end });
	blurRow:AddSlider({
		Min = 1, Max = 40, Default = 8, Rounding = 0, Size = 90,
		Flag = "shader_blur_size",
		Callback = function(v) blur.Size = v end,
	});

	local GRADE = {
		On = false,
		Tint = Color3.fromRGB(255, 255, 255),
		Saturation = 0.2,
		Contrast = 0.1,
		Brightness = 0,
	};

	local function paintGrade()
		grade.Enabled = GRADE.On;
		grade.TintColor = GRADE.Tint;
		grade.Saturation = GRADE.Saturation;
		grade.Contrast = GRADE.Contrast;
		grade.Brightness = GRADE.Brightness;
	end;

	ESP.ApplyGrade = paintGrade;

	local gradeRow = Sections.Shaders:AddLabel("Color Grade");
	gradeRow:AddToggle({ Default = false, Flag = "shader_grade", Callback = function(v) GRADE.On = v; paintGrade() end });
	gradeRow:AddColorPicker({
		Default = Color3.fromRGB(255, 255, 255), Flag = "shader_grade_tint",
		Callback = function(v) GRADE.Tint = v; paintGrade() end,
	});

	local gradeOptions = gradeRow:AddOption(1);

	gradeOptions:AddLabel("Saturation"):AddSlider({
		Min = -100, Max = 200, Default = 20, Rounding = 0, Size = 90,
		Flag = "shader_grade_saturation",
		Callback = function(v) GRADE.Saturation = v / 100; paintGrade() end,
	});

	gradeOptions:AddLabel("Contrast"):AddSlider({
		Min = -100, Max = 200, Default = 10, Rounding = 0, Size = 90,
		Flag = "shader_grade_contrast",
		Callback = function(v) GRADE.Contrast = v / 100; paintGrade() end,
	});

	gradeOptions:AddLabel("Brightness"):AddSlider({
		Min = -100, Max = 100, Default = 0, Rounding = 0, Size = 90,
		Flag = "shader_grade_brightness",
		Callback = function(v) GRADE.Brightness = v / 100; paintGrade() end,
	});

	local airRow = Sections.Shaders:AddLabel("Atmosphere");
	airRow:AddToggle({
		Default = false, Flag = "shader_atmosphere",
		Callback = function(v)
			AIR.On = v;

			applyAir();
		end,
	});
	airRow:AddColorPicker({
		Default = Color3.fromRGB(199, 199, 199), Flag = "shader_atmosphere_color",
		Callback = function(v) AIR.Color = v; applyAir() end,
	});

	local airOptions = airRow:AddOption(1);

	airOptions:AddLabel("Density"):AddSlider({
		Min = 0, Max = 100, Default = 30, Rounding = 0, Size = 90,
		Flag = "shader_atmosphere_density",
		Callback = function(v) AIR.Density = v / 100; applyAir() end,
	});

	airOptions:AddLabel("Haze"):AddSlider({
		Min = 0, Max = 100, Default = 0, Rounding = 0, Size = 90,
		Flag = "shader_atmosphere_haze",
		Callback = function(v) AIR.Haze = v / 10; applyAir() end,
	});
end);

guard("lighting", function()
	local Lighting = game:GetService("Lighting");

	local original = {
		Brightness = Lighting.Brightness,
		ClockTime = Lighting.ClockTime,
		GlobalShadows = Lighting.GlobalShadows,
		Ambient = Lighting.Ambient,
		OutdoorAmbient = Lighting.OutdoorAmbient,
		Exposure = Lighting.ExposureCompensation,
		FogEnd = Lighting.FogEnd,
	};

	local FB = { On = false };
	local TM = { On = false, Value = 12 };
	local AM = { On = false, Color = Color3.fromRGB(128, 128, 128) };
	local EX = { On = false, Value = 0 };

	local function applyFullbright()
		local light = Lighting;

		if FB.On then
			light.Brightness = 2;
			light.GlobalShadows = false;
			light.OutdoorAmbient = AM.On and AM.Color or Color3.fromRGB(128, 128, 128);
			light.ClockTime = TM.On and TM.Value or 14;

		else
			light.Brightness = original.Brightness;
			light.GlobalShadows = original.GlobalShadows;
			light.OutdoorAmbient = AM.On and AM.Color or original.OutdoorAmbient;
			light.ClockTime = TM.On and TM.Value or original.ClockTime;

		end;
	end;

	local function applyAmbient()
		local light = Lighting;

		if AM.On then
			light.Ambient = AM.Color;
			light.OutdoorAmbient = AM.Color;
		else
			light.Ambient = original.Ambient;
			light.OutdoorAmbient = FB.On and Color3.fromRGB(128, 128, 128) or original.OutdoorAmbient;
		end;
	end;

	local function applyTime()
		if TM.On then
			Lighting.ClockTime = TM.Value;
		else
			Lighting.ClockTime = FB.On and 14 or original.ClockTime;
		end;
	end;

	local function applyExposure()
		Lighting.ExposureCompensation = EX.On and EX.Value or original.Exposure;
	end;

	local function applyAll()
		if FB.On then applyFullbright() end;
		if AM.On then applyAmbient() end;
		if TM.On then applyTime() end;
		if EX.On then applyExposure() end;
	end;

	ESP.RestoreLighting = function()
		FB.On, TM.On, AM.On, EX.On = false, false, false, false;
		applyFullbright(); applyAmbient(); applyTime(); applyExposure();
	end;

	ESP.Lighting = { FB = FB, Time = TM, Ambient = AM, Exposure = EX };

	task.spawn(function()
		while ALIVE do
			task.wait(1);
			if not ALIVE then break end;

			if NeverLose.ScreenGui.Parent then
				if FB.On or TM.On or AM.On or EX.On then
					pcall(applyAll);
				end;
			end;
		end;
	end);

	local fullbrightRow = Sections.Lighting:AddLabel("Fullbright");
	fullbrightRow:AddToggle({
		Default = false, Flag = "fullbright",
		Callback = function(v) FB.On = v; applyFullbright() end,
	});

	local timeRow = Sections.Lighting:AddLabel("Time Change");
	timeRow:AddToggle({
		Default = false, Flag = "time_change",
		Callback = function(v) TM.On = v; applyTime() end,
	});

	timeRow:AddOption(1):AddLabel("Time"):AddSlider({
		Min = 0, Max = 24, Default = 12, Rounding = 1, Size = 90,
		Flag = "time_value",
		Callback = function(v) TM.Value = v; applyTime() end,
	});

	local ambientRow = Sections.Lighting:AddLabel("Ambient");
	ambientRow:AddToggle({
		Default = false, Flag = "ambient",
		Callback = function(v) AM.On = v; applyAmbient() end,
	});
	ambientRow:AddColorPicker({
		Default = AM.Color, Flag = "ambient_color",
		Callback = function(v) AM.Color = v; applyAmbient() end,
	});

	local exposureRow = Sections.Lighting:AddLabel("Exposure");
	exposureRow:AddToggle({
		Default = false, Flag = "exposure",
		Callback = function(v) EX.On = v; applyExposure() end,
	});

	exposureRow:AddOption(1):AddLabel("Value"):AddSlider({
		Min = -5, Max = 5, Default = 0, Rounding = 2, Size = 90,
		Flag = "exposure_value",
		Callback = function(v) EX.Value = v; applyExposure() end,
	});
end);

guard("aura", function()

	local ORDER = {
		"Angelic", "Ambient", "Nimb", "Tornado",
		"Angel", "Starlight", "Heavenly", "Ribbon", "Sakura", "Wind", "Flow", "Star",
	};

	local CATALOGUE = {
		Angel = "97658130917593",
		Starlight = "134645216613107",
		Heavenly = "139300897520961",
		Ribbon = "132069507632161",
		Sakura = "81755778619404",
		Wind = "80694081850877",
		Flow = "119913533725648",
		Star = "73754563740680",
	};

	local GROUPS = {
		{ "Head" },
		{ "Torso", "UpperTorso", "LowerTorso", "HumanoidRootPart" },
		{ "Left Arm", "LeftUpperArm", "LeftLowerArm", "LeftHand" },
		{ "Right Arm", "RightUpperArm", "RightLowerArm", "RightHand" },
		{ "Left Leg", "LeftUpperLeg", "LeftLowerLeg", "LeftFoot" },
		{ "Right Leg", "RightUpperLeg", "RightLowerLeg", "RightFoot" },
	};

	local GROUP_OF = {};

	for _, names in ipairs(GROUPS) do
		for _, name in ipairs(names) do GROUP_OF[name] = names end;
	end;

	local A = {
		On = false,
		Color = Color3.fromRGB(133, 220, 255),
		Types = {},
		Type = "Angelic",
		Glow = 2,
		Rate = 1,
		Size = 1,
		Tint = true,
	};

	ESP.Aura = A;

	local attachments, particles = {}, {};
	local charConnection = nil;

	local borrowed = {};

	local function clearAll()
		for i = 1, #attachments do
			if attachments[i] and attachments[i].Parent then
				attachments[i]:Destroy();
			end;
		end;

		for i = 1, #borrowed do
			if borrowed[i] and borrowed[i].Parent then
				pcall(function() borrowed[i]:Destroy() end);
			end;
		end;

		attachments = {};
		borrowed = {};
		particles = {};
	end;

	local function keep(emitter, attachment)
		emitter.Parent = attachment;

		particles[#particles + 1] = {
			emitter = emitter,
			rate = emitter.Rate,
			bright = emitter.Brightness,
			size = emitter.Size,
		};

		return emitter;
	end;

	local function scaleSequence(sequence, factor)
		if factor == 1 then return sequence end;

		local points = {};

		for index, key in ipairs(sequence.Keypoints) do
			points[index] = NumberSequenceKeypoint.new(key.Time, key.Value * factor, key.Envelope * factor);
		end;

		return NumberSequence.new(points);
	end;

	local function tune()
		for _, record in ipairs(particles) do
			local emitter = record.emitter;

			if emitter.Parent then
				emitter.Color = ColorSequence.new(A.Color);
				emitter.Rate = record.rate * A.Rate;
				emitter.Brightness = record.bright * A.Glow * 0.5;
				emitter.Size = scaleSequence(record.size, A.Size);
			end;
		end;

		for _, item in ipairs(borrowed) do
			if item.Parent then
				pcall(function()
					if item:IsA("PointLight") or item:IsA("SpotLight") or item:IsA("SurfaceLight") then
						item.Color = A.Color;
					elseif item:IsA("Beam") or item:IsA("Trail") then
						item.Color = ColorSequence.new(A.Color);
					end;
				end);
			end;
		end;
	end;

	local function part(character, ...)
		for _, name in ipairs({ ... }) do
			local found = character:FindFirstChild(name);

			if found then return found end;
		end;

		return nil;
	end;

	local function anchor(host, cframe)
		local attachment = Instance.new("Attachment");

		attachment.CFrame = cframe;
		attachment.Parent = host;

		attachments[#attachments + 1] = attachment;

		return attachment;
	end;

	local function createAngelic(character)
		local torso = part(character, "Torso", "UpperTorso");

		if not torso then return end;

		local left = anchor(torso, CFrame.new(-1.012, 0.5, 0.852, 0.966, 0, 0.259, 0, 1, 0, -0.259, 0, 0.966));
		local wingL = Instance.new("ParticleEmitter");
		wingL.Lifetime = NumberRange.new(1, 1);
		wingL.LockedToPart = true;
		wingL.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.944),
			NumberSequenceKeypoint.new(0.2, 0),
			NumberSequenceKeypoint.new(0.8, 0),
			NumberSequenceKeypoint.new(1, 1),
		});
		wingL.LightEmission = 1;
		wingL.Color = ColorSequence.new(A.Color);
		wingL.Speed = NumberRange.new(0.05, 0.05);
		wingL.Size = NumberSequence.new(2.75, 3.5);
		wingL.Rate = 4;
		wingL.Texture = "rbxassetid://13267054240";
		wingL.EmissionDirection = Enum.NormalId.Back;
		wingL.Orientation = Enum.ParticleOrientation.VelocityPerpendicular;
		wingL.Rotation = NumberRange.new(-15, -15);
		keep(wingL, left);

		local right = anchor(torso, CFrame.new(1.167, 0.5, 0.852, 0.966, 0, -0.259, 0, 1, 0, 0.259, 0, 0.966));
		local wingR = wingL:Clone();
		wingR.EmissionDirection = Enum.NormalId.Front;
		keep(wingR, right);

		local core = anchor(torso, CFrame.new(0, 0.3, 0));
		local burst = Instance.new("ParticleEmitter");
		burst.Lifetime = NumberRange.new(2, 2);
		burst.FlipbookLayout = Enum.ParticleFlipbookLayout.Grid4x4;
		burst.SpreadAngle = Vector2.new(180, 180);
		burst.LockedToPart = true;
		burst.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.5, 0.3),
			NumberSequenceKeypoint.new(1, 1),
		});
		burst.LightEmission = 1;
		burst.Color = ColorSequence.new(A.Color);
		burst.Speed = NumberRange.new(0.5, 0.5);
		burst.Brightness = 2;
		burst.Size = NumberSequence.new(3, 4);
		burst.Rate = 5;
		burst.Texture = "rbxassetid://11402221943";
		burst.FlipbookMode = Enum.ParticleFlipbookMode.OneShot;
		burst.Rotation = NumberRange.new(0, 360);
		keep(burst, core);
	end;

	local function createAmbient(character)
		local hrp = part(character, "HumanoidRootPart");

		if not hrp then return end;

		local base = anchor(hrp, CFrame.new(0, -2.75, 0));

		local grow = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.3, 1),
			NumberSequenceKeypoint.new(0.6, 2.5),
			NumberSequenceKeypoint.new(0.8, 4),
			NumberSequenceKeypoint.new(1, 6),
		});

		local crescent = Instance.new("ParticleEmitter");
		crescent.Lifetime = NumberRange.new(2, 2);
		crescent.SpreadAngle = Vector2.new(0.001, 0.001);
		crescent.LockedToPart = true;
		crescent.Transparency = NumberSequence.new(0, 1);
		crescent.LightEmission = 1;
		crescent.Color = ColorSequence.new(A.Color);
		crescent.Squash = NumberSequence.new(0);
		crescent.Speed = NumberRange.new(0.001, 0.001);
		crescent.Brightness = 2;
		crescent.Size = grow;
		crescent.RotSpeed = NumberRange.new(-600, 600);
		crescent.Texture = "rbxassetid://12713358087";
		crescent.Orientation = Enum.ParticleOrientation.VelocityPerpendicular;
		crescent.Rotation = NumberRange.new(0, 360);
		keep(crescent, base);

		local ring = Instance.new("ParticleEmitter");
		ring.Lifetime = NumberRange.new(2, 2);
		ring.SpreadAngle = Vector2.new(0.001, 0.001);
		ring.LockedToPart = true;
		ring.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.6, 0.2),
			NumberSequenceKeypoint.new(1, 1),
		});
		ring.LightEmission = 1;
		ring.Color = ColorSequence.new(A.Color);
		ring.Squash = NumberSequence.new(0, 2);
		ring.Speed = NumberRange.new(0.001, 0.001);
		ring.Brightness = 2;
		ring.Size = grow;
		ring.RotSpeed = NumberRange.new(-30, 30);
		ring.Texture = "rbxassetid://7216849325";
		ring.Orientation = Enum.ParticleOrientation.VelocityPerpendicular;
		ring.Rotation = NumberRange.new(0, 360);
		keep(ring, base);

		local wide = Instance.new("ParticleEmitter");
		wide.Lifetime = NumberRange.new(2, 2);
		wide.SpreadAngle = Vector2.new(0.001, 0.001);
		wide.LockedToPart = true;
		wide.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.2, 0.3),
			NumberSequenceKeypoint.new(1, 1),
		});
		wide.LightEmission = 1;
		wide.Color = ColorSequence.new(A.Color);
		wide.Squash = NumberSequence.new(0);
		wide.Speed = NumberRange.new(0.001, 0.001);
		wide.Brightness = 2;
		wide.Size = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.3, 2),
			NumberSequenceKeypoint.new(0.6, 5),
			NumberSequenceKeypoint.new(0.8, 8),
			NumberSequenceKeypoint.new(1, 12),
		});
		wide.RotSpeed = NumberRange.new(-40, 40);
		wide.Texture = "rbxassetid://7216855136";
		wide.Orientation = Enum.ParticleOrientation.VelocityPerpendicular;
		wide.Rotation = NumberRange.new(0, 360);
		keep(wide, base);
	end;

	local function createNimb(character)
		local head = part(character, "Head");

		if not head then return end;

		local halo = anchor(head, CFrame.new(-0.25, 0.933, 0.259, 0.469, -0.25, -0.847, -0.117, 0.933, -0.34, 0.875, 0.259, 0.408));

		for index = 1, 2 do
			local emitter = Instance.new("ParticleEmitter");
			emitter.Lifetime = NumberRange.new(1, 1);
			emitter.SpreadAngle = Vector2.new(5, 5);
			emitter.LockedToPart = true;
			emitter.Transparency = NumberSequence.new({
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.2, 0),
				NumberSequenceKeypoint.new(0.8, 0),
				NumberSequenceKeypoint.new(1, 1),
			});
			emitter.LightEmission = 1;
			emitter.Color = ColorSequence.new(A.Color);
			emitter.Speed = NumberRange.new(0.001, 0.001);
			emitter.Brightness = 2;
			emitter.Size = (index == 1) and NumberSequence.new(2.5, 3) or NumberSequence.new(2, 3);
			emitter.RotSpeed = NumberRange.new(-400, 400);
			emitter.Rate = 7;
			emitter.Texture = "rbxassetid://8819682608";
			emitter.Orientation = Enum.ParticleOrientation.VelocityPerpendicular;
			emitter.Rotation = NumberRange.new(0, 360);
			keep(emitter, halo);
		end;
	end;

	local function createTornado(character)
		local hrp = part(character, "HumanoidRootPart");

		if not hrp then return end;

		local base = anchor(hrp, CFrame.new(0, -3, 0));

		local funnel = Instance.new("ParticleEmitter");
		funnel.LightInfluence = 1;
		funnel.LockedToPart = true;
		funnel.LightEmission = 1;
		funnel.Color = ColorSequence.new(A.Color);
		funnel.Speed = NumberRange.new(0.01, 0.01);
		funnel.Size = NumberSequence.new(6, 10);
		funnel.RotSpeed = NumberRange.new(360, 360);
		funnel.Rate = 1;
		funnel.Texture = "rbxassetid://8553497052";
		funnel.Orientation = Enum.ParticleOrientation.VelocityPerpendicular;
		keep(funnel, base);
	end;

	local loaded = {};

	local function fetchAura(name)
		if loaded[name] ~= nil then return loaded[name] or nil end;

		local id = CATALOGUE[name];

		if not id then return nil end;

		local ok, objects = pcall(game.GetObjects, game, "rbxassetid://" .. id);
		local source = (ok and type(objects) == "table") and objects[1] or nil;

		loaded[name] = source or false;

		return source;
	end;

	local function slotFor(character, name)
		local direct = character:FindFirstChild(name, true);

		if direct and direct:IsA("BasePart") then return direct end;

		for _, alias in ipairs(GROUP_OF[name] or {}) do
			local found = character:FindFirstChild(alias, true);

			if found and found:IsA("BasePart") then return found end;
		end;

		return nil;
	end;

	local function createCatalogue(name)
		return function(character)
			local source = fetchAura(name);

			if not source then return end;

			local clone = source:Clone();

			for _, group in ipairs(clone:GetChildren()) do
				local target = slotFor(character, group.Name);

				if target then
					for _, child in ipairs(group:GetChildren()) do
						child.Parent = target;

						borrowed[#borrowed + 1] = child;

						if child:IsA("ParticleEmitter") then
							particles[#particles + 1] = {
								emitter = child,
								rate = child.Rate,
								bright = child.Brightness,
								size = child.Size,
							};
						end;
					end;
				end;
			end;

			clone:Destroy();
		end;
	end;

	local BUILDERS = {
		Angelic = createAngelic,
		Ambient = createAmbient,
		Nimb = createNimb,
		Tornado = createTornado,
	};

	for name in pairs(CATALOGUE) do BUILDERS[name] = createCatalogue(name) end;

	local function refreshAuras()
		clearAll();

		if not (ALIVE and A.On) then return end;

		local character = LocalPlayer.Character;

		if not character then return end;

		for _, name in ipairs(ORDER) do
			if A.Types[name] then
				local build = BUILDERS[name];

				if build then pcall(build, character) end;
			end;
		end;

		tune();
	end;

	local function onCharacterAdded()
		if not A.On then return end;

		task.wait(0.5);

		if ALIVE and A.On then refreshAuras() end;
	end;

	local function setEnabled(value)
		A.On = value and true or false;

		if A.On then
			if not charConnection then
				charConnection = NeverLose:AddSignal(LocalPlayer.CharacterAdded:Connect(onCharacterAdded));
			end;

			if LocalPlayer.Character then
				task.spawn(function()
					task.wait(0.2);

					if ALIVE and A.On then refreshAuras() end;
				end);
			end;
		else
			if charConnection then
				pcall(function() charConnection:Disconnect() end);

				charConnection = nil;
			end;

			clearAll();
		end;
	end;

	ESP.AuraSource = function()
		return LocalPlayer.Character;
	end;

	local function refreshPreview()
		if Preview and Preview.ReadAura then pcall(Preview.ReadAura) end;
	end;

	local row = Sections.Aura:AddLabel("Aura");

	row:AddToggle({
		Name = "Aura",
		Default = false,
		Flag = "aura",
		Callback = function(v) setEnabled(v); refreshPreview() end,
	});

	row:AddColorPicker({
		Default = A.Color,
		Flag = "aura_color",
		Callback = function(v)
			A.Color = v;

			tune();
			refreshPreview();
		end,
	});

	Sections.Aura:AddLabel("Types"):AddDropdown({
		Default = { "Angelic" },
		Values = ORDER,
		Multi = true,
		Flag = "aura_types",
		Callback = function(v)
			local picked = {};

			if type(v) == "table" then
				for key, value in pairs(v) do

					if type(key) == "string" and value then
						picked[key] = true;
					elseif type(value) == "string" then
						picked[value] = true;
					end;
				end;
			elseif type(v) == "string" then
				picked[v] = true;
			end;

			A.Types = picked;
			A.Type = nil;

			for _, name in ipairs(ORDER) do
				if picked[name] then A.Type = name; break end;
			end;

			A.Type = A.Type or "Angelic";

			refreshAuras();
			refreshPreview();
		end,
	});

	for _, setting in ipairs({
		{ "Glow", "Glow", "aura_glow", 0, 600, 200, 100 },
		{ "Rate", "Rate", "aura_rate", 10, 400, 100, 100 },
		{ "Size", "Size", "aura_size", 25, 300, 100, 100 },
	}) do
		local key, divisor = setting[2], setting[7];

		Sections.Aura:AddLabel(setting[1]):AddSlider({
			Min = setting[4], Max = setting[5], Default = setting[6],
			Rounding = 0, Size = 90, Flag = setting[3],
			Callback = function(v)
				A[key] = v / divisor;

				tune();
				refreshPreview();
			end,
		});
	end;

	ESP.ClearAura = onUnload("aura", function()
		A.On = false;

		if charConnection then
			pcall(function() charConnection:Disconnect() end);

			charConnection = nil;
		end;

		clearAll();
	end);
end);

guard("motiongraph", function()
	local MG = { On = false };

	ESP.MotionGraph = MG;

		local run = RunService
		local ws  = workspace
		local lp  = LocalPlayer

		local mg_on = false
		local mg_color = Color3.fromRGB(242, 242, 242)
		local mg_width = 280
		local mg_height = 72
		local mg_offset = 105
		local mg_thickness = 1
		local mg_span = 2.8
		local mg_step = 1 / 45
		local mg_accum = 0
		local mg_smooth = 0
		local mg_history = {}
		local mg_lines = {}
		local mg_shadows = {}
		local mg_labels = {}
		local mg_current = nil
		local mg_conn = nil

		local function mg_remove(obj)
			destroyAny(obj)
		end

		local function mg_speed()
			local char = lp.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			if not root then return 0 end
			local velocity = root.AssemblyLinearVelocity
			return Vector3.new(velocity.X, 0, velocity.Z).Magnitude
		end

		local function mg_reference()
			local char = lp.Character
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			return math.max(1, hum and hum.WalkSpeed or 16)
		end

		local function mg_new_line(color, thickness, zindex, transparency)
			local line = Drawing.new("Line")
			line.Color = color
			line.Thickness = thickness
			line.Transparency = transparency
			line.ZIndex = zindex
			line.Visible = false
			return line
		end

		local function mg_new_text()
			local text = Drawing.new("Text")
			text.Center = true
			text.Outline = true
			text.Color = mg_color
			text.Size = 12
			text.ZIndex = 904
			text.Visible = false
			return text
		end

		local function mg_sync_pool(needed)
			while #mg_lines < needed do
				mg_shadows[#mg_shadows + 1] = mg_new_line(Color3.new(0, 0, 0), mg_thickness + 2, 901, 0.45)
				mg_lines[#mg_lines + 1] = mg_new_line(mg_color, mg_thickness, 902, 1)
			end
			while #mg_lines > needed do
				mg_remove(table.remove(mg_lines))
				mg_remove(table.remove(mg_shadows))
			end
		end

		local function mg_create()
			if mg_current then return end
			mg_current = mg_new_text()
			mg_current.Center = false
			for i = 1, 6 do
				mg_labels[i] = mg_new_text()
			end
		end

		local function mg_hide()
			if mg_current then mg_current.Visible = false end
			for i = 1, #mg_lines do
				mg_lines[i].Visible = false
				mg_shadows[i].Visible = false
			end
			for i = 1, #mg_labels do
				mg_labels[i].Visible = false
			end
		end

		local function mg_clear()
			if mg_conn then
				pcall(function() mg_conn:Disconnect() end)
				mg_conn = nil
			end
			mg_remove(mg_current)
			mg_current = nil
			for i = 1, #mg_lines do
				mg_remove(mg_lines[i])
				mg_remove(mg_shadows[i])
			end
			for i = 1, #mg_labels do
				mg_remove(mg_labels[i])
			end
			table.clear(mg_lines)
			table.clear(mg_shadows)
			table.clear(mg_labels)
			table.clear(mg_history)
			mg_accum = 0
		end

		local function mg_reset_history()
			table.clear(mg_history)
			local now = os.clock()
			local speed = mg_speed()
			mg_smooth = speed
			local count = math.ceil(mg_span / mg_step)
			for i = 0, count do
				mg_history[#mg_history + 1] = {
					t = now - mg_span + i * mg_step,
					v = speed
				}
			end
			mg_sync_pool(#mg_history)
		end

		local function mg_apply_style()
			if mg_current then mg_current.Color = mg_color end
			for i = 1, #mg_lines do
				mg_lines[i].Color = mg_color
				mg_lines[i].Thickness = mg_thickness
				mg_shadows[i].Thickness = mg_thickness + 2
			end
			for i = 1, #mg_labels do
				mg_labels[i].Color = mg_color
			end
		end

		local function mg_y(value, center, height, reference)
			local normalized = math.clamp(value / reference - 1, -1, 1)
			return center - normalized * height * 0.44
		end

		local function mg_render(now)
			local camera = ws.CurrentCamera
			if not mg_on or not camera or #mg_history < 2 then
				mg_hide()
				return
			end
			local viewport = camera.ViewportSize
			local width = math.min(mg_width, math.max(120, viewport.X - 48))
			local height = math.min(mg_height, math.max(36, viewport.Y - 32))
			local left = math.floor(viewport.X * 0.5 - width * 0.5)
			local center = math.clamp(math.floor(viewport.Y * 0.5 + mg_offset), height * 0.5 + 8, viewport.Y - height * 0.5 - 8)
			local reference = mg_reference()
			local start_time = now - mg_span
			local count = #mg_history
			mg_sync_pool(count)
			for i = 1, count - 1 do
				local a = mg_history[i]
				local b = mg_history[i + 1]
				local ap = math.clamp((a.t - start_time) / mg_span, 0, 1)
				local bp = math.clamp((b.t - start_time) / mg_span, 0, 1)
				local fade = math.clamp(math.min((ap + bp) * 6, (2 - ap - bp) * 5), 0, 1)
				local from = Vector2.new(left + ap * width, mg_y(a.v, center, height, reference))
				local to = Vector2.new(left + bp * width, mg_y(b.v, center, height, reference))
				local line = mg_lines[i]
				local shadow = mg_shadows[i]
				line.From, line.To = from, to
				line.Transparency = fade
				line.Visible = fade > 0.02
				shadow.From, shadow.To = from, to
				shadow.Transparency = fade * 0.42
				shadow.Visible = fade > 0.02
			end
			local last = mg_history[count]
			local lpct = math.clamp((last.t - start_time) / mg_span, 0, 1)
			local from = Vector2.new(left + lpct * width, mg_y(last.v, center, height, reference))
			local to = Vector2.new(left + width, mg_y(mg_smooth, center, height, reference))
			local tail = mg_lines[count]
			local tail_shadow = mg_shadows[count]
			tail.From, tail.To = from, to
			tail.Transparency = 0.72
			tail.Visible = true
			tail_shadow.From, tail_shadow.To = from, to
			tail_shadow.Transparency = 0.3
			tail_shadow.Visible = true
			for i = count + 1, #mg_lines do
				mg_lines[i].Visible = false
				mg_shadows[i].Visible = false
			end
			mg_current.Text = tostring(math.floor(mg_smooth + 0.5))
			mg_current.Position = Vector2.new(left + width + 5, to.Y - 7)
			mg_current.Color = mg_color
			mg_current.Visible = true
			while #mg_labels < 12 do
				mg_labels[#mg_labels + 1] = mg_new_text()
			end
			local threshold = math.max(0.8, reference * 0.08)
			local min_label_gap = 0.42
			for i = 5, count - 4 do
				local point = mg_history[i]
				if not point.checked then
					point.checked = true
					local before = point.v - mg_history[i - 4].v
					local after = mg_history[i + 4].v - point.v
					if math.abs(before) >= threshold and (before * after <= 0 or math.abs(after) < threshold * 0.35) then
						local nearby = nil
						for j = i - 1, 1, -1 do
							local previous = mg_history[j]
							if point.t - previous.t > min_label_gap then break end
							if previous.label ~= nil then
								nearby = previous
								break
							end
						end
						local score = math.abs(before) - math.abs(after)
						if not nearby then
							point.label = math.floor(point.v + 0.5)
							point.label_score = score
						elseif score > (nearby.label_score or -math.huge) then
							nearby.label = nil
							nearby.label_score = nil
							point.label = math.floor(point.v + 0.5)
							point.label_score = score
						end
					end
				end
			end
			for i = 1, #mg_labels do
				mg_labels[i].Visible = false
			end
			local placed = {}
			local label_count = 0
			for i = count, 1, -1 do
				local point = mg_history[i]
				if point.label ~= nil and label_count < #mg_labels then
					local pct = (point.t - start_time) / mg_span
					if pct > 0.04 and pct < 0.82 then
						local value = tostring(point.label)
						local x = left + pct * width
						local y = mg_y(point.v, center, height, reference) - 15
						local half_width = math.max(8, #value * 3.5 + 2)
						local blocked = false
						for j = 1, #placed do
							local other = placed[j]
							if x + half_width + 5 > other.x1 and x - half_width - 5 < other.x2 and y + 13 > other.y1 and y - 3 < other.y2 then
								blocked = true
								break
							end
						end
						if not blocked then
							label_count = label_count + 1
							local text = mg_labels[label_count]
							text.Text = value
							text.Position = Vector2.new(x, y)
							text.Color = mg_color
							text.Visible = true
							placed[#placed + 1] = {
								x1 = x - half_width,
								x2 = x + half_width,
								y1 = y - 3,
								y2 = y + 13
							}
						end
					end
				end
			end
		end

		mg_offset = 180

		local function mg_start()
			mg_clear()
			mg_create()
			mg_reset_history()
			mg_apply_style()
			mg_conn = run.RenderStepped:Connect(function(dt)
				if not ALIVE or not mg_on then
					mg_hide()
					return
				end
				local raw = mg_speed()
				mg_smooth = mg_smooth + (raw - mg_smooth) * (1 - math.exp(-dt * 18))
				mg_accum = mg_accum + dt
				local now = os.clock()
				if mg_accum >= mg_step then
					mg_accum = mg_accum % mg_step
					mg_history[#mg_history + 1] = { t = now, v = mg_smooth }
					local cutoff = now - mg_span
					while #mg_history > 2 and mg_history[2].t < cutoff do
						table.remove(mg_history, 1)
					end
				end
				mg_render(now)
			end)
		end

		MG.On = false
		MG.Color     = mg_color
		MG.Width     = mg_width
		MG.Height    = mg_height
		MG.Thickness = mg_thickness
		MG.OffsetY   = mg_offset

		ESP.MotionGraphSet = { set = function(k, v)
			if k == "color" then
				mg_color = v
				mg_apply_style()
			elseif k == "width" then
				mg_width = v
			elseif k == "height" then
				mg_height = v
			elseif k == "y" then
				mg_offset = v
			elseif k == "thickness" then
				mg_thickness = v
				mg_apply_style()
			end
		end }

		ESP.StartMotionGraph = function()
			mg_on = true
			MG.On = true
			mg_start()
		end

		ESP.ClearMotionGraph = function()
			mg_on = false
			MG.On = false
			mg_clear()
		end

		ESP.MotionGraphStyle = mg_apply_style

		NeverLose:AddSignal(lp.CharacterAdded:Connect(function()
			task.wait(0.4)
			if ALIVE and mg_on then mg_reset_history() end
		end))

	local row = Sections.Screen:AddLabel("Motion Graph");
	row:AddToggle({
		Default = false, Flag = "motion_graph",
		Callback = function(v)
			if v then ESP.StartMotionGraph() else ESP.ClearMotionGraph() end;
		end,
	});
	row:AddColorPicker({
		Default = MG.Color, Flag = "motion_graph_color",
		Callback = function(v) ESP.MotionGraphSet.set("color", v) end,
	});

	local options = row:AddOption(1);

	options:AddLabel("Width"):AddSlider({
		Min = 120, Max = 600, Default = 280, Rounding = 0, Size = 90,
		Flag = "motion_graph_width",
		Callback = function(v) ESP.MotionGraphSet.set("width", v) end,
	});

	options:AddLabel("Height"):AddSlider({
		Min = 30, Max = 200, Default = 72, Rounding = 0, Size = 90,
		Flag = "motion_graph_height",
		Callback = function(v) ESP.MotionGraphSet.set("height", v) end,
	});

	options:AddLabel("Offset"):AddSlider({
		Min = 40, Max = 400, Default = 180, Rounding = 0, Size = 90,
		Flag = "motion_graph_offset",
		Callback = function(v) ESP.MotionGraphSet.set("y", v) end,
	});

	options:AddLabel("Thickness"):AddSlider({
		Min = 1, Max = 5, Default = 1, Rounding = 0, Size = 90,
		Flag = "motion_graph_thickness",
		Callback = function(v) ESP.MotionGraphSet.set("thickness", v) end,
	});
end);

guard("backtrack", function()
	local BT = {
		On = false,
		Style = "ForceField",
		Delay = 120,
		Color = Color3.fromRGB(120, 200, 255),
		Transparency = 45,
		Target = "Other",
		Outline = Color3.fromRGB(255, 255, 255),
		OutlineTransparency = 10,
		OutlineOn = true,
	};

	BT.ChamsMaterial = BT.Style;
	BT.ChamsOutline = BT.Outline;
	BT.ChamsOutlineTransparency = BT.OutlineTransparency;

	ESP.Backtrack = BT;

	local order = ESP.MaterialOrder;

	if type(order) ~= "table" or #order == 0 then
		order = {};

		for name in pairs(ESP.MaterialStyles or {}) do order[#order + 1] = name end;

		table.sort(order);
	end;

	local row = Sections.Chams:AddLabel("Backtrack");
	row:AddToggle({
		Default = false, Flag = "backtrack",
		Callback = function(v)
			BT.On = v;

			if not v and ESP.ClearBacktrackChams then ESP.ClearBacktrackChams() end;
		end,
	});
	row:AddColorPicker({ Default = BT.Color, Flag = "backtrack_color", Callback = function(v) BT.Color = v end });

	local options = row:AddOption(1);

	options:AddLabel("Style"):AddDropdown({
		Default = "ForceField",
		Values = order,
		Flag = "backtrack_style",
		Callback = function(v)
			BT.Style, BT.ChamsMaterial = v, v;

			if ESP.ClearBacktrackChams then ESP.ClearBacktrackChams() end;
		end,
	});

	options:AddLabel("Target"):AddDropdown({
		Default = "Other", Values = { "Self", "Other", "All" }, Flag = "backtrack_target",
		Callback = function(v)
			BT.Target = v;

			if ESP.ClearBacktrackChams then ESP.ClearBacktrackChams() end;
		end,
	});

	options:AddLabel("Delay"):AddSlider({
		Min = 20, Max = 800, Default = 120, Type = "ms", Rounding = 0, Size = 90,
		Flag = "backtrack_delay",
		Callback = function(v) BT.Delay = v end,
	});

	options:AddLabel("Fade"):AddSlider({
		Min = 0, Max = 90, Default = 45, Type = "%", Size = 90,
		Flag = "backtrack_fade",
		Callback = function(v) BT.Transparency = v end,
	});

	local outlineRow = options:AddLabel("Outline");
	outlineRow:AddToggle({
		Default = true, Flag = "backtrack_outline_on",
		Callback = function(v) BT.OutlineOn = v end,
	});
	outlineRow:AddColorPicker({
		Default = BT.Outline, Flag = "backtrack_outline",
		Callback = function(v) BT.Outline, BT.ChamsOutline = v, v end,
	});

	options:AddLabel("Outline Opacity"):AddSlider({
		Min = 0, Max = 100, Default = 90, Type = "%", Size = 90,
		Flag = "backtrack_outline_opacity",
		Callback = function(v)
			BT.OutlineTransparency = 100 - v;
			BT.ChamsOutlineTransparency = BT.OutlineTransparency;
		end,
	});
end);

guard("backtrack_chams", function()
	local BT = ESP.Backtrack;
	local states, timer = {}, 0;
	local SAMPLE_STEP = 1 / 30;

	local present = {};

	local function clear(player)
		local state = states[player];
		if not state then return end;
		if state.model then state.model:Destroy() end;
		states[player] = nil;
	end;

	local function clearAll()
		while next(states) do clear(next(states)) end;
	end;

	local function selected(player)
		return BT.On and (BT.Target == "All" or (BT.Target == "Self" and player == LocalPlayer) or (BT.Target == "Other" and player ~= LocalPlayer));
	end;

	local function groupParts(model)
		local groups = {};
		for _, descendant in ipairs(model:GetDescendants()) do
			if descendant:IsA("BasePart") then
				groups[descendant.Name] = groups[descendant.Name] or {};
				table.insert(groups[descendant.Name], descendant);
			end;
		end;
		return groups;
	end;

	local function buildModel(state)
		if state.model and state.model.Parent then return true end;
		local character = state.character;
		local archivable = character.Archivable;
		pcall(function() character.Archivable = true end);
		local ok, model = pcall(character.Clone, character);
		pcall(function() character.Archivable = archivable end);
		if not ok or not model then return false end;

		for _, descendant in ipairs(model:GetDescendants()) do
			if descendant:IsA("BasePart") then
				descendant.Anchored = true;
				descendant.CanCollide = false;
				descendant.CanTouch = false;
				descendant.CanQuery = false;
				descendant.CastShadow = false;
				descendant.Transparency = 1;
			elseif descendant:IsA("Humanoid") or descendant:IsA("BaseScript") or descendant:IsA("Sound")
				or descendant:IsA("Decal") or descendant:IsA("Texture") or descendant:IsA("ParticleEmitter")
				or descendant:IsA("Trail") or descendant:IsA("Beam") or descendant:IsA("Light")
				or descendant:IsA("Highlight") or descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") then
				descendant:Destroy();
			end;
		end;

		local sourceGroups = groupParts(character);
		local cloneGroups = groupParts(model);
		local links = {};
		for name, sources in pairs(sourceGroups) do
			local clones = cloneGroups[name] or {};
			for index, source in ipairs(sources) do
				local clone = clones[index];
				if clone and source.Name ~= "HumanoidRootPart" and source.Transparency < 1 then
					links[#links + 1] = { source = source, clone = clone, baseTransparency = source.Transparency };
				end;
			end;
		end;

		local highlight = Instance.new("Highlight");
		highlight.Name = "BacktrackPlayerChams";
		highlight.Adornee = model;
		highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
		highlight.Parent = model;

		model.Name = NeverLose.RandomString();
		model:SetAttribute(TAG, true);
		model.Parent = workspace;
		state.model, state.links, state.highlight = model, links, highlight;
		return true;
	end;

	local function ensure(player, character)
		local state = states[player];
		if state and state.character == character then return state end;
		clear(player);
		state = { character = character, history = {} };
		states[player] = state;
		return state;
	end;

	local function snapshot(state, root, now)
		local pose = {};
		for index, link in ipairs(state.links or {}) do
			if link.source.Parent then pose[index] = link.source.CFrame end;
		end;
		state.history[#state.history + 1] = { t = now, root = root.CFrame, pose = pose };
		local keep = math.max(1.05, BT.Delay / 1000 + 0.2);
		while #state.history > 2 and state.history[2].t < now - keep do table.remove(state.history, 1) end;
	end;

	local function delayedPose(history, target)
		if #history == 0 then return nil end;
		local before, after = history[1], history[1];
		for index = 2, #history do
			local sample = history[index];
			if sample.t >= target then
				before, after = history[index - 1], sample;
				break;
			end;
			before, after = sample, sample;
		end;
		local alpha = before == after and 0 or math.clamp((target - before.t) / math.max(after.t - before.t, 0.00001), 0, 1);
		return before, after, alpha;
	end;

	local function renderChams(state, before, after, alpha)
		if not buildModel(state) then return end;
		local style = ESP.MaterialStyles[BT.ChamsMaterial] or ESP.MaterialStyles.ForceField;
		local userFade = math.clamp(BT.Transparency / 100, 0, 1);
		local styleFade = math.clamp(style.transparency or 0, 0, 1);
		for index, link in ipairs(state.links) do
			local first = before.pose[index];
			local second = after.pose[index] or first;
			if first and link.clone.Parent then
				link.clone.CFrame = first:Lerp(second, alpha);
				link.clone.Material = style.material or Enum.Material.ForceField;
				link.clone.Reflectance = style.reflectance or 0;
				link.clone.Color = BT.Color;
				link.clone.Transparency = 1 - (1 - link.baseTransparency) * (1 - userFade) * (1 - styleFade);
			end;
		end;
		local highlight = state.highlight;
		if highlight then
			highlight.Enabled = true;
			highlight.FillColor = BT.Color;
			highlight.FillTransparency = userFade;
			highlight.OutlineColor = BT.ChamsOutline;
			highlight.OutlineTransparency = BT.OutlineOn and math.clamp(BT.ChamsOutlineTransparency / 100, 0, 1) or 1;
		end;
	end;

	local function hideChams(state)
		if state.highlight then state.highlight.Enabled = false end;
		for _, link in ipairs(state.links or {}) do link.clone.Transparency = 1 end;
	end;

	NeverLose:AddSignal(Players.PlayerRemoving:Connect(clear));
	NeverLose:AddSignal(RunService.RenderStepped:Connect(function(dt)
		if not ALIVE then return end;
		timer = timer + dt;
		local sampleNow = timer >= SAMPLE_STEP;
		if sampleNow then timer = timer % SAMPLE_STEP end;
		local now = os.clock();

		table.clear(present);

		for _, player in ipairs(Players:GetPlayers()) do
			present[player] = true;
			local character = player.Character;
			local root = character and character:FindFirstChild("HumanoidRootPart");
			if selected(player) and character and root then
				local state = ensure(player, character);
				if not state.model or not state.model.Parent then buildModel(state) end;
				if sampleNow or #state.history == 0 then snapshot(state, root, now) end;
				local before, after, alpha = delayedPose(state.history, now - BT.Delay / 1000);
				if before then renderChams(state, before, after, alpha) end;
			elseif states[player] then
				clear(player);
			end;
		end;
		for player in pairs(states) do if not present[player] then clear(player) end end;
	end));
	ESP.ClearBacktrackChams = clearAll;
end);

guard("circles", function()
	local Debris = game:GetService("Debris");

	local C = {
		Jump = false, Land = false,
		Style = "Circle",
		Color = Color3.fromRGB(150, 200, 255),
		Size = 4,
		Life = 0.8,
		Target = "Self",
		Bright = 100,
		Grow = 160,
		Spin = 0,
	};

	local styles = {
		Circle = { file = Remote.file("circles/circle.png") },
		Konchal = { file = Remote.file("circles/konchal.png") },
		Ring = { asset = "rbxassetid://7185003058" },
		Ripple = { file = Remote.file("circles/ripple.png") },
		Neon = { file = Remote.file("circles/neonring.png") },
		Swirl = { file = Remote.file("circles/swirl.png") },
		Star = { file = Remote.file("circles/neonstar.png") },
		Halo = { file = Remote.file("circles/haloring.png") },
		Shatter = { file = Remote.file("circles/shatter.png") },
	};

	local order = { "Circle", "Konchal", "Ring", "Ripple", "Neon", "Swirl", "Star", "Halo", "Shatter" };

	do
		for _, rel in ipairs(Remote.under("circles/")) do
			local file = string.match(rel, "([^/]+)$");
			local name, cols, rows, frames = string.match(file or "", "^(.+)_(%d+)x(%d+)_(%d+)%.png$");

			if name then
				local pretty = (string.gsub(name, "^%l", string.upper));

				styles[pretty] = {
					file = Remote.file(rel),
					cols = tonumber(cols), rows = tonumber(rows), frames = tonumber(frames),
				};

				order[#order + 1] = pretty;
			end;
		end;
	end;

	local function urlFor(style)
		if style.asset then return style.asset end;

		return Remote.id(style.file);
	end;

	local FLIPBOOK = {
		[2] = Enum.ParticleFlipbookLayout.Grid2x2,
		[4] = Enum.ParticleFlipbookLayout.Grid4x4,
		[8] = Enum.ParticleFlipbookLayout.Grid8x8,
	};

	local function groundAt(char, root)
		local params = RaycastParams.new();
		params.FilterType = Enum.RaycastFilterType.Exclude;
		params.FilterDescendantsInstances = { char };
		params.IgnoreWater = true;

		local sum, normal, hits = Vector3.zero, Vector3.zero, 0;

		for _, name in ipairs({ "LeftFoot", "RightFoot", "Left Leg", "Right Leg" }) do
			local foot = char:FindFirstChild(name);

			if foot and foot:IsA("BasePart") then
				local hit = workspace:Raycast(foot.Position + Vector3.new(0, 0.35, 0), Vector3.new(0, -7, 0), params);

				if hit then
					sum = sum + hit.Position;
					normal = normal + hit.Normal;
					hits = hits + 1;
				end;
			end;
		end;

		if hits > 0 then return sum / hits, normal.Unit end;

		local hit = workspace:Raycast(root.Position + Vector3.new(0, 1, 0), Vector3.new(0, -16, 0), params);

		if hit then return hit.Position, hit.Normal end;

		return root.Position - Vector3.new(0, 3, 0), Vector3.yAxis;
	end;

	local function spawnCircle(position, normal)
		local style = styles[C.Style] or styles.Circle;
		local url = urlFor(style);

		if not url then return end;

		local up = normal or Vector3.yAxis;
		local reference = (math.abs(up.Y) > 0.98) and Vector3.xAxis or Vector3.yAxis;
		local right = up:Cross(reference).Unit;
		local front = right:Cross(up).Unit;

		local part = Instance.new("Part");
		part.Name = NeverLose.RandomString();
		part:SetAttribute(TAG, true);
		part.Anchored = true;
		part.CanCollide = false;
		part.CanQuery = false;
		part.CanTouch = false;
		part.CastShadow = false;
		part.Transparency = 1;
		part.Size = Vector3.new(0.2, 0.2, 0.2);
		part.CFrame = CFrame.fromMatrix(position + up * 0.08, right, up, front);
		part.Parent = workspace;

		local attach = Instance.new("Attachment");
		attach.Parent = part;

		local opacity = math.clamp(C.Bright / 100, 0, 1);

		local emitter = Instance.new("ParticleEmitter");
		emitter.Texture = url;
		emitter.Color = ColorSequence.new(C.Color);
		emitter.LightEmission = 1;
		emitter.LightInfluence = 0;
		emitter.Rate = 0;
		emitter.Lifetime = NumberRange.new(C.Life);
		emitter.Speed = NumberRange.new(0.01);
		emitter.Drag = 0;
		emitter.Acceleration = Vector3.zero;
		emitter.VelocityInheritance = 0;
		emitter.EmissionDirection = Enum.NormalId.Top;
		emitter.Rotation = NumberRange.new(0);
		emitter.RotSpeed = NumberRange.new(C.Spin);
		emitter.ZOffset = 0;

		pcall(function() emitter.Orientation = Enum.ParticleOrientation.VelocityPerpendicular end);

		emitter.Size = NumberSequence.new({
			NumberSequenceKeypoint.new(0, C.Size * 0.35),
			NumberSequenceKeypoint.new(0.4, C.Size),
			NumberSequenceKeypoint.new(1, C.Size * C.Grow / 100),
		});

		emitter.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1 - opacity),
			NumberSequenceKeypoint.new(0.6, 1 - opacity * 0.55),
			NumberSequenceKeypoint.new(1, 1),
		});

		if style.frames and FLIPBOOK[style.cols] then
			pcall(function()
				emitter.FlipbookLayout = FLIPBOOK[style.cols];
				emitter.FlipbookMode = Enum.ParticleFlipbookMode.OneShot;
			end);
		end;

		emitter.Parent = attach;
		emitter:Emit(1);

		Debris:AddItem(part, C.Life + 0.4);
	end;

	local function wants(player)
		local isSelf = player == LocalPlayer;

		return C.Target == "All" or (isSelf and C.Target == "Self") or (not isSelf and C.Target == "Other");
	end;

	local state = {};

	local function unhook(player)
		local record = state[player];

		if not record then return end;

		if record.conn then pcall(function() record.conn:Disconnect() end) end;

		state[player] = nil;
	end;

	local function watch(player)
		local function hook(character)
			task.spawn(function()
				local human = character:WaitForChild("Humanoid", 10);
				if not human or not ALIVE then return end;

				unhook(player);

				local record = { conn = nil };

				local floor = human.FloorMaterial;

				record.air = floor == Enum.Material.Air;

				record.conn = human.StateChanged:Connect(function(_, new)
					if not wants(player) then return end;

					local root = character:FindFirstChild("HumanoidRootPart");
					if not root then return end;

					if new == Enum.HumanoidStateType.Jumping then
						if C.Jump then spawnCircle(groundAt(character, root)) end;

						record.air = true;
					elseif new == Enum.HumanoidStateType.Freefall then
						record.air = true;
					elseif new == Enum.HumanoidStateType.Landed and C.Land and record.air then
						spawnCircle(groundAt(character, root));
						record.air = false;
					end;
				end);

				state[player] = record;
			end);
		end;

		if player.Character then hook(player.Character) end;

		NeverLose:AddSignal(player.CharacterAdded:Connect(hook));
	end;

	for _, player in ipairs(Players:GetPlayers()) do watch(player) end;
	NeverLose:AddSignal(Players.PlayerAdded:Connect(watch));
	NeverLose:AddSignal(Players.PlayerRemoving:Connect(unhook));

	ESP.Circles = C;

	ESP.ClearCircles = onUnload("circles", function()
		for player in pairs(state) do unhook(player) end;

		table.clear(state);
	end);

	local jumpRow = Sections.Circles:AddLabel("Jump Circle");
	jumpRow:AddToggle({ Default = false, Flag = "jump_circle", Callback = function(v) C.Jump = v end });
	jumpRow:AddColorPicker({ Default = C.Color, Flag = "circle_color", Callback = function(v) C.Color = v end });

	Sections.Circles:AddLabel("Land Circle"):AddToggle({
		Default = false, Flag = "land_circle",
		Callback = function(v) C.Land = v end,
	});

	Sections.Circles:AddLabel("Style"):AddDropdown({
		Default = "Circle",
		Values = order,
		Flag = "circle_style",
		Callback = function(v) C.Style = v end,
	});

	Sections.Circles:AddLabel("Size"):AddSlider({
		Min = 1, Max = 30, Default = 4, Rounding = 1, Size = 100,
		Flag = "circle_size",
		Callback = function(v) C.Size = v end,
	});

	Sections.Circles:AddLabel("Life"):AddSlider({
		Min = 2, Max = 40, Default = 8, Rounding = 0, Size = 100,
		Flag = "circle_life",
		Callback = function(v) C.Life = v / 10 end,
	});

	Sections.Circles:AddLabel("Grow"):AddSlider({
		Min = 100, Max = 400, Default = 220, Type = "%", Size = 100,
		Flag = "circle_grow",
		Callback = function(v) C.Grow = v end,
	});

	Sections.Circles:AddLabel("Brightness"):AddSlider({
		Min = 10, Max = 100, Default = 100, Type = "%", Size = 100,
		Flag = "circle_bright",
		Callback = function(v) C.Bright = v end,
	});

	Sections.Circles:AddLabel("Spin"):AddSlider({
		Min = 0, Max = 180, Default = 0, Rounding = 0, Size = 100,
		Flag = "circle_spin",
		Callback = function(v) C.Spin = v end,
	});

	Sections.Circles:AddLabel("Target"):AddDropdown({
		Default = "Self",
		Values = { "Self", "Other", "All" },
		Flag = "circle_target",
		Callback = function(v) C.Target = v end,
	});

	Sections.Circles:AddButton({
		Icon = "play-large",
		Name = "Test Circle",
		Callback = function()
			local char = LocalPlayer.Character;
			local root = char and char:FindFirstChild("HumanoidRootPart");

			if root then spawnCircle(groundAt(char, root)) end;
		end,
	});
end);

guard("trail", function()
	local T = {
		On = false,
		Target = "Self",
		Color = Color3.fromRGB(120, 200, 255),
		Color2 = Color3.fromRGB(255, 120, 220),
		Rainbow = false,
		Style = "Bloom",
		Size = 10,
		Life = 0.9,
		Rate = 140,
		Bright = 85,
		Spread = 100,
		Gravity = 100,
		Always = false,
		Speed = 18,
	};

	local PARTICLES = "particles/";
	local TRAILS = "trail/";

	local STYLES = {
		Bloom = { kind = "particle", sprite = { "p_bloom" }, size = 2.04, rate = 34, life = 1.0,
			speed = { 0.4, 1.4 }, spread = 16, rise = 1.6, drag = 3.5, spin = 20, light = 0.85 },
		Glow = { kind = "particle", sprite = { "p_glow", "p_softglow" }, size = 2.40, rate = 26, life = 1.2,
			speed = { 0.2, 1.0 }, spread = 22, rise = 2.2, drag = 4, spin = 12, light = 1 },
		Sparkle = { kind = "particle", sprite = { "p_sparkle" }, size = 1.20, rate = 46, life = 0.8,
			speed = { 1.0, 3.2 }, spread = 45, rise = -2, drag = 2.2, spin = 180, light = 0.9 },
		Stars = { kind = "particle", sprite = { "p_star", "p_starnew" }, size = 1.32, rate = 34, life = 1.1,
			speed = { 0.8, 2.4 }, spread = 38, rise = -1.5, drag = 2, spin = 140, light = 0.55 },
		Fireflies = { kind = "particle", sprite = { "p_firefly" }, size = 0.96, rate = 30, life = 1.8,
			speed = { 0.3, 1.2 }, spread = 60, rise = 1.2, drag = 5, spin = 30, light = 1 },
		Hearts = { kind = "particle", sprite = { "p_heart" }, size = 1.44, rate = 22, life = 1.3,
			speed = { 0.6, 1.8 }, spread = 30, rise = 2.4, drag = 3, spin = 60, light = 0.35 },
		Snow = { kind = "particle", sprite = { "p_snowflake" }, size = 1.20, rate = 30, life = 1.6,
			speed = { 0.3, 1.1 }, spread = 42, rise = -1.8, drag = 3.5, spin = 90, light = 0.4 },
		Petals = { kind = "particle", sprite = { "p_petal1", "p_petal2", "p_petal3", "p_petal4" }, size = 1.08,
			rate = 30, life = 1.7, speed = { 0.5, 1.6 }, spread = 55, rise = -2.4, drag = 2.6, spin = 150, light = 0.2, own = true },
		Leaves = { kind = "particle", sprite = { "p_leaf1", "p_leaf2", "p_leaf3", "p_leaf4" }, size = 1.08,
			rate = 24, life = 1.7, speed = { 0.5, 1.6 }, spread = 55, rise = -2.6, drag = 2.6, spin = 170, light = 0.15, own = true },
		Flowers = { kind = "particle", sprite = { "p_flower1", "p_flower2", "p_flower3", "p_flower4" }, size = 1.08,
			rate = 24, life = 1.6, speed = { 0.5, 1.5 }, spread = 50, rise = -2.2, drag = 2.6, spin = 130, light = 0.2, own = true },
		Flame = { kind = "particle", sprite = { "p_flame1", "p_flame2", "p_flame3", "p_flame4", "p_flame5", "p_flame6", "p_flame7", "p_flame8" },
			size = 1.68, rate = 44, life = 0.7, speed = { 0.3, 1.2 }, spread = 20, rise = 3.5, drag = 2, spin = 40, light = 1, own = true },
		Bubbles = { kind = "particle", sprite = { "p_bubble" }, size = 1.44, rate = 20, life = 1.9,
			speed = { 0.3, 1.0 }, spread = 35, rise = 2.8, drag = 4, spin = 25, light = 0.5 },
		Lightning = { kind = "particle", sprite = { "p_lightning" }, size = 1.44, rate = 28, life = 0.6,
			speed = { 1.4, 3.6 }, spread = 30, rise = 0, drag = 1.5, spin = 220, light = 1 },
		Dash = { kind = "particle", cubes = true, size = 1.20, rate = 50, life = 0.8,
			speed = { 0.6, 2.4 }, spread = 14, rise = -4, drag = 3, spin = 60, light = 0.5 },
		Crowns = { kind = "particle", sprite = { "p_crown" }, size = 1.44, rate = 16, life = 1.4,
			speed = { 0.6, 1.6 }, spread = 28, rise = 2.0, drag = 3, spin = 70, light = 0.3 },

		Embers = { kind = "particle", sprite = { "p_flame1", "p_flame4", "p_flame7" }, size = 0.72,
			rate = 70, life = 1.5, speed = { 0.8, 2.6 }, spread = 24, rise = 5.5, drag = 1.4, spin = 90, light = 1, own = true },
		Smolder = { kind = "particle", sprite = { "p_bloom", "p_softglow" }, size = 3.20,
			rate = 14, life = 2.6, speed = { 0.1, 0.5 }, spread = 70, rise = 1.0, drag = 6, spin = 8, light = 0.45 },
		Halo = { kind = "particle", sprite = { "p_glowboost" }, size = 2.80, rate = 12, life = 1.6,
			speed = { 0.05, 0.3 }, spread = 90, rise = 0.4, drag = 7, spin = 15, light = 1.3 },
		Starfall = { kind = "particle", sprite = { "p_star", "p_starnew", "p_sparkle" }, size = 0.84,
			rate = 60, life = 2.2, speed = { 0.2, 0.9 }, spread = 25, rise = -6, drag = 1.2, spin = 200, light = 0.8 },
		Swarm = { kind = "particle", sprite = { "p_firefly", "p_sparkle" }, size = 0.60, rate = 90,
			life = 1.1, speed = { 1.6, 4.2 }, spread = 120, rise = 0, drag = 2.5, spin = 260, light = 1 },
		Static = { kind = "particle", sprite = { "p_lightning", "p_sparkle" }, size = 0.90, rate = 75,
			life = 0.35, speed = { 2.4, 5.5 }, spread = 75, rise = 0, drag = 0.8, spin = 300, light = 1.2 },
		Frost = { kind = "particle", sprite = { "p_snowflake", "p_sparkle" }, size = 0.78, rate = 55,
			life = 2.4, speed = { 0.2, 0.8 }, spread = 80, rise = -1.0, drag = 5, spin = 60, light = 0.7 },
		Bloomfall = { kind = "particle", sprite = { "p_flower1", "p_flower3", "p_petal2", "p_petal4" },
			size = 0.84, rate = 44, life = 2.8, speed = { 0.2, 0.8 }, spread = 70, rise = -3.2, drag = 3.2, spin = 200, light = 0.2, own = true },
		Confetti = { kind = "particle", sprite = { "p_petal1", "p_petal3", "p_leaf2", "p_leaf4" },
			size = 0.66, rate = 85, life = 1.9, speed = { 1.2, 3.4 }, spread = 140, rise = -2.0, drag = 2, spin = 320, light = 0.3, own = true },
		Reticle = { kind = "particle", sprite = { "p_target" }, size = 2.20, rate = 8, life = 1.2,
			speed = { 0, 0.2 }, spread = 10, rise = 0, drag = 8, spin = 45, light = 0.9 },
		Bloomburst = { kind = "particle", sprite = { "p_bloom", "p_glow", "p_glowboost" }, size = 1.10,
			rate = 100, life = 0.5, speed = { 3.0, 7.0 }, spread = 180, rise = 0, drag = 1, spin = 120, light = 1.4 },
		Soap = { kind = "particle", sprite = { "p_bubble" }, size = 0.72, rate = 60, life = 3.0,
			speed = { 0.1, 0.6 }, spread = 100, rise = 3.6, drag = 6, spin = 20, light = 0.55 },

		Ribbon = { kind = "ribbon", texture = "", light = 1 },
		Comet = { kind = "ribbon", texture = Remote.file(PARTICLES .. "p_glow.png"), local_file = true, light = 2 },
		Beam = { kind = "ribbon", texture = Remote.file("images/WhiteBeam.png"), local_file = true, light = 2.2 },
		Chain = { kind = "ribbon", texture = Remote.file("images/chain.png"), local_file = true, light = 1.4 },
		Smoke = { kind = "ribbon", texture = "rbxasset://textures/particles/smoke_main.dds", light = 0.4 },
	};

	local order = {
		"Bloom", "Glow", "Sparkle", "Stars", "Fireflies", "Hearts", "Snow",
		"Petals", "Leaves", "Flowers", "Flame", "Bubbles", "Lightning", "Dash", "Crowns",
		"Embers", "Smolder", "Halo", "Starfall", "Swarm", "Static", "Frost",
		"Bloomfall", "Confetti", "Reticle", "Bloomburst", "Soap",
		"Ribbon", "Comet", "Beam", "Chain", "Smoke",
	};

	local function customAsset(path)
		return Remote.id(path) or "";
	end;

	local cubics = {};

	pcall(function()
		for _, rel in ipairs(Remote.under("trail/")) do
			local file = string.match(rel, "([^/]+)$") or "";

			if string.match(file, "^dashcubic%d+%.png$") then
				cubics[#cubics + 1] = Remote.file(rel);
			end;
		end;
	end);

	local function textureFor(style)
		if style.cubes then
			if #cubics == 0 then return customAsset(Remote.file(TRAILS .. "bloom.png")) end;

			return customAsset(cubics[math.random(1, #cubics)]);
		end;

		if style.sprite then
			return customAsset(Remote.file(PARTICLES .. style.sprite[math.random(1, #style.sprite)] .. ".png"));
		end;

		if not style.local_file then return style.texture end;

		return customAsset(style.texture);
	end;

	local live = {};

	local function clear(character)
		local entry = live[character];
		if not entry then return end;

		for _, key in ipairs({ "trail", "emitter", "a", "b" }) do
			local part = entry[key];

			if part then pcall(function() part:Destroy() end) end;
		end;

		live[character] = nil;
	end;

	local function clearAll()
		for character in pairs(live) do clear(character) end;
	end;

	local function colors()
		if T.Rainbow then
			local hue = (os.clock() * 0.12) % 1;

			return Color3.fromHSV(hue, 0.85, 1), Color3.fromHSV((hue + 0.22) % 1, 0.85, 1);
		end;

		return T.Color, T.Color2;
	end;

	local function sequenceFor(style)
		if style.own then return ColorSequence.new(Color3.new(1, 1, 1)) end;

		local first, second = colors();

		return ColorSequence.new(first, second);
	end;

	local function sizeFor(style)
		local base = style.size * (T.Size / 10);

		return NumberSequence.new({
			NumberSequenceKeypoint.new(0, base * 0.35),
			NumberSequenceKeypoint.new(0.25, base),
			NumberSequenceKeypoint.new(1, base * 0.1),
		});
	end;

	local function fadeFor()
		local floor = 1 - math.clamp(T.Bright / 100, 0.05, 1);

		return NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.12, floor),
			NumberSequenceKeypoint.new(0.55, floor + (1 - floor) * 0.35),
			NumberSequenceKeypoint.new(1, 1),
		});
	end;

	local function buildParticles(character, root, style)
		local attach = Instance.new("Attachment");
		attach.Name = NeverLose.RandomString();
		attach.Position = Vector3.new(0, -0.9, 0);
		attach.Parent = root;

		local emitter = Instance.new("ParticleEmitter");
		emitter.Name = NeverLose.RandomString();
		emitter.Texture = textureFor(style);
		emitter.LightEmission = style.light;

	emitter.LightInfluence = 0;
		emitter.Enabled = false;
		emitter.Rate = style.rate * (T.Rate / 100);
		emitter.Lifetime = NumberRange.new(T.Life * 0.65, T.Life);
		emitter.Speed = NumberRange.new(style.speed[1], style.speed[2]);
		emitter.SpreadAngle = Vector2.new(style.spread, style.spread) * (T.Spread / 100);
		emitter.Acceleration = Vector3.new(0, style.rise * (T.Gravity / 100), 0);
		emitter.Drag = style.drag;
		emitter.VelocityInheritance = 0.3;
		emitter.EmissionDirection = Enum.NormalId.Back;
		emitter.Rotation = NumberRange.new(0, 360);
		emitter.RotSpeed = NumberRange.new(-style.spin, style.spin);
		emitter.Color = sequenceFor(style);
		emitter.Size = sizeFor(style);
		emitter.Transparency = fadeFor();
		emitter.Parent = attach;

		live[character] = {
			emitter = emitter, a = attach, root = root, style = style,
			swap = 0, size = T.Size, rate = T.Rate, bright = T.Bright,
		};
	end;

	local function buildRibbon(character, root, style)
		local a = Instance.new("Attachment");
		a.Name = NeverLose.RandomString();
		a.Position = Vector3.new(0, T.Size * 0.09, 0);
		a.Parent = root;

		local b = Instance.new("Attachment");
		b.Name = NeverLose.RandomString();
		b.Position = Vector3.new(0, -T.Size * 0.09, 0);
		b.Parent = root;

		local first, second = colors();

		local trail = Instance.new("Trail");
		trail.Name = NeverLose.RandomString();
		trail.Attachment0, trail.Attachment1 = a, b;
		trail.Lifetime = T.Life;
		trail.MinLength = 0.08;
		trail.FaceCamera = true;
		trail.LightEmission = style.light;
		trail.LightInfluence = 0;
		trail.Texture = textureFor(style);
		trail.TextureMode = Enum.TextureMode.Static;
		trail.TextureLength = 4;
		trail.Color = ColorSequence.new(first, second);

		trail.WidthScale = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.5, 0.62),
			NumberSequenceKeypoint.new(1, 0),
		});

		local floor = 1 - math.clamp(T.Bright / 100, 0.05, 1);

		trail.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, floor),
			NumberSequenceKeypoint.new(0.7, floor + (1 - floor) * 0.5),
			NumberSequenceKeypoint.new(1, 1),
		});

		trail.Parent = root;

		live[character] = { trail = trail, a = a, b = b, root = root, style = style, size = T.Size };
	end;

	local function build(character)
		local root = character:FindFirstChild("HumanoidRootPart");
		if not root then return end;

		clear(character);

		local style = STYLES[T.Style] or STYLES.Bloom;

		if style.kind == "ribbon" then
			buildRibbon(character, root, style);
		else
			buildParticles(character, root, style);
		end;
	end;

	local function wants(player)
		if not T.On then return false end;

		local isSelf = player == LocalPlayer;

		return T.Target == "All" or (isSelf and T.Target == "Self") or (not isSelf and T.Target == "Other");
	end;

	local function refresh()
		clearAll();

		if not T.On then return end;

		for _, player in ipairs(Players:GetPlayers()) do
			if wants(player) and player.Character then build(player.Character) end;
		end;
	end;

	NeverLose:AddSignal(RunService.RenderStepped:Connect(function(dt)
		if not NeverLose.ScreenGui.Parent then return end;

		for character, entry in pairs(live) do
			if not entry.root or not entry.root.Parent then
				clear(character);
			elseif entry.emitter then
				if not entry.emitter.Parent then
					clear(character);
				else
					local moving = T.Always or entry.root.AssemblyLinearVelocity.Magnitude > 3;
					local style = entry.style;

					entry.emitter.Enabled = moving;
					entry.emitter.Color = sequenceFor(style);
					entry.emitter.Lifetime = NumberRange.new(T.Life * 0.65, T.Life);

					if entry.size ~= T.Size then
						entry.size = T.Size;
						entry.emitter.Size = sizeFor(style);
					end;

					if entry.rate ~= T.Rate then
						entry.rate = T.Rate;
						entry.emitter.Rate = style.rate * (T.Rate / 100);
					end;

					if entry.bright ~= T.Bright then
						entry.bright = T.Bright;
						entry.emitter.Transparency = fadeFor();
					end;

					if (style.cubes or (style.sprite and #style.sprite > 1)) and moving then
						entry.swap = entry.swap + dt;

						if entry.swap > 0.22 then
							entry.swap = 0;
							entry.emitter.Texture = textureFor(style);
						end;
					end;
				end;
			elseif not entry.trail or not entry.trail.Parent then
				clear(character);
			else
				local first, second = colors();

				entry.trail.Color = ColorSequence.new(first, second);
				entry.trail.Lifetime = T.Life;

				if entry.size ~= T.Size then
					entry.size = T.Size;
					entry.a.Position = Vector3.new(0, T.Size * 0.09, 0);
					entry.b.Position = Vector3.new(0, -T.Size * 0.09, 0);
				end;
			end;
		end;
	end));

	local function watch(player)
		NeverLose:AddSignal(player.CharacterAdded:Connect(function(character)
			if not wants(player) then return end;

			task.delay(1, function()
				if wants(player) and character.Parent then build(character) end;
			end);
		end));
	end;

	for _, player in ipairs(Players:GetPlayers()) do watch(player) end;
	NeverLose:AddSignal(Players.PlayerAdded:Connect(watch));

	ESP.Trail = T;
	ESP.TrailStyles = order;
	ESP.ClearTrail = clearAll;

	local row = Sections.Trail:AddLabel("Enabled");
	row:AddToggle({ Default = false, Flag = "trail", Callback = function(v) T.On = v; refresh() end });
	row:AddColorPicker({ Default = T.Color, Flag = "trail_color", Callback = function(v) T.Color = v end });

	Sections.Trail:AddLabel("Style"):AddDropdown({
		Default = "Bloom",
		Values = order,
		Flag = "trail_style",
		Callback = function(v) T.Style = v; refresh() end,
	});

	Sections.Trail:AddLabel("Target"):AddDropdown({
		Default = "Self",
		Values = { "Self", "Other", "All" },
		Flag = "trail_target",
		Callback = function(v) T.Target = v; refresh() end,
	});

	local fade = Sections.Trail:AddLabel("Fade Color");
	fade:AddColorPicker({ Default = T.Color2, Flag = "trail_color2", Callback = function(v) T.Color2 = v end });

	Sections.Trail:AddLabel("Rainbow"):AddToggle({
		Default = false, Flag = "trail_rainbow",
		Callback = function(v) T.Rainbow = v end,
	});

	local options = Sections.Trail:AddLabel("Tuning"):AddOption(1);

	options:AddLabel("Size"):AddSlider({
		Min = 2, Max = 40, Default = 10, Rounding = 0, Size = 100,
		Flag = "trail_width",
		Callback = function(v) T.Size = v end,
	});

	options:AddLabel("Length"):AddSlider({
		Min = 2, Max = 40, Default = 9, Rounding = 0, Size = 100,
		Flag = "trail_life",
		Callback = function(v) T.Life = v / 10 end,
	});

	options:AddLabel("Density"):AddSlider({
		Min = 10, Max = 300, Default = 140, Type = "%", Size = 100,
		Flag = "trail_rate",
		Callback = function(v) T.Rate = v end,
	});

	options:AddLabel("Brightness"):AddSlider({
		Min = 5, Max = 100, Default = 85, Type = "%", Size = 100,
		Flag = "trail_bright",
		Callback = function(v) T.Bright = v end,
	});

	options:AddLabel("Spread"):AddSlider({
		Min = 0, Max = 250, Default = 100, Type = "%", Size = 100,
		Flag = "trail_spread",
		Callback = function(v) T.Spread = v; refresh() end,
	});

	options:AddLabel("Drift"):AddSlider({
		Min = 0, Max = 250, Default = 100, Type = "%", Size = 100,
		Flag = "trail_gravity",
		Callback = function(v) T.Gravity = v; refresh() end,
	});

	options:AddLabel("Always On"):AddToggle({
		Default = false, Flag = "trail_always",
		Callback = function(v) T.Always = v end,
	});
end);

guard("glyphs", function()
	local G = {
		On = false,
		Count = 18,
		Color = Color3.fromRGB(130, 205, 255),
		Size = 0.55,
		Speed = 14,
		Life = 6,
		Style = "Curve",
		Look = "Plain",
		Range = 90,
		Tail = Color3.fromRGB(150, 90, 255),
		Blend = true,
	};

	local STYLES = { "Drift", "Curve", "Angular" };

	local LINKS = 4;

	local LOOKS = {
		{ name = "Plain" },
		{ name = "Beam", file = "images/WhiteBeam.png" },
		{ name = "Glow", file = "trail/bloom.png" },
		{ name = "Ember", file = "particles/p_bloom.png" },
		{ name = "Spark", file = "particles/p_glow.png", wrap = 6 },
		{ name = "Dashed", file = "trail/dashbloom.png", wrap = 10 },
		{ name = "Chain", file = "images/chain.png", wrap = 8 },
		{ name = "Zigzag", file = "images/zigzag.png", wrap = 12 },
	};

	local LOOK_NAMES = {};

	for _, look in ipairs(LOOKS) do LOOK_NAMES[#LOOK_NAMES + 1] = look.name end;

	ESP.Glyphs = G;

	local FADE = 1.1;
	local MAX = 250;

	local random = Random.new(0x5A11AD);

	local host = Instance.new("Part");

	host.Name = NeverLose.RandomString();
	host.Anchored = true;
	host.CanCollide = false;
	host.CanQuery = false;
	host.CanTouch = false;
	host.Transparency = 1;
	host.Size = Vector3.one;
	host.Locked = true;
	host:SetAttribute(TAG, true);
	host.Parent = workspace;

	local function urlFor(rel)
		return rel and Remote.asset(rel) or "";
	end;

	local function lookOf(name)
		for _, look in ipairs(LOOKS) do
			if look.name == name then return look end;
		end;

		return LOOKS[1];
	end;

	local glyphs = {};

	local NEARSHELL = 0.45;

	local function spawnAt(camera)
		local at = camera.CFrame.Position;

		local turn = random:NextNumber(0, math.pi * 2);

		local rise = random:NextNumber(-0.42, 0.52);
		local flat = math.sqrt(math.max(0.02, 1 - rise * rise));

		local dir = Vector3.new(flat * math.cos(turn), rise, flat * math.sin(turn));

		dir = (dir.Magnitude > 0.001) and dir.Unit or Vector3.zAxis;

		local slice = random:NextNumber(NEARSHELL ^ 3, 1) ^ (1 / 3);

		return at + dir * (G.Range * slice);
	end;

	local function make()
		local nodes, beams = {}, {};

		for i = 1, LINKS + 1 do
			local node = Instance.new("Attachment");

			node.Name = NeverLose.RandomString();
			node.Parent = host;

			nodes[i] = node;
		end;

		for i = 1, LINKS do
			local beam = Instance.new("Beam");

			beam.Attachment0 = nodes[i + 1];
			beam.Attachment1 = nodes[i];
			beam.FaceCamera = true;
			beam.LightInfluence = 0;
			beam.LightEmission = 1;
			beam.Segments = 9;
			beam.TextureSpeed = 0;
			beam.Enabled = false;
			beam.Parent = host;

			beams[i] = beam;
		end;

		return { nodes = nodes, beams = beams, trail = {}, look = nil };
	end;

	local function reseed(glyph, camera, aged)
		glyph.head = spawnAt(camera);

		local drift = Vector3.new(
			random:NextNumber(-1, 1),
			random:NextNumber(-0.35, 0.35),
			random:NextNumber(-1, 1)
		);

		glyph.dir = (drift.Magnitude > 0.001) and drift.Unit or Vector3.zAxis;
		glyph.life = G.Life * random:NextNumber(0.75, 1.3);

		glyph.age = aged and random:NextNumber(0, glyph.life * 0.8) or 0;
		glyph.swirl = random:NextNumber(0.2, 0.7);
		glyph.phase = random:NextNumber(0, 6.283);
		glyph.span = random:NextNumber(0.7, 1.5);

		local axis = Vector3.new(
			random:NextNumber(-1, 1),
			random:NextNumber(-1, 1),
			random:NextNumber(-1, 1)
		);

		glyph.axis = (axis.Magnitude > 0.001) and axis.Unit or Vector3.yAxis;
		glyph.arc = random:NextNumber(0.35, 0.95) * (random:NextInteger(0, 1) == 0 and -1 or 1);
		glyph.hold = random:NextNumber(0.3, 0.8);
		glyph.since = 0;

		local step = (G.Size * 16 * glyph.span) / LINKS;

		for i = 1, LINKS + 1 do
			glyph.trail[i] = glyph.head - glyph.dir * (step * (i - 1));
		end;
	end;

	local function drop(glyph)
		for _, beam in ipairs(glyph.beams) do pcall(function() beam:Destroy() end) end;
		for _, node in ipairs(glyph.nodes) do pcall(function() node:Destroy() end) end;
	end;

	local function clear()
		for _, glyph in ipairs(glyphs) do drop(glyph) end;

		table.clear(glyphs);
	end;

	local function resize(camera)
		local want = math.clamp(math.floor(G.Count), 1, MAX);

		while #glyphs > want do drop(table.remove(glyphs)) end;

		while #glyphs < want do
			local glyph = make();

			reseed(glyph, camera, true);

			glyphs[#glyphs + 1] = glyph;
		end;
	end;

	local function step(dt)
		if not (ALIVE and G.On) then return end;

		local camera = Render.camera();

		if not camera then return end;

		local at = camera.CFrame.Position;

		host.CFrame = CFrame.new(at);

		resize(camera);

		local color = ColorSequence.new(G.Color);
		local width = math.max(G.Size, 0.05);
		local style = G.Style;
		local look = lookOf(G.Look);
		local blend = G.Blend;

		for _, glyph in ipairs(glyphs) do
			glyph.age = glyph.age + dt;

			if glyph.age >= glyph.life or (glyph.head - at).Magnitude > G.Range * 1.6 then
				reseed(glyph, camera, false);
			end;

			if style == "Curve" then

				glyph.dir = CFrame.fromAxisAngle(glyph.axis, glyph.arc * dt):VectorToWorldSpace(glyph.dir);
			elseif style == "Angular" then
				glyph.since = glyph.since + dt;

				if glyph.since >= glyph.hold then
					glyph.since = 0;
					glyph.hold = random:NextNumber(0.3, 0.8);

					local turn = Vector3.new(
						random:NextNumber(-1, 1),
						random:NextNumber(-0.7, 0.7),
						random:NextNumber(-1, 1)
					);

					if turn.Magnitude > 0.001 then
						turn = turn.Unit;

						if turn:Dot(glyph.dir) > 0.4 then
							turn = (turn - glyph.dir * turn:Dot(glyph.dir));
							turn = (turn.Magnitude > 0.001) and turn.Unit or glyph.axis;
						end;

						glyph.dir = turn;
					end;
				end;
			else

				glyph.phase = glyph.phase + dt * glyph.swirl;

				local bend = Vector3.new(
					math.sin(glyph.phase),
					math.sin(glyph.phase * 0.6) * 0.4,
					math.cos(glyph.phase * 0.8)
				);

				local steered = glyph.dir + bend * (dt * 0.9);

				if steered.Magnitude > 0.001 then glyph.dir = steered.Unit end;
			end;

			glyph.head = glyph.head + glyph.dir * (G.Speed * dt);

			local length = width * 16 * glyph.span;
			local reach = length / LINKS;
			local trail = glyph.trail;

			trail[1] = glyph.head;

			for i = 2, LINKS + 1 do
				local gap = trail[i - 1] - trail[i];
				local far = gap.Magnitude;

				if far > reach then
					trail[i] = trail[i] + gap.Unit * (far - reach);
				end;
			end;

			for i = 1, LINKS + 1 do
				local node = glyph.nodes[i];
				local ahead = trail[math.max(1, i - 1)];
				local behind = trail[math.min(LINKS + 1, i + 1)];
				local along = ahead - behind;

				if along.Magnitude > 0.01 then

					local right = along.Unit;
					local side = right:Cross(Vector3.yAxis);

					if side.Magnitude < 0.001 then side = right:Cross(Vector3.xAxis) end;

					node.WorldCFrame = CFrame.fromMatrix(trail[i], right, side.Unit:Cross(right));
				else
					node.WorldPosition = trail[i];
				end;
			end;

			local alpha = math.clamp(
				math.min(glyph.age / FADE, (glyph.life - glyph.age) / FADE, 1), 0, 1);

			for i = 1, LINKS do
				local beam = glyph.beams[i];

				local near = 1 - (i - 1) / LINKS;
				local far = 1 - i / LINKS;

				if glyph.look ~= look.name then
					beam.Texture = urlFor(look.file);
					beam.TextureMode = look.wrap and Enum.TextureMode.Wrap
						or Enum.TextureMode.Stretch;

					if look.wrap then beam.TextureLength = look.wrap end;
				end;

				local bend = reach * 0.34;

				beam.CurveSize0 = bend;
				beam.CurveSize1 = bend;

				beam.Enabled = alpha > 0.01;

				beam.Color = blend
					and ColorSequence.new(G.Tail:Lerp(G.Color, far), G.Tail:Lerp(G.Color, near))
					or color;
				beam.Width0 = math.max(0.02, width * far);
				beam.Width1 = math.max(0.02, width * near);

				beam.Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, math.clamp(1 - alpha * (0.12 + far * 0.88), 0, 1)),
					NumberSequenceKeypoint.new(1, math.clamp(1 - alpha * (0.12 + near * 0.88), 0, 1)),
				});
			end;

			glyph.look = look.name;
		end;
	end;

	NeverLose:AddSignal(RunService.RenderStepped:Connect(step));

	local row = Sections.Glyphs:AddLabel("Streaks");

	row:AddToggle({
		Name = "Streaks",
		Default = false,
		Flag = "glyphs",
		Callback = function(v)
			G.On = v;

			if not v then
				for _, glyph in ipairs(glyphs) do
					for _, beam in ipairs(glyph.beams) do beam.Enabled = false end;
				end;
			end;
		end,
	});

	row:AddColorPicker({
		Default = G.Color,
		Flag = "glyphs_color",
		Callback = function(v) G.Color = v end,
	});

	Sections.Glyphs:AddLabel("Movement"):AddDropdown({
		Default = "Curve",
		Values = STYLES,
		Flag = "glyphs_style",
		Callback = function(v)
			G.Style = v;

			for _, glyph in ipairs(glyphs) do
				glyph.since = 0;
				glyph.hold = random:NextNumber(0.3, 0.8);
			end;
		end,
	});

	local tailRow = Sections.Glyphs:AddLabel("Tail Color");

	tailRow:AddToggle({
		Name = "Tail Color",
		Default = true,
		Flag = "glyphs_blend",
		Callback = function(v) G.Blend = v end,
	});

	tailRow:AddColorPicker({
		Default = G.Tail,
		Flag = "glyphs_tail",
		Callback = function(v) G.Tail = v end,
	});

	Sections.Glyphs:AddLabel("Material"):AddDropdown({
		Default = "Plain",
		Values = LOOK_NAMES,
		Flag = "glyphs_look",
		Callback = function(v) G.Look = v end,
	});

	Sections.Glyphs:AddLabel("Count"):AddSlider({
		Min = 1, Max = MAX, Default = 18, Rounding = 0, Size = 100,
		Flag = "glyphs_count",
		Callback = function(v) G.Count = v end,
	});

	Sections.Glyphs:AddLabel("Spawn Radius"):AddSlider({
		Min = 20, Max = 400, Default = 90, Rounding = 0, Size = 100,
		Flag = "glyphs_range",
		Callback = function(v) G.Range = v end,
	});

	Sections.Glyphs:AddLabel("Size"):AddSlider({
		Min = 10, Max = 200, Default = 55, Rounding = 0, Type = "%", Size = 100,
		Flag = "glyphs_size",
		Callback = function(v) G.Size = v / 100 end,
	});

	Sections.Glyphs:AddLabel("Speed"):AddSlider({
		Min = 2, Max = 60, Default = 14, Rounding = 0, Size = 100,
		Flag = "glyphs_speed",
		Callback = function(v) G.Speed = v end,
	});

	Sections.Glyphs:AddLabel("Lifetime"):AddSlider({
		Min = 2, Max = 20, Default = 6, Rounding = 0, Type = "s", Size = 100,
		Flag = "glyphs_life",
		Callback = function(v) G.Life = v end,
	});

	ESP.ClearGlyphs = onUnload("glyphs", function()
		G.On = false;

		clear();

		pcall(function() host:Destroy() end);
	end);
end);

guard("skins", function()
	local REL = "data/mm2_weapons.json";

	local HttpService = game:GetService("HttpService");
	local RunService = game:GetService("RunService");
	local CollectionService = game:GetService("CollectionService");
	local ReplicatedStorage = game:GetService("ReplicatedStorage");
	local Players = game:GetService("Players");
	local LocalPlayer = Players.LocalPlayer;

	local REVIVE;

	local function tagged(t)
		local kind = t[1];

		if kind == "$v" then return Vector3.new(t[2], t[3], t[4]) end;
		if kind == "$c" then return Color3.fromRGB(t[2], t[3], t[4]) end;
		if kind == "$f" then return CFrame.new(unpack(t, 2)) end;
		if kind == "$a" then return CFrame.Angles(t[2], t[3], t[4]) end;
		if kind == "$v2" then return Vector2.new(t[2], t[3]) end;
		if kind == "$d" then return UDim.new(t[2], t[3]) end;
		if kind == "$d2" then return UDim2.new(t[2], t[3], t[4], t[5]) end;
		if kind == "$nr" then return NumberRange.new(t[2], t[3]) end;
		if kind == "$rc" then return Rect.new(t[2], t[3], t[4], t[5]) end;
		if kind == "$csk" then return ColorSequenceKeypoint.new(t[2], REVIVE(t[3])) end;
		if kind == "$nsk" then return NumberSequenceKeypoint.new(t[2], t[3], t[4]) end;

		if kind == "$cs" or kind == "$ns" then
			local source = t;
			local from = 2;

			if type(t[2]) == "table" and type(t[2][1]) ~= "string" then
				source, from = t[2], 1;
			end;

			local keys = {};

			for index = from, #source do keys[#keys + 1] = REVIVE(source[index]) end;

			local want = (kind == "$cs") and "ColorSequenceKeypoint" or "NumberSequenceKeypoint";

			if #keys == 1 and typeof(keys[1]) ~= want then
				return kind == "$cs" and ColorSequence.new(keys[1]) or NumberSequence.new(keys[1]);
			end;

			return kind == "$cs" and ColorSequence.new(keys) or NumberSequence.new(keys);
		end;
		if kind == "$e" then
			local category = Enum[t[2]];
			return category and category[t[3]] or nil;
		end;

		return nil;
	end;

	function REVIVE(value)
		if type(value) ~= "table" then return value end;

		local head = value[1];

		if type(head) == "string" and string.sub(head, 1, 1) == "$" then
			local built = tagged(value);

			if built ~= nil then return built end;
		end;

		for key, item in pairs(value) do value[key] = REVIVE(item) end;

		return value;
	end;

	if not Remote.ensure(REL) then
		warn("[visuals] weapon data missing: " .. REL);

		return;
	end;

	local decoded;

	do
		local function readTable()
			local body = Remote.body(REL);

			local ok, result = pcall(function()
				return HttpService:JSONDecode(body);
			end);

			return ok and type(result) == "table" and result or nil;
		end;

		decoded = readTable();

		if not decoded and Remote.repair(REL) then
			decoded = readTable();
		end;

		if not decoded then
			warn("[visuals] weapon data unreadable and could not be refetched");

			return;
		end;
	end;

	local MESHES = REVIVE(decoded);

	local ProfileData, EquipService;

	do
		local services = ReplicatedStorage:FindFirstChild("ClientServices");
		local modules = ReplicatedStorage:FindFirstChild("Modules");

		pcall(function()
			ProfileData = require(modules:WaitForChild("ProfileData", 5));
			EquipService = require(services:WaitForChild("EquipService", 5));
		end);
	end;

	local INGAME = ProfileData ~= nil;

	local function trimAsset(value)
		if type(value) == "string" then
			return (string.gsub(string.gsub(value, "^%s+", ""), "%s+$", ""));
		end;

		return value;
	end;

	local function applyProps(instance, props, skip)
		for key, value in pairs(props or {}) do
			if not (skip and skip[key]) then
				if key == "MeshId" or key == "TextureId" or key == "TextureID" or key == "Texture" then
					value = trimAsset(value);
				end;

				pcall(function() instance[key] = value end);
			end;
		end;
	end;

	local function createMeshPart(props)
		local meshId = trimAsset(props.MeshId or "");
		local size = props.Size or Vector3.new(1, 1, 1);
		local part;

		pcall(function()
			part = game:GetService("InsertService"):CreateMeshPartAsync(
				meshId, Enum.CollisionFidelity.Box, Enum.RenderFidelity.Precise);
		end);

		if part then
			pcall(function() part.Size = size end);

			return part;
		end;

		local fallback = Instance.new("Part");

		fallback.Size = size;

		local mesh = Instance.new("SpecialMesh");

		mesh.MeshType = Enum.MeshType.FileMesh;

		pcall(function() mesh.MeshId = meshId end);
		pcall(function() mesh.TextureId = trimAsset(props.TextureID or props.TextureId or "") end);

		mesh.Parent = fallback;

		return fallback;
	end;

	local CHROMA = {
		Color3.fromRGB(255, 0, 0),
		Color3.fromRGB(255, 255, 0),
		Color3.fromRGB(0, 255, 0),
		Color3.fromRGB(0, 255, 255),
		Color3.fromRGB(0, 0, 255),
		Color3.fromRGB(255, 0, 255),
	};

	local CHROMA_FLASH_RATE = 1.8;
	local CHROMA_LAYER = "rbxassetid://18363392181";

	local function chromaColor(at)
		local count = #CHROMA;
		local phase = at % count;
		local index = math.floor(phase);

		return CHROMA[index + 1]:Lerp(CHROMA[((index + 1) % count) + 1], phase - index);
	end;

	local function isChroma(name, data)
		if data.Meta and data.Meta.Chroma == true then return true end;

		return string.sub(name, -6) == "Chroma";
	end;

	local function startChroma(overlay)
		local flash, decals, others = {}, {}, {};
		local tagged = false;

		for _, item in ipairs(overlay:GetDescendants()) do
			local role = item:GetAttribute("MM2Chroma");

			if role then
				tagged = true;

				if role == "part" then
					flash[#flash + 1] = item;
				elseif role == "decal" and item:IsA("Decal") then
					pcall(function() item.Texture = CHROMA_LAYER end);

					decals[#decals + 1] = item;
				elseif role == "fire" then
					others[#others + 1] = item;
				end;
			end;
		end;

		if not tagged then
			for _, item in ipairs(overlay:GetDescendants()) do
				if item:IsA("BasePart") and (item.Material == Enum.Material.Neon or string.find(string.lower(item.Name), "light")) then
					flash[#flash + 1] = item;
				elseif item:IsA("Decal") and string.find(string.lower(item.Name), "chroma") then
					decals[#decals + 1] = item;
				elseif item:IsA("Fire") then
					others[#others + 1] = item;
				end;
			end;

			if #decals == 0 then others[#others + 1] = overlay end;
		end;

		if #flash == 0 and #decals == 0 and #others == 0 then return nil end;

		return RunService.Heartbeat:Connect(function()
			local now = os.clock();
			local color = chromaColor(now);

			for _, item in ipairs(decals) do item.Color3 = color end;

			for _, item in ipairs(others) do
				if item:IsA("Fire") then
					item.Color = color;
				elseif item:IsA("BasePart") then
					item.Color = color;
				end;
			end;

			local step = math.floor(now * CHROMA_FLASH_RATE);

			for index, part in ipairs(flash) do
				part.Color = CHROMA[((step + index - 1) % #CHROMA) + 1];
			end;
		end);
	end;

	local STRUCTURAL = {
		WeldConstraint = true, Weld = true, Motor6D = true, RigidConstraint = true,
		Bone = true, Snap = true, ManualWeld = true, Rotate = true, RotateP = true, RotateV = true,
	};

	local PARTICLE_CLASSES = {
		ParticleEmitter = true, Fire = true, Smoke = true, Sparkles = true,
		PointLight = true, SpotLight = true, SurfaceLight = true,
	};

	local function chromaTag(instance, node)
		if not (instance and node.Tags) then return end;

		for _, name in ipairs(node.Tags) do
			local role = (name == "ChromaPart" and "part")
				or (name == "ChromaDecal" and "decal")
				or (name == "ChromaFire" and "fire") or nil;

			if role then
				pcall(function() instance:SetAttribute("MM2Chroma", role) end);
			end;
		end;
	end;

	local function instantiateNode(node)
		local class = node.Class;

		if STRUCTURAL[class] then return nil end;

		local instance;

		if class == "MeshPart" then
			instance = createMeshPart(node.Props);

			applyProps(instance, node.Props, { MeshId = true, Size = true, RelCF = true, CanCollide = true });
		else
			local ok, made = pcall(Instance.new, class);

			if not ok or not made then return nil end;

			instance = made;

			applyProps(instance, node.Props, { RelCF = true });
		end;

		chromaTag(instance, node);

		return instance;
	end;

	local function rebuildTree(node, parentInstance, root, idToInstance, parts, deferred)
		for _, child in ipairs(node.Children or {}) do
			local instance = instantiateNode(child);

			if not instance then

				rebuildTree(child, parentInstance, root, idToInstance, parts, deferred);
			else
				idToInstance[child.Id] = instance;

				if instance:IsA("BasePart") then
					instance.Anchored, instance.CanCollide, instance.CanQuery, instance.CanTouch, instance.Massless =
						false, false, false, false, true;

					parts[#parts + 1] = { inst = instance, relcf = child.Props and child.Props.RelCF };
					instance.Parent = root;
				elseif instance:IsA("Attachment") then
					if child.Props and child.Props.RelCF then
						pcall(function() instance.CFrame = child.Props.RelCF end);
					end;

					instance.Parent = root;
				elseif instance:IsA("Beam") or instance:IsA("Trail") then
					instance.Parent = parentInstance;

					deferred[#deferred + 1] = { inst = instance, a0 = child.Att0, a1 = child.Att1 };
				else
					instance.Parent = parentInstance;
				end;

				rebuildTree(child, instance, root, idToInstance, parts, deferred);
			end;
		end;
	end;

	local function buildFullOverlay(data)
		local node = data.Model;

		if not node then return nil end;

		local root;

		if node.Class == "MeshPart" then
			root = createMeshPart(node.Props);

			applyProps(root, node.Props, { MeshId = true, Size = true, RelCF = true, CanCollide = true });
		else
			root = Instance.new("Part");

			applyProps(root, node.Props, { RelCF = true, CanCollide = true });
		end;

		chromaTag(root, node);

		root.Anchored, root.CanCollide, root.CanQuery, root.CanTouch, root.Massless =
			false, false, false, false, true;

		local idToInstance = { [node.Id] = root };
		local parts, deferred = {}, {};

		rebuildTree(node, root, root, idToInstance, parts, deferred);

		for _, item in ipairs(deferred) do
			if item.a0 and idToInstance[item.a0] then
				pcall(function() item.inst.Attachment0 = idToInstance[item.a0] end);
			end;

			if item.a1 and idToInstance[item.a1] then
				pcall(function() item.inst.Attachment1 = idToInstance[item.a1] end);
			end;
		end;

		return { root = root, parts = parts };
	end;

	local function buildFlatOverlay(data)
		local root, meshes, decals, effects = nil, {}, {}, {};

		for _, entry in ipairs(data.Display or {}) do
			if entry.Path == "(root)" then
				root = entry;
			elseif entry.Class == "SpecialMesh" then
				meshes[#meshes + 1] = entry;
			elseif entry.Class == "Decal" or entry.Class == "Texture" then
				decals[#decals + 1] = entry;
			elseif PARTICLE_CLASSES[entry.Class] then
				effects[#effects + 1] = entry;
			end;
		end;

		if not root then return nil end;

		if root.Class ~= "MeshPart" and #meshes == 0 and #decals == 0 then return nil end;

		local part;

		if root.Class == "MeshPart" then
			part = createMeshPart(root.Props);

			applyProps(part, root.Props, { MeshId = true, Size = true, CanCollide = true });
		else
			part = Instance.new("Part");
			part.Size = root.Props.Size or Vector3.new(1, 1, 1);

			applyProps(part, root.Props, { Size = true, CanCollide = true });

			for _, entry in ipairs(meshes) do
				local mesh = Instance.new("SpecialMesh");

				mesh.MeshType = Enum.MeshType.FileMesh;

				applyProps(mesh, entry.Props);

				mesh.Parent = part;
			end;
		end;

		part.Anchored, part.CanCollide, part.CanQuery, part.CanTouch, part.Massless =
			false, false, false, false, true;

		for _, entry in ipairs(decals) do
			local decal = Instance.new("Decal");

			applyProps(decal, entry.Props);

			decal.Parent = part;
		end;

		for _, entry in ipairs(effects) do
			local ok, instance = pcall(Instance.new, entry.Class);

			if ok and instance then
				applyProps(instance, entry.Props);

				instance.Parent = part;
			end;
		end;

		return { root = part, parts = {} };
	end;

	local function buildAnyOverlay(data)
		if data.Model then return buildFullOverlay(data) end;
		if data.Display then return buildFlatOverlay(data) end;

		return nil;
	end;

	local function finalizeOverlay(built, targetCF)
		local root = built.root;

		pcall(function() root.CFrame = targetCF end);

		for _, part in ipairs(built.parts) do
			if part.relcf then
				pcall(function() part.inst.CFrame = targetCF * part.relcf end);
			end;

			local weld = Instance.new("WeldConstraint");

			weld.Part0 = part.inst;
			weld.Part1 = root;
			weld.Parent = part.inst;
		end;

		return root;
	end;

	local function targetMeshId(data)
		if data.Model then
			local node = data.Model;

			if node.Class == "MeshPart" then return trimAsset(node.Props.MeshId or "") end;

			for _, child in ipairs(node.Children or {}) do
				if child.Class == "SpecialMesh" then return trimAsset(child.Props.MeshId or "") end;
			end;

			return "";
		end;

		for _, entry in ipairs(data.Display or {}) do
			if entry.Path == "(root)" and entry.Class == "MeshPart" then
				return trimAsset(entry.Props.MeshId or "");
			end;

			if entry.Class == "SpecialMesh" then return trimAsset(entry.Props.MeshId or "") end;
		end;

		return "";
	end;

	local function baseMeshId(base)
		if not base then return "" end;
		if base:IsA("MeshPart") then return trimAsset(base.MeshId or "") end;

		local mesh = base:FindFirstChildWhichIsA("SpecialMesh", true);

		return mesh and trimAsset(mesh.MeshId or "") or "";
	end;

	local function hideInto(list, instance)
		if instance:IsA("BasePart") or instance:IsA("Decal") then
			list[#list + 1] = { inst = instance, prop = "Transparency", val = instance.Transparency };

			pcall(function() instance.Transparency = 1 end);
		elseif instance:IsA("ParticleEmitter") or instance:IsA("Trail") or instance:IsA("Beam")
			or instance:IsA("Fire") or instance:IsA("Smoke") or instance:IsA("Sparkles") then
			list[#list + 1] = { inst = instance, prop = "Enabled", val = instance.Enabled };

			pcall(function() instance.Enabled = false end);
		end;
	end;

	local function restore(hidden)
		for _, entry in ipairs(hidden or {}) do
			pcall(function() entry.inst[entry.prop] = entry.val end);
		end;
	end;

	local alive = true;
	local conns = {};
	local named = {};

	local function keep(connection)
		if connection then conns[#conns + 1] = connection end;

		return connection;
	end;

	local function keepNamed(name, connection)
		if named[name] then pcall(function() named[name]:Disconnect() end) end;

		named[name] = connection;

		return connection;
	end;

	local function currentChar()
		return LocalPlayer.Character;
	end;

	local function displayValue(slot)
		local character = currentChar();

		if not character then return nil end;

		local ref = character:FindFirstChild("DisplayRef" .. slot);

		return ref and ref.Value or nil;
	end;

	local function waitDisplay(slot, timeout)
		local deadline = os.clock() + (timeout or 1);

		while alive and os.clock() < deadline do
			local value = displayValue(slot);

			if value then return value end;

			task.wait(0.05);
		end;

		return displayValue(slot);
	end;

	local state, lastApplied, token = {}, {}, {};

	local function cleanup(slot)
		local current = state[slot];

		if not current then return end;

		state[slot] = nil;

		if current.chroma then pcall(function() current.chroma:Disconnect() end) end;
		if current.overlay then pcall(function() current.overlay:Destroy() end) end;

		restore(current.hidden);
	end;

	local function apply(slot, name)
		if not alive then return end;
		if state[slot] and lastApplied[slot] == name and name ~= nil then return end;

		token[slot] = (token[slot] or 0) + 1;

		local mine = token[slot];

		cleanup(slot);

		local data = name and MESHES[name];

		lastApplied[slot] = name;

		if not data then return end;

		local base = displayValue(slot) or waitDisplay(slot, 1.5);

		if not alive or token[slot] ~= mine then return end;

		if not base then return end;

		if baseMeshId(base) ~= "" and baseMeshId(base) == targetMeshId(data) then return end;

		local hidden = {};

		hideInto(hidden, base);

		for _, item in ipairs(base:GetDescendants()) do hideInto(hidden, item) end;

		local built = buildAnyOverlay(data);

		if not alive or not built or not built.root or token[slot] ~= mine or not base.Parent then
			restore(hidden);

			if built and built.root then built.root:Destroy() end;

			return;
		end;

		finalizeOverlay(built, base.CFrame);

		local overlay = built.root;

		overlay.Parent = base.Parent or base;

		local weld = Instance.new("WeldConstraint");

		weld.Part0 = overlay;
		weld.Part1 = base;
		weld.Parent = overlay;

		state[slot] = {
			overlay = overlay,
			hidden = hidden,
			chroma = isChroma(name, data) and startChroma(overlay) or nil,
		};
	end;

	local toolState = {};

	local function isMine(instance)
		if instance:IsDescendantOf(LocalPlayer) then return true end;

		local character = currentChar();

		return character ~= nil and instance:IsDescendantOf(character);
	end;

	local function unoverlayTool(tool)
		local current = toolState[tool];

		if not current then return end;

		toolState[tool] = nil;

		if current.chroma then pcall(function() current.chroma:Disconnect() end) end;
		if current.overlay then pcall(function() current.overlay:Destroy() end) end;

		restore(current.hidden);
	end;

	local function overlayTool(tool, slot)
		if not alive or toolState[tool] then return end;

		local handle = tool:FindFirstChild("Handle") or tool:WaitForChild("Handle", 5);

		if not (alive and handle) then return end;

		local skin = lastApplied[slot];

		if not skin and ProfileData then
			pcall(function() skin = ProfileData.Weapons.Equipped[slot] end);
		end;

		local data = skin and MESHES[skin];

		if not data then return end;

		local built = buildAnyOverlay(data);

		if not built or not built.root then return end;

		if not (alive and handle.Parent) then
			built.root:Destroy();

			return;
		end;

		local hidden = {};

		hideInto(hidden, handle);

		for _, item in ipairs(handle:GetDescendants()) do hideInto(hidden, item) end;

		finalizeOverlay(built, handle.CFrame);

		local overlay = built.root;

		overlay.Parent = handle;

		local weld = Instance.new("WeldConstraint");

		weld.Part0 = overlay;
		weld.Part1 = handle;
		weld.Parent = overlay;

		toolState[tool] = {
			overlay = overlay,
			hidden = hidden,
			chroma = isChroma(skin, data) and startChroma(overlay) or nil,
		};
	end;

	local function reapplyTools(slot)
		for tool in pairs(toolState) do
			local kind = CollectionService:HasTag(tool, "Weapon_Gun") and "Gun" or "Knife";

			if kind == slot then
				unoverlayTool(tool);

				task.spawn(overlayTool, tool, slot);
			end;
		end;
	end;

	local knives, guns = {}, {};

	local function renderable(data)
		if data.Model then return true end;

		for _, entry in ipairs(data.Display or {}) do
			local class = entry.Class;

			if class == "MeshPart" or class == "SpecialMesh"
				or class == "Decal" or class == "Texture" then
				return true;
			end;
		end;

		return false;
	end;

	for key, data in pairs(MESHES) do
		local meta = data.Meta;

		if renderable(data) then
			local label = (meta and meta.ItemName) or key;
			local id = meta and tonumber(meta.ItemID) or nil;

			if not id and meta and type(meta.Image) == "string" then
				id = tonumber(string.match(meta.Image, "assetId=(%d+)")
					or string.match(meta.Image, "[?&]id=(%d+)")
					or string.match(meta.Image, "rbxassetid://(%d+)"));
			end;

			local row = { name = key, label = label, base = label, id = id };

			if meta and meta.ItemType == "Gun" then
				guns[#guns + 1] = row;
			else
				knives[#knives + 1] = row;
			end;
		end;
	end;

	local function byName(a, b) return string.lower(a.label) < string.lower(b.label) end;

	table.sort(knives, byName);
	table.sort(guns, byName);

	local worn = {};
	local FAVORITES = "Salad Visuals/Config/skin favourites.json";
	local starred = {};

	do
		local ok, body = pcall(function() return readfile(FAVORITES) end);

		if ok and type(body) == "string" then
			local fine, list = pcall(function()
				return game:GetService("HttpService"):JSONDecode(body);
			end);

			if fine and type(list) == "table" then
				for _, key in ipairs(list) do starred[key] = true end;
			end;
		end;
	end;

	local function saveStarred()
		local list = {};

		for key in pairs(starred) do list[#list + 1] = key end;

		table.sort(list);

		pcall(function()
			writefile(FAVORITES, game:GetService("HttpService"):JSONEncode(list));
		end);
	end;

	local function ordered(rows)
		local out = {};

		for _, row in ipairs(rows) do
			out[#out + 1] = {
				name = row.name,
				label = (starred[row.name] and "• " or "") .. row.base,
				id = row.id,
				base = row.base,
			};
		end;

		table.sort(out, function(a, b)
			local sa, sb = starred[a.name] and 1 or 0, starred[b.name] and 1 or 0;

			if sa ~= sb then return sa > sb end;

			return string.lower(a.base) < string.lower(b.base);
		end);

		return out;
	end;

	local grids = {};

	local function wear(slot)
		return function(value)
			local key = (type(value) == "table") and value[1] or value;

			if type(key) ~= "string" or key == "" then return end;
			if not INGAME then return end;

			if worn[slot] == key then
				worn[slot] = nil;

				pcall(apply, slot, nil);

				for tool in pairs(toolState) do unoverlayTool(tool) end;

				return;
			end;

			worn[slot] = key;

			if pcall(apply, slot, key) then
				reapplyTools(slot);
			else
				worn[slot] = nil;
			end;
		end;
	end;

	local function star(slot, rows)
		return function(name)
			if type(name) ~= "string" or name == "" then return end;

			starred[name] = (not starred[name]) or nil;

			saveStarred();

			local grid = grids[slot];

			if grid and grid.setdata then pcall(grid.setdata, grid, ordered(rows)) end;
		end;
	end;

	grids.Knife = Visuals.Skins:AddGallery({
		Name = "Knives", Icon = "sword", Position = "left",
		Height = 430, Cell = 74, Thumb = "Asset", Blank = "sword",
		Empty = "No knives", Values = ordered(knives),
		Flag = "skin_knife", Callback = wear("Knife"), Context = star("Knife", knives),
	});

	grids.Gun = Visuals.Skins:AddGallery({
		Name = "Guns", Icon = "crosshair", Position = "right",
		Height = 430, Cell = 74, Thumb = "Asset", Blank = "crosshair",
		Empty = "No guns", Values = ordered(guns),
		Flag = "skin_gun", Callback = wear("Gun"), Context = star("Gun", guns),
	});

	local function watchCharacter(character)

		keepNamed("char", character.ChildAdded:Connect(function(child)
			local slot = (child.Name == "DisplayRefKnife" and "Knife")
				or (child.Name == "DisplayRefGun" and "Gun") or nil;

			if not slot then return end;

			task.delay(0.2, function()
				local skin = lastApplied[slot];

				if alive and skin then
					cleanup(slot);
					apply(slot, skin);
				end;
			end);
		end));
	end;

	if currentChar() then watchCharacter(currentChar()) end;

	keep(LocalPlayer.CharacterAdded:Connect(function(character)

		for slot in pairs(state) do
			local current = state[slot];

			state[slot] = nil;

			if current.chroma then pcall(function() current.chroma:Disconnect() end) end;
			if current.overlay then pcall(function() current.overlay:Destroy() end) end;
		end;

		for tool in pairs(toolState) do unoverlayTool(tool) end;

		watchCharacter(character);

		task.delay(1, function()
			if not alive then return end;

			for _, slot in ipairs({ "Knife", "Gun" }) do
				if lastApplied[slot] then apply(slot, lastApplied[slot]) end;
			end;
		end);
	end));

	for _, tag in ipairs({ "Weapon_Knife", "Weapon_Gun" }) do
		local slot = (tag == "Weapon_Gun") and "Gun" or "Knife";

		for _, tool in ipairs(CollectionService:GetTagged(tag)) do
			if isMine(tool) then task.spawn(overlayTool, tool, slot) end;
		end;

		keep(CollectionService:GetInstanceAddedSignal(tag):Connect(function(tool)
			if isMine(tool) then task.spawn(overlayTool, tool, slot) end;
		end));

		keep(CollectionService:GetInstanceRemovedSignal(tag):Connect(unoverlayTool));
	end;

	if EquipService then
		pcall(function()
			keep(EquipService.EquippedChanged.Event:Connect(function(kind, name)
				if not alive then return end;

				if (kind == "Knife" or kind == "Gun") and not worn[kind] then
					task.spawn(apply, kind, name);
				end;
			end));
		end);
	end;

	ESP.Skins = {
		MESHES = MESHES,
		apply = apply,
		worn = worn,
		count = #knives + #guns,
		ingame = INGAME,
	};

	ESP.ClearSkins = onUnload("skins", function()
		alive = false;

		for _, connection in ipairs(conns) do pcall(function() connection:Disconnect() end) end;
		for _, connection in pairs(named) do pcall(function() connection:Disconnect() end) end;

		table.clear(conns);
		table.clear(named);

		for slot in pairs(state) do pcall(cleanup, slot) end;
		for tool in pairs(toolState) do pcall(unoverlayTool, tool) end;

		ESP.Skins = nil;
	end);
end);

guard("models", function()

	local STORE = "Salad Visuals/Config/models.txt";

	local BUILTIN = {
		{ Name = "Tung Tung Sahur", Id = "138151705692565" },
	};

	local M = { On = false, Pick = nil };

	ESP.Models = M;

	local defs, order = {}, {};
	local cache = {};
	local generation = 0;
	local shell, follow, charConn = nil, nil, nil;
	local hiddenParts, hiddenDecals = {}, {};
	local grid, status;

	local korblox, headless = false, false;
	local legBackup, headBackup = {}, {};

	local function register(def)
		if defs[def.Name] then return end;

		defs[def.Name] = def;
		order[#order + 1] = def.Name;
	end;

	local function rebuildList()
		table.clear(defs);
		table.clear(order);

		for _, def in ipairs(BUILTIN) do
			register({ Name = def.Name, Id = def.Id, Kind = "asset" });
		end;

		table.sort(order, function(a, b) return string.lower(a) < string.lower(b) end);

		if isfile and readfile and isfile(STORE) then
			local ok, body = pcall(readfile, STORE);

			if ok and type(body) == "string" then
				for line in string.gmatch(body, "[^\r\n]+") do
					local id, name = string.match(line, "^(%d+)|(.*)$");

					if id then
						register({ Name = (name ~= "" and name) or ("Model " .. id), Id = id, Kind = "asset", User = true });
					end;
				end;
			end;
		end;
	end;

	local function saveUsers()
		if not writefile then return end;

		local lines = {};

		for _, name in ipairs(order) do
			local def = defs[name];

			if def and def.User and def.Id then
				lines[#lines + 1] = def.Id .. "|" .. def.Name;
			end;
		end;

		pcall(writefile, STORE, table.concat(lines, "\n"));
	end;

	local function rows()
		local out = {};

		for _, name in ipairs(order) do
			local def = defs[name];

			out[#out + 1] = { name = name, label = name, id = def and def.Id and tonumber(def.Id) or nil };
		end;

		return out;
	end;

	local function refreshGrid()
		if grid and grid.setlist then pcall(function() grid:setlist(rows()) end) end;
	end;

	local function restoreReal()
		for item, value in pairs(hiddenParts) do
			if item.Parent then pcall(function() item.LocalTransparencyModifier = value end) end;
		end;

		for item, value in pairs(hiddenDecals) do
			if item.Parent then pcall(function() item.Transparency = value end) end;
		end;

		table.clear(hiddenParts);
		table.clear(hiddenDecals);
	end;

	local function hideReal(character)
		for _, d in ipairs(character:GetDescendants()) do
			if d:IsA("BasePart") then
				if hiddenParts[d] == nil then hiddenParts[d] = d.LocalTransparencyModifier end;

				if d.LocalTransparencyModifier < 1 then d.LocalTransparencyModifier = 1 end;
			elseif d:IsA("Decal") or d:IsA("Texture") then
				if hiddenDecals[d] == nil then hiddenDecals[d] = d.Transparency end;

				if d.Transparency < 1 then d.Transparency = 1 end;
			end;
		end;
	end;

	local function template(def)
		if cache[def.Name] then return cache[def.Name] end;

		local ok, objects = pcall(game.GetObjects, game, "rbxassetid://" .. tostring(def.Id));

		if not ok or type(objects) ~= "table" or not objects[1] then return nil end;

		local root = objects[1];

		if not root:IsA("Model") then
			local holder = Instance.new("Model");

			root.Parent = holder;
			root = holder;
		end;

		for _, d in ipairs(root:GetDescendants()) do
			if d:IsA("LuaSourceContainer") or d:IsA("Humanoid") or d:IsA("JointInstance")
				or d:IsA("Constraint") or d:IsA("BodyMover") then
				pcall(function() d:Destroy() end);
			end;
		end;

		for _, d in ipairs(root:GetDescendants()) do
			if d:IsA("BasePart") then
				d.Anchored, d.CanCollide, d.CanQuery, d.CanTouch = true, false, false, false;
				d.Massless, d.CastShadow, d.Locked = true, false, true;
			end;
		end;

		cache[def.Name] = root;

		return root;
	end;

	local function clear()
		if follow then
			pcall(function() follow:Disconnect() end);

			follow = nil;
		end;

		if shell then
			pcall(function() shell:Destroy() end);

			shell = nil;
		end;

		restoreReal();
	end;

	local KORBLOX = {
		RightUpperLeg = { MeshId = "rbxassetid://902942096", TextureID = "rbxassetid://902843398" },
		RightLowerLeg = { MeshId = "rbxassetid://902942093", Transparency = 1 },
		RightFoot = { MeshId = "rbxassetid://902942089", Transparency = 1 },
	};

	local HEADLESS_MESH = "rbxassetid://6686307858";

	local function restoreKorblox()
		for part, saved in pairs(legBackup) do
			if part.Parent then
				for property, value in pairs(saved) do
					pcall(function() part[property] = value end);
				end;
			end;
		end;

		table.clear(legBackup);
	end;

	local function applyKorblox()
		if not korblox then return end;

		local character = LocalPlayer.Character;

		if not character then return end;

		restoreKorblox();

		for name, swapTo in pairs(KORBLOX) do
			local part = character:FindFirstChild(name);

			if part then
				local saved = {};

				for property in pairs(swapTo) do
					local ok, value = pcall(function() return part[property] end);

					if ok then saved[property] = value end;
				end;

				legBackup[part] = saved;

				for property, value in pairs(swapTo) do
					pcall(function() part[property] = value end);
				end;
			end;
		end;
	end;

	local function restoreHeadless()
		for object, saved in pairs(headBackup) do
			if object.Parent then
				for property, value in pairs(saved) do
					pcall(function() object[property] = value end);
				end;
			end;
		end;

		table.clear(headBackup);
	end;

	local function applyHeadless()
		if not headless then return end;

		local character = LocalPlayer.Character;
		local head = character and character:FindFirstChild("Head");

		if not head then return end;

		restoreHeadless();

		headBackup[head] = {
			MeshId = (pcall(function() return head.MeshId end)) and head.MeshId or nil,
			TextureID = (pcall(function() return head.TextureID end)) and head.TextureID or nil,
			Transparency = head.Transparency,
		};

		pcall(function() head.MeshId = HEADLESS_MESH end);
		pcall(function() head.TextureID = HEADLESS_MESH end);
		pcall(function() head.Transparency = 1 end);

		for _, child in ipairs(head:GetDescendants()) do
			local ok, value = pcall(function() return child.Transparency end);

			if ok and type(value) == "number" then
				headBackup[child] = { Transparency = value };

				pcall(function() child.Transparency = 1 end);
			end;
		end;
	end;

	local function build(mine)
		local def = M.Pick and defs[M.Pick];

		if not def then return end;

		local character = LocalPlayer.Character;

		if not character then return end;

		local root = character:FindFirstChild("HumanoidRootPart");
		local human = character:FindFirstChildOfClass("Humanoid");

		if not root then return end;

		local source = template(def);

		if mine ~= generation then return end;

		if not source then
			if status then status:SetText("Could not load " .. def.Name) end;

			return;
		end;

		local clone = source:Clone();

		local _, charSize = character:GetBoundingBox();
		local _, rawSize = clone:GetBoundingBox();

		if rawSize.Y > 0.01 then
			local scale = charSize.Y / rawSize.Y;

			if math.abs(scale - 1) > 0.02 then pcall(function() clone:ScaleTo(scale) end) end;
		end;

		local box, size = clone:GetBoundingBox();
		local pivotFix = (clone:GetPivot():Inverse() * box):Inverse();
		local lift = size.Y * 0.5 - root.Size.Y * 0.5 - (human and human.HipHeight or 0);

		clone.Name = "VisualsModelShell";
		clone.Parent = workspace;

		shell = clone;

		hideReal(character);

		local last;

		follow = RunService.RenderStepped:Connect(function()
			if not (ALIVE and M.On and shell and shell.Parent) then return end;

			if not root.Parent then return end;

			local cf = root.CFrame;

			if last == cf then return end;

			last = cf;

			local look, pos = cf.LookVector, cf.Position;

			shell:PivotTo(CFrame.new(pos.X, pos.Y + lift, pos.Z)
				* CFrame.fromEulerAnglesYXZ(0, math.atan2(-look.X, -look.Z), 0)
				* pivotFix);

			hideReal(character);
		end);

		if status then status:SetText("Wearing " .. def.Name) end;
	end;

	local function apply()
		generation = generation + 1;

		clear();

		if not (M.On and M.Pick) then
			if status then status:SetText("Nothing applied") end;

			return;
		end;

		local mine = generation;

		task.spawn(function()
			local ok, err = pcall(build, mine);

			if not ok then warn("[visuals] model: " .. tostring(err)) end;

			if mine == generation and not M.On then clear() end;
		end);
	end;

	local function choose(value)
		local name = (type(value) == "table") and value[1] or value;

		if type(name) ~= "string" or name == "" then return end;

		if not defs[name] then
			M.Pick = nil;

			if M.On then apply() end;

			return;
		end;

		M.Pick = name;

		if M.On then apply() end;
	end;

	local function addById(text)
		local id = string.match(tostring(text or ""), "(%d+)");

		if not id then
			Notification.new({ Title = "Models", Content = "Invalid ID", Duration = 4 });

			return;
		end;

		register({ Name = "Model " .. id, Id = id, Kind = "asset", User = true });
		saveUsers();
		refreshGrid();
	end;

	local function forget(name)
		local def = defs[name];

		if not (def and def.User) then return end;

		defs[name] = nil;

		for index, other in ipairs(order) do
			if other == name then table.remove(order, index); break end;
		end;

		if M.Pick == name then M.Pick = nil; apply() end;

		saveUsers();
		refreshGrid();
	end;

	rebuildList();

	status = Sections.Models:AddLabel("Nothing applied", true);

	local function reapply()
		if not ALIVE then return end;

		task.wait(1);

		if not ALIVE then return end;

		pcall(applyKorblox);
		pcall(applyHeadless);

		if M.On then pcall(apply) end;
	end;

	local function watchCharacter()
		if charConn then return end;

		charConn = NeverLose:AddSignal(LocalPlayer.CharacterAdded:Connect(function()
			task.spawn(reapply);
		end));
	end;

	Sections.Models:AddLabel("Model Changer"):AddToggle({
		Name = "Model Changer",
		Default = false,
		Flag = "model_on",
		ToolTip = "Replaces your character",
		Callback = function(v)
			M.On = v;

			if v then watchCharacter() end;

			apply();
		end,
	});

	Sections.Models:AddLabel("Korblox Leg"):AddToggle({
		Name = "Korblox Leg",
		Default = false,
		Flag = "korblox_leg",
		ToolTip = "Skeleton right leg",
		Callback = function(v)
			korblox = v;

			if v then
				watchCharacter();
				applyKorblox();
			else
				restoreKorblox();
			end;
		end,
	});

	Sections.Models:AddLabel("Headless"):AddToggle({
		Name = "Headless",
		Default = false,
		Flag = "headless",
		ToolTip = "Hides your head",
		Callback = function(v)
			headless = v;

			if v then
				watchCharacter();
				applyHeadless();
			else
				restoreHeadless();
			end;
		end,
	});

	Sections.Models:AddButton({
		Icon = "plus",
		Name = "Add by ID",
		Callback = function()
			local asked = false;

			pcall(function()
				NeverLose.Lib:ask({
					title = "add model",
					icon = "plus",
					hint = "model id or link",
					accept = "add",
					deny = "cancel",
					callback = function(text) addById(text) end,
				});

				asked = true;
			end);

			if not asked then addById(getgenv and getgenv().VISUALS_MODEL_ID) end;
		end,
	});

	Sections.Models:AddButton({
		Icon = "trash-can",
		Name = "Remove Model",
		Callback = function()
			M.On = false;
			M.Pick = nil;

			apply();
		end,
	});

	grid = Visuals.Models:AddGallery({
		Name = "Models",
		Icon = "shirt",
		Position = "left",
		Height = 320,
		Cell = 78,
		Thumb = "Asset",
		Blank = "person-standing",
		Empty = "No models yet",
		Values = rows(),
		Flag = "model_pick",
		Callback = choose,
		Context = function(name, _, x, y, cell)
			local def = defs[name];

			if not def then return end;

			local items = {
				{ icon = "check", name = (M.Pick == name) and "in use" or "use", callback = function() choose(name) end },
			};

			if def.Id then
				items[#items + 1] = { icon = "copy", name = "copy id", callback = function() pcall(setclipboard, def.Id) end };
			end;

			if def.User then
				items[#items + 1] = { icon = "trash-2", name = "remove", callback = function() forget(name) end };
			end;

			pcall(function()
				NeverLose.Lib:popup({ title = name, icon = "shirt", x = x, y = y, follow = cell, items = items });
			end);
		end,
	});

	ESP.ClearModels = onUnload("models", function()
		M.On = false;
		korblox, headless = false, false;
		generation = generation + 1;

		if charConn then pcall(function() charConn:Disconnect() end); charConn = nil end;

		restoreKorblox();
		restoreHeadless();
		clear();
	end);
end);

guard("chinahat", function()
	local lp = LocalPlayer;

	local ch_on = false
	local ch_col = Color3.fromRGB(170, 85, 255)

	local CH_RADIUS, CH_HEIGHT, CH_DROP = 1.55, 0.82, 0.02
	local CH_SEGMENTS = 48
	local CH_TAU = math.pi * 2
	local CH_ALPHA = 0.72
	local CH_MAX_ROWS = 220

	local ch = {
		rows = {},
		px = table.create(CH_SEGMENTS + 1),
		py = table.create(CH_SEGMENTS + 1),
		cos = table.create(CH_SEGMENTS),
		sin = table.create(CH_SEGMENTS),
		ord = table.create(CH_SEGMENTS + 1),
		stack = table.create(CH_SEGMENTS + 2),
		shown = {},
		cpos = {},
		csize = {},
		ccol = {},
		white = Color3.new(1, 1, 1),
		black = Color3.new(0, 0, 0),
		eps = 0.75
	}

	for i = 1, CH_SEGMENTS do
		local angle = (i - 1) / CH_SEGMENTS * CH_TAU
		ch.cos[i] = math.cos(angle) * CH_RADIUS
		ch.sin[i] = math.sin(angle) * CH_RADIUS
	end

	ch.order = function(i, j)
		local px, py = ch.px, ch.py
		local ax, bx = px[i], px[j]
		return ax == bx and py[i] < py[j] or ax < bx
	end

	ch.hull = function(n)
		local px, py, ord, st = ch.px, ch.py, ch.ord, ch.stack
		for i = 1, n do ord[i] = i end
		table.sort(ord, ch.order)
		local m = 0
		for k = 1, n do
			local i = ord[k]
			local x, y = px[i], py[i]
			while m >= 2 do
				local o, a = st[m - 1], st[m]
				local ox, oy = px[o], py[o]
				if (px[a] - ox) * (y - oy) - (py[a] - oy) * (x - ox) > 0 then break end
				m = m - 1
			end
			m = m + 1
			st[m] = i
		end
		local lower = m
		for k = n - 1, 1, -1 do
			local i = ord[k]
			local x, y = px[i], py[i]
			while m > lower do
				local o, a = st[m - 1], st[m]
				local ox, oy = px[o], py[o]
				if (px[a] - ox) * (y - oy) - (py[a] - oy) * (x - ox) > 0 then break end
				m = m - 1
			end
			m = m + 1
			st[m] = i
		end
		return m - 1
	end

	ch.visible = function(state)
		local rows, shown = ch.rows, ch.shown
		for i = 1, #rows do
			if shown[i] ~= state then
				rows[i].Visible = state
				shown[i] = state
			end
		end
	end

	ch.clear = function()
		local rows = ch.rows
		for i = 1, #rows do
			pcall(function() rows[i]:Remove() end)
		end
		table.clear(rows)
		table.clear(ch.shown)
		table.clear(ch.cpos)
		table.clear(ch.csize)
		table.clear(ch.ccol)
		ch.head, ch.pos, ch.cf = nil, nil, nil
		ch.fov, ch.vx, ch.vy, ch.col = nil, nil, nil, nil
	end

	ch.build = function()
		ch.clear()
	end

	ch.row = function(index)
		local rows = ch.rows
		local row = rows[index]
		if row then return row end
		row = Drawing.new("Square")
		row.Filled = true
		row.Thickness = 0
		row.Transparency = CH_ALPHA
		row.Visible = false
		row.ZIndex = 1
		rows[index] = row
		ch.shown[index] = false
		return row
	end

	ch.update = function(camera)
		local char = lp.Character
		local head = char and char:FindFirstChild("Head")
		if not head or not head:IsA("BasePart") or not camera then
			ch.visible(false)
			return
		end
		local headPos = head.Position
		local camCF = camera.CFrame
		local fov = camera.FieldOfView
		local view = camera.ViewportSize
		local viewX, viewY = view.X, view.Y
		if ch.head == head and ch.pos == headPos and ch.cf == camCF
			and ch.fov == fov and ch.vx == viewX and ch.vy == viewY and ch.col == ch_col then
			return
		end
		ch.head, ch.pos, ch.cf = head, headPos, camCF
		ch.fov, ch.vx, ch.vy, ch.col = fov, viewX, viewY, ch_col
		local px, py, cosT, sinT = ch.px, ch.py, ch.cos, ch.sin
		local baseY = headPos.Y + head.Size.Y * 0.5 - CH_DROP
		local center = Vector3.new(headPos.X, baseY, headPos.Z)
		local apex = camera:WorldToViewportPoint(center + Vector3.new(0, CH_HEIGHT, 0))
		if apex.Z <= 0 then
			ch.visible(false)
			return
		end
		local probe = camera:WorldToViewportPoint(center + Vector3.new(cosT[1], 0, sinT[1]))
		if probe.Z <= 0 then
			ch.visible(false)
			return
		end
		px[1], py[1] = apex.X, apex.Y
		px[2], py[2] = probe.X, probe.Y
		local camPos = camCF.Position
		local rv, uv, lv = camCF.RightVector, camCF.UpVector, camCF.LookVector
		local ox, oy, oz = center.X - camPos.X, center.Y - camPos.Y, center.Z - camPos.Z
		local baseR = ox * rv.X + oy * rv.Y + oz * rv.Z
		local baseU = ox * uv.X + oy * uv.Y + oz * uv.Z
		local baseD = ox * lv.X + oy * lv.Y + oz * lv.Z
		local rvx, rvz, uvx, uvz, lvx, lvz = rv.X, rv.Z, uv.X, uv.Z, lv.X, lv.Z
		local scale = viewY * 0.5 / math.tan(math.rad(fov * 0.5))
		local midX, midY = viewX * 0.5, viewY * 0.5
		local eps = ch.eps
		local exact = false
		local dep = baseD + CH_HEIGHT * lv.Y
		if dep > 0 then
			local inv = scale / dep
			if math.abs(midX + (baseR + CH_HEIGHT * rv.Y) * inv - apex.X) <= eps
				and math.abs(midY - (baseU + CH_HEIGHT * uv.Y) * inv - apex.Y) <= eps then
				local c, s = cosT[1], sinT[1]
				dep = baseD + c * lvx + s * lvz
				if dep > 0 then
					inv = scale / dep
					if math.abs(midX + (baseR + c * rvx + s * rvz) * inv - probe.X) <= eps
						and math.abs(midY - (baseU + c * uvx + s * uvz) * inv - probe.Y) <= eps then
						exact = true
					end
				end
			end
		end
		if exact then
			for i = 2, CH_SEGMENTS do
				local c, s = cosT[i], sinT[i]
				local d = baseD + c * lvx + s * lvz
				if d <= 0 then
					ch.visible(false)
					return
				end
				local inv = scale / d
				px[i + 1] = midX + (baseR + c * rvx + s * rvz) * inv
				py[i + 1] = midY - (baseU + c * uvx + s * uvz) * inv
			end
		else
			for i = 2, CH_SEGMENTS do
				local point = camera:WorldToViewportPoint(center + Vector3.new(cosT[i], 0, sinT[i]))
				if point.Z <= 0 then
					ch.visible(false)
					return
				end
				px[i + 1] = point.X
				py[i + 1] = point.Y
			end
		end
		local hn = ch.hull(CH_SEGMENTS + 1)
		if hn < 3 then
			ch.visible(false)
			return
		end
		local st = ch.stack
		local minY, maxY = math.huge, -math.huge
		for i = 1, hn do
			local y = py[st[i]]
			if y < minY then minY = y end
			if y > maxY then maxY = y end
		end
		local firstY = math.max(0, math.floor(minY))
		local lastY = math.min(viewY, math.ceil(maxY))
		if lastY - firstY < 2 then
			ch.visible(false)
			return
		end
		local step = math.max(1, math.ceil((lastY - firstY) / CH_MAX_ROWS))
		local span = math.max(1, maxY - minY)
		local rows, shown = ch.rows, ch.shown
		local cpos, csize, ccol = ch.cpos, ch.csize, ch.ccol
		local white, black = ch.white, ch.black
		local used = 0
		for y0 = firstY, lastY - 1, step do
			local height = math.min(step, lastY - y0)
			local y = y0 + height * 0.5
			local left, right = math.huge, -math.huge
			local ax, ay = px[st[hn]], py[st[hn]]
			for i = 1, hn do
				local ix = st[i]
				local bx, by = px[ix], py[ix]
				if (ay <= y and by > y) or (by <= y and ay > y) then
					local x = ax + (y - ay) * (bx - ax) / (by - ay)
					if x < left then left = x end
					if x > right then right = x end
				end
				ax, ay = bx, by
			end
			local width = right - left
			if width >= 2.5 then
				used = used + 1
				local row = ch.row(used)
				local t = (y - minY) / span
				local light = 1 - t * 1.35
				local dark = (t - 0.58) / 0.42
				if light < 0 then light = 0 end
				if dark < 0 then dark = 0 end
				local color = ch_col:Lerp(white, light * 0.26):Lerp(black, dark * 0.1)
				local pos = Vector2.new(left, y0)
				local size = Vector2.new(width, height)
				if cpos[used] ~= pos then
					row.Position = pos
					cpos[used] = pos
				end
				if csize[used] ~= size then
					row.Size = size
					csize[used] = size
				end
				if ccol[used] ~= color then
					row.Color = color
					ccol[used] = color
				end
				if not shown[used] then
					row.Visible = true
					shown[used] = true
				end
			end
		end
		for i = used + 1, #rows do
			if shown[i] then
				rows[i].Visible = false
				shown[i] = false
			end
		end
	end

	NeverLose:AddSignal(RunService.RenderStepped:Connect(function()
		if not ch_on then return end

		ch.update(workspace.CurrentCamera)
	end));

	NeverLose:AddSignal(LocalPlayer.CharacterAdded:Connect(function()
		task.wait(0.4)

		if ALIVE and ch_on then ch.build() end
	end));

	local row = Sections.ESP:AddLabel("China Hat");

	row:AddToggle({
		Name = "China Hat",
		Default = false,
		Flag = "china_hat",
		Callback = function(v)
			ch_on = v

			if v then ch.build() else ch.clear() end
		end,
	});

	row:AddColorPicker({
		Default = ch_col,
		Flag = "china_hat_color",
		Callback = function(c) ch_col = c end,
	});

	ESP.ChinaHat = { On = function() return ch_on end };

	ESP.ClearChinaHat = onUnload("chinahat", function()
		ch_on = false

		pcall(ch.clear)
	end);
end);

guard("killfx", function()
	local TweenService = game:GetService("TweenService");

	local K = {
		Clone = false, CloneColor = Color3.fromRGB(255, 0, 0), CloneTime = 3,
		Emitter = false, EmitterColor = Color3.fromRGB(255, 100, 100), EmitterTime = 1.2,
		Target = "Other",
	};

	local clones = {};
	local active, activeCount = {}, 0;

	local function removeEffect(record)
		for i = 1, activeCount do
			if active[i] == record then
				active[i] = active[activeCount];
				active[activeCount] = nil;
				activeCount = activeCount - 1;
				break;
			end;
		end;

		if record.part and record.part.Parent then record.part:Destroy() end;
	end;

	local function spawnEmitter(character, tint, duration)
		if not (character and character.Parent) then return end;

		if activeCount >= 3 then
			removeEffect(active[1]);
		end;

		duration = math.max(duration, 0.2);

		local bodyParts = {};

		for _, source in ipairs(character:GetChildren()) do
			if source:IsA("BasePart") and source.Name ~= "HumanoidRootPart" and #bodyParts < 15 then
				bodyParts[#bodyParts + 1] = source;
			end;
		end;

		if #bodyParts == 0 then return end;

		local root = Instance.new("Folder");
		root.Name = NeverLose.RandomString();
		root:SetAttribute(TAG, true);
		root.Parent = workspace;

		local record = { part = root, balls = {} };
		activeCount = activeCount + 1;
		active[activeCount] = record;

		local random = math.random;
		local goldenAngle = math.pi * (3 - math.sqrt(5));

		local function surfacePosition(source, radius, index, count, headSeed)
			local size = source.Size;
			local padding = radius * 0.92;

			if source.Name == "Head" then
				local y = 1 - 2 * ((index - 0.5) / count);
				local angle = index * goldenAngle + headSeed;
				local radial = math.sqrt(math.max(0, 1 - y * y));
				local dir = Vector3.new(radial * math.cos(angle), y, radial * math.sin(angle));
				local half = size * 0.5;

				return source.CFrame:PointToWorldSpace(Vector3.new(
					dir.X * (half.X + padding),
					dir.Y * (half.Y + padding),
					dir.Z * (half.Z + padding)
				));
			end;

			local areaX = size.Y * size.Z;
			local areaY = size.X * size.Z;
			local areaZ = size.X * size.Y;
			local pick = random() * (areaX + areaY + areaZ);
			local pos;

			if pick < areaX then
				local side = random() < 0.5 and -1 or 1;
				pos = Vector3.new(side * (size.X * 0.5 + padding), (random() - 0.5) * size.Y, (random() - 0.5) * size.Z);
			elseif pick < areaX + areaY then
				local side = random() < 0.5 and -1 or 1;
				pos = Vector3.new((random() - 0.5) * size.X, side * (size.Y * 0.5 + padding), (random() - 0.5) * size.Z);
			else
				local side = random() < 0.5 and -1 or 1;
				pos = Vector3.new((random() - 0.5) * size.X, (random() - 0.5) * size.Y, side * (size.Z * 0.5 + padding));
			end;

			return source.CFrame:PointToWorldSpace(pos);
		end;

		local minY, maxY = math.huge, -math.huge;

		for _, source in ipairs(bodyParts) do
			local halfY = source.Size.Y * 0.5;
			minY = math.min(minY, source.Position.Y - halfY);
			maxY = math.max(maxY, source.Position.Y + halfY);
		end;

		local phaseCount = 8;
		local groups = {};

		for i = 1, phaseCount do groups[i] = {} end;

		local headSeed = random() * math.pi * 2;
		local height = math.max(maxY - minY, 0.01);
		local created = 0;

		for _, source in ipairs(bodyParts) do
			local size = source.Size;
			local surface = 2 * (size.X * size.Y + size.X * size.Z + size.Y * size.Z);
			local count = source.Name == "Head" and 24 or math.clamp(math.floor(surface * 0.65 + 0.5), 7, 12);
			count = math.min(count, 140 - created);

			for index = 1, count do
				local diameter = source.Name == "Head" and (0.115 + random() * 0.045) or (0.13 + random() * 0.06);
				local targetSize = Vector3.new(diameter, diameter, diameter);
				local position = surfacePosition(source, diameter * 0.5, index, count, headSeed);

				local ball = Instance.new("Part");
				ball.Name = NeverLose.RandomString();
				ball.Shape = Enum.PartType.Ball;
				ball.Material = Enum.Material.Neon;
				ball.Color = tint;
				ball.Size = Vector3.new(0.015, 0.015, 0.015);
				ball.Position = position;
				ball.Anchored = true;
				ball.CanCollide = false;
				ball.CanQuery = false;
				ball.CanTouch = false;
				ball.CastShadow = false;
				ball.Massless = true;
				ball.Transparency = 1;
				ball.Parent = root;

				record.balls[#record.balls + 1] = ball;
				created = created + 1;

				local vertical = math.clamp((position.Y - minY) / height, 0, 1);
				local phase = math.clamp(math.floor(vertical * (phaseCount - 1) + 1.5) + random(-1, 1), 1, phaseCount);

				groups[phase][#groups[phase] + 1] = { ball = ball, size = targetSize };
			end;

			if created >= 140 then break end;
		end;

		local revealWindow = math.min(0.34, duration * 0.26);
		local revealTime = math.min(0.2, duration * 0.18);
		local fadeBegin = math.max(revealWindow + revealTime + 0.06, duration * 0.42);
		local fadeWindow = math.min(0.28, duration * 0.18);
		local fadeTime = math.max(duration - fadeBegin - fadeWindow, 0.1);

		for phase = 1, phaseCount do
			local alpha = (phase - 1) / (phaseCount - 1);
			local group = groups[phase];

			task.delay(revealWindow * alpha, function()
				if not root.Parent then return end;

				for _, item in ipairs(group) do
					if item.ball.Parent then
						TweenService:Create(item.ball, TweenInfo.new(revealTime, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
							Size = item.size, Transparency = 0.05,
						}):Play();
					end;
				end;
			end);

			task.delay(fadeBegin + fadeWindow * alpha, function()
				if not root.Parent then return end;

				for _, item in ipairs(group) do
					if item.ball.Parent then
						TweenService:Create(item.ball, TweenInfo.new(fadeTime, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
							Size = item.size * 0.58, Transparency = 1,
						}):Play();
					end;
				end;
			end);
		end;

		task.delay(duration + 0.12, function()
			removeEffect(record);
		end);
	end;

	local function fadeClone(clone, wait)
		task.delay(wait, function()
			if not clone.Parent then return end;

			for _, d in ipairs(clone:GetDescendants()) do
				if d:IsA("BasePart") and d.Name ~= "HumanoidRootPart" then
					pcall(function()
						TweenService:Create(d, TweenInfo.new(1.5, Enum.EasingStyle.Linear), { Transparency = 1 }):Play();
					end);
				end;
			end;

			task.delay(1.6, function()
				for i = #clones, 1, -1 do
					if clones[i] == clone then table.remove(clones, i) end;
				end;

				if clone.Parent then clone:Destroy() end;
			end);
		end);
	end;

	local function makeClone(character)

		local archivable = character.Archivable;

		if not archivable then
			pcall(function() character.Archivable = true end);
		end;

		local ok, clone = pcall(character.Clone, character);

		if not archivable then
			pcall(function() character.Archivable = archivable end);
		end;

		if not ok or not clone then return end;

		for _, d in ipairs(clone:GetDescendants()) do
			if d:IsA("BasePart") then
				d.Anchored = true;
				d.CanCollide = false;
				d.CanQuery = false;
				d.CanTouch = false;

				if d.Name == "HumanoidRootPart" then
					d.Transparency = 1;
				else
					d.Material = Enum.Material.ForceField;
					d.Color = K.CloneColor;
				end;
			elseif d:IsA("Humanoid") or d:IsA("BaseScript") or d:IsA("ModuleScript") or d:IsA("Sound")
				or d:IsA("SurfaceAppearance") or d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam")
				or d:IsA("Smoke") or d:IsA("Fire") or d:IsA("Sparkles") or d:IsA("Light") or d:IsA("Highlight") then
				pcall(function() d:Destroy() end);
			end;
		end;

		clone.Name = NeverLose.RandomString();
		clone:SetAttribute(TAG, true);
		clone.Parent = workspace;

		clones[#clones + 1] = clone;

		fadeClone(clone, K.CloneTime);
	end;

	local function wants(player)
		local isSelf = player == LocalPlayer;

		return K.Target == "All" or (isSelf and K.Target == "Self") or (not isSelf and K.Target == "Other");
	end;

	local function onDeath(character)
		if K.Clone then makeClone(character) end;
		if K.Emitter then spawnEmitter(character, K.EmitterColor, K.EmitterTime) end;
	end;

	local function watch(player)
		local function hook(character)
			task.spawn(function()
				local human = character:WaitForChild("Humanoid", 10);
				if not human then return end;

				NeverLose:AddSignal(human.Died:Connect(function()
					if not (K.Clone or K.Emitter) then return end;
					if not wants(player) then return end;

					onDeath(character);
				end));
			end);
		end;

		if player.Character then hook(player.Character) end;

		NeverLose:AddSignal(player.CharacterAdded:Connect(hook));
	end;

	for _, player in ipairs(Players:GetPlayers()) do watch(player) end;
	NeverLose:AddSignal(Players.PlayerAdded:Connect(watch));

	for _, leftover in ipairs(workspace:GetChildren()) do
		if leftover:GetAttribute(TAG) and (leftover:IsA("Folder") or leftover:IsA("Model")) then
			leftover:Destroy();
		end;
	end;

	ESP.KillFx = K;

	ESP.ClearKillFx = function()
		for i = activeCount, 1, -1 do
			if active[i] then pcall(function() active[i].part:Destroy() end) end;
			active[i] = nil;
		end;

		activeCount = 0;

		for _, clone in ipairs(clones) do pcall(function() clone:Destroy() end) end;

		clones = {};
	end;

	local cloneRow = Sections.KillFx:AddLabel("Ghost");
	cloneRow:AddToggle({ Default = false, Flag = "killfx_clone", Callback = function(v) K.Clone = v end });
	cloneRow:AddColorPicker({ Default = K.CloneColor, Flag = "killfx_clone_color", Callback = function(v) K.CloneColor = v end });
	cloneRow:AddOption(1):AddLabel("Hold"):AddSlider({
		Min = 1, Max = 100, Default = 30, Rounding = 0, Size = 90,
		Flag = "killfx_clone_time",
		Callback = function(v) K.CloneTime = v / 10 end,
	});

	local emitterRow = Sections.KillFx:AddLabel("Neon Burst");
	emitterRow:AddToggle({ Default = false, Flag = "killfx_emitter", Callback = function(v) K.Emitter = v end });
	emitterRow:AddColorPicker({ Default = K.EmitterColor, Flag = "killfx_emitter_color", Callback = function(v) K.EmitterColor = v end });
	emitterRow:AddOption(1):AddLabel("Length"):AddSlider({
		Min = 4, Max = 60, Default = 12, Rounding = 0, Size = 90,
		Flag = "killfx_emitter_time",
		Callback = function(v) K.EmitterTime = v / 10 end,
	});

	Sections.KillFx:AddLabel("Target"):AddDropdown({
		Default = "Other",
		Values = { "Other", "Self", "All" },
		Flag = "killfx_target",
		Callback = function(v) K.Target = v end,
	});
end);

guard("tracers", function()
	local Debris = game:GetService("Debris");
	local TweenService = game:GetService("TweenService");
	local ReplicatedStorage = game:GetService("ReplicatedStorage");

	local STYLES = {
		["White Beam"] = { texture = Remote.file("images/WhiteBeam.png"), local_file = true, speed = 0, length = 1, emission = 2, brightness = 2 },
		Energy = { texture = "rbxassetid://12781800668", speed = 1.5, length = 2, emission = 3, brightness = 2.5 },
		Plain = { texture = "", speed = 0, length = 1, emission = 1, brightness = 1 },
		Smoke = { texture = "rbxasset://textures/particles/smoke_main.dds", speed = 0.4, length = 6, emission = 0.4, brightness = 1 },
		Sparkle = { texture = "rbxasset://textures/particles/sparkles_main.dds", speed = 3, length = 1.5, emission = 4, brightness = 3 },
		Chain = { texture = Remote.file("images/chain.png"), local_file = true, speed = 0.8, length = 3, emission = 1.5, brightness = 2 },
		Zigzag = { texture = Remote.file("images/zigzag.png"), local_file = true, speed = 0.6, length = 2.5, emission = 2.5, brightness = 2.4 },
	};

	local T = {
		On = false,
		Style = "White Beam",
		Target = "All",
		Color = Color3.fromRGB(133, 220, 255),
		Width = 0.25,
		Duration = 1,
	};

	local function textureFor(style)
		if not style.local_file then return style.texture end;

		return Remote.id(style.texture) or "rbxassetid://12781800668";
	end;

	local fade = TweenInfo.new(0.2, Enum.EasingStyle.Linear, Enum.EasingDirection.Out);

	local function point(position, lifetime)
		local part = Instance.new("Part");
		part.Transparency = 1;
		part.Anchored = true;
		part.CanCollide = false;
		part.CanQuery = false;
		part.CanTouch = false;
		part.CastShadow = false;
		part.Size = Vector3.new(1, 1, 1);
		part.CFrame = CFrame.new(position);

		Instance.new("Attachment", part);

		Debris:AddItem(part, lifetime);
		part.Parent = workspace;

		return part;
	end;

	local function toPosition(value)
		if typeof(value) == "Vector3" then
			return value;
		elseif typeof(value) == "CFrame" then
			return value.Position;
		elseif typeof(value) == "Instance" then
			if value:IsA("Attachment") then
				return value.WorldPosition;
			elseif value:IsA("BasePart") then
				return value.Position;
			end;
		end;
	end;

	local function draw(fromValue, toValue)
		local from = toPosition(fromValue);
		local to = toPosition(toValue);

		if not (from and to) then return end;

		local style = STYLES[T.Style] or STYLES.Energy;
		local life = T.Duration + 0.5;

		local a = point(from, life);
		local b = point(to, life);

		local beam = Instance.new("Beam");
		beam.FaceCamera = true;
		beam.Texture = textureFor(style);
		beam.TextureSpeed = style.speed;
		beam.TextureLength = style.length;
		beam.LightEmission = style.emission;
		beam.LightInfluence = 0;
		beam.Brightness = style.brightness;
		beam.Width0 = T.Width;
		beam.Width1 = T.Width;
		beam.Color = ColorSequence.new(T.Color);
		beam.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0.1),
			NumberSequenceKeypoint.new(1, 0.1),
		});
		beam.Attachment0 = a.Attachment;
		beam.Attachment1 = b.Attachment;
		beam.Parent = a;

		task.delay(T.Duration, function()
			if beam.Parent then
				TweenService:Create(beam, fade, { Width0 = 0, Width1 = 0 }):Play();
			end;
		end);
	end;

	local function isDroppedGun(gun)
		if T.Target == "All" then return true end;

		local mine = typeof(gun) == "Instance" and LocalPlayer.Character and gun:IsDescendantOf(LocalPlayer.Character);

		if T.Target == "Self" then return mine and true or false end;

		return not mine;
	end;

	local connection, remote;

	local function connect()
		local ok, found = pcall(function()
			return ReplicatedStorage:WaitForChild("ClientServices", 5)
				and ReplicatedStorage.ClientServices:WaitForChild("WeaponService", 5)
				and ReplicatedStorage.ClientServices.WeaponService:WaitForChild("GunFired", 5);
		end);

		if not ok or not found then return end;
		if connection and remote == found and connection.Connected then return end;

		if connection then pcall(function() connection:Disconnect() end) end;

		remote = found;
		connection = NeverLose:AddSignal(found.OnClientEvent:Connect(function(gun, fromValue, toValue)
			if not T.On then return end;
			if not isDroppedGun(gun) then return end;

			task.spawn(draw, fromValue, toValue);
		end));
	end;

	task.spawn(function()
		while true do
			if T.On then pcall(connect) end;

			task.wait(2);
		end;
	end);

	ESP.Tracers = T;

	local row = Sections.Tracers:AddLabel("Enabled");
	row:AddToggle({
		Default = false, Flag = "bullet_tracers",
		Callback = function(v)
			T.On = v;

			if v then pcall(connect) end;
		end,
	});
	row:AddColorPicker({
		Default = T.Color, Flag = "bullet_tracers_color",
		Callback = function(v) T.Color = v end,
	});

	Sections.Tracers:AddLabel("Style"):AddDropdown({
		Default = "White Beam",
		Values = { "White Beam", "Energy", "Chain", "Zigzag", "Plain", "Smoke", "Sparkle" },
		Flag = "bullet_tracers_style",
		Callback = function(v) T.Style = v end,
	});

	Sections.Tracers:AddLabel("Shooter"):AddDropdown({
		Default = "All",
		Values = { "All", "Self", "Other" },
		Flag = "bullet_tracers_target",
		Callback = function(v) T.Target = v end,
	});

	Sections.Tracers:AddLabel("Width"):AddSlider({
		Min = 5, Max = 200, Default = 25, Rounding = 0, Size = 100,
		Flag = "bullet_tracers_width",
		Callback = function(v) T.Width = v / 100 end,
	});

	Sections.Tracers:AddLabel("Duration"):AddSlider({
		Min = 1, Max = 60, Default = 10, Rounding = 0, Size = 100,
		Flag = "bullet_tracers_duration",
		Callback = function(v) T.Duration = v / 10 end,
	});

end);

guard("constellations", function()

	local FAR, NEAR = 1400, 190;
	local RADIUS = FAR;

	local FIGURES = {
		Andromeda = {
			stars = {
				{ "Alpheratz", 0.14, 29.09, 2.1 }, { "Mirach", 1.162, 35.62, 2.1 },
				{ "Almach", 2.065, 42.33, 2.1 }, { "Delta And", 0.655, 30.86, 3.3 },
				{ "51 And", 1.632, 48.63, 3.6 },
			},
			lines = {
				{ 1, 4 }, { 4, 2 }, { 2, 3 }, { 2, 5 },
			},
		},
		Antlia = {
			stars = {
				{ "Alpha Ant", 10.452, -31.07, 4.3 }, { "Epsilon Ant", 9.487, -35.95, 4.5 },
			},
			lines = {
				{ 2, 1 },
			},
		},
		Apus = {
			stars = {
				{ "Alpha Aps", 14.798, -79.04, 3.8 }, { "Gamma Aps", 16.558, -78.9, 3.9 },
				{ "Beta Aps", 16.718, -77.52, 4.2 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 },
			},
		},
		Aquarius = {
			stars = {
				{ "Sadalsuud", 21.526, -5.57, 2.9 }, { "Sadalmelik", 22.096, -0.32, 2.9 },
				{ "Skat", 22.911, -15.82, 3.3 }, { "Zeta Aqr", 22.481, -0.02, 3.6 },
				{ "Eta Aqr", 22.582, -0.12, 4.0 }, { "Gamma Aqr", 22.361, -1.39, 3.8 },
				{ "Lambda Aqr", 22.879, -7.58, 3.7 },
			},
			lines = {
				{ 1, 2 }, { 2, 6 }, { 6, 4 }, { 4, 5 }, { 2, 7 },
				{ 7, 3 },
			},
		},
		Aquila = {
			stars = {
				{ "Altair", 19.846, 8.87, 0.8 }, { "Tarazed", 19.771, 10.61, 2.7 },
				{ "Alshain", 19.922, 6.41, 3.7 }, { "Deneb el Okab", 19.09, 13.86, 3.0 },
				{ "Theta Aql", 20.188, -0.82, 3.2 }, { "Lambda Aql", 19.104, -4.88, 3.4 },
			},
			lines = {
				{ 2, 1 }, { 1, 3 }, { 2, 4 }, { 3, 5 }, { 5, 6 },
			},
		},
		Ara = {
			stars = {
				{ "Beta Ara", 17.422, -55.53, 2.8 }, { "Alpha Ara", 17.531, -49.88, 2.8 },
				{ "Zeta Ara", 16.977, -55.99, 3.1 }, { "Gamma Ara", 17.419, -56.38, 3.3 },
				{ "Delta Ara", 17.518, -60.68, 3.6 },
			},
			lines = {
				{ 3, 1 }, { 1, 4 }, { 4, 5 }, { 1, 2 },
			},
		},
		Aries = {
			stars = {
				{ "Hamal", 2.119, 23.46, 2.0 }, { "Sheratan", 1.911, 20.81, 2.6 },
				{ "Mesarthim", 1.892, 19.29, 3.9 }, { "41 Ari", 2.832, 27.26, 3.6 },
			},
			lines = {
				{ 4, 1 }, { 1, 2 }, { 2, 3 },
			},
		},
		Auriga = {
			stars = {
				{ "Capella", 5.278, 45.998, 0.1 }, { "Menkalinan", 5.992, 44.95, 1.9 },
				{ "Mahasim", 5.995, 37.21, 2.6 }, { "Hassaleh", 4.95, 33.17, 2.7 },
				{ "Almaaz", 5.033, 43.82, 3.0 }, { "Elnath", 5.438, 28.61, 1.7 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 3, 6 }, { 6, 4 }, { 4, 5 },
				{ 5, 1 },
			},
		},
		Bootes = {
			stars = {
				{ "Arcturus", 14.261, 19.18, -0.05 }, { "Izar", 14.75, 27.07, 2.4 },
				{ "Muphrid", 13.911, 18.4, 2.7 }, { "Seginus", 14.534, 38.31, 3.0 },
				{ "Nekkar", 15.032, 40.39, 3.5 }, { "Rho Boo", 14.529, 30.37, 3.6 },
				{ "Zeta Boo", 14.685, 13.73, 3.8 },
			},
			lines = {
				{ 3, 1 }, { 1, 6 }, { 6, 4 }, { 4, 5 }, { 5, 2 },
				{ 2, 1 }, { 1, 7 },
			},
		},
		Caelum = {
			stars = {
				{ "Alpha Cae", 4.676, -41.86, 4.4 }, { "Beta Cae", 4.703, -37.14, 5.0 },
			},
			lines = {
				{ 1, 2 },
			},
		},
		Camelopardalis = {
			stars = {
				{ "Beta Cam", 5.057, 60.44, 4.0 }, { "CS Cam", 3.487, 59.94, 4.2 },
				{ "Alpha Cam", 4.906, 66.34, 4.3 }, { "Gamma Cam", 3.839, 71.33, 4.6 },
			},
			lines = {
				{ 2, 1 }, { 1, 3 }, { 3, 4 },
			},
		},
		Cancer = {
			stars = {
				{ "Altarf", 8.275, 9.19, 3.5 }, { "Asellus Australis", 8.745, 18.15, 3.9 },
				{ "Asellus Borealis", 8.722, 21.47, 4.7 }, { "Acubens", 8.975, 11.86, 4.3 },
				{ "Iota Cnc", 8.779, 28.76, 4.0 },
			},
			lines = {
				{ 1, 2 }, { 2, 4 }, { 2, 3 }, { 3, 5 },
			},
		},
		["Canes Venatici"] = {
			stars = {
				{ "Cor Caroli", 12.934, 38.32, 2.9 }, { "Chara", 12.562, 41.36, 4.2 },
			},
			lines = {
				{ 1, 2 },
			},
		},
		["Canis Major"] = {
			stars = {
				{ "Sirius", 6.752, -16.72, -1.5 }, { "Mirzam", 6.378, -17.96, 2.0 },
				{ "Wezen", 7.14, -26.39, 1.8 }, { "Adhara", 6.977, -28.97, 1.5 },
				{ "Aludra", 7.402, -29.3, 2.4 }, { "Muliphein", 7.063, -15.63, 4.1 },
			},
			lines = {
				{ 2, 1 }, { 1, 6 }, { 1, 3 }, { 3, 4 }, { 3, 5 },
			},
		},
		["Canis Minor"] = {
			stars = {
				{ "Procyon", 7.655, 5.22, 0.4 }, { "Gomeisa", 7.453, 8.29, 2.9 },
			},
			lines = {
				{ 1, 2 },
			},
		},
		Capricornus = {
			stars = {
				{ "Algedi", 20.3, -12.51, 3.6 }, { "Dabih", 20.351, -14.78, 3.1 },
				{ "Deneb Algedi", 21.784, -16.13, 2.8 }, { "Nashira", 21.668, -16.66, 3.7 },
				{ "Zeta Cap", 21.444, -22.41, 3.7 }, { "Omega Cap", 20.863, -26.92, 4.1 },
			},
			lines = {
				{ 1, 2 }, { 2, 6 }, { 6, 5 }, { 5, 4 }, { 4, 3 },
				{ 3, 1 },
			},
		},
		Carina = {
			stars = {
				{ "Canopus", 6.399, -52.7, -0.7 }, { "Miaplacidus", 9.22, -69.72, 1.7 },
				{ "Avior", 8.375, -59.51, 1.9 }, { "Aspidiske", 9.285, -59.28, 2.2 },
				{ "Theta Car", 10.716, -64.39, 2.8 }, { "Upsilon Car", 9.785, -65.07, 3.0 },
			},
			lines = {
				{ 1, 3 }, { 3, 4 }, { 4, 6 }, { 6, 2 }, { 6, 5 },
			},
		},
		Cassiopeia = {
			stars = {
				{ "Segin", 1.907, 63.67, 3.4 }, { "Ruchbah", 1.43, 60.24, 2.7 },
				{ "Gamma Cas", 0.945, 60.72, 2.2 }, { "Schedar", 0.675, 56.54, 2.2 },
				{ "Caph", 0.153, 59.15, 2.3 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 5 },
			},
		},
		Centaurus = {
			stars = {
				{ "Rigil Kentaurus", 14.66, -60.84, -0.3 }, { "Hadar", 14.064, -60.37, 0.6 },
				{ "Menkent", 14.112, -36.37, 2.1 }, { "Muhlifain", 12.692, -48.96, 2.2 },
				{ "Epsilon Cen", 13.665, -53.47, 2.3 }, { "Eta Cen", 14.596, -42.16, 2.3 },
				{ "Zeta Cen", 13.926, -47.29, 2.5 }, { "Delta Cen", 12.139, -50.72, 2.6 },
				{ "Iota Cen", 13.343, -36.71, 2.7 },
			},
			lines = {
				{ 1, 2 }, { 2, 5 }, { 5, 7 }, { 7, 6 }, { 6, 3 },
				{ 5, 4 }, { 4, 8 }, { 3, 9 },
			},
		},
		Cepheus = {
			stars = {
				{ "Alderamin", 21.31, 62.59, 2.4 }, { "Alfirk", 21.478, 70.56, 3.2 },
				{ "Errai", 23.656, 77.63, 3.2 }, { "Zeta Cep", 22.181, 58.2, 3.4 },
				{ "Iota Cep", 22.828, 66.2, 3.5 }, { "Eta Cep", 20.755, 61.84, 3.4 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 3, 5 }, { 5, 4 }, { 4, 1 },
				{ 1, 6 },
			},
		},
		Cetus = {
			stars = {
				{ "Diphda", 0.726, -17.99, 2.0 }, { "Menkar", 3.038, 4.09, 2.5 },
				{ "Mira", 2.322, -2.98, 3.0 }, { "Kaffaljidhma", 2.722, 3.24, 3.5 },
				{ "Baten Kaitos", 1.858, -10.34, 3.5 }, { "Tau Cet", 1.734, -15.94, 3.5 },
				{ "Deneb Algenubi", 1.4, -8.18, 3.6 },
			},
			lines = {
				{ 1, 6 }, { 6, 5 }, { 5, 3 }, { 3, 4 }, { 4, 2 },
				{ 1, 7 }, { 7, 5 },
			},
		},
		Chamaeleon = {
			stars = {
				{ "Alpha Cha", 8.309, -76.92, 4.1 }, { "Gamma Cha", 10.591, -78.61, 4.1 },
				{ "Beta Cha", 12.303, -79.31, 4.2 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 },
			},
		},
		Circinus = {
			stars = {
				{ "Alpha Cir", 14.708, -64.98, 3.2 }, { "Beta Cir", 15.29, -58.8, 4.1 },
			},
			lines = {
				{ 1, 2 },
			},
		},
		Columba = {
			stars = {
				{ "Phact", 5.661, -34.07, 2.6 }, { "Wazn", 5.849, -35.77, 3.1 },
				{ "Delta Col", 6.372, -33.44, 3.9 }, { "Epsilon Col", 5.522, -35.47, 3.9 },
			},
			lines = {
				{ 4, 1 }, { 1, 2 }, { 2, 3 },
			},
		},
		["Coma Berenices"] = {
			stars = {
				{ "Beta Com", 13.198, 27.88, 4.3 }, { "Alpha Com", 13.166, 17.53, 4.3 },
				{ "Gamma Com", 12.448, 28.27, 4.4 },
			},
			lines = {
				{ 3, 1 }, { 1, 2 },
			},
		},
		["Corona Australis"] = {
			stars = {
				{ "Alphecca Meridiana", 19.158, -37.9, 4.1 }, { "Beta CrA", 19.167, -39.34, 4.1 },
				{ "Gamma CrA", 19.107, -37.06, 4.2 }, { "Delta CrA", 19.129, -40.5, 4.6 },
			},
			lines = {
				{ 3, 1 }, { 1, 2 }, { 2, 4 },
			},
		},
		["Corona Borealis"] = {
			stars = {
				{ "Alphecca", 15.578, 26.71, 2.2 }, { "Nusakan", 15.464, 29.11, 3.7 },
				{ "Gamma CrB", 15.711, 26.3, 3.8 }, { "Delta CrB", 15.827, 26.07, 4.6 },
				{ "Epsilon CrB", 15.96, 26.88, 4.1 }, { "Theta CrB", 15.548, 31.36, 4.1 },
			},
			lines = {
				{ 6, 2 }, { 2, 1 }, { 1, 3 }, { 3, 4 }, { 4, 5 },
			},
		},
		Corvus = {
			stars = {
				{ "Gienah Corvi", 12.263, -17.54, 2.6 }, { "Kraz", 12.573, -23.4, 2.7 },
				{ "Algorab", 12.498, -16.52, 3.0 }, { "Minkar", 12.169, -22.62, 3.0 },
				{ "Alchiba", 12.14, -24.73, 4.0 },
			},
			lines = {
				{ 5, 4 }, { 4, 1 }, { 1, 3 }, { 3, 2 }, { 2, 4 },
			},
		},
		Crater = {
			stars = {
				{ "Delta Crt", 11.323, -14.78, 3.6 }, { "Gamma Crt", 11.415, -17.68, 4.1 },
				{ "Alpha Crt", 10.996, -18.3, 4.1 }, { "Beta Crt", 11.194, -22.83, 4.5 },
				{ "Epsilon Crt", 11.416, -10.86, 4.8 },
			},
			lines = {
				{ 3, 1 }, { 1, 5 }, { 1, 2 }, { 2, 4 },
			},
		},
		Crux = {
			stars = {
				{ "Acrux", 12.443, -63.1, 0.8 }, { "Mimosa", 12.795, -59.69, 1.3 },
				{ "Gacrux", 12.519, -57.11, 1.6 }, { "Imai", 12.253, -58.75, 2.8 },
				{ "Epsilon Cru", 12.356, -60.4, 3.6 },
			},
			lines = {
				{ 1, 3 }, { 2, 4 },
			},
		},
		Cygnus = {
			stars = {
				{ "Deneb", 20.69, 45.28, 1.3 }, { "Sadr", 20.37, 40.26, 2.2 },
				{ "Gienah", 20.77, 33.97, 2.5 }, { "Delta Cyg", 19.749, 45.13, 2.9 },
				{ "Albireo", 19.512, 27.96, 3.1 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 2, 4 }, { 2, 5 },
			},
		},
		Delphinus = {
			stars = {
				{ "Rotanev", 20.626, 14.6, 3.6 }, { "Sualocin", 20.661, 15.91, 3.8 },
				{ "Gamma Del", 20.777, 16.12, 3.9 }, { "Delta Del", 20.727, 15.07, 4.4 },
				{ "Epsilon Del", 20.555, 11.3, 4.0 },
			},
			lines = {
				{ 2, 3 }, { 3, 4 }, { 4, 1 }, { 1, 2 }, { 1, 5 },
			},
		},
		Dorado = {
			stars = {
				{ "Alpha Dor", 4.567, -55.04, 3.3 }, { "Beta Dor", 5.56, -62.49, 3.8 },
				{ "Gamma Dor", 4.269, -51.49, 4.2 },
			},
			lines = {
				{ 3, 1 }, { 1, 2 },
			},
		},
		Draco = {
			stars = {
				{ "Thuban", 14.073, 64.38, 3.7 }, { "Rastaban", 17.507, 52.3, 2.8 },
				{ "Eltanin", 17.943, 51.49, 2.2 }, { "Grumium", 17.892, 56.87, 3.7 },
				{ "Altais", 19.209, 67.66, 3.1 }, { "Aldhibah", 17.146, 65.71, 3.2 },
				{ "Edasich", 15.415, 58.97, 3.3 }, { "Giausar", 11.531, 69.33, 3.8 },
				{ "Kappa Dra", 12.558, 69.79, 3.9 }, { "Chi Dra", 18.352, 72.73, 3.6 },
			},
			lines = {
				{ 2, 3 }, { 3, 4 }, { 4, 6 }, { 6, 5 }, { 5, 10 },
				{ 10, 1 }, { 1, 7 }, { 7, 6 }, { 1, 9 }, { 9, 8 },
			},
		},
		Equuleus = {
			stars = {
				{ "Kitalpha", 21.263, 5.25, 3.9 }, { "Delta Equ", 21.245, 10.01, 4.5 },
				{ "Gamma Equ", 21.174, 10.13, 4.7 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 },
			},
		},
		Eridanus = {
			stars = {
				{ "Achernar", 1.629, -57.24, 0.5 }, { "Cursa", 5.131, -5.09, 2.8 },
				{ "Zaurak", 3.967, -13.51, 2.9 }, { "Acamar", 2.971, -40.3, 3.2 },
				{ "Theta2 Eri", 2.971, -40.3, 4.4 }, { "Epsilon Eri", 3.549, -9.46, 3.7 },
				{ "Tau4 Eri", 3.322, -21.76, 3.7 }, { "Upsilon Eri", 4.593, -30.56, 3.8 },
				{ "Phi Eri", 2.276, -51.51, 3.6 },
			},
			lines = {
				{ 2, 6 }, { 6, 3 }, { 3, 7 }, { 7, 8 }, { 8, 4 },
				{ 4, 9 }, { 9, 1 },
			},
		},
		Fornax = {
			stars = {
				{ "Dalim", 3.201, -28.99, 3.9 }, { "Beta For", 2.816, -32.41, 4.5 },
			},
			lines = {
				{ 1, 2 },
			},
		},
		Gemini = {
			stars = {
				{ "Castor", 7.577, 31.89, 1.6 }, { "Pollux", 7.755, 28.03, 1.1 },
				{ "Mebsuta", 6.732, 25.13, 3.0 }, { "Tejat", 6.383, 22.51, 2.9 },
				{ "Wasat", 7.335, 21.98, 3.5 }, { "Alhena", 6.629, 16.4, 1.9 },
			},
			lines = {
				{ 1, 2 }, { 1, 3 }, { 3, 4 }, { 2, 5 }, { 5, 6 },
			},
		},
		Grus = {
			stars = {
				{ "Alnair", 22.137, -46.96, 1.7 }, { "Beta Gru", 22.711, -46.88, 2.1 },
				{ "Gamma Gru", 21.899, -37.36, 3.0 }, { "Delta Gru", 22.487, -43.5, 4.0 },
				{ "Epsilon Gru", 22.807, -51.32, 3.5 },
			},
			lines = {
				{ 3, 4 }, { 4, 1 }, { 1, 2 }, { 2, 5 },
			},
		},
		Hercules = {
			stars = {
				{ "Kornephoros", 16.504, 21.49, 2.8 }, { "Zeta Her", 16.688, 31.6, 2.8 },
				{ "Pi Her", 17.251, 36.81, 3.2 }, { "Eta Her", 16.715, 38.92, 3.5 },
				{ "Epsilon Her", 17.005, 30.93, 3.9 }, { "Delta Her", 17.25, 24.84, 3.1 },
				{ "Rasalgethi", 17.244, 14.39, 3.1 }, { "Mu Her", 17.774, 27.72, 3.4 },
				{ "Xi Her", 17.965, 29.25, 3.7 }, { "Iota Her", 17.655, 46.01, 3.8 },
			},
			lines = {
				{ 7, 1 }, { 1, 2 }, { 2, 4 }, { 4, 3 }, { 3, 5 },
				{ 5, 2 }, { 5, 6 }, { 6, 8 }, { 8, 9 }, { 3, 10 },
			},
		},
		Horologium = {
			stars = {
				{ "Alpha Hor", 4.234, -42.29, 3.9 }, { "Beta Hor", 2.985, -64.07, 5.0 },
			},
			lines = {
				{ 1, 2 },
			},
		},
		Hydra = {
			stars = {
				{ "Alphard", 9.46, -8.66, 2.0 }, { "Gamma Hya", 13.315, -23.17, 3.0 },
				{ "Zeta Hya", 8.925, 5.95, 3.1 }, { "Nu Hya", 10.828, -16.19, 3.1 },
				{ "Pi Hya", 14.107, -26.68, 3.3 }, { "Epsilon Hya", 8.779, 6.42, 3.4 },
				{ "Xi Hya", 11.553, -31.86, 3.5 }, { "Lambda Hya", 10.181, -12.35, 3.6 },
				{ "Delta Hya", 8.629, 5.7, 4.1 },
			},
			lines = {
				{ 9, 6 }, { 6, 3 }, { 3, 1 }, { 1, 8 }, { 8, 4 },
				{ 4, 7 }, { 7, 2 }, { 2, 5 },
			},
		},
		Hydrus = {
			stars = {
				{ "Beta Hyi", 0.429, -77.25, 2.8 }, { "Alpha Hyi", 1.98, -61.57, 2.9 },
				{ "Gamma Hyi", 3.787, -74.24, 3.2 },
			},
			lines = {
				{ 2, 1 }, { 1, 3 },
			},
		},
		Indus = {
			stars = {
				{ "Alpha Ind", 20.626, -47.29, 3.1 }, { "Beta Ind", 20.913, -58.45, 3.7 },
				{ "Theta Ind", 21.331, -53.45, 4.4 },
			},
			lines = {
				{ 1, 3 }, { 3, 2 },
			},
		},
		Lacerta = {
			stars = {
				{ "Alpha Lac", 22.521, 50.28, 3.8 }, { "Beta Lac", 22.394, 52.23, 4.4 },
				{ "5 Lac", 22.499, 47.71, 4.4 }, { "1 Lac", 22.264, 37.75, 4.1 },
			},
			lines = {
				{ 2, 1 }, { 1, 3 }, { 3, 4 },
			},
		},
		Leo = {
			stars = {
				{ "Regulus", 10.139, 11.97, 1.4 }, { "Algieba", 10.333, 19.84, 2.0 },
				{ "Ras Elased", 9.764, 23.77, 3.0 }, { "Zosma", 11.235, 20.52, 2.6 },
				{ "Denebola", 11.818, 14.57, 2.1 }, { "Chort", 11.237, 15.43, 3.3 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 2, 4 }, { 4, 5 }, { 5, 6 },
				{ 6, 1 },
			},
		},
		["Leo Minor"] = {
			stars = {
				{ "46 LMi", 10.886, 34.22, 3.8 }, { "Beta LMi", 10.472, 36.71, 4.2 },
				{ "21 LMi", 10.124, 35.24, 4.5 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 },
			},
		},
		Lepus = {
			stars = {
				{ "Arneb", 5.545, -17.82, 2.6 }, { "Nihal", 5.471, -20.76, 2.8 },
				{ "Epsilon Lep", 5.093, -22.37, 3.2 }, { "Mu Lep", 5.216, -16.21, 3.3 },
				{ "Zeta Lep", 5.782, -14.82, 3.5 }, { "Gamma Lep", 5.744, -22.45, 3.6 },
			},
			lines = {
				{ 4, 1 }, { 1, 5 }, { 1, 2 }, { 2, 3 }, { 2, 6 },
			},
		},
		Libra = {
			stars = {
				{ "Zubeneschamali", 15.283, -9.38, 2.6 }, { "Zubenelgenubi", 14.848, -16.04, 2.7 },
				{ "Brachium", 15.067, -25.28, 3.3 }, { "Gamma Lib", 15.596, -14.79, 3.9 },
			},
			lines = {
				{ 2, 1 }, { 1, 4 }, { 4, 3 }, { 3, 2 },
			},
		},
		Lupus = {
			stars = {
				{ "Alpha Lup", 14.699, -47.39, 2.3 }, { "Beta Lup", 14.976, -43.13, 2.7 },
				{ "Gamma Lup", 15.585, -41.17, 2.8 }, { "Delta Lup", 15.356, -40.65, 3.2 },
				{ "Epsilon Lup", 15.379, -44.69, 3.4 }, { "Zeta Lup", 15.203, -52.1, 3.4 },
			},
			lines = {
				{ 1, 6 }, { 1, 2 }, { 2, 4 }, { 4, 3 }, { 3, 5 },
				{ 5, 1 },
			},
		},
		Lynx = {
			stars = {
				{ "Alpha Lyn", 9.351, 34.39, 3.1 }, { "38 Lyn", 9.317, 36.8, 3.8 },
				{ "31 Lyn", 8.383, 43.19, 4.2 }, { "21 Lyn", 7.444, 49.21, 4.6 },
				{ "15 Lyn", 6.96, 58.42, 4.3 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 5 },
			},
		},
		Lyra = {
			stars = {
				{ "Vega", 18.615, 38.78, 0.0 }, { "Zeta Lyr", 18.746, 37.6, 4.3 },
				{ "Delta Lyr", 18.908, 36.9, 4.2 }, { "Sulafat", 18.982, 32.69, 3.2 },
				{ "Sheliak", 18.834, 33.36, 3.5 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 5 }, { 5, 2 },
			},
		},
		Mensa = {
			stars = {
				{ "Alpha Men", 6.171, -74.75, 5.1 }, { "Gamma Men", 5.514, -76.34, 5.2 },
			},
			lines = {
				{ 1, 2 },
			},
		},
		Microscopium = {
			stars = {
				{ "Gamma Mic", 21.017, -32.26, 4.7 }, { "Epsilon Mic", 21.297, -32.18, 4.7 },
			},
			lines = {
				{ 1, 2 },
			},
		},
		Monoceros = {
			stars = {
				{ "Beta Mon", 6.482, -7.03, 3.7 }, { "Alpha Mon", 7.685, -9.55, 3.9 },
				{ "Gamma Mon", 6.248, -6.27, 4.0 }, { "Delta Mon", 7.198, -0.49, 4.1 },
			},
			lines = {
				{ 3, 1 }, { 1, 2 }, { 1, 4 },
			},
		},
		Musca = {
			stars = {
				{ "Alpha Mus", 12.62, -69.14, 2.7 }, { "Beta Mus", 12.771, -68.11, 3.0 },
				{ "Delta Mus", 13.037, -71.55, 3.6 }, { "Gamma Mus", 12.542, -72.13, 3.8 },
			},
			lines = {
				{ 2, 1 }, { 1, 4 }, { 4, 3 },
			},
		},
		Norma = {
			stars = {
				{ "Gamma2 Nor", 16.32, -50.16, 4.0 }, { "Epsilon Nor", 16.457, -47.55, 4.5 },
			},
			lines = {
				{ 1, 2 },
			},
		},
		Octans = {
			stars = {
				{ "Nu Oct", 21.691, -77.39, 3.8 }, { "Beta Oct", 22.767, -81.38, 4.1 },
				{ "Delta Oct", 14.454, -83.67, 4.3 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 },
			},
		},
		Ophiuchus = {
			stars = {
				{ "Rasalhague", 17.582, 12.56, 2.1 }, { "Cebalrai", 17.724, 4.57, 2.8 },
				{ "Yed Prior", 16.239, -3.69, 2.7 }, { "Yed Posterior", 16.304, -4.69, 3.2 },
				{ "Zeta Oph", 16.619, -10.57, 2.6 }, { "Eta Oph", 17.173, -15.72, 2.4 },
				{ "Nu Oph", 17.983, -9.77, 3.3 }, { "Kappa Oph", 16.961, 9.38, 3.2 },
			},
			lines = {
				{ 1, 8 }, { 8, 3 }, { 3, 4 }, { 4, 5 }, { 5, 6 },
				{ 6, 7 }, { 7, 2 }, { 2, 1 },
			},
		},
		Orion = {
			stars = {
				{ "Betelgeuse", 5.919, 7.41, 0.5 }, { "Bellatrix", 5.418, 6.35, 1.6 },
				{ "Mintaka", 5.533, -0.3, 2.2 }, { "Alnilam", 5.604, -1.2, 1.7 },
				{ "Alnitak", 5.679, -1.94, 1.8 }, { "Saiph", 5.796, -9.67, 2.1 },
				{ "Rigel", 5.242, -8.2, 0.1 }, { "Meissa", 5.585, 9.93, 3.4 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 5 }, { 5, 1 },
				{ 3, 7 }, { 5, 6 }, { 7, 6 }, { 1, 8 }, { 2, 8 },
			},
		},
		Pavo = {
			stars = {
				{ "Peacock", 20.427, -56.74, 1.9 }, { "Beta Pav", 20.749, -66.2, 3.4 },
				{ "Delta Pav", 20.145, -66.18, 3.6 }, { "Eta Pav", 17.762, -64.72, 3.6 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 3, 4 },
			},
		},
		Pegasus = {
			stars = {
				{ "Markab", 23.079, 15.21, 2.5 }, { "Scheat", 23.063, 28.08, 2.4 },
				{ "Algenib", 0.221, 15.18, 2.8 }, { "Alpheratz", 0.14, 29.09, 2.1 },
				{ "Enif", 21.736, 9.88, 2.4 }, { "Homam", 22.691, 10.83, 3.4 },
				{ "Matar", 22.717, 30.22, 2.9 },
			},
			lines = {
				{ 1, 2 }, { 2, 4 }, { 4, 3 }, { 3, 1 }, { 1, 6 },
				{ 6, 5 }, { 2, 7 },
			},
		},
		Perseus = {
			stars = {
				{ "Mirfak", 3.405, 49.86, 1.8 }, { "Algol", 3.136, 40.96, 2.1 },
				{ "Zeta Per", 3.902, 31.88, 2.8 }, { "Epsilon Per", 3.964, 40.01, 2.9 },
				{ "Gamma Per", 3.08, 53.51, 2.9 }, { "Delta Per", 3.715, 47.79, 3.0 },
				{ "Eta Per", 2.845, 55.9, 3.8 },
			},
			lines = {
				{ 7, 5 }, { 5, 1 }, { 1, 6 }, { 6, 4 }, { 4, 3 },
				{ 1, 2 }, { 2, 3 },
			},
		},
		Phoenix = {
			stars = {
				{ "Ankaa", 0.438, -42.31, 2.4 }, { "Beta Phe", 1.101, -46.72, 3.3 },
				{ "Gamma Phe", 1.472, -43.32, 3.4 }, { "Epsilon Phe", 0.157, -45.75, 3.9 },
			},
			lines = {
				{ 4, 1 }, { 1, 2 }, { 2, 3 },
			},
		},
		Pictor = {
			stars = {
				{ "Alpha Pic", 6.803, -61.94, 3.3 }, { "Beta Pic", 5.788, -51.07, 3.9 },
			},
			lines = {
				{ 1, 2 },
			},
		},
		Pisces = {
			stars = {
				{ "Alrescha", 2.034, 2.76, 3.8 }, { "Eta Psc", 1.525, 15.35, 3.6 },
				{ "Gamma Psc", 23.286, 3.28, 3.7 }, { "Omega Psc", 23.986, 6.86, 4.0 },
				{ "Iota Psc", 23.66, 5.63, 4.1 }, { "Lambda Psc", 23.7, 1.78, 4.5 },
				{ "Nu Psc", 1.683, 5.49, 4.4 },
			},
			lines = {
				{ 1, 7 }, { 7, 2 }, { 1, 6 }, { 6, 5 }, { 5, 3 },
				{ 3, 4 }, { 4, 6 },
			},
		},
		["Piscis Austrinus"] = {
			stars = {
				{ "Fomalhaut", 22.961, -29.62, 1.2 }, { "Epsilon PsA", 22.679, -27.04, 4.2 },
				{ "Delta PsA", 22.93, -32.54, 4.2 }, { "Beta PsA", 22.526, -32.35, 4.3 },
			},
			lines = {
				{ 1, 2 }, { 2, 4 }, { 4, 3 }, { 3, 1 },
			},
		},
		Puppis = {
			stars = {
				{ "Naos", 8.06, -40.0, 2.2 }, { "Tureis", 8.126, -24.3, 2.8 },
				{ "Pi Pup", 7.285, -37.1, 2.7 }, { "Nu Pup", 6.623, -43.2, 3.2 },
			},
			lines = {
				{ 4, 3 }, { 3, 1 }, { 1, 2 },
			},
		},
		Pyxis = {
			stars = {
				{ "Alpha Pyx", 8.726, -33.19, 3.7 }, { "Beta Pyx", 8.673, -35.31, 4.0 },
				{ "Gamma Pyx", 8.841, -27.71, 4.0 },
			},
			lines = {
				{ 2, 1 }, { 1, 3 },
			},
		},
		Reticulum = {
			stars = {
				{ "Alpha Ret", 4.24, -62.47, 3.3 }, { "Beta Ret", 3.737, -64.81, 3.8 },
				{ "Epsilon Ret", 4.274, -59.3, 4.4 }, { "Gamma Ret", 4.01, -62.16, 4.5 },
			},
			lines = {
				{ 1, 3 }, { 3, 4 }, { 4, 2 }, { 2, 1 },
			},
		},
		Sagitta = {
			stars = {
				{ "Gamma Sge", 19.979, 19.49, 3.5 }, { "Delta Sge", 19.789, 18.53, 3.8 },
				{ "Alpha Sge", 19.669, 18.01, 4.4 }, { "Beta Sge", 19.683, 17.48, 4.4 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 2, 4 },
			},
		},
		Sagittarius = {
			stars = {
				{ "Kaus Australis", 18.403, -34.38, 1.8 }, { "Nunki", 18.921, -26.3, 2.1 },
				{ "Ascella", 19.044, -29.88, 2.6 }, { "Kaus Media", 18.35, -29.83, 2.7 },
				{ "Kaus Borealis", 18.466, -25.42, 2.8 }, { "Alnasl", 18.097, -30.42, 3.0 },
				{ "Phi Sgr", 18.762, -26.99, 3.2 }, { "Tau Sgr", 19.116, -27.67, 3.3 },
			},
			lines = {
				{ 6, 4 }, { 4, 1 }, { 4, 5 }, { 5, 7 }, { 7, 2 },
				{ 2, 8 }, { 8, 3 }, { 3, 7 },
			},
		},
		Scorpius = {
			stars = {
				{ "Antares", 16.49, -26.43, 1.0 }, { "Graffias", 16.09, -19.81, 2.6 },
				{ "Dschubba", 16.005, -22.62, 2.3 }, { "Pi Sco", 15.981, -26.11, 2.9 },
				{ "Sigma Sco", 16.353, -25.59, 2.9 }, { "Tau Sco", 16.598, -28.22, 2.8 },
				{ "Shaula", 17.56, -37.1, 1.6 }, { "Sargas", 17.622, -42.99, 1.9 },
				{ "Lesath", 17.512, -37.3, 2.7 }, { "Epsilon Sco", 16.836, -34.29, 2.3 },
			},
			lines = {
				{ 2, 3 }, { 3, 4 }, { 3, 5 }, { 5, 1 }, { 1, 6 },
				{ 6, 10 }, { 10, 8 }, { 8, 9 }, { 9, 7 },
			},
		},
		Sculptor = {
			stars = {
				{ "Alpha Scl", 0.977, -29.36, 4.3 }, { "Beta Scl", 23.548, -37.82, 4.4 },
				{ "Gamma Scl", 23.315, -32.53, 4.4 },
			},
			lines = {
				{ 1, 3 }, { 3, 2 },
			},
		},
		Scutum = {
			stars = {
				{ "Alpha Sct", 18.586, -8.24, 3.8 }, { "Beta Sct", 18.786, -4.75, 4.2 },
				{ "Gamma Sct", 18.487, -14.57, 4.7 },
			},
			lines = {
				{ 2, 1 }, { 1, 3 },
			},
		},
		Serpens = {
			stars = {
				{ "Unukalhai", 15.738, 6.43, 2.6 }, { "Mu Ser", 15.824, -3.43, 3.5 },
				{ "Beta Ser", 15.77, 15.42, 3.7 }, { "Gamma Ser", 15.941, 15.66, 3.8 },
				{ "Kappa Ser", 15.811, 18.14, 4.1 }, { "Eta Ser", 18.355, -2.9, 3.2 },
				{ "Xi Ser", 17.628, -15.4, 3.5 }, { "Theta Ser", 18.939, 4.2, 4.0 },
			},
			lines = {
				{ 5, 3 }, { 3, 4 }, { 3, 1 }, { 1, 2 }, { 7, 6 },
				{ 6, 8 },
			},
		},
		Sextans = {
			stars = {
				{ "Alpha Sex", 10.132, -0.37, 4.5 }, { "Gamma Sex", 9.879, -8.1, 5.1 },
			},
			lines = {
				{ 1, 2 },
			},
		},
		Taurus = {
			stars = {
				{ "Aldebaran", 4.599, 16.51, 0.9 }, { "Elnath", 5.438, 28.61, 1.7 },
				{ "Alcyone", 3.791, 24.11, 2.9 }, { "Hyadum", 4.33, 15.63, 3.7 },
				{ "Ain", 4.478, 19.18, 3.5 }, { "Zeta Tau", 5.627, 21.14, 3.0 },
			},
			lines = {
				{ 1, 4 }, { 1, 5 }, { 5, 2 }, { 1, 6 }, { 4, 3 },
			},
		},
		Telescopium = {
			stars = {
				{ "Alpha Tel", 18.45, -45.97, 3.5 }, { "Zeta Tel", 18.485, -49.07, 4.1 },
			},
			lines = {
				{ 1, 2 },
			},
		},
		Triangulum = {
			stars = {
				{ "Mothallah", 1.885, 29.58, 3.4 }, { "Beta Tri", 2.159, 34.99, 3.0 },
				{ "Gamma Tri", 2.289, 33.85, 4.0 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 3, 1 },
			},
		},
		["Triangulum Australe"] = {
			stars = {
				{ "Atria", 16.811, -69.03, 1.9 }, { "Beta TrA", 15.919, -63.43, 2.8 },
				{ "Gamma TrA", 15.315, -68.68, 2.9 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 3, 1 },
			},
		},
		Tucana = {
			stars = {
				{ "Alpha Tuc", 22.308, -60.26, 2.9 }, { "Gamma Tuc", 23.294, -58.24, 4.0 },
				{ "Zeta Tuc", 0.336, -64.87, 4.2 }, { "Beta Tuc", 0.525, -62.96, 4.4 },
			},
			lines = {
				{ 1, 2 }, { 2, 4 }, { 4, 3 },
			},
		},
		["Ursa Major"] = {
			stars = {
				{ "Dubhe", 11.062, 61.75, 1.8 }, { "Merak", 11.031, 56.38, 2.4 },
				{ "Phecda", 11.897, 53.69, 2.4 }, { "Megrez", 12.257, 57.03, 3.3 },
				{ "Alioth", 12.9, 55.96, 1.8 }, { "Mizar", 13.399, 54.93, 2.2 },
				{ "Alkaid", 13.792, 49.31, 1.9 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 5 }, { 5, 6 },
				{ 6, 7 }, { 4, 1 },
			},
		},
		["Ursa Minor"] = {
			stars = {
				{ "Polaris", 2.53, 89.26, 2.0 }, { "Yildun", 17.537, 86.59, 4.4 },
				{ "Epsilon UMi", 16.766, 82.04, 4.2 }, { "Zeta UMi", 15.734, 77.79, 4.3 },
				{ "Kochab", 14.845, 74.16, 2.1 }, { "Pherkad", 15.345, 71.83, 3.0 },
				{ "Eta UMi", 16.291, 75.76, 5.0 },
			},
			lines = {
				{ 1, 2 }, { 2, 3 }, { 3, 4 }, { 4, 5 }, { 5, 6 },
				{ 6, 7 }, { 7, 4 },
			},
		},
		Vela = {
			stars = {
				{ "Suhail al Muhlif", 8.158, -47.34, 1.8 }, { "Markeb", 9.368, -55.01, 2.5 },
				{ "Suhail", 9.133, -43.43, 2.2 }, { "Delta Vel", 8.745, -54.71, 2.0 },
				{ "Mu Vel", 10.777, -49.42, 2.7 },
			},
			lines = {
				{ 1, 4 }, { 4, 2 }, { 2, 3 }, { 3, 5 }, { 3, 1 },
			},
		},
		Virgo = {
			stars = {
				{ "Spica", 13.42, -11.16, 1.0 }, { "Porrima", 12.694, -1.45, 2.7 },
				{ "Vindemiatrix", 13.036, 10.96, 2.8 }, { "Auva", 12.927, 3.4, 3.4 },
				{ "Zavijava", 11.845, 1.76, 3.6 }, { "Heze", 13.578, -0.6, 3.4 },
				{ "Syrma", 14.269, -6.0, 4.1 }, { "Zaniah", 12.333, -0.67, 3.9 },
			},
			lines = {
				{ 5, 8 }, { 8, 2 }, { 2, 4 }, { 4, 3 }, { 2, 1 },
				{ 1, 6 }, { 6, 7 },
			},
		},
		Volans = {
			stars = {
				{ "Beta Vol", 8.429, -66.14, 3.8 }, { "Gamma Vol", 7.145, -70.5, 3.8 },
				{ "Zeta Vol", 7.694, -72.61, 3.9 }, { "Delta Vol", 7.279, -67.96, 4.0 },
			},
			lines = {
				{ 2, 4 }, { 4, 1 }, { 1, 3 },
			},
		},
		Vulpecula = {
			stars = {
				{ "Anser", 19.478, 24.66, 4.4 }, { "15 Vul", 20.048, 27.81, 4.6 },
			},
			lines = {
				{ 1, 2 },
			},
		},
	};

	local ORDER = {
		"Andromeda", "Antlia", "Apus", "Aquarius",
		"Aquila", "Ara", "Aries", "Auriga",
		"Bootes", "Caelum", "Camelopardalis", "Cancer",
		"Canes Venatici", "Canis Major", "Canis Minor", "Capricornus",
		"Carina", "Cassiopeia", "Centaurus", "Cepheus",
		"Cetus", "Chamaeleon", "Circinus", "Columba",
		"Coma Berenices", "Corona Australis", "Corona Borealis", "Corvus",
		"Crater", "Crux", "Cygnus", "Delphinus",
		"Dorado", "Draco", "Equuleus", "Eridanus",
		"Fornax", "Gemini", "Grus", "Hercules",
		"Horologium", "Hydra", "Hydrus", "Indus",
		"Lacerta", "Leo", "Leo Minor", "Lepus",
		"Libra", "Lupus", "Lynx", "Lyra",
		"Mensa", "Microscopium", "Monoceros", "Musca",
		"Norma", "Octans", "Ophiuchus", "Orion",
		"Pavo", "Pegasus", "Perseus", "Phoenix",
		"Pictor", "Pisces", "Piscis Austrinus", "Puppis",
		"Pyxis", "Reticulum", "Sagitta", "Sagittarius",
		"Scorpius", "Sculptor", "Scutum", "Serpens",
		"Sextans", "Taurus", "Telescopium", "Triangulum",
		"Triangulum Australe", "Tucana", "Ursa Major", "Ursa Minor",
		"Vela", "Virgo", "Volans", "Vulpecula",
	};

	local TINT = {
		Betelgeuse = Color3.fromRGB(255, 154, 102), Antares = Color3.fromRGB(255, 148, 100),
		Tejat = Color3.fromRGB(255, 160, 112), ["Delta Lyr"] = Color3.fromRGB(255, 176, 128),
		Aldebaran = Color3.fromRGB(255, 184, 128), Schedar = Color3.fromRGB(255, 196, 142),
		Hyadum = Color3.fromRGB(255, 198, 146), Ain = Color3.fromRGB(255, 198, 146),
		Gienah = Color3.fromRGB(255, 196, 140), Albireo = Color3.fromRGB(255, 202, 138),
		Pollux = Color3.fromRGB(255, 202, 152), Algieba = Color3.fromRGB(255, 206, 160),
		Dubhe = Color3.fromRGB(255, 210, 170), ["Ras Elased"] = Color3.fromRGB(255, 226, 180),
		Mebsuta = Color3.fromRGB(255, 232, 190), Sadr = Color3.fromRGB(255, 244, 214),
		Wezen = Color3.fromRGB(255, 246, 222), Caph = Color3.fromRGB(255, 246, 224),
		Sargas = Color3.fromRGB(255, 248, 230),

		Wasat = Color3.fromRGB(246, 248, 255), Ruchbah = Color3.fromRGB(246, 248, 255),
		["Zeta Lyr"] = Color3.fromRGB(244, 247, 255), Chort = Color3.fromRGB(240, 246, 255),
		Alhena = Color3.fromRGB(240, 246, 255), Zosma = Color3.fromRGB(238, 244, 255),
		Megrez = Color3.fromRGB(238, 244, 255), Sirius = Color3.fromRGB(236, 244, 255),
		Merak = Color3.fromRGB(236, 242, 255), Phecda = Color3.fromRGB(236, 242, 255),
		["Delta Cyg"] = Color3.fromRGB(236, 243, 255), Castor = Color3.fromRGB(235, 242, 255),
		Denebola = Color3.fromRGB(235, 242, 255), Alioth = Color3.fromRGB(234, 241, 255),
		Mizar = Color3.fromRGB(234, 241, 255), Deneb = Color3.fromRGB(232, 240, 255),
		Vega = Color3.fromRGB(226, 236, 255),

		Elnath = Color3.fromRGB(208, 226, 255), Alkaid = Color3.fromRGB(206, 224, 255),
		Regulus = Color3.fromRGB(202, 222, 255), Sheliak = Color3.fromRGB(202, 220, 255),
		Sulafat = Color3.fromRGB(200, 219, 255), Muliphein = Color3.fromRGB(198, 218, 255),
		Segin = Color3.fromRGB(198, 218, 255), Rigel = Color3.fromRGB(196, 216, 255),
		["Gamma Cas"] = Color3.fromRGB(196, 217, 255), ["Zeta Tau"] = Color3.fromRGB(194, 215, 255),
		["Sigma Sco"] = Color3.fromRGB(192, 213, 255), Alcyone = Color3.fromRGB(192, 214, 255),
		Bellatrix = Color3.fromRGB(190, 212, 255), Saiph = Color3.fromRGB(190, 212, 255),
		Meissa = Color3.fromRGB(190, 212, 255), Aludra = Color3.fromRGB(190, 212, 255),
		["Pi Sco"] = Color3.fromRGB(190, 212, 255), Mintaka = Color3.fromRGB(188, 210, 255),
		Alnitak = Color3.fromRGB(188, 210, 255), Graffias = Color3.fromRGB(188, 210, 255),
		["Tau Sco"] = Color3.fromRGB(188, 210, 255), Alnilam = Color3.fromRGB(186, 209, 255),
		Mirzam = Color3.fromRGB(186, 209, 255), Dschubba = Color3.fromRGB(186, 209, 255),
		Shaula = Color3.fromRGB(184, 208, 255), Adhara = Color3.fromRGB(182, 207, 255),
	};

	local PLAIN = Color3.fromRGB(252, 250, 242);

	local C = {
		On = false,
		Star = Color3.fromRGB(255, 252, 235),
		Line = Color3.fromRGB(120, 175, 255),
		Scale = 100,
		Glow = 100,
		Lines = true,
		Labels = false,
		Spin = 12,
		Twinkle = 60,
		Natural = true,
		Always = true,
		Names = false,
		Field = true,
		Density = 220,
		Meteors = true,
		Rate = 12,
		Picked = {},
	};

	for _, name in ipairs(ORDER) do C.Picked[name] = true end;

	ESP.Constellations = C;

	local function place(ra, dec)
		local a = math.rad(ra * 15);
		local d = math.rad(dec);
		local flat = math.cos(d);

		return Vector3.new(flat * math.cos(a), math.sin(d), flat * math.sin(a));
	end;

	local host = Instance.new("Part");

	host.Name = NeverLose.RandomString();
	host.Anchored = true;
	host.CanCollide = false;
	host.CanQuery = false;
	host.CanTouch = false;
	host.Transparency = 1;
	host.Size = Vector3.one;
	host.Locked = true;
	host:SetAttribute(TAG, true);
	host.Parent = workspace;

	local gui = Instance.new("Folder");
	gui.Name = NeverLose.RandomString();
	gui.Parent = host;

	local glow;

	glow = Remote.asset("particles/p_glow.png");

	local built = {};
	local spin = 0;

	local TILT = math.rad(90 - 46);
	local COMPASS = math.rad(28);

	local dome = FAR;
	local domeScale = 1;

	local Lighting = game:GetService("Lighting");

	local function reach()
		if not C.Always then return FAR end;

		local air = Lighting:FindFirstChildOfClass("Atmosphere");
		local thick = (air and air.Density) or 0;

		return math.floor(math.clamp(NEAR * (1 - thick), 24, NEAR) / 2) * 2;
	end;

	local function skyfade(height)
		return math.clamp((height + 0.03) / 0.16, 0, 1);
	end;

	local function buildOne(name)
		local figure = FIGURES[name];

		if not figure then return nil end;

		local record = { stars = {}, beams = {}, born = os.clock(), sway = math.random() * math.pi * 2 };

		local middle = Vector3.zero;

		for index, star in ipairs(figure.stars) do
			local aim = place(star[2], star[3]);

			local anchor = Instance.new("Attachment");

			anchor.Name = NeverLose.RandomString();

			anchor.Position = aim * dome;
			anchor.Parent = host;

			local weight = math.clamp((5.2 - star[4]) / 6.2, 0.3, 1);

			local board = Instance.new("BillboardGui");

			board.Name = NeverLose.RandomString();
			board.Adornee = anchor;
			board.AlwaysOnTop = false;
			board.LightInfluence = 0;

			board.Size = UDim2.fromScale(1, 1);
			board.Parent = gui;

			local halo = Instance.new("ImageLabel");

			halo.BackgroundTransparency = 1;
			halo.AnchorPoint = Vector2.new(0.5, 0.5);
			halo.Position = UDim2.fromScale(0.5, 0.5);
			halo.Size = UDim2.fromScale(3.4, 3.4);
			halo.Image = glow or "rbxasset://textures/particles/sparkles_main.dds";
			halo.Parent = board;

			local dot = Instance.new("ImageLabel");

			dot.BackgroundTransparency = 1;
			dot.AnchorPoint = Vector2.new(0.5, 0.5);
			dot.Position = UDim2.fromScale(0.5, 0.5);
			dot.Size = UDim2.fromScale(1, 1);
			dot.Image = glow or "rbxasset://textures/particles/sparkles_main.dds";
			dot.Parent = board;

			local label;

			if star[1] then
				label = Instance.new("TextLabel");
				label.AnchorPoint = Vector2.new(0.5, 0);
				label.Position = UDim2.fromScale(0.5, 1);
				label.Size = UDim2.fromScale(4, 0.5);
				label.BackgroundTransparency = 1;
				label.Font = Enum.Font.Gotham;
				label.Text = star[1];
				label.TextSize = 11;
				label.TextTransparency = 0.35;
				label.Visible = false;
				label.Parent = board;
			end;

			middle = middle + aim;

			record.stars[index] = {
				anchor = anchor, board = board, dot = dot, halo = halo, label = label,
				weight = weight, aim = aim, home = aim * dome,
				tint = TINT[star[1]] or PLAIN,

				phase = math.random() * math.pi * 2,
				rate = 0.5 + math.random() * 1.3,

				delay = 0.04 * index,
				alpha = 0,
			};
		end;

		if #figure.stars > 0 then
			local aim = middle / #figure.stars;

			aim = (aim.Magnitude > 0.001) and aim.Unit or Vector3.yAxis;

			local seat = Instance.new("Attachment");

			seat.Name = NeverLose.RandomString();
			seat.Position = aim * dome;
			seat.Parent = host;

			local board = Instance.new("BillboardGui");

			board.Name = NeverLose.RandomString();
			board.Adornee = seat;
			board.AlwaysOnTop = false;
			board.LightInfluence = 0;
			board.Size = UDim2.fromScale(1, 1);
			board.Enabled = false;
			board.Parent = gui;

			local tag = Instance.new("TextLabel");

			tag.BackgroundTransparency = 1;
			tag.Size = UDim2.fromScale(1, 1);
			tag.Font = Enum.Font.Gotham;
			tag.Text = name;
			tag.TextScaled = true;
			tag.TextTransparency = 0.45;
			tag.Parent = board;

			record.title = { seat = seat, board = board, tag = tag, aim = aim };
		end;

		for order, pair in ipairs(figure.lines) do
			local from = record.stars[pair[1]];
			local to = record.stars[pair[2]];

			if from and to then
				local beam = Instance.new("Beam");

				beam.Attachment0 = from.anchor;
				beam.Attachment1 = to.anchor;
				beam.FaceCamera = true;
				beam.LightInfluence = 0;
				beam.LightEmission = 1;

				beam.Segments = 10;
				beam.Width0 = 4;
				beam.Width1 = 4;
				beam.Parent = host;

				record.beams[#record.beams + 1] = {
					beam = beam, a = from, b = to,

					delay = 0.45 + 0.05 * order,
					shown = -1,
				};
			end;
		end;

		return record;
	end;

	local function dropRecord(record)
		if record.title then
			pcall(function() record.title.board:Destroy() end);
			pcall(function() record.title.seat:Destroy() end);
		end;

		for _, line in ipairs(record.beams) do pcall(function() line.beam:Destroy() end) end;

		for _, star in ipairs(record.stars) do
			pcall(function() star.board:Destroy() end);
			pcall(function() star.anchor:Destroy() end);
		end;
	end;

	local meteors = {};
	local nextFall = 0;

	local function clearMeteors()
		for _, m in ipairs(meteors) do
			pcall(function() m.beam:Destroy() end);
			pcall(function() m.head:Destroy() end);
			pcall(function() m.tail:Destroy() end);
		end;

		table.clear(meteors);
	end;

	local function fall(now)

		local up = 0.3 + math.random() * 0.55;
		local turn = math.random() * math.pi * 2;
		local flat = math.sqrt(math.max(0, 1 - up * up));
		local from = Vector3.new(flat * math.cos(turn), up, flat * math.sin(turn)) * dome;
		local radial = from.Unit;

		local want = Vector3.new(math.random() - 0.5, -1.1, math.random() - 0.5);
		local dir = want - radial * want:Dot(radial);

		if dir.Magnitude < 0.05 then dir = radial:Cross(Vector3.yAxis) end;

		local head = Instance.new("Attachment");
		head.Name = NeverLose.RandomString();
		head.Parent = host;

		local tail = Instance.new("Attachment");
		tail.Name = NeverLose.RandomString();
		tail.Parent = host;

		local beam = Instance.new("Beam");
		beam.Attachment0 = tail;
		beam.Attachment1 = head;
		beam.FaceCamera = true;
		beam.LightInfluence = 0;
		beam.LightEmission = 1;
		beam.Segments = 8;
		beam.Width0 = 0.8;
		beam.Width1 = 11;
		beam.Parent = host;

		meteors[#meteors + 1] = {
			beam = beam, head = head, tail = tail,
			from = from, dir = dir.Unit, born = now,
			life = 0.9 + math.random() * 0.8,
			span = 240 + math.random() * 300,
			trail = 110 + math.random() * 150,
		};
	end;

	local function stepMeteors(now, color)
		if not C.Meteors then
			if #meteors > 0 then clearMeteors() end;

			nextFall = 0;

			return;
		end;

		if nextFall == 0 then
			nextFall = now + math.random() * 4;
		elseif now >= nextFall then

			local gap = 60 / math.max(1, C.Rate);

			nextFall = now + gap * (0.45 + math.random());

			if #meteors < 6 then fall(now) end;
		end;

		for i = #meteors, 1, -1 do
			local m = meteors[i];
			local t = (now - m.born) / m.life;

			if t >= 1 then
				pcall(function() m.beam:Destroy() end);
				pcall(function() m.head:Destroy() end);
				pcall(function() m.tail:Destroy() end);

				table.remove(meteors, i);
			else
				local at = m.from + m.dir * (m.span * t);
				local drawn = m.trail * math.min(1, t * 5);

				m.head.Position = at;
				m.tail.Position = at - m.dir * drawn;

				local fade = (t < 0.12) and (t / 0.12) or (1 - (t - 0.12) / 0.88) ^ 1.6;

				fade = fade * skyfade((host.CFrame:VectorToWorldSpace(at)).Unit.Y);

				m.beam.Color = ColorSequence.new(color);
				m.beam.Transparency = NumberSequence.new({
					NumberSequenceKeypoint.new(0, 1),
					NumberSequenceKeypoint.new(0.35, math.clamp(1 - fade * 0.25, 0, 1)),
					NumberSequenceKeypoint.new(1, math.clamp(1 - fade, 0, 1)),
				});
			end;
		end;
	end;

	local field = {};

	local function respan()
		local want = reach();

		if want == dome then return end;

		dome = want;
		domeScale = dome / FAR;

		for _, record in pairs(built) do
			for _, star in ipairs(record.stars) do
				star.home = star.aim * dome;
				star.anchor.Position = star.home;
			end;

			if record.title then
				record.title.seat.Position = record.title.aim * dome;
			end;
		end;

		for _, speck in ipairs(field) do
			speck.seat.Position = speck.aim * dome;
		end;

		clearMeteors();
	end;

	local fieldTurn = 0;
	local starTurn = 0;

	local function clearField()
		for _, speck in ipairs(field) do
			pcall(function() speck.board:Destroy() end);
			pcall(function() speck.seat:Destroy() end);
		end;

		table.clear(field);
	end;

	local function growField()
		local want = C.Field and math.floor(C.Density) or 0;

		while #field > want do
			local speck = table.remove(field);

			pcall(function() speck.board:Destroy() end);
			pcall(function() speck.seat:Destroy() end);
		end;

		while #field < want do

			local rise = math.random() * 2 - 1;
			local turn = math.random() * math.pi * 2;
			local flat = math.sqrt(math.max(0, 1 - rise * rise));
			local aim = Vector3.new(flat * math.cos(turn), rise, flat * math.sin(turn));

			local seat = Instance.new("Attachment");

			seat.Name = NeverLose.RandomString();
			seat.Position = aim * dome;
			seat.Parent = host;

			local board = Instance.new("BillboardGui");

			board.Name = NeverLose.RandomString();
			board.Adornee = seat;
			board.LightInfluence = 0;
			board.Size = UDim2.fromScale(1, 1);
			board.Parent = gui;

			local dot = Instance.new("ImageLabel");

			dot.BackgroundTransparency = 1;
			dot.AnchorPoint = Vector2.new(0.5, 0.5);
			dot.Position = UDim2.fromScale(0.5, 0.5);
			dot.Size = UDim2.fromScale(1, 1);
			dot.Image = glow or "rbxasset://textures/particles/sparkles_main.dds";
			dot.Parent = board;

			field[#field + 1] = {
				seat = seat, board = board, dot = dot, aim = aim,

				weight = 0.1 + (math.random() ^ 3) * 0.28,
				phase = math.random() * math.pi * 2,
				rate = 0.4 + math.random() * 1.4,
				warm = math.random() < 0.3,
			};
		end;
	end;

	local function teardown()
		for name, record in pairs(built) do
			dropRecord(record);

			built[name] = nil;
		end;

		clearMeteors();
		clearField();
	end;

	local function sync()
		if not C.On then
			teardown();

			return;
		end;

		for _, name in ipairs(ORDER) do
			if C.Picked[name] and not built[name] then
				built[name] = buildOne(name);
			elseif not C.Picked[name] and built[name] then
				dropRecord(built[name]);

				built[name] = nil;
			end;
		end;
	end;

	local function ribbon(base)
		return NumberSequence.new(base);
	end;

	local function step(dt)
		if not (ALIVE and C.On) then return end;

		local camera = Render.camera();

		if not camera then return end;

		local now = os.clock();

		spin = (spin + dt * (C.Spin / 1000)) % (math.pi * 2);

		host.CFrame = CFrame.new(camera.CFrame.Position)
			* CFrame.Angles(0, COMPASS, 0)
			* CFrame.Angles(TILT, 0, 0)
			* CFrame.Angles(0, spin, 0);

		respan();

		local scale = (C.Scale / 100) * domeScale;
		local glowAmount = C.Glow / 100;
		local twinkle = C.Twinkle / 100;
		local natural = C.Natural;
		local frame = host.CFrame;

		stepMeteors(now, natural and Color3.fromRGB(255, 244, 222) or C.Star);

		growField();

		local warmTone = C.Star:Lerp(Color3.fromRGB(255, 198, 150), 0.5);

		fieldTurn = (fieldTurn + 1) % 3;

		for index = 1 + fieldTurn, #field, 3 do
			local speck = field[index];
			local horizon = skyfade((frame:VectorToWorldSpace(speck.aim * dome)).Unit.Y);

			if horizon <= 0.002 then
				if speck.board.Enabled then speck.board.Enabled = false end;
			else
				if not speck.board.Enabled then speck.board.Enabled = true end;

				local pulse = 1 + twinkle * 0.2 * math.sin(now * speck.rate + speck.phase);
				local lit = glowAmount * horizon * speck.weight * pulse;
				local size = 78 * speck.weight * scale * pulse;

				speck.board.Size = UDim2.fromScale(size, size);
				speck.board.AlwaysOnTop = C.Always;

				local tone = (natural and speck.warm) and warmTone or C.Star;

				if speck.tone ~= tone then
					speck.tone = tone;
					speck.dot.ImageColor3 = tone;
				end;

				speck.dot.ImageTransparency = math.clamp(1 - lit, 0, 1);
			end;
		end;

		for _, record in pairs(built) do

			local breath = 0.92 + 0.08 * math.sin(now * 0.32 + record.sway);
			local age = now - record.born;

			starTurn = 1 - starTurn;

			for index = 1 + starTurn, #record.stars, 2 do
				local star = record.stars[index];
				local height = (frame:VectorToWorldSpace(star.home)).Unit.Y;
				local horizon = skyfade(height);

				if horizon <= 0.002 then
					if star.board.Enabled then star.board.Enabled = false end;

					continue;
				end;

				if not star.board.Enabled then star.board.Enabled = true end;

				star.alpha = math.clamp((age - star.delay) / 0.55, 0, 1);

				local pulse = 1 + twinkle * 0.16 * math.sin(now * star.rate + star.phase)
					+ twinkle * 0.07 * math.sin(now * star.rate * 2.7 + star.phase * 1.7);

				local lit = glowAmount * horizon * star.alpha * breath
					* (0.35 + star.weight * 0.65) * pulse;

				local size = 78 * star.weight * scale * (0.55 + 0.45 * star.alpha)
					* (1 + twinkle * 0.08 * (pulse - 1) * 6);

				local tone = natural and star.tint:Lerp(C.Star, 0.35) or C.Star;

				star.board.Size = UDim2.fromScale(size, size);

				if star.board.AlwaysOnTop ~= C.Always then
					star.board.AlwaysOnTop = C.Always;
				end;

				if star.tone ~= tone then
					star.tone = tone;
					star.dot.ImageColor3 = tone;
					star.halo.ImageColor3 = tone;
				end;

				star.dot.ImageTransparency = math.clamp(1 - lit, 0, 1);

				star.halo.ImageTransparency = math.clamp(1 - lit * star.weight * 0.7, 0, 1);

				if star.label then
					star.label.Visible = C.Labels and horizon > 0.25 and star.weight > 0.62;
					star.label.TextColor3 = tone;
					star.label.TextTransparency = math.clamp(0.35 + (1 - horizon) * 0.65, 0, 1);
				end;
			end;

			if record.title then
				local title = record.title;
				local height = (frame:VectorToWorldSpace(title.aim * dome)).Unit.Y;
				local horizon = skyfade(height);
				local want = C.Names and horizon > 0.2;

				if title.board.Enabled ~= want then title.board.Enabled = want end;

				if want then
					local span = 26 * scale;

					title.board.Size = UDim2.fromScale(span * 4, span);
					title.board.AlwaysOnTop = C.Always;
					title.tag.TextColor3 = C.Line;
					title.tag.TextTransparency = math.clamp(0.5 + (1 - horizon) * 0.5, 0, 1);
				end;
			end;

			for _, line in ipairs(record.beams) do
				local beam = line.beam;

				if not C.Lines then
					beam.Enabled = false;
				else
					local reach = math.min(
						skyfade((frame:VectorToWorldSpace(line.a.home)).Unit.Y),
						skyfade((frame:VectorToWorldSpace(line.b.home)).Unit.Y)
					);

					local drawn = math.clamp((age - line.delay) / 0.7, 0, 1);
					local lit = glowAmount * reach * drawn * breath;
					local want = lit > 0.02;

					if beam.Enabled ~= want then beam.Enabled = want end;

					if want then

						local base = math.clamp(1 - lit * 1.35, 0.42, 0.9);

						if math.abs(base - line.shown) > 0.015 then
							line.shown = base;
							beam.Transparency = ribbon(base);
						end;

						local wide = 4 * scale;

						if line.wide ~= wide then
							line.wide = wide;
							beam.Width0 = wide;
							beam.Width1 = wide;
						end;

						if line.natural ~= natural or line.tone ~= C.Line then
							line.natural = natural;
							line.tone = C.Line;

							beam.Color = natural
								and ColorSequence.new(line.a.tint:Lerp(C.Line, 0.55), line.b.tint:Lerp(C.Line, 0.55))
								or ColorSequence.new(C.Line);
						end;
					end;
				end;
			end;
		end;
	end;

	NeverLose:AddSignal(RunService.RenderStepped:Connect(step));

	local row = Sections.Stars:AddLabel("Constellations");

	row:AddToggle({
		Name = "Constellations",
		Default = false,
		Flag = "stars",
		Callback = function(v) C.On = v; sync() end,
	});

	row:AddColorPicker({
		Default = C.Star,
		Flag = "stars_color",
		Callback = function(v) C.Star = v end,
	});

	local lineRow = Sections.Stars:AddLabel("Lines");

	lineRow:AddToggle({
		Name = "Lines",
		Default = true,
		Flag = "stars_lines",
		Callback = function(v) C.Lines = v end,
	});

	lineRow:AddColorPicker({
		Default = C.Line,
		Flag = "stars_line_color",
		Callback = function(v) C.Line = v end,
	});

	Sections.Stars:AddLabel("Constellations"):AddDropdown({
		Default = ORDER,
		Values = ORDER,
		Multi = true,
		Flag = "stars_pick",
		Callback = function(value)
			local picked = {};

			if type(value) == "table" then
				for key, item in pairs(value) do
					if type(key) == "string" and item then
						picked[key] = true;
					elseif type(item) == "string" then
						picked[item] = true;
					end;
				end;
			elseif type(value) == "string" then
				picked[value] = true;
			end;

			C.Picked = picked;

			sync();
		end,
	});

	Sections.Stars:AddLabel("Size"):AddSlider({
		Min = 20, Max = 260, Default = 100, Rounding = 0, Type = "%", Size = 100,
		Flag = "stars_scale",
		Callback = function(v) C.Scale = v end,
	});

	Sections.Stars:AddLabel("Glow"):AddSlider({
		Min = 10, Max = 100, Default = 100, Rounding = 0, Type = "%", Size = 100,
		Flag = "stars_glow",
		Callback = function(v) C.Glow = v end,
	});

	Sections.Stars:AddLabel("Drift"):AddSlider({
		Min = 0, Max = 60, Default = 12, Rounding = 0, Size = 100,
		Flag = "stars_spin",
		Callback = function(v) C.Spin = v end,
	});

	Sections.Stars:AddLabel("Twinkle"):AddSlider({
		Min = 0, Max = 100, Default = 60, Rounding = 0, Type = "%", Size = 100,
		Flag = "stars_twinkle",
		Callback = function(v) C.Twinkle = v end,
	});

	Sections.Stars:AddLabel("Draw On Top"):AddToggle({
		Name = "Draw On Top",
		Default = true,
		Flag = "stars_always",
		Callback = function(v) C.Always = v end,
	});

	Sections.Stars:AddLabel("Real Star Colors"):AddToggle({
		Name = "Real Star Colors",
		Default = true,
		Flag = "stars_natural",
		Callback = function(v) C.Natural = v end,
	});

	local fallRow = Sections.Stars:AddLabel("Shooting Stars");

	fallRow:AddToggle({
		Name = "Shooting Stars",
		Default = true,
		Flag = "stars_meteors",
		Callback = function(v) C.Meteors = v end,
	});

	fallRow:AddSlider({
		Min = 1, Max = 60, Default = 12, Rounding = 0, Size = 90,
		Flag = "stars_meteor_rate",
		Callback = function(v) C.Rate = v end,
	});

	local fieldRow = Sections.Stars:AddLabel("Background Stars");

	fieldRow:AddToggle({
		Name = "Background Stars",
		Default = true,
		Flag = "stars_field",
		Callback = function(v)
			C.Field = v;

			if not v then clearField() end;
		end,
	});

	fieldRow:AddSlider({
		Min = 60, Max = 700, Default = 220, Rounding = 0, Size = 80,
		Flag = "stars_density",
		Callback = function(v) C.Density = v end,
	});

	Sections.Stars:AddLabel("Names"):AddToggle({
		Name = "Names",
		Default = false,
		Flag = "stars_names",
		Callback = function(v) C.Names = v end,
	});

	Sections.Stars:AddLabel("Star Labels"):AddToggle({
		Name = "Star Labels",
		Default = false,
		Flag = "stars_labels",
		Callback = function(v) C.Labels = v end,
	});

	ESP.ClearConstellations = onUnload("constellations", function()
		C.On = false;

		teardown();

		pcall(function() host:Destroy() end);
	end);
end);

guard("starfall", function()
	local S = {
		On = false,
		Rate = 40,
		Speed = 100,
		Length = 100,
		Size = 100,
		Head = Color3.fromRGB(255, 252, 244),
		Tail = Color3.fromRGB(140, 190, 255),
		Fireballs = true,
	};

	ESP.Starfall = S;

	local DOME = 180;
	local POOL = 34;

	local rng = Random.new(os.clock() * 1000 % 1e6);

	local sky = Instance.new("Part");

	sky.Name = NeverLose.RandomString();
	sky.Anchored = true;
	sky.CanCollide = false;
	sky.CanQuery = false;
	sky.CanTouch = false;
	sky.Transparency = 1;
	sky.Size = Vector3.one;
	sky.Locked = true;
	sky:SetAttribute(TAG, true);
	sky.Parent = workspace;

	local heads = Instance.new("Folder");

	heads.Name = NeverLose.RandomString();
	heads.Parent = sky;

	local dot = Remote.asset("particles/p_glow.png");

	local FADES = {};

	for step = 0, 24 do
		local lit = step / 24;

		FADES[step] = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 1),
			NumberSequenceKeypoint.new(0.45, math.clamp(1 - lit * 0.12, 0, 1)),
			NumberSequenceKeypoint.new(0.82, math.clamp(1 - lit * 0.6, 0, 1)),
			NumberSequenceKeypoint.new(0.95, math.clamp(1 - lit * 0.95, 0, 1)),
			NumberSequenceKeypoint.new(1, math.clamp(1 - lit * 0.3, 0, 1)),
		});
	end;

	local slots = {};
	local idle = {};

	for i = 1, POOL do
		local tail = Instance.new("Attachment");
		local nose = Instance.new("Attachment");

		tail.Name = NeverLose.RandomString();
		nose.Name = NeverLose.RandomString();
		tail.Parent = sky;
		nose.Parent = sky;

		local line = Instance.new("Beam");

		line.Attachment0 = tail;
		line.Attachment1 = nose;
		line.FaceCamera = true;
		line.LightInfluence = 0;
		line.LightEmission = 1;
		line.Segments = 24;
		line.Width0 = 0;
		line.Enabled = false;
		line.Parent = sky;

		local card = Instance.new("BillboardGui");

		card.Name = NeverLose.RandomString();
		card.Adornee = nose;
		card.AlwaysOnTop = true;
		card.LightInfluence = 0;
		card.Size = UDim2.fromScale(1, 1);
		card.Enabled = false;
		card.Parent = heads;

		local blob = Instance.new("ImageLabel");

		blob.BackgroundTransparency = 1;
		blob.AnchorPoint = Vector2.new(0.5, 0.5);
		blob.Position = UDim2.fromScale(0.5, 0.5);
		blob.Size = UDim2.fromScale(1, 1);
		blob.Image = dot or "rbxasset://textures/particles/sparkles_main.dds";
		blob.Parent = card;

		slots[i] = { tail = tail, nose = nose, line = line, card = card, blob = blob, busy = false };
		idle[i] = slots[i];
	end;

	local function park(slot)
		slot.busy = false;
		slot.line.Enabled = false;
		slot.card.Enabled = false;

		idle[#idle + 1] = slot;
	end;

	local function parkAll()
		for _, slot in ipairs(slots) do
			if slot.busy then park(slot) end;
		end;
	end;

	local origin = Vector3.new(0.25, 0.86, 0.45).Unit;
	local due = 0;

	local function fire(now)
		local slot = table.remove(idle);

		if not slot then return end;

		local off = rng:NextUnitVector() * rng:NextNumber(0.15, 0.95);
		local from = (origin + off).Unit;

		if from.Y < 0.28 then
			from = Vector3.new(from.X, 0.28 + rng:NextNumber(0, 0.4), from.Z).Unit;
		end;

		local out = (from - origin);

		if out.Magnitude < 0.03 then out = from:Cross(Vector3.yAxis) end;

		out = out - from * out:Dot(from);
		out = (out.Magnitude > 0.01) and out.Unit or from:Cross(Vector3.yAxis).Unit;

		local down = Vector3.yAxis - from * from:Dot(Vector3.yAxis);
		local dive = (down.Magnitude > 0.01) and -down.Unit or out;

		slot.busy = true;
		slot.from = from * DOME;
		slot.dir = (out * 0.65 + dive * 0.7).Unit;
		slot.born = now;
		slot.fire = S.Fireballs and rng:NextNumber() < 0.08;
		slot.life = slot.fire and rng:NextNumber(1.4, 2.0) or rng:NextNumber(0.5, 0.95);

		slot.mass = slot.fire and rng:NextNumber(1.8, 2.6) or (0.35 + rng:NextNumber() ^ 2.4 * 0.9);
		slot.run = DOME * rng:NextNumber(0.30, 0.62);
	end;

	local function step()
		if not (ALIVE and S.On) then return end;

		local cam = Render.camera();

		if not cam then return end;

		sky.CFrame = CFrame.new(cam.CFrame.Position);

		local now = os.clock();

		origin = CFrame.fromAxisAngle(Vector3.yAxis, 0.0002):VectorToWorldSpace(origin).Unit;

		if due == 0 then
			due = now + rng:NextNumber(0, 1);
		elseif now >= due then
			due = now + (60 / math.max(1, S.Rate)) * rng:NextNumber(0.4, 1.7);

			fire(now);
		end;

		local wide = S.Size / 100;
		local long = S.Length / 100;
		local pace = S.Speed / 100;

		for _, slot in ipairs(slots) do
			if slot.busy then
				local t = (now - slot.born) / slot.life;

				if t >= 1 then
					park(slot);
				else

					local nose = (slot.from + slot.dir * (slot.run * pace * t)).Unit * DOME;
					local span = DOME * 0.2 * long * (0.55 + slot.mass * 0.45);
					local tail = (nose - slot.dir * span);

					slot.nose.Position = nose;
					slot.tail.Position = tail;

					local lit = math.min(t / 0.07, 1) * (1 - t) ^ 0.8;

					lit = lit * math.clamp((nose.Unit.Y - 0.04) / 0.16, 0, 1);

					local glow = DOME * 0.028 * wide * slot.mass * (0.7 + lit * 0.6);

					slot.line.Enabled = lit > 0.015;
					slot.card.Enabled = lit > 0.015;

					if lit > 0.015 then
						slot.line.Width1 = math.max(0.05, DOME * 0.011 * wide * slot.mass);
						slot.line.Color = ColorSequence.new(S.Tail, S.Head);
						slot.line.Transparency = FADES[math.floor(math.clamp(lit, 0, 1) * 24 + 0.5)];

						slot.card.Size = UDim2.fromScale(glow, glow);
						slot.blob.ImageColor3 = S.Head;
						slot.blob.ImageTransparency = math.clamp(1 - lit * 1.2, 0, 1);
					end;
				end;
			end;
		end;
	end;

	NeverLose:AddSignal(RunService.RenderStepped:Connect(step));

	local row = Sections.Shaders:AddLabel("Starfall");

	row:AddToggle({
		Name = "Starfall",
		Default = false,
		Flag = "starfall",
		Callback = function(v)
			S.On = v;

			if not v then parkAll() end;
		end,
	});

	row:AddColorPicker({
		Default = S.Head,
		Flag = "starfall_head",
		Callback = function(v) S.Head = v end,
	});

	local more = row:AddOption(1);

	more:AddLabel("Tail Color"):AddColorPicker({
		Default = S.Tail,
		Flag = "starfall_tail",
		Callback = function(v) S.Tail = v end,
	});

	more:AddLabel("Rate"):AddSlider({
		Min = 2, Max = 200, Default = 40, Rounding = 0, Size = 90,
		Flag = "starfall_rate",
		Callback = function(v) S.Rate = v end,
	});

	more:AddLabel("Speed"):AddSlider({
		Min = 30, Max = 250, Default = 100, Rounding = 0, Type = "%", Size = 90,
		Flag = "starfall_speed",
		Callback = function(v) S.Speed = v end,
	});

	more:AddLabel("Tail Length"):AddSlider({
		Min = 25, Max = 260, Default = 100, Rounding = 0, Type = "%", Size = 90,
		Flag = "starfall_length",
		Callback = function(v) S.Length = v end,
	});

	more:AddLabel("Size"):AddSlider({
		Min = 30, Max = 250, Default = 100, Rounding = 0, Type = "%", Size = 90,
		Flag = "starfall_size",
		Callback = function(v) S.Size = v end,
	});

	more:AddLabel("Fireballs"):AddToggle({
		Name = "Fireballs",
		Default = true,
		Flag = "starfall_fireballs",
		Callback = function(v) S.Fireballs = v end,
	});

	ESP.ClearStarfall = onUnload("starfall", function()
		S.On = false;

		parkAll();

		pcall(function() sky:Destroy() end);
	end);
end);

guard("weather", function()
	local SOFT = "rbxasset://textures/particles/smoke_main.dds";
	local DOT = "rbxassetid://241876428";

	for _, leftover in ipairs(workspace:GetChildren()) do
		if leftover:GetAttribute(TAG) and leftover:FindFirstChildWhichIsA("ParticleEmitter") then
			leftover:Destroy();
		end;
	end;

	local TYPES = {
		Snow = {

			texture = DOT,
			color = Color3.fromRGB(226, 240, 255),
			lifetime = NumberRange.new(4, 6),
			speed = NumberRange.new(6, 12),
			acceleration = Vector3.new(2, -6, 1),
			spread = Vector2.new(35, 35),
			spin = NumberRange.new(-40, 40),
			size = 0.16,
			squash = 0,
			emission = 0.15,
			transparency = { 0.1, 0.2 },
			fade = 0.8,
		},
		["Snow Soft"] = {

			color = Color3.fromRGB(150, 200, 255),
			lifetime = NumberRange.new(4, 6),
			speed = NumberRange.new(6, 12),
			acceleration = Vector3.new(2, -6, 1),
			spread = Vector2.new(35, 35),
			spin = NumberRange.new(-40, 40),
			size = 0.55,
			squash = 0,
			emission = 0.4,
			transparency = { 0.2, 0.3 },
			fade = 0.8,
		},
		Sakura = {
			color = Color3.fromRGB(255, 170, 210),
			lifetime = NumberRange.new(5, 7),
			speed = NumberRange.new(5, 10),
			acceleration = Vector3.new(4, -5, 2),
			spread = Vector2.new(40, 40),
			spin = NumberRange.new(-80, 80),
			size = 0.5,
			squash = 1.4,
			emission = 0.4,
			transparency = { 0.15, 0.25 },
			fade = 0.85,
		},
		Rain = {
			color = Color3.fromRGB(170, 200, 255),
			lifetime = NumberRange.new(1.1, 1.6),
			speed = NumberRange.new(70, 95),
			acceleration = Vector3.new(0, -40, 0),

			spread = Vector2.new(2, 2),
			spin = NumberRange.new(0, 0),
			size = 0.28,
			squash = 9,
			emission = 0.2,
			transparency = { 0.35, 0.45 },
			fade = 0.9,

			orientation = Enum.ParticleOrientation.VelocityParallel,
			rotation = NumberRange.new(0, 0),
			lean = Vector3.new(6, 0, 4),
		},
		Ash = {
			color = Color3.fromRGB(90, 90, 95),
			lifetime = NumberRange.new(6, 9),
			speed = NumberRange.new(3, 7),
			acceleration = Vector3.new(3, -3, 2),
			spread = Vector2.new(45, 45),
			spin = NumberRange.new(-25, 25),
			size = 0.32,
			squash = 0,
			emission = 0.1,
			transparency = { 0.25, 0.4 },
			fade = 0.85,
		},
		Fireflies = {
			color = Color3.fromRGB(255, 220, 120),
			lifetime = NumberRange.new(3, 5),
			speed = NumberRange.new(1, 3),
			acceleration = Vector3.new(0, 0.5, 0),
			spread = Vector2.new(180, 180),
			spin = NumberRange.new(-10, 10),
			size = 0.22,
			squash = 0,
			emission = 1,
			transparency = { 0.1, 0.1 },
			fade = 0.75,
		},
	};

	local W = {
		Kind = "Off",
		Rate = 250,
		Speed = 100,
		Size = 100,
		Fade = 100,
		Distance = 260,
		Height = 140,
		Color = TYPES.Snow.color,
	};

	local part, emitter, conn, lastPos, lastLook;

	local colorNow, colorTarget = W.Color, W.Color;

	local function easeColour(target)
		colorTarget = target;
	end;

	local function stepColour()
		if not emitter then return end;

		local dr, dg, db = colorNow.R - colorTarget.R, colorNow.G - colorTarget.G, colorNow.B - colorTarget.B;

		if dr * dr + dg * dg + db * db < 0.00002 then
			if colorNow ~= colorTarget then
				colorNow = colorTarget;
				emitter.Color = ColorSequence.new(colorNow);
			end;

			return;
		end;

		colorNow = colorNow:Lerp(colorTarget, 0.09);
		emitter.Color = ColorSequence.new(colorNow);
	end;

	local function style()
		local preset = TYPES[W.Kind];
		if not (emitter and preset) then return end;

		local scale = W.Speed / 100;

		emitter.Texture = preset.texture or SOFT;
		emitter.LightInfluence = 0;
		emitter.LightEmission = preset.emission;
		emitter.ZOffset = 0;
		emitter.Drag = 0;
		emitter.EmissionDirection = Enum.NormalId.Bottom;
		emitter.Rate = W.Rate;
		emitter.Color = ColorSequence.new(colorNow);

		emitter.Rotation = preset.rotation or NumberRange.new(0, 360);
		emitter.RotSpeed = preset.spin;
		emitter.SpreadAngle = preset.spread;

		pcall(function()
			emitter.Orientation = preset.orientation or Enum.ParticleOrientation.FacingCamera;
		end);

		emitter.Speed = NumberRange.new(preset.speed.Min * scale, preset.speed.Max * scale);
		emitter.Acceleration = (preset.acceleration + (preset.lean or Vector3.zero)) * scale;

		emitter.Lifetime = NumberRange.new(preset.lifetime.Min / scale, preset.lifetime.Max / scale);
		emitter.Size = NumberSequence.new(preset.size * (W.Size / 100));

		pcall(function() emitter.Squash = NumberSequence.new(preset.squash) end);

		local ghost = W.Fade / 100;
		local head = math.clamp(1 - (1 - preset.transparency[1]) / ghost, 0, 1);
		local tail = math.clamp(1 - (1 - preset.transparency[2]) / ghost, 0, 1);

		emitter.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, head),
			NumberSequenceKeypoint.new(preset.fade, tail),
			NumberSequenceKeypoint.new(1, 1),
		});
	end;

	local function resize()
		if not part then return end;

		part.Size = Vector3.new(W.Distance, W.Height, W.Distance);
		lastPos, lastLook = nil, nil;
	end;

	local function stop()
		if conn then pcall(function() conn:Disconnect() end) conn = nil end;
		if part then pcall(function() part:Destroy() end) part = nil end;

		emitter, lastPos, lastLook = nil, nil, nil;
	end;

	local function ensurePart()
		if part and part.Parent then return end;

		part = Instance.new("Part");
		part.Name = NeverLose.RandomString();
		part.Anchored = true;
		part.CanCollide = false;
		part.CanQuery = false;
		part.CanTouch = false;
		part.CastShadow = false;
		part.Transparency = 1;
		part.Size = Vector3.new(W.Distance, W.Height, W.Distance);
		part:SetAttribute(TAG, true);
		part.Parent = workspace;

		emitter = Instance.new("ParticleEmitter");

		pcall(function()
			emitter.Shape = Enum.ParticleEmitterShape.Box;
			emitter.ShapeStyle = Enum.ParticleEmitterShapeStyle.Volume;
		end);

		emitter.Parent = part;

		style();
	end;

	local function burst()
		if not emitter then return end;

		emitter:Emit(math.clamp(math.floor(W.Rate * 0.16), 30, 140));
	end;

	local function start()
		ensurePart();

		if conn then return end;

		lastPos, lastLook = nil, nil;

		conn = NeverLose:AddSignal(RunService.RenderStepped:Connect(function()
			if not (part and part.Parent) then return end;

			stepColour();

			local camera = workspace.CurrentCamera;
			if not camera then return end;

			local cf = camera.CFrame;
			local at = cf.Position;
			local look = cf.LookVector;
			local flat = Vector3.new(look.X, 0, look.Z);

			if flat.Magnitude < 0.05 then
				flat = Vector3.new(0, 0, -1);
			else
				flat = flat.Unit;
			end;

			if lastPos and lastLook and (at - lastPos).Magnitude < 10 and flat:Dot(lastLook) > 0.95 then return end;

			lastPos, lastLook = at, flat;
			part.CFrame = CFrame.new(at + flat * (W.Distance * 0.22) + Vector3.new(0, W.Height * 0.5 - 26, 0));
		end));

		burst();
	end;

	ESP.Weather = W;
	ESP.ClearWeather = stop;

	local colorPicker;

	Sections.Weather:AddLabel("Type"):AddDropdown({
		Default = "Off",
		Values = { "Off", "Snow", "Snow Soft", "Sakura", "Rain", "Ash", "Fireflies" },
		Flag = "weather_kind",
		Callback = function(v)
			W.Kind = v;

			if v == "Off" then
				stop();
				return;
			end;

			W.Color = TYPES[v].color;
			easeColour(W.Color);

			if colorPicker and colorPicker.SetValue then
				pcall(colorPicker.SetValue, colorPicker, W.Color);
			end;

			start();
			style();
			burst();
		end,
	});

	Sections.Weather:AddLabel("Amount"):AddSlider({
		Min = 20, Max = 800, Default = 250, Rounding = 0, Size = 100,
		Flag = "weather_rate",
		Callback = function(v)
			W.Rate = v;

			if emitter then emitter.Rate = v end;
		end,
	});

	Sections.Weather:AddLabel("Fall Speed"):AddSlider({
		Min = 10, Max = 400, Default = 100, Type = "%", Size = 100,
		Flag = "weather_speed",
		Callback = function(v) W.Speed = v; style() end,
	});

	Sections.Weather:AddLabel("Particle Size"):AddSlider({
		Min = 10, Max = 500, Default = 100, Type = "%", Size = 100,
		Flag = "weather_size",
		Callback = function(v) W.Size = v; style() end,
	});

	Sections.Weather:AddLabel("Transparency"):AddSlider({
		Min = 20, Max = 400, Default = 100, Type = "%", Size = 100,
		Flag = "weather_fade",
		Callback = function(v) W.Fade = v; style() end,
	});

	Sections.Weather:AddLabel("Distance"):AddSlider({
		Min = 60, Max = 600, Default = 260, Rounding = 0, Size = 100,
		Flag = "weather_distance",
		Callback = function(v) W.Distance = v; resize() end,
	});

	Sections.Weather:AddLabel("Height"):AddSlider({
		Min = 40, Max = 400, Default = 140, Rounding = 0, Size = 100,
		Flag = "weather_height",
		Callback = function(v) W.Height = v; resize() end,
	});

	colorPicker = Sections.Weather:AddLabel("Color"):AddColorPicker({
		Default = W.Color,
		Flag = "weather_color",
		Callback = function(v)
			W.Color = v;
			easeColour(v);
		end,
	});

	Sections.Weather:AddButton({
		Icon = "arrow-rotate-right",
		Name = "Burst",
		Callback = burst,
	});
end);

guard("crosshair", function()
	local UserInputService = game:GetService("UserInputService");
	local LP = LocalPlayer;

	local crosshair_lines = {};
	local crosshair_enabled = false;
	local crosshair_hidden_game_cursor = false;
	local gun_equipped = false;
	local game_crosshair_gui = nil;
	local game_crosshair_hook_conn = nil;
	local mouse_icon_hook = nil;
	local mouse_icon_hook_active = false;

	local gap_size = 4;
	local line_length = 8;
	local line_thickness = 2;
	local line_color = Color3.fromRGB(255, 255, 255);
	local outline_color = Color3.fromRGB(0, 0, 0);
	local rotation_speed = 0;

	local current_rotation = 0;
	local crosshair_connection = nil;
	local gun_watch_connections = {};
	local crosshair_angles = { 0, 0, 0, 0 };

	local function has_gun_equipped()
		local char = LP.Character;

		if char and char:FindFirstChild("Gun") then
			return true;
		end;

		return false;
	end;

	local function create_crosshair_lines()
		for i = 1, 8 do
			local line = Drawing.new("Line");

			line.Visible = false;
			line.Color = (i % 2 == 0) and outline_color or line_color;
			line.Thickness = (i % 2 == 0) and line_thickness + 2 or line_thickness;
			line.Transparency = 1;
			line.ZIndex = (i % 2 == 0) and 999 or 1000;

			crosshair_lines[i] = line;
		end;
	end;

	local function destroy_crosshair_lines()
		for i = 1, #crosshair_lines do
			if crosshair_lines[i] then
				destroyAny(crosshair_lines[i]);

				crosshair_lines[i] = nil;
			end;
		end;
	end;

	local function update_crosshair_visibility(show, equipped)
		if equipped == nil then
			equipped = has_gun_equipped();
		end;

		gun_equipped = equipped;

		local should_show = show and crosshair_enabled and gun_equipped;

		for i = 1, #crosshair_lines do
			if crosshair_lines[i] then
				crosshair_lines[i].Visible = should_show;
			end;
		end;
	end;

	local function hide_game_crosshair_gui()
		local pg = LP:FindFirstChild("PlayerGui");

		if not pg then return end;

		local topbar = pg:FindFirstChild("GameTopbar");

		if not topbar then return end;

		local crosshair = topbar:FindFirstChild("Crosshair");

		if crosshair and crosshair:IsA("GuiObject") then
			game_crosshair_gui = crosshair;
			crosshair.Visible = false;
		end;
	end;

	local function show_game_crosshair_gui()
		if game_crosshair_gui and game_crosshair_gui.Parent then
			pcall(function()
				if game_crosshair_gui:IsA("GuiObject") then
					game_crosshair_gui.Visible = true;
				end;
			end);
		end;
	end;

	local function setup_mouse_icon_hook()
		mouse_icon_hook_active = true;

		if mouse_icon_hook then return end;
		if not (hookmetamethod and checkcaller) then return end;

		pcall(function()
			mouse_icon_hook = hookmetamethod(game, "__newindex", function(self, property, value)
				if property == "Icon" and mouse_icon_hook_active and crosshair_hidden_game_cursor
					and checkcaller() == false and self:IsA("Mouse") then
					if value == "rbxassetid://79658449" or value == "" then
						return;
					end;
				end;

				return mouse_icon_hook(self, property, value);
			end);
		end);
	end;

	local function remove_mouse_icon_hook()
		mouse_icon_hook_active = false;
	end;

	local function hide_game_cursor(hide)
		if hide and crosshair_hidden_game_cursor then
			setup_mouse_icon_hook();

			local mouse = LP:GetMouse();

			if mouse then
				mouse.Icon = "";
			end;

			hide_game_crosshair_gui();
		else
			remove_mouse_icon_hook();

			local mouse = LP:GetMouse();

			if mouse then
				mouse.Icon = "";
			end;

			if not crosshair_enabled then
				show_game_crosshair_gui();
			end;
		end;
	end;

	local function update_crosshair(dt)
		if not crosshair_enabled or #crosshair_lines == 0 then return end;

		local equipped = has_gun_equipped();

		gun_equipped = equipped;

		if not equipped then
			update_crosshair_visibility(false, equipped);

			return;
		end;

		local mouse_pos = UserInputService:GetMouseLocation();
		local center_x = mouse_pos.X;
		local center_y = mouse_pos.Y;

		if rotation_speed > 0 then
			current_rotation = (current_rotation + dt * rotation_speed * 100) % 360;
		else
			current_rotation = 0;
		end;

		local rad = math.rad(current_rotation);
		local cos = math.cos;
		local sin = math.sin;
		local pi = math.pi;

		crosshair_angles[1] = rad;
		crosshair_angles[2] = pi / 2 + rad;
		crosshair_angles[3] = pi + rad;
		crosshair_angles[4] = 3 * pi / 2 + rad;

		for i = 1, 4 do
			local angle = crosshair_angles[i];
			local line_idx = (i - 1) * 2 + 1;
			local outline_idx = line_idx + 1;

			local start_x = center_x + gap_size * cos(angle);
			local start_y = center_y + gap_size * sin(angle);
			local end_x = center_x + (gap_size + line_length) * cos(angle);
			local end_y = center_y + (gap_size + line_length) * sin(angle);

			local outline_start_x = center_x + (gap_size - 1) * cos(angle);
			local outline_start_y = center_y + (gap_size - 1) * sin(angle);
			local outline_end_x = center_x + (gap_size + line_length + 1) * cos(angle);
			local outline_end_y = center_y + (gap_size + line_length + 1) * sin(angle);

			if crosshair_lines[line_idx] then
				crosshair_lines[line_idx].From = Vector2.new(start_x, start_y);
				crosshair_lines[line_idx].To = Vector2.new(end_x, end_y);
			end;

			if crosshair_lines[outline_idx] then
				crosshair_lines[outline_idx].From = Vector2.new(outline_start_x, outline_start_y);
				crosshair_lines[outline_idx].To = Vector2.new(outline_end_x, outline_end_y);
			end;
		end;

		update_crosshair_visibility(true, equipped);
	end;

	local function start_crosshair()
		if crosshair_connection then return end;

		if #crosshair_lines == 0 then
			create_crosshair_lines();
		end;

		crosshair_connection = RunService.RenderStepped:Connect(update_crosshair);

		local function watch_gun(container)
			if not container then return end;

			local conn1 = container.ChildAdded:Connect(function(child)
				if child.Name == "Gun" then
					hide_game_crosshair_gui();
					update_crosshair_visibility(true);
					hide_game_cursor(true);
				end;
			end);

			local conn2 = container.ChildRemoved:Connect(function(child)
				if child.Name == "Gun" then
					update_crosshair_visibility(false);
					hide_game_cursor(false);
				end;
			end);

			table.insert(gun_watch_connections, conn1);
			table.insert(gun_watch_connections, conn2);
		end;

		if not game_crosshair_hook_conn then
			local pg = LP:FindFirstChild("PlayerGui");

			if pg then
				game_crosshair_hook_conn = pg.DescendantAdded:Connect(function(descendant)
					if descendant.Name == "Crosshair" and descendant.Parent and descendant.Parent.Name == "GameTopbar" then
						if crosshair_hidden_game_cursor and descendant:IsA("GuiObject") then
							descendant.Visible = false;
							game_crosshair_gui = descendant;
						end;
					end;
				end);
			end;
		end;

		local char = LP.Character;

		if char then
			watch_gun(char);
		end;

		local backpack = LP:FindFirstChildOfClass("Backpack");

		if backpack then
			watch_gun(backpack);
		end;

		local char_conn = LP.CharacterAdded:Connect(function(new_char)
			task.wait(0.3);

			watch_gun(new_char);
			watch_gun(LP:FindFirstChildOfClass("Backpack"));

			gun_equipped = has_gun_equipped();

			update_crosshair_visibility(true, gun_equipped);
			hide_game_cursor(gun_equipped and crosshair_hidden_game_cursor);
		end);

		table.insert(gun_watch_connections, char_conn);

		gun_equipped = has_gun_equipped();

		update_crosshair_visibility(true, gun_equipped);
		hide_game_cursor(gun_equipped and crosshair_hidden_game_cursor);
	end;

	local function stop_crosshair()
		if crosshair_connection then
			pcall(function() crosshair_connection:Disconnect() end);

			crosshair_connection = nil;
		end;

		if game_crosshair_hook_conn then
			pcall(function() game_crosshair_hook_conn:Disconnect() end);

			game_crosshair_hook_conn = nil;
		end;

		for _, conn in ipairs(gun_watch_connections) do
			pcall(function() conn:Disconnect() end);
		end;

		gun_watch_connections = {};

		update_crosshair_visibility(false);
		hide_game_cursor(false);
		show_game_crosshair_gui();
		destroy_crosshair_lines();
	end;

	local row = Sections.Screen:AddLabel("Crosshair");

	row:AddToggle({
		Name = "Crosshair",
		Default = false,
		Flag = "crosshair",
		Callback = function(v)
			crosshair_enabled = v;

			if v then
				start_crosshair();
			else
				stop_crosshair();
			end;
		end,
	});

	row:AddColorPicker({
		Default = line_color,
		Flag = "crosshair_color",
		Callback = function(c)
			line_color = c;

			for i = 1, #crosshair_lines do
				if crosshair_lines[i] and i % 2 == 1 then
					crosshair_lines[i].Color = c;
				end;
			end;
		end,
	});

	Sections.Screen:AddLabel("Hide Original"):AddToggle({
		Name = "Hide Original",
		Default = false,
		Flag = "crosshair_hide_original",
		Callback = function(v)
			crosshair_hidden_game_cursor = v;

			if gun_equipped and crosshair_enabled then
				hide_game_cursor(v);
			end;
		end,
	});

	Sections.Screen:AddLabel("Gap"):AddSlider({
		Min = 0, Max = 20, Default = 4, Rounding = 0, Size = 100,
		Flag = "crosshair_gap",
		Callback = function(v) gap_size = v end,
	});

	Sections.Screen:AddLabel("Length"):AddSlider({
		Min = 2, Max = 30, Default = 8, Rounding = 0, Size = 100,
		Flag = "crosshair_length",
		Callback = function(v) line_length = v end,
	});

	Sections.Screen:AddLabel("Thickness"):AddSlider({
		Min = 1, Max = 5, Default = 2, Rounding = 0, Size = 100,
		Flag = "crosshair_thickness",
		Callback = function(v)
			line_thickness = v;

			for i = 1, #crosshair_lines do
				if crosshair_lines[i] then
					crosshair_lines[i].Thickness = (i % 2 == 0) and v + 2 or v;
				end;
			end;
		end,
	});

	Sections.Screen:AddLabel("Rotation"):AddSlider({
		Min = 0, Max = 10, Default = 0, Rounding = 0, Size = 100,
		Flag = "crosshair_rotation",
		Callback = function(v) rotation_speed = v end,
	});

	Sections.Screen:AddLabel("Outline"):AddColorPicker({
		Default = outline_color,
		Flag = "crosshair_outline_color",
		Callback = function(c)
			outline_color = c;

			for i = 1, #crosshair_lines do
				if crosshair_lines[i] and i % 2 == 0 then
					crosshair_lines[i].Color = c;
				end;
			end;
		end,
	});

	ESP.ClearCrosshair = onUnload("crosshair", function()
		crosshair_enabled = false;

		stop_crosshair();
	end);
end);

guard("animations", function()
	local A = { EmoteLoop = false, EmoteSpeed = 100, Alive = true, _request = 0, PackName = "Default" };

	local function prettyName(value)
		local text = tostring(value or ""):gsub("[_]+", " ");

		text = text:gsub("%s+", " "):match("^%s*(.-)%s*$") or "";

		if text == "" or text:match("^%[%d+%]$") then return "Untitled" end;

		text = text:gsub("(%a[%w']*)", function(word)
			if word:match("^%l") and not word:match("%u") then
				return word:sub(1, 1):upper() .. word:sub(2);
			end;

			return word;
		end);

		return text;
	end

		local origAnims = {}

		local function toAid(v)
			local t = tostring(v or ""):match("^%s*(.-)%s*$")
			local d = t:match("(%d+)")
			if not d or tonumber(d) == 0 then return nil end
			return "rbxassetid://" .. d
		end

		local function kickReload(hum, animate)

			pcall(function()
				local animator = hum:FindFirstChildOfClass("Animator");
				for _, track in ipairs(animator and animator:GetPlayingAnimationTracks() or hum:GetPlayingAnimationTracks()) do
					if track.Priority.Value <= Enum.AnimationPriority.Movement.Value then track:Stop(0.12) end;
				end;
				if not animate.Disabled then animate.Disabled = true; animate.Disabled = false end;
			end);
		end;

		local function restoreAnims()
			for animation, id in pairs(origAnims) do
				if animation.Parent then
					pcall(function()
						local parent = animation.Parent;
						animation.AnimationId = id;
						animation.Parent = nil;
						animation.Parent = parent;
					end);
				end;
			end;
			origAnims = {};
		end;

		local CAT_URLS = {
			"https://raw.githubusercontent.com/7yd7/sniper-Emote/refs/heads/test/AnimationSniper.json",
			"https://raw.githubusercontent.com/7yd7/sniper-Emote/refs/heads/test/AnimationSniperoffsale.json",
		}
		local PACK_CACHE = Remote.file("animpacks.json")

		local packByName = {}
		local mapCache   = {}

		A.PackCatalog   = {}
		A.PackSearch    = ""
		A.PackPage      = 1
		A.PacksPerPage  = 24
		A.PackFiltered  = {}

		local function resolveMappings(data)
			local key = tostring(data.id)
			if mapCache[key] then return mapCache[key] end
			local bundled = data.bundledItems
			if type(bundled) ~= "table" then return nil end
			local mappings = {}
			for _, ids in pairs(bundled) do
				if type(ids) == "table" then
					for _, assetId in pairs(ids) do
						local ok, objs = pcall(game.GetObjects, game, "rbxassetid://" .. tostring(assetId))
						if ok and objs then
							local function scan(parent, path)
								for _, child in ipairs(parent:GetChildren()) do
									if child:IsA("Animation") then
										local parts = (path .. "." .. child.Name):split(".")
										mappings[#mappings + 1] = {
											category = parts[#parts - 1],
											name = parts[#parts],
											id = child.AnimationId,
										}
									elseif #child:GetChildren() > 0 then
										scan(child, path .. "." .. child.Name)
									end
								end
							end
							for _, o in ipairs(objs) do
								scan(o, o.Name)
								pcall(function() o:Destroy() end)
							end
						end
					end
				end
			end
			mapCache[key] = next(mappings) and mappings or nil
			return mappings
		end

		local function applyCategory(animate, folderName, mappings)
			local items, changed = {}, 0
			for _, m in ipairs(mappings) do
				if m.category and m.category:lower() == folderName then
					items[m.name:lower()] = m.id
				end
			end
			if not next(items) then return 0 end
			local folder = animate:FindFirstChild(folderName)
			if not folder then return 0 end
			local _, first = next(items)
			for _, a in ipairs(folder:GetChildren()) do
				if a:IsA("Animation") then
					local id = items[a.Name:lower()] or first
					if id then
						if origAnims[a] == nil then origAnims[a] = a.AnimationId end
						changed = changed + 1
						a.AnimationId = id
						local p = a.Parent
						a.Parent = nil
						a.Parent = p
					end
				end
			end
			return changed;
		end

		A.ApplyPack = function(packName)
			if not A.Alive then return false end;
			A.ResetEmote();
			local token = A._request;
			local name = packName or A.PackName or "Default";
			A.PackName = "Default";
			A.PendingPack = name ~= "Default" and name or nil;
			if A.OnStateChange then A.OnStateChange() end;
			if name == "Default" then
				restoreAnims();
				local c = LocalPlayer.Character;
				local hum = c and c:FindFirstChildOfClass("Humanoid");
				local animate = c and c:FindFirstChild("Animate");
				if hum and animate then kickReload(hum, animate) end;
				return true;
			end;
			local data = packByName[name];
			if not data then A.PendingPack = nil; if A.OnStateChange then A.OnStateChange() end; return false end;
			task.spawn(function()
				local ok, mappings = pcall(resolveMappings, data);
				if not A.Alive or token ~= A._request then return end;
				local c = LocalPlayer.Character;
				local hum = c and c:FindFirstChildOfClass("Humanoid");
				local animate = c and c:FindFirstChild("Animate");
				A.PendingPack = nil;
				if not (ok and mappings and #mappings > 0 and hum and animate) then
					restoreAnims();
					A.LastError = "Animation pack could not load on this character";
					if A.OnStateChange then A.OnStateChange() end;
					return;
				end;
				restoreAnims();
				local changed = 0;
				for _, folderName in ipairs({ "idle", "walk", "run", "jump", "fall", "climb", "swim", "swimidle" }) do
					changed = changed + applyCategory(animate, folderName, mappings);
				end;
				if changed > 0 then
					A.PackName = name;
					A.LastError = nil;
					kickReload(hum, animate);
				else
					A.LastError = "This pack has no matching animation slots";
				end;
				if A.OnStateChange then A.OnStateChange() end;
			end);
			return true;
		end;

		A._RefreshPackList = function()
			A.PackFavs = A.PackFavs or {}
			local q = tostring(A.PackSearch or ""):lower()
			local list = A.PackCatalog
			if q ~= "" then
				local filtered = {}
				for _, e in ipairs(list) do
					if e.name:lower():find(q, 1, true) then filtered[#filtered + 1] = e end
				end
				A.PackFiltered = filtered
			else
				A.PackFiltered = list
			end

			if next(A.PackFavs) ~= nil then
				local fav, rest = {}, {}
				for _, e in ipairs(A.PackFiltered) do
					if A.PackFavs[e.name] then fav[#fav+1] = e else rest[#rest+1] = e end
				end
				for _, e in ipairs(rest) do fav[#fav+1] = e end
				A.PackFiltered = fav
			end
			local total = #A.PackFiltered
			A.PackTotalPages = math.max(1, math.ceil(total / A.PacksPerPage))
			if A.PackPage > A.PackTotalPages then A.PackPage = A.PackTotalPages end
			if A.PackPage < 1 then A.PackPage = 1 end
		end

		local function ingest(list)
			local seen = {}
			for _, e in ipairs(A.PackCatalog) do seen[e.id] = true end
			for _, item in pairs(list) do
				local id = tonumber(item.id)
				if id and id > 0 and item.bundledItems and not seen[id] then
					seen[id] = true
					local nm = prettyName(item.name or ("Animation " .. id))
					if packByName[nm] then nm = nm .. " [" .. id .. "]" end
					packByName[nm] = { id = id, bundledItems = item.bundledItems }
					A.PackCatalog[#A.PackCatalog + 1] = { id = id, name = nm }
				end
			end
		end

		task.spawn(function()
			local cached
			pcall(function()
				if isfile and isfile(PACK_CACHE) then
					local d = game:GetService("HttpService"):JSONDecode(readfile(PACK_CACHE))
					if type(d) == "table" and #d > 0 then cached = d end
				end
			end)
			if cached then
				ingest(cached)
				table.sort(A.PackCatalog, function(a, b) return a.name < b.name end)
			end

			local fresh = {}
			for _, url in ipairs(CAT_URLS) do
				local ok, res = pcall(function()
					local body = game:HttpGet(url)
					return body ~= "" and game:GetService("HttpService"):JSONDecode(body) or nil
				end)
				if ok and type(res) == "table" then
					local list = res.data or res
					for _, item in pairs(list) do
						if item and item.id and item.bundledItems then fresh[#fresh + 1] = item end
					end
				end
			end
			if not A.Alive or #fresh == 0 then return end

			A.PackCatalog = {}
			packByName = {}
			ingest(fresh)
			table.sort(A.PackCatalog, function(a, b) return a.name < b.name end)
			pcall(function()
								writefile(PACK_CACHE, game:GetService("HttpService"):JSONEncode(fresh))
			end)
		end)

		A.ResetEmote = function()
			A._request = A._request + 1;
			A.PendingEmoteId, A.PendingPack, A.SelectedEmoteId = nil, nil, nil;
			if A._emoteStopped then A._emoteStopped:Disconnect(); A._emoteStopped = nil end;
			local track = A._currentEmoteTrack;
			A._currentEmoteTrack = nil;
			if track then pcall(function() track:Stop(0.12); track:Destroy() end) end;
			if A._currentEmoteAnim then A._currentEmoteAnim:Destroy(); A._currentEmoteAnim = nil end;
			if A.OnStateChange then A.OnStateChange() end;
		end;

		local animIdCache = {};

		local function resolveAnimId(id)
			local key = tostring(id);
			if animIdCache[key] then return animIdCache[key] end;
			local direct = toAid(id);
			if not direct then return nil end;
			local found;
			local ok, objects = pcall(game.GetObjects, game, direct);
			if ok and type(objects) == "table" then
				for _, object in ipairs(objects) do
					if object:IsA("Animation") then found = toAid(object.AnimationId) end;
					if not found then
						for _, descendant in ipairs(object:GetDescendants()) do
							if descendant:IsA("Animation") then found = toAid(descendant.AnimationId); if found then break end end;
						end;
					end;
					object:Destroy();
				end;
			end;
			animIdCache[key] = found or direct;
			return animIdCache[key];
		end;

		A.PlayEmote = function(id)
			if not A.Alive then return false end;
			A.ResetEmote();
			restoreAnims();
			A.PackName = "Default";
			local token = A._request;
			local character = LocalPlayer.Character;
			local hum = character and character:FindFirstChildOfClass("Humanoid");
			local raw = toAid(id);
			if not (hum and raw) then return false end;
			A.PendingEmoteId = tostring(id);
			A.LastError = nil;
			if A.OnStateChange then A.OnStateChange() end;
			task.spawn(function()
				local ok, aid = pcall(resolveAnimId, id);
				if not A.Alive or token ~= A._request or LocalPlayer.Character ~= character then return end;
				local animation = Instance.new("Animation");
				animation.AnimationId = ok and aid or raw;
				local animator = hum:FindFirstChildOfClass("Animator");
				local loaded, track = pcall(function()
					return animator and animator:LoadAnimation(animation) or hum:LoadAnimation(animation);
				end);
				if loaded and track then
					local deadline = os.clock() + 5;
					while A.Alive and token == A._request and track.Length <= 0 and os.clock() < deadline do task.wait(0.05) end;
				end;
				if not A.Alive or token ~= A._request or LocalPlayer.Character ~= character then
					if loaded and track then pcall(function() track:Stop(0); track:Destroy() end) end;
					animation:Destroy();
					return;
				end;
				A.PendingEmoteId = nil;
				if not loaded or not track or track.Length <= 0 then
					if loaded and track then track:Destroy() end;
					animation:Destroy();
					A.LastError = "Emote unavailable for this character or experience";
					if A.OnStateChange then A.OnStateChange() end;
					return;
				end;
				track.Priority = Enum.AnimationPriority.Action;
				track.Looped = A.EmoteLoop == true;
				A._currentEmoteTrack, A._currentEmoteAnim = track, animation;
				A.SelectedEmoteId = id;
				A._emoteStopped = track.Stopped:Connect(function()
					if A._currentEmoteTrack == track then A.ResetEmote() end;
				end);
				local played = pcall(function() track:Play(0.12, 1, A.EmoteSpeed / 100) end);
				if not played then A.ResetEmote(); A.LastError = "Unable to play this emote" end;
				if A.OnStateChange then A.OnStateChange() end;
			end);
			return true;
		end;

		A._SetEmoteLoop = function(value)
			A.EmoteLoop = value == true;
			local track = A._currentEmoteTrack;
			if track then track.Looped = A.EmoteLoop end;
		end;

		NeverLose:AddSignal(LocalPlayer.CharacterAdded:Connect(function(character)
			local emote = A.SelectedEmoteId or A.PendingEmoteId;
			local pack = A.PendingPack or A.PackName;
			A.ResetEmote();
			origAnims = {};
			local token = A._request;
			task.spawn(function()
				local human = character:WaitForChild("Humanoid", 10);
				local animate = character:WaitForChild("Animate", 10);
				if animate then animate:WaitForChild("idle", 5) end;
				if not A.Alive or token ~= A._request or LocalPlayer.Character ~= character or not human then return end;
				if emote then A.PlayEmote(emote) elseif pack and pack ~= "Default" then A.ApplyPack(pack) end;
			end);
		end));

		A.Destroy = function()
			if not A.Alive then return end;
			A.Alive = false;
			A.OnStateChange = nil;
			A.ResetEmote();
			restoreAnims();
			A.PackName = "Default";
		end;
		NeverLose:AddSignal(NeverLose.ScreenGui.Destroying:Connect(A.Destroy));

		A.EmoteCatalog = {}
		A.EmoteSearch = ""
		A.EmoteFavorites = {}
		A.EmoteSpeed   = 100
		A.EmoteLoop    = false
		A.SelectedEmoteId = nil
		A._emotePage = 1
		A._emotesPerPage = 24
		A._emoteFilteredList = {}

		do
			A.EmoteCatalog = { { id = 129149402922241, name = "Griddy" } };
			local seeded = { [129149402922241] = true };

			pcall(function()
				if isfile and isfile("emotes.json") then
					local d = game:GetService("HttpService"):JSONDecode(readfile("emotes.json"));

					if type(d) == "table" then
						for k, v in pairs(d) do
							local name, id;

							if type(v) == "table" then
								name, id = tostring(v.name or v[1] or k), v.id or v[2]
							else
								name, id = tostring(k), v
							end;

							local raw = tonumber(tostring(id or ""):gsub("%D", "")) or 0;

							if name ~= "" and raw > 0 and not seeded[raw] then
								seeded[raw] = true;
								A.EmoteCatalog[#A.EmoteCatalog + 1] = { id = raw, name = prettyName(name) };
							end;
						end;
					end;
				end;
			end);
		end

		local function fetchEmotes()
			local ok, result = pcall(function()
				local json = game:HttpGet("https://raw.githubusercontent.com/7yd7/sniper-Emote/refs/heads/test/EmoteSniper.json")
				if json and json ~= "" then
					return game:GetService("HttpService"):JSONDecode(json).data or {}
				end
			end)
			if ok and result then
				local list = {}
				for _, item in pairs(result) do
					local id = tonumber(item.id)
					if id and id > 0 then
						list[#list+1] = { id = id, name = prettyName(item.name or ("Emote_"..id)) }
					end
				end
				return list
			end
			return {}
		end

		local function filterEmotes(search)
			search = search:lower()
			local list = A.EmoteCatalog
			if search ~= "" then
				local isId = search:match("^%d+$")
				local filtered = {}
				for _, e in ipairs(list) do
					if isId then
						if tostring(e.id) == search then filtered[#filtered+1] = e end
					else
						local name = prettyName(e.name):lower()
						local match = true
						for word in search:gmatch("%S+") do
							if not name:find(word, 1, true) then match = false; break end
						end
						if match then filtered[#filtered+1] = e end
					end
				end
				A._emoteFilteredList = filtered
			else
				A._emoteFilteredList = list
			end
		end

		A._refreshEmoteList = function()
			filterEmotes(A.EmoteSearch)
			if next(A.EmoteFavorites) ~= nil then
				local fav, rest = {}, {}
				for _, e in ipairs(A._emoteFilteredList) do
					if A.EmoteFavorites[e.id] then fav[#fav+1] = e else rest[#rest+1] = e end
				end
				for _, e in ipairs(rest) do fav[#fav+1] = e end
				A._emoteFilteredList = fav
			end
			local total = #A._emoteFilteredList
			local pp = A._emotesPerPage
			A._emoteTotalPages = math.max(1, math.ceil(total / pp))
			if A._emotePage > A._emoteTotalPages then A._emotePage = A._emoteTotalPages end
			if A._emotePage < 1 then A._emotePage = 1 end
		end

		local CACHE = Remote.file("emotes.json")

		local function loadCache()
			local ok, list = pcall(function()
				if not (isfile and isfile(CACHE)) then return nil end
				local d = game:GetService("HttpService"):JSONDecode(readfile(CACHE))
				return (type(d) == "table" and #d > 0) and d or nil
			end)
			return ok and list or nil
		end

		local function saveCache(list)
			pcall(function()
								writefile(CACHE, game:GetService("HttpService"):JSONEncode(list))
			end)
		end

		task.spawn(function()
			local cached = loadCache()
			if cached then
				local seen, merged = {}, {};
				for _, e in ipairs(A.EmoteCatalog) do
					if e and e.id and not seen[e.id] then
						e.name = prettyName(e.name or e.id)
						seen[e.id] = true;
						merged[#merged + 1] = e;
					end;
				end;
				for _, e in ipairs(cached) do
					if e and e.id and not seen[e.id] then
						e.name = prettyName(e.name or e.id)
						seen[e.id] = true;
						merged[#merged + 1] = e;
					end;
				end;
				A.EmoteCatalog = merged
				A._refreshEmoteList()
				if A._buildEmoteGrid then pcall(A._buildEmoteGrid) end
			end

			for attempt = 1, 5 do
				if not A.Alive then return end;
				local fresh = fetchEmotes()
				if not A.Alive then return end;
				if #fresh > 0 then

					local seen, merged = {}, {};

					for _, e in ipairs(A.EmoteCatalog) do
						if e and e.id and not seen[e.id] then
							e.name = prettyName(e.name or e.id)
							seen[e.id] = true;
							merged[#merged + 1] = e;
						end;
					end;

					for _, e in ipairs(fresh) do
						if e and e.id and not seen[e.id] then
							e.name = prettyName(e.name or e.id)
							seen[e.id] = true;
							merged[#merged + 1] = e;
						end;
					end;

					A.EmoteCatalog = merged
					saveCache(A.EmoteCatalog)
					A._refreshEmoteList()
					if A._buildEmoteGrid then pcall(A._buildEmoteGrid) end
					return
				end
				task.wait(3)
			end
		end)

	ESP.Anim = A;
	ESP.ClearAnimations = A.Destroy;

	local Accent = NeverLose.AccentColor;

	local function sectionHost(section)
		return section.Items or section.Root;
	end;

		local COLS, CELL_H, PAD = 2, 118, 8;
		local COL_IDLE = Color3.fromRGB(25, 27, 33);
		local COL_HOVER = Color3.fromRGB(35, 38, 48);
		local COL_ACTIVE = Color3.fromRGB(30, 34, 48);
		local COL_TEXT = Color3.fromRGB(236, 238, 244);
		local COL_EDGE = Color3.fromRGB(45, 48, 58);
		local grids = {};

		local function buildGrid(parent, height, order, cfg)
			local sf = Instance.new("ScrollingFrame");
			sf.Name = "AnimationCatalog";
			sf.Size = UDim2.new(1, -8, 0, height);
			sf.BackgroundColor3 = Color3.fromRGB(13, 14, 18);
			sf.ZIndex, sf.BorderSizePixel, sf.ScrollBarThickness = 20, 0, 4;
			sf.ScrollBarImageColor3 = Accent;
			sf.CanvasSize = UDim2.new();
			sf.ClipsDescendants = true;
			sf.Parent, sf.LayoutOrder = parent, order;
			Instance.new("UICorner", sf).CornerRadius = UDim.new(0, 6);
			local empty = Instance.new("TextLabel");
			empty.Name, empty.Text = "Empty", "No matching results";
			empty.Size, empty.Position = UDim2.new(1, -16, 0, 48), UDim2.fromOffset(8, 16);
			empty.BackgroundTransparency, empty.TextTransparency = 1, 0.35;
			empty.Font, empty.TextSize, empty.TextColor3 = Enum.Font.Gotham, 12, COL_TEXT;
			empty.ZIndex, empty.Parent = 21, sf;
			local pool, live, parked = {}, {}, {};
			local selectedKey, dirty, disposed = nil, true, false;
			local grid = { Frame = sf };

			local function restoreScroll()
				for ancestor, enabled in pairs(parked) do
					if ancestor.Parent then ancestor.ScrollingEnabled = enabled end;
					parked[ancestor] = nil;
				end;
			end;
			local function visible()
				if disposed or not A.Alive or not sf.Parent then return false end;
				local ancestor = sf;
				while ancestor do
					if ancestor:IsA("GuiObject") and not ancestor.Visible then return false end;
					if ancestor:IsA("ScreenGui") then return ancestor.Enabled end;
					ancestor = ancestor.Parent;
				end;
				return false;
			end;
			local function build()
				local card = Instance.new("TextButton");
				card.Name, card.ClipsDescendants = "CatalogCard", true;
				card.BackgroundColor3, card.BorderSizePixel, card.ZIndex = COL_IDLE, 0, 21;
				card.AutoButtonColor, card.Text = false, "";
				Instance.new("UICorner", card).CornerRadius = UDim.new(0, 6);
				local stroke = Instance.new("UIStroke", card);
				stroke.Color, stroke.Thickness, stroke.Transparency = COL_EDGE, 1, 0.45;
				local scale = Instance.new("UIScale", card);
				local img = Instance.new("ImageLabel", card);
				img.Name, img.ZIndex, img.BackgroundTransparency = "Thumb", 22, 1;
				img.ScaleType = Enum.ScaleType.Fit;
				img.Size, img.Position = UDim2.new(1, -16, 0, CELL_H - 44), UDim2.fromOffset(8, 7);
				local label = Instance.new("TextLabel", card);
				label.Name, label.ZIndex, label.BackgroundTransparency = "Title", 23, 1;

				label.FontFace = NeverLose.BuiltInRegular;
				label.TextSize, label.TextColor3 = 12, COL_TEXT;
				label.TextWrapped, label.TextTruncate = false, Enum.TextTruncate.AtEnd;
				label.TextXAlignment = Enum.TextXAlignment.Center;
				label.Size, label.Position = UDim2.new(1, -10, 0, 16), UDim2.fromOffset(5, CELL_H - 26);
				local star = Instance.new("TextLabel", card);
				star.Name, star.Text, star.Font = "Favorite", "★", Enum.Font.GothamBold;
				star.ZIndex, star.TextSize, star.BackgroundTransparency = 24, 17, 1;
				star.TextColor3, star.TextTransparency = Color3.fromRGB(255, 211, 104), 1;
				star.Position, star.Size = UDim2.fromOffset(5, 3), UDim2.fromOffset(20, 20);
				local dot = Instance.new("Frame", card);
				dot.Name, dot.ZIndex, dot.BorderSizePixel = "ActiveDot", 24, 0;
				dot.AnchorPoint, dot.Position = Vector2.new(1, 0), UDim2.new(1, -7, 0, 8);
				dot.Size, dot.BackgroundColor3, dot.BackgroundTransparency = UDim2.fromOffset(7, 7), Accent, 1;
				Instance.new("UICorner", dot).CornerRadius = UDim.new(1, 0);
				local tile = { card = card, img = img, label = label, stroke = stroke, scale = scale, dot = dot, star = star, active = 0, hover = 0, favorite = 0, pulse = 0 };
				card.MouseEnter:Connect(function() tile.hovered = true end);
				card.MouseLeave:Connect(function() tile.hovered = false end);
				card.MouseButton1Click:Connect(function()
					if not tile.entry or not visible() then return end;
					local entry, key = tile.entry, tile.key;
					tile.pulse = 1;
					cfg.onClick(entry, key);
				end);
				card.MouseButton2Click:Connect(function()
					if tile.entry and visible() and cfg.onFav then cfg.onFav(tile.entry, tile.key) end;
				end);
				return tile;
			end;

			function grid.refresh()
				if disposed then return end;
				dirty = false;
				local list = cfg.getList() or {};
				local total, rowHeight = #list, CELL_H + PAD;
				local rows = math.ceil(total / COLS);
				local canvasHeight = math.max(0, rows * rowHeight + PAD);
				if sf.CanvasSize.Y.Offset ~= canvasHeight then sf.CanvasSize = UDim2.fromOffset(0, canvasHeight) end;
				empty.Visible = total == 0;
				local width = math.max(40, (sf.AbsoluteSize.X - sf.ScrollBarThickness - PAD * (COLS + 1)) / COLS);
				local first = math.max(0, math.floor((sf.CanvasPosition.Y - PAD) / rowHeight) - 1);
				local last = math.min(rows - 1, math.floor((sf.CanvasPosition.Y + math.max(sf.AbsoluteSize.Y, height)) / rowHeight) + 1);
				local want = {};
				for row = first, last do
					for col = 0, COLS - 1 do
						local index = row * COLS + col + 1;
						if index <= total then want[index] = { row, col } end;
					end;
				end;
				for index, tile in pairs(live) do
					if not want[index] then
						tile.card.Visible, tile.hovered = false, false;
						tile.entry, tile.key = nil, nil;
						pool[#pool + 1], live[index] = tile, nil;
					end;
				end;
				for index, coordinates in pairs(want) do
					local tile = live[index] or table.remove(pool) or build();
					live[index] = tile;
					local entry, key = list[index], cfg.keyOf(list[index]);
					if key ~= tile.key then
						tile.active, tile.hover, tile.favorite, tile.pulse = key == selectedKey and 1 or 0, 0, 0, 0;
						tile.hovered = false;
						tile.img.Image, tile.label.Text = cfg.imageOf(entry), cfg.nameOf(entry);
					end;
					tile.entry, tile.key = entry, key;
					tile.card.Parent, tile.card.Visible = sf, true;
					tile.card.Size = UDim2.fromOffset(width, CELL_H);
					tile.card.Position = UDim2.fromOffset(PAD + coordinates[2] * (width + PAD), PAD + coordinates[1] * rowHeight);
				end;
			end;
			function grid.select(key) selectedKey = key end;
			function grid.queue(resetScroll)
				if disposed then return end;
				dirty = true;
				if resetScroll then sf.CanvasPosition = Vector2.zero end;
			end;
			function grid.step(dt)
				if not visible() then restoreScroll(); return end;
				if dirty then grid.refresh() end;
				local blend = 1 - math.exp(-18 * math.min(dt, 0.1));
				for _, tile in pairs(live) do
					local on = tile.key == selectedKey;
					tile.active = tile.active + ((on and 1 or 0) - tile.active) * blend;
					tile.hover = tile.hover + ((tile.hovered and 1 or 0) - tile.hover) * blend;
					local favorite = cfg.isFav and cfg.isFav(tile.entry) and 1 or 0;
					tile.favorite = tile.favorite + (favorite - tile.favorite) * blend;
					tile.pulse = tile.pulse * (1 - blend);
					local accent = NeverLose.AccentColor;
					tile.card.BackgroundColor3 = COL_IDLE:Lerp(COL_HOVER, tile.hover * 0.7):Lerp(COL_ACTIVE, tile.active);
					tile.stroke.Color = COL_EDGE:Lerp(accent, tile.active);
					tile.stroke.Thickness = 1 + tile.active;
					tile.stroke.Transparency = 0.45 * (1 - tile.active);
					tile.label.TextColor3 = COL_TEXT:Lerp(accent, tile.active);
					tile.dot.BackgroundColor3, tile.dot.BackgroundTransparency = accent, 1 - tile.active;
					tile.star.TextTransparency = 1 - tile.favorite;
					tile.star.Rotation = -15 * (1 - tile.favorite);
					tile.scale.Scale = 1 - tile.pulse * 0.025;
				end;
			end;
			sf:GetPropertyChangedSignal("CanvasPosition"):Connect(function() grid.queue() end);
			sf:GetPropertyChangedSignal("AbsoluteSize"):Connect(function() grid.queue() end);
			sf.MouseEnter:Connect(function()
				if not visible() then return end;
				local ancestor = sf.Parent;
				while ancestor do
					if ancestor:IsA("ScrollingFrame") and parked[ancestor] == nil then
						parked[ancestor] = ancestor.ScrollingEnabled;
						ancestor.ScrollingEnabled = false;
					end;
					ancestor = ancestor.Parent;
				end;
			end);
			sf.MouseLeave:Connect(restoreScroll);
			sf.Destroying:Connect(function() disposed = true; restoreScroll() end);
			Window.Signal:Connect(function(value) if not value then restoreScroll() else grid.queue() end end);
			if cfg.tab then cfg.tab.Signal:Connect(function(value) if not value then restoreScroll() else grid.queue() end end) end;
			grids[#grids + 1] = grid;
			return grid;
		end;

		NeverLose:AddSignal(RunService.Heartbeat:Connect(function(dt)
			if not A.Alive then return end;
			for _, grid in ipairs(grids) do grid.step(dt) end;
		end));

	local FAVS_FILE = "Salad Visuals/Config/favourites.json";

	local favorites = { emotes = {}, packs = {} };

	pcall(function()
		if isfile and isfile(FAVS_FILE) then
			local decoded = game:GetService("HttpService"):JSONDecode(readfile(FAVS_FILE));

			if type(decoded) == "table" then
				favorites.emotes = type(decoded.emotes) == "table" and decoded.emotes or {};
				favorites.packs = type(decoded.packs) == "table" and decoded.packs or {};
				local function normalizeKeys(source)
					local normalized = {};
					if type(source) ~= "table" then return normalized end;
					for key, value in pairs(source) do
						if value then normalized[prettyName(key)] = true end
					end
					return normalized;
				end
				favorites.emotes = normalizeKeys(favorites.emotes);
				favorites.packs = normalizeKeys(favorites.packs);
			end;
		end;
	end);

	local function saveFavorites()
		pcall(function()
			if not (writefile and isfolder) then return end;
			if not isfolder("Salad Visuals/Config") then makefolder("Salad Visuals/Config") end;

			writefile(FAVS_FILE, game:GetService("HttpService"):JSONEncode(favorites));
		end);
	end;

	local function favoriteKey(entry) return tostring(entry.id) end;
	local function isFavorite(list, entry)
		local key = favoriteKey(entry);

		return list[key] == true or list[entry.name] == true or list[prettyName(entry.name)] == true;
	end;
	local function toggleFavorite(list, entry)
		local enabled = not isFavorite(list, entry);
		list[entry.name], list[prettyName(entry.name)] = nil, nil;
		list[favoriteKey(entry)] = enabled or nil;
		saveFavorites();
	end;
	local function filtered(source, search, favs, nameOf)
		local needle = tostring(search or ""):lower();
		local pinned, rest = {}, {};
		for _, entry in ipairs(source or {}) do
			local haystack = (nameOf(entry) .. " " .. tostring(entry.id)):lower();
			local matches = true;
			for word in needle:gmatch("%S+") do
				if not haystack:find(word, 1, true) then matches = false; break end;
			end;
			if matches then
				local list = isFavorite(favs, entry) and pinned or rest;
				list[#list + 1] = entry;
			end;
		end;
		for _, entry in ipairs(rest) do pinned[#pinned + 1] = entry end;
		return pinned;
	end;

	local emoteSearch, emoteList, emoteGrid = "", {};
	local packSearch, packList, packGrid;

	local function refreshEmotes()
		emoteList = filtered(A.EmoteCatalog, emoteSearch, favorites.emotes, function(e) return prettyName(e.name or tostring(e.id)) end);

		if emoteGrid then emoteGrid.queue() end;
	end;

	Sections.Emotes:AddLabel("Search"):AddTextInput({
		Default = "",
		Placeholder = "Search emotes...",
		Flag = "emote_search",
		Size = 130,
		Callback = function(v) emoteSearch = v or ""; refreshEmotes(); if emoteGrid then emoteGrid.queue(true) end end,
	});

	emoteGrid = buildGrid(sectionHost(Sections.Emotes), 300, 10, {
		tab = MiscGroup.Emotes,
		getList = function() return emoteList end,
		keyOf = function(e) return tostring(e.id) end,
		nameOf = function(e) return prettyName(e.name or tostring(e.id)) end,
		imageOf = function(e) return "rbxthumb://type=Asset&id=" .. tostring(e.id) .. "&w=420&h=420" end,
		onClick = function(entry, key)
			if tostring(A.SelectedEmoteId or A.PendingEmoteId or "") == key then A.ResetEmote() else A.PlayEmote(entry.id) end;
		end,
		isFav = function(entry) return isFavorite(favorites.emotes, entry) end,
		onFav = function(entry)
			toggleFavorite(favorites.emotes, entry);
			refreshEmotes();
			emoteGrid.queue(true);
		end,
	});

	Sections.EmoteOptions:AddLabel("Loop"):AddToggle({
		Default = false, Flag = "emote_loop",
		Callback = function(v)
			if A._SetEmoteLoop then A._SetEmoteLoop(v) else A.EmoteLoop = v end;
		end,
	});

	Sections.EmoteOptions:AddLabel("Speed"):AddSlider({
		Min = 10, Max = 300, Default = 100, Type = "%", Size = 100,
		Flag = "emote_speed",
		Callback = function(v)
			A.EmoteSpeed = v;

			local track = A._currentEmoteTrack;

			if track then pcall(track.AdjustSpeed, track, v / 100) end;
		end,
	});

	Sections.EmoteOptions:AddButton({
		Icon = "stop-large",
		Name = "Stop Emote",
		Callback = function()
			if A.ResetEmote then pcall(A.ResetEmote) end;
			emoteGrid.select(nil);
		end,
	});

	packSearch, packList, packGrid = "", {}, {};

	local function refreshPacks()
		packList = filtered(A.PackCatalog, packSearch, favorites.packs, function(e) return prettyName(e.name) end);

		if packGrid and packGrid.queue then packGrid.queue() end;
	end;

	Sections.Animations:AddLabel("Search"):AddTextInput({
		Default = "",
		Placeholder = "Search packs...",
		Flag = "pack_search",
		Size = 130,
		Callback = function(v) packSearch = v or ""; refreshPacks(); if packGrid and packGrid.queue then packGrid.queue(true) end end,
	});

	packGrid = buildGrid(sectionHost(Sections.Animations), 300, 10, {
		tab = MiscGroup.Animations,
		getList = function() return packList end,
		keyOf = function(e) return e.name end,
		nameOf = function(e) return prettyName(e.name) end,
		imageOf = function(e) return "rbxthumb://type=BundleThumbnail&id=" .. tostring(e.id) .. "&w=420&h=420" end,
		onClick = function(entry, key)
			A.ApplyPack((A.PackName == entry.name or A.PendingPack == entry.name) and "Default" or entry.name);
		end,
		isFav = function(entry) return isFavorite(favorites.packs, entry) end,
		onFav = function(entry)
			toggleFavorite(favorites.packs, entry);
			refreshPacks();
			packGrid.queue(true);
		end,
	});

	pcall(function()
		NeverLose.Lib:hook("anim_pack", "string",
			function() return tostring(A.PackName or "Default") end,
			function(value)
				value = tostring(value or "Default");

				if value == "" then value = "Default" end;

				task.spawn(function()
					task.wait(1.5);

					if ALIVE and A.ApplyPack then pcall(A.ApplyPack, value) end;
				end);
			end);

		NeverLose.Lib:hook("emote_pick", "string",
			function() return tostring(A.SelectedEmoteId or "") end,
			function(value)
				local id = tonumber(value);

				if not id then return end;

				task.spawn(function()
					task.wait(1.8);

					if ALIVE and A.PlayEmote then pcall(A.PlayEmote, id) end;
				end);
			end);
	end);

	Sections.AnimationOptions:AddButton({
		Icon = "arrow-rotate-right",
		Name = "Reapply",
		Callback = function()
			if A.ApplyPack then pcall(A.ApplyPack, A.PackName) end;
		end,
	});

	Sections.AnimationOptions:AddButton({
		Icon = "trash-can",
		Name = "Reset To Default",
		Callback = function()
			A.PackName = "Default";

			if A.ApplyPack then pcall(A.ApplyPack, "Default") end;
			packGrid.select(nil);
		end,
	});

	local emoteStatus = Sections.EmoteOptions:AddLabel("Choose an emote", true);
	local packStatus = Sections.AnimationOptions:AddLabel("Default animations", true);
	A.OnStateChange = function()
		if not A.Alive then return end;
		emoteGrid.select(A.SelectedEmoteId and tostring(A.SelectedEmoteId) or nil);
		packGrid.select(A.PackName ~= "Default" and A.PackName or nil);
		emoteStatus:SetText(A.PendingEmoteId and "Loading emote..." or (A.SelectedEmoteId and "Playing · click again to stop" or A.LastError or "Choose an emote"));
		packStatus:SetText(A.PendingPack and ("Loading " .. prettyName(A.PendingPack) .. "...") or (A.PackName ~= "Default" and prettyName(A.PackName) or A.LastError or "Default animations"));
	end;
	A.OnStateChange();

	ESP.RefreshAnimGrids = function()
		refreshEmotes();
		refreshPacks();
	end;

	task.spawn(function()
		local lastEmotes, lastPacks = -1, -1;

		while A.Alive and NeverLose.ScreenGui.Parent do
			local emotes = #(A.EmoteCatalog or {});
			local packs = #(A.PackCatalog or {});

			if emotes ~= lastEmotes or packs ~= lastPacks then
				lastEmotes, lastPacks = emotes, packs;

				pcall(refreshEmotes);
				pcall(refreshPacks);
			end;

			task.wait(2);
		end;
	end);

	local TeleportService = game:GetService("TeleportService");
	local HttpService = game:GetService("HttpService");

	local function say(ok, text)
		Notification.new({
			Title = ok and "Helpers" or "Helpers failed",
			Content = tostring(text),
			Duration = ok and 4 or 6,
		});
	end;

	local zoomLimit = { On = false, Max = nil, Min = nil };

	local function applyZoom()
		local ok = pcall(function()
			if zoomLimit.On then
				if zoomLimit.Max == nil then
					zoomLimit.Max = LocalPlayer.CameraMaxZoomDistance;
					zoomLimit.Min = LocalPlayer.CameraMinZoomDistance;
				end;

				LocalPlayer.CameraMaxZoomDistance = 2048;
			elseif zoomLimit.Max ~= nil then
				LocalPlayer.CameraMaxZoomDistance = zoomLimit.Max;
				LocalPlayer.CameraMinZoomDistance = zoomLimit.Min;
				zoomLimit.Max, zoomLimit.Min = nil, nil;
			end;
		end);

		return ok;
	end;

	Sections.Helpers:AddLabel("No Zoom Limit"):AddToggle({
		Name = "No Zoom Limit",
		Default = false,
		ToolTip = "Removes the zoom cap",
		Flag = "no_zoom_limit",
		Callback = function(v)
			zoomLimit.On = v;

			applyZoom();
		end,
	});

	NeverLose:AddSignal(LocalPlayer.CharacterAdded:Connect(function()
		task.wait(0.6);

		if zoomLimit.On then
			zoomLimit.Max, zoomLimit.Min = nil, nil;

			applyZoom();
		end;
	end));

	onUnload("zoom limit", function()
		zoomLimit.On = false;

		applyZoom();
	end);

	Sections.Helpers:AddButton({
		Icon = "refresh-cw",
		Name = "Rejoin",
		ToolTip = "Same server",
		Callback = function()
			say(true, "rejoining...");

			task.spawn(function()
				local ok, err = pcall(function()
					TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer);
				end);

				if not ok then say(false, tostring(err)) end;
			end);
		end,
	});

	Sections.Helpers:AddButton({
		Icon = "compass",
		Name = "Server Hop",
		ToolTip = "Random server",
		Callback = function()
			say(true, "looking for a server...");

			task.spawn(function()
				local cursor, tried = "", 0;

				while tried < 6 do
					tried = tried + 1;

					local url = ("https://games.roblox.com/v1/games/%d/servers/Public?sortOrder=Desc&limit=100")
						:format(game.PlaceId) .. (cursor ~= "" and ("&cursor=" .. cursor) or "");

					local body = Remote.download(url);
					local ok, page = pcall(function() return HttpService:JSONDecode(body) end);

					if not (ok and type(page) == "table" and type(page.data) == "table") then
						return say(false, "server list unavailable");
					end;

					for _, server in ipairs(page.data) do
						if server.id ~= game.JobId
							and (tonumber(server.playing) or 0) < (tonumber(server.maxPlayers) or 0) then
							local sent = pcall(function()
								TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer);
							end);

							if sent then return end;
						end;
					end;

					if type(page.nextPageCursor) ~= "string" then break end;

					cursor = page.nextPageCursor;
				end;

				say(false, "No open servers");
			end);
		end,
	});

	Sections.Helpers:AddButton({
		Icon = "copy",
		Name = "Copy Join Link",
		ToolTip = "Copies a join link",
		Callback = function()
			local link = ("roblox://experiences/start?placeId=%d&gameInstanceId=%s")
				:format(game.PlaceId, game.JobId);

			if setclipboard and pcall(setclipboard, link) then
				say(true, "join link copied");
			else
				say(false, "No clipboard support");
			end;
		end,
	});

end);

guard("camera", function()
	local lockedFov, holding = nil, false;
	local original = nil;

	local loop = RunService.RenderStepped:Connect(function()
		if not (ALIVE and holding and lockedFov) then return end;

		local camera = Render.camera();

		if camera and math.abs(camera.FieldOfView - lockedFov) > 0.01 then
			camera.FieldOfView = lockedFov;
		end;
	end);

	NeverLose:AddSignal(loop);

	local row = Sections.Camera:AddLabel("Field of View");

	row:AddToggle({
		Name = "Field of View",
		Default = false,
		Flag = "camera_fov",
		ToolTip = "Locks FOV",
		Callback = function(v)
			holding = v;

			local camera = Render.camera();

			if v then
				if camera and original == nil then original = camera.FieldOfView end;
			elseif camera and original then
				camera.FieldOfView = original;
			end;
		end,
	});

	row:AddSlider({
		Name = "Amount",
		Min = 40, Max = 120, Default = 70, Rounding = 0, Size = 110,
		Flag = "camera_fov_value",
		Callback = function(v) lockedFov = v end,
	});

	ESP.ClearCamera = onUnload("camera", function()
		holding = false;

		loop:Disconnect();

		local camera = workspace.CurrentCamera;

		if camera and original then camera.FieldOfView = original end;
	end);
end);

guard("misc", function()
	local players = Players;
	local run = RunService;
	local lp = LocalPlayer;
	local ws = workspace;
	local uis = game:GetService("UserInputService");
	local cs = game:GetService("CollectionService");
	local rs = game:GetService("ReplicatedStorage");
	local vu = game:GetService("VirtualUser");

	local function get_hrp()
		local c = lp.Character
		return c and c:FindFirstChild("HumanoidRootPart")
	end

	local function get_hum()
		local c = lp.Character
		return c and c:FindFirstChildOfClass("Humanoid")
	end

	local anti_afk, anti_fling, anti_void, anti_trap = false, false, false, false
	local coin_on = false
	local fade_on = false
	local void_original = ws.FallenPartsDestroyHeight
	local noclip_on, fly_on = false, false
	local inf_jump_on, wallhop_on = false, false
	local noclip_cache = {}
	local fling_cache = {}
	local last_coin_backup = nil

	local ws_on, ws_value = false, 40
	local jp_on, jp_value = false, 80

	local function kill_container(d)
		pcall(function()
			d.Archivable = true
			last_coin_backup = { clone = d:Clone(), parent = d.Parent }
			d:Destroy()
		end)
	end

	local function wipe_coins()
		for _, v in ipairs(cs:GetTagged("CoinVisual")) do
			pcall(function() v:Destroy() end)
		end
		for _, d in ipairs(ws:GetDescendants()) do
			if d.Name == "CoinContainer" then
				kill_container(d)
			end
		end
	end

	local function restore_coins()
		if last_coin_backup and last_coin_backup.clone then
			pcall(function()
				last_coin_backup.clone.Parent = last_coin_backup.parent or ws
			end)
			last_coin_backup = nil
		end
	end
	local player_gui = lp:FindFirstChildOfClass("PlayerGui")
	local fade_cache = {}
	local fade_conns = {}

	local FADE_GUI_NAMES = { CameraFade = true, SpawnFade = true, Fade = true, DeathFade = true }
	local fade_desc_conn = nil

	local function fade_gui()
		if player_gui and player_gui.Parent then return player_gui end
		player_gui = lp:FindFirstChildOfClass("PlayerGui")
		return player_gui
	end

	local function fade_hide(frame)
		if not frame or not frame.Parent or not frame:IsA("GuiObject") then return end
		if fade_cache[frame] == nil then fade_cache[frame] = frame.Visible end
		if frame.Visible then pcall(function() frame.Visible = false end) end
		if not fade_conns[frame] then
			fade_conns[frame] = frame:GetPropertyChangedSignal("Visible"):Connect(function()
				if fade_on and frame.Visible then
					pcall(function() frame.Visible = false end)
				end
			end)
		end
	end

	local function fade_match(inst)
		if not inst:IsA("GuiObject") then return false end
		local parent = inst.Parent
		if not parent then return false end
		if (inst.Name == "Fade" or inst.Name == "Frame") and parent:IsA("ScreenGui") and FADE_GUI_NAMES[parent.Name] then
			return true
		end
		if inst.Name == "Fade" and parent.Name == "Game" then
			return true
		end
		return false
	end

	local function fade_targets()
		local list = {}
		local gui = fade_gui()
		if not gui then return list end
		for _, child in ipairs(gui:GetChildren()) do
			if child:IsA("ScreenGui") and FADE_GUI_NAMES[child.Name] then
				for _, sub in ipairs(child:GetChildren()) do
					if sub:IsA("GuiObject") and (sub.Name == "Fade" or sub.Name == "Frame") then
						list[#list + 1] = sub
					end
				end
			end
		end
		local main = gui:FindFirstChild("MainGUI")
		local gg = main and main:FindFirstChild("Game")
		local gf = gg and gg:FindFirstChild("Fade")
		if gf and gf:IsA("GuiObject") then list[#list + 1] = gf end
		return list
	end

	local function fade_watch()
		if fade_desc_conn then return end
		local gui = fade_gui()
		if not gui then return end
		fade_desc_conn = gui.DescendantAdded:Connect(function(d)
			if not fade_on then return end
			if not fade_match(d) then return end
			task.defer(function()
				if fade_on and d.Parent then pcall(fade_hide, d) end
			end)
		end)
	end

	local function fade_apply()
		fade_watch()
		for _, frame in ipairs(fade_targets()) do
			pcall(fade_hide, frame)
		end
	end

	local function fade_restore()
		for _, conn in pairs(fade_conns) do
			pcall(function() conn:Disconnect() end)
		end
		fade_conns = {}
		for frame, v in pairs(fade_cache) do
			if frame and frame.Parent then
				pcall(function()
					frame.BackgroundTransparency = 1
					frame.Visible = v
				end)
			end
		end
		fade_cache = {}
	end
	local FLING_MAX_VEL = 700
	local FLING_MAX_ANG = 90
	local FLING_SNAP_DIST = 60
	local FLING_HOLD = 0.25
	local FLING_SAFE_VEL = 250

	local fling_reg = {}
	local fling_conns = {}
	local fling_attached = false
	local fling_safe_cf = nil
	local fling_hold_until = 0

	local fling_active_since = 0

	local function fling_busy()
		if fly_on then return true end
		if os.clock() < (getgenv().VELOCITY_DESYNC_UNTIL or 0) then return true end
		if (getgenv().FLING_ACTIVE or 0) > 0 then
			local now = os.clock()
			if fling_active_since == 0 then fling_active_since = now end
			if now - fling_active_since < 20 then return true end
			getgenv().FLING_ACTIVE = 0
			fling_active_since = 0
			return false
		end
		fling_active_since = 0
		return false
	end

	local function fling_kill_part(p)
		if fling_cache[p] == nil then fling_cache[p] = p.CanCollide end
		if p.CanCollide then p.CanCollide = false end
	end

	local function fling_unregister(model)
		local entry = fling_reg[model]
		if not entry then return end
		fling_reg[model] = nil
		for i = 1, #entry.conns do
			pcall(function() entry.conns[i]:Disconnect() end)
		end
		for p in pairs(entry.parts) do
			local v = fling_cache[p]
			fling_cache[p] = nil
			if v ~= nil and p.Parent then
				pcall(function() p.CanCollide = v end)
			end
		end
		table.clear(entry.parts)
	end

	local function fling_register(model)
		if not anti_fling or not model then return end
		if fling_reg[model] or model == lp.Character then return end
		local entry = { parts = {}, conns = {} }
		fling_reg[model] = entry
		local function add(d)
			if d:IsA("BasePart") and not entry.parts[d] then
				entry.parts[d] = true
				if anti_fling then pcall(fling_kill_part, d) end
			end
		end
		for _, d in model:GetDescendants() do
			pcall(add, d)
		end
		local function push(c) entry.conns[#entry.conns + 1] = c end
		push(model.DescendantAdded:Connect(function(d)
			if anti_fling then pcall(add, d) end
		end))
		push(model.DescendantRemoving:Connect(function(d)
			if entry.parts[d] then
				entry.parts[d] = nil
				fling_cache[d] = nil
			end
		end))
		push(model.AncestryChanged:Connect(function(_, parent)
			if not parent then fling_unregister(model) end
		end))
	end

	local function fling_is_body(m)
		return m ~= lp.Character
			and m:IsA("Model")
			and m:FindFirstChildOfClass("Humanoid") ~= nil
	end

	local function fling_scan()
		for _, pl in players:GetPlayers() do
			if pl ~= lp and pl.Character then fling_register(pl.Character) end
		end
		for _, m in ws:GetChildren() do
			if fling_is_body(m) then fling_register(m) end
		end
	end

	local function fling_sweep()
		for model, entry in pairs(fling_reg) do
			if not model.Parent or model == lp.Character then
				fling_unregister(model)
			else
				for p in pairs(entry.parts) do
					if p.Parent then
						if p.CanCollide then
							if fling_cache[p] == nil then fling_cache[p] = true end
							p.CanCollide = false
						end
					else
						entry.parts[p] = nil
						fling_cache[p] = nil
					end
				end
			end
		end
	end

	local function fling_guard(full)
		local hrp = get_hrp()
		if not hrp or not hrp.Parent then
			fling_safe_cf = nil
			return
		end
		if fling_busy() then
			fling_safe_cf = nil
			return
		end
		local lin = hrp.AssemblyLinearVelocity
		local ang = hrp.AssemblyAngularVelocity
		local spike = lin.Magnitude > FLING_MAX_VEL or ang.Magnitude > FLING_MAX_ANG
		local now = os.clock()
		if spike then fling_hold_until = now + FLING_HOLD end
		if spike or now < fling_hold_until then
			hrp.AssemblyLinearVelocity = Vector3.zero
			hrp.AssemblyAngularVelocity = Vector3.zero
			if full and fling_safe_cf then
				if (hrp.Position - fling_safe_cf.Position).Magnitude > FLING_SNAP_DIST then
					hrp.CFrame = fling_safe_cf
				end
			end
		elseif full and lin.Magnitude < FLING_SAFE_VEL then
			fling_safe_cf = hrp.CFrame
		end
	end

	local function fling_detach()
		fling_attached = false
		for i = 1, #fling_conns do
			pcall(function() fling_conns[i]:Disconnect() end)
		end
		table.clear(fling_conns)
	end

	local function fling_attach()
		if fling_attached then return end
		fling_attached = true
		local function push(c) fling_conns[#fling_conns + 1] = c end
		local function watch(pl)
			if pl == lp then return end
			push(pl.CharacterAdded:Connect(function(c)
				if anti_fling then fling_register(c) end
			end))
			push(pl.CharacterRemoving:Connect(function(c)
				fling_unregister(c)
			end))
		end
		for _, pl in players:GetPlayers() do watch(pl) end
		push(players.PlayerAdded:Connect(function(pl)
			watch(pl)
			if anti_fling and pl.Character then fling_register(pl.Character) end
		end))
		push(players.PlayerRemoving:Connect(function(pl)
			if pl.Character then fling_unregister(pl.Character) end
		end))
		push(ws.ChildAdded:Connect(function(m)
			if not anti_fling then return end
			task.defer(function()
				if anti_fling and m.Parent == ws and fling_is_body(m) then
					fling_register(m)
				end
			end)
		end))
		push(lp.CharacterAdded:Connect(function(c)
			fling_unregister(c)
			fling_safe_cf = nil
			fling_hold_until = 0
			if anti_fling then task.defer(fling_scan) end
		end))
		fling_scan()
	end

	local function fling_restore()
		fling_detach()
		for model in pairs(fling_reg) do
			fling_unregister(model)
		end
		table.clear(fling_reg)
		for p, v in pairs(fling_cache) do
			if p and p.Parent then pcall(function() p.CanCollide = v end) end
		end
		table.clear(fling_cache)
		fling_safe_cf = nil
		fling_hold_until = 0
	end
	local TRAP_LOCK = 1
	local TRAP_HOLD = 5
	local trap_window = 0
	local trap_busy = false
	local trap_speed_cache = 16
	local trap_jump_cache = 50
	local trap_hit_conn = nil

	local function trap_hum()
		local c = lp.Character
		return c and c:FindFirstChildOfClass("Humanoid")
	end

	local function trap_kill_gui()
		local gui = fade_gui()
		if not gui then return end
		for _, child in ipairs(gui:GetChildren()) do
			if child.Name == "TrapGUI" then
				pcall(function() child:Destroy() end)
			end
		end
	end

	local function trap_unlock(hum)
		if not hum or not hum.Parent then return end
		pcall(function()
			if hum.WalkSpeed <= TRAP_LOCK then hum.WalkSpeed = trap_speed_cache end
			if hum.JumpPower <= TRAP_LOCK then hum.JumpPower = trap_jump_cache end
		end)
	end

	local function trap_engage()
		if not anti_trap then return end
		trap_window = os.clock() + TRAP_HOLD
		local hum = trap_hum()
		if hum then
			if hum.WalkSpeed > TRAP_LOCK then trap_speed_cache = hum.WalkSpeed end
			if hum.JumpPower > TRAP_LOCK then trap_jump_cache = hum.JumpPower end
		end
		trap_kill_gui()
		if trap_busy then return end
		trap_busy = true
		task.spawn(function()
			while anti_trap and os.clock() < trap_window do
				trap_unlock(trap_hum())
				trap_kill_gui()
				run.Heartbeat:Wait()
			end
			trap_busy = false
		end)
	end

	local function trap_attach()
		if trap_hit_conn then return end
		local ok, remote = pcall(function()
			local sys = rs:FindFirstChild("TrapSystem")
			return sys and sys:FindFirstChild("TrapHitLocal")
		end)
		if not ok or not remote then return end
		trap_hit_conn = remote.OnClientEvent:Connect(function()
			task.spawn(trap_engage)
		end)
	end

	local function trap_detach()
		if trap_hit_conn then
			pcall(function() trap_hit_conn:Disconnect() end)
			trap_hit_conn = nil
		end
		trap_window = 0
		trap_unlock(trap_hum())
	end
	local function noclip_restore()
		for p, v in pairs(noclip_cache) do
			if p and p.Parent then p.CanCollide = v end
		end
		noclip_cache = {}
	end

	local part_index = setmetatable({}, { __mode = "k" })

	local function char_parts(char)
		local entry = part_index[char]
		if not entry then
			entry = { list = {}, valid = false }
			part_index[char] = entry
			local function dirty(d)
				if d:IsA("BasePart") then entry.valid = false end
			end
			entry.added = char.DescendantAdded:Connect(dirty)
			entry.removing = char.DescendantRemoving:Connect(dirty)
		end
		if not entry.valid then
			local list = entry.list
			table.clear(list)
			local n = 0
			for _, p in char:GetDescendants() do
				if p:IsA("BasePart") then
					n = n + 1
					list[n] = p
				end
			end
			entry.valid = true
		end
		return entry.list
	end

	local function release_part_index()
		for _, entry in pairs(part_index) do
			if entry.added then pcall(function() entry.added:Disconnect() end) end
			if entry.removing then pcall(function() entry.removing:Disconnect() end) end
		end
		part_index = setmetatable({}, { __mode = "k" })
	end

	local step_conn = run.Stepped:Connect(function()
		if anti_fling then
			if not fling_attached then pcall(fling_attach) end
			pcall(fling_sweep)
			pcall(fling_guard, true)
		end
		if noclip_on then
			if (getgenv().FLING_ACTIVE or 0) == 0 then
				local c = lp.Character
				if c then
					local list = char_parts(c)
					for i = 1, #list do
						local p = list[i]
						if p.Parent and p.CanCollide then
							if noclip_cache[p] == nil then noclip_cache[p] = p.CanCollide end
							p.CanCollide = false
						end
					end
				end
			elseif next(noclip_cache) then
				noclip_restore()
			end
		end
	end)

	local fling_beat_conn = run.Heartbeat:Connect(function()
		if anti_fling then
			pcall(fling_guard, false)
		end
	end)
	local controls_ref = nil
	local function get_controls()
		if controls_ref then return controls_ref end
		local ok, res = pcall(function()
			local ps = lp:FindFirstChild("PlayerScripts")
			local pm = ps and ps:FindFirstChild("PlayerModule")
			if not pm then return nil end
			return require(pm):GetControls()
		end)
		if ok and res then controls_ref = res end
		return controls_ref
	end

	local function flat_unit(v)
		local f = Vector3.new(v.X, 0, v.Z)
		if f.Magnitude > 0 then return f.Unit end
		return Vector3.zero
	end

	local function get_move_vector(cam)
		local c = get_controls()
		if c then
			local ok, v = pcall(function() return c:GetMoveVector() end)
			if ok and typeof(v) == "Vector3" and v.Magnitude > 0.05 then
				return v
			end
		end
		local ch = lp.Character
		local hum = ch and ch:FindFirstChildOfClass("Humanoid")
		if hum and cam then
			local md = hum.MoveDirection
			if md.Magnitude > 0.05 then
				local ff, fr = flat_unit(cam.CFrame.LookVector), flat_unit(cam.CFrame.RightVector)
				return Vector3.new(md:Dot(fr), 0, -md:Dot(ff))
			end
		end
		return Vector3.zero
	end

	local hop_params = RaycastParams.new()
	hop_params.FilterType = Enum.RaycastFilterType.Exclude
	hop_params.IgnoreWater = true
	local hop_ang = { 0, 0.45, -0.45, 0.9, -0.9, 1.4, -1.4, 2, -2, 2.6, -2.6, 3.14 }

	local function hop_wall(hrp, hum)
		local cam = ws.CurrentCamera
		local base = flat_unit(hum.MoveDirection)
		if base == Vector3.zero then
			base = cam and flat_unit(cam.CFrame.LookVector) or Vector3.zero
		end
		if base == Vector3.zero then return nil end
		hop_params.FilterDescendantsInstances = { lp.Character }
		local pos = hrp.Position
		for i = 1, #hop_ang do
			local c, s = math.cos(hop_ang[i]), math.sin(hop_ang[i])
			local dir = Vector3.new(base.X * c + base.Z * s, 0, base.Z * c - base.X * s) * 3
			local hit = ws:Raycast(pos, dir, hop_params)
			if not hit then
				hit = ws:Raycast(pos - Vector3.new(0, 2, 0), dir, hop_params)
			end
			if hit and math.abs(hit.Normal.Y) < 0.5 then return hit end
		end
		return nil
	end

	local hop_scan_t = 0
	local jump_conn = uis.JumpRequest:Connect(function()
		jump_hold_t = os.clock()
		if fly_on or (not inf_jump_on and not wallhop_on) then return end
		local hrp = get_hrp()
		local ch = lp.Character
		local hum = ch and ch:FindFirstChildOfClass("Humanoid")
		if not hrp or not hum or hum.Health <= 0 then return end
		if inf_jump_on then
			hum:ChangeState(Enum.HumanoidStateType.Jumping)
			return
		end
		if hum.FloorMaterial ~= Enum.Material.Air then return end
		local now = os.clock()
		if now - hop_scan_t < 0.1 then return end
		hop_scan_t = now
		local wall = hop_wall(hrp, hum)
		if not wall then return end
		local n = flat_unit(wall.Normal)
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
		local v = hrp.AssemblyLinearVelocity
		hrp.AssemblyLinearVelocity = Vector3.new(v.X + n.X * 3, v.Y, v.Z + n.Z * 3)
	end)

	local idle_conn = lp.Idled:Connect(function()
		if anti_afk then
			pcall(function()
				vu:CaptureController()
				vu:ClickButton2(Vector2.new())
			end)
		end
	end)

	local coin_conn = cs:GetInstanceAddedSignal("CoinVisual"):Connect(function(v)
		if coin_on then
			task.wait()
			if coin_on then pcall(function() v:Destroy() end) end
		end
	end)

	local coin_desc_conn = ws.DescendantAdded:Connect(function(d)
		if coin_on and d.Name == "CoinContainer" then
			task.wait()
			if coin_on then kill_container(d) end
		end
	end)

	local speed_conn = run.Stepped:Connect(function()

		if not (ws_on or jp_on) then return end

		local hum = get_hum()
		if not hum then return end
		if ws_on and hum.WalkSpeed ~= ws_value then
			hum.WalkSpeed = ws_value
		end
		if jp_on then
			if not hum.UseJumpPower then hum.UseJumpPower = true end
			if hum.JumpPower ~= jp_value then hum.JumpPower = jp_value end
		end
	end)

	local ws_original, jp_original, use_jp_original = nil, nil, nil

	Sections.Anti:AddLabel("Anti Fling"):AddToggle({
		Name = "Anti Fling",
		Default = false,
		Flag = "anti_fling",
		ToolTip = "Blocks fling",
		Callback = function(v)
			if v == anti_fling then return end;

			anti_fling = v;

			if v then fling_attach() else fling_restore() end;
		end,
	});

	Sections.Anti:AddLabel("Anti Blackout"):AddToggle({
		Name = "Anti Blackout",
		Default = false,
		Flag = "anti_blackout",
		ToolTip = "Blocks screen fades",
		Callback = function(v)
			if v == fade_on then return end;

			fade_on = v;

			if v then fade_apply() else fade_restore() end;
		end,
	});

	Sections.Anti:AddLabel("Anti AFK"):AddToggle({
		Name = "Anti AFK",
		Default = false,
		Flag = "anti_afk",
		ToolTip = "Prevents AFK kick",
		Callback = function(v) anti_afk = v end,
	});

	ESP.ClearMisc = onUnload("misc", function()
		anti_afk, anti_fling, anti_void, anti_trap = false, false, false, false
		coin_on, fade_on = false, false
		noclip_on, fly_on = false, false
		inf_jump_on, wallhop_on = false, false
		ws_on, jp_on = false, false

		pcall(function() ws.FallenPartsDestroyHeight = void_original end)

		for _, conn in ipairs({ idle_conn, coin_conn, coin_desc_conn, step_conn, fling_beat_conn, speed_conn, jump_conn }) do
			pcall(function() conn:Disconnect() end)
		end

		if fade_desc_conn then pcall(function() fade_desc_conn:Disconnect() end) fade_desc_conn = nil end

		pcall(trap_detach)
		pcall(restore_coins)
		pcall(fade_restore)
		pcall(fling_restore)
		pcall(noclip_restore)
		pcall(release_part_index)

		local hum = get_hum()

		if hum then
			pcall(function()
				if ws_original then hum.WalkSpeed = ws_original end
				if jp_original then hum.JumpPower = jp_original end
				if use_jp_original ~= nil then hum.UseJumpPower = use_jp_original end
			end)
		end
	end);
end);

guard("trade", function()
	local players = game:GetService("Players")
	local rs = game:GetService("ReplicatedStorage")
	local lp = players.LocalPlayer

	local show_on = false
	local conns = {}
	local gen = 0
	local sync = nil

	local env = getgenv()
	env.__SV_STORE = env.__SV_STORE or { pages = {}, items = {}, fails = {}, busy = {} }
	local store = env.__SV_STORE
	local prefetch_gen = 0
	local id_index = nil

	local BASE = "https://r.jina.ai/https://supremevalues.com/mm2/"
	local PAGES = {
		"godlies", "chromas", "ancients", "uniques", "vintages",
		"legendaries", "rares", "uncommons", "commons", "pets", "misc"
	}
	local RARITY_PAGE = {
		Common = "commons",
		Uncommon = "uncommons",
		Rare = "rares",
		Legendary = "legendaries",
		Godly = "godlies",
		Ancient = "ancients",
		Unique = "uniques",
		Classic = "vintages",
		Vintage = "vintages",
		Christmas = "misc",
		Halloween = "misc",
	}
	local SKIP = {
		"^Class %-", "^Range", "^Stability", "^Demand", "^Rarity", "^Change in Value",
		"^Inv%.", "^Value", "^Tier", "^Filter", "^Sort", "^Title:", "^URL Source",
		"^Published Time", "^Markdown Content", "^%*", "^!%[", "^%[", "^%-", "^Supreme",
		"^Trade your", "^The Supreme", "^Chance of"
	}

	local LOW = "<1"

	local function norm(s)
		return (string.gsub(string.lower(tostring(s)), "[^%w]", ""))
	end

	local function comma(n)
		local s = tostring(math.floor(n + 0.5))
		while true do
			local r
			s, r = string.gsub(s, "^(-?%d+)(%d%d%d)", "%1,%2")
			if r == 0 then break end
		end
		return s
	end

	local function skip_line(t)
		for _, p in ipairs(SKIP) do
			if string.match(t, p) then return true end
		end
		return string.find(t, "%]%(") ~= nil or #t > 44
	end

	local function unwrap(t)
		return string.match(t, "^!%[.-%]%b()%s*(.+)$") or t
	end

	local function parse_page(txt, slug)
		local out = {}
		local last = nil
		for line in string.gmatch(txt .. "\n", "([^\n]*)\n") do
			local t = unwrap(string.match(line, "^%s*(.-)%s*$"))
			if t ~= "" then
				local raw = string.match(t, "^Value %- %*%*(.-)%*%*")
				if raw then
					if last then
						local clean = string.gsub(raw, "[,%s]", "")
						local num = tonumber(clean)
						if not num and string.match(clean, "^x%d+T%d") then num = LOW end
						if not num and #clean > 0 and #clean <= 12 then num = clean end
						local key = norm(last)
						if num and key ~= "" then
							if out[key] == nil then out[key] = num end
							if slug == "chromas" then
								local cut = string.match(key, "^chroma(.+)") or string.match(key, "^c(.+)")
								if cut and cut ~= "" and out[cut] == nil then out[cut] = num end
							end
						end
					end
					last = nil
				elseif not skip_line(t) then
					last = t
				end
			end
		end
		return out
	end

	local function valid_body(s)
		if type(s) ~= "string" or #s < 512 then return false end
		if not string.find(s, "Markdown Content", 1, true) then return false end
		return true
	end

	local function http_get(url)
		local ok, res = pcall(function() return game:HttpGet(url, true) end)
		if ok and valid_body(res) then return res end
		local req = rawget(getfenv(), "request")
			or rawget(getfenv(), "http_request")
			or (syn and syn.request)
			or (http and http.request)
			or (fluxus and fluxus.request)
			or env.request
		if type(req) == "function" then
			local ok2, res2 = pcall(req, {
				Url = url,
				Method = "GET",
				Headers = { ["Accept"] = "text/plain", ["User-Agent"] = "Mozilla/5.0" }
			})
			if ok2 and type(res2) == "table" and valid_body(res2.Body) then return res2.Body end
		end
		return nil
	end

	local BACKOFF = { 2, 4, 6, 9 }
	local FAIL_COOLDOWN = 6

	local function get_page(slug)
		local cached = store.pages[slug]
		if cached then return cached end
		local waited = 0
		while store.busy[slug] do
			task.wait(0.2)
			waited = waited + 0.2
			if store.pages[slug] then return store.pages[slug] end
			if waited > 90 then
				store.busy[slug] = nil
				break
			end
		end
		if store.pages[slug] then return store.pages[slug] end
		local fail = store.fails[slug]
		if fail and os.clock() - fail < FAIL_COOLDOWN then return nil end
		store.busy[slug] = true
		local built = nil
		for attempt = 1, #BACKOFF + 1 do
			local txt = http_get(BASE .. slug)
			if txt then
				local ok, idx = pcall(parse_page, txt, slug)
				if ok and type(idx) == "table" and next(idx) ~= nil then
					built = idx
					break
				end
			end
			local nap = BACKOFF[attempt]
			if nap then task.wait(nap) end
		end
		store.busy[slug] = nil
		if built then
			store.pages[slug] = built
			store.fails[slug] = nil
			return built
		end
		store.fails[slug] = os.clock()
		return nil
	end

	local function item_keys(data)
		local base = norm(data.ItemName or data.Name or "")
		local keys = {}
		if base == "" then return keys end
		local ty = data.ItemType and norm(tostring(data.ItemType)) or nil
		local yr = data.Year and norm(tostring(data.Year)) or nil
		local evo = data.EvoIndex and ("var" .. norm(tostring(data.EvoIndex))) or nil

		local seen = {}
		local function push(k)
			if k == "" or seen[k] then return end
			seen[k] = true
			keys[#keys + 1] = k
		end

		if evo then push(base .. evo) end
		if ty and yr then push(base .. ty .. yr) end
		if ty then push(base .. ty) end
		if yr then push(base .. yr) end
		push(base)
		return keys
	end

	local function page_list(data, dtype)
		if dtype == "Pets" then return { "pets" } end
		if data.Chroma then return { "chromas" } end
		local p = RARITY_PAGE[data.Rarity or ""]
		if p then return { p } end
		return { "misc" }
	end

	local function match_index(idx, keys)
		for _, k in ipairs(keys) do
			local v = idx[k]
			if v ~= nil then return v end
		end
		return nil
	end

	local function resolve(dtype, id, data)
		local ck = tostring(dtype) .. "|" .. tostring(id) .. (data.Chroma and "|c" or "")
		local hit = store.items[ck]
		if hit ~= nil then return hit, true end

		local keys = item_keys(data)
		if #keys == 0 then return false, true end

		local primary = page_list(data, dtype)
		local incomplete = false

		for _, slug in ipairs(primary) do
			local idx = get_page(slug)
			if idx then
				local v = match_index(idx, keys)
				if v ~= nil then
					store.items[ck] = v
					return v, true
				end
			else
				incomplete = true
			end
		end

		if not data.Chroma then
			for _, slug in ipairs(PAGES) do
				local skip = slug == "chromas"
				for _, x in ipairs(primary) do
					if x == slug then skip = true break end
				end
				if not skip then
					local idx = store.pages[slug]
					if idx then
						local v = match_index(idx, keys)
						if v ~= nil then
							store.items[ck] = v
							return v, true
						end
					elseif not store.fails[slug] then
						incomplete = true
					end
				end
			end
		end

		if incomplete then return nil, false end
		store.items[ck] = false
		return false, true
	end

	local function prefetch()
		prefetch_gen = prefetch_gen + 1
		local my = prefetch_gen
		store.fails = {}
		task.spawn(function()
			for sweep = 1, 4 do
				local left = 0
				for _, slug in ipairs(PAGES) do
					if my ~= prefetch_gen or not show_on then return end
					if not store.pages[slug] then
						get_page(slug)
						if not store.pages[slug] then left = left + 1 end
						task.wait(0.4)
					end
				end
				if left == 0 then return end
				if my ~= prefetch_gen or not show_on then return end
				task.wait(sweep * 4)
			end
		end)
	end

	local function trade_root()
		local pg = lp:FindFirstChildOfClass("PlayerGui")
		local gui = pg and pg:FindFirstChild("TradeGUI")
		local cont = gui and gui:FindFirstChild("Container")
		return cont and cont:FindFirstChild("Trade"), gui
	end

	local function make_label(parent, name, size, pos, anchor, maxtext, align)
		local l = parent:FindFirstChild(name)
		if l then
			l.AnchorPoint = anchor
			l.Position = pos
			l.Size = size
			l.TextXAlignment = align
			local c = l:FindFirstChildOfClass("UITextSizeConstraint")
			if c then c.MaxTextSize = maxtext end
			return l
		end
		l = Instance.new("TextLabel")
		l.Name = name
		l.AnchorPoint = anchor
		l.Position = pos
		l.Size = size
		l.BackgroundTransparency = 1
		l.BorderSizePixel = 0
		l.Font = Enum.Font.GothamBold
		l.TextColor3 = Color3.fromRGB(255, 216, 110)
		l.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
		l.TextStrokeTransparency = 0.15
		l.TextXAlignment = align
		l.TextScaled = true
		l.RichText = false
		l.ZIndex = 40
		l.Text = ""
		local con = Instance.new("UITextSizeConstraint")
		con.MaxTextSize = maxtext
		con.MinTextSize = 7
		con.Parent = l
		l.Parent = parent
		return l
	end

	local function total_label(offer)
		local l = make_label(offer, "SV_Total",
			UDim2.new(0.4, 0, 0, 22), UDim2.new(0.025, 0, 1, -137),
			Vector2.new(0, 1), 22, Enum.TextXAlignment.Left)

		local width = offer.AbsoluteSize.X
		local left = width * 0.025
		local title = offer:FindFirstChild("Title")
		if title and title.TextBounds.X > 4 then
			left = (title.AbsolutePosition.X - offer.AbsolutePosition.X) + title.TextBounds.X + 10
		end
		local limit = width - left - 8
		local user = offer:FindFirstChild("Username")
		if user and user.TextBounds.X > 4 then
			local edge = (user.AbsolutePosition.X - offer.AbsolutePosition.X) + user.AbsoluteSize.X - user.TextBounds.X
			limit = math.min(limit, edge - left - 8)
		end
		l.Position = UDim2.new(0, math.floor(left), 1, -137)
		l.Size = UDim2.new(0, math.max(60, math.floor(limit)), 0, 22)
		return l
	end

	local function card_label(card)
		local l = make_label(card, "SV_Value",
			UDim2.new(0.7, 0, 0.16, 0), UDim2.new(1, -6, 0, 4),
			Vector2.new(1, 0), 18, Enum.TextXAlignment.Right)

		local inner = card:FindFirstChild("Container")
		local amt = inner and inner:FindFirstChild("Amount")
		local stacked = amt and amt.Visible and string.match(amt.Text or "", "x%s*%d") ~= nil
		l.Position = UDim2.new(1, -6, 0, stacked and 32 or 4)
		return l
	end

	local function clear_side(offer)
		if not offer then return end
		local l = offer:FindFirstChild("SV_Total")
		if l then l.Visible = false end
		local cont = offer:FindFirstChild("Container")
		if not cont then return end
		for _, ch in ipairs(cont:GetChildren()) do
			local v = ch:FindFirstChild("SV_Value")
			if v then v.Visible = false end
		end
	end

	local function wipe_labels()
		local root = trade_root()
		if not root then return end
		for _, side in ipairs({ "YourOffer", "TheirOffer" }) do
			local offer = root:FindFirstChild(side)
			if offer then
				local l = offer:FindFirstChild("SV_Total")
				if l then l:Destroy() end
				local cont = offer:FindFirstChild("Container")
				if cont then
					for _, ch in ipairs(cont:GetChildren()) do
						local v = ch:FindFirstChild("SV_Value")
						if v then v:Destroy() end
					end
				end
			end
		end
	end

	local function ensure_sync()
		if sync then return sync end
		local ok, mod = pcall(function()
			return require(rs:WaitForChild("Database"):WaitForChild("Sync"))
		end)
		if ok and type(mod) == "table" then sync = mod end
		return sync
	end

	local function build_index()
		if id_index then return id_index end
		if not ensure_sync() then return nil end
		local byid, byname = {}, {}
		local function add(map, key, rec)
			if not key or key == "" then return end
			local bucket = map[key]
			if bucket then
				bucket[#bucket + 1] = rec
			else
				map[key] = { rec }
			end
		end
		for _, dtype in ipairs({ "Weapons", "Pets" }) do
			local db = sync[dtype]
			if type(db) == "table" then
				for id, d in pairs(db) do
					if type(d) == "table" then
						local rec = { dtype = dtype, id = id, data = d }
						if d.ItemID then add(byid, tostring(d.ItemID), rec) end
						if type(d.Image) == "string" then
							local dig = string.match(d.Image, "assetId=(%d+)")
								or string.match(d.Image, "id=(%d+)")
								or string.match(d.Image, "rbxassetid://(%d+)")
							if dig then add(byid, dig, rec) end
						end
						add(byname, tostring(d.ItemName or d.Name or ""), rec)
					end
				end
			end
		end
		id_index = { byid = byid, byname = byname }
		return id_index
	end

	local function icon_id(card)
		local inner = card:FindFirstChild("Container")
		local icon = inner and inner:FindFirstChild("Icon")
		local img = icon and icon.Image or ""
		if img == "" then return nil end
		return string.match(img, "assetId=(%d+)")
			or string.match(img, "id=(%d+)")
			or string.match(img, "rbxassetid://(%d+)")
	end

	local function card_entry(card, text, chroma)
		local ix = build_index()
		if not ix then return nil end
		local iid = icon_id(card)
		local pool = iid and ix.byid[iid] or nil
		if not pool then pool = ix.byname[text] end
		if not pool then return nil end

		local fallback = nil
		for _, rec in ipairs(pool) do
			local d = rec.data
			if (d.Chroma == true) == chroma then
				if tostring(d.ItemName or d.Name or "") == text then return rec.dtype, rec.id, d end
				if not fallback then fallback = rec end
			end
		end
		if fallback then return fallback.dtype, fallback.id, fallback.data end
		if iid and ix.byid[iid] == pool then
			local rec = pool[1]
			return rec.dtype, rec.id, rec.data
		end
		return nil
	end

	local function gui_items(offer)
		local out = {}
		local cont = offer and offer:FindFirstChild("Container")
		if not cont then return out end
		local i = 1
		while true do
			local card = cont:FindFirstChild("NewItem" .. i)
			if not card or not card.Visible then break end
			local nm = card:FindFirstChild("ItemName")
			local lbl = nm and nm:FindFirstChild("Label")
			local text = lbl and lbl.Text or ""
			if text == "" then break end
			local tags = card:FindFirstChild("Tags")
			local ch = tags and tags:FindFirstChild("Chroma")
			local inner = card:FindFirstChild("Container")
			local amt_l = inner and inner:FindFirstChild("Amount")
			local amt = amt_l and tonumber(string.match(amt_l.Text or "", "x%s*(%d+)")) or 1
			local chroma = ch ~= nil and ch.Visible == true
			local dtype, id, data = card_entry(card, text, chroma)
			out[i] = {
				id = id or norm(text),
				amount = amt,
				dtype = dtype or "Weapons",
				data = data or { ItemName = text, Chroma = chroma }
			}
			i = i + 1
		end
		return out
	end

	local function collect(offer_data)
		local out = {}
		if type(offer_data) ~= "table" then return out end
		ensure_sync()
		for i, v in ipairs(offer_data) do
			local id = v[1] or v.ItemID
			local amount = v[2] or v.Amount or 1
			local dtype = v[3] or v.ItemType
			local db = sync and dtype and sync[dtype]
			local data = db and db[id]
			out[i] = { id = id, amount = amount, dtype = dtype, data = data }
		end
		return out
	end

	local function render(offer, items, my_gen)
		if not offer then return end
		local cont = offer:FindFirstChild("Container")
		if not cont then return end
		clear_side(offer)
		local total = total_label(offer)
		if #items == 0 then
			total.Visible = false
			return
		end
		total.Visible = true
		total.Text = "..."
		for i in ipairs(items) do
			local card = cont:FindFirstChild("NewItem" .. i)
			if card then
				local l = card_label(card)
				l.Visible = true
				l.Text = "..."
			end
		end
		task.spawn(function()
			local done = {}
			local deadline = os.clock() + 150
			while true do
				local pending = false
				local sum = 0
				for i, it in ipairs(items) do
					if my_gen ~= gen or not show_on then return end
					if done[i] == nil then
						if it.data then
							local val, settled = resolve(it.dtype, it.id, it.data)
							if settled then done[i] = { v = val } else pending = true end
						else
							done[i] = { v = false }
						end
					end
					if my_gen ~= gen or not show_on then return end
					local card = cont:FindFirstChild("NewItem" .. i)
					local l = card and card:FindFirstChild("SV_Value")
					local rec = done[i]
					if rec then
						local val = rec.v
						local amt = tonumber(it.amount) or 1
						if type(val) == "number" then
							sum = sum + val * amt
							if l then l.Text = comma(val) end
						elseif type(val) == "string" then
							if l then l.Text = val end
						elseif l then
							l.Text = "?"
						end
					elseif l then
						l.Text = "..."
					end
				end
				if total.Parent then
					total.Text = pending and (comma(sum) .. " ...") or comma(sum)
				end
				if not pending then return end
				if os.clock() > deadline then
					for i in ipairs(items) do
						if done[i] == nil then
							local card = cont:FindFirstChild("NewItem" .. i)
							local l = card and card:FindFirstChild("SV_Value")
							if l then l.Text = "?" end
						end
					end
					if total.Parent then total.Text = comma(sum) end
					return
				end
				task.wait(2)
			end
		end)
	end

	local function update(data)
		if not show_on or type(data) ~= "table" then return end
		local mine, theirs
		if data.Player1 and data.Player1.Player == lp then
			mine, theirs = data.Player1.Offer, data.Player2 and data.Player2.Offer
		elseif data.Player2 and data.Player2.Player == lp then
			mine, theirs = data.Player2.Offer, data.Player1 and data.Player1.Offer
		else
			return
		end
		gen = gen + 1
		local my_gen = gen
		local my_items, their_items = collect(mine), collect(theirs)
		task.delay(0.05, function()
			if my_gen ~= gen or not show_on then return end
			local root = trade_root()
			if not root then return end
			render(root:FindFirstChild("YourOffer"), my_items, my_gen)
			render(root:FindFirstChild("TheirOffer"), their_items, my_gen)
		end)
	end

	local function refresh_gui()
		if not show_on then return end
		local root, gui = trade_root()
		if not root or not gui or not gui.Enabled then return end
		gen = gen + 1
		local my_gen = gen
		local mine = root:FindFirstChild("YourOffer")
		local theirs = root:FindFirstChild("TheirOffer")
		render(mine, gui_items(mine), my_gen)
		render(theirs, gui_items(theirs), my_gen)
	end

	local function hook()
		local trade = rs:FindFirstChild("Trade")
		if not trade then return end
		local upd = trade:FindFirstChild("UpdateTrade")
		local start = trade:FindFirstChild("StartTrade")
		if upd then
			conns[#conns + 1] = upd.OnClientEvent:Connect(update)
		end
		if start then
			conns[#conns + 1] = start.OnClientEvent:Connect(function(data)
				update(data)
			end)
		end
		local _, gui = trade_root()
		if gui then
			conns[#conns + 1] = gui:GetPropertyChangedSignal("Enabled"):Connect(function()
				if not gui.Enabled then
					gen = gen + 1
					local root = trade_root()
					if root then
						clear_side(root:FindFirstChild("YourOffer"))
						clear_side(root:FindFirstChild("TheirOffer"))
					end
				end
			end)
		end
	end

	local function unhook()
		for _, c in ipairs(conns) do
			pcall(function() c:Disconnect() end)
		end
		conns = {}
	end

	Sections.Trade:AddLabel("Show Values"):AddToggle({
		Name = "Show Values",
		Default = false,
		Flag = "trade_show_values",
		ToolTip = "Shows trade values",
		Callback = function(v)
			show_on = v
			gen = gen + 1
			if v then
				unhook()
				hook()
				prefetch()
				refresh_gui()
			else
				prefetch_gen = prefetch_gen + 1
				unhook()
				wipe_labels()
			end
		end,
	});

	Sections.Trade:AddButton({
		Icon = "arrow-rotate-right",
		Name = "Refresh Values",
		Callback = function()
			if not show_on then return end;

			store.pages = {};
			store.items = {};
			store.fails = {};

			prefetch();
			refresh_gui();
		end,
	});

	ESP.ClearTrade = function()
		show_on = false
		gen = gen + 1
		prefetch_gen = prefetch_gen + 1
		unhook()
		wipe_labels()
	end;
end);

guard("menu", function()

	local HttpService = game:GetService("HttpService");
	local ContentProvider = game:GetService("ContentProvider");
	local function fileExists(path)
		return Remote.have(path);
	end;
	local function assetUrl(path)
		return Remote.id(path);
	end;
	local function readManifest(path)
		local body = Remote.body(path);
		if not body then return nil end;
		local ok, records = pcall(function() return HttpService:JSONDecode(body) end);
		return ok and type(records) == "table" and records or nil;
	end;
	local function localPath(relative)
		if type(relative) ~= "string" or relative == "" or relative:find("..", 1, true) or relative:find(":", 1, true) then return nil end;
		return Remote.file(relative);
	end;

	local function listFolder(relative)
		return Remote.under(relative .. "/");
	end;

	local function prettyName(name)
		local text = tostring(name or ""):match("^%s*(.-)%s*$");

		if text == "" then return "Untitled" end;

		return (text:gsub("[_%-]+", " "):gsub("(%a)(%d)", "%1 %2"):gsub("(%a[%w']*)", function(word)
			return word:sub(1, 1):upper() .. word:sub(2);
		end));
	end;

	do
		local url = assetUrl(Remote.file("sounds/Inject.wav")) or assetUrl(Remote.file("Inject.wav"));
		if url then
			local sound = Instance.new("Sound");
			sound.Name = NeverLose.RandomString();
			sound.SoundId = url;
			sound.Volume = 0.5;
			sound.Parent = NeverLose.ScreenGui;
			NeverLose:AddSignal(sound.Ended:Connect(function() sound:Destroy() end));
			game:GetService("Debris"):AddItem(sound, 30);
			sound:Play();
		end;
	end;

	local presets, order = {}, { "Off" };
	local records = readManifest("menusounds/manifest.json");
	if records then
		for _, entry in ipairs(records) do
			if type(entry) == "table" and type(entry.name) == "string" and entry.name ~= "Off" then
				local on, off = localPath(entry.on), localPath(entry.off);
				if on and fileExists(on) and not presets[entry.name] then
					presets[entry.name] = { on = on, off = off and fileExists(off) and off or nil };
					order[#order + 1] = entry.name;
				end;
			end;
		end;
	else
		local pairsFound, names = {}, {};
		for _, rel in ipairs(listFolder("menusounds")) do
			local file = string.match(rel, "([^/]+)$") or "";
			local name, side, extension = string.match(file:lower(), "^(.+)_(o[nf]f?)%.(%w+)$");
			if name and (extension == "wav" or extension == "ogg" or extension == "mp3") and fileExists(Remote.file(rel)) then
				if not pairsFound[name] then pairsFound[name] = {}; names[#names + 1] = name end;
				pairsFound[name][side] = Remote.file(rel);
			end;
		end;
		table.sort(names);
		for _, name in ipairs(names) do
			local entry = pairsFound[name];
			if entry.on then
				local label = prettyName(name) .. (entry.off and "" or " (ON only)");
				presets[label] = entry; order[#order + 1] = label;
			end;
		end;
	end;

	local M = { Preset = "Off", Volume = 50 };
	local onSound = Instance.new("Sound");
	onSound.Name = NeverLose.RandomString();
	onSound.Parent = NeverLose.ScreenGui;
	local offSound = onSound:Clone();
	offSound.Parent = NeverLose.ScreenGui;
	local function loadPreset(name)
		onSound:Stop(); offSound:Stop();
		local entry = presets[name];
		onSound.SoundId = entry and assetUrl(entry.on) or "";

		offSound.SoundId = entry and entry.off and assetUrl(entry.off) or "";
	end;
	local function click(state)
		if M.Preset == "Off" or M.Volume <= 0 then return end;
		local sound = state and onSound or offSound;
		if not sound.Parent or sound.SoundId == "" then return end;
		sound.Volume = M.Volume / 100;
		sound.TimePosition = 0;
		sound:Play();
	end;
	ESP.MenuClick = click;
	ESP.MenuSounds = M;

	local lib = NeverLose.Lib;
	local OFF_KINDS = { off = true, close = true };

	function lib:chime(kind)
		if M.Preset == "Off" or M.Volume <= 0 then return end;
		if lib.quiet then return end;

		click(not OFF_KINDS[kind]);
	end;

	NeverLose.OnToggleChanged = function(_, _, _)
		if Preview and Preview.Queue then Preview.Queue() end;
	end;
	Sections.MenuSounds:AddLabel("Preset"):AddDropdown({
		Default = "Off", Values = order, Flag = "menu_sound",
		Callback = function(value) M.Preset = value; loadPreset(value); if value ~= "Off" then click(true) end end,
	});
	Sections.MenuSounds:AddLabel("Volume"):AddSlider({
		Min = 0, Max = 100, Default = 50, Type = "%", Size = 100, Flag = "menu_sound_volume",
		Callback = function(value) M.Volume = value end,
	});

	local sheets, stickerOrder = {}, { "Off" };
	local function addSheet(record)
		if type(record) ~= "table" or type(record.name) ~= "string" or record.name == "Off" or sheets[record.name] then return end;
		local cols, rows = tonumber(record.cols), tonumber(record.rows);
		local width, height, frames = tonumber(record.width), tonumber(record.height), tonumber(record.frames);
		if not (cols and rows and width and height and frames) then return end;
		if cols < 1 or rows < 1 or frames < 1 or cols % 1 ~= 0 or rows % 1 ~= 0 or frames % 1 ~= 0 then return end;
		if width % cols ~= 0 or height % rows ~= 0 or width < cols or height < rows then return end;
		local files = {};
		for _, relative in ipairs(record.sheets or { record.file }) do
			local path = localPath(relative);
			if not (path and fileExists(path)) then return end;
			files[#files + 1] = path;
		end;
		if #files == 0 or frames > cols * rows * #files then return end;
		sheets[record.name] = {
			files = files, cols = cols, rows = rows, frames = frames,
			cellWidth = width / cols, cellHeight = height / rows,
			fps = math.clamp(tonumber(record.fps) or 15, 1, 120),
		};
		stickerOrder[#stickerOrder + 1] = record.name;
	end;
	local stickerRecords = readManifest("stickers/manifest.json");
	if stickerRecords then for _, record in ipairs(stickerRecords) do addSheet(record) end end;

	local CUSTOM = "Salad Visuals/Stickers";
	local customNames = {};

	local function scanCustom()
		if not (isfolder and listfiles and isfile) then return end;
		if not isfolder(CUSTOM) then
			if makefolder then pcall(makefolder, CUSTOM) end;

			return;
		end;

		local found = {};

		local ok = pcall(function()
			for _, path in ipairs(listfiles(CUSTOM)) do
				local file = string.match(path, "([^/\\]+)$") or "";
				local extension = string.match(string.lower(file), "%.(%w+)$");

				if extension == "png" or extension == "jpg" or extension == "jpeg" then
					found[#found + 1] = { path = path, file = file };
				end;
			end;
		end);

		if not ok then return end;

		table.sort(found, function(a, b) return string.lower(a.file) < string.lower(b.file) end);

		for _, entry in ipairs(found) do
			local stem = string.gsub(entry.file, "%.%w+$", "");
			local base, cols, rows, frames = string.match(stem, "^(.+)_(%d+)x(%d+)_(%d+)$");
			local name = prettyName(base or stem);

			if sheets[name] then name = name .. " (mine)" end;

			if not sheets[name] then
				if cols then
					sheets[name] = {
						files = { entry.path }, cols = tonumber(cols), rows = tonumber(rows),
						frames = tonumber(frames), cellWidth = nil, cellHeight = nil,
						fps = 15, custom = true, sheet = true,
					};
				else

					sheets[name] = {
						files = { entry.path }, cols = 1, rows = 1, frames = 1,
						fps = 1, custom = true, whole = true,
					};
				end;

				stickerOrder[#stickerOrder + 1] = name;
				customNames[#customNames + 1] = name;
			end;
		end;
	end;

	scanCustom();

	if #stickerOrder == 1 then
		local legacy = {};
		for _, path in ipairs(listFolder("stickers")) do
			local file = string.match(path, "([^/\\]+)$") or "";
			local name, cols, rows, frames = string.match(file, "^(.+)_(%d+)x(%d+)_(%d+)%.png$");
			if name then
				legacy[#legacy + 1] = { name = prettyName(name), file = "stickers/" .. file, cols = tonumber(cols), rows = tonumber(rows), frames = tonumber(frames), width = 128 * tonumber(cols), height = 128 * tonumber(rows), fps = 15 };
			end;
		end;
		table.sort(legacy, function(a, b) return a.name < b.name end);
		for _, record in ipairs(legacy) do addSheet(record) end;
	end;

	local ST = {
		Name = "Off", Size = 176, Speed = 100, Opacity = 100, Side = "Header",
		Raise = 0, OffsetX = 0, OffsetY = 0, Layer = 60,
	};
	local holder = Instance.new("ImageLabel");
	holder.Name = NeverLose.RandomString();
	holder.BackgroundTransparency = 1;
	holder.BorderSizePixel = 0;
	holder.ScaleType = Enum.ScaleType.Fit;
	holder.ImageColor3 = Color3.new(1, 1, 1);
	holder.ImageTransparency = 1;
	holder.Visible = false;
	holder.Active = false;
	holder.ZIndex = 60;
	holder.Parent = NeverLose.ScreenGui;
	local current, frame, elapsed, opacity = nil, 0, 0, 0;
	local menuOpen = Window.Signal:GetValue();
	local function place()
		local window = ESP.WindowFrame and ESP.WindowFrame();
		if not (window and current) then return end;
		local screen = NeverLose.ScreenGui.AbsoluteSize;
		local size = math.min(ST.Size, math.max(16, screen.X - 4), math.max(16, screen.Y - 4));
		local ratio = current.cellWidth / current.cellHeight;
		local width, height = size * math.min(1, ratio), size / math.max(1, ratio);
		local at, box = window.AbsolutePosition, window.AbsoluteSize;
		local origin = holder.AbsolutePosition - Vector2.new(holder.Position.X.Offset, holder.Position.Y.Offset);
		local x, y;

		if ST.Side == "Header" then x, y = at.X - width * 0.18, at.Y - height * 0.22;
		elseif ST.Side == "Header Right" then x, y = at.X + box.X - width * 0.82, at.Y - height * 0.22;
		elseif ST.Side == "Right" then x, y = at.X + box.X - width * 0.25, at.Y + box.Y - height;
		else x, y = at.X - width * 0.75, at.Y + box.Y - height end;

		x = math.clamp(x + ST.OffsetX, -width + 8, math.max(8, screen.X - 8));
		y = math.clamp(y + ST.OffsetY - ST.Raise, -height + 8, math.max(8, screen.Y - 8));
		holder.Size = UDim2.fromOffset(width, height);
		holder.ZIndex = ST.Layer;
		holder.Position = UDim2.fromOffset(x - origin.X, y - origin.Y);
	end;
	local function drawFrame()
		if not current then return end;
		local url = current.urls[1];

		if current.whole then
			if holder.Image ~= url then holder.Image = url end;
			holder.ImageRectSize = Vector2.new();
			holder.ImageRectOffset = Vector2.new();
			return;
		end;
		local capacity = current.cols * current.rows;
		local page = math.floor(frame / capacity) + 1;
		local localFrame = frame % capacity;
		url = current.urls[page];
		if holder.Image ~= url then holder.Image = url end;

		if not current.cellWidth then
			local source = (holder.ImageRectSize.X > 0) and holder.ImageRectSize or nil;
			local guess = source or Vector2.new(128 * current.cols, 128 * current.rows);
			current.cellWidth = guess.X / current.cols;
			current.cellHeight = guess.Y / current.rows;
		end;
		holder.ImageRectSize = Vector2.new(current.cellWidth, current.cellHeight);
		holder.ImageRectOffset = Vector2.new((localFrame % current.cols) * current.cellWidth, math.floor(localFrame / current.cols) * current.cellHeight);
	end;
	local function select(name)
		current = nil; frame = 0; elapsed = 0; opacity = 0;
		holder.Visible = false; holder.ImageTransparency = 1;
		local entry = sheets[name];
		if not entry then return end;
		if not entry.urls then
			local resolved = {};
			for _, path in ipairs(entry.files) do
				local url = assetUrl(path);
				if not url then ST.Error = "Unable to load " .. path; return end;
				resolved[#resolved + 1] = url;
			end;
			entry.urls = resolved;
			task.spawn(function() pcall(function() ContentProvider:PreloadAsync(resolved) end) end);
		end;
		ST.Error = nil;
		current = entry;
		drawFrame(); place();
	end;
	NeverLose:AddSignal(RunService.RenderStepped:Connect(function(dt)
		if not (NeverLose.ScreenGui.Parent and holder.Parent) then return end;
		local target = current and menuOpen and ST.Opacity / 100 or 0;
		opacity = opacity + (target - opacity) * (1 - math.exp(-18 * math.max(dt, 0)));
		if math.abs(target - opacity) < 0.001 then opacity = target end;
		holder.ImageTransparency = 1 - math.clamp(opacity, 0, 1);
		holder.Visible = current ~= nil and opacity > 0.001;
		if not current or not holder.Visible then return end;
		place();
		if not menuOpen or current.frames <= 1 then return end;
		local fps = current.fps * ST.Speed / 100;
		elapsed = elapsed + dt;
		local steps = math.floor(elapsed * fps);
		if steps < 1 then return end;
		elapsed = elapsed - steps / fps;
		frame = (frame + steps) % current.frames;
		drawFrame();
	end));
	local stickerDrop = Sections.MenuSticker:AddLabel("Sticker"):AddDropdown({
		Default = "Off", Values = stickerOrder, Flag = "menu_sticker",
		Callback = function(value) ST.Name = value; select(value) end,
	});

	Sections.MenuSticker:AddButton({
		Icon = "refresh-cw", Name = "Reload Stickers",
		Callback = function()
			local before = #stickerOrder;

			scanCustom();

			if stickerDrop and stickerDrop.SetValues then
				pcall(stickerDrop.SetValues, stickerDrop, stickerOrder);
			end;

			Notification.new({
				Title = "Stickers",
				Content = (#stickerOrder - before) .. " added, " .. #customNames .. " custom",
				Duration = 4,
			});
		end,
	});
	Sections.MenuSticker:AddLabel("Spot"):AddDropdown({
		Default = "Header", Values = { "Header", "Header Right", "Right", "Left" }, Flag = "menu_sticker_side",
		Callback = function(value) ST.Side = value; place() end,
	});
	Sections.MenuSticker:AddLabel("Size"):AddSlider({
		Min = 40, Max = 700, Default = 176, Rounding = 0, Size = 100, Flag = "menu_sticker_size",
		Callback = function(value) ST.Size = value; place() end,
	});
	Sections.MenuSticker:AddLabel("Playback Speed"):AddSlider({
		Min = 10, Max = 200, Default = 100, Rounding = 0, Type = "%", Size = 100, Flag = "menu_sticker_speed",
		Callback = function(value) ST.Speed = value end,
	});
	Sections.MenuSticker:AddLabel("Opacity"):AddSlider({
		Min = 0, Max = 100, Default = 100, Rounding = 0, Type = "%", Size = 100, Flag = "menu_sticker_opacity",
		Callback = function(value) ST.Opacity = value end,
	});

	Sections.MenuSticker:AddLabel("Offset X"):AddSlider({
		Min = -200, Max = 200, Default = 0, Rounding = 0, Size = 100, Flag = "menu_sticker_x",
		Callback = function(value) ST.OffsetX = value; place() end,
	});
	Sections.MenuSticker:AddLabel("Offset Y"):AddSlider({
		Min = -200, Max = 200, Default = 0, Rounding = 0, Size = 100, Flag = "menu_sticker_y",
		Callback = function(value) ST.OffsetY = value; place() end,
	});

	Sections.MenuSticker:AddLabel("Layer"):AddSlider({
		Min = 1, Max = 120, Default = 60, Rounding = 0, Size = 100, Flag = "menu_sticker_z",
		Callback = function(value) ST.Layer = value; place() end,
	});
	Window.Signal:Connect(function(open) menuOpen = open end);
	ESP.Sticker = ST;
	ESP.ClearMenuExtras = function()
		current = nil; menuOpen = false;
		ST.Name = "Off"; M.Preset = "Off";
		NeverLose.OnToggleChanged = function() end;
		onSound:Destroy(); offSound:Destroy(); holder:Destroy();
	end;
end);

guard("music", function()
	local HttpService = game:GetService("HttpService");
	local TweenService = game:GetService("TweenService");
	local UserInputService = game:GetService("UserInputService");

	local TH = NeverLose.Lib.theme;

	local CONFIG = "Salad Visuals/Config/spotify.json";
	local AUTH = "https://accounts.spotify.com/authorize";
	local TOKEN = "https://accounts.spotify.com/api/token";
	local API = "https://api.spotify.com/v1";
	local REDIRECT = "http://127.0.0.1:8888/callback";
	local SCOPES = "user-read-playback-state user-modify-playback-state user-read-currently-playing";

	local Playback = {
		title = "Nothing playing",
		artist = "",
		artwork = "",
		duration = 0,
		position = 0,
		playing = false,
		volume = 50,
		canSeek = false,
		canSkipNext = false,
		canSkipPrevious = false,
		shuffle = false,
		loop = false,
		status = "",
	};

	local HUD = {
		On = false,
		Layout = "Full",
		Artwork = true,
		Controls = true,
		Progress = true,
		Times = true,
		Visualizer = true,
		Opacity = 100,
		Scale = 100,
		Lyrics = false,
		LyricsSize = 150,
		LyricsSpot = "Bottom Left",
		LyricsX = 0,
		LyricsY = 0,
		LyricsPlaced = false,
		Spot = "Bottom Left",
		OffsetX = 0,
		OffsetY = 0,
		AccentColor = Color3.fromRGB(120, 200, 255),
		CoverSize = 52,
	};

	ESP.Music = { Playback = Playback, Hud = HUD };

	local requestFn = (syn and syn.request) or (http and http.request)
		or rawget(getgenv(), "http_request") or rawget(getgenv(), "request");

	local function httpJson(method, url, headers, body)
		if type(requestFn) ~= "function" then return nil, 0 end;

		local ok, res = pcall(requestFn, {
			Url = url,
			Method = method,
			Headers = headers,
			Body = body,
		});

		if not ok or type(res) ~= "table" then return nil, 0 end;

		local code = tonumber(res.StatusCode or res.Status or 0) or 0;

		if type(res.Body) ~= "string" or res.Body == "" then return nil, code, res end;

		local decoded;

		pcall(function() decoded = HttpService:JSONDecode(res.Body) end);

		return decoded, code, res;
	end;

	local function urlencode(value)
		return (string.gsub(tostring(value), "[^%w%-%._~]", function(c)
			return string.format("%%%02X", string.byte(c));
		end));
	end;

	local function form(pairsTable)
		local parts = {};

		for key, value in pairs(pairsTable) do
			parts[#parts + 1] = key .. "=" .. urlencode(value);
		end;

		return table.concat(parts, "&");
	end;

	local SAFE = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-._~";

	local function verifier()
		local out = {};

		for index = 1, 64 do
			local pick = math.random(1, #SAFE);

			out[index] = string.sub(SAFE, pick, pick);
		end;

		return table.concat(out);
	end;

	local function challengeFor(text)
		local crypt = rawget(getgenv(), "crypt");

		if not (crypt and crypt.hash and crypt.base64encode) then return nil end;

		local hex = crypt.hash(text, "sha256");

		if type(hex) ~= "string" then return nil end;

		local raw = (string.gsub(hex, "%x%x", function(byte)
			return string.char(tonumber(byte, 16));
		end));

		local encoded = crypt.base64encode(raw);

		encoded = string.gsub(encoded, "%+", "-");
		encoded = string.gsub(encoded, "/", "_");
		encoded = string.gsub(encoded, "=", "");

		return encoded;
	end;

	local COVER_DIR = Remote.store();
	local covers, coverBusy = {}, {};

	local function coverFor(url)
		if type(url) ~= "string" or url == "" then return "" end;
		if not string.find(url, "^https?://") then return url end;

		local hit = covers[url];

		if hit then return hit end;
		if coverBusy[url] then return "" end;

		coverBusy[url] = true;

		task.spawn(function()
			local asset = "";

			local ok = pcall(function()
				if not (writefile and getcustomasset and isfolder and makefolder) then return end;

								if not isfolder(COVER_DIR) then makefolder(COVER_DIR) end;

				local path = COVER_DIR .. "/" .. Remote.slug("cover:" .. url) .. ".png";

				if not isfile(path) then
					if type(requestFn) ~= "function" then return end;

					local fine, res = pcall(requestFn, { Url = url, Method = "GET" });

					if not (fine and type(res) == "table" and type(res.Body) == "string" and #res.Body > 256) then
						return;
					end;

					writefile(path, res.Body);
				end;

				asset = getcustomasset(path);
			end);

			covers[url] = (ok and asset ~= "") and asset or nil;
			coverBusy[url] = nil;
		end);

		return "";
	end;

	local LocalProvider = { name = "Local" };

	do
		local sound = Instance.new("Sound");
		sound.Name = NeverLose.RandomString();
		sound.Volume = 0.5;
		sound.Looped = false;
		sound.Parent = NeverLose.ScreenGui;

		local queue, cursor = {}, 0;
		local cover = "";

		LocalProvider.sound = sound;

		local function load(index)
			if #queue == 0 then return end;

			cursor = ((index - 1) % #queue) + 1;

			local entry = queue[cursor];

			sound.SoundId = "rbxassetid://" .. tostring(entry.id);
			sound.TimePosition = 0;
			sound:Play();
		end;

		function LocalProvider.add(text)
			local raw = tostring(text or "");
			local id = string.match(raw, "(%d+)");

			if not id then return false end;

			local rest = string.match(raw, "^%s*%d+%s*(.-)%s*$") or "";
			local artist, title = string.match(rest, "^(.-)%s*%-%s*(.+)$");

			queue[#queue + 1] = {
				id = id,
				title = title or (rest ~= "" and rest) or ("Track " .. id),
				artist = title and artist or nil,
			};

			if #queue == 1 then load(1) end;

			return true;
		end;

		function LocalProvider.clear()
			sound:Stop();

			table.clear(queue);

			cursor = 0;
		end;

		function LocalProvider.dump()
			local out = {};

			for _, entry in ipairs(queue) do
				out[#out + 1] = entry.id .. (entry.artist and (" " .. entry.artist .. " - " .. entry.title)
					or (entry.title and (" " .. entry.title) or ""));
			end;

			return out;
		end;

		function LocalProvider.restore(list)
			if type(list) ~= "table" then return end;

			LocalProvider.clear();

			for _, text in ipairs(list) do
				if type(text) == "string" then LocalProvider.add(text) end;
			end;

			sound:Stop();
			sound.TimePosition = 0;
		end;

		function LocalProvider.setCover(url) cover = url or "" end;

		function LocalProvider.play() if sound.SoundId ~= "" then sound:Resume() end end;
		function LocalProvider.pause() sound:Pause() end;
		function LocalProvider.stop() sound:Stop(); sound.TimePosition = 0 end;
		function LocalProvider.replay() sound.TimePosition = 0; sound:Play() end;
		function LocalProvider.next() if #queue > 0 then load(cursor + 1) end end;
		function LocalProvider.previous() if #queue > 0 then load(cursor - 1) end end;
		function LocalProvider.setLoop(v) sound.Looped = v and true or false end;
		function LocalProvider.setVolume(v) sound.Volume = math.clamp(v, 0, 100) / 100 end;
		function LocalProvider.seek(fraction)
			if sound.TimeLength > 0 then sound.TimePosition = sound.TimeLength * math.clamp(fraction, 0, 1) end;
		end;

		function LocalProvider.read(into)
			local entry = queue[cursor];

			into.title = entry and entry.title or "No track queued";
			into.artist = (entry and entry.artist)
				or ((#queue > 0) and (cursor .. " / " .. #queue) or "");
			into.album = "";
			into.artwork = cover;
			into.duration = sound.TimeLength or 0;
			into.position = sound.TimePosition or 0;
			into.playing = sound.IsPlaying;
			into.volume = math.floor(sound.Volume * 100 + 0.5);
			into.canSeek = sound.TimeLength > 0;
			into.canSkipNext = #queue > 1;
			into.canSkipPrevious = #queue > 1;
			into.loop = sound.Looped;
			into.status = "";
		end;

		onUnload("music local", function()
			pcall(function() sound:Stop() end);
			pcall(function() sound:Destroy() end);
		end);
	end;

	local Spotify = { name = "Spotify", connected = false };

	do
		local clientId = "";
		local refreshToken = "";
		local pendingVerifier = nil;
		local access, expires = "", 0;
		local backoffUntil = 0;

		local function save()
			if not writefile then return end;

			pcall(function()
				writefile(CONFIG, HttpService:JSONEncode({
					clientId = clientId,
					refreshToken = refreshToken,
					verifier = pendingVerifier or "",
				}));
			end);
		end;

		local function load()
			if not (isfile and readfile and isfile(CONFIG)) then return end;

			pcall(function()
				local blob = HttpService:JSONDecode(readfile(CONFIG));

				clientId = blob.clientId or "";
				refreshToken = blob.refreshToken or "";
				pendingVerifier = (blob.verifier ~= "" and blob.verifier) or nil;
			end);
		end;

		load();

		function Spotify.setClientId(value)
			clientId = tostring(value or ""):gsub("%s", "");

			save();
		end;

		function Spotify.hasClientId() return clientId ~= "" end;

		local function refresh()
			if clientId == "" or refreshToken == "" then return false end;

			local body, code = httpJson("POST", TOKEN,
				{ ["Content-Type"] = "application/x-www-form-urlencoded" },
				form({
					grant_type = "refresh_token",
					refresh_token = refreshToken,
					client_id = clientId,
				}));

			if code == 200 and body and body.access_token then
				access = body.access_token;
				expires = os.clock() + (tonumber(body.expires_in) or 3600) - 60;

				if body.refresh_token then refreshToken = body.refresh_token; save() end;

				Spotify.connected = true;

				return true;
			end;

			if code == 400 or code == 401 then
				refreshToken = "";
				Spotify.connected = false;

				save();
			end;

			return false;
		end;

		local function token()
			if access ~= "" and os.clock() < expires then return access end;

			return refresh() and access or nil;
		end;

		function Spotify.begin()
			if clientId == "" then
				Notification.new({ Title = "Spotify", Content = "Set a Client ID first", Duration = 6 });

				return;
			end;

			pendingVerifier = verifier();

			save();

			local challenge = challengeFor(pendingVerifier);

			if not challenge then
				Notification.new({ Title = "Spotify", Content = "Executor has no sha256", Duration = 6 });

				return;
			end;

			local url = AUTH .. "?" .. form({
				client_id = clientId,
				response_type = "code",
				redirect_uri = REDIRECT,
				code_challenge_method = "S256",
				code_challenge = challenge,
				scope = SCOPES,
			});

			pcall(setclipboard, url);

			Notification.new({
				Title = "Spotify",
				Content = "Link copied",
				Duration = 10,
			});
		end;

		function Spotify.finish(code)
			local text = tostring(code or "");

			local value = string.match(text, "code=([^&%s]+)") or string.match(text, "^%s*(%S+)%s*$");

			if not value then
				Spotify.lastError = "No code found";

				Notification.new({ Title = "spotify", Content = Spotify.lastError, Duration = 6 });

				return;
			end;

			if not pendingVerifier then
				Spotify.lastError = "Press Connect first";

				Notification.new({ Title = "spotify", Content = Spotify.lastError, Duration = 7 });

				return;
			end;

			local body, status = httpJson("POST", TOKEN,
				{ ["Content-Type"] = "application/x-www-form-urlencoded" },
				form({
					grant_type = "authorization_code",
					code = value,
					redirect_uri = REDIRECT,
					client_id = clientId,
					code_verifier = pendingVerifier,
				}));

			pendingVerifier = nil;

			save();

			if status == 200 and body and body.access_token then
				access = body.access_token;
				expires = os.clock() + (tonumber(body.expires_in) or 3600) - 60;
				refreshToken = body.refresh_token or "";
				Spotify.connected = true;

				save();

				Notification.new({ Title = "Spotify", Content = "Connected", Duration = 5 });
			else
				Spotify.connected = false;
				Spotify.lastError = ("http %s: %s"):format(
					tostring(status),
					(body and (body.error_description or body.error)) or "No response"
				);

				Notification.new({
					Title = "Spotify",
					Content = Spotify.lastError,
					Duration = 8,
				});
			end;
		end;

		function Spotify.disconnect()
			access, refreshToken, expires = "", "", 0;
			Spotify.connected = false;

			save();
		end;

		local function call(method, path, body)
			local key = token();

			if not key then return nil, 401 end;

			local headers = { ["Authorization"] = "Bearer " .. key };

			if body then headers["Content-Type"] = "application/json" end;

			return httpJson(method, API .. path, headers, body);
		end;

		Spotify.call = call;

		function Spotify.play() call("PUT", "/me/player/play") end;
		function Spotify.pause() call("PUT", "/me/player/pause") end;
		function Spotify.next() call("POST", "/me/player/next") end;
		function Spotify.previous() call("POST", "/me/player/previous") end;
		function Spotify.setVolume(v) call("PUT", "/me/player/volume?volume_percent=" .. math.floor(math.clamp(v, 0, 100))) end;
		function Spotify.seek(fraction)
			if Playback.duration <= 0 then return end;

			call("PUT", "/me/player/seek?position_ms=" .. math.floor(Playback.duration * math.clamp(fraction, 0, 1) * 1000));
		end;
		function Spotify.stop() Spotify.pause() end;
		function Spotify.replay() Spotify.seek(0) end;
		function Spotify.setLoop() end;

		function Spotify.refreshState(into)
			if clientId == "" then
				into.status = "No Client ID";
				into.title = "Spotify not set up";
				into.artist = "";
				into.playing = false;

				return;
			end;

			if refreshToken == "" and access == "" then
				into.status = "not connected";
				into.title = "Spotify not connected";
				into.artist = "";
				into.playing = false;

				return;
			end;

			if os.clock() < backoffUntil then return end;

			local body, code, raw = call("GET", "/me/player");

			if code == 204 then
				into.status = "No active device";
				into.title = "Nothing playing";
				into.artist = "open Spotify on any device";
				into.artwork = "";
				into.playing = false;
				into.duration, into.position = 0, 0;

				return;
			end;

			if code == 429 then
				local wait = 5;

				if raw and raw.Headers then
					wait = tonumber(raw.Headers["retry-after"] or raw.Headers["Retry-After"]) or 5;
				end;

				backoffUntil = os.clock() + wait;
				into.status = "rate limited";

				return;
			end;

			if code == 401 then
				if refresh() then return end;

				into.status = "session expired";
				into.playing = false;

				return;
			end;

			if code == 403 then
				local reason = raw and type(raw.Body) == "string" and raw.Body or "";

				if string.find(reason, "premium", 1, true) or string.find(reason, "Premium", 1, true) then
					into.status = "needs Spotify Premium on the app owner";
					into.title = "Spotify unavailable";
				elseif reason ~= "" then
					into.status = string.sub(reason, 1, 90);
					into.title = "Spotify unavailable";
				else
					into.status = "private session";
				end;

				into.artist = "";
				into.artwork = "";
				into.playing = false;
				into.duration, into.position = 0, 0;

				return;
			end;

			if not body or type(body.item) ~= "table" then
				into.status = (code == 200) and "Nothing playing" or ("http " .. tostring(code));
				into.playing = body and body.is_playing or false;

				return;
			end;

			local item = body.item;
			local artists = {};

			for _, artist in ipairs(item.artists or {}) do artists[#artists + 1] = artist.name end;

			local art = "";

			if item.album and type(item.album.images) == "table" then

				local best;

				for _, image in ipairs(item.album.images) do
					if not best or (image.width and image.width >= 160 and image.width < (best.width or 1e9)) then
						best = image;
					end;
				end;

				art = (best and best.url) or (item.album.images[1] and item.album.images[1].url) or "";
			end;

			into.trackId = item.id;
			into.album = (item.album and item.album.name) or "";
			into.title = item.name or "Unknown";
			into.artist = table.concat(artists, ", ");
			into.artwork = art;
			into.duration = (tonumber(item.duration_ms) or 0) / 1000;
			into.position = (tonumber(body.progress_ms) or 0) / 1000;
			into.playing = body.is_playing and true or false;
			into.shuffle = body.shuffle_state and true or false;
			into.loop = (body.repeat_state or "off") ~= "off";
			into.canSeek = true;
			into.canSkipNext = true;
			into.canSkipPrevious = true;
			into.status = "";

			if body.device and body.device.volume_percent then
				into.volume = body.device.volume_percent;
			end;
		end;
	end;

	local AUDIO_DIR = Remote.store();

	local audioCache = {};

	local function cacheAudio(url)
		if type(url) ~= "string" or url == "" then return nil, "no url" end;

		if audioCache[url] then return audioCache[url] end;

		if not (writefile and getcustomasset and isfolder and makefolder and isfile) then
			return nil, "executor cannot write files";
		end;

		local stamp;

		pcall(function()
			local hasher = rawget(getgenv(), "crypt");

			stamp = (hasher and hasher.hash) and string.sub(hasher.hash(url, "sha256"), 1, 24) or nil;
		end);

		stamp = stamp or (tostring(#url) .. "_" .. (string.match(url, "([%w]+)$") or "x"));

		local kind = string.match(string.lower(url), "%.(%a%a%a%a?)[%?#]") or "mp3";

		if kind ~= "mp3" and kind ~= "ogg" and kind ~= "wav" then kind = "mp3" end;

		local path = AUDIO_DIR .. "/" .. stamp .. "." .. kind;

		if not isfile(path) then
			if type(requestFn) ~= "function" then return nil, "no http" end;

			local ok, res = pcall(requestFn, { Url = url, Method = "GET" });

			if not (ok and type(res) == "table" and type(res.Body) == "string" and #res.Body > 4096) then
				return nil, "download failed";
			end;

						if not isfolder(AUDIO_DIR) then makefolder(AUDIO_DIR) end;

			local fine = pcall(writefile, path, res.Body);

			if not fine then return nil, "could not write" end;
		end;

		local ok, asset = pcall(getcustomasset, path);

		if not (ok and type(asset) == "string" and asset ~= "") then return nil, "asset failed" end;

		audioCache[url] = asset;

		return asset;
	end;

	local function streamProvider(name, resolve)
		local P = { name = name };

		local sound = Instance.new("Sound");
		sound.Name = NeverLose.RandomString();
		sound.Volume = 0.5;
		sound.Looped = false;
		sound.Parent = NeverLose.ScreenGui;

		local queue, cursor, note = {}, 0, "";

		P.sound = sound;

		local function load(index)
			if #queue == 0 then return end;

			cursor = ((index - 1) % #queue) + 1;

			local entry = queue[cursor];

			if not entry.asset then
				note = "loading " .. tostring(entry.title);

				local asset, why = cacheAudio(entry.url);

				if not asset then
					note = tostring(why);

					return;
				end;

				entry.asset = asset;
			end;

			note = "";
			sound.SoundId = entry.asset;
			sound.TimePosition = 0;
			sound:Play();
		end;

		function P.add(text)
			task.spawn(function()
				note = "resolving...";

				local ok, track, why = pcall(resolve, text);

				if not ok then
					note = tostring(track);

					return;
				end;

				if not track then
					note = tostring(why or "Nothing found");

					return;
				end;

				local list = track.tracks or { track };

				for _, one in ipairs(list) do
					if type(one.url) == "string" and one.url ~= "" then
						queue[#queue + 1] = {
							title = one.title or "Unknown",
							artist = one.artist or "",
							artwork = one.artwork or "",
							duration = tonumber(one.duration) or 0,
							url = one.url,
						};
					end;
				end;

				note = "";

				if cursor == 0 and #queue > 0 then load(1) end;
			end);

			return true;
		end;

		function P.clear()
			sound:Stop();
			table.clear(queue);
			cursor, note = 0, "";
		end;

		function P.play() if sound.SoundId ~= "" then sound:Resume() end end;
		function P.pause() sound:Pause() end;
		function P.stop() sound:Stop(); sound.TimePosition = 0 end;
		function P.replay() sound.TimePosition = 0; sound:Play() end;
		function P.next() if #queue > 0 then task.spawn(load, cursor + 1) end end;
		function P.previous() if #queue > 0 then task.spawn(load, cursor - 1) end end;
		function P.setLoop(v) sound.Looped = v and true or false end;
		function P.setVolume(v) sound.Volume = math.clamp(v, 0, 100) / 100 end;

		function P.seek(fraction)
			if sound.TimeLength > 0 then
				sound.TimePosition = sound.TimeLength * math.clamp(fraction, 0, 1);
			end;
		end;

		function P.read(into)
			local entry = queue[cursor];

			into.title = entry and entry.title or (name .. ": nothing queued");
			into.artist = entry and entry.artist or "";
			into.album = "";
			into.artwork = entry and coverFor(entry.artwork) or "";
			into.duration = (sound.TimeLength > 0) and sound.TimeLength or (entry and entry.duration or 0);
			into.position = sound.TimePosition or 0;
			into.playing = sound.IsPlaying;
			into.volume = math.floor(sound.Volume * 100 + 0.5);
			into.canSeek = sound.TimeLength > 0;
			into.canSkipNext = #queue > 1;
			into.canSkipPrevious = #queue > 1;
			into.loop = sound.Looped;
			into.status = note;
		end;

		onUnload("music " .. string.lower(name), function()
			pcall(function() sound:Stop() end);
			pcall(function() sound:Destroy() end);
		end);

		return P;
	end;

	local SC = { Client = "" };

	local function soundcloudResolve(text)
		local raw = string.match(tostring(text or ""), "^%s*(.-)%s*$");

		if raw == "" then return nil, "paste a soundcloud link" end;

		if string.find(string.lower(raw), "%.mp3") or string.find(string.lower(raw), "%.ogg") then
			return { title = string.match(raw, "([^/]+)%.%a+") or "Track", artist = "", url = raw };
		end;

		if SC.Client == "" then return nil, "set a client id first" end;

		local data, code = httpJson("GET", ("https://api-v2.soundcloud.com/resolve?url=%s&client_id=%s")
			:format(urlencode(raw), urlencode(SC.Client)));

		if code == 401 or code == 403 then return nil, "client id rejected" end;
		if type(data) ~= "table" then return nil, "resolve failed (" .. tostring(code) .. ")" end;

		local items = data.tracks or { data };
		local out = {};

		for _, item in ipairs(items) do
			if type(item) == "table" and type(item.media) == "table" then
				local stream;

				for _, t in ipairs(item.media.transcodings or {}) do
					if type(t) == "table" and type(t.format) == "table"
						and t.format.protocol == "progressive" then
						stream = t.url;
					end;
				end;

				if stream then
					local hand, leadCode = httpJson("GET", stream .. "?client_id=" .. urlencode(SC.Client));

					if type(hand) == "table" and type(hand.url) == "string" then
						out[#out + 1] = {
							title = item.title or "Track",
							artist = (type(item.user) == "table" and item.user.username) or "",
							artwork = item.artwork_url or "",
							duration = (tonumber(item.duration) or 0) / 1000,
							url = hand.url,
						};
					elseif leadCode == 401 or leadCode == 403 then
						return nil, "client id rejected";
					end;
				end;
			end;
		end;

		if #out == 0 then return nil, "No playable stream" end;

		return { tracks = out };
	end;

	local VK = { Token = "" };

	local function vkResolve(text)
		local raw = string.match(tostring(text or ""), "^%s*(.-)%s*$");

		if string.find(string.lower(raw), "%.mp3") or string.find(string.lower(raw), "%.m4a") then
			return { title = string.match(raw, "([^/]+)%.%a+") or "Track", artist = "", url = raw };
		end;

		if VK.Token == "" then return nil, "set a vk token first" end;

		local owner, count = string.match(raw, "^(-?%d+)"), 25;
		local url = ("https://api.vk.com/method/audio.get?v=5.131&count=%d&access_token=%s")
			:format(count, urlencode(VK.Token));

		if owner then url = url .. "&owner_id=" .. owner end;

		local data, code = httpJson("GET", url);

		if type(data) ~= "table" then return nil, "vk unreachable (" .. tostring(code) .. ")" end;

		if type(data.error) == "table" then
			return nil, "vk: " .. tostring(data.error.error_msg or data.error.error_code);
		end;

		local items = (type(data.response) == "table" and data.response.items) or {};
		local out = {};

		for _, item in ipairs(items) do

			if type(item) == "table" and type(item.url) == "string" and item.url ~= ""
				and not string.find(item.url, "%.m3u8") then
				out[#out + 1] = {
					title = item.title or "Track",
					artist = item.artist or "",
					duration = tonumber(item.duration) or 0,
					url = item.url,
				};
			end;
		end;

		if #out == 0 then return nil, "No direct file" end;

		return { tracks = out };
	end;

	local SoundCloud = streamProvider("SoundCloud", soundcloudResolve);
	local Vk = streamProvider("VK", vkResolve);

	ESP.Music.SoundCloud = SoundCloud;
	ESP.Music.Vk = Vk;

	local providers = { Local = LocalProvider, Spotify = Spotify, SoundCloud = SoundCloud, VK = Vk };
	local current = "Local";

	ESP.Music.Providers = providers;
	ESP.Music.Local = LocalProvider;
	ESP.Music.Spotify = Spotify;

	local function provider() return providers[current] or LocalProvider end;

	local function command(name, ...)
		local p = provider();
		local fn = p[name];

		if type(fn) == "function" then pcall(fn, ...) end;
	end;

	local gui = Render.gui("music", 40);

	local panel = Instance.new("Frame");
	panel.Name = "NowPlaying";
	panel.BackgroundColor3 = TH.panel;
	panel.BorderSizePixel = 0;
	panel.Size = UDim2.fromOffset(286, 88);
	panel.Visible = false;
	panel.Parent = gui;

	Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 7);

	local sheen = Instance.new("UIGradient", panel);
	sheen.Rotation = 90;
	sheen.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 178, 190)),
	});

	pcall(function()
		local shade = Instance.new("UIShadow");
		shade.Color = TH.bg;
		shade.BlurRadius = UDim.new(0, 12);
		shade.Parent = panel;
	end);

	local edge = Instance.new("UIStroke", panel);
	edge.Color = TH.line;
	edge.Transparency = 0.45;
	edge.Thickness = 1;

	local scale = Instance.new("UIScale", panel);

	local art = Instance.new("ImageLabel");
	art.Name = "Art";
	art.BackgroundColor3 = TH.head;
	art.BorderSizePixel = 0;
	art.Position = UDim2.fromOffset(11, 11);
	art.Size = UDim2.fromOffset(56, 56);
	art.ScaleType = Enum.ScaleType.Crop;
	art.Parent = panel;

	Instance.new("UICorner", art).CornerRadius = UDim.new(0, 6);

	local artEdge = Instance.new("UIStroke", art);
	artEdge.Color = TH.line;
	artEdge.Transparency = 0.6;

	local artMark = Instance.new("ImageLabel");
	artMark.Name = "ArtMark";
	artMark.BackgroundTransparency = 1;
	artMark.AnchorPoint = Vector2.new(0.5, 0.5);
	artMark.Position = UDim2.fromScale(0.5, 0.5);
	artMark.Size = UDim2.fromScale(0.42, 0.42);
	artMark.ScaleType = Enum.ScaleType.Fit;
	artMark.ImageColor3 = TH.dim;
	artMark.ImageTransparency = 0.25;
	artMark.Image = "rbxassetid://" .. tostring(NeverLose.Lib.icons["volume-2"] or 0);
	artMark.Parent = art;

	local artOld = art:Clone();
	artOld.Name = "ArtOld";
	artOld.ImageTransparency = 1;
	artOld.BackgroundTransparency = 1;
	artOld.Parent = panel;

	local staleMark = artOld:FindFirstChild("ArtMark");

	if staleMark then staleMark:Destroy() end;

	local title = Instance.new("TextLabel");
	title.Name = "Title";
	title.BackgroundTransparency = 1;
	title.Position = UDim2.fromOffset(78, 12);
	title.Size = UDim2.new(1, -88, 0, 17);
	title.FontFace = NeverLose.BuiltInBold;
	title.TextSize = 13;
	title.TextColor3 = TH.text;
	title.TextXAlignment = Enum.TextXAlignment.Left;
	title.TextTruncate = Enum.TextTruncate.AtEnd;
	title.Text = "Nothing playing";
	title.ClipsDescendants = true;
	title.Parent = panel;

	local artist = Instance.new("TextLabel");
	artist.Name = "Artist";
	artist.BackgroundTransparency = 1;
	artist.Position = UDim2.fromOffset(78, 29);
	artist.Size = UDim2.new(1, -88, 0, 14);
	artist.FontFace = NeverLose.BuiltInRegular;
	artist.TextSize = 11;
	artist.TextColor3 = TH.dim;
	artist.TextXAlignment = Enum.TextXAlignment.Left;
	artist.TextTruncate = Enum.TextTruncate.AtEnd;
	artist.Text = "";
	artist.Parent = panel;

	local track = Instance.new("Frame");
	track.Name = "Track";
	track.BackgroundColor3 = TH.head;
	track.BorderSizePixel = 0;
	track.Position = UDim2.fromOffset(78, 52);
	track.Size = UDim2.new(1, -90, 0, 4);
	track.Parent = panel;

	Instance.new("UICorner", track).CornerRadius = UDim.new(1, 0);

	local fill = Instance.new("Frame");
	fill.Name = "Fill";
	fill.BackgroundColor3 = HUD.AccentColor;
	fill.BorderSizePixel = 0;
	fill.Size = UDim2.fromScale(0, 1);
	fill.Parent = track;

	Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0);

	local knob = Instance.new("Frame");
	knob.Name = "Knob";
	knob.AnchorPoint = Vector2.new(0.5, 0.5);
	knob.Position = UDim2.new(1, 0, 0.5, 0);
	knob.Size = UDim2.fromOffset(8, 8);
	knob.BorderSizePixel = 0;
	knob.ZIndex = 3;
	knob.Parent = fill;

	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0);

	local seekHit = Instance.new("TextButton");
	seekHit.Name = "Seek";
	seekHit.BackgroundTransparency = 1;
	seekHit.Text = "";
	seekHit.Position = UDim2.fromOffset(0, -6);
	seekHit.Size = UDim2.new(1, 0, 0, 15);
	seekHit.Parent = track;

	local clock = Instance.new("TextLabel");
	clock.Name = "Clock";
	clock.BackgroundTransparency = 1;
	clock.Position = UDim2.fromOffset(78, 61);
	clock.Size = UDim2.new(1, -90, 0, 12);
	clock.FontFace = NeverLose.BuiltInRegular;
	clock.TextSize = 10;
	clock.TextColor3 = TH.dim;
	clock.TextXAlignment = Enum.TextXAlignment.Left;
	clock.Text = "0:00 / 0:00";
	clock.Parent = panel;

	local GLYPH = {};

	for _, name in ipairs({ "play", "pause", "next", "prev", "stop" }) do
		GLYPH[name] = Remote.asset("images/ui_" .. name .. ".png");
	end;

	local controls = Instance.new("Frame");
	controls.Name = "Controls";
	controls.BackgroundTransparency = 1;
	controls.AnchorPoint = Vector2.new(1, 0);
	controls.Position = UDim2.new(1, -10, 0, 56);
	controls.Size = UDim2.fromOffset(84, 24);
	controls.Parent = panel;

	local IDLE, HOVER, DOWN, OFF = 0.28, 0, 0.1, 0.72;

	local function transport(name, x, size)
		local holder = Instance.new("ImageButton");
		holder.Name = name;
		holder.BackgroundColor3 = TH.glow;
		holder.BackgroundTransparency = 1;
		holder.BorderSizePixel = 0;
		holder.AutoButtonColor = false;
		holder.Image = "";
		holder.Position = UDim2.fromOffset(x, 0);
		holder.Size = UDim2.fromOffset(size, 24);
		holder.Parent = controls;

		Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 6);

		local glyph = Instance.new("ImageLabel");
		glyph.Name = "Glyph";
		glyph.BackgroundTransparency = 1;
		glyph.AnchorPoint = Vector2.new(0.5, 0.5);
		glyph.Position = UDim2.fromScale(0.5, 0.5);
		glyph.Size = UDim2.fromOffset(size - 10, size - 10);
		glyph.ScaleType = Enum.ScaleType.Fit;
		glyph.ImageColor3 = TH.text;
		glyph.ImageTransparency = IDLE;
		glyph.Parent = holder;

		local pulse = Instance.new("UIScale", holder);

		local item = { button = holder, glyph = glyph, enabled = true, hovered = false };

		local function repaint()
			local target = IDLE;

			if not item.enabled then
				target = OFF;
			elseif item.down then
				target = DOWN;
			elseif item.hovered then
				target = HOVER;
			end;

			TweenService:Create(glyph, TweenInfo.new(0.12), { ImageTransparency = target }):Play();
			TweenService:Create(holder, TweenInfo.new(0.12), {
				BackgroundTransparency = (item.enabled and item.hovered) and 0.9 or 1,
			}):Play();
			TweenService:Create(pulse, TweenInfo.new(0.09), { Scale = item.down and 0.88 or 1 }):Play();
		end;

		holder.MouseEnter:Connect(function() item.hovered = true; repaint() end);
		holder.MouseLeave:Connect(function() item.hovered, item.down = false, false; repaint() end);
		holder.MouseButton1Down:Connect(function() item.down = true; repaint() end);
		holder.MouseButton1Up:Connect(function() item.down = false; repaint() end);

		function item.setEnabled(on)
			if item.enabled == on then return end;

			item.enabled = on;

			repaint();
		end;

		function item.setGlyph(key)
			glyph.Image = GLYPH[key] or "";
		end;

		item.repaint = repaint;

		return item;
	end;

	local prevBtn = transport("Prev", 0, 24);
	local playBtn = transport("Play", 30, 26);
	local nextBtn = transport("Next", 60, 24);

	prevBtn.setGlyph("prev");
	playBtn.setGlyph("play");
	nextBtn.setGlyph("next");

	local bars = {};

	for index = 1, 4 do
		local b = Instance.new("Frame");
		b.Name = "Bar" .. index;
		b.BackgroundColor3 = HUD.AccentColor;
		b.BorderSizePixel = 0;
		b.AnchorPoint = Vector2.new(0, 1);
		b.Position = UDim2.fromOffset(9 + (index - 1) * 5, 61);
		b.Size = UDim2.fromOffset(3, 4);
		b.Visible = false;
		b.Parent = panel;

		Instance.new("UICorner", b).CornerRadius = UDim.new(0, 1);

		bars[index] = b;
	end;

	local SPOTS = {
		["Top Left"] = Vector2.new(0, 0),
		["Top Right"] = Vector2.new(1, 0),
		["Bottom Left"] = Vector2.new(0, 1),
		["Bottom Right"] = Vector2.new(1, 1),
	};

	local PAD = 16;

	local function place()
		local anchor = SPOTS[HUD.Spot] or SPOTS["Bottom Left"];

		local screen = workspace.CurrentCamera.ViewportSize;
		local size = panel.AbsoluteSize;

		local function limit(side, offset, extent, span)
			if extent <= 1 or span <= extent then return offset end;

			local base = (side == 0) and PAD or (span - PAD - extent);

			return math.clamp(offset, -base, span - extent - base);
		end;

		HUD.OffsetX = limit(anchor.X, HUD.OffsetX, size.X, screen.X);
		HUD.OffsetY = limit(anchor.Y, HUD.OffsetY, size.Y, screen.Y);

		panel.AnchorPoint = anchor;
		panel.Position = UDim2.new(
			anchor.X,
			(anchor.X == 0 and PAD or -PAD) + HUD.OffsetX,
			anchor.Y,
			(anchor.Y == 0 and PAD or -PAD) + HUD.OffsetY
		);
	end;

	local dragging, dragFrom, dragBase = false, nil, nil;

	local placeLyrics;

	local function pushOffsets()
		for flag, value in pairs({ music_x = HUD.OffsetX, music_y = HUD.OffsetY }) do
			local item = NeverLose.Flags[flag];

			if item and item.SetValue then pcall(item.SetValue, item, value) end;
		end;

		local spot = NeverLose.Flags.music_spot;

		if spot and spot.SetValue then pcall(spot.SetValue, spot, HUD.Spot) end;
	end;

	local GuiService = game:GetService("GuiService");

	local function screenAt(object)
		return object.AbsolutePosition + GuiService:GetGuiInset();
	end;

	local function snapCorner()
		local screen = NeverLose.ScreenGui.AbsoluteSize;

		if screen.X < 8 or screen.Y < 8 then return end;

		local center = screenAt(panel) + panel.AbsoluteSize * 0.5;
		local right = center.X > screen.X * 0.5;
		local bottom = center.Y > screen.Y * 0.5;

		HUD.Spot = (bottom and "Bottom " or "Top ") .. (right and "Right" or "Left");

		local anchor = SPOTS[HUD.Spot];
		local at = screenAt(panel) + panel.AbsoluteSize * Vector2.new(anchor.X, anchor.Y);
		local corner = Vector2.new(anchor.X * screen.X, anchor.Y * screen.Y);
		local base = Vector2.new(anchor.X == 0 and PAD or -PAD, anchor.Y == 0 and PAD or -PAD);

		local reachX = math.max(0, screen.X - panel.AbsoluteSize.X);
		local reachY = math.max(0, screen.Y - panel.AbsoluteSize.Y);

		HUD.OffsetX = math.clamp(math.floor(at.X - corner.X - base.X + 0.5), -reachX, reachX);
		HUD.OffsetY = math.clamp(math.floor(at.Y - corner.Y - base.Y + 0.5), -reachY, reachY);
	end;

	panel.Active = true;

	panel.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return;
		end;

		dragging = true;
		dragFrom = input.Position;
		dragBase = Vector2.new(HUD.OffsetX, HUD.OffsetY);
	end);

	NeverLose:AddSignal(UserInputService.InputChanged:Connect(function(input)
		if not dragging then return end;

		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return;
		end;

		local delta = input.Position - dragFrom;

		HUD.OffsetX = dragBase.X + delta.X;
		HUD.OffsetY = dragBase.Y + delta.Y;

		place();

		local screen = NeverLose.ScreenGui.AbsoluteSize;
		local at = screenAt(panel);
		local size = panel.AbsoluteSize;
		local pushX = math.clamp(at.X, 0, math.max(0, screen.X - size.X)) - at.X;
		local pushY = math.clamp(at.Y, 0, math.max(0, screen.Y - size.Y)) - at.Y;

		if pushX ~= 0 or pushY ~= 0 then
			HUD.OffsetX = HUD.OffsetX + pushX;
			HUD.OffsetY = HUD.OffsetY + pushY;

			place();
		end;
	end));

	NeverLose:AddSignal(UserInputService.InputEnded:Connect(function(input)
		if not dragging then return end;

		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return;
		end;

		dragging = false;

		snapCorner();
		place();
		placeLyrics();
		pushOffsets();
	end));

	local function accent()
		return NeverLose.AccentColor or HUD.AccentColor;
	end;

	local function clockText(seconds)
		seconds = math.max(0, math.floor(seconds or 0));

		return string.format("%d:%02d", math.floor(seconds / 60), seconds % 60);
	end;

	local function relayout()
		local compact = HUD.Layout == "Compact";
		local coverOn = HUD.Artwork;
		local size = compact and math.floor(HUD.CoverSize * 0.58) or HUD.CoverSize;
		local pad = compact and 9 or 11;
		local left = coverOn and (size + pad + 11) or 14;

		art.Visible = coverOn;
		artOld.Visible = coverOn;
		art.Position = UDim2.fromOffset(pad, pad);
		artOld.Position = art.Position;
		art.Size = UDim2.fromOffset(size, size);
		artOld.Size = art.Size;

		local height = compact and (size + pad * 2) or math.max(88, size + 32);

		panel.Size = UDim2.fromOffset(compact and 250 or 286, height);

		local stacked = HUD.Progress or HUD.Times;
		local top = compact and math.floor((height - 30) / 2) or (stacked and 12 or math.floor((height - 32) / 2));

		local reserve = compact and 38 or 14;

		title.Position = UDim2.fromOffset(left, top);
		title.Size = UDim2.new(1, -left - reserve, 0, 17);

		artist.Position = UDim2.fromOffset(left, top + 17);
		artist.Size = UDim2.new(1, -left - reserve, 0, 14);
		artist.Visible = true;

		track.Position = UDim2.fromOffset(left, height - 36);
		track.Size = UDim2.new(1, -left - 12, 0, 4);
		track.Visible = HUD.Progress and not compact;

		clock.Position = UDim2.fromOffset(left, height - 27);
		clock.Visible = HUD.Times and not compact;

		controls.Visible = HUD.Controls;
		controls.Position = compact and UDim2.new(1, -9, 0.5, -12) or UDim2.new(1, -10, 0, height - 32);
		controls.Size = UDim2.fromOffset(compact and 26 or 84, 24);

		prevBtn.button.Visible = not compact;
		nextBtn.button.Visible = not compact;
		playBtn.button.Position = UDim2.fromOffset(compact and 0 or 30, 0);

		local barsOn = HUD.Visualizer and not compact and not HUD.Progress;

		for index, b in ipairs(bars) do
			b.Visible = barsOn;
			b.Position = UDim2.fromOffset(left + (index - 1) * 6, height - 14);
		end;

		scale.Scale = HUD.Scale / 100;

		local clear = 1 - HUD.Opacity / 100;

		panel.BackgroundTransparency = clear * 0.85 + 0.06;
		edge.Transparency = 0.35 + clear * 0.6;

		place();
		placeLyrics();
	end;

	local LYRICS = "https://lrclib.net/api/get";

	local lyricPanel = Instance.new("Frame");
	lyricPanel.Name = "Lyrics";
	lyricPanel.BackgroundColor3 = TH.panel;
	lyricPanel.BorderSizePixel = 0;
	lyricPanel.Size = UDim2.fromOffset(268, 150);
	lyricPanel.Visible = false;
	lyricPanel.ClipsDescendants = true;
	lyricPanel.Parent = gui;

	Instance.new("UICorner", lyricPanel).CornerRadius = UDim.new(0, 7);

	local lyricSheen = Instance.new("UIGradient", lyricPanel);
	lyricSheen.Rotation = 90;
	lyricSheen.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.new(1, 1, 1)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(178, 178, 190)),
	});

	pcall(function()
		local shade = Instance.new("UIShadow");
		shade.Color = TH.bg;
		shade.BlurRadius = UDim.new(0, 12);
		shade.Parent = lyricPanel;
	end);

	local lyricEdge = Instance.new("UIStroke", lyricPanel);
	lyricEdge.Color = TH.line;
	lyricEdge.Transparency = 0.45;

	local lyricScale = Instance.new("UIScale", lyricPanel);

	local lyricHead = Instance.new("TextLabel");
	lyricHead.Name = "Head";
	lyricHead.BackgroundTransparency = 1;
	lyricHead.Position = UDim2.fromOffset(14, 9);
	lyricHead.Size = UDim2.new(1, -28, 0, 14);
	lyricHead.FontFace = NeverLose.BuiltInBold;
	lyricHead.TextSize = 11;
	lyricHead.TextColor3 = TH.dim;
	lyricHead.TextXAlignment = Enum.TextXAlignment.Left;
	lyricHead.TextTruncate = Enum.TextTruncate.AtEnd;
	lyricHead.Text = "LYRICS";
	lyricHead.Parent = lyricPanel;

	local lyricView = Instance.new("Frame");
	lyricView.Name = "View";
	lyricView.BackgroundTransparency = 1;
	lyricView.ClipsDescendants = true;
	lyricView.Position = UDim2.fromOffset(14, 28);
	lyricView.Size = UDim2.new(1, -28, 1, -38);
	lyricView.Parent = lyricPanel;

	local lyricRoll = Instance.new("Frame");
	lyricRoll.Name = "Roll";
	lyricRoll.BackgroundTransparency = 1;
	lyricRoll.Size = UDim2.new(1, 0, 1, 0);
	lyricRoll.Parent = lyricView;

	local lyricFade = Instance.new("UIGradient", lyricView);
	lyricFade.Rotation = 90;
	lyricFade.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1),
		NumberSequenceKeypoint.new(0.22, 0),
		NumberSequenceKeypoint.new(0.78, 0),
		NumberSequenceKeypoint.new(1, 1),
	});

	local LINE_H = 20;
	local lyricRows = {};
	local lyricShow = 0;

	local function lyricRow(index)
		local row = lyricRows[index];

		if row then return row end;

		row = Instance.new("TextLabel");
		row.Name = "Line" .. index;
		row.BackgroundTransparency = 1;
		row.Size = UDim2.new(1, 0, 0, LINE_H);
		row.FontFace = NeverLose.BuiltInRegular;
		row.TextSize = 12;
		row.TextColor3 = TH.dim;
		row.TextXAlignment = Enum.TextXAlignment.Left;
		row.TextTruncate = Enum.TextTruncate.AtEnd;
		row.Text = "";
		row.Parent = lyricRoll;

		lyricRows[index] = row;

		return row;
	end;

	local lyricState = {
		key = nil,
		lines = {},
		synced = false,
		status = "",
		busy = false,
		offset = 0,
	};

	local function parseSynced(text)
		local lines = {};

		for stamp, body in string.gmatch(text, "%[(%d+:%d+%.?%d*)%]([^\n]*)") do
			local m, sec = string.match(stamp, "(%d+):([%d%.]+)");

			if m then
				local at = tonumber(m) * 60 + (tonumber(sec) or 0);
				local clean = string.match(body, "^%s*(.-)%s*$");

				lines[#lines + 1] = { at = at, text = clean };
			end;
		end;

		return lines;
	end;

	local function parsePlain(text)
		local lines = {};

		for body in string.gmatch(text .. "\n", "([^\n]*)\n") do
			lines[#lines + 1] = { at = nil, text = body };
		end;

		return lines;
	end;

	local function fetchLyrics(title, artist, album, duration)
		lyricState.busy = true;
		lyricState.status = "searching...";

		local query = LYRICS .. "?" .. form({
			track_name = title,
			artist_name = artist,
			album_name = album or "",
			duration = math.floor(duration or 0),
		});

		local body, code = httpJson("GET", query, { ["Accept"] = "application/json" });

		if code ~= 200 or type(body) ~= "table" then
			local hits = httpJson("GET", "https://lrclib.net/api/search?" .. form({ track_name = title, artist_name = artist }),
				{ ["Accept"] = "application/json" });

			body = (type(hits) == "table" and hits[1]) or nil;
		end;

		lyricState.busy = false;

		if type(body) ~= "table" then
			lyricState.lines = {};
			lyricState.synced = false;
			lyricState.status = "No lyrics";

			return;
		end;

		if type(body.syncedLyrics) == "string" and body.syncedLyrics ~= "" then
			lyricState.lines = parseSynced(body.syncedLyrics);
			lyricState.synced = #lyricState.lines > 0;
		end;

		if not lyricState.synced then
			local plain = body.plainLyrics;

			lyricState.lines = (type(plain) == "string" and plain ~= "") and parsePlain(plain) or {};
			lyricState.synced = false;
		end;

		lyricState.status = (#lyricState.lines == 0) and "No lyrics" or "";
	end;

	local function wantLyrics()
		if not (HUD.On and HUD.Lyrics) then return end;
		if lyricState.busy then return end;

		local title = Playback.title or "";
		local artist = Playback.artist or "";

		if title == "" then return end;

		local blocked = {
			["Nothing playing"] = true,
			["No track queued"] = true,
			["Spotify unavailable"] = true,
			["Spotify not connected"] = true,
			["Spotify not set up"] = true,
		};

		if blocked[title] then
			lyricState.key = nil;
			lyricState.lines = {};
			lyricState.status = "Nothing playing";

			return;
		end;

		local key = title .. "|" .. artist;

		if lyricState.key == key then return end;

		lyricState.key = key;
		lyricState.lines = {};
		lyricState.synced = false;
		lyricState.status = "searching...";

		task.spawn(function()
			local mine = key;

			pcall(fetchLyrics, title, artist, Playback.album, Playback.duration);

			if lyricState.key ~= mine then

				lyricState.key = nil;
			end;
		end);
	end;

	function placeLyrics()

		if not HUD.LyricsPlaced then
			local anchor = SPOTS[HUD.Spot] or SPOTS["Bottom Left"];
			local gapY = (panel.Size.Y.Offset + 8) * (HUD.Scale / 100);

			HUD.LyricsSpot = HUD.Spot;
			HUD.LyricsX = HUD.OffsetX;
			HUD.LyricsY = HUD.OffsetY + (anchor.Y == 1 and -gapY or gapY);
			HUD.LyricsPlaced = true;

			for flag, value in pairs({ music_lyrics_x = HUD.LyricsX, music_lyrics_y = HUD.LyricsY }) do
				local item = NeverLose.Flags[flag];

				if item and item.SetValue then pcall(item.SetValue, item, value) end;
			end;

			local spot = NeverLose.Flags.music_lyrics_spot;

			if spot and spot.SetValue then pcall(spot.SetValue, spot, HUD.LyricsSpot) end;
		end;

		local anchor = SPOTS[HUD.LyricsSpot] or SPOTS["Bottom Left"];

		lyricPanel.AnchorPoint = anchor;
		lyricScale.Scale = HUD.Scale / 100;

		lyricPanel.Size = UDim2.fromOffset(panel.Size.X.Offset, HUD.LyricsSize);

		lyricPanel.Position = UDim2.new(
			anchor.X,
			(anchor.X == 0 and PAD or -PAD) + HUD.LyricsX,
			anchor.Y,
			(anchor.Y == 0 and PAD or -PAD) + HUD.LyricsY
		);
	end;

	local lyricDrag, lyricFrom, lyricBase = false, nil, nil;

	local function snapLyrics()
		local screen = NeverLose.ScreenGui.AbsoluteSize;

		if screen.X < 8 or screen.Y < 8 then return end;

		local center = screenAt(lyricPanel) + lyricPanel.AbsoluteSize * 0.5;
		local right = center.X > screen.X * 0.5;
		local bottom = center.Y > screen.Y * 0.5;

		HUD.LyricsSpot = (bottom and "Bottom " or "Top ") .. (right and "Right" or "Left");

		local anchor = SPOTS[HUD.LyricsSpot];
		local at = screenAt(lyricPanel) + lyricPanel.AbsoluteSize * Vector2.new(anchor.X, anchor.Y);
		local corner = Vector2.new(anchor.X * screen.X, anchor.Y * screen.Y);
		local base = Vector2.new(anchor.X == 0 and PAD or -PAD, anchor.Y == 0 and PAD or -PAD);
		local reachX = math.max(0, screen.X - lyricPanel.AbsoluteSize.X);
		local reachY = math.max(0, screen.Y - lyricPanel.AbsoluteSize.Y);

		HUD.LyricsX = math.clamp(math.floor(at.X - corner.X - base.X + 0.5), -reachX, reachX);
		HUD.LyricsY = math.clamp(math.floor(at.Y - corner.Y - base.Y + 0.5), -reachY, reachY);
	end;

	lyricPanel.Active = true;

	lyricPanel.InputBegan:Connect(function(input)
		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return;
		end;

		lyricDrag = true;
		lyricFrom = input.Position;
		lyricBase = Vector2.new(HUD.LyricsX, HUD.LyricsY);
	end);

	NeverLose:AddSignal(UserInputService.InputChanged:Connect(function(input)
		if not lyricDrag then return end;

		if input.UserInputType ~= Enum.UserInputType.MouseMovement
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return;
		end;

		local delta = input.Position - lyricFrom;

		HUD.LyricsX = lyricBase.X + delta.X;
		HUD.LyricsY = lyricBase.Y + delta.Y;

		placeLyrics();

		local screen = NeverLose.ScreenGui.AbsoluteSize;
		local at = screenAt(lyricPanel);
		local size = lyricPanel.AbsoluteSize;
		local pushX = math.clamp(at.X, 0, math.max(0, screen.X - size.X)) - at.X;
		local pushY = math.clamp(at.Y, 0, math.max(0, screen.Y - size.Y)) - at.Y;

		if pushX ~= 0 or pushY ~= 0 then
			HUD.LyricsX = HUD.LyricsX + pushX;
			HUD.LyricsY = HUD.LyricsY + pushY;

			placeLyrics();
		end;
	end));

	NeverLose:AddSignal(UserInputService.InputEnded:Connect(function(input)
		if not lyricDrag then return end;

		if input.UserInputType ~= Enum.UserInputType.MouseButton1
			and input.UserInputType ~= Enum.UserInputType.Touch then
			return;
		end;

		lyricDrag = false;

		snapLyrics();
		placeLyrics();

		for flag, value in pairs({ music_lyrics_x = HUD.LyricsX, music_lyrics_y = HUD.LyricsY }) do
			local item = NeverLose.Flags[flag];

			if item and item.SetValue then pcall(item.SetValue, item, value) end;
		end;

		local spot = NeverLose.Flags.music_lyrics_spot;

		if spot and spot.SetValue then pcall(spot.SetValue, spot, HUD.LyricsSpot) end;
	end));

	local function drawLyrics(position, dt)

		local lines = lyricState.lines;
		local want = HUD.On and HUD.Lyrics and #lines > 0;

		lyricShow = lyricShow + ((want and 1 or 0) - lyricShow) * math.min(1, dt * 9);

		if lyricShow < 0.01 then
			lyricPanel.Visible = false;

			return;
		end;

		lyricPanel.Visible = true;

		local tone = accent();
		local clear = 1 - HUD.Opacity / 100;

		lyricPanel.BackgroundTransparency = 1 - (1 - (clear * 0.85 + 0.06)) * lyricShow;
		lyricEdge.Transparency = 1 - (1 - (0.4 + clear * 0.55)) * lyricShow;
		lyricHead.TextTransparency = 1 - lyricShow;
		lyricHead.TextColor3 = tone;
		lyricHead.Text = lyricState.synced and "LYRICS" or "LYRICS  -  unsynced";

		local active = 0;

		if lyricState.synced then
			for index = 1, #lines do
				if (lines[index].at or 0) <= position then active = index else break end;
			end;
		end;

		local rows = math.max(1, math.floor(lyricView.AbsoluteSize.Y / LINE_H));
		local center = math.floor(rows / 2);
		local target = lyricState.synced and math.max(0, active - 1 - center) or 0;

		lyricState.offset = lyricState.offset + (target - lyricState.offset) * math.min(1, dt * 7);

		lyricRoll.Position = UDim2.fromOffset(0, -math.floor(lyricState.offset * LINE_H + 0.5));

		for index = 1, math.max(#lines, #lyricRows) do
			local entry = lines[index];

			if entry then
				local row = lyricRow(index);

				if row.Text ~= entry.text then row.Text = entry.text ~= "" and entry.text or " " end;

				row.Position = UDim2.fromOffset(0, (index - 1) * LINE_H);

				local away = lyricState.synced and math.abs(index - active) or 0;
				local near = math.clamp(1 - away / 3.2, 0, 1);
				local isNow = lyricState.synced and index == active;

				local wantAlpha = lyricState.synced and (0.62 - near * 0.62) or 0.1;
				local wantColour = TH.dim:Lerp(tone, isNow and 1 or near * 0.28);

				row.TextTransparency = row.TextTransparency + ((1 - (1 - wantAlpha) * lyricShow) - row.TextTransparency) * math.min(1, dt * 10);
				row.TextColor3 = row.TextColor3:Lerp(wantColour, math.min(1, dt * 10));

				local face = isNow and NeverLose.BuiltInBold or NeverLose.BuiltInRegular;

				if row.FontFace ~= face then row.FontFace = face end;

				local scaleWant = isNow and 1.06 or 1;
				local grow = row:FindFirstChildOfClass("UIScale");

				if not grow then
					grow = Instance.new("UIScale");
					grow.Parent = row;
				end;

				grow.Scale = grow.Scale + (scaleWant - grow.Scale) * math.min(1, dt * 9);
			else
				local row = lyricRows[index];

				if row and row.Text ~= "" then row.Text = "" end;
			end;
		end;
	end;

	local lastSync = os.clock();
	local pollTask;

	local function sync()
		local p = provider();

		if p.read then
			p.read(Playback);
		elseif p.refreshState then
			p.refreshState(Playback);
		end;

		lastSync = os.clock();
	end;

	pollTask = task.spawn(function()
		while ALIVE do
			if HUD.On then pcall(sync) end;

			task.wait(current == "Spotify" and 4 or 0.5);
		end;
	end);

	local shownArt = "";
	local shownTitle = "";

	local frame = RunService.RenderStepped:Connect(function(dt)
		if not ALIVE then return end;

		panel.Visible = HUD.On;

		if not HUD.On then return end;

		local position = Playback.position;

		if Playback.playing then
			position = position + (os.clock() - lastSync);
		end;

		if Playback.duration > 0 then position = math.min(position, Playback.duration) end;

		local tone = accent();

		fill.BackgroundColor3 = tone;
		knob.BackgroundColor3 = tone;
		knob.Visible = Playback.duration > 0;
		artMark.Visible = (art.Image == "");
		artMark.ImageColor3 = tone;

		if Playback.duration > 0 then
			fill.Size = UDim2.fromScale(math.clamp(position / Playback.duration, 0, 1), 1);
		else
			fill.Size = UDim2.fromScale(0, 1);
		end;

		clock.Text = clockText(position) .. " / " .. clockText(Playback.duration);

		local heading = Playback.title or "";

		if Playback.status ~= "" then heading = Playback.title end;

		if heading ~= shownTitle then
			shownTitle = heading;
			title.Text = heading;
		end;

		artist.Text = (Playback.status ~= "" and Playback.status ~= "Nothing playing")
			and Playback.status or (Playback.artist or "");

		local wantArt = coverFor(Playback.artwork);

		if wantArt ~= shownArt then
			artOld.Image = art.Image;
			artOld.ImageTransparency = 0;
			shownArt = wantArt;
			art.Image = wantArt;
			art.ImageTransparency = 1;

			TweenService:Create(art, TweenInfo.new(0.35), { ImageTransparency = 0 }):Play();
			TweenService:Create(artOld, TweenInfo.new(0.35), { ImageTransparency = 1 }):Play();
		end;

		playBtn.setGlyph(Playback.playing and "pause" or "play");
		prevBtn.setEnabled(Playback.canSkipPrevious);
		nextBtn.setEnabled(Playback.canSkipNext);
		seekHit.Active = Playback.canSeek;

		if not dragging then
			local spotFlag = NeverLose.Flags.music_spot;
			local xFlag = NeverLose.Flags.music_x;
			local yFlag = NeverLose.Flags.music_y;
			local moved = false;

			if spotFlag then
				local value = spotFlag:GetValue();

				if type(value) == "table" then value = value[1] end;

				if type(value) == "string" and SPOTS[value] and value ~= HUD.Spot then
					HUD.Spot = value;
					moved = true;
				end;
			end;

			if xFlag then
				local value = tonumber(xFlag:GetValue());

				if value and value ~= HUD.OffsetX then HUD.OffsetX = value; moved = true end;
			end;

			if yFlag then
				local value = tonumber(yFlag:GetValue());

				if value and value ~= HUD.OffsetY then HUD.OffsetY = value; moved = true end;
			end;

			if moved then place(); placeLyrics() end;
		end;

		if not lyricDrag then
			local spotFlag = NeverLose.Flags.music_lyrics_spot;
			local xFlag = NeverLose.Flags.music_lyrics_x;
			local yFlag = NeverLose.Flags.music_lyrics_y;
			local moved = false;

			if spotFlag then
				local value = spotFlag:GetValue();

				if type(value) == "table" then value = value[1] end;

				if type(value) == "string" and SPOTS[value] and value ~= HUD.LyricsSpot then
					HUD.LyricsSpot = value;
					HUD.LyricsPlaced = true;
					moved = true;
				end;
			end;

			if xFlag then
				local value = tonumber(xFlag:GetValue());

				if value and value ~= HUD.LyricsX then HUD.LyricsX = value; HUD.LyricsPlaced = true; moved = true end;
			end;

			if yFlag then
				local value = tonumber(yFlag:GetValue());

				if value and value ~= HUD.LyricsY then HUD.LyricsY = value; HUD.LyricsPlaced = true; moved = true end;
			end;

			if moved then placeLyrics() end;
		end;

		wantLyrics();
		drawLyrics(position, math.min(dt, 0.1));

		if HUD.Visualizer then
			local beat = os.clock() * 6;

			for index, b in ipairs(bars) do
				if b.Visible then
					local height = Playback.playing
						and (5 + math.abs(math.sin(beat + index * 0.9)) * 11)
						or 4;

					b.Size = UDim2.fromOffset(3, height);
					b.BackgroundColor3 = tone;
				end;
			end;
		end;
	end);

	NeverLose:AddSignal(frame);

	playBtn.button.MouseButton1Click:Connect(function()
		if Playback.playing then command("pause") else command("play") end;

		task.delay(0.35, function() if HUD.On then pcall(sync) end end);
	end);

	nextBtn.button.MouseButton1Click:Connect(function()
		command("next");

		task.delay(0.5, function() if HUD.On then pcall(sync) end end);
	end);

	prevBtn.button.MouseButton1Click:Connect(function()
		command("previous");

		task.delay(0.5, function() if HUD.On then pcall(sync) end end);
	end);

	seekHit.MouseButton1Click:Connect(function()
		if not Playback.canSeek then return end;

		local mouse = UserInputService:GetMouseLocation();
		local at = track.AbsolutePosition.X;
		local width = math.max(1, track.AbsoluteSize.X);

		command("seek", math.clamp((mouse.X - at) / width, 0, 1));

		task.delay(0.4, function() if HUD.On then pcall(sync) end end);
	end);

	local function showPanels(name)
		local cards = {
			Spotify = Sections.Spotify,
			SoundCloud = Sections.SoundCloud,
			VK = Sections.Vk,
		};

		for key, card in pairs(cards) do
			if card and card.SetVisible then pcall(card.SetVisible, card, key == name) end;
		end;
	end;

	Sections.Music:AddLabel("Provider"):AddDropdown({
		Default = "Local",
		Values = { "Local", "Spotify", "SoundCloud", "VK" },
		Flag = "music_provider",
		Callback = function(v)
			current = v;

			showPanels(v);
			pcall(sync);
		end,
	});

	showPanels("Local");

	Sections.Music:AddLabel("Now Playing HUD"):AddToggle({
		Name = "Now Playing HUD",
		Default = false,
		Flag = "music_hud",
		Callback = function(v)
			HUD.On = v;

			if v then pcall(sync) end;
		end,
	});

	Sections.Music:AddButton({
		Icon = "plus",
		Name = "Add Track by ID",
		Callback = function()
			pcall(function()
				NeverLose.Lib:ask({
					title = "add track",
					icon = "plus",
					hint = "audio id, or: 12345 Artist - Title",
					accept = "add",
					deny = "cancel",
					callback = function(text)
						if LocalProvider.add(text) then pcall(sync) end;
					end,
				});
			end);
		end,
	});

	Sections.Music:AddButton({ Icon = "trash-can", Name = "Clear Queue", Callback = function()
		LocalProvider.clear(); SoundCloud.clear(); Vk.clear(); pcall(sync);
	end });

	Sections.Music:AddLabel("Loop"):AddToggle({
		Name = "Loop",
		Default = false, Flag = "music_loop",
		Callback = function(v) command("setLoop", v) end,
	});

	Sections.Music:AddLabel("Volume"):AddSlider({
		Min = 0, Max = 100, Default = 50, Type = "%", Size = 100,
		Flag = "music_volume",
		Callback = function(v) command("setVolume", v) end,
	});

	Sections.MusicHud:AddLabel("Layout"):AddDropdown({
		Default = "Full", Values = { "Full", "Compact" },
		Flag = "music_layout",
		Callback = function(v) HUD.Layout = v; relayout() end,
	});

	for _, entry in ipairs({
		{ "Show Artwork", "Artwork", "music_show_art", true },
		{ "Show Controls", "Controls", "music_show_controls", true },
		{ "Show Progress", "Progress", "music_show_progress", true },
		{ "Show Time", "Times", "music_show_time", true },
		{ "Show Visualizer", "Visualizer", "music_show_vis", true },
	}) do
		local key = entry[2];

		Sections.MusicHud:AddLabel(entry[1]):AddToggle({
			Name = entry[1], Default = entry[4], Flag = entry[3],
			Callback = function(v) HUD[key] = v; relayout() end,
		});
	end;

	Sections.MusicHud:AddLabel("Lyrics"):AddToggle({
		Name = "Lyrics",
		Default = false,
		Flag = "music_lyrics",
		ToolTip = "Synced lyrics",
		Callback = function(v)
			HUD.Lyrics = v;

			if v then lyricState.key = nil end;

			placeLyrics();
		end,
	});

	Sections.MusicHud:AddLabel("Lyrics Height"):AddSlider({
		Min = 90, Max = 340, Default = 150, Rounding = 0, Size = 100,
		Flag = "music_lyrics_size",
		Callback = function(v) HUD.LyricsSize = v; placeLyrics() end,
	});

	Sections.MusicHud:AddLabel("Lyrics Corner"):AddDropdown({
		Default = "Bottom Left",
		Values = { "Top Left", "Top Right", "Bottom Left", "Bottom Right" },
		Flag = "music_lyrics_spot",
		Callback = function(v) HUD.LyricsSpot = v; HUD.LyricsPlaced = true; placeLyrics() end,
	});

	Sections.MusicHud:AddLabel("Position"):AddDropdown({
		Default = "Bottom Left",
		Values = { "Top Left", "Top Right", "Bottom Left", "Bottom Right" },
		Flag = "music_spot",
		Callback = function(v) HUD.Spot = v; place() end,
	});

	do
		local hidden = {
			{ "music_x", "OffsetX" },
			{ "music_y", "OffsetY" },
			{ "music_lyrics_x", "LyricsX" },
			{ "music_lyrics_y", "LyricsY" },
		};

		for _, entry in ipairs(hidden) do
			local id, key = entry[1], entry[2];

			NeverLose.Lib:hook(id, "number",
				function() return HUD[key] end,
				function(value)
					local number = tonumber(value);

					if number then
						HUD[key] = number;

						if key == "LyricsX" or key == "LyricsY" then HUD.LyricsPlaced = true end;
					end;
				end);

			NeverLose.Flags[id] = {
				GetValue = function() return HUD[key] end,
				SetValue = function(_, value)
					local number = tonumber(value);

					if number then HUD[key] = number end;
				end,
			};
		end;
	end;

	for _, entry in ipairs({
		{ "Opacity", "Opacity", "music_opacity", 10, 100, 100 },
		{ "Scale", "Scale", "music_scale", 60, 180, 100 },
		{ "Cover Size", "CoverSize", "music_cover", 32, 96, 52 },
	}) do
		local key = entry[2];

		Sections.MusicHud:AddLabel(entry[1]):AddSlider({
			Min = entry[4], Max = entry[5], Default = entry[6], Rounding = 0, Size = 100,
			Flag = entry[3],
			Callback = function(v) HUD[key] = v; relayout() end,
		});
	end;

	Sections.Spotify:AddLabel("Client ID"):AddTextInput({
		Default = "",
		Placeholder = "Client ID",
		Flag = "spotify_client",
		Callback = function(v) Spotify.setClientId(v) end,
	});

	Sections.Spotify:AddButton({
		Icon = "link",
		Name = "Connect",
		Callback = function() Spotify.begin() end,
	});

	Sections.Spotify:AddLabel("Paste Code"):AddTextInput({
		Default = "",
		Placeholder = "Paste code",
		Flag = "spotify_code",
		Callback = function(v)
			if #tostring(v or "") > 20 then Spotify.finish(v) end;
		end,
	});

	Sections.Spotify:AddButton({
		Icon = "info",
		Name = "Test Connection",
		Callback = function()
			task.spawn(function()
				if not Spotify.hasClientId() then
					Notification.new({ Title = "Spotify", Content = "No Client ID", Duration = 6 });

					return;
				end;

				local body, code, raw = Spotify.call("GET", "/me");

				if code == 200 and body then
					Notification.new({
						Title = "Spotify",
						Content = ("Connected as %s (%s)"):format(tostring(body.display_name or body.id), tostring(body.product)),
						Duration = 8,
					});

					return;
				end;

				local reason = (raw and type(raw.Body) == "string" and raw.Body ~= "") and raw.Body or "no response body";

				Notification.new({
					Title = "Spotify",
					Content = "Request failed (" .. tostring(code) .. ")",
					Duration = 12,
				});

				warn("[visuals] spotify /me -> " .. tostring(code) .. ": " .. reason);
			end);
		end,
	});

	Sections.Spotify:AddButton({
		Icon = "log-out",
		Name = "Disconnect",
		Callback = function()
			Spotify.disconnect();

			Notification.new({ Title = "Spotify", Content = "Disconnected", Duration = 4 });
		end,
	});

	Sections.Spotify:AddLabel("Redirect URI: " .. REDIRECT, true);

	Sections.SoundCloud:AddLabel("Client ID"):AddTextInput({
		Default = "", Placeholder = "Client ID",
		Flag = "soundcloud_client",
		Callback = function(v) SC.Client = tostring(v or "") end,
	});

	Sections.SoundCloud:AddLabel("Link"):AddTextInput({
		Default = "", Placeholder = "Track or playlist URL",
		Flag = "soundcloud_link",
		Callback = function() end,
	});

	Sections.SoundCloud:AddButton({
		Icon = "plus", Name = "Queue From SoundCloud",
		Callback = function()
			local box = NeverLose.Flags.soundcloud_link;
			local text = box and box:GetValue() or "";

			pcall(function() NeverLose.Lib.pool["music_provider"].set("SoundCloud") end);
			SoundCloud.add(text);
		end,
	});

	Sections.Vk:AddLabel("Token"):AddTextInput({
		Default = "", Placeholder = "Access token",
		Flag = "vk_token",
		Callback = function(v) VK.Token = tostring(v or "") end,
	});

	Sections.Vk:AddLabel("Owner"):AddTextInput({
		Default = "", Placeholder = "Owner ID (optional)",
		Flag = "vk_link",
		Callback = function() end,
	});

	Sections.Vk:AddButton({
		Icon = "plus", Name = "Queue From VK",
		Callback = function()
			local box = NeverLose.Flags.vk_link;
			local text = box and box:GetValue() or "";

			pcall(function() NeverLose.Lib.pool["music_provider"].set("VK") end);
			Vk.add(text);
		end,
	});

	relayout();

	ESP.ClearMusic = onUnload("music", function()
		HUD.On = false;

		pcall(function() frame:Disconnect() end);

		if pollTask then pcall(task.cancel, pollTask) end;

		pcall(function() lyricPanel:Destroy() end);

		pcall(LocalProvider.stop);
	end);
end);

guard("assets", function()
	local function assetUrl(rel)
		return Remote.asset(rel);
	end;

	local function listNames(folder, extensions)
		local names, map, entries = { "Off" }, {}, {};
		if not isfile then return names, map end;

		local ok, files = pcall(Remote.under, folder .. "/");
		if not ok or type(files) ~= "table" then return names, map end;
		for _, rel in ipairs(files) do
			local file = string.match(rel, "[^/]+$");
			local extension = file and file:match("%.(%w+)$");
			if extension and extensions[extension:lower()] and Remote.ensure(rel) then
				local label = file:gsub("%.%w+$", ""):gsub("[_%-]+", " "):gsub("(%l)(%u)", "%1 %2");
				label = label:gsub("(%a[%w']*)", function(word) return word:sub(1, 1):upper() .. word:sub(2) end);
				entries[#entries + 1] = { name = label, file = file };
			end;
		end;
		table.sort(entries, function(a, b)
			if a.name:lower() == b.name:lower() then return a.file < b.file end;
			return a.name:lower() < b.name:lower();
		end);
		for _, entry in ipairs(entries) do
			local name = entry.name;
			if map[name] or name == "Off" then name = name .. " (" .. entry.file .. ")" end;
			names[#names + 1] = name;
			map[name] = folder .. "/" .. entry.file;
		end;
		return names, map;
	end;

	local _, cursorFiles = listNames("cursors", { png = true, jpg = true, jpeg = true });
	local soundNames, soundFiles = listNames("sounds", { wav = true, ogg = true, mp3 = true });

	local lib = NeverLose.Lib;

	for name, file in pairs(cursorFiles or {}) do
		if name ~= "Off" and not lib.cursors[name] then
			local url = assetUrl(file);

			if url then
				lib.cursors[name] = url;
				lib.cursorlist[#lib.cursorlist + 1] = name;
			end;
		end;
	end;

	table.sort(lib.cursorlist, function(a, b) return string.lower(a) < string.lower(b) end);

	lib.style = lib.style or lib.cursorlist[1];

	if #lib.cursorlist > 0 then
		local cursorRow = Sections.ScreenInfo:AddLabel("Custom Cursor");

		cursorRow:AddToggle({
			Default = false, Flag = "cursor_on",
			Callback = function(v) pcall(function() lib:setcursor(v) end) end,
		});

		Sections.ScreenInfo:AddLabel("Cursor"):AddDropdown({
			Default = lib.style,
			Values = lib.cursorlist,
			Flag = "cursor_skin",
			Callback = function(v) pcall(function() lib:setstyle(v) end) end,
		});

		Sections.ScreenInfo:AddLabel("Cursor Size"):AddSlider({
			Min = 16, Max = 96, Default = 32, Rounding = 0, Size = 90,
			Flag = "cursor_size",
			Callback = function(v)

				for _, child in ipairs(lib.scr:GetChildren()) do
					if child:IsA("ImageLabel") and child.ZIndex == 2147483647 then
						child.Size = UDim2.fromOffset(v, v);
					end;
				end;
			end,
		});
	end;

	local iconHook;

	pcall(function()
		if not hookmetamethod then return end;

		iconHook = hookmetamethod(game, "__newindex", function(self, property, value)
			if property == "Icon" and lib.cursor and checkcaller and not checkcaller() then
				local ok, isMouse = pcall(function() return self:IsA("Mouse") end);

				if ok and isMouse then return end;
			end;

			return iconHook(self, property, value);
		end);
	end);

	onUnload("cursor", function()
		pcall(function() lib:setcursor(false) end);

		if iconHook and restorefunction then pcall(restorefunction, iconHook) end;
	end);

	local killNames, killFiles = listNames("killsounds", { ogg = true, wav = true, mp3 = true });

	for i = 2, #soundNames do
		local name = soundNames[i];

		killNames[#killNames + 1] = name;
		killFiles[name] = soundFiles[name];
	end;

	local H = {
		Sound = "Off", Volume = 50,
		OnKill = "Off", KillVolume = 60,
		Hush = true,
	};

	local hitSound = Instance.new("Sound");
	hitSound.Name = NeverLose.RandomString();
	hitSound.Parent = NeverLose.ScreenGui;

	local killSound = hitSound:Clone();
	killSound.Parent = NeverLose.ScreenGui;

	local muteUntil = 0;
	local muted = {};
	ESP.ClearSounds = function()
		muteUntil=0;
		for sound, volume in pairs(muted) do pcall(function() sound.Volume=volume end) end;
		table.clear(muted); hitSound:Destroy(); killSound:Destroy();
	end;

	local HUSH = {
		"gunshot", "gun shot", "gunshoot", "shoot", "fire",
		"reload", "gunreload",
		"knifekill", "knife kill", "stab", "slash", "swing",
		"kill", "killeffect", "death", "die",
	};

	local function hushed(sound)
		local name = string.lower(sound.Name);

		for _, want in ipairs(HUSH) do
			if string.find(name, want, 1, true) then return true end;
		end;

		return false;
	end;

	local function silence(sound)
		if muted[sound] or sound == hitSound or sound == killSound then return end;

		muted[sound] = sound.Volume;
		sound.Volume = 0;

		task.delay(1.5, function()
			if sound.Parent and muted[sound] then
				sound.Volume = muted[sound];
			end;

			muted[sound] = nil;
		end);
	end;

	local function armed()
		return H.Hush and (H.Sound ~= "Off" or H.OnKill ~= "Off");
	end;

	NeverLose:AddSignal(game.DescendantAdded:Connect(function(inst)
		if not inst:IsA("Sound") then return end;

		if os.clock() <= muteUntil then
			silence(inst);
		elseif armed() and hushed(inst) then
			silence(inst);
		end;
	end));

	local function play(sound, name, volume, pool)
		local file = (pool or soundFiles)[name];
		if not file then return false end;

		local url = assetUrl(file);
		if not url then return false end;

		sound.SoundId = url;
		sound.Volume = volume / 100;
		sound:Play();

		muteUntil = os.clock() + 0.35;

		return true;
	end;

	local function silenceAround(char)
		for _, inst in ipairs(char:GetDescendants()) do
			if inst:IsA("Sound") and inst.IsPlaying then silence(inst) end;
		end;
	end;

	Sections.WorldMisc:AddLabel("Shoot Sound"):AddDropdown({
		Default = "Off",
		Values = soundNames,
		Flag = "hitsound",
		Callback = function(v) H.Sound = v end,
	});

	Sections.WorldMisc:AddLabel("Shoot Volume"):AddSlider({
		Min = 0, Max = 100, Default = 50, Type = "%", Size = 90,
		Flag = "sound_volume",
		Callback = function(v) H.Volume = v end,
	});

	Sections.WorldMisc:AddLabel("Kill Sound"):AddDropdown({
		Default = "Off",
		Values = killNames,
		Flag = "killsound",
		Callback = function(v) H.OnKill = v end,
	});

	Sections.WorldMisc:AddLabel("Kill Volume"):AddSlider({
		Min = 0, Max = 100, Default = 60, Type = "%", Size = 90,
		Flag = "kill_volume",
		Callback = function(v) H.KillVolume = v end,
	});

	Sections.WorldMisc:AddLabel("Mute Game Sounds"):AddToggle({
		Name = "Mute Game Sounds",
		Default = true,
		Flag = "sound_hush",
		Callback = function(v) H.Hush = v end,
	});

	local watched = {};

	local function watch(player)
		if player == LocalPlayer then return end;

		local lastPlayed = 0;

		local function react(char, value, previous)
			if value >= previous then return end;
			if os.clock() - lastPlayed < 0.12 then return end;

			lastPlayed = os.clock();

			local played;

			if value <= 0 then
				played = play(killSound, H.OnKill, H.KillVolume, killFiles);
			else
				played = play(hitSound, H.Sound, H.Volume);
			end;

			if played then silenceAround(char) end;
		end;

		local function hook(char)
			local human = char:FindFirstChildWhichIsA("Humanoid");

			if not human then
				task.spawn(function()
					human = char:WaitForChild("Humanoid", 10);
					if not ALIVE or not human then return end;

					local last = human.Health;

					NeverLose:AddSignal(human.HealthChanged:Connect(function(value)
						react(char, value, last);
						last = value;
					end));
				end);

				return;
			end;

			local last = human.Health;

			NeverLose:AddSignal(human.HealthChanged:Connect(function(value)
				react(char, value, last);
				last = value;
			end));
		end;

		if watched[player] then return end;
		watched[player] = true;

		local hooked;

		local function once(char)
			if hooked == char then return end;
			hooked = char;
			hook(char);
		end;

		if player.Character then once(player.Character) end;

		NeverLose:AddSignal(player.CharacterAdded:Connect(once));
	end;

	for _, player in ipairs(Players:GetPlayers()) do watch(player) end;
	NeverLose:AddSignal(Players.PlayerAdded:Connect(watch));

	ESP.Assets = { Url = assetUrl, Cursors = cursorFiles, Sounds = soundFiles };
end);

Sections.ScreenInfo:AddLabel("Watermark"):AddToggle({
	Default = true, Flag = "hud_watermark",
	Callback = function(v)
		if NeverLose.SetWatermark then NeverLose.SetWatermark(v) end;

		Watermark:SetRender(v);
	end,
});

Sections.ScreenInfo:AddLabel("Watermark Spot"):AddDropdown({
	Default = "Top Right",
	Values = NeverLose.SpotNames or { "Top Right" },
	Flag = "hud_watermark_spot",
	Callback = function(v)
		if NeverLose.SetWatermarkSpot then NeverLose.SetWatermarkSpot(v) end;
	end,
});

Sections.ScreenInfo:AddLabel("Keybind List"):AddToggle({
	Default = true, Flag = "hud_keybinds",
	Callback = function(v)
		if NeverLose.SetKeybindList then NeverLose.SetKeybindList(v) end;
	end,
});

Sections.ScreenInfo:AddLabel("Keybind Spot"):AddDropdown({
	Default = "Bottom Left",
	Values = NeverLose.SpotNames or { "Bottom Left" },
	Flag = "hud_keybind_spot",
	Callback = function(v)
		if NeverLose.SetKeybindSpot then NeverLose.SetKeybindSpot(v) end;
	end,
});

Window.UserSettings:AddLabel("Menu Keybind"):AddKeybind({
	Default = "RightShift",
	Flag = "menu_keybind",
	Callback = function(v)

		Window:SetKeybind(v);
	end,
});

Window.UserSettings:AddLabel("Watermark"):AddToggle({
	Default = true,
	Flag = "watermark",
	Callback = function(v)
		Watermark:SetRender(v);
	end,
});

Window.UserSettings:AddButton({
	Icon = "trash-can",
	Name = "Unload",
	Callback = function()
		if getgenv then getgenv().Visuals = nil; end;
		NeverLose:Unload();
	end,
});

local frames, clock = 0, os.clock();

NeverLose:AddSignal(RunService.RenderStepped:Connect(function()
	frames = frames + 1;

	local now = os.clock();
	if now - clock >= 1 then
		fpsBlock:SetText(tostring(frames) .. " FPS");
		frames, clock = 0, now;

		local ok, ping = pcall(function()
			return math.floor(LocalPlayer:GetNetworkPing() * 1000);
		end);
		pingBlock:SetText((ok and tostring(ping) or "0") .. " MS");
	end;
end));

Watermark:SetRender(true);

pcall(function() NeverLose.SetWatermarkText("Salad") end);

Notification.new({
	Content = "Loaded",
	Duration = 6,
});

guard("config", function()
	local lib = NeverLose.Lib;

	lib.dir = "Salad Visuals/Config";

	local SECRET = {
		spotify_code = true,
		spotify_client = true,
		soundcloud_client = true,
		vk_token = true,
	};

	local store = lib.store;

	function lib:store(name)
		local saved = {};

		for id in pairs(SECRET) do
			local entry = lib.pool[id];

			if entry then
				saved[id] = entry.get;
				entry.get = function() return nil end;
			end;
		end;

		local ok, result = pcall(store, lib, name);

		for id, get in pairs(saved) do
			local entry = lib.pool[id];

			if entry then entry.get = get end;
		end;

		return ok and result or nil;
	end;

	Window:AddConfigCard();
end);

local unloadLibrary = NeverLose.Unload;
local Visuals = {
	Lib = NeverLose,
	Window = Window,
	Notification = Notification,
	Logging = Logging,
	Indicator = Indicator,
	Tabs = Tabs,
	Sections = Sections,
	Preview = Preview,
	ESP = ESP,
	Errors = ERRORS,
	AddGroup = makeGroup,
	Unload = function()
		if not ALIVE then return end;
		ALIVE=false;
		if getgenv then getgenv().Visuals=nil end;

		runCleanups();

		local sweep = {};

		for name, value in pairs(ESP) do
			if type(value) == "function"
				and (string.sub(name, 1, 5) == "Clear" or string.sub(name, 1, 7) == "Restore") then
				sweep[#sweep + 1] = name;
			end;
		end;

		table.sort(sweep);

		for _, name in ipairs(sweep) do
			local ok, err = pcall(ESP[name]);

			if not ok then warn("[visuals] cleanup " .. name .. ": " .. tostring(err)) end;
		end;

		for _, key in ipairs({"ChromaticGui","ArrowGui"}) do if ESP[key] then pcall(function() ESP[key]:Destroy() end) end end;
		unloadLibrary(NeverLose);
	end,
};

NeverLose.Unload = function() Visuals.Unload() end;
if getgenv then getgenv().Visuals = Visuals; end;

return Visuals;
