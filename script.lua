-- Services.
local playersService = game:GetService("Players")
local replicatedStorage = game:GetService("ReplicatedStorage")
local runService = game:GetService("RunService")
local tweenService = game:GetService("TweenService")
local statsService = game:GetService("Stats")
local userInputService = game:GetService("UserInputService")
local debrisService = game:GetService("Debris")
local soundService = game:GetService("SoundService")
local lightingService = game:GetService("Lighting")
local httpService = game:GetService("HttpService")
local marketService = game:GetService("MarketplaceService")
local avatarEditorService = game:GetService("AvatarEditorService")

local localPlayer = playersService.LocalPlayer
if not localPlayer then
	playersService:GetPropertyChangedSignal("LocalPlayer"):Wait()
	localPlayer = playersService.LocalPlayer
end

local camera = workspace.CurrentCamera

local playerRoles = {}
local originalSheriff = nil
local chamsOriginals = {}
local playerHealthCache = {}
local activeTogglesRegistry = {}
local keybindRegistry = {}
local listeningKeybind = nil
local selectedFlingPlayer = nil

local customFpsText = ""
local silentAimTarget = nil
local fovRadius = 180
local crosshairAngle = 0
local flingDebounce = false

local defaultLighting = {
	FogStart = lightingService.FogStart,
	FogEnd = lightingService.FogEnd,
	FogColor = lightingService.FogColor
}

local settings = {
	menuKeybind = Enum.KeyCode.Insert,

	roleEsp = false,
	espMurder = false,
	espSheriff = false,
	espHero = false,
	espInnocents = false,
	espAll = false,
	espGunDrop = false,

	highlightEsp = false,
	highlightColor = Color3.fromRGB(180, 90, 255),

	skeletonEsp = false,
	skeletonColor = Color3.fromRGB(255, 255, 255),

	box2D = false,
	box2DMode = "Full",
	box2DMM2 = false,
	box2DColor = Color3.fromRGB(255, 255, 255),
	box2DFill = false,
	box2DFillColor = Color3.fromRGB(160, 90, 255),
	box2DFillMM2 = false,

	arrowEsp = false,
	arrowEspColor = Color3.fromRGB(255, 255, 255),
	snaplines = false,
	snaplineOrigin = "Bottom",
	snaplineColor = Color3.fromRGB(255, 255, 255),

	healthBar = false,
	distanceEsp = false,
	distanceColor = Color3.fromRGB(255, 255, 255),

	box3D = false,
	box3DColor = Color3.fromRGB(160, 90, 255),
	box3DFill = false,
	box3DFillColor = Color3.fromRGB(160, 90, 255),

	aura = false,
	auraColor = Color3.fromRGB(185, 115, 255),
	selfWings = false,
	selfWingsColor = Color3.fromRGB(255, 255, 255),
	selfStarlight = false,
	jumpPulse = false,
	jumpPulseColor = Color3.fromRGB(185, 115, 255),

	glassChams = false,
	glassChamsAll = false,
	glassChamsColor = Color3.fromRGB(160, 100, 255),
	glassChamsMM2 = false,

	playHitSound = true,
	playKillSound = true,
	killFlash = false,
	killFlashColor = Color3.fromRGB(185, 90, 255),

	customFog = false,
	fogDistance = 250,
	fogColor = Color3.fromRGB(140, 100, 220),

	silentAim = false,
	silentAimTargetPart = "Head",
	showFov = false,
	autoKill = false,
	autoShootMurderer = false,

	bhop = false,
	speedHack = false,
	speedValue = 38,
	speedMethod = "Velocity",
	jumpPowerHack = false,
	jumpPowerValue = 50,
	jumpPowerMethod = "Humanoid",
	strafe = false,
	strafeType = "Hybrid",
	antiFling = false,
	antiVoid = false,

	fly = false,
	flySpeed = 1,
	noclip = false,
	autoCollectCoins = false,

	flingMode = "Rage",
	autoFlingTarget = false,
	autoFlingMurderer = false,
	autoFlingSheriff = false,
	autoFlingHero = false,

	crosshair = false,
	crosshairStyle = 1,
	crosshairSpin = false,
	crosshairColor = Color3.fromRGB(255, 255, 255),

	antiCheatBypass = true,
	furryBackground = false,
	menuTransparency = 0,
	hudActiveList = true,
	hudKeybindsList = true,

	menuWidth = 570,
	menuHeight = 370,
	hudWidth = 240,
	hudHeight = 32,

	bloxSilentAim = false,
	bloxSilentFOV = 35,
	bloxSilentTeamCheck = true,
	bloxSilentWallCheck = true,
	bloxAimPart = "Head",
	bloxNoRecoil = false,
	bloxNoSpread = false,
	bloxWallBang = false,
	bloxSpinBot = false,
	bloxSpinSpeed = 40,
	bloxEsp = false,
	bloxEspColor = Color3.fromRGB(0, 255, 130)
}

local colors = {
	bgDark = Color3.fromRGB(12, 10, 16),
	sidebarBg = Color3.fromRGB(15, 13, 20),
	cardBg = Color3.fromRGB(20, 17, 28),
	cardHover = Color3.fromRGB(28, 24, 38),
	border = Color3.fromRGB(48, 42, 65),
	borderActive = Color3.fromRGB(140, 90, 245),
	accent = Color3.fromRGB(140, 90, 245),
	accentSubtle = Color3.fromRGB(45, 30, 75),
	textPrimary = Color3.fromRGB(240, 238, 245),
	textSecondary = Color3.fromRGB(140, 135, 155),
	textMuted = Color3.fromRGB(90, 85, 105),

	murderer = Color3.fromRGB(240, 50, 60),
	sheriff = Color3.fromRGB(55, 130, 255),
	hero = Color3.fromRGB(250, 205, 45),
	innocent = Color3.fromRGB(55, 215, 115),
	gunDrop = Color3.fromRGB(255, 215, 35)
}

local soundCache = {
	hit = "rbxassetid://121642642930821",
	kill = "rbxassetid://135478009117226"
}

local function playCustomSound(id)
	pcall(function()
		local snd = Instance.new("Sound")
		snd.SoundId = id
		snd.Volume = 2.5
		snd.Parent = soundService
		snd:Play()
		debrisService:AddItem(snd, 3)
	end)
end

local animationPacks = {
	{ name = "Zombie Pack", idle1 = 616158929, idle2 = 616160018, walk = 616168032, run = 616163682, jump = 616161997, fall = 616157476 },
	{ name = "Ninja Pack", idle1 = 656117400, idle2 = 656118341, walk = 656121766, run = 656118852, jump = 656117878, fall = 656115606 },
	{ name = "Old School Pack", idle1 = 531982820, idle2 = 531983976, walk = 531984432, run = 531984432, jump = 531984193, fall = 531983572 },
	{ name = "Mage Pack", idle1 = 707742142, idle2 = 707855907, walk = 707897001, run = 707861613, jump = 707853694, fall = 707829716 },
	{ name = "Vampire Pack", idle1 = 1083445855, idle2 = 1083450166, walk = 1083463630, run = 1083462077, jump = 1083455352, fall = 1083443587 },
	{ name = "Superhero Pack", idle1 = 616111295, idle2 = 616113536, walk = 616121766, run = 616117076, jump = 616115533, fall = 616108001 },
	{ name = "Robot Pack", idle1 = 616088211, idle2 = 616089559, walk = 616095330, run = 616091570, jump = 616090535, fall = 616086039 },
	{ name = "Toy Pack", idle1 = 782841498, idle2 = 782845736, walk = 782843345, run = 782842708, jump = 782847020, fall = 782846423 },
	{ name = "Cartoony Pack", idle1 = 742637544, idle2 = 742638445, walk = 742638842, run = 742640026, jump = 742639812, fall = 742637151 },
	{ name = "Levitation Pack", idle1 = 616006778, idle2 = 616008087, walk = 616013647, run = 616010382, jump = 616009424, fall = 616005863 },
	{ name = "Werewolf Pack", idle1 = 1083195517, idle2 = 1083214794, walk = 1083218792, run = 1083216690, jump = 1083211110, fall = 1083189019 },
	{ name = "Pirate Pack", idle1 = 750781874, idle2 = 750782770, walk = 750785693, run = 750783738, jump = 750782230, fall = 750780242 },
	{ name = "Knight Pack", idle1 = 658824296, idle2 = 658825808, walk = 658839070, run = 658837146, jump = 658827948, fall = 658823511 },
	{ name = "Elder Pack", idle1 = 845397891, idle2 = 845400520, walk = 845403565, run = 845401763, jump = 845398858, fall = 845396048 }
}

local emoteList = {
	{ name = "Salute", id = 3360686498 },
	{ name = "Stadium", id = 3360689775 },
	{ name = "Tilt", id = 3360692915 },
	{ name = "Shrug", id = 3360694441 },
	{ name = "Point", id = 3360696147 },
	{ name = "Hello", id = 3360697843 },
	{ name = "Hype Dance", id = 3696757129 }
}

local r15Limbs = {
	{"Head", "UpperTorso"},
	{"UpperTorso", "LowerTorso"},
	{"UpperTorso", "LeftUpperArm"}, {"LeftUpperArm", "LeftLowerArm"}, {"LeftLowerArm", "LeftHand"},
	{"UpperTorso", "RightUpperArm"}, {"RightUpperArm", "RightLowerArm"}, {"RightLowerArm", "RightHand"},
	{"LowerTorso", "LeftUpperLeg"}, {"LeftUpperLeg", "LeftLowerLeg"}, {"LeftLowerLeg", "LeftFoot"},
	{"LowerTorso", "RightUpperLeg"}, {"RightUpperLeg", "RightLowerLeg"}, {"RightLowerLeg", "RightFoot"}
}

local r6Limbs = {
	{"Head", "Torso"},
	{"Torso", "Left Arm"},
	{"Torso", "Right Arm"},
	{"Torso", "Left Leg"},
	{"Torso", "Right Leg"}
}

local iconMap = {
	["Combat"] = "rbxassetid://86796167900966",
	["Visuals"] = "rbxassetid://131891142101954",
	["Misc"] = "rbxassetid://78903857382511",
	["Troll"] = "rbxassetid://72916572327175",
	["Bundles"] = "rbxassetid://70705022740112",
	["Config"] = "rbxassetid://123292948367309",
	["Settings"] = "rbxassetid://129338365599931"
}

local function decodePlayerData(data)
	if typeof(data) ~= "table" then return end
	for rawKey, rawValue in pairs(data) do
		local playerName = typeof(rawKey) == "Instance" and rawKey.Name or tostring(rawKey)
		if typeof(rawValue) == "table" then
			local detectedRole = rawValue.Role or rawValue.role or rawValue.ROLE
			if detectedRole then playerRoles[playerName] = tostring(detectedRole) end
		elseif typeof(rawValue) == "string" then
			playerRoles[playerName] = rawValue
		end
	end
end

pcall(function()
	local gameplayFolder = replicatedStorage:WaitForChild("Remotes", 5):WaitForChild("Gameplay", 5)
	local pdcRemote = gameplayFolder:WaitForChild("PlayerDataChanged", 5)
	if pdcRemote then
		pdcRemote.OnClientEvent:Connect(function(...)
			local packets = { ... }
			for _, item in ipairs(packets) do
				if typeof(item) == "table" then decodePlayerData(item) end
			end
		end)
	end
end)

local function resolveRole(player)
	if not player then return "Innocent" end
	if playerRoles[player.Name] then return playerRoles[player.Name] end
	local char = player.Character
	local bp = player:FindFirstChild("Backpack")
	if (char and char:FindFirstChild("Knife")) or (bp and bp:FindFirstChild("Knife")) then
		playerRoles[player.Name] = "Murderer"
		return "Murderer"
	end
	if (char and char:FindFirstChild("Gun")) or (bp and bp:FindFirstChild("Gun")) then
		if originalSheriff == nil or originalSheriff == player then
			originalSheriff = player
			playerRoles[player.Name] = "Sheriff"
			return "Sheriff"
		else
			playerRoles[player.Name] = "Hero"
			return "Hero"
		end
	end
	return "Innocent"
end

local function getMurdererPlayer()
	for _, p in ipairs(playersService:GetPlayers()) do
		if p ~= localPlayer and resolveRole(p) == "Murderer" then return p end
	end
	return nil
end

local function getSheriffPlayer()
	for _, p in ipairs(playersService:GetPlayers()) do
		if p ~= localPlayer and resolveRole(p) == "Sheriff" then return p end
	end
	return nil
end

local function getHeroPlayer()
	for _, p in ipairs(playersService:GetPlayers()) do
		if p ~= localPlayer and resolveRole(p) == "Hero" then return p end
	end
	return nil
end

local function executeFling(targetPlr)
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local tChar = targetPlr and targetPlr.Character
	local tHrp = tChar and tChar:FindFirstChild("HumanoidRootPart")
	local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")

	if hrp and tHrp and hum and tHum and tHum.Health > 0 then
		local origCF = hrp.CFrame

		local bav = Instance.new("BodyAngularVelocity")
		bav.Name = "AnxiumFlingAngular"
		bav.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
		bav.P = math.huge
		bav.AngularVelocity = Vector3.new(0, 999999, 0)
		bav.Parent = hrp

		local bv = Instance.new("BodyVelocity")
		bv.Name = "AnxiumFlingVelocity"
		bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
		bv.Velocity = Vector3.new(9e7, 9e7, 9e7)
		bv.Parent = hrp

		pcall(function() hum:ChangeState(Enum.HumanoidStateType.Physics) end)

		local startTime = tick()
		local flip = 1
		while tick() - startTime < 1.3 and tHrp and tHrp.Parent and tHum.Health > 0 do
			flip = -flip
			if settings.flingMode == "Rage" then
				local sideOffset = tHrp.CFrame.RightVector * (flip * 3)
				hrp.CFrame = CFrame.new(tHrp.Position + sideOffset + Vector3.new(0, math.random(-1, 1) * 0.3, 0))
				hrp.Velocity = Vector3.new(9e7, 9e7, 9e7)
			else
				hrp.CFrame = tHrp.CFrame * CFrame.new(0, math.random(-1, 1) * 0.25, 0)
				hrp.Velocity = Vector3.new(50000, 50000, 50000)
			end
			hrp.AssemblyLinearVelocity = Vector3.new(9e7, 9e7, 9e7)
			hrp.AssemblyAngularVelocity = Vector3.new(999999, 999999, 999999)
			runService.Heartbeat:Wait()
		end

		bav:Destroy()
		bv:Destroy()
		hrp.Velocity = Vector3.zero
		hrp.AssemblyLinearVelocity = Vector3.zero
		hrp.AssemblyAngularVelocity = Vector3.zero
		hrp.CFrame = origCF + Vector3.new(0, 3, 0)
		pcall(function() hum:ChangeState(Enum.HumanoidStateType.GettingUp) end)
	end
end

local function executeFlingAll()
	for _, plr in ipairs(playersService:GetPlayers()) do
		if plr ~= localPlayer and plr.Character then
			executeFling(plr)
			task.wait(0.1)
		end
	end
end

local flyBodyVelocity, flyBodyGyro = nil, nil
local flyKeys = { W = false, A = false, S = false, D = false, Up = false, Down = false }

local function startFly()
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if not hrp or not hum then return end
	hum.PlatformStand = true

	flyBodyGyro = Instance.new("BodyGyro")
	flyBodyGyro.P = 9e4
	flyBodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
	flyBodyGyro.CFrame = hrp.CFrame
	flyBodyGyro.Parent = hrp

	flyBodyVelocity = Instance.new("BodyVelocity")
	flyBodyVelocity.Velocity = Vector3.zero
	flyBodyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
	flyBodyVelocity.Parent = hrp
end

local function stopFly()
	if flyBodyVelocity then flyBodyVelocity:Destroy(); flyBodyVelocity = nil end
	if flyBodyGyro then flyBodyGyro:Destroy(); flyBodyGyro = nil end
	local char = localPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then hum.PlatformStand = false end
end

runService.RenderStepped:Connect(function()
	if settings.fly and flyBodyVelocity and flyBodyGyro then
		local char = localPlayer.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if not hrp then return end

		flyBodyGyro.CFrame = camera.CFrame
		local moveVector = Vector3.zero
		local speed = 50 * settings.flySpeed

		if flyKeys.W then moveVector = moveVector + camera.CFrame.LookVector end
		if flyKeys.S then moveVector = moveVector - camera.CFrame.LookVector end
		if flyKeys.A then moveVector = moveVector - camera.CFrame.RightVector end
		if flyKeys.D then moveVector = moveVector + camera.CFrame.RightVector end
		if flyKeys.Up then moveVector = moveVector + Vector3.new(0, 1, 0) end
		if flyKeys.Down then moveVector = moveVector - Vector3.new(0, 1, 0) end

		flyBodyVelocity.Velocity = moveVector.Magnitude > 0 and (moveVector.Unit * speed) or Vector3.zero
	end
end)

userInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.KeyCode == Enum.KeyCode.W then flyKeys.W = true
	elseif input.KeyCode == Enum.KeyCode.S then flyKeys.S = true
	elseif input.KeyCode == Enum.KeyCode.A then flyKeys.A = true
	elseif input.KeyCode == Enum.KeyCode.D then flyKeys.D = true
	elseif input.KeyCode == Enum.KeyCode.Space then flyKeys.Up = true
	elseif input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.LeftControl then flyKeys.Down = true end
end)

userInputService.InputEnded:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.W then flyKeys.W = false
	elseif input.KeyCode == Enum.KeyCode.S then flyKeys.S = false
	elseif input.KeyCode == Enum.KeyCode.A then flyKeys.A = false
	elseif input.KeyCode == Enum.KeyCode.D then flyKeys.D = false
	elseif input.KeyCode == Enum.KeyCode.Space then flyKeys.Up = false
	elseif input.KeyCode == Enum.KeyCode.LeftShift or input.KeyCode == Enum.KeyCode.LeftControl then flyKeys.Down = false end
end)

