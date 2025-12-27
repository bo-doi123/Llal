-- ======================================================
-- ULTIMATE BLOX FRUITS FPS BOOST (POTATO V3 - 2025)
-- ======================================================

local l = game:GetService("Lighting")
local w = game:GetService("Workspace")
local p = game:GetService("Players")
local rs = game:GetService("RunService")
local stats = game:GetService("Stats")

-- 1. BẢNG HIỂN THỊ CHỈ SỐ (HUD)
local screenGui = Instance.new("ScreenGui", game.CoreGui)
local infoLabel = Instance.new("TextLabel", screenGui)
infoLabel.Size = UDim2.new(0, 160, 0, 60)
infoLabel.Position = UDim2.new(0, 10, 0, 10)
infoLabel.BackgroundColor3 = Color3.new(0, 0, 0)
infoLabel.BackgroundTransparency = 0.5
infoLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
infoLabel.TextSize = 14
infoLabel.Font = Enum.Font.Code
infoLabel.TextXAlignment = Enum.TextXAlignment.Left

rs.RenderStepped:Connect(function()
    local fps = math.floor(1 / rs.RenderStepped:Wait())
    local ping = math.floor(stats.Network.ServerStatsItem["Data Ping"]:GetValue())
    infoLabel.Text = " FPS: " .. fps .. "\n Ping: " .. ping .. "ms\n Mode: SUPER POTATO"
end)

-- 2. HÀM TỐI ƯU HÓA CHI TIẾT (XÓA CHIÊU & TEXTURE)
local function Optimize(v)
    if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v:Destroy()
    elseif v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") then
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
        v.CastShadow = false
    elseif v:IsA("Atmosphere") or v:IsA("Clouds") or v:IsA("Sky") then
        v:Destroy()
    end
end

-- 3. QUÉT LIÊN TỤC ĐỂ DIỆT CHIÊU MỚI (CHỐNG LAG PVP)
rs.Heartbeat:Connect(function()
    for _, v in pairs(w:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
end)

-- 4. XÓA SKIN VÀ PHỤ KIỆN NGƯỜI CHƠI
local function RemoveSkin(char)
    task.wait(0.2)
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Clothing") or v:IsA("ShirtGraphic") or v:IsA("Accessory") then
            v:Destroy()
        elseif v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
            v.Color = Color3.fromRGB(160, 160, 160)
        end
    end
end

for _, player in pairs(p:GetPlayers()) do
    if player.Character then RemoveSkin(player.Character) end
    player.CharacterAdded:Connect(RemoveSkin)
end

-- 5. CÀI ĐẶT HỆ THỐNG CỰC THẤP
l.GlobalShadows = false
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = 1

if sethiddenproperty then
    sethiddenproperty(l, "Technology", Enum.Technology.Compatibility)
    sethiddenproperty(w, "StreamingTargetRadius", 32)
end

-- Tắt trang trí địa hình (Cỏ, Nước)
if w.Terrain then
    w.Terrain.WaterWaveSize = 0
    w.Terrain.WaterWaveSpeed = 0
    w.Terrain.Decoration = false
end

-- 6. DỌN RAM TỰ ĐỘNG
task.spawn(function()
    while task.wait(30) do
        collectgarbage("collect")
    end
end)

print("--- SCRIPT TỔNG HỢP HOÀN TẤT: ĐÃ BẬT POTATO MODE V3 ---")
