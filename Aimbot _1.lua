local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
Camera cục bộ = workspace.CurrentCamera
local HttpService = game:GetService("HttpService")
local TweenService = game:GetService("TweenService")

-- Cấu hình
local AimbotEnabled = false
local TeamCheck = true
local WallCheck = true
FOVRadius cục bộ = 100
ESPEnabled cục bộ = false
local ESPTeamCheck = true
local HighlightColor = Color3.fromRGB(255, 0, 0)
cục bộ FOVRainbow = false
local FOVColor = Color3.fromRGB(0, 255, 0)

-- Vòng tròn FOV
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false

local FOVCircle = Instance.new("Frame")
FOVCircle.Name = "FOV"
FOVCircle.Parent = ScreenGui
FOVCircle.AnchorPoint = Vector2.new(0.5, 0.5)
FOVCircle.Position = UDim2.new(0.5, 0, 0.5, 0)
FOVCircle.Size = UDim2.new(0, FOVRadius * 2, 0, FOVRadius * 2)
FOVCircle.BackgroundTransparency = 1

local UIStroke = Instance.new("UIStroke", FOVCircle)
UIStroke.Thickness = 2
UIStroke.Color = FOVColor

local UICorner = Instance.new("UICorner", FOVCircle)
UICorner.CornerRadius = UDim.new(1, 0)

-- Hiển thị FPS và Ping
local StatsLabel = Instance.new("TextLabel")
StatsLabel.Parent = ScreenGui
StatsLabel.Size = UDim2.new(0, 200, 0, 50)
StatsLabel.Position = UDim2.new(1, -210, 0, 10)
StatsLabel.BackgroundTransparency = 1
StatsLabel.TextColor3 = Color3.new(1, 1, 1)
StatsLabel.TextStrokeTransparency = 0
StatsLabel.Font = Enum.Font.Code
StatsLabel.TextSize = 18
StatsLabel.TextXAlignment = Enum.TextXAlignment.Right

local lastUpdate = tick()
RunService.RenderStepped:Connect(function()
	fps cục bộ = math.floor(1 / RunService.RenderStepped:Wait())
	nếu tick() - lastUpdate >= 0.3 thì
		ping cục bộ = tonumber(string.match(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString(), "%d+")) hoặc 0
		StatsLabel.Text = "FPS: " .. fps .. " | Ping: " .. ping .. "ms"
		lastUpdate = tick()
	kết thúc
kết thúc)

-- Giao diện người dùng Rayfield
local Window = Rayfield:CreateWindow({
	Tên = "Aimbot FOV",
	LoadingTitle = "Đang tải...",
	LoadingSubtitle = "Bởi _zxmisaxz_",
	Lưu cấu hình = {
		Đã bật = true,
		FolderName = "AimbotFOV",
		Tên tệp = "cài đặt"
	},
	KeySystem = false
})

-- Tab chính
local Tab = Window:CreateTab("Main", 4483362458)
Tab:CreateToggle({
	Tên = "Activar Aimbot",
	Giá trị hiện tại = false,
	Callback = function(value)
		AimbotEnabled = giá trị
		FOVCircle.Visible = giá trị
	kết thúc
})
Tab:CreateToggle({
	Tên = "Kiểm tra nhóm",
	Giá trị hiện tại = đúng,
	Callback = function(value)
		TeamCheck = giá trị
	kết thúc
})
Tab:CreateToggle({
	Tên = "Kiểm tra tường",
	Giá trị hiện tại = đúng,
	Callback = function(value)
		WallCheck = giá trị
	kết thúc
})
Tab:CreateSlider({
	Tên = "Tamaño del FOV"
	Phạm vi = {50, 300},
	Bước tăng = 5,
	Giá trị hiện tại = 100,
	Callback = function(value)
		FOVRadius = giá trị
		FOVCircle.Size = UDim2.new(0, value * 2, 0, value * 2)
	kết thúc
})