runService.Stepped:Connect(function()
	if settings.noclip or settings.autoCollectCoins then
		local char = localPlayer.Character
		if char then
			for _, part in ipairs(char:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = false end
			end
		end
	end
end)

local function teleportToMouse()
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local mousePos = userInputService:GetMouseLocation()
	local unitRay = camera:ViewportPointToRay(mousePos.X, mousePos.Y)
	local rayParams = RaycastParams.new()
	rayParams.FilterType = Enum.RaycastFilterType.Exclude
	rayParams.FilterDescendantsInstances = {char}

	local hit = workspace:Raycast(unitRay.Origin, unitRay.Direction * 2000, rayParams)
	if hit then
		hrp.CFrame = CFrame.new(hit.Position + Vector3.new(0, 3, 0))
		hrp.Velocity = Vector3.zero
		hrp.AssemblyLinearVelocity = Vector3.zero
	end
end

local function getCoinContainer()
	for _, obj in ipairs(workspace:GetChildren()) do
		local c = obj:FindFirstChild("CoinContainer")
		if c then return c end
	end
	return workspace:FindFirstChild("CoinContainer", true)
end

task.spawn(function()
	while true do
		task.wait(0.1)
		if settings.autoCollectCoins then
			local char = localPlayer.Character
			local hrp = char and char:FindFirstChild("HumanoidRootPart")
			local hum = char and char:FindFirstChildOfClass("Humanoid")
			local container = getCoinContainer()

			if hrp and hum and hum.Health > 0 and container then
				for _, coin in ipairs(container:GetChildren()) do
					if not settings.autoCollectCoins then break end
					local coinPart = coin:IsA("BasePart") and coin or coin:FindFirstChildWhichIsA("BasePart", true)
					if coinPart and coinPart.Transparency < 0.9 then
						local reached = false
						while not reached and settings.autoCollectCoins and coinPart.Parent and coinPart.Transparency < 0.9 and hum.Health > 0 do
							local cPos = hrp.Position
							local tPos = coinPart.Position
							local dist = (tPos - cPos).Magnitude

							if dist < 2.5 then
								hrp.CFrame = CFrame.new(tPos)
								if typeof(firetouchinterest) == "function" then
									firetouchinterest(coinPart, hrp, 0)
									firetouchinterest(coinPart, hrp, 1)
								end
								reached = true
								task.wait(0.2)
							else
								local dir = (tPos - cPos).Unit
								hrp.Velocity = Vector3.zero
								hrp.AssemblyLinearVelocity = Vector3.zero
								hrp.CFrame = CFrame.new(cPos + (dir * math.min(19 * 0.05, dist)))
								task.wait(0.05)
							end
						end
					end
				end
			end
		end
	end
end)

local function shootMurderer()
	local char = localPlayer.Character
	local bp = localPlayer:FindFirstChild("Backpack")
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local gun = (char and char:FindFirstChild("Gun")) or (bp and bp:FindFirstChild("Gun"))

	local m = getMurdererPlayer()
	local mChar = m and m.Character
	local mHead = mChar and mChar:FindFirstChild("Head")
	local mHum = mChar and mChar:FindFirstChildOfClass("Humanoid")

	if not (gun and hum and mHead and mHum and mHum.Health > 0) then return end
	if gun.Parent == bp then hum:EquipTool(gun); task.wait(0.08) end

	local shootRemote = replicatedStorage:FindFirstChild("ShootGun", true)
	if shootRemote then
		local predTarget = mHead.Position + (mHead.AssemblyLinearVelocity * 0.032)
		if shootRemote:IsA("RemoteFunction") then
			shootRemote:InvokeServer(camera.CFrame.Position, predTarget)
		elseif shootRemote:IsA("RemoteEvent") then
			shootRemote:FireServer(camera.CFrame.Position, predTarget)
		end
	end
end

task.spawn(function()
	while true do
		task.wait(0.4)
		if settings.autoShootMurderer then shootMurderer() end
	end
end)

task.spawn(function()
	while true do
		task.wait(0.6)
		if not flingDebounce then
			if settings.autoFlingMurderer then
				local m = getMurdererPlayer()
				if m then
					flingDebounce = true
					executeFling(m)
					flingDebounce = false
				end
			elseif settings.autoFlingSheriff then
				local s = getSheriffPlayer()
				if s then
					flingDebounce = true
					executeFling(s)
					flingDebounce = false
				end
			elseif settings.autoFlingHero then
				local h = getHeroPlayer()
				if h then
					flingDebounce = true
					executeFling(h)
					flingDebounce = false
				end
			elseif settings.autoFlingTarget and selectedFlingPlayer then
				flingDebounce = true
				executeFling(selectedFlingPlayer)
				flingDebounce = false
			end
		end
	end
end)

local function applyHighlight(instance, color, tag)
	if not instance or not instance.Parent then return end
	local hl = instance:FindFirstChild(tag)
	if not hl then
		hl = Instance.new("Highlight")
		hl.Name = tag
		hl.Adornee = instance
		pcall(function()
			hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
		end)
		hl.FillTransparency = 0.5
		hl.OutlineTransparency = 0.1
		hl.Parent = instance
	end
	hl.FillColor = color
	hl.OutlineColor = color
	hl.Enabled = true
end

local function stripHighlight(instance, tag)
	if not instance then return end
	local hl = instance:FindFirstChild(tag)
	if hl then hl.Enabled = false end
end

local function getHealthColor(alpha)
	alpha = math.clamp(alpha, 0, 1)
	if alpha >= 0.5 then
		local factor = (alpha - 0.5) * 2
		return Color3.fromRGB(245, 215, 55):Lerp(Color3.fromRGB(55, 225, 105), factor)
	else
		local factor = alpha * 2
		return Color3.fromRGB(240, 50, 60):Lerp(Color3.fromRGB(245, 215, 55), factor)
	end
end

local function drawScreenLine(lineFrame, p1, p2, color, thickness)
	local dist = (p2 - p1).Magnitude
	local mid = (p1 + p2) / 2
	local angle = math.deg(math.atan2(p2.Y - p1.Y, p2.X - p1.X))

	lineFrame.Size = UDim2.new(0, dist, 0, thickness or 1.5)
	lineFrame.Position = UDim2.new(0, mid.X, 0, mid.Y)
	lineFrame.Rotation = angle
	lineFrame.BackgroundColor3 = color
	lineFrame.Visible = true
end

local function getSafeContainer()
	local successHui, hui = pcall(gethui)
	if successHui and hui then return hui end
	local successCore, coreGui = pcall(function() return game:GetService("CoreGui") end)
	if successCore and coreGui then
		local test = pcall(function() return coreGui.Name end)
		if test then return coreGui end
	end
	local pGui = localPlayer:FindFirstChildOfClass("PlayerGui")
	if pGui then return pGui end
	return localPlayer:WaitForChild("PlayerGui", 10)
end

pcall(function()
	local oldGui = getSafeContainer():FindFirstChild("AnxiumSuite")
	if oldGui then oldGui:Destroy() end
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AnxiumSuite"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = getSafeContainer()

local espContainer = Instance.new("Folder", screenGui)
espContainer.Name = "ESPContainer"

local function makeDraggable(targetFrame, dragHandle, onClickCallback)
	dragHandle = dragHandle or targetFrame
	local dragging = false
	local dragStart, startPos
	local hasMoved = false

	dragHandle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			hasMoved = false
			dragStart = input.Position
			startPos = targetFrame.Position

			local endConn
			endConn = userInputService.InputEnded:Connect(function(endInput)
				if endInput.UserInputType == Enum.UserInputType.MouseButton1 or endInput.UserInputType == Enum.UserInputType.Touch then
					dragging = false
					endConn:Disconnect()
					if not hasMoved and onClickCallback then
						onClickCallback()
					end
				end
			end)
		end
	end)

	userInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			if delta.Magnitude > 6 then hasMoved = true end
			targetFrame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end)
end
-- [КОНЕЦ ЧАСТИ 1]
local killFlashOverlay = Instance.new("Frame", screenGui)
killFlashOverlay.Name = "KillFlash"
killFlashOverlay.Size = UDim2.new(1, 0, 1, 0)
killFlashOverlay.BackgroundColor3 = settings.killFlashColor
killFlashOverlay.BackgroundTransparency = 1
killFlashOverlay.ZIndex = 90

local function triggerKillFlash()
	killFlashOverlay.BackgroundColor3 = settings.killFlashColor
	killFlashOverlay.BackgroundTransparency = 0.45
	tweenService:Create(killFlashOverlay, TweenInfo.new(0.4, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
		BackgroundTransparency = 1
	}):Play()
end

local crosshairContainer = Instance.new("Frame", screenGui)
crosshairContainer.Name = "CustomCrosshair"
crosshairContainer.Size = UDim2.new(0, 44, 0, 44)
crosshairContainer.Position = UDim2.new(0.5, -22, 0.5, -22)
crosshairContainer.BackgroundTransparency = 1
crosshairContainer.Visible = false

local chElements = {}
for i = 1, 10 do
	local f = Instance.new("Frame", crosshairContainer)
	f.BorderSizePixel = 0
	f.BackgroundColor3 = settings.crosshairColor
	f.Visible = false
	table.insert(chElements, f)
end

local function updateCrosshairRender()
	for _, el in ipairs(chElements) do
		el.Visible = false
		el.BackgroundColor3 = settings.crosshairColor
	end
	local style = settings.crosshairStyle
	if style == 1 then
		chElements[1].Size = UDim2.new(0, 4, 0, 4)
		chElements[1].Position = UDim2.new(0.5, -2, 0.5, -2)
		chElements[1].Visible = true
	elseif style == 2 then
		chElements[1].Size = UDim2.new(0, 2, 0, 10); chElements[1].Position = UDim2.new(0.5, -1, 0.5, -13); chElements[1].Visible = true
		chElements[2].Size = UDim2.new(0, 2, 0, 10); chElements[2].Position = UDim2.new(0.5, -1, 0.5, 3); chElements[2].Visible = true
		chElements[3].Size = UDim2.new(0, 10, 0, 2); chElements[3].Position = UDim2.new(0.5, -13, 0.5, -1); chElements[3].Visible = true
		chElements[4].Size = UDim2.new(0, 10, 0, 2); chElements[4].Position = UDim2.new(0.5, 3, 0.5, -1); chElements[4].Visible = true
	elseif style == 3 then
		chElements[1].Size = UDim2.new(0, 2, 0, 14); chElements[1].Position = UDim2.new(0.5, -1, 0.5, -7); chElements[1].Visible = true
		chElements[2].Size = UDim2.new(0, 14, 0, 2); chElements[2].Position = UDim2.new(0.5, -7, 0.5, -1); chElements[2].Visible = true
		chElements[3].Size = UDim2.new(0, 6, 0, 2); chElements[3].Position = UDim2.new(0.5, -1, 0.5, -7); chElements[3].Visible = true
		chElements[4].Size = UDim2.new(0, 6, 0, 2); chElements[4].Position = UDim2.new(0.5, -5, 0.5, 5); chElements[4].Visible = true
		chElements[5].Size = UDim2.new(0, 2, 0, 6); chElements[5].Position = UDim2.new(0.5, 5, 0.5, -1); chElements[5].Visible = true
		chElements[6].Size = UDim2.new(0, 2, 0, 6); chElements[6].Position = UDim2.new(0.5, -7, 0.5, -5); chElements[6].Visible = true
	else
		chElements[1].Size = UDim2.new(0, 4, 0, 4); chElements[1].Position = UDim2.new(0.5, -2, 0.5, -2); chElements[1].Visible = true
		chElements[2].Size = UDim2.new(0, 2, 0, 6); chElements[2].Position = UDim2.new(0.5, -1, 0.5, -9); chElements[2].Visible = true
		chElements[3].Size = UDim2.new(0, 2, 0, 6); chElements[3].Position = UDim2.new(0.5, -1, 0.5, 3); chElements[3].Visible = true
		chElements[4].Size = UDim2.new(0, 6, 0, 2); chElements[4].Position = UDim2.new(0.5, -9, 0.5, -1); chElements[4].Visible = true
		chElements[5].Size = UDim2.new(0, 6, 0, 2); chElements[5].Position = UDim2.new(0.5, 3, 0.5, -1); chElements[5].Visible = true
	end
end

local fovCircleFrame = Instance.new("Frame", screenGui)
fovCircleFrame.Name = "FOVCircle"
fovCircleFrame.Size = UDim2.new(0, fovRadius * 2, 0, fovRadius * 2)
fovCircleFrame.Position = UDim2.new(0.5, -fovRadius, 0.5, -fovRadius)
fovCircleFrame.BackgroundTransparency = 1
fovCircleFrame.Visible = false

local fovCorner = Instance.new("UICorner", fovCircleFrame)
fovCorner.CornerRadius = UDim.new(1, 0)
local fovStroke = Instance.new("UIStroke", fovCircleFrame)
fovStroke.Color = colors.accent
fovStroke.Thickness = 1.2
fovStroke.Transparency = 0.35

local hudActiveBox = Instance.new("Frame", screenGui)
hudActiveBox.Name = "ActiveFeaturesHUD"
hudActiveBox.Size = UDim2.new(0, 140, 0, 20)
hudActiveBox.Position = UDim2.new(0.04, 0, 0.12, 0)
hudActiveBox.BackgroundColor3 = Color3.fromRGB(15, 12, 22)
hudActiveBox.BackgroundTransparency = 0.35
hudActiveBox.Visible = true

local habCorner = Instance.new("UICorner", hudActiveBox)
habCorner.CornerRadius = UDim.new(0, 6)
local habStroke = Instance.new("UIStroke", hudActiveBox)
habStroke.Color = colors.border
habStroke.Thickness = 1

local habTitle = Instance.new("TextLabel", hudActiveBox)
habTitle.Size = UDim2.new(1, -12, 0, 18)
habTitle.Position = UDim2.new(0, 8, 0, 2)
habTitle.BackgroundTransparency = 1
habTitle.Font = Enum.Font.GothamBold
habTitle.Text = "Active"
habTitle.TextColor3 = colors.accent
habTitle.TextSize = 10
habTitle.TextXAlignment = Enum.TextXAlignment.Left

local habList = Instance.new("TextLabel", hudActiveBox)
habList.Size = UDim2.new(1, -12, 0, 0)
habList.Position = UDim2.new(0, 8, 0, 20)
habList.BackgroundTransparency = 1
habList.Font = Enum.Font.RobotoMono
habList.Text = "None"
habList.TextColor3 = colors.textSecondary
habList.TextSize = 9
habList.TextXAlignment = Enum.TextXAlignment.Left
habList.TextYAlignment = Enum.TextYAlignment.Top

local function refreshActiveHud()
	local activeNames = {}
	for name, state in pairs(activeTogglesRegistry) do
		if state then table.insert(activeNames, "• " .. name) end
	end
	if #activeNames == 0 then
		habList.Text = "• None"
		hudActiveBox.Size = UDim2.new(0, 140, 0, 36)
	else
		habList.Text = table.concat(activeNames, "\n")
		hudActiveBox.Size = UDim2.new(0, 140, 0, 24 + (#activeNames * 12))
	end
end

local hudKeybindsBox = Instance.new("Frame", screenGui)
hudKeybindsBox.Name = "KeybindsHUD"
hudKeybindsBox.Size = UDim2.new(0, 140, 0, 36)
hudKeybindsBox.Position = UDim2.new(0.04, 0, 0.28, 0)
hudKeybindsBox.BackgroundColor3 = Color3.fromRGB(15, 12, 22)
hudKeybindsBox.BackgroundTransparency = 0.35
hudKeybindsBox.Visible = true

local hkbCorner = Instance.new("UICorner", hudKeybindsBox)
hkbCorner.CornerRadius = UDim.new(0, 6)
local hkbStroke = Instance.new("UIStroke", hudKeybindsBox)
hkbStroke.Color = colors.border
hkbStroke.Thickness = 1

local hkbTitle = Instance.new("TextLabel", hudKeybindsBox)
hkbTitle.Size = UDim2.new(1, -12, 0, 18)
hkbTitle.Position = UDim2.new(0, 8, 0, 2)
hkbTitle.BackgroundTransparency = 1
hkbTitle.Font = Enum.Font.GothamBold
hkbTitle.Text = "Keybinds"
hkbTitle.TextColor3 = colors.accent
hkbTitle.TextSize = 10
hkbTitle.TextXAlignment = Enum.TextXAlignment.Left

local hkbList = Instance.new("TextLabel", hudKeybindsBox)
hkbList.Size = UDim2.new(1, -12, 0, 0)
hkbList.Position = UDim2.new(0, 8, 0, 20)
hkbList.BackgroundTransparency = 1
hkbList.Font = Enum.Font.RobotoMono
hkbList.Text = "• None"
hkbList.TextColor3 = colors.textSecondary
hkbList.TextSize = 9
hkbList.TextXAlignment = Enum.TextXAlignment.Left
hkbList.TextYAlignment = Enum.TextYAlignment.Top

local function refreshKeybindsHud()
	local entries = {}
	if settings.menuKeybind and settings.menuKeybind ~= Enum.KeyCode.Unknown then
		table.insert(entries, string.format("• [%s] Menu Toggle", settings.menuKeybind.Name))
	end
	for name, item in pairs(keybindRegistry) do
		if item.key and item.key ~= Enum.KeyCode.Unknown then
			table.insert(entries, string.format("• [%s] %s", item.key.Name, name))
		end
	end
	if #entries == 0 then
		hkbList.Text = "• None"
		hudKeybindsBox.Size = UDim2.new(0, 140, 0, 36)
	else
		hkbList.Text = table.concat(entries, "\n")
		hudKeybindsBox.Size = UDim2.new(0, 140, 0, 24 + (#entries * 12))
	end
end

local hudFrame = Instance.new("Frame", screenGui)
hudFrame.Name = "HUD"
hudFrame.Size = UDim2.new(0, settings.hudWidth, 0, settings.hudHeight)
hudFrame.Position = UDim2.new(0.04, 0, 0.06, 0)
hudFrame.BackgroundColor3 = colors.bgDark
hudFrame.Active = true

local hudCorner = Instance.new("UICorner", hudFrame)
hudCorner.CornerRadius = UDim.new(0, 8)
local hudStroke = Instance.new("UIStroke", hudFrame)
hudStroke.Color = colors.border
hudStroke.Thickness = 1

local hudStatusDot = Instance.new("Frame", hudFrame)
hudStatusDot.Size = UDim2.new(0, 6, 0, 6)
hudStatusDot.Position = UDim2.new(0, 10, 0.5, -3)
hudStatusDot.BackgroundColor3 = colors.accent
local dotCorner = Instance.new("UICorner", hudStatusDot)
dotCorner.CornerRadius = UDim.new(1, 0)

local hudTitle = Instance.new("TextLabel", hudFrame)
hudTitle.Size = UDim2.new(0, 56, 1, 0)
hudTitle.Position = UDim2.new(0, 22, 0, 0)
hudTitle.BackgroundTransparency = 1
hudTitle.Font = Enum.Font.GothamBold
hudTitle.Text = "ANXIUM"
hudTitle.TextColor3 = colors.textPrimary
hudTitle.TextSize = 11
hudTitle.TextXAlignment = Enum.TextXAlignment.Left

local hudShine = Instance.new("UIGradient", hudTitle)
hudShine.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 238, 245)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 165, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 238, 245))
})

task.spawn(function()
	local offset = -1
	while screenGui.Parent do
		offset = offset + 0.035
		if offset > 1 then offset = -1 end
		hudShine.Offset = Vector2.new(offset, 0)
		task.wait(0.03)
	end
end)

local hudDivider = Instance.new("Frame", hudFrame)
hudDivider.Size = UDim2.new(0, 1, 0, 14)
hudDivider.Position = UDim2.new(0, 82, 0.5, -7)
hudDivider.BackgroundColor3 = colors.border
hudDivider.BorderSizePixel = 0

local hudPing = Instance.new("TextLabel", hudFrame)
hudPing.Size = UDim2.new(0, 60, 1, 0)
hudPing.Position = UDim2.new(0, 88, 0, 0)
hudPing.BackgroundTransparency = 1
hudPing.Font = Enum.Font.RobotoMono
hudPing.Text = "0 ms"
hudPing.TextColor3 = colors.textSecondary
hudPing.TextSize = 11
hudPing.TextXAlignment = Enum.TextXAlignment.Left

local hudDivider2 = Instance.new("Frame", hudFrame)
hudDivider2.Size = UDim2.new(0, 1, 0, 14)
hudDivider2.Position = UDim2.new(0, 150, 0.5, -7)
hudDivider2.BackgroundColor3 = colors.border
hudDivider2.BorderSizePixel = 0

local hudFps = Instance.new("TextLabel", hudFrame)
hudFps.Size = UDim2.new(1, -156, 1, 0)
hudFps.Position = UDim2.new(0, 156, 0, 0)
hudFps.BackgroundTransparency = 1
hudFps.Font = Enum.Font.RobotoMono
hudFps.Text = "60 fps"
hudFps.TextColor3 = Color3.fromRGB(50, 235, 110)
hudFps.TextSize = 11
hudFps.TextXAlignment = Enum.TextXAlignment.Left

local fpsFrameCount = 0
local fpsLastTime = tick()

runService.RenderStepped:Connect(function()
	fpsFrameCount = fpsFrameCount + 1
	local now = tick()
	if now - fpsLastTime >= 1 then
		if customFpsText ~= "" then
			hudFps.Text = customFpsText
		else
			hudFps.Text = string.format("%d fps", fpsFrameCount)
		end
		fpsFrameCount = 0
		fpsLastTime = now
	end
end)

task.spawn(function()
	while screenGui.Parent do
		local pingVal = 0
		pcall(function()
			pingVal = math.floor(statsService.Network.ServerStatsItem["Data Ping"]:GetValue())
		end)
		hudPing.Text = string.format("%d ms", pingVal)
		task.wait(1)
	end
end)

-- ===================== BLOXSTRIKE COMPLETE =====================
local bloxSilent = {
	Enabled = false,
	TeamCheck = true,
	WallCheck = true,
	FOV = 35,
	AimPart = "Head"
}

local bloxEspCache = {}
local bloxTracers = {}

local function isBloxAlive(char)
	if not char then return false end
	if char:GetAttribute("Dead") then return false end
	local hp = char:GetAttribute("Health")
	return hp == nil or hp > 0
end

local function isBloxObstructed(origin, target, char)
	local params = RaycastParams.new()
	params.FilterType = Enum.RaycastFilterType.Exclude
	params.FilterDescendantsInstances = {char, localPlayer.Character}
	local ray = workspace:Raycast(origin, target - origin, params)
	return ray and ray.Instance and not ray.Instance:IsDescendantOf(char)
end

local function getBloxTarget(origin)
	local localTeam = localPlayer:GetAttribute("Team")
	local look = camera.CFrame.LookVector
	local best, bestAngle = nil, math.rad(bloxSilent.FOV)

	for _, plr in ipairs(playersService:GetPlayers()) do
		if plr == localPlayer then continue end
		local char = plr.Character
		if not isBloxAlive(char) then continue end
		if bloxSilent.TeamCheck and plr:GetAttribute("Team") == localTeam then continue end

		local part = char:FindFirstChild(bloxSilent.AimPart)
			or char:FindFirstChild("Head")
			or char:FindFirstChild("HumanoidRootPart")
		if not part then continue end

		local dir = (part.Position - origin).Unit
		local angle = math.acos(math.clamp(look:Dot(dir), -1, 1))
		if angle < bestAngle then
			if bloxSilent.WallCheck and isBloxObstructed(origin, part.Position, char) then continue end
			best, bestAngle = part, angle
		end
	end
	return best
end

local function buildBloxHit(origin, part)
	local pos = part.Position
	local dir = (pos - origin).Unit
	return {
		Distance = (pos - origin).Magnitude,
		Instance = part,
		Position = pos,
		Normal = -dir,
		Material = part.Material.Name,
		Exit = false
	}
end

task.spawn(function()
	local ok, Remotes = pcall(function()
		return require(replicatedStorage.Database.Security.Remotes)
	end)
	if not ok or not Remotes then return end

	local shoot = Remotes.Inventory and Remotes.Inventory.ShootWeapon
	if not (shoot and shoot.Send) then return end

	local old
	local function hook(packet, ...)
		if settings.bloxSilentAim and packet and packet.Bullets then
			for _, b in ipairs(packet.Bullets) do
				if b.Origin then
					local part = getBloxTarget(b.Origin)
					if part then
						b.Direction = (part.Position - b.Origin).Unit
						b.Hits = {buildBloxHit(b.Origin, part)}
					end
				end
			end
		end
		return old(packet, ...)
	end

	if typeof(hookfunction) == "function" then
		old = hookfunction(shoot.Send, hook)
	else
		old = shoot.Send
		shoot.Send = hook
	end
end)

