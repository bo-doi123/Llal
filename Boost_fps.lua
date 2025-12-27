-- ======================================================
-- ULTIMATE EXTREME FPS BOOST (ALL-IN-ONE) - VERSION 2025
-- Features: No Fog, Low Chunk, No Skin, No Shader, No Skill Effects, Physics & RAM Optimizer
-- ======================================================

local l = game:GetService("Lighting")
local w = game:GetService("Workspace")
local p = game:GetService("Players")
local rs = game:GetService("RunService")
local settings = settings()

-- 1. XÓA SHADER & HẬU KỲ (POST-PROCESSING)
l.GlobalShadows = false
l.FogEnd = 9e9
l.Brightness = 0
l.ExposureCompensation = 0

if sethiddenproperty then
    sethiddenproperty(l, "Technology", Enum.Technology.Compatibility)
end

for _, v in pairs(l:GetChildren()) do
    if v:IsA("PostEffect") or v:IsA("Bloom") or v:IsA("Blur") or v:IsA("SunRays") or v:IsA("ColorCorrectionEffect") or v:IsA("DepthOfFieldEffect") then
        v.Enabled = false
    end
end

-- 2. GIẢM PIXEL (TEXTURE) & DIỆT SẠCH HIỆU ỨNG CHIÊU
local function Optimize(v)
    if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
        v.CastShadow = false
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v:Destroy()
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
        if v:IsA("ParticleEmitter") then v.Lifetime = NumberRange.new(0) end
    elseif v:IsA("Explosion") then
        v.Visible = false
    end
end

for _, v in pairs(w:GetDescendants()) do Optimize(v) end
w.DescendantAdded:Connect(Optimize)

-- 3. XÓA SKIN NGƯỜI CHƠI (BIẾN THÀNH KHỐI TRƠN)
local function RemoveSkin(char)
    task.wait(0.2)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Clothing") or v:IsA("ShirtGraphic") or v:IsA("Accessory") or v:IsA("CharacterMesh") then
            v:Destroy()
        elseif v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
            v.Color = Color3.fromRGB(163, 162, 165)
        end
    end
end

for _, player in pairs(p:GetPlayers()) do
    if player.Character then RemoveSkin(player.Character) end
    player.CharacterAdded:Connect(RemoveSkin)
end

-- 4. TỐI ƯU VẬT LÝ, CHUNK & HỆ THỐNG
settings.Rendering.QualityLevel = Enum.QualityLevel.Level01
settings.Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Always
settings.Physics.AllowSleep = true

if sethiddenproperty then
    sethiddenproperty(w, "StreamingTargetRadius", 48)
    sethiddenproperty(w, "StreamingMinRadius", 32)
    sethiddenproperty(w, "InterpolationThrottling", Enum.InterpolationThrottlingMode.Enabled)
end

-- Tắt trang trí địa hình (Cỏ, Nước)
if w.Terrain then
    w.Terrain.WaterWaveSize = 0
    w.Terrain.WaterWaveSpeed = 0
    w.Terrain.WaterReflectance = 0
    w.Terrain.WaterTransparency = 0
    sethiddenproperty(w.Terrain, "Decoration", false)
end

-- 5. MODULE DỌN DẸP RAM LIÊN TỤC (ANTI-LAG)
local lastCollect = tick()
rs.Heartbeat:Connect(function()
    if tick() - lastCollect > 30 then -- Dọn rác mỗi 30 giây
        collectgarbage("collect")
        lastCollect = tick()
    end
end)

-- 6. TẠO BẢNG HIỂN THỊ FPS VÀ PING (HUD)
local screenGui = Instance.new("ScreenGui", game.CoreGui)
local infoLabel = Instance.new("TextLabel", screenGui)
infoLabel.Size = UDim2.new(0, 150, 0, 50)
infoLabel.Position = UDim2.new(0, 10, 0, 10)
infoLabel.BackgroundColor3 = Color3.new(0, 0, 0)
infoLabel.BackgroundTransparency = 0.5
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.TextSize = 14
infoLabel.Font = Enum.Font.Code
infoLabel.TextXAlignment = Enum.TextXAlignment.Left

rs.RenderStepped:Connect(function()
    local fps = math.floor(1 / rs.RenderStepped:Wait())
    local ping = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    infoLabel.Text = " FPS: " .. fps .. "\n Ping: " .. ping .. " ms"
end)

print("--- KẾT HỢP HOÀN TẤT: CHẾ ĐỘ POTATO PC/MOBILE ĐÃ BẬT ---")