-- Tab ESP
local ESPTab = Window:CreateTab("ESP", 4483362458)
ESPTab:CreateToggle({
	Tên = "Activar Highlight",
	Giá trị hiện tại = false,
	Callback = function(value)
		ESPEnabled = giá trị
		for _, player in ipairs(Players:GetPlayers()) do
			nếu player ~= LocalPlayer thì
				local highlight = player.Character and player.Character:FindFirstChild("ESPHighlight")
				nếu tô sáng thì
					highlight.Enabled = value and (not ESPTeamCheck or player.Team ~= LocalPlayer.Team)
				kết thúc
			kết thúc
		kết thúc
	kết thúc
})
ESPTab:CreateToggle({
	Tên = "Điểm nổi bật kiểm tra nhóm",
	Giá trị hiện tại = đúng,
	Callback = function(value)
		ESPTeamCheck = giá trị
		for _, player in ipairs(Players:GetPlayers()) do
			nếu player ~= LocalPlayer thì
				local highlight = player.Character and player.Character:FindFirstChild("ESPHighlight")
				nếu tô sáng thì
					highlight.Enabled = ESPEnabled và (không phải giá trị hoặc player.Team ~= LocalPlayer.Team)
				kết thúc
			kết thúc
		kết thúc
	kết thúc
})
ESPTab:CreateColorPicker({
	Tên = "Màu làm nổi bật",
	Màu sắc = Màu nổi bật,
	Callback = function(value)
		Màu nổi bật = giá trị
		for _, player in ipairs(Players:GetPlayers()) do
			local highlight = player.Character and player.Character:FindFirstChild("ESPHighlight")
			nếu tô sáng thì
				highlight.OutlineColor = value
				highlight.FillColor = giá trị
			kết thúc
		kết thúc
	kết thúc
})

-- Tab Trực quan
local VisualTab = Window:CreateTab("Visual", 4483362458)
VisualTab:CreateToggle({
	Tên = "FOV Arcoíris",
	Giá trị hiện tại = false,
	Callback = function(value)
		FOOVRainbow = giá trị
	kết thúc
})
VisualTab:CreateColorPicker({
	Tên = "Color del FOV"
	Màu sắc = FOVColor,
	Callback = function(value)
		FOVColor = giá trị
		nếu không phải FOVRainbow thì
			UIStroke.Color = giá trị
		kết thúc
	kết thúc
})

VisualTab:CreateToggle({
	Tên = "PvP chuyển động chậm",
	Giá trị hiện tại = false,
	Callback = hàm (đã bật)
		nếu được bật thì
			local tween = TweenService:Create(game, TweenInfo.new(0.5), {ClockTime = 0.25})
			tween:Play()
			trò chơi:GetService("RunService"):Set3dRenderingEnabled(true)
			không gian làm việc.Gravity = 100 -- Menos Gravedad ayuda al efecto
		khác
			local tween = TweenService:Create(game, TweenInfo.new(0.5), {ClockTime = 1})
			tween:Play()
			không gian làm việc.Gravity = 196.2 -- Gravedad bởi lỗi
		kết thúc
	kết thúc
})

local Lighting = game:GetService("Lighting")
Hướng dẫn StarsGui địa phương
local OriginalAmbient = Lighting.Ambient
local OriginalOutdoorAmbient = Lighting.OutdoorAmbient
local OriginalBrightness = Lighting.Brightness
local OriginalClockTime = Lighting.ClockTime
local OriginalSky = Lighting:FindFirstChildOfClass("Sky")