task.spawn(function()
	pcall(function()
		local cameraControllerScript = replicatedStorage:WaitForChild("Controllers", 3)
		if cameraControllerScript then
			cameraControllerScript = cameraControllerScript:FindFirstChild("CameraController")
		end

		if cameraControllerScript then
			local controllerModule = require(cameraControllerScript)
			local oldWeaponKick = controllerModule.weaponKick
			local oldSetRecoil = controllerModule.setWeaponRecoil

			controllerModule.weaponKick = function(...)
				if settings.bloxNoRecoil then return end
				return oldWeaponKick(...)
			end

			controllerModule.setWeaponRecoil = function(...)
				if settings.bloxNoRecoil then return end
				return oldSetRecoil(...)
			end
		end

		local bulletScript = replicatedStorage:WaitForChild("Components", 3)
		if bulletScript then
			bulletScript = bulletScript:FindFirstChild("Bullet")
		end

		if bulletScript then
			local bulletModule = require(bulletScript)
			local oldTrueSpread = bulletModule.getTrueSpread
			local oldBaseSpread = bulletModule.getBaseSpread

			bulletModule.getTrueSpread = function(self, ...)
				if settings.bloxNoSpread then return 0 end
				return oldTrueSpread and oldTrueSpread(self, ...) or 0
			end

			bulletModule.getBaseSpread = function(self, ...)
				if settings.bloxNoSpread then return 0 end
				return oldBaseSpread and oldBaseSpread(self, ...) or 0
			end
		end
	end)
end)

pcall(function()
	local old
	old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
		local method = getnamecallmethod()
		if not checkcaller() and method == "Raycast" and settings.bloxWallBang then
			local args = {...}
			if typeof(args[3]) == "RaycastParams" then
				args[3].FilterType = Enum.RaycastFilterType.Exclude
				args[3].FilterDescendantsInstances = {workspace}
			end
			return old(self, unpack(args))
		end
		return old(self, ...)
	end))
end)

runService.RenderStepped:Connect(function(dt)
	if not settings.bloxSpinBot then return end
	local hrp = localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(settings.bloxSpinSpeed * 60 * dt), 0)
	end
end)

local function getBloxTargets()
	local list = {}

	local chars = workspace:FindFirstChild("Characters")
	if chars then
		for _, folder in ipairs(chars:GetChildren()) do
			for _, model in ipairs(folder:GetChildren()) do
				if model:IsA("Model") then
					table.insert(list, model)
				end
			end
		end
	end

	local debris = workspace:FindFirstChild("Debris")
	if debris then
		for _, child in ipairs(debris:GetChildren()) do
			if child:IsA("Model") and (child:FindFirstChild("HumanoidRootPart") or child:FindFirstChild("Head")) then
				table.insert(list, child)
			end
		end
	end

	for _, plr in ipairs(playersService:GetPlayers()) do
		if plr ~= localPlayer and plr.Character then
			table.insert(list, plr.Character)
		end
	end

	return list
end

local function destroyBloxEsp(model)
	local data = bloxEspCache[model]
	if data then
		if data.box then pcall(function() data.box:Remove() end) end
		if data.snap then pcall(function() data.snap:Remove() end) end
		bloxEspCache[model] = nil
	end
end

local function createBloxEsp(model)
	if bloxEspCache[model] then return bloxEspCache[model] end

	local box = Drawing.new("Square")
	box.Thickness = 1
	box.Filled = false
	box.Visible = false

	local snap = Drawing.new("Line")
	snap.Thickness = 1.2
	snap.Visible = false

	bloxEspCache[model] = {box = box, snap = snap}
	return bloxEspCache[model]
end

workspace.DescendantRemoving:Connect(function(obj)
	if bloxEspCache[obj] then
		destroyBloxEsp(obj)
	end
end)

runService.RenderStepped:Connect(function()
	if not settings.bloxEsp then
		for model, data in pairs(bloxEspCache) do
			data.box.Visible = false
			data.snap.Visible = false
		end
		return
	end

	local color = settings.bloxEspColor or Color3.fromRGB(0, 255, 130)
	local screenBottom = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y)
	local targets = getBloxTargets()
	local seen = {}

	for _, model in ipairs(targets) do
		local hrp = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head")
		local hum = model:FindFirstChildOfClass("Humanoid")

		if not hrp or (hum and hum.Health <= 0) or not isBloxAlive(model) then
			destroyBloxEsp(model)
			continue
		end

		seen[model] = true
		local data = createBloxEsp(model)

		data.box.Color = color
		data.snap.Color = color

		local topPos = hrp.Position + Vector3.new(0, 2.6, 0)
		local bottomPos = hrp.Position - Vector3.new(0, 2.6, 0)

		local top, topOnScreen = camera:WorldToViewportPoint(topPos)
		local bottom, bottomOnScreen = camera:WorldToViewportPoint(bottomPos)
		local center = camera:WorldToViewportPoint(hrp.Position)

		if topOnScreen and bottomOnScreen and top.Z > 0 then
			local height = math.abs(top.Y - bottom.Y)
			local width = height * 0.65

			data.box.Size = Vector2.new(width, height)
			data.box.Position = Vector2.new(top.X - width / 2, top.Y)
			data.box.Visible = true

			data.snap.From = screenBottom
			data.snap.To = Vector2.new(center.X, bottom.Y)
			data.snap.Visible = true
		else
			data.box.Visible = false
			data.snap.Visible = false
		end
	end

	for model, data in pairs(bloxEspCache) do
		if not seen[model] then
			destroyBloxEsp(model)
		end
	end
end)

local function addTracer(fromPos, toPos)
	local from = camera:WorldToViewportPoint(fromPos)
	local to = camera:WorldToViewportPoint(toPos)
	if from.Z <= 0 or to.Z <= 0 then return end

	local line = Drawing.new("Line")
	line.From = Vector2.new(from.X, from.Y)
	line.To = Vector2.new(to.X, to.Y)
	line.Color = Color3.fromRGB(0, 255, 200)
	line.Thickness = 1.6
	line.Visible = true

	table.insert(bloxTracers, {line = line, life = 0.5})
end

runService.RenderStepped:Connect(function(dt)
	for i = #bloxTracers, 1, -1 do
		local t = bloxTracers[i]
		t.life = t.life - dt
		if t.life <= 0 then
			t.line:Remove()
			table.remove(bloxTracers, i)
		else
			t.line.Transparency = 1 - (t.life / 0.5)
		end
	end
end)

pcall(function()
	local old
	old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
		local method = getnamecallmethod()
		local args = {...}

		if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
			if typeof(args[1]) == "Vector3" and typeof(args[2]) == "Vector3" then
				addTracer(args[1], args[2])
			end
		end

		return old(self, ...)
	end))
end)

local mainFrame = Instance.new("Frame", screenGui)
mainFrame.Name = "Main"
mainFrame.Size = UDim2.new(0, settings.menuWidth, 0, settings.menuHeight)
mainFrame.Position = UDim2.new(0.5, -settings.menuWidth / 2, 0.5, -settings.menuHeight / 2)
mainFrame.BackgroundColor3 = colors.bgDark
mainFrame.ClipsDescendants = true
mainFrame.Visible = true

local mainCorner = Instance.new("UICorner", mainFrame)
mainCorner.CornerRadius = UDim.new(0, 12)
local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = colors.border
mainStroke.Thickness = 1.2

local furryBg = Instance.new("ImageLabel", mainFrame)
furryBg.Name = "FurryBg"
furryBg.Size = UDim2.new(1, 0, 1, 0)
furryBg.BackgroundTransparency = 1
furryBg.Image = "rbxassetid://14799621400"
furryBg.ScaleType = Enum.ScaleType.Crop
furryBg.Visible = false

local gridCanvas = Instance.new("ImageLabel", mainFrame)
gridCanvas.Size = UDim2.new(2, 0, 2, 0)
gridCanvas.Position = UDim2.new(-0.5, 0, -0.5, 0)
gridCanvas.BackgroundTransparency = 1
gridCanvas.Image = "rbxassetid://9968344505"
gridCanvas.ImageColor3 = colors.accent
gridCanvas.ImageTransparency = 0.94
gridCanvas.ScaleType = Enum.ScaleType.Tile
gridCanvas.TileSize = UDim2.new(0, 28, 0, 28)

local gridVector = Vector2.new(0, 0)
runService.RenderStepped:Connect(function(dt)
	if mainFrame.Visible then
		gridVector = gridVector + Vector2.new(-18, 18) * dt
		gridCanvas.Position = UDim2.new(-0.5, gridVector.X % 28, -0.5, gridVector.Y % 28)
	end
end)

local sidebar = Instance.new("Frame", mainFrame)
sidebar.Size = UDim2.new(0, 160, 1, 0)
sidebar.BackgroundColor3 = colors.sidebarBg
sidebar.BorderSizePixel = 0

local sidebarCorner = Instance.new("UICorner", sidebar)
sidebarCorner.CornerRadius = UDim.new(0, 12)
local sidebarBorder = Instance.new("Frame", sidebar)
sidebarBorder.Size = UDim2.new(0, 1, 1, 0)
sidebarBorder.Position = UDim2.new(1, -1, 0, 0)
sidebarBorder.BackgroundColor3 = colors.border
sidebarBorder.BorderSizePixel = 0

local dragBar = Instance.new("Frame", mainFrame)
dragBar.Size = UDim2.new(1, 0, 0, 32)
dragBar.BackgroundTransparency = 1

makeDraggable(mainFrame, dragBar)
makeDraggable(mainFrame, sidebar)

local isMenuOpen = true
local function toggleMenu()
	isMenuOpen = not isMenuOpen
	local targetSize = UDim2.new(0, settings.menuWidth, 0, settings.menuHeight)
	if isMenuOpen then
		mainFrame.Visible = true
		mainFrame.Size = UDim2.new(0, targetSize.X.Offset, 0, 0)
		tweenService:Create(mainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
			Size = targetSize
		}):Play()
	else
		local closeTween = tweenService:Create(mainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
			Size = UDim2.new(0, targetSize.X.Offset, 0, 0)
		})
		closeTween:Play()
		closeTween.Completed:Connect(function()
			if not isMenuOpen then mainFrame.Visible = false end
		end)
	end
end

makeDraggable(hudFrame, hudFrame, toggleMenu)

userInputService.InputBegan:Connect(function(input, gpe)
	if listeningKeybind then
		if input.UserInputType == Enum.UserInputType.Keyboard then
			if input.KeyCode == Enum.KeyCode.Escape or input.KeyCode == Enum.KeyCode.Backspace then
				listeningKeybind.set(Enum.KeyCode.Unknown, "[None]")
			else
				listeningKeybind.set(input.KeyCode, "[" .. input.KeyCode.Name .. "]")
			end
			listeningKeybind = nil
			refreshKeybindsHud()
		end
		return
	end

	if not gpe and input.UserInputType == Enum.UserInputType.Keyboard then
		if input.KeyCode == settings.menuKeybind or input.KeyCode == Enum.KeyCode.RightControl then
			toggleMenu()
			return
		end

		for _, item in pairs(keybindRegistry) do
			if item.key and item.key == input.KeyCode and item.trigger then
				item.trigger()
			end
		end
	end
end)

local brandHeader = Instance.new("Frame", sidebar)
brandHeader.Size = UDim2.new(1, 0, 0, 48)
brandHeader.BackgroundTransparency = 1

local brandLabel = Instance.new("TextLabel", brandHeader)
brandLabel.Size = UDim2.new(1, -20, 1, 0)
brandLabel.Position = UDim2.new(0, 16, 0, 0)
brandLabel.BackgroundTransparency = 1
brandLabel.Font = Enum.Font.GothamBold
brandLabel.Text = "ANXIUM"
brandLabel.TextColor3 = colors.textPrimary
brandLabel.TextSize = 16
brandLabel.TextXAlignment = Enum.TextXAlignment.Left

local brandShine = Instance.new("UIGradient", brandLabel)
brandShine.Color = ColorSequence.new({
	ColorSequenceKeypoint.new(0, Color3.fromRGB(240, 238, 245)),
	ColorSequenceKeypoint.new(0.5, Color3.fromRGB(220, 165, 255)),
	ColorSequenceKeypoint.new(1, Color3.fromRGB(240, 238, 245))
})

task.spawn(function()
	local offset = -1
	while screenGui.Parent do
		offset = offset + 0.035
		if offset > 1 then offset = -1 end
		brandShine.Offset = Vector2.new(offset, 0)
		task.wait(0.03)
	end
end)

local brandBadge = Instance.new("TextLabel", brandHeader)
brandBadge.Size = UDim2.new(0, 30, 0, 15)
brandBadge.Position = UDim2.new(1, -44, 0.5, -8)
brandBadge.BackgroundColor3 = colors.accentSubtle
brandBadge.Font = Enum.Font.RobotoMono
brandBadge.Text = "PC"
brandBadge.TextColor3 = colors.accent
brandBadge.TextSize = 9
local badgeCorner = Instance.new("UICorner", brandBadge)
badgeCorner.CornerRadius = UDim.new(0, 3)

local tabList = Instance.new("ScrollingFrame", sidebar)
tabList.Size = UDim2.new(1, -12, 1, -114)
tabList.Position = UDim2.new(0, 6, 0, 48)
tabList.BackgroundTransparency = 1
tabList.ScrollBarThickness = 0

local tabListLayout = Instance.new("UIListLayout", tabList)
tabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
tabListLayout.Padding = UDim.new(0, 3)

local profileCard = Instance.new("Frame", sidebar)
profileCard.Size = UDim2.new(1, -12, 0, 52)
profileCard.Position = UDim2.new(0, 6, 1, -58)
profileCard.BackgroundColor3 = colors.cardBg
profileCard.ClipsDescendants = true
local pcCorner = Instance.new("UICorner", profileCard)
pcCorner.CornerRadius = UDim.new(0, 6)
local pcStroke = Instance.new("UIStroke", profileCard)
pcStroke.Color = colors.border
pcStroke.Thickness = 1

local avatarImg = Instance.new("ImageLabel", profileCard)
avatarImg.Size = UDim2.new(0, 36, 0, 36)
avatarImg.Position = UDim2.new(0, 8, 0.5, -18)
avatarImg.BackgroundTransparency = 1
local avCorner = Instance.new("UICorner", avatarImg)
avCorner.CornerRadius = UDim.new(1, 0)

task.spawn(function()
	local success, content = pcall(function()
		return playersService:GetUserThumbnailAsync(localPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
	end)
	if success and content and content ~= "" then
		avatarImg.Image = content
	else
		avatarImg.Image = "rbxthumb://type=AvatarHeadShot&id=" .. tostring(localPlayer.UserId) .. "&w=100&h=100"
	end
end)

local userDisplayName = Instance.new("TextLabel", profileCard)
userDisplayName.Size = UDim2.new(1, -52, 0, 16)
userDisplayName.Position = UDim2.new(0, 48, 0, 10)
userDisplayName.BackgroundTransparency = 1
userDisplayName.Font = Enum.Font.GothamBold
userDisplayName.Text = localPlayer.DisplayName
userDisplayName.TextColor3 = colors.textPrimary
userDisplayName.TextScaled = true
userDisplayName.TextXAlignment = Enum.TextXAlignment.Left

local nameConstraint = Instance.new("UITextSizeConstraint", userDisplayName)
nameConstraint.MaxTextSize = 11
nameConstraint.MinTextSize = 8

local creationDate = os.date("%d.%m.%Y", os.time() - (localPlayer.AccountAge * 86400))
local userDateLabel = Instance.new("TextLabel", profileCard)
userDateLabel.Size = UDim2.new(1, -52, 0, 12)
userDateLabel.Position = UDim2.new(0, 48, 0, 26)
userDateLabel.BackgroundTransparency = 1
userDateLabel.Font = Enum.Font.RobotoMono
userDateLabel.Text = creationDate
userDateLabel.TextColor3 = colors.textMuted
userDateLabel.TextSize = 9
userDateLabel.TextXAlignment = Enum.TextXAlignment.Left

local contentFrame = Instance.new("Frame", mainFrame)
contentFrame.Size = UDim2.new(1, -174, 1, -20)
contentFrame.Position = UDim2.new(0, 166, 0, 10)
contentFrame.BackgroundTransparency = 1

local tabsConfig = {
	{ name = "Combat", icon = iconMap["Combat"] },
	{ name = "Visuals", icon = iconMap["Visuals"] },
	{ name = "Misc", icon = iconMap["Misc"] },
	{ name = "Troll", icon = iconMap["Troll"] },
	{ name = "Bundles", icon = iconMap["Bundles"] },
	{ name = "Config", icon = iconMap["Config"] },
	{ name = "Settings", icon = iconMap["Settings"] }
}

local tabObjects = {}
local tabPages = {}
local activeTab = nil

for _, tabData in ipairs(tabsConfig) do
	local tabName = tabData.name

	local page = Instance.new("ScrollingFrame", contentFrame)
	page.Name = tabName .. "Page"
	page.Size = UDim2.new(1, 0, 1, 0)
	page.BackgroundTransparency = 1
	page.ScrollBarThickness = 3
	page.ScrollBarImageColor3 = colors.borderActive
	page.ScrollBarImageTransparency = 0.4
	page.AutomaticCanvasSize = Enum.AutomaticSize.Y
	page.CanvasSize = UDim2.new(0, 0, 0, 0)
	page.Visible = false

	local pagePad = Instance.new("UIPadding", page)
	pagePad.PaddingTop = UDim.new(0, 2)
	pagePad.PaddingBottom = UDim.new(0, 35)
	pagePad.PaddingLeft = UDim.new(0, 6)
	pagePad.PaddingRight = UDim.new(0, 12)

	local layout = Instance.new("UIListLayout", page)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	layout.Padding = UDim.new(0, 7)

	local pageHeader = Instance.new("Frame", page)
	pageHeader.Size = UDim2.new(1, 0, 0, 24)
	pageHeader.BackgroundTransparency = 1

	local headerLabel = Instance.new("TextLabel", pageHeader)
	headerLabel.Size = UDim2.new(1, 0, 1, 0)
	headerLabel.BackgroundTransparency = 1
	headerLabel.Font = Enum.Font.RobotoMono
	headerLabel.Text = "-- " .. tabName .. " --"
	headerLabel.TextColor3 = colors.textMuted
	headerLabel.TextSize = 11
	headerLabel.TextXAlignment = Enum.TextXAlignment.Left

	tabPages[tabName] = page

	local tabBtn = Instance.new("TextButton", tabList)
	tabBtn.Name = tabName .. "Tab"
	tabBtn.Size = UDim2.new(1, 0, 0, 27)
	tabBtn.BackgroundColor3 = Color3.fromRGB(14, 13, 19)
	tabBtn.BackgroundTransparency = 1
	tabBtn.Text = ""
	tabBtn.AutoButtonColor = false

	local tabCorner = Instance.new("UICorner", tabBtn)
	tabCorner.CornerRadius = UDim.new(0, 5)

	local indicator = Instance.new("Frame", tabBtn)
	indicator.Size = UDim2.new(0, 2, 0, 14)
	indicator.Position = UDim2.new(0, 0, 0.5, -7)
	indicator.BackgroundColor3 = colors.accent
	indicator.BackgroundTransparency = 1
	indicator.BorderSizePixel = 0

	local tabIcon = Instance.new("ImageLabel", tabBtn)
	tabIcon.Size = UDim2.new(0, 14, 0, 14)
	tabIcon.Position = UDim2.new(0, 8, 0.5, -7)
	tabIcon.BackgroundTransparency = 1
	tabIcon.Image = tabData.icon
	tabIcon.ImageColor3 = colors.textSecondary

	local tabText = Instance.new("TextLabel", tabBtn)
	tabText.Size = UDim2.new(1, -30, 1, 0)
	tabText.Position = UDim2.new(0, 28, 0, 0)
	tabText.BackgroundTransparency = 1
	tabText.Font = Enum.Font.GothamMedium
	tabText.Text = tabName
	tabText.TextColor3 = colors.textSecondary
	tabText.TextSize = 11
	tabText.TextXAlignment = Enum.TextXAlignment.Left

	tabObjects[tabName] = {
		btn = tabBtn,
		icon = tabIcon,
		text = tabText,
		indicator = indicator,
	}

	tabBtn.MouseEnter:Connect(function()
		if activeTab ~= tabName then
			tweenService:Create(tabBtn, TweenInfo.new(0.15), { BackgroundTransparency = 0.5 }):Play()
			tweenService:Create(tabText, TweenInfo.new(0.15), { TextColor3 = colors.textPrimary }):Play()
			tweenService:Create(tabIcon, TweenInfo.new(0.15), { ImageColor3 = colors.textPrimary }):Play()
		end
	end)

	tabBtn.MouseLeave:Connect(function()
		if activeTab ~= tabName then
			tweenService:Create(tabBtn, TweenInfo.new(0.15), { BackgroundTransparency = 1 }):Play()
			tweenService:Create(tabText, TweenInfo.new(0.15), { TextColor3 = colors.textSecondary }):Play()
			tweenService:Create(tabIcon, TweenInfo.new(0.15), { ImageColor3 = colors.textSecondary }):Play()
		end
	end)
end

local isSwitchingTab = false

local function selectTab(tabName)
	if activeTab == tabName or isSwitchingTab then return end
	isSwitchingTab = true

	activeTab = tabName

	for name, item in pairs(tabObjects) do
		local isCurrent = (name == tabName)
		local targetColor = isCurrent and colors.textPrimary or colors.textSecondary
		local targetIcon = isCurrent and colors.accent or colors.textSecondary
		local targetIndicator = isCurrent and 0 or 1
		local targetBg = isCurrent and 0.2 or 1

		tweenService:Create(item.btn, TweenInfo.new(0.2), { BackgroundTransparency = targetBg, BackgroundColor3 = colors.cardHover }):Play()
		tweenService:Create(item.text, TweenInfo.new(0.2), { TextColor3 = targetColor }):Play()
		tweenService:Create(item.icon, TweenInfo.new(0.2), { ImageColor3 = targetIcon }):Play()
		tweenService:Create(item.indicator, TweenInfo.new(0.2), { BackgroundTransparency = targetIndicator }):Play()
	end

	for name, page in pairs(tabPages) do
		page.Visible = (name == tabName)
	end
	isSwitchingTab = false
end

for name, item in pairs(tabObjects) do
	item.btn.Activated:Connect(function()
		selectTab(name)
	end)
end

selectTab("Visuals")

local activePickerModal = nil

local function openAdvancedColorPicker(titleText, initialColor, triggerBtn, onChanged)
	if activePickerModal then
		activePickerModal:Destroy()
		activePickerModal = nil
	end

	local curR = math.floor(initialColor.R * 255)
	local curG = math.floor(initialColor.G * 255)
	local curB = math.floor(initialColor.B * 255)

	local modal = Instance.new("Frame", screenGui)
	modal.Name = "AdvancedColorPickerModal"
	modal.Size = UDim2.new(0, 480, 0, 310)
	modal.Position = UDim2.new(0.5, -240, 0.5, -155)
	modal.BackgroundColor3 = colors.bgDark
	modal.BorderSizePixel = 0
	modal.ZIndex = 120

	local mCorner = Instance.new("UICorner", modal)
	mCorner.CornerRadius = UDim.new(0, 10)
	local mStroke = Instance.new("UIStroke", modal)
	mStroke.Color = colors.borderActive
	mStroke.Thickness = 1.4

	local header = Instance.new("Frame", modal)
	header.Size = UDim2.new(1, 0, 0, 32)
	header.BackgroundColor3 = colors.sidebarBg
	header.ZIndex = 121
	local hCorn = Instance.new("UICorner", header)
	hCorn.CornerRadius = UDim.new(0, 10)

	local titleLbl = Instance.new("TextLabel", header)
	titleLbl.Size = UDim2.new(1, -40, 1, 0)
	titleLbl.Position = UDim2.new(0, 12, 0, 0)
	titleLbl.BackgroundTransparency = 1
	titleLbl.Font = Enum.Font.GothamBold
	titleLbl.Text = "COLOR CONFIG & ESP PREVIEW - " .. string.upper(titleText)
	titleLbl.TextColor3 = colors.textPrimary
	titleLbl.TextSize = 11
	titleLbl.TextXAlignment = Enum.TextXAlignment.Left
	titleLbl.ZIndex = 122

	local closeBtn = Instance.new("TextButton", header)
	closeBtn.Size = UDim2.new(0, 24, 0, 24)
	closeBtn.Position = UDim2.new(1, -28, 0.5, -12)
	closeBtn.BackgroundColor3 = colors.accentSubtle
	closeBtn.Font = Enum.Font.GothamBold
	closeBtn.Text = "✕"
	closeBtn.TextColor3 = colors.textPrimary
	closeBtn.TextSize = 11
	closeBtn.ZIndex = 122
	local ccb = Instance.new("UICorner", closeBtn)
	ccb.CornerRadius = UDim.new(0, 4)

	local previewSection = Instance.new("Frame", modal)
	previewSection.Size = UDim2.new(0, 190, 0, 255)
	previewSection.Position = UDim2.new(1, -202, 0, 42)
	previewSection.BackgroundColor3 = colors.cardBg
	previewSection.ZIndex = 121
	local psCorn = Instance.new("UICorner", previewSection)
	psCorn.CornerRadius = UDim.new(0, 8)
	local psStroke = Instance.new("UIStroke", previewSection)
	psStroke.Color = colors.border
	psStroke.Thickness = 1

	local pHeader = Instance.new("TextLabel", previewSection)
	pHeader.Size = UDim2.new(1, 0, 0, 20)
	pHeader.Position = UDim2.new(0, 0, 0, 4)
	pHeader.BackgroundTransparency = 1
	pHeader.Font = Enum.Font.RobotoMono
	pHeader.Text = "LIVE ESP PREVIEW"
	pHeader.TextColor3 = colors.textSecondary
	pHeader.TextSize = 9
	pHeader.ZIndex = 122

	local pRole = Instance.new("TextLabel", previewSection)
	pRole.Size = UDim2.new(0, 90, 0, 14)
	pRole.Position = UDim2.new(0.5, -45, 0, 28)
	pRole.BackgroundTransparency = 1
	pRole.Font = Enum.Font.GothamBold
	pRole.Text = "TARGET"
	pRole.TextColor3 = initialColor
	pRole.TextSize = 10
	pRole.ZIndex = 123

	local pBox = Instance.new("Frame", previewSection)
	pBox.Size = UDim2.new(0, 84, 0, 130)
	pBox.Position = UDim2.new(0.5, -42, 0, 46)
	pBox.BackgroundTransparency = 0.8
	pBox.BackgroundColor3 = initialColor
	pBox.BorderSizePixel = 0
	pBox.ZIndex = 122
	local pbStroke = Instance.new("UIStroke", pBox)
	pbStroke.Color = initialColor
	pbStroke.Thickness = 1.2

	local pHpTrack = Instance.new("Frame", previewSection)
	pHpTrack.Size = UDim2.new(0, 3, 0, 130)
	pHpTrack.Position = UDim2.new(0.5, -48, 0, 46)
	pHpTrack.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
	pHpTrack.BorderSizePixel = 0
	pHpTrack.ZIndex = 123
	local pHp = Instance.new("Frame", pHpTrack)
	pHp.Size = UDim2.new(1, 0, 0.75, 0)
	pHp.Position = UDim2.new(0, 0, 0.25, 0)
	pHp.BackgroundColor3 = Color3.fromRGB(55, 225, 105)
	pHp.BorderSizePixel = 0
	pHp.ZIndex = 124

	local pSkelHead = Instance.new("Frame", pBox)
	pSkelHead.Size = UDim2.new(0, 14, 0, 14)
	pSkelHead.Position = UDim2.new(0.5, -7, 0, 8)
	pSkelHead.BackgroundColor3 = initialColor
	pSkelHead.BorderSizePixel = 0
	pSkelHead.ZIndex = 124
	local shc = Instance.new("UICorner", pSkelHead)
	shc.CornerRadius = UDim.new(1, 0)

	local pSpine = Instance.new("Frame", pBox)
	pSpine.Size = UDim2.new(0, 2, 0, 38)
	pSpine.Position = UDim2.new(0.5, -1, 0, 24)
	pSpine.BackgroundColor3 = initialColor
	pSpine.BorderSizePixel = 0
	pSpine.ZIndex = 124

	local pDist = Instance.new("TextLabel", previewSection)
	pDist.Size = UDim2.new(0, 90, 0, 14)
	pDist.Position = UDim2.new(0.5, -45, 0, 180)
	pDist.BackgroundTransparency = 1
	pDist.Font = Enum.Font.RobotoMono
	pDist.Text = "[18m]"
	pDist.TextColor3 = initialColor
	pDist.TextSize = 10
	pDist.ZIndex = 123

	local pSnap = Instance.new("Frame", previewSection)
	pSnap.Size = UDim2.new(0, 1.2, 0, 45)
	pSnap.Position = UDim2.new(0.5, -0.6, 0, 202)
	pSnap.BackgroundColor3 = initialColor
	pSnap.BorderSizePixel = 0
	pSnap.ZIndex = 123

	local controlsSection = Instance.new("Frame", modal)
	controlsSection.Size = UDim2.new(0, 255, 0, 255)
	controlsSection.Position = UDim2.new(0, 12, 0, 42)
	controlsSection.BackgroundTransparency = 1
	controlsSection.ZIndex = 121

	local swatchRow = Instance.new("Frame", controlsSection)
	swatchRow.Size = UDim2.new(1, 0, 0, 60)
	swatchRow.BackgroundTransparency = 1
	swatchRow.ZIndex = 122
	local swLayout = Instance.new("UIGridLayout", swatchRow)
	swLayout.CellSize = UDim2.new(0, 26, 0, 26)
	swLayout.CellPadding = UDim2.new(0, 6, 0, 6)

	local presets = {
		Color3.fromRGB(255, 255, 255), Color3.fromRGB(240, 50, 60),
		Color3.fromRGB(55, 130, 255), Color3.fromRGB(55, 215, 115),
		Color3.fromRGB(250, 205, 45), Color3.fromRGB(180, 90, 255),
		Color3.fromRGB(255, 105, 180), Color3.fromRGB(0, 255, 255),
		Color3.fromRGB(255, 140, 0), Color3.fromRGB(140, 100, 220),
		Color3.fromRGB(45, 200, 200), Color3.fromRGB(200, 200, 200)
	}

	local function updateColor(newColor)
		curR = math.floor(newColor.R * 255)
		curG = math.floor(newColor.G * 255)
		curB = math.floor(newColor.B * 255)

		pRole.TextColor3 = newColor
		pBox.BackgroundColor3 = newColor
		pbStroke.Color = newColor
		pSkelHead.BackgroundColor3 = newColor
		pSpine.BackgroundColor3 = newColor
		pDist.TextColor3 = newColor
		pSnap.BackgroundColor3 = newColor

		triggerBtn.BackgroundColor3 = newColor
		if onChanged then onChanged(newColor) end
	end

	for _, col in ipairs(presets) do
		local swBtn = Instance.new("TextButton", swatchRow)
		swBtn.BackgroundColor3 = col
		swBtn.Text = ""
		swBtn.AutoButtonColor = false
		swBtn.ZIndex = 123
		local sc = Instance.new("UICorner", swBtn)
		sc.CornerRadius = UDim.new(0, 4)
		swBtn.Activated:Connect(function()
			updateColor(col)
		end)
	end

	local function createSliderRow(labelName, initVal, yPos, onChangeVal)
		local row = Instance.new("Frame", controlsSection)
		row.Size = UDim2.new(1, 0, 0, 34)
		row.Position = UDim2.new(0, 0, 0, yPos)
		row.BackgroundColor3 = colors.cardBg
		row.ZIndex = 122
		local rc = Instance.new("UICorner", row)
		rc.CornerRadius = UDim.new(0, 6)

		local rLbl = Instance.new("TextLabel", row)
		rLbl.Size = UDim2.new(0, 32, 1, 0)
		rLbl.Position = UDim2.new(0, 8, 0, 0)
		rLbl.BackgroundTransparency = 1
		rLbl.Font = Enum.Font.RobotoMono
		rLbl.Text = labelName
		rLbl.TextColor3 = colors.textPrimary
		rLbl.TextSize = 10
		rLbl.TextXAlignment = Enum.TextXAlignment.Left
		rLbl.ZIndex = 123

		local valBox = Instance.new("TextBox", row)
		valBox.Size = UDim2.new(0, 42, 0, 22)
		valBox.Position = UDim2.new(1, -50, 0.5, -11)
		valBox.BackgroundColor3 = colors.sidebarBg
		valBox.Font = Enum.Font.RobotoMono
		valBox.Text = tostring(initVal)
		valBox.TextColor3 = colors.textPrimary
		valBox.TextSize = 10
		valBox.ZIndex = 123
		local vbc = Instance.new("UICorner", valBox)
		vbc.CornerRadius = UDim.new(0, 4)

		valBox.FocusLost:Connect(function()
			local num = tonumber(valBox.Text)
			if num then
				num = math.clamp(math.floor(num), 0, 255)
				valBox.Text = tostring(num)
				onChangeVal(num)
			else
				valBox.Text = tostring(initVal)
			end
		end)
	end

	createSliderRow("R:", curR, 70, function(n)
		curR = n
		updateColor(Color3.fromRGB(curR, curG, curB))
	end)

	createSliderRow("G:", curG, 112, function(n)
		curG = n
		updateColor(Color3.fromRGB(curR, curG, curB))
	end)

	createSliderRow("B:", curB, 154, function(n)
		curB = n
		updateColor(Color3.fromRGB(curR, curG, curB))
	end)

	local applyBtn = Instance.new("TextButton", controlsSection)
	applyBtn.Size = UDim2.new(1, 0, 0, 32)
	applyBtn.Position = UDim2.new(0, 0, 0, 204)
	applyBtn.BackgroundColor3 = colors.accent
	applyBtn.Font = Enum.Font.GothamBold
	applyBtn.Text = "APPLY & CLOSE"
	applyBtn.TextColor3 = colors.textPrimary
	applyBtn.TextSize = 11
	applyBtn.ZIndex = 123
	local abc = Instance.new("UICorner", applyBtn)
	abc.CornerRadius = UDim.new(0, 6)

	local function closeModal()
		if modal and modal.Parent then
			modal:Destroy()
			activePickerModal = nil
		end
	end

	closeBtn.Activated:Connect(closeModal)
	applyBtn.Activated:Connect(closeModal)

	activePickerModal = modal
end

local function createToggle(parent, titleText, descText, initial, callback, colorConfig)
	local active = initial
	activeTogglesRegistry[titleText] = initial

	local card = Instance.new("Frame", parent)
	card.Size = UDim2.new(1, 0, 0, 42)
	card.BackgroundColor3 = colors.cardBg

	local corner = Instance.new("UICorner", card)
	corner.CornerRadius = UDim.new(0, 6)
	local stroke = Instance.new("UIStroke", card)
	stroke.Color = colors.border
	stroke.Thickness = 1

	local label = Instance.new("TextLabel", card)
	label.Size = UDim2.new(0.55, 0, 0, 16)
	label.Position = UDim2.new(0, 10, 0, 6)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamMedium
	label.Text = titleText
	label.TextColor3 = colors.textPrimary
	label.TextSize = 11
	label.TextXAlignment = Enum.TextXAlignment.Left

	local subLabel = Instance.new("TextLabel", card)
	subLabel.Size = UDim2.new(0.55, 0, 0, 12)
	subLabel.Position = UDim2.new(0, 10, 0, 22)
	subLabel.BackgroundTransparency = 1
	subLabel.Font = Enum.Font.Gotham
	subLabel.Text = descText
	subLabel.TextColor3 = colors.textMuted
	subLabel.TextSize = 9
	subLabel.TextXAlignment = Enum.TextXAlignment.Left

	local keybindBtn = Instance.new("TextButton", card)
	keybindBtn.Size = UDim2.new(0, 44, 0, 18)
	keybindBtn.Position = UDim2.new(1, -94, 0.5, -9)
	keybindBtn.BackgroundColor3 = colors.sidebarBg
	keybindBtn.Font = Enum.Font.RobotoMono
	keybindBtn.Text = "[None]"
	keybindBtn.TextColor3 = colors.textSecondary
	keybindBtn.TextSize = 9
	keybindBtn.ZIndex = 15
	local kCorner = Instance.new("UICorner", keybindBtn)
	kCorner.CornerRadius = UDim.new(0, 4)
	local kStroke = Instance.new("UIStroke", keybindBtn)
	kStroke.Color = colors.border
	kStroke.Thickness = 1

	local switchBtn = Instance.new("TextButton", card)
	switchBtn.Name = "ToggleSwitchBtn"
	switchBtn.Size = UDim2.new(0, 36, 0, 20)
	switchBtn.Position = UDim2.new(1, -44, 0.5, -10)
	switchBtn.BackgroundColor3 = active and colors.accent or colors.accentSubtle
	switchBtn.Text = ""
	switchBtn.AutoButtonColor = false
	switchBtn.ZIndex = 20

	local sCorner = Instance.new("UICorner", switchBtn)
	sCorner.CornerRadius = UDim.new(1, 0)

	local switchThumb = Instance.new("Frame", switchBtn)
	switchThumb.Size = UDim2.new(0, 14, 0, 14)
	switchThumb.Position = active and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
	switchThumb.BackgroundColor3 = colors.textPrimary
	switchThumb.Active = false
	switchThumb.ZIndex = 21

	local tCorner = Instance.new("UICorner", switchThumb)
	tCorner.CornerRadius = UDim.new(1, 0)

	local leftBoundOffset = colorConfig and -122 or -98
	local cardClickArea = Instance.new("TextButton", card)
	cardClickArea.Size = UDim2.new(1, leftBoundOffset, 1, 0)
	cardClickArea.BackgroundTransparency = 1
	cardClickArea.Text = ""
	cardClickArea.ZIndex = 5

	local function toggleState()
		active = not active
		activeTogglesRegistry[titleText] = active
		refreshActiveHud()

		local targetColor = active and colors.accent or colors.accentSubtle
		local targetPos = active and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)

		tweenService:Create(switchBtn, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { BackgroundColor3 = targetColor }):Play()
		tweenService:Create(switchThumb, TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), { Position = targetPos }):Play()
		callback(active)
	end

	keybindRegistry[titleText] = {
		key = Enum.KeyCode.Unknown,
		trigger = toggleState
	}

	keybindBtn.Activated:Connect(function()
		keybindBtn.Text = "[...]"
		listeningKeybind = {
			set = function(newKey, labelText)
				keybindRegistry[titleText].key = newKey
				keybindBtn.Text = labelText
			end
		}
	end)

	if colorConfig then
		local colorBtn = Instance.new("TextButton", card)
		colorBtn.Size = UDim2.new(0, 18, 0, 18)
		colorBtn.Position = UDim2.new(1, -120, 0.5, -9)
		colorBtn.BackgroundColor3 = colorConfig.initialColor
		colorBtn.Text = ""
		colorBtn.AutoButtonColor = false
		colorBtn.ZIndex = 15

		local cCorner = Instance.new("UICorner", colorBtn)
		cCorner.CornerRadius = UDim.new(0, 4)
		local cStroke = Instance.new("UIStroke", colorBtn)
		cStroke.Color = colors.border
		cStroke.Thickness = 1

		colorBtn.Activated:Connect(function()
			openAdvancedColorPicker(titleText, colorConfig.initialColor, colorBtn, colorConfig.onChanged)
		end)
	end

	local function onHoverEnter()
		tweenService:Create(card, TweenInfo.new(0.15), { BackgroundColor3 = colors.cardHover }):Play()
		tweenService:Create(stroke, TweenInfo.new(0.15), { Color = active and colors.borderActive or colors.border }):Play()
	end

	local function onHoverLeave()
		tweenService:Create(card, TweenInfo.new(0.15), { BackgroundColor3 = colors.cardBg }):Play()
		tweenService:Create(stroke, TweenInfo.new(0.15), { Color = colors.border }):Play()
	end

	cardClickArea.MouseEnter:Connect(onHoverEnter)
	cardClickArea.MouseLeave:Connect(onHoverLeave)
	switchBtn.MouseEnter:Connect(onHoverEnter)
	switchBtn.MouseLeave:Connect(onHoverLeave)

	cardClickArea.Activated:Connect(toggleState)
	switchBtn.Activated:Connect(toggleState)
end

local function createTextInput(parent, titleText, descText, placeholder, callback)
	local card = Instance.new("Frame", parent)
	card.Size = UDim2.new(1, 0, 0, 42)
	card.BackgroundColor3 = colors.cardBg

	local corner = Instance.new("UICorner", card)
	corner.CornerRadius = UDim.new(0, 6)
	local stroke = Instance.new("UIStroke", card)
	stroke.Color = colors.border
	stroke.Thickness = 1

	local label = Instance.new("TextLabel", card)
	label.Size = UDim2.new(0.55, 0, 0, 16)
	label.Position = UDim2.new(0, 10, 0, 6)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamMedium
	label.Text = titleText
	label.TextColor3 = colors.textPrimary
	label.TextSize = 11
	label.TextXAlignment = Enum.TextXAlignment.Left

	local subLabel = Instance.new("TextLabel", card)
	subLabel.Size = UDim2.new(0.55, 0, 0, 12)
	subLabel.Position = UDim2.new(0, 10, 0, 22)
	subLabel.BackgroundTransparency = 1
	subLabel.Font = Enum.Font.Gotham
	subLabel.Text = descText
	subLabel.TextColor3 = colors.textMuted
	subLabel.TextSize = 9
	subLabel.TextXAlignment = Enum.TextXAlignment.Left

	local textBox = Instance.new("TextBox", card)
	textBox.Size = UDim2.new(0, 85, 0, 24)
	textBox.Position = UDim2.new(1, -95, 0.5, -12)
	textBox.BackgroundColor3 = colors.sidebarBg
	textBox.Font = Enum.Font.RobotoMono
	textBox.PlaceholderText = placeholder
	textBox.PlaceholderColor3 = colors.textMuted
	textBox.Text = ""
	textBox.TextColor3 = colors.textPrimary
	textBox.TextSize = 11
	textBox.ClearTextOnFocus = false

	local boxCorner = Instance.new("UICorner", textBox)
	boxCorner.CornerRadius = UDim.new(0, 4)
	local boxStroke = Instance.new("UIStroke", textBox)
	boxStroke.Color = colors.border
	boxStroke.Thickness = 1

	textBox.FocusLost:Connect(function()
		callback(textBox.Text)
	end)
end