VisualTab:CreateToggle({
    Tên = "Modo Cielo PvP Suave",
    Giá trị hiện tại = false,
    Callback = function(value)
        nếu có giá trị thì
            -- Ajustes suaves de luz (crepúsculo)
            Lighting.Ambient = Color3.fromRGB(120, 130, 140)
            Lighting.OutdoorAmbient = Color3.fromRGB(90, 100, 110)
            Độ sáng đèn = 1.5
            Lighting.ClockTime = 18,5 -- atardecer muy suave
            
            -- Cambiar cielo por uno con estrellas
            nếu OriginalSky thì OriginalSky.Enabled = false
            local PvPSky = Instance.new("Sky")
            PvPSky.Name = "PvPSky"
            PvPSky.SkyboxBk = "rbxassetid://1022207611" -- ejemplo cielo estrellado, cambia por uno que te guste
            PvPSky.SkyboxDn = "rbxassetid1022207683"
            PvPSky.SkyboxFt = "rbxassetid1022207746"
            PvPSky.SkyboxLf = "rbxassetid1022207814"
            PvPSky.SkyboxRt = "rbxassetid1022207886"
            PvPSky.SkyboxUp = "rbxassetid1022207958"
            PvPSky.Parent = Ánh sáng
            
            -- Các bài viết trên ScreenGui
            StarsGui = Instance.new("ScreenGui", game.CoreGui)
            StarsGui.Name = "StarsGui"
            StarsGui.IgnoreGuiInset = true
            StarsGui.ResetOnSpawn = false
            
            for i = 1, 50 do
                local star = Instance.new("Frame")
                star.Size = UDim2.new(0, 2, 0, 2)
                star.Position = UDim2.new(math.random(), 0, math.random(), 0)
                star.BackgroundColor3 = Color3.new(1, 1, 1)
                star.BackgroundTransparency = 0.7
                star.BorderSizePixel = 0
                star.AnchorPoint = Vector2.new(0.5, 0.5)
                star.Parent = StarsGui
                
                coroutine.wrap(function()
                    trong khi StarsGui và StarsGui.Parent thì
                        star.BackgroundTransparency = 0.5 + math.sin(tick() * math.random(1,3)) * 0.4
                        chờ (0.1)
                    kết thúc
                kết thúc)()
            kết thúc
            
        khác
            -- Nhà hàng valores originales
            Ánh sáng.Không gian xung quanh = Không gian xung quanh gốc
            Lighting.OutdoorAmbient = OriginalOutdoorAmbient
            Độ sáng ánh sáng = Độ sáng gốc
            Lighting.ClockTime = OriginalClockTime
            
            local PvPSky = Lighting:FindFirstChild("PvPSky")
            nếu PvPSky thì PvPSky:Destroy() kết thúc
            if OriginalSky then OriginalSky.Enabled = true end
            
            nếu StarsGui thì
                StarsGui:Destroy()
                StarsGui = nil
            kết thúc
        kết thúc
    kết thúc
})

-- Tab Tối ưu hóa
OptimTab cục bộ = Window:CreateTab("Optimización", 4483362458)

OptimTab:CreateButton({
	Tên = "Tối ưu hóa FPS (mejora rendimiento)",
	Callback = hàm()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		for _, v in ipairs(workspace:GetDescendants()) do
			nếu v:IsA("BasePart") thì
				v.Material = Enum.Material.SmoothPlastic
				v.Reflectance = 0
			elseif v:IsA("Decal") then
				v.Tính trong suốt = 1
			elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
				v.Enabled = false
			kết thúc
		kết thúc
	kết thúc
})

local FPSUnlockerEnabled = false

OptimTab:CreateToggle({
	Tên = "Trình mở khóa FPS (sin límite de 60 FPS)",
	Giá trị hiện tại = false,
	Callback = function(value)
		FPSUnlockerEnabled = giá trị
		nếu có giá trị thì
			setfpscap(1000)
		khác
			setfpscap(60)
		kết thúc
	kết thúc
})

OptimTab:CreateButton({
    Name = "Optimizar Ping (menos uso de red)",
    Callback = hàm()
        -- Desactiva replicación innecesaria trực quan
        for _, obj in ipairs(workspace:GetDescendants()) do
            nếu obj:IsA("ParticleEmitter") hoặc obj:IsA("Trail") hoặc obj:IsA("Beam") thì
                obj.Enabled = false
            elseif obj:IsA("Explosion") then
                obj.Visible = false
            kết thúc
        kết thúc

        -- Giảm tỷ lệ Vật lý (menos carga de red para cosas innecesarias)
        settings().Physics.AllowSleep = true
        settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Default

        -- Vô hiệu hóa các nhu cầu chiếu sáng toàn cầu
        game:GetService("Lighting").GlobalShadows = false
        trò chơi:GetService("Lighting").FogEnd = 100000 -- sin niebla

        -- Baja el nivel de detalle de terreno (si aplica)
        workspace.Terrain.WaterWaveSize = 0
        workspace.Terrain.WaterWaveSpeed = 0
        workspace.Terrain.WaterReflectance = 0
        workspace.Terrain.WaterTransparency = 1

        -- Tối thiểu hóa hiệu ứng giao diện người dùng được sử dụng trong các lần truy cập (nếu có nhiều GUI)
        for _, gui in ipairs(game.CoreGui:GetDescendants()) do
            nếu gui:IsA("ImageLabel") hoặc gui:IsA("ImageButton") thì
                gui.ImageTransparency = 0.2
            kết thúc
        kết thúc

        Rayfield:Notify({
            Tiêu đề = "Ping đã được tối ưu hóa",
            Nội dung = "Giảm sử dụng ứng dụng màu đỏ. Có thể tham gia PvP.",
            Thời lượng = 5
        })
    kết thúc
})