local function createActionBtn(parent, titleText, descText, callback)
	local card = Instance.new("Frame", parent)
	card.Size = UDim2.new(1, 0, 0, 38)
	card.BackgroundColor3 = colors.cardBg

	local corner = Instance.new("UICorner", card)
	corner.CornerRadius = UDim.new(0, 6)
	local stroke = Instance.new("UIStroke", card)
	stroke.Color = colors.border
	stroke.Thickness = 1

	local label = Instance.new("TextLabel", card)
	label.Size = UDim2.new(0.7, 0, 0, 16)
	label.Position = UDim2.new(0, 10, 0, 4)
	label.BackgroundTransparency = 1
	label.Font = Enum.Font.GothamMedium
	label.Text = titleText
	label.TextColor3 = colors.textPrimary
	label.TextSize = 11
	label.TextXAlignment = Enum.TextXAlignment.Left

	local subLabel = Instance.new("TextLabel", card)
	subLabel.Size = UDim2.new(0.7, 0, 0, 12)
	subLabel.Position = UDim2.new(0, 10, 0, 20)
	subLabel.BackgroundTransparency = 1
	subLabel.Font = Enum.Font.Gotham
	subLabel.Text = descText
	subLabel.TextColor3 = colors.textMuted
	subLabel.TextSize = 9
	subLabel.TextXAlignment = Enum.TextXAlignment.Left

	local applyBtn = Instance.new("TextButton", card)
	applyBtn.Size = UDim2.new(0, 52, 0, 22)
	applyBtn.Position = UDim2.new(1, -60, 0.5, -11)
	applyBtn.BackgroundColor3 = colors.accentSubtle
	applyBtn.Font = Enum.Font.GothamBold
	applyBtn.Text = "Action"
	applyBtn.TextColor3 = colors.accent
	applyBtn.TextSize = 10

	local bCorner = Instance.new("UICorner", applyBtn)
	bCorner.CornerRadius = UDim.new(0, 4)

	applyBtn.Activated:Connect(function()
		applyBtn.Text = "Done!"
		callback()
		task.delay(0.6, function()
			applyBtn.Text = "Action"
		end)
	end)
end

local function createSectionFolder(parent, titleText, startOpen)
	local isOpen = startOpen ~= false

	local section = Instance.new("Frame", parent)
	section.Name = titleText:gsub("%s+", "") .. "Section"
	section.Size = UDim2.new(1, 0, 0, 0)
	section.BackgroundTransparency = 1
	section.AutomaticSize = Enum.AutomaticSize.Y

	local secLayout = Instance.new("UIListLayout", section)
	secLayout.SortOrder = Enum.SortOrder.LayoutOrder
	secLayout.Padding = UDim.new(0, 4)

	local headerBtn = Instance.new("TextButton", section)
	headerBtn.Size = UDim2.new(1, 0, 0, 24)
	headerBtn.BackgroundColor3 = colors.cardBg
	headerBtn.Text = ""
	headerBtn.AutoButtonColor = false
	headerBtn.LayoutOrder = 0

	local hCorner = Instance.new("UICorner", headerBtn)
	hCorner.CornerRadius = UDim.new(0, 5)
	local hStroke = Instance.new("UIStroke", headerBtn)
	hStroke.Color = colors.border
	hStroke.Thickness = 1

	local hTitle = Instance.new("TextLabel", headerBtn)
	hTitle.Size = UDim2.new(1, -30, 1, 0)
	hTitle.Position = UDim2.new(0, 8, 0, 0)
	hTitle.BackgroundTransparency = 1
	hTitle.Font = Enum.Font.GothamBold
	hTitle.Text = string.upper(titleText)
	hTitle.TextColor3 = colors.accent
	hTitle.TextSize = 10
	hTitle.TextXAlignment = Enum.TextXAlignment.Left

	local arrowLbl = Instance.new("TextLabel", headerBtn)
	arrowLbl.Size = UDim2.new(0, 20, 1, 0)
	arrowLbl.Position = UDim2.new(1, -22, 0, 0)
	arrowLbl.BackgroundTransparency = 1
	arrowLbl.Font = Enum.Font.GothamBold
	arrowLbl.Text = isOpen and "▼" or "▶"
	arrowLbl.TextColor3 = colors.textSecondary
	arrowLbl.TextSize = 9

	local contentContainer = Instance.new("Frame", section)
	contentContainer.Name = "Container"
	contentContainer.Size = UDim2.new(1, 0, 0, 0)
	contentContainer.BackgroundTransparency = 1
	contentContainer.AutomaticSize = Enum.AutomaticSize.Y
	contentContainer.Visible = isOpen
	contentContainer.LayoutOrder = 1

	local contentLayout = Instance.new("UIListLayout", contentContainer)
	contentLayout.SortOrder = Enum.SortOrder.LayoutOrder
	contentLayout.Padding = UDim.new(0, 4)

	headerBtn.Activated:Connect(function()
		isOpen = not isOpen
		contentContainer.Visible = isOpen
		arrowLbl.Text = isOpen and "▼" or "▶"
	end)

	return contentContainer
end

local combatPage = tabPages["Combat"]
local fAimbot = createSectionFolder(combatPage, "Aimbot Systems", true)
local fCombatUtil = createSectionFolder(combatPage, "Combat Utilities", true)

createToggle(fAimbot, "Universal Silent Aim v2", "Redirects shots within FOV to target", settings.silentAim, function(v)
	settings.silentAim = v
end)

createToggle(fAimbot, "Auto Shoot Murderer", "Экипирует пистолет и стреляет в голову Мардеру", settings.autoShootMurderer, function(v)
	settings.autoShootMurderer = v
end)

createToggle(fAimbot, "Blox Silent Aim", "BloxStrike", false, function(v)
	settings.bloxSilentAim = v
	bloxSilent.Enabled = v
end)

createToggle(fAimbot, "No Recoil", "BloxStrike", false, function(v)
	settings.bloxNoRecoil = v
end)

createToggle(fAimbot, "No Spread", "BloxStrike", false, function(v)
	settings.bloxNoSpread = v
end)

createToggle(fAimbot, "Wall Bang", "Works without silent", false, function(v)
	settings.bloxWallBang = v
end)

createToggle(fAimbot, "Spin Bot", "BloxStrike", false, function(v)
	settings.bloxSpinBot = v
end)

createActionBtn(fAimbot, "Silent Aim Bone: Head", "Locks ray destinations directly onto Head", function()
	settings.silentAimTargetPart = "Head"
end)

createActionBtn(fAimbot, "Silent Aim Bone: Torso", "Locks ray destinations onto HumanoidRootPart", function()
	settings.silentAimTargetPart = "HumanoidRootPart"
end)

createToggle(fAimbot, "Show FOV Circle", "Displays lock-on radius ring following mouse", settings.showFov, function(v)
	settings.showFov = v
	fovCircleFrame.Visible = v
end)

createToggle(fCombatUtil, "Kill Flash", "Screen flashes on confirmed target elimination", settings.killFlash, function(v)
	settings.killFlash = v
end, {
	initialColor = settings.killFlashColor,
	onChanged = function(c) settings.killFlashColor = c end
})

createToggle(fCombatUtil, "Auto Kill (Murderer)", "Brings and eliminates entire lobby", settings.autoKill, function(v)
	settings.autoKill = v
end)

local visualsPage = tabPages["Visuals"]
local fMM2Esp = createSectionFolder(visualsPage, "MM2 Specific ESP", true)
local fBoxes = createSectionFolder(visualsPage, "Bounding Boxes & Outlines", true)
local fTracers = createSectionFolder(visualsPage, "Tracers, Skeleton & Direction", true)
local fEffects = createSectionFolder(visualsPage, "Cosmetics & Environment", true)

createToggle(fMM2Esp, "Role ESP", "Renders text role indicator above character", settings.roleEsp, function(v)
	settings.roleEsp = v
end)

createToggle(fMM2Esp, "2D Box ESP (MM2 Role)", "Renders 2D Box using current MM2 role color", settings.box2DMM2, function(v)
	settings.box2DMM2 = v
end)

createToggle(fMM2Esp, "2D Box MM2 Gradient", "Заливка 2D бокса градиентом цвета роли", settings.box2DFillMM2, function(v)
	settings.box2DFillMM2 = v
end)

createToggle(fMM2Esp, "Glass Chams (MM2 Roles)", "Окрашивает Glass Chams под цвет роли игрока", settings.glassChamsMM2, function(v)
	settings.glassChamsMM2 = v
	if not v and not settings.glassChams then
		restoreGlassChams()
	end
end)

createToggle(fMM2Esp, "ESP All", "Highlight every player in match", settings.espAll, function(v)
	settings.espAll = v
end)

createToggle(fMM2Esp, "ESP Murder", "Highlights active Murderer in red", settings.espMurder, function(v)
	settings.espMurder = v
end)

createToggle(fMM2Esp, "ESP Sheriff", "Highlights starting Sheriff in blue", settings.espSheriff, function(v)
	settings.espSheriff = v
end)

createToggle(fMM2Esp, "ESP Hero", "Highlights gun holder in yellow", settings.espHero, function(v)
	settings.espHero = v
end)

createToggle(fMM2Esp, "ESP Innocents", "Highlights innocent players in green", settings.espInnocents, function(v)
	settings.espInnocents = v
end)

createToggle(fMM2Esp, "GunDrop ESP", "High-visibility marker for dropped gun", settings.espGunDrop, function(v)
	settings.espGunDrop = v
end)

createToggle(fBoxes, "Highlight ESP", "Full outline glow through map architecture", settings.highlightEsp, function(v)
	settings.highlightEsp = v
end, {
	initialColor = settings.highlightColor,
	onChanged = function(c) settings.highlightColor = c end
})

createToggle(fBoxes, "BloxStrike ESP", "2D Box + Snaplines", false, function(v)
	settings.bloxEsp = v
end)

createToggle(fBoxes, "2D Box ESP (Custom Color)", "Screen-space boundary wireframe using selected color", settings.box2D, function(v)
	settings.box2D = v
end, {
	initialColor = settings.box2DColor,
	onChanged = function(c) settings.box2DColor = c end
})

createActionBtn(fBoxes, "Box Style: Full Box", "Continuous 4-sided wireframe outline", function()
	settings.box2DMode = "Full"
end)

createActionBtn(fBoxes, "Box Style: Corner / Half Box", "4 sleek corners [ ] style as in screenshots", function()
	settings.box2DMode = "Corner"
end)

createToggle(fBoxes, "Filled 2D Box (Gradient)", "Translucent vertical gradient box fill", settings.box2DFill, function(v)
	settings.box2DFill = v
end, {
	initialColor = settings.box2DFillColor,
	onChanged = function(c) settings.box2DFillColor = c end
})

createToggle(fBoxes, "Dynamic HP Bar", "Tri-color gradient indicator (Red/Yellow/Green)", settings.healthBar, function(v)
	settings.healthBar = v
end)

createToggle(fBoxes, "Distance ESP", "Metric label under target base", settings.distanceEsp, function(v)
	settings.distanceEsp = v
end, {
	initialColor = settings.distanceColor,
	onChanged = function(c) settings.distanceColor = c end
})

createToggle(fBoxes, "3D Box ESP", "In-world geometric bounding box", settings.box3D, function(v)
	settings.box3D = v
end, {
	initialColor = settings.box3DColor,
	onChanged = function(c) settings.box3DColor = c end
})

createToggle(fBoxes, "Filled 3D Box", "Volumetric shaded adornment box", settings.box3DFill, function(v)
	settings.box3DFill = v
end, {
	initialColor = settings.box3DFillColor,
	onChanged = function(c) settings.box3DFillColor = c end
})

createToggle(fTracers, "Skeleton ESP", "Renders precise anatomical bone connection segments", settings.skeletonEsp, function(v)
	settings.skeletonEsp = v
end, {
	initialColor = settings.skeletonColor,
	onChanged = function(c) settings.skeletonColor = c end
})

createToggle(fTracers, "Arrow ESP", "Directional screen border chevrons pointing to enemies", settings.arrowEsp, function(v)
	settings.arrowEsp = v
end, {
	initialColor = settings.arrowEspColor,
	onChanged = function(c) settings.arrowEspColor = c end
})

createToggle(fTracers, "Snaplines", "Traces projection lines towards enemy bases", settings.snaplines, function(v)
	settings.snaplines = v
end, {
	initialColor = settings.snaplineColor,
	onChanged = function(c) settings.snaplineColor = c end
})

createActionBtn(fTracers, "Snapline Origin: Bottom", "Traces from bottom screen edge to targets", function()
	settings.snaplineOrigin = "Bottom"
end)

createActionBtn(fTracers, "Snapline Origin: Center", "Traces from crosshair center to targets", function()
	settings.snaplineOrigin = "Center"
end)

local auraObjects = { parts = {}, emitters = {}, wings = nil, floorRing = nil }

local function buildAnimeAura()
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local bodyFlame = Instance.new("ParticleEmitter", hrp)
	bodyFlame.Name = "AnimeBodyFlame"
	bodyFlame.Texture = "rbxassetid://243098098"
	bodyFlame.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.35, settings.auraColor),
		ColorSequenceKeypoint.new(1, settings.auraColor)
	})
	bodyFlame.LightEmission = 1
	bodyFlame.LightInfluence = 0
	bodyFlame.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1.6),
		NumberSequenceKeypoint.new(0.5, 3.6),
		NumberSequenceKeypoint.new(1, 0)
	})
	bodyFlame.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.4),
		NumberSequenceKeypoint.new(0.65, 0.7),
		NumberSequenceKeypoint.new(1, 1)
	})
	bodyFlame.Lifetime = NumberRange.new(0.45, 0.65)
	bodyFlame.Rate = 45
	bodyFlame.Speed = NumberRange.new(3, 5.5)
	bodyFlame.SpreadAngle = Vector2.new(12, 12)
	bodyFlame.EmissionDirection = Enum.NormalId.Top
	table.insert(auraObjects.emitters, bodyFlame)

	local groundAtt = Instance.new("Attachment", hrp)
	groundAtt.Name = "GroundAuraAtt"
	groundAtt.Position = Vector3.new(0, -2.8, 0)
	table.insert(auraObjects.emitters, groundAtt)

	local shockwave = Instance.new("ParticleEmitter", groundAtt)
	shockwave.Name = "GroundShockwave"
	shockwave.Texture = "rbxassetid://1084991219"
	shockwave.Color = ColorSequence.new(settings.auraColor)
	shockwave.LightEmission = 1
	shockwave.LightInfluence = 0
	shockwave.Orientation = Enum.ParticleOrientation.VelocityPerpendicular
	shockwave.Size = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 1.5),
		NumberSequenceKeypoint.new(1, 9.5)
	})
	shockwave.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.1),
		NumberSequenceKeypoint.new(0.7, 0.5),
		NumberSequenceKeypoint.new(1, 1)
	})
	shockwave.Lifetime = NumberRange.new(0.5, 0.8)
	shockwave.Rate = 8
	shockwave.Speed = NumberRange.new(0.01, 0.02)
	shockwave.Rotation = NumberRange.new(-360, 360)
	shockwave.RotSpeed = NumberRange.new(80, 180)
	table.insert(auraObjects.emitters, shockwave)

	local floorRingPart = Instance.new("Part", workspace)
	floorRingPart.Name = "DetailedFloorRing"
	floorRingPart.Size = Vector3.new(7.5, 0.05, 7.5)
	floorRingPart.CFrame = hrp.CFrame * CFrame.new(0, -2.75, 0)
	floorRingPart.Anchored = true
	floorRingPart.CanCollide = false
	floorRingPart.CastShadow = false
	floorRingPart.Material = Enum.Material.Neon
	floorRingPart.Color = settings.auraColor
	floorRingPart.Transparency = 0.45
	local cylMesh = Instance.new("SpecialMesh", floorRingPart)
	cylMesh.MeshType = Enum.MeshType.Cylinder
	auraObjects.floorRing = floorRingPart

	local horizontalConfigs = {
		{ speed = 14.5, radius = 4.4, height = -2.75, width = 1.2, isFloor = true, phase = 0 },
		{ speed = -14.0, radius = 3.6, height = -2.7, width = 0.9, isFloor = true, phase = math.pi * 0.25 },
		{ speed = 15.2, radius = 2.8, height = -2.65, width = 1.0, isFloor = true, phase = math.pi * 0.5 },
		{ speed = -14.5, radius = 2.2, height = -2.6, width = 0.8, isFloor = true, phase = math.pi * 0.75 },
		{ speed = 16.0, radius = 4.8, height = -2.75, width = 1.4, isFloor = true, phase = math.pi },
		{ speed = -15.5, radius = 4.0, height = -2.68, width = 1.1, isFloor = true, phase = math.pi * 1.25 },
		{ speed = 15.8, radius = 3.2, height = -2.62, width = 0.9, isFloor = true, phase = math.pi * 1.5 },
		{ speed = -16.2, radius = 1.8, height = -2.55, width = 0.75, isFloor = true, phase = math.pi * 1.75 },

		{ speed = 13.0, radius = 2.4, height = -1.2, width = 0.65, isFloor = false, phase = 0 },
		{ speed = -13.5, radius = 2.2, height = -0.5, width = 0.6, isFloor = false, phase = math.pi * 0.2 },
		{ speed = 14.5, radius = 2.6, height = 0.1, width = 0.65, isFloor = false, phase = math.pi * 0.4 },
		{ speed = -14.0, radius = 2.4, height = 0.7, width = 0.6, isFloor = false, phase = math.pi * 0.6 },
		{ speed = 15.0, radius = 2.8, height = 1.3, width = 0.55, isFloor = false, phase = math.pi * 0.8 },
		{ speed = -15.5, radius = 2.3, height = 1.8, width = 0.5, isFloor = false, phase = math.pi },
		{ speed = 14.2, radius = 3.0, height = -0.9, width = 0.6, isFloor = false, phase = math.pi * 1.2 },
		{ speed = -14.8, radius = 2.7, height = -0.2, width = 0.65, isFloor = false, phase = math.pi * 1.4 },
		{ speed = 15.4, radius = 2.5, height = 0.4, width = 0.55, isFloor = false, phase = math.pi * 1.6 },
		{ speed = -16.0, radius = 2.9, height = 1.0, width = 0.5, isFloor = false, phase = math.pi * 1.8 }
	}

	for i, cfg in ipairs(horizontalConfigs) do
		local orbitPart = Instance.new("Part", workspace)
		orbitPart.Name = "HorizontalAuraNode_" .. i
		orbitPart.Size = Vector3.new(0.05, 0.05, 0.05)
		orbitPart.Transparency = 1
		orbitPart.CanCollide = false
		orbitPart.Anchored = true
		orbitPart.CastShadow = false

		local att0 = Instance.new("Attachment", orbitPart)
		att0.Position = Vector3.new(0, cfg.isFloor and 0.06 or 0.14, 0)
		local att1 = Instance.new("Attachment", orbitPart)
		att1.Position = Vector3.new(0, cfg.isFloor and -0.06 or -0.14, 0)

		local trail = Instance.new("Trail", orbitPart)
		trail.Attachment0 = att0
		trail.Attachment1 = att1
		trail.Lifetime = cfg.isFloor and 0.28 or 0.22
		trail.LightEmission = 1
		trail.LightInfluence = 0
		trail.FaceCamera = not cfg.isFloor
		trail.WidthScale = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.25, cfg.width),
			NumberSequenceKeypoint.new(0.75, cfg.width * 0.4),
			NumberSequenceKeypoint.new(1, 0)
		})
		trail.Color = ColorSequence.new({
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(0.35, settings.auraColor),
			ColorSequenceKeypoint.new(1, settings.auraColor)
		})
		trail.Transparency = NumberSequence.new({
			NumberSequenceKeypoint.new(0, 0),
			NumberSequenceKeypoint.new(0.7, 0.25),
			NumberSequenceKeypoint.new(1, 1)
		})

		table.insert(auraObjects.parts, {
			part = orbitPart,
			trail = trail,
			speed = cfg.speed,
			radius = cfg.radius,
			heightOffset = cfg.height,
			isFloor = cfg.isFloor,
			phase = cfg.phase
		})
	end
end

local function cleanAnimeAura()
	for _, node in ipairs(auraObjects.parts) do
		if node.part then node.part:Destroy() end
	end
	table.clear(auraObjects.parts)

	for _, item in ipairs(auraObjects.emitters) do
		if item then item:Destroy() end
	end
	table.clear(auraObjects.emitters)

	if auraObjects.floorRing then
		auraObjects.floorRing:Destroy()
		auraObjects.floorRing = nil
	end

	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		for _, name in ipairs({ "AnimeBodyFlame", "GroundAuraAtt" }) do
			local obj = hrp:FindFirstChild(name)
			if obj then obj:Destroy() end
		end
	end
end

createToggle(fEffects, "Celestial Aura (Horizontal)", "Dense horizontal ground ribbons, floor rings & plasma", settings.aura, function(v)
	settings.aura = v
	if not v then
		cleanAnimeAura()
	else
		buildAnimeAura()
	end
end, {
	initialColor = settings.auraColor,
	onChanged = function(c)
		settings.auraColor = c
		local char = localPlayer.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		if hrp then
			local flame = hrp:FindFirstChild("AnimeBodyFlame")
			if flame then
				flame.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.35, c),
					ColorSequenceKeypoint.new(1, c)
				})
			end
			local gAtt = hrp:FindFirstChild("GroundAuraAtt")
			if gAtt then
				local wave = gAtt:FindFirstChild("GroundShockwave")
				if wave then wave.Color = ColorSequence.new(c) end
			end
		end
		if auraObjects.floorRing then
			auraObjects.floorRing.Color = c
		end
		for _, node in ipairs(auraObjects.parts) do
			if node.trail then
				node.trail.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.35, c),
					ColorSequenceKeypoint.new(1, c)
				})
			end
		end
	end
})

local function buildAngelWings()
	local char = localPlayer.Character
	local torso = char and (char:FindFirstChild("UpperTorso") or char:FindFirstChild("Torso"))
	if not torso or auraObjects.wings then return end

	local wingsModel = Instance.new("Model", char)
	wingsModel.Name = "AnxiumAngelWings"

	for side = -1, 1, 2 do
		local wing = Instance.new("Part", wingsModel)
		wing.Size = Vector3.new(2.8, 1.8, 0.1)
		wing.Material = Enum.Material.Neon
		wing.Color = settings.selfWingsColor
		wing.Transparency = 0.25
		wing.CanCollide = false
		wing.CastShadow = false

		local wMesh = Instance.new("SpecialMesh", wing)
		wMesh.MeshType = Enum.MeshType.Wedge
		wMesh.Scale = Vector3.new(side, 1, 1)

		local weld = Instance.new("Weld", wing)
		weld.Part0 = torso
		weld.Part1 = wing
		weld.C0 = CFrame.new(side * 1.6, 0.6, 0.8) * CFrame.Angles(math.rad(15), math.rad(side * 25), math.rad(side * -18))
	end
	auraObjects.wings = wingsModel
end

local function cleanAngelWings()
	if auraObjects.wings then
		auraObjects.wings:Destroy()
		auraObjects.wings = nil
	end
	local char = localPlayer.Character
	if char and char:FindFirstChild("AnxiumAngelWings") then
		char.AnxiumAngelWings:Destroy()
	end
end

createToggle(fEffects, "Angel Wings (Self)", "Glowing celestial angel wings behind torso", settings.selfWings, function(v)
	settings.selfWings = v
	if v then buildAngelWings() else cleanAngelWings() end
end, {
	initialColor = settings.selfWingsColor,
	onChanged = function(c)
		settings.selfWingsColor = c
		if auraObjects.wings then
			for _, p in ipairs(auraObjects.wings:GetChildren()) do
				if p:IsA("BasePart") then p.Color = c end
			end
		end
	end
})

createToggle(fEffects, "Starlight Sparkles", "Twinkling star glitter particles around body", settings.selfStarlight, function(v)
	settings.selfStarlight = v
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local sp = hrp:FindFirstChild("AnxiumStarlight")
	if v and not sp then
		sp = Instance.new("ParticleEmitter", hrp)
		sp.Name = "AnxiumStarlight"
		sp.Texture = "rbxassetid://446111271"
		sp.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255))
		sp.LightEmission = 1
		sp.Size = NumberSequence.new({ NumberSequenceKeypoint.new(0, 0.6), NumberSequenceKeypoint.new(1, 0) })
		sp.Lifetime = NumberRange.new(0.4, 0.8)
		sp.Rate = 20
		sp.Speed = NumberRange.new(1, 3)
		sp.SpreadAngle = Vector2.new(180, 180)
	elseif not v and sp then
		sp:Destroy()
	end
end)

local function applyGlassChamsToChar(character, overrideColor)
	for _, part in ipairs(character:GetDescendants()) do
		if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
			if not chamsOriginals[part] then
				chamsOriginals[part] = {
					material = part.Material,
					color = part.Color,
					transparency = part.Transparency
				}
			end
			part.Material = Enum.Material.ForceField
			part.Color = overrideColor or settings.glassChamsColor
			part.Transparency = 0.35
		end
	end
end

local function restoreGlassChams()
	for part, orig in pairs(chamsOriginals) do
		if part and part.Parent then
			part.Material = orig.material
			part.Color = orig.color
			part.Transparency = orig.transparency
		end
	end
	table.clear(chamsOriginals)
end

createToggle(fEffects, "Glass Chams", "Translucent crystal shimmer shader", settings.glassChams, function(v)
	settings.glassChams = v
	if not v then restoreGlassChams() end
end, {
	initialColor = settings.glassChamsColor,
	onChanged = function(c)
		settings.glassChamsColor = c
		if settings.glassChams then
			if settings.glassChamsAll then
				for _, p in ipairs(playersService:GetPlayers()) do
					if p.Character then applyGlassChamsToChar(p.Character) end
				end
			elseif localPlayer.Character then
				applyGlassChamsToChar(localPlayer.Character)
			end
		end
	end
})

createToggle(fEffects, "Chams: Target All", "Applies glass chams to all players vs local only", settings.glassChamsAll, function(v)
	settings.glassChamsAll = v
	restoreGlassChams()
end)

createToggle(fEffects, "Custom Fog", "Atmospheric fog distance and tint control", settings.customFog, function(v)
	settings.customFog = v
	if v then
		lightingService.FogStart = 0
		lightingService.FogEnd = settings.fogDistance
		lightingService.FogColor = settings.fogColor
	else
		lightingService.FogStart = defaultLighting.FogStart
		lightingService.FogEnd = defaultLighting.FogEnd
		lightingService.FogColor = defaultLighting.FogColor
	end
end, {
	initialColor = settings.fogColor,
	onChanged = function(c)
		settings.fogColor = c
		if settings.customFog then lightingService.FogColor = c end
	end
})

createTextInput(fEffects, "Fog Distance", "Numeric fog depth limit (e.g. 200)", tostring(settings.fogDistance), function(val)
	local num = tonumber(val)
	if num then
		settings.fogDistance = num
		if settings.customFog then lightingService.FogEnd = num end
	end
end)

local miscPage = tabPages["Misc"]
local fMove = createSectionFolder(miscPage, "Movement & Physics", true)
local fUtility = createSectionFolder(miscPage, "Defense & Utility", true)
local fDisplay = createSectionFolder(miscPage, "Crosshair & Audio HUD", true)

createToggle(fMove, "Bunny Hop & Strafe", "Instant acceleration snapping on jump / turns", settings.bhop, function(v)
	settings.bhop = v
end)

createActionBtn(fMove, "Strafe Mode: Hybrid", "Combines velocity heading with instant CFrame redirection", function()
	settings.strafeType = "Hybrid"
end)

createActionBtn(fMove, "Strafe Mode: Velocity", "Instantaneous linear horizontal velocity overwrite", function()
	settings.strafeType = "Velocity"
end)

createActionBtn(fMove, "Strafe Mode: CFrame", "Pure positional coordinate translation step", function()
	settings.strafeType = "CFrame"
end)

createToggle(fMove, "Fly (Infinite Yield)", "Полет на WASD, Space и Shift", settings.fly, function(v)
	settings.fly = v
	if v then startFly() else stopFly() end
end)

createTextInput(fMove, "Fly Speed Multiplier", "Множитель скорости полета", tostring(settings.flySpeed), function(val)
	local num = tonumber(val)
	if num and num > 0 then settings.flySpeed = num end
end)

createToggle(fMove, "Custom Noclip", "Прохождение сквозь стены через Stepped", settings.noclip, function(v)
	settings.noclip = v
end)

createToggle(fMove, "Speed Hack", "Overrides WalkSpeed with bypass protection", settings.speedHack, function(v)
	settings.speedHack = v
	if not v and localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
		localPlayer.Character:FindFirstChildOfClass("Humanoid").WalkSpeed = 16
	end
end)

createActionBtn(fMove, "Speed Method: Humanoid", "Direct Humanoid.WalkSpeed variable modification", function()
	settings.speedMethod = "Humanoid"
end)

createActionBtn(fMove, "Speed Method: Velocity", "Linear physics assembly boost (bypasses property locks)", function()
	settings.speedMethod = "Velocity"
end)

createActionBtn(fMove, "Speed Method: CFrame Step", "Micro-coordinate translation (bypasses all walkspeed locks)", function()
	settings.speedMethod = "CFrame"
end)

createTextInput(fMove, "WalkSpeed Value", "Enter custom walking speed", tostring(settings.speedValue), function(val)
	local num = tonumber(val)
	if num then settings.speedValue = num end
end)

createToggle(fMove, "JumpPower Hack", "Overrides jump height with custom power", settings.jumpPowerHack, function(v)
	settings.jumpPowerHack = v
	if not v and localPlayer.Character and localPlayer.Character:FindFirstChildOfClass("Humanoid") then
		localPlayer.Character:FindFirstChildOfClass("Humanoid").JumpPower = 50
	end
end)

createActionBtn(fMove, "Jump Method: Humanoid", "Modifies Humanoid.JumpPower / JumpHeight", function()
	settings.jumpPowerMethod = "Humanoid"
end)

createActionBtn(fMove, "Jump Method: Impulse", "Applies instantaneous upward vertical impulse on jump", function()
	settings.jumpPowerMethod = "Impulse"
end)

createTextInput(fMove, "JumpPower Value", "Enter custom jump power", tostring(settings.jumpPowerValue), function(val)
	local num = tonumber(val)
	if num then settings.jumpPowerValue = num end
end)

createToggle(fUtility, "Anti Fling (Players Only)", "Disables player-to-player collision without breaking floor", settings.antiFling, function(v)
	settings.antiFling = v
end)

createActionBtn(fUtility, "Teleport to Mouse", "Телепортация персонажа на курсор мыши", function()
	teleportToMouse()
end)

createToggle(fUtility, "Auto Collect Coins", "Медленный сбор коинов с Noclip по всей карте", settings.autoCollectCoins, function(v)
	settings.autoCollectCoins = v
end)

createToggle(fUtility, "Anti Void", "Prevents falling into void & resets to safe ground", settings.antiVoid, function(v)
	settings.antiVoid = v
	if v then pcall(function() workspace.FallenPartsDestroyHeight = -50000 end) end
end)

createActionBtn(fUtility, "TP to Gun and Return", "Grabs dropped pistol instantly and returns to origin", function()
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local gunDrop = workspace:FindFirstChild("GunDrop", true)
	if gunDrop then
		local gunPart = gunDrop:IsA("BasePart") and gunDrop or gunDrop:FindFirstChildWhichIsA("BasePart", true)
		if gunPart then
			local originCF = hrp.CFrame
			hrp.CFrame = gunPart.CFrame + Vector3.new(0, 1.2, 0)
			task.wait(0.25)
			hrp.CFrame = originCF
			hrp.Velocity = Vector3.zero
		end
	end
end)

createToggle(fDisplay, "Custom Crosshair (PC)", "Renders custom screen center crosshair", settings.crosshair, function(v)
	settings.crosshair = v
	crosshairContainer.Visible = v
	updateCrosshairRender()
end, {
	initialColor = settings.crosshairColor,
	onChanged = function(c)
		settings.crosshairColor = c
		updateCrosshairRender()
	end
})

createToggle(fDisplay, "Spin Crosshair", "Rotates crosshair continuously on screen", settings.crosshairSpin, function(v)
	settings.crosshairSpin = v
	if not v then crosshairContainer.Rotation = 0 end
end)

createActionBtn(fDisplay, "Crosshair: Cycle Style (1-4)", "Switches crosshair geometry layout", function()
	settings.crosshairStyle = (settings.crosshairStyle % 4) + 1
	updateCrosshairRender()
end)

createToggle(fDisplay, "Hit Sound (Mine Only)", "Plays custom hit sound when hitting enemies", settings.playHitSound, function(v)
	settings.playHitSound = v
end)

createToggle(fDisplay, "Kill Sound (Mine Only)", "Plays custom kill sound on personal eliminations", settings.playKillSound, function(v)
	settings.playKillSound = v
end)

createTextInput(fDisplay, "Fake / Real FPS Label", "Custom text (leave blank for real FPS)", "e.g. 120 fps", function(val)
	customFpsText = val
end)

local trollPage = tabPages["Troll"]
local fManualFling = createSectionFolder(trollPage, "Instant 1-Click Flings", true)
local fAutoFling = createSectionFolder(trollPage, "Automated Continuous Flings", true)

createActionBtn(fManualFling, "Toggle Fling Mode: Rage / Normal", "Switches fling trajectory pattern", function()
	settings.flingMode = settings.flingMode == "Rage" and "Normal" or "Rage"
end)

createTextInput(fManualFling, "Target Player Name", "Enter player name to target", "Username", function(val)
	local found = nil
	val = val:lower()
	for _, p in ipairs(playersService:GetPlayers()) do
		if p ~= localPlayer and (p.Name:lower():find(val) or p.DisplayName:lower():find(val)) then
			found = p
			break
		end
	end
	selectedFlingPlayer = found
end)

createActionBtn(fManualFling, "Fling Target Player", "Instant 1-click thrust attack on selected target", function()
	if selectedFlingPlayer then task.spawn(executeFling, selectedFlingPlayer) end
end)

createActionBtn(fManualFling, "Fling Murderer", "Instant 1-click attack targeting current Murderer", function()
	local m = getMurdererPlayer()
	if m then task.spawn(executeFling, m) end
end)

createActionBtn(fManualFling, "Fling Sheriff", "Instant 1-click attack targeting current Sheriff", function()
	local s = getSheriffPlayer()
	if s then task.spawn(executeFling, s) end
end)

createActionBtn(fManualFling, "Fling Hero", "Instant 1-click attack targeting current Hero", function()
	local h = getHeroPlayer()
	if h then task.spawn(executeFling, h) end
end)

createActionBtn(fManualFling, "Fling All Players", "Запускает IY Fling по очереди по всем игрокам", function()
	task.spawn(executeFlingAll)
end)

createToggle(fAutoFling, "Auto Fling Target Player", "Continuously flings target username while in match", settings.autoFlingTarget, function(v)
	settings.autoFlingTarget = v
end)

createToggle(fAutoFling, "Auto Fling Murderer", "Continuously flings the Murderer whenever detected", settings.autoFlingMurderer, function(v)
	settings.autoFlingMurderer = v
end)

createToggle(fAutoFling, "Auto Fling Sheriff", "Continuously flings the Sheriff whenever detected", settings.autoFlingSheriff, function(v)
	settings.autoFlingSheriff = v
end)

createToggle(fAutoFling, "Auto Fling Hero", "Continuously flings the Hero whenever detected", settings.autoFlingHero, function(v)
	settings.autoFlingHero = v
end)

local bundlesPage = tabPages["Bundles"]
local fMarketFolder = createSectionFolder(bundlesPage, "Marketplace Catalog Search", true)
local fBundlesFolder = createSectionFolder(bundlesPage, "Animation Packs (Bundles)", true)
local fEmotesFolder = createSectionFolder(bundlesPage, "Emotes", true)

local bundleSearchBox = Instance.new("TextBox", fBundlesFolder)
bundleSearchBox.Size = UDim2.new(1, 0, 0, 30)
bundleSearchBox.BackgroundColor3 = colors.cardBg
bundleSearchBox.PlaceholderText = "Filter bundle name..."
bundleSearchBox.PlaceholderColor3 = colors.textMuted
bundleSearchBox.TextColor3 = colors.textPrimary
bundleSearchBox.Font = Enum.Font.GothamMedium
bundleSearchBox.TextSize = 11
local bsc = Instance.new("UICorner", bundleSearchBox)
bsc.CornerRadius = UDim.new(0, 6)

local bundleCards = {}
for _, pack in ipairs(animationPacks) do
	local card = Instance.new("Frame", fBundlesFolder)
	card.Size = UDim2.new(1, 0, 0, 36)
	card.BackgroundColor3 = colors.cardBg
	local cCorner = Instance.new("UICorner", card)
	cCorner.CornerRadius = UDim.new(0, 6)
	local cStroke = Instance.new("UIStroke", card)
	cStroke.Color = colors.border
	cStroke.Thickness = 1

	local lbl = Instance.new("TextLabel", card)
	lbl.Size = UDim2.new(1, -65, 1, 0)
	lbl.Position = UDim2.new(0, 10, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.GothamMedium
	lbl.Text = pack.name
	lbl.TextColor3 = colors.textPrimary
	lbl.TextSize = 11
	lbl.TextXAlignment = Enum.TextXAlignment.Left

	local btn = Instance.new("TextButton", card)
	btn.Size = UDim2.new(0, 48, 0, 22)
	btn.Position = UDim2.new(1, -54, 0.5, -11)
	btn.BackgroundColor3 = colors.accentSubtle
	btn.Font = Enum.Font.GothamBold
	btn.Text = "Apply"
	btn.TextColor3 = colors.accent
	btn.TextSize = 10
	local bc = Instance.new("UICorner", btn)
	bc.CornerRadius = UDim.new(0, 4)

	btn.Activated:Connect(function()
		local char = localPlayer.Character
		if char then
			local anim = char:FindFirstChild("Animate")
			if anim then
				anim.Disabled = true
				local function setAnim(fName, cName, id)
					local f = anim:FindFirstChild(fName)
					if f then
						local c = f:FindFirstChild(cName)
						if c then c.AnimationId = "rbxassetid://" .. tostring(id) end
					end
				end
				setAnim("idle", "Animation1", pack.idle1)
				setAnim("idle", "Animation2", pack.idle2)
				setAnim("walk", "WalkAnim", pack.walk)
				setAnim("run", "RunAnim", pack.run)
				setAnim("jump", "JumpAnim", pack.jump)
				setAnim("fall", "FallAnim", pack.fall)
				task.wait(0.05)
				anim.Disabled = false
			end
			local hum = char:FindFirstChildOfClass("Humanoid")
			if hum then
				local a = hum:FindFirstChildOfClass("Animator")
				if a then for _, t in ipairs(a:GetPlayingAnimationTracks()) do t:Stop() end end
			end
		end
		btn.Text = "Set!"
		task.delay(0.6, function() btn.Text = "Apply" end)
	end)

	table.insert(bundleCards, { frame = card, name = pack.name:lower() })
end

bundleSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local q = bundleSearchBox.Text:lower()
	for _, it in ipairs(bundleCards) do
		it.frame.Visible = (q == "" or it.name:find(q) ~= nil)
	end
end)

local emoteSearchBox = Instance.new("TextBox", fEmotesFolder)
emoteSearchBox.Size = UDim2.new(1, 0, 0, 30)
emoteSearchBox.BackgroundColor3 = colors.cardBg
emoteSearchBox.PlaceholderText = "Filter emote name..."
emoteSearchBox.PlaceholderColor3 = colors.textMuted
emoteSearchBox.TextColor3 = colors.textPrimary
emoteSearchBox.Font = Enum.Font.GothamMedium
emoteSearchBox.TextSize = 11
local esc = Instance.new("UICorner", emoteSearchBox)
esc.CornerRadius = UDim.new(0, 6)

local emoteCards = {}
for _, emote in ipairs(emoteList) do
	local card = Instance.new("Frame", fEmotesFolder)
	card.Size = UDim2.new(1, 0, 0, 36)
	card.BackgroundColor3 = colors.cardBg
	local cCorner = Instance.new("UICorner", card)
	cCorner.CornerRadius = UDim.new(0, 6)
	local cStroke = Instance.new("UIStroke", card)
	cStroke.Color = colors.border
	cStroke.Thickness = 1

	local lbl = Instance.new("TextLabel", card)
	lbl.Size = UDim2.new(1, -65, 1, 0)
	lbl.Position = UDim2.new(0, 10, 0, 0)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.GothamMedium
	lbl.Text = emote.name
	lbl.TextColor3 = colors.textPrimary
	lbl.TextSize = 11
	lbl.TextXAlignment = Enum.TextXAlignment.Left

	local btn = Instance.new("TextButton", card)
	btn.Size = UDim2.new(0, 48, 0, 22)
	btn.Position = UDim2.new(1, -54, 0.5, -11)
	btn.BackgroundColor3 = colors.accentSubtle
	btn.Font = Enum.Font.GothamBold
	btn.Text = "Play"
	btn.TextColor3 = colors.accent
	btn.TextSize = 10
	local bc = Instance.new("UICorner", btn)
	bc.CornerRadius = UDim.new(0, 4)

	btn.Activated:Connect(function()
		local char = localPlayer.Character
		local hum = char and char:FindFirstChildOfClass("Humanoid")
		if hum then
			local anim = Instance.new("Animation")
			anim.AnimationId = "rbxassetid://" .. tostring(emote.id)
			local track = hum:LoadAnimation(anim)
			track:Play()
		end
		btn.Text = "Playing"
		task.delay(0.6, function() btn.Text = "Play" end)
	end)

	table.insert(emoteCards, { frame = card, name = emote.name:lower() })
end

emoteSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
	local q = emoteSearchBox.Text:lower()
	for _, it in ipairs(emoteCards) do
		it.frame.Visible = (q == "" or it.name:find(q) ~= nil)
	end
end)

local liveResultsBox = Instance.new("ScrollingFrame", fMarketFolder)
liveResultsBox.Size = UDim2.new(1, 0, 0, 140)
liveResultsBox.BackgroundTransparency = 1
liveResultsBox.ScrollBarThickness = 2
liveResultsBox.AutomaticCanvasSize = Enum.AutomaticSize.Y

local liveLayout = Instance.new("UIListLayout", liveResultsBox)
liveLayout.SortOrder = Enum.SortOrder.LayoutOrder
liveLayout.Padding = UDim.new(0, 5)

local function applyMarketplaceItem(id)
	local char = localPlayer.Character
	if not char then return end
	local hum = char:FindFirstChildOfClass("Humanoid")
	if not hum then return end

	local success, info = pcall(function()
		return marketService:GetProductInfo(id, Enum.InfoType.Asset)
	end)

	if success and info then
		if info.AssetTypeId == 24 then
			local anim = Instance.new("Animation")
			anim.AnimationId = "rbxassetid://" .. tostring(id)
			local track = hum:LoadAnimation(anim)
			track:Play()
		else
			pcall(function()
				local desc = hum:GetAppliedDescription()
				if desc then hum:ApplyDescription(desc) end
			end)
		end
	else
		local anim = Instance.new("Animation")
		anim.AnimationId = "rbxassetid://" .. tostring(id)
		local track = hum:LoadAnimation(anim)
		track:Play()
	end