OptimTab:CreateButton({
    Tên = "Skybox PvP (estilo brillante)",
    Callback = hàm()
        local Lighting = game:GetService("Lighting")
        for _, v in ipairs(Lighting:GetChildren()) do
            if v:IsA("Sky") then v:Destroy() end
        kết thúc

        local sky = Instance.new("Sky", Lighting)
        sky.SkyboxBk = "rbxassetid://159454299" -- Bạn có thể sửa lỗi ID bởi otros más PvP
        sky.SkyboxDn = "rbxassetid159454296"
        sky.SkyboxFt = "rbxassetid159454293"
        sky.SkyboxLf = "rbxassetid159454286"
        sky.SkyboxRt = "rbxassetid159454300"
        sky.SkyboxUp = "rbxassetid159454288"
        sky.StarCount = 3000
        sky.SunAngularSize = 0
        sky.MoonAngularSize = 11
        Lighting.TimeOfDay = "18:00:00"
    kết thúc
})

-- Điểm nổi bật
hàm cục bộ ApplyHighlight(player)
	nếu không phải player.Character thì trả về end
	local existing = player.Character:FindFirstChild("ESPHighlight")
	nếu tồn tại thì hủy bỏ()

	local highlight = Instance.new("Highlight")
	highlight.Name = "ESPHighlight"
	highlight.FillTransparency = 1
	highlight.OutlineTransparency = 0
	highlight.OutlineColor = HighlightColor
	highlight.FillColor = HighlightColor
	highlight.Enabled = ESPEnabled và (không phải ESPTeamCheck hoặc player.Team ~= LocalPlayer.Team)
	highlight.Parent = player.Character
kết thúc

hàm cục bộ SetupCharacterHighlight(player)
	nếu player ~= LocalPlayer thì
		player.CharacterAdded:Connect(function()
			lặp lại tác vụ.wait() cho đến khi player.Character và player.Character:FindFirstChild("HumanoidRootPart")
			ApplyHighlight(player)
		kết thúc)
	kết thúc
kết thúc

for _, player in ipairs(Players:GetPlayers()) do
	Thiết lập làm nổi bật nhân vật (người chơi)
	nếu player.Character thì
		ApplyHighlight(player)
	kết thúc
kết thúc

Người chơi.Người chơi đã thêm:Kết nối(hàm(người chơi)
	Thiết lập làm nổi bật nhân vật (người chơi)
kết thúc)

-- Aimbot
hàm cục bộ GetClosestTarget()
	người gần nhất cục bộ = nil
	local shortestDist = FOVRadius

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			Nếu TeamCheck và player.Team == LocalPlayer.Team thì tiếp tục.

			local pos, onScreen = Camera:WorldToViewportPoint(player.Character.HumanoidRootPart.Position)
			nếu hiển thị trên màn hình thì
				local center = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y/2)
				khoảng cách cục bộ = (Vector2.new(pos.X, pos.Y) - center).Magnitude

				nếu dist <= shortestDist thì
					nếu WallCheck thì
						gốc cục bộ = Camera.CFrame.Vị trí
						hướng cục bộ = (player.Character.HumanoidRootPart.Position - origin).Unit * 1000
						local raycastParams = RaycastParams.new()
						raycastParams.FilterDescendantsInstances = {LocalPlayer.Character}
						raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

						kết quả cục bộ = workspace:Raycast(origin, direction, raycastParams)
						nếu kết quả và kết quả.Instance:IsDescendantOf(player.Character) thì
							gần nhất = người chơi
							khoảng cách ngắn nhất = khoảng cách
						kết thúc
					khác
						gần nhất = người chơi
						khoảng cách ngắn nhất = khoảng cách
					kết thúc
				kết thúc
			kết thúc
		kết thúc
	kết thúc

	trở lại điểm gần nhất
kết thúc

RunService.RenderStepped:Connect(function()
	nếu FOVRainbow thì
		màu sắc cục bộ = tick() % 5 / 5
		màu cục bộ = Color3.fromHSV(hue, 1, 1)
		UIStroke.Color = màu
	kết thúc

	nếu AimbotEnabled thì
		mục tiêu cục bộ = GetClosestTarget()
		nếu target và target.Character và target.Character:FindFirstChild("HumanoidRootPart") thì
			local head = target.Character.HumanoidRootPart.Position
			local camPos = Camera.CFrame.Position
			local newCF = CFrame.new(camPos, head)
			Camera.CFrame = Camera.CFrame:Lerp(newCF, 0.4)
		kết thúc
	kết thúc
kết thúc)