end

local function searchMarketplace(keyword)
	for _, child in ipairs(liveResultsBox:GetChildren()) do
		if child:IsA("Frame") then child:Destroy() end
	end
	if keyword == "" then return end

	local foundAny = false
	pcall(function()
		local catalogParams = CatalogSearchParams.new()
		catalogParams.SearchKeyword = keyword
		catalogParams.CategoryFilter = Enum.CatalogCategoryFilter.Animation
		catalogParams.Limit = 10

		local searchPages = avatarEditorService:SearchCatalog(catalogParams)
		local currentPage = searchPages:GetCurrentPage()

		for _, item in ipairs(currentPage) do
			foundAny = true
			local card = Instance.new("Frame", liveResultsBox)
			card.Size = UDim2.new(1, 0, 0, 36)
			card.BackgroundColor3 = colors.cardBg
			local cCorner = Instance.new("UICorner", card)
			cCorner.CornerRadius = UDim.new(0, 6)
			local cStroke = Instance.new("UIStroke", card)
			cStroke.Color = colors.border
			cStroke.Thickness = 1

			local lbl = Instance.new("TextLabel", card)
			lbl.Size = UDim2.new(1, -70, 1, 0)
			lbl.Position = UDim2.new(0, 10, 0, 0)
			lbl.BackgroundTransparency = 1
			lbl.Font = Enum.Font.GothamMedium
			lbl.Text = item.Name or ("ID: " .. tostring(item.Id))
			lbl.TextColor3 = colors.textPrimary
			lbl.TextSize = 10
			lbl.TextXAlignment = Enum.TextXAlignment.Left
			lbl.TextTruncate = Enum.TextTruncate.AtEnd

			local btn = Instance.new("TextButton", card)
			btn.Size = UDim2.new(0, 52, 0, 22)
			btn.Position = UDim2.new(1, -58, 0.5, -11)
			btn.BackgroundColor3 = colors.accentSubtle
			btn.Font = Enum.Font.GothamBold
			btn.Text = "Equip"
			btn.TextColor3 = colors.accent
			btn.TextSize = 10
			local bc = Instance.new("UICorner", btn)
			bc.CornerRadius = UDim.new(0, 4)

			btn.Activated:Connect(function()
				applyMarketplaceItem(item.Id)
				btn.Text = "Done!"
				task.delay(0.6, function() btn.Text = "Equip" end)
			end)
		end
	end)

	if not foundAny then
		local url = "https://catalog.roblox.com/v1/search/items?category=All&keyword=" .. httpService:UrlEncode(keyword) .. "&limit=6"
		task.spawn(function()
			local response = nil
			pcall(function()
				if typeof(request) == "function" then
					local res = request({ Url = url, Method = "GET" })
					response = res and res.Body
				elseif typeof(http_request) == "function" then
					local res = http_request({ Url = url, Method = "GET" })
					response = res and res.Body
				elseif typeof(game.HttpGet) == "function" then
					response = game:HttpGet(url)
				end
			end)
			if response then
				local data = httpService:JSONDecode(response)
				if data and data.data then
					for _, item in ipairs(data.data) do
						local card = Instance.new("Frame", liveResultsBox)
						card.Size = UDim2.new(1, 0, 0, 36)
						card.BackgroundColor3 = colors.cardBg
						local cCorner = Instance.new("UICorner", card)
						cCorner.CornerRadius = UDim.new(0, 6)
						local cStroke = Instance.new("UIStroke", card)
						cStroke.Color = colors.border
						cStroke.Thickness = 1

						local lbl = Instance.new("TextLabel", card)
						lbl.Size = UDim2.new(1, -70, 1, 0)
						lbl.Position = UDim2.new(0, 10, 0, 0)
						lbl.BackgroundTransparency = 1
						lbl.Font = Enum.Font.GothamMedium
						lbl.Text = item.name or ("Asset: " .. tostring(item.id))
						lbl.TextColor3 = colors.textPrimary
						lbl.TextSize = 10
						lbl.TextXAlignment = Enum.TextXAlignment.Left
						lbl.TextTruncate = Enum.TextTruncate.AtEnd

						local btn = Instance.new("TextButton", card)
						btn.Size = UDim2.new(0, 52, 0, 22)
						btn.Position = UDim2.new(1, -58, 0.5, -11)
						btn.BackgroundColor3 = colors.accentSubtle
						btn.Font = Enum.Font.GothamBold
						btn.Text = "Equip"
						btn.TextColor3 = colors.accent
						btn.TextSize = 10
						local bc = Instance.new("UICorner", btn)
						bc.CornerRadius = UDim.new(0, 4)

						btn.Activated:Connect(function()
							applyMarketplaceItem(item.id)
							btn.Text = "Done!"
							task.delay(0.6, function() btn.Text = "Equip" end)
						end)
					end
				end
			end
		end)
	end
end

createTextInput(fMarketFolder, "Market Search", "Search bundles & emotes on Roblox marketplace", "Keyword", function(val)
	searchMarketplace(val)
end)

local configPage = tabPages["Config"]
local fConfigMgr = createSectionFolder(configPage, "Configuration Profiles", true)
local savedConfigs = {}

createActionBtn(fConfigMgr, "Save Current Settings", "Writes current config to slot 1", function()
	local encoded = httpService:JSONEncode(settings)
	savedConfigs["Slot1"] = encoded
	pcall(function()
		if writefile then writefile("Anxium_Config1.json", encoded) end
	end)
end)

createActionBtn(fConfigMgr, "Load Settings", "Restores saved parameters from slot 1", function()
	local raw = savedConfigs["Slot1"]
	pcall(function()
		if readfile and isfile and isfile("Anxium_Config1.json") then
			raw = readfile("Anxium_Config1.json")
		end
	end)
	if raw then
		local decoded = httpService:JSONDecode(raw)
		for k, v in pairs(decoded) do settings[k] = v end
	end
end)

local settingsPage = tabPages["Settings"]
local fSettingsDisplay = createSectionFolder(settingsPage, "Layout Dimensions (PC UI)", true)

createToggle(fSettingsDisplay, "Show Keybinds HUD", "Displays keybind panel on screen", settings.hudKeybindsList, function(v)
	settings.hudKeybindsList = v
	hudKeybindsBox.Visible = v
end)

createTextInput(fSettingsDisplay, "Menu Width", "Changes main window pixel width", tostring(settings.menuWidth), function(val)
	local num = tonumber(val)
	if num and num >= 450 and num <= 900 then
		settings.menuWidth = num
		mainFrame.Size = UDim2.new(0, settings.menuWidth, 0, settings.menuHeight)
	end
end)

createTextInput(fSettingsDisplay, "Menu Height", "Changes main window pixel height", tostring(settings.menuHeight), function(val)
	local num = tonumber(val)
	if num and num >= 280 and num <= 700 then
		settings.menuHeight = num
		mainFrame.Size = UDim2.new(0, settings.menuWidth, 0, settings.menuHeight)
	end
end)

createTextInput(fSettingsDisplay, "HUD Width", "Changes top-left indicator bar width", tostring(settings.hudWidth), function(val)
	local num = tonumber(val)
	if num and num >= 180 and num <= 400 then
		settings.hudWidth = num
		hudFrame.Size = UDim2.new(0, settings.hudWidth, 0, settings.hudHeight)
	end
end)

createTextInput(fSettingsDisplay, "HUD Height", "Changes top-left indicator bar height", tostring(settings.hudHeight), function(val)
	local num = tonumber(val)
	if num and num >= 24 and num <= 60 then
		settings.hudHeight = num
		hudFrame.Size = UDim2.new(0, settings.hudWidth, 0, settings.hudHeight)
	end
end)

createActionBtn(fSettingsDisplay, "Reset PC Window Sizes", "Sets default dimensions (570x370 / 240x32)", function()
	settings.menuWidth = 570
	settings.menuHeight = 370
	settings.hudWidth = 240
	settings.hudHeight = 32
	mainFrame.Size = UDim2.new(0, settings.menuWidth, 0, settings.menuHeight)
	hudFrame.Size = UDim2.new(0, settings.hudWidth, 0, settings.hudHeight)
end)

local fSettingsVisual = createSectionFolder(settingsPage, "Interface & Display", true)
local fSettingsSafety = createSectionFolder(settingsPage, "Safety & Guardrails", true)

do
	local card = Instance.new("Frame", fSettingsVisual)
	card.Size = UDim2.new(1, 0, 0, 42)
	card.BackgroundColor3 = colors.cardBg

	local cCorn = Instance.new("UICorner", card)
	cCorn.CornerRadius = UDim.new(0, 6)
	local cStr = Instance.new("UIStroke", card)
	cStr.Color = colors.border
	cStr.Thickness = 1

	local lbl = Instance.new("TextLabel", card)
	lbl.Size = UDim2.new(0.65, 0, 0, 16)
	lbl.Position = UDim2.new(0, 10, 0, 6)
	lbl.BackgroundTransparency = 1
	lbl.Font = Enum.Font.GothamMedium
	lbl.Text = "Menu Toggle Keybind"
	lbl.TextColor3 = colors.textPrimary
	lbl.TextSize = 11
	lbl.TextXAlignment = Enum.TextXAlignment.Left

	local sLbl = Instance.new("TextLabel", card)
	sLbl.Size = UDim2.new(0.65, 0, 0, 12)
	sLbl.Position = UDim2.new(0, 10, 0, 22)
	sLbl.BackgroundTransparency = 1
	sLbl.Font = Enum.Font.Gotham
	sLbl.Text = "Key used to show/hide this menu"
	sLbl.TextColor3 = colors.textMuted
	sLbl.TextSize = 9
	sLbl.TextXAlignment = Enum.TextXAlignment.Left

	local bindBtn = Instance.new("TextButton", card)
	bindBtn.Size = UDim2.new(0, 75, 0, 22)
	bindBtn.Position = UDim2.new(1, -85, 0.5, -11)
	bindBtn.BackgroundColor3 = colors.sidebarBg
	bindBtn.Font = Enum.Font.RobotoMono
	bindBtn.Text = "[" .. settings.menuKeybind.Name .. "]"
	bindBtn.TextColor3 = colors.accent
	bindBtn.TextSize = 10
	local bCorn = Instance.new("UICorner", bindBtn)
	bCorn.CornerRadius = UDim.new(0, 4)
	local bStr = Instance.new("UIStroke", bindBtn)
	bStr.Color = colors.border
	bStr.Thickness = 1

	bindBtn.Activated:Connect(function()
		bindBtn.Text = "[...]"
		listeningKeybind = {
			set = function(newKey, labelText)
				settings.menuKeybind = newKey
				bindBtn.Text = labelText
			end
		}
	end)
end

createToggle(fSettingsVisual, "Furry Background", "Applies theme image (14799621400) to menu", settings.furryBackground, function(v)
	settings.furryBackground = v
	furryBg.Visible = v
end)

createTextInput(fSettingsVisual, "Background Transparency", "0 (opaque) to 1 (invisible)", tostring(settings.menuTransparency), function(val)
	local num = tonumber(val)
	if num then
		num = math.clamp(num, 0, 0.95)
		settings.menuTransparency = num
		mainFrame.BackgroundTransparency = num
		sidebar.BackgroundTransparency = math.clamp(num + 0.1, 0, 0.95)
	end
end)

createToggle(fSettingsVisual, "Show Active Features HUD", "Displays active toggles panel in top-left", settings.hudActiveList, function(v)
	settings.hudActiveList = v
	hudActiveBox.Visible = v
end)

createToggle(fSettingsSafety, "Anti-Void Bypass", "Locks FallenHeight and negates out-of-bounds death", settings.antiCheatBypass, function(v)
	settings.antiCheatBypass = v
	if v then pcall(function() workspace.FallenPartsDestroyHeight = -50000 end) end
end)

if settings.antiCheatBypass then
	pcall(function() workspace.FallenPartsDestroyHeight = -50000 end)
end

local cached2D = {}

local function getOrCreate2D(player)
	if cached2D[player] then return cached2D[player] end

	local container = Instance.new("Folder", espContainer)
	container.Name = player.Name .. "_2DESP"

	local boxFrame = Instance.new("Frame", container)
	boxFrame.BackgroundTransparency = 1
	boxFrame.BorderSizePixel = 0
	boxFrame.Visible = false

	local boxStroke = Instance.new("UIStroke", boxFrame)
	boxStroke.Thickness = 1.2

	local boxGradient = Instance.new("UIGradient", boxFrame)
	boxGradient.Rotation = 90
	boxGradient.Color = ColorSequence.new({
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 90, 220)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 20))
	})
	boxGradient.Transparency = NumberSequence.new({
		NumberSequenceKeypoint.new(0, 0.35),
		NumberSequenceKeypoint.new(1, 0.05)
	})

	local cTL_H = Instance.new("Frame", boxFrame); cTL_H.BorderSizePixel = 0
	local cTL_V = Instance.new("Frame", boxFrame); cTL_V.BorderSizePixel = 0
	local cTR_H = Instance.new("Frame", boxFrame); cTR_H.BorderSizePixel = 0
	local cTR_V = Instance.new("Frame", boxFrame); cTR_V.BorderSizePixel = 0
	local cBL_H = Instance.new("Frame", boxFrame); cBL_H.BorderSizePixel = 0
	local cBL_V = Instance.new("Frame", boxFrame); cBL_V.BorderSizePixel = 0
	local cBR_H = Instance.new("Frame", boxFrame); cBR_H.BorderSizePixel = 0
	local cBR_V = Instance.new("Frame", boxFrame); cBR_V.BorderSizePixel = 0

	local corners = { cTL_H, cTL_V, cTR_H, cTR_V, cBL_H, cBL_V, cBR_H, cBR_V }

	local hpTrack = Instance.new("Frame", container)
	hpTrack.BackgroundColor3 = Color3.fromRGB(15, 15, 20)
	hpTrack.BorderSizePixel = 0
	hpTrack.Visible = false
	local hpBar = Instance.new("Frame", hpTrack)
	hpBar.BorderSizePixel = 0

	local distLabel = Instance.new("TextLabel", container)
	distLabel.BackgroundTransparency = 1
	distLabel.Font = Enum.Font.RobotoMono
	distLabel.TextSize = 10
	distLabel.TextStrokeTransparency = 0.3
	distLabel.Visible = false

	local roleLabel = Instance.new("TextLabel", container)
	roleLabel.BackgroundTransparency = 1
	roleLabel.Font = Enum.Font.GothamBold
	roleLabel.TextSize = 10
	roleLabel.TextStrokeTransparency = 0.3
	roleLabel.Visible = false

	local snapline = Instance.new("Frame", container)
	snapline.AnchorPoint = Vector2.new(0.5, 0.5)
	snapline.BorderSizePixel = 0
	snapline.Visible = false

	local arrowIndicator = Instance.new("Frame", container)
	arrowIndicator.Size = UDim2.new(0, 16, 0, 16)
	arrowIndicator.AnchorPoint = Vector2.new(0.5, 0.5)
	arrowIndicator.BackgroundTransparency = 1
	arrowIndicator.Visible = false

	local arrowLabel = Instance.new("TextLabel", arrowIndicator)
	arrowLabel.Size = UDim2.new(1, 0, 1, 0)
	arrowLabel.BackgroundTransparency = 1
	arrowLabel.Font = Enum.Font.GothamBold
	arrowLabel.Text = "▶"
	arrowLabel.TextSize = 16

	local skeletonLines = {}
	for i = 1, 15 do
		local line = Instance.new("Frame", container)
		line.AnchorPoint = Vector2.new(0.5, 0.5)
		line.BorderSizePixel = 0
		line.Visible = false
		table.insert(skeletonLines, line)
	end

	local data = {
		container = container,
		box = boxFrame,
		stroke = boxStroke,
		gradient = boxGradient,
		corners = corners,
		cTL_H = cTL_H, cTL_V = cTL_V, cTR_H = cTR_H, cTR_V = cTR_V,
		cBL_H = cBL_H, cBL_V = cBL_V, cBR_H = cBR_H, cBR_V = cBR_V,
		hpTrack = hpTrack,
		hpBar = hpBar,
		dist = distLabel,
		role = roleLabel,
		snapline = snapline,
		arrow = arrowIndicator,
		arrowLabel = arrowLabel,
		skeletonLines = skeletonLines
	}

	cached2D[player] = data
	return data
end

local function apply3DAdornments(character)
	local hrp = character:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local box3D = character:FindFirstChild("Anxium3DWire")
	if not box3D then
		box3D = Instance.new("SelectionBox", character)
		box3D.Name = "Anxium3DWire"
		box3D.LineThickness = 0.04
		box3D.SurfaceTransparency = 1
		box3D.Adornee = character
	end

	box3D.Color3 = settings.box3DColor
	box3D.Visible = settings.box3D

	local fill3D = character:FindFirstChild("Anxium3DFill")
	if not fill3D then
		fill3D = Instance.new("BoxHandleAdornment", character)
		fill3D.Name = "Anxium3DFill"
		fill3D.Size = Vector3.new(3.8, 5.2, 2.2)
		fill3D.CFrame = CFrame.new(0, -0.2, 0)
		fill3D.Transparency = 0.7
		fill3D.AlwaysOnTop = true
		fill3D.ZIndex = 2
		fill3D.Adornee = hrp
	end

	fill3D.Color3 = settings.box3DFillColor
	fill3D.Visible = settings.box3DFill
end

playersService.PlayerRemoving:Connect(function(plr)
	if cached2D[plr] then
		cached2D[plr].container:Destroy()
		cached2D[plr] = nil
	end
	playerHealthCache[plr] = nil
end)

local boxOffsets = {
	Vector3.new(-1.8, 2.7, -1.2),
	Vector3.new(1.8, 2.7, -1.2),
	Vector3.new(-1.8, -2.7, -1.2),
	Vector3.new(1.8, -2.7, -1.2),
	Vector3.new(-1.8, 2.7, 1.2),
	Vector3.new(1.8, 2.7, 1.2),
	Vector3.new(-1.8, -2.7, 1.2),
	Vector3.new(1.8, -2.7, 1.2),
}

local function executeAutoKill()
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local bp = localPlayer:FindFirstChild("Backpack")
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	local knife = (char and char:FindFirstChild("Knife")) or (bp and bp:FindFirstChild("Knife"))
	if not knife or not hrp or not hum then return end

	if knife.Parent == bp then hum:EquipTool(knife) end

	local index = 0
	for _, plr in ipairs(playersService:GetPlayers()) do
		if plr ~= localPlayer and plr.Character then
			local tChar = plr.Character
			local tHrp = tChar and tChar:FindFirstChild("HumanoidRootPart")
			local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")

			if tHrp and tHum and tHum.Health > 0 then
				index = index + 1
				tHrp.Anchored = true
				tHrp.CFrame = hrp.CFrame * CFrame.new(0, 0, -2.5 - (index * 0.3))
				knife:Activate()
				local handle = knife:FindFirstChild("Handle")
				if handle and typeof(firetouchinterest) == "function" then
					firetouchinterest(handle, tHrp, 0)
					firetouchinterest(handle, tHrp, 1)
				end
			end
		end
	end
end

local function spawnJumpPulse(position)
	local pulsePart = Instance.new("Part", workspace)
	pulsePart.Name = "JumpPulseRing"
	pulsePart.Size = Vector3.new(2, 0.05, 2)
	pulsePart.CFrame = CFrame.new(position)
	pulsePart.Anchored = true
	pulsePart.CanCollide = false
	pulsePart.CastShadow = false
	pulsePart.Material = Enum.Material.Neon
	pulsePart.Color = settings.jumpPulseColor
	pulsePart.Transparency = 0.2

	local pulseMesh = Instance.new("SpecialMesh", pulsePart)
	pulseMesh.MeshType = Enum.MeshType.Cylinder

	local tween = tweenService:Create(pulsePart, TweenInfo.new(0.65, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
		Size = Vector3.new(16, 0.05, 16),
		Transparency = 1
	})
	tween:Play()
	debrisService:AddItem(pulsePart, 0.7)
end

local function setupLocalCharHooks(char)
	local hum = char:WaitForChild("Humanoid", 5)
	if hum then
		hum.StateChanged:Connect(function(oldState, newState)
			if newState == Enum.HumanoidStateType.Jumping then
				if settings.jumpPowerHack and settings.jumpPowerMethod == "Impulse" then
					local hrp = char:FindFirstChild("HumanoidRootPart")
					if hrp then hrp.Velocity = Vector3.new(hrp.Velocity.X, settings.jumpPowerValue, hrp.Velocity.Z) end
				end
				if settings.jumpPulse then
					local hrp = char:FindFirstChild("HumanoidRootPart")
					if hrp then
						local raycastParams = RaycastParams.new()
						raycastParams.FilterDescendantsInstances = {char}
						raycastParams.FilterType = Enum.RaycastFilterType.Exclude
						local hit = workspace:Raycast(hrp.Position, Vector3.new(0, -6, 0), raycastParams)
						local groundPos = hit and hit.Position or (hrp.Position - Vector3.new(0, 2.7, 0))
						spawnJumpPulse(groundPos + Vector3.new(0, 0.05, 0))
					end
				end
			end
		end)
	end
end

if localPlayer.Character then setupLocalCharHooks(localPlayer.Character) end
localPlayer.CharacterAdded:Connect(setupLocalCharHooks)

runService.Stepped:Connect(function()
	if settings.antiFling then
		for _, plr in ipairs(playersService:GetPlayers()) do
			if plr ~= localPlayer and plr.Character then
				for _, part in ipairs(plr.Character:GetChildren()) do
					if part:IsA("BasePart") then part.CanCollide = false end
				end
			end
		end
	end
end)

local lastSafePos = Vector3.new(0, 5, 0)

runService.Heartbeat:Connect(function(dt)
	local char = localPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	local hum = char and char:FindFirstChildOfClass("Humanoid")

	if hrp and hum then
		if hrp.Position.Y > -20 then
			lastSafePos = hrp.Position
		elseif settings.antiVoid and hrp.Position.Y < -40 then
			hrp.CFrame = CFrame.new(lastSafePos + Vector3.new(0, 4, 0))
			hrp.Velocity = Vector3.zero
		end

		local moveDir = hum.MoveDirection
		if settings.bhop then
			if hum.FloorMaterial ~= Enum.Material.Air then
				if moveDir.Magnitude > 0 then hum.Jump = true end
			else
				if moveDir.Magnitude > 0 then
					if settings.strafeType == "Velocity" then
						hrp.Velocity = Vector3.new(moveDir.X * settings.speedValue, hrp.Velocity.Y, moveDir.Z * settings.speedValue)
					elseif settings.strafeType == "CFrame" then
						hrp.CFrame = hrp.CFrame + (moveDir * (settings.speedValue * dt))
					else
						local forward = camera.CFrame.LookVector
						local flat = Vector3.new(forward.X, 0, forward.Z).Unit
						hrp.Velocity = Vector3.new(flat.X * settings.speedValue, hrp.Velocity.Y, flat.Z * settings.speedValue)
						hrp.CFrame = hrp.CFrame + (moveDir * 0.15)
					end
				end
			end
		end

		if settings.speedHack and not settings.bhop then
			if settings.speedMethod == "Humanoid" then
				hum.WalkSpeed = settings.speedValue
			elseif settings.speedMethod == "Velocity" then
				if moveDir.Magnitude > 0 then hrp.Velocity = Vector3.new(moveDir.X * settings.speedValue, hrp.Velocity.Y, moveDir.Z * settings.speedValue) end
			elseif settings.speedMethod == "CFrame" then
				if moveDir.Magnitude > 0 then hrp.CFrame = hrp.CFrame + (moveDir * (settings.speedValue * dt)) end
			end
		end

		if settings.jumpPowerHack and settings.jumpPowerMethod == "Humanoid" then
			hum.UseJumpPower = true
			hum.JumpPower = settings.jumpPowerValue
		end
	end
end)

runService.RenderStepped:Connect(function(dt)
	pcall(function()
		local char = localPlayer.Character
		local hrp = char and char:FindFirstChild("HumanoidRootPart")
		local mousePos = userInputService:GetMouseLocation()

		if settings.showFov then
			fovCircleFrame.Position = UDim2.new(0, mousePos.X - fovRadius, 0, mousePos.Y - fovRadius)
			fovCircleFrame.Visible = true
		else
			fovCircleFrame.Visible = false
		end

		if settings.crosshair then
			crosshairContainer.Position = UDim2.new(0, mousePos.X - 22, 0, mousePos.Y - 22)
			if settings.crosshairSpin then
				crosshairAngle = (crosshairAngle + (dt * 200)) % 360
				crosshairContainer.Rotation = crosshairAngle
			end
		end

		if settings.autoKill and resolveRole(localPlayer) == "Murderer" then executeAutoKill() end

		if settings.glassChams or settings.glassChamsMM2 then
			for _, p in ipairs(playersService:GetPlayers()) do
				if p.Character then
					local tintColor = settings.glassChamsColor
					if settings.glassChamsMM2 then
						local role = resolveRole(p)
						if role == "Murderer" then tintColor = colors.murderer
						elseif role == "Sheriff" then tintColor = colors.sheriff
						elseif role == "Hero" then tintColor = colors.hero
						else tintColor = colors.innocent end
					end
					if settings.glassChamsAll or settings.glassChamsMM2 or p == localPlayer then
						applyGlassChamsToChar(p.Character, tintColor)
					end
				end
			end
		end

		if settings.aura and hrp then
			if #auraObjects.parts == 0 or not hrp:FindFirstChild("AnimeBodyFlame") then
				cleanAnimeAura()
				buildAnimeAura()
			end

			local timeNow = tick()
			if auraObjects.floorRing then
				auraObjects.floorRing.CFrame = CFrame.new(hrp.Position - Vector3.new(0, 2.75, 0)) * CFrame.Angles(0, timeNow * 3, 0)
			end

			for _, node in ipairs(auraObjects.parts) do
				local curAngle = (timeNow * node.speed) + node.phase
				local bob = node.isFloor and 0 or (math.sin(timeNow * 8.5 + node.phase) * 0.25)
				local localPos = Vector3.new(
					math.cos(curAngle) * node.radius,
					node.heightOffset + bob,
					math.sin(curAngle) * node.radius
				)
				node.part.CFrame = CFrame.new(hrp.Position + localPos)
			end
		else
			if #auraObjects.parts > 0 or #auraObjects.emitters > 0 then cleanAnimeAura() end
		end

		silentAimTarget = nil
		local shortestDist = fovRadius

		for _, plr in ipairs(playersService:GetPlayers()) do
			if plr ~= localPlayer then
				local tChar = plr.Character
				local tHrp = tChar and tChar:FindFirstChild("HumanoidRootPart")
				local tHead = tChar and tChar:FindFirstChild("Head")
				local tHum = tChar and tChar:FindFirstChildOfClass("Humanoid")
				local ui = getOrCreate2D(plr)

				if tChar and tHrp and tHum then
					local lastHealth = playerHealthCache[plr] or tHum.Health
					local tool = char and char:FindFirstChildOfClass("Tool")
					local isNear = hrp and ((tHrp.Position - hrp.Position).Magnitude < 40) or false

					if tHum.Health <= 0 and lastHealth > 0 then
						if tool and (tool.Name == "Knife" or tool.Name == "Gun") and isNear then
							if settings.playKillSound then playCustomSound(soundCache.kill) end
							if settings.killFlash then triggerKillFlash() end
						end
					elseif tHum.Health < lastHealth and lastHealth > 0 then
						if tool and (tool.Name == "Knife" or tool.Name == "Gun") and isNear then
							if settings.playHitSound then playCustomSound(soundCache.hit) end
						end
					end

					playerHealthCache[plr] = tHum.Health

					if tHum.Health > 0 then
						local role = resolveRole(plr)
						local visibleRole = settings.espAll
							or (settings.espMurder and role == "Murderer")
							or (settings.espSheriff and role == "Sheriff")
							or (settings.espHero and role == "Hero")
							or (settings.espInnocents and role == "Innocent")

						local roleColor = colors.innocent
						if role == "Murderer" then roleColor = colors.murderer
						elseif role == "Sheriff" then roleColor = colors.sheriff
						elseif role == "Hero" then roleColor = colors.hero
						end

						if visibleRole then
							applyHighlight(tChar, roleColor, "AnxiumESP")
						else
							stripHighlight(tChar, "AnxiumESP")
						end

						if settings.highlightEsp then
							applyHighlight(tChar, settings.highlightColor, "AnxiumCustomHighlight")
						else
							stripHighlight(tChar, "AnxiumCustomHighlight")
						end

						if settings.silentAim then
							local targetBone = settings.silentAimTargetPart == "Head" and tHead or tHrp
							if targetBone then
								local scr, onScreen = camera:WorldToViewportPoint(targetBone.Position)
								if onScreen and scr.Z > 0 then
									local dist = (Vector2.new(scr.X, scr.Y) - mousePos).Magnitude
									if dist < shortestDist then
										shortestDist = dist
										silentAimTarget = targetBone
									end
								end
							end
						end

						apply3DAdornments(tChar)

						if settings.skeletonEsp then
							local isR15 = tHum.RigType == Enum.HumanoidRigType.R15
							local limbPairs = isR15 and r15Limbs or r6Limbs

							for index, line in ipairs(ui.skeletonLines) do
								local pair = limbPairs[index]
								if pair then
									local p1 = tChar:FindFirstChild(pair[1])
									local p2 = tChar:FindFirstChild(pair[2])
									if p1 and p2 then
										local s1, v1 = camera:WorldToViewportPoint(p1.Position)
										local s2, v2 = camera:WorldToViewportPoint(p2.Position)
										if v1 and v2 and s1.Z > 0 and s2.Z > 0 then
											drawScreenLine(line, Vector2.new(s1.X, s1.Y), Vector2.new(s2.X, s2.Y), settings.skeletonColor, 1.4)
										else
											line.Visible = false
										end
									else
										line.Visible = false
									end
								else
									line.Visible = false
								end
							end
						else
							for _, line in ipairs(ui.skeletonLines) do line.Visible = false end
						end

						local minX, minY = math.huge, math.huge
						local maxX, maxY = -math.huge, -math.huge
						local allVisible = true

						for _, offset in ipairs(boxOffsets) do
							local worldPos = tHrp.Position + offset
							local scr, vis = camera:WorldToViewportPoint(worldPos)
							if vis and scr.Z > 0 then
								minX = math.min(minX, scr.X)
								maxX = math.max(maxX, scr.X)
								minY = math.min(minY, scr.Y)
								maxY = math.max(maxY, scr.Y)
							else
								allVisible = false
								break
							end
						end

						local centerScr, centerVis = camera:WorldToViewportPoint(tHrp.Position)

						if settings.arrowEsp then
							if not centerVis or centerScr.Z <= 0 then
								local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
								local dir = (Vector2.new(centerScr.X, centerScr.Y) - screenCenter).Unit
								local borderPos = screenCenter + (dir * math.min(screenCenter.X - 35, screenCenter.Y - 35))
								local angle = math.deg(math.atan2(dir.Y, dir.X))
								ui.arrow.Position = UDim2.new(0, borderPos.X, 0, borderPos.Y)
								ui.arrow.Rotation = angle
								ui.arrowLabel.TextColor3 = settings.arrowEspColor
								ui.arrow.Visible = true
							else
								ui.arrow.Visible = false
							end
						else
							ui.arrow.Visible = false
						end

						if settings.snaplines and centerVis and centerScr.Z > 0 then
							local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)
							local fromPos = settings.snaplineOrigin == "Center" and screenCenter or Vector2.new(screenCenter.X, camera.ViewportSize.Y)
							local toPos = Vector2.new(centerScr.X, maxY)
							local dist = (toPos - fromPos).Magnitude
							local mid = (fromPos + toPos) / 2
							local angle = math.deg(math.atan2(toPos.Y - fromPos.Y, toPos.X - fromPos.X))

							ui.snapline.Size = UDim2.new(0, dist, 0, 1.2)
							ui.snapline.Position = UDim2.new(0, mid.X, 0, mid.Y)
							ui.snapline.Rotation = angle
							ui.snapline.BackgroundColor3 = settings.snaplineColor
							ui.snapline.Visible = true
						else
							ui.snapline.Visible = false
						end

						if allVisible then
							local width = math.clamp(maxX - minX, 6, 2000)
							local height = math.clamp(maxY - minY, 8, 2500)
							local chosenColor = settings.box2DMM2 and roleColor or settings.box2DColor

							if settings.box2D or settings.box2DMM2 then
								ui.box.Size = UDim2.new(0, width, 0, height)
								ui.box.Position = UDim2.new(0, minX, 0, minY)

								if settings.box2DMode == "Corner" then
									ui.stroke.Enabled = false
									local cLen = math.clamp(width * 0.25, 4, 14)
									local cThick = 1.5

									ui.cTL_H.Size = UDim2.new(0, cLen, 0, cThick); ui.cTL_H.Position = UDim2.new(0, 0, 0, 0); ui.cTL_H.BackgroundColor3 = chosenColor; ui.cTL_H.Visible = true
									ui.cTL_V.Size = UDim2.new(0, cThick, 0, cLen); ui.cTL_V.Position = UDim2.new(0, 0, 0, 0); ui.cTL_V.BackgroundColor3 = chosenColor; ui.cTL_V.Visible = true
									ui.cTR_H.Size = UDim2.new(0, cLen, 0, cThick); ui.cTR_H.Position = UDim2.new(1, -cLen, 0, 0); ui.cTR_H.BackgroundColor3 = chosenColor; ui.cTR_H.Visible = true
									ui.cTR_V.Size = UDim2.new(0, cThick, 0, cLen); ui.cTR_V.Position = UDim2.new(1, -cThick, 0, 0); ui.cTR_V.BackgroundColor3 = chosenColor; ui.cTR_V.Visible = true
									ui.cBL_H.Size = UDim2.new(0, cLen, 0, cThick); ui.cBL_H.Position = UDim2.new(0, 0, 1, -cThick); ui.cBL_H.BackgroundColor3 = chosenColor; ui.cBL_H.Visible = true
									ui.cBL_V.Size = UDim2.new(0, cThick, 0, cLen); ui.cBL_V.Position = UDim2.new(0, 0, 1, -cLen); ui.cBL_V.BackgroundColor3 = chosenColor; ui.cBL_V.Visible = true
									ui.cBR_H.Size = UDim2.new(0, cLen, 0, cThick); ui.cBR_H.Position = UDim2.new(1, -cLen, 1, -cThick); ui.cBR_H.BackgroundColor3 = chosenColor; ui.cBR_H.Visible = true
									ui.cBR_V.Size = UDim2.new(0, cThick, 0, cLen); ui.cBR_V.Position = UDim2.new(1, -cThick, 1, -cLen); ui.cBR_V.BackgroundColor3 = chosenColor; ui.cBR_V.Visible = true
								else
									ui.stroke.Enabled = true
									ui.stroke.Color = chosenColor
									for _, c in ipairs(ui.corners) do c.Visible = false end
								end

								if settings.box2DFillMM2 then
									ui.box.BackgroundColor3 = roleColor
									ui.box.BackgroundTransparency = 0.55
									ui.gradient.Color = ColorSequence.new({
										ColorSequenceKeypoint.new(0, roleColor),
										ColorSequenceKeypoint.new(0.5, roleColor:Lerp(Color3.fromRGB(15, 10, 25), 0.5)),
										ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 20))
									})
									ui.gradient.Enabled = true
									ui.box.Visible = true
								elseif settings.box2DFill then
									ui.box.BackgroundColor3 = settings.box2DFillColor
									ui.box.BackgroundTransparency = 0.5
									ui.gradient.Color = ColorSequence.new({
										ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
										ColorSequenceKeypoint.new(0.5, Color3.fromRGB(140, 90, 220)),
										ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 5, 20))
									})
									ui.gradient.Enabled = true
									ui.box.Visible = true
								else
									ui.box.BackgroundTransparency = 1
									ui.gradient.Enabled = false
									ui.box.Visible = true
								end
							else
								ui.box.Visible = false
								for _, c in ipairs(ui.corners) do c.Visible = false end
							end

							if settings.roleEsp then
								ui.role.Text = string.upper(role)
								ui.role.TextColor3 = roleColor
								ui.role.Size = UDim2.new(0, width + 40, 0, 14)
								ui.role.Position = UDim2.new(0, minX - 20, 0, minY - 16)
								ui.role.Visible = true
							else
								ui.role.Visible = false
							end

							if settings.healthBar then
								local hpPercent = math.clamp(tHum.Health / tHum.MaxHealth, 0, 1)
								local barWidth = 3
								local barSpacing = 4

								ui.hpTrack.Size = UDim2.new(0, barWidth, 0, height)
								ui.hpTrack.Position = UDim2.new(0, minX - barWidth - barSpacing, 0, minY)
								ui.hpTrack.Visible = true

								local fillHeight = math.clamp(height * hpPercent, 0, height)
								ui.hpBar.Size = UDim2.new(1, 0, 0, fillHeight)
								ui.hpBar.Position = UDim2.new(0, 0, 1, -fillHeight)
								ui.hpBar.BackgroundColor3 = getHealthColor(hpPercent)
							else
								ui.hpTrack.Visible = false
							end

							if settings.distanceEsp and hrp then
								local dist = (hrp.Position - tHrp.Position).Magnitude
								ui.dist.Text = string.format("[%dm]", math.floor(dist))
								ui.dist.TextColor3 = settings.distanceColor
								ui.dist.Size = UDim2.new(0, width, 0, 14)
								ui.dist.Position = UDim2.new(0, minX, 0, maxY + 2)
								ui.dist.Visible = true
							else
								ui.dist.Visible = false
							end
						else
							ui.box.Visible = false
							ui.hpTrack.Visible = false
							ui.dist.Visible = false
							ui.role.Visible = false
							for _, c in ipairs(ui.corners) do c.Visible = false end
						end
					else
						ui.box.Visible = false
						ui.hpTrack.Visible = false
						ui.dist.Visible = false
						ui.role.Visible = false
						ui.snapline.Visible = false
						ui.arrow.Visible = false
						for _, c in ipairs(ui.corners) do c.Visible = false end
						for _, line in ipairs(ui.skeletonLines) do line.Visible = false end
					end
				else
					ui.box.Visible = false
					ui.hpTrack.Visible = false
					ui.dist.Visible = false
					ui.role.Visible = false
					ui.snapline.Visible = false
					ui.arrow.Visible = false
					for _, c in ipairs(ui.corners) do c.Visible = false end
					for _, line in ipairs(ui.skeletonLines) do line.Visible = false end
				end
			end
		end

		if settings.espGunDrop then
			for _, item in ipairs(workspace:GetDescendants()) do
				if item.Name == "GunDrop" then
					local targetPart = item:IsA("BasePart") and item or item:FindFirstChildWhichIsA("BasePart", true)
					if targetPart then
						applyHighlight(targetPart, colors.gunDrop, "AnxiumGunESP")

						local boxAdorn = targetPart:FindFirstChild("AnxiumGunBox")
						if not boxAdorn then
							boxAdorn = Instance.new("BoxHandleAdornment", targetPart)
							boxAdorn.Name = "AnxiumGunBox"
							boxAdorn.Size = targetPart.Size + Vector3.new(0.5, 0.5, 0.5)
							boxAdorn.Color3 = colors.gunDrop
							boxAdorn.Transparency = 0.35
							boxAdorn.AlwaysOnTop = true
							boxAdorn.ZIndex = 5
							boxAdorn.Adornee = targetPart
						end

						local marker = targetPart:FindFirstChild("AnxiumGunBillboard")
						if not marker then
							marker = Instance.new("BillboardGui", targetPart)
							marker.Name = "AnxiumGunBillboard"
							marker.AlwaysOnTop = true
							marker.Size = UDim2.new(0, 90, 0, 22)
							marker.StudsOffset = Vector3.new(0, 1.8, 0)
							marker.Adornee = targetPart

							local txt = Instance.new("TextLabel", marker)
							txt.Size = UDim2.new(1, 0, 1, 0)
							txt.BackgroundTransparency = 1
							txt.Font = Enum.Font.GothamBold
							txt.Text = "[ GUN DROP ]"
							txt.TextColor3 = colors.gunDrop
							txt.TextSize = 12
							txt.TextStrokeTransparency = 0.2
						end
					end
				end
			end
		else
			for _, item in ipairs(workspace:GetDescendants()) do
				if item.Name == "GunDrop" then
					local targetPart = item:IsA("BasePart") and item or item:FindFirstChildWhichIsA("BasePart", true)
					if targetPart then
						stripHighlight(targetPart, "AnxiumGunESP")
						local marker = targetPart:FindFirstChild("AnxiumGunBillboard")
						if marker then marker:Destroy() end
						local boxAdorn = targetPart:FindFirstChild("AnxiumGunBox")
						if boxAdorn then boxAdorn:Destroy() end
					end
				end
			end
		end
	end)
end)

pcall(function()
	local oldNamecall
	oldNamecall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
		local method = getnamecallmethod()
		if not checkcaller() and (method == "InvokeServer" or method == "FireServer") then
			if self.Name == "ShootGun" and settings.silentAim and silentAimTarget then
				local args = { ... }
				local targetHead = silentAimTarget.Parent:FindFirstChild("Head") or silentAimTarget
				local targetPos = targetHead.Position + (targetHead.AssemblyLinearVelocity * 0.032)

				if typeof(args[2]) == "Vector3" then
					args[2] = targetPos
					return oldNamecall(self, unpack(args))
				elseif typeof(args[1]) == "Vector3" then
					args[1] = targetPos
					return oldNamecall(self, unpack(args))
				end
			end
		end
		return oldNamecall(self, ...)
	end))
end)

userInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		if settings.silentAim and silentAimTarget then
			local char = localPlayer.Character
			local tool = char and char:FindFirstChildOfClass("Tool")
			if tool and tool.Name == "Gun" then
				pcall(function()
					local shootRemote = replicatedStorage:FindFirstChild("ShootGun", true)
					if shootRemote then
						local origin = camera.CFrame.Position
						local targetHead = silentAimTarget.Parent:FindFirstChild("Head") or silentAimTarget
						local targetPos = targetHead.Position + (targetHead.AssemblyLinearVelocity * 0.032)
						if shootRemote:IsA("RemoteFunction") then
							shootRemote:InvokeServer(origin, targetPos)
						elseif shootRemote:IsA("RemoteEvent") then
							shootRemote:FireServer(origin, targetPos)
						end
					end
				end)
			end
		end
	end
end)