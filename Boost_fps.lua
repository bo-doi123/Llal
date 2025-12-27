-- ======================================================
-- ULTIMATE EXTREME FPS BOOST (ALL-IN-ONE)
-- Features: No Fog, Low Chunk, No Skin, No Shader, No Skill Effects
-- ======================================================

local l = game:GetService("Lighting")
local w = game:GetService("Workspace")
local p = game:GetService("Players")
local settings = settings()

-- 1. XÓA SHADER & HẬU KỲ (POST-PROCESSING)
l.GlobalShadows = false
l.FogEnd = 9e9
l.Brightness = 0
l.ExposureCompensation = 0

-- Chuyển công nghệ Render về mức thấp nhất nếu Executor hỗ trợ
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
    -- Giảm chất lượng pixel môi trường
    if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("UnionOperation") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
        v.CastShadow = false
    -- Xóa texture và decal (pixel môi trường)
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v:Destroy()
    -- Xóa hiệu ứng chiêu (Particles, Trail, Fire...)
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
        if v:IsA("ParticleEmitter") then v.Lifetime = NumberRange.new(0) end
    end
end

-- Chạy lần đầu cho toàn map
for _, v in pairs(w:GetDescendants()) do Optimize(v) end
-- Tự động xóa cho các chiêu thức hoặc vật thể mới xuất hiện
w.DescendantAdded:Connect(Optimize)

-- 3. XÓA SKIN NGƯỜI CHƠI (BIẾN THÀNH KHỐI TRƠN)
local function RemoveSkin(char)
    task.wait(0.2) -- Chờ nhân vật load xong rồi mới xóa
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("Clothing") or v:IsA("ShirtGraphic") or v:IsA("Accessory") or v:IsA("CharacterMesh") then
            v:Destroy()
        elseif v:IsA("BasePart") then
            v.Material = Enum.Material.Plastic
            v.Color = Color3.fromRGB(163, 162, 165) -- Màu xám nhẹ cho đỡ lag mắt
            v.CanQuery = true -- Tối ưu vật lý
        end
    end
end

for _, player in pairs(p:GetPlayers()) do
    if player.Character then RemoveSkin(player.Character) end
    player.CharacterAdded:Connect(RemoveSkin)
end

-- 4. GIẢM TỐC ĐỘ TẢI CHUNK & RENDERING LÕI
settings.Rendering.QualityLevel = Enum.QualityLevel.Level01
if sethiddenproperty then
    sethiddenproperty(w, "StreamingTargetRadius", 48) -- Tầm nhìn cực ngắn
    sethiddenproperty(w, "StreamingMinRadius", 32)
end

-- Tắt các hiệu ứng trang trí địa hình (Cỏ, nước gợn sóng)
if w:FindFirstChildOfClass("Terrain") then
    local t = w:FindFirstChildOfClass("Terrain")
    t.WaterWaveSize = 0
    t.WaterWaveSpeed = 0
    t.WaterReflectance = 0
    t.WaterTransparency = 0
    t.Decoration = false
end

print("--- KẾT HỢP HOÀN TẤT: ĐÃ KÍCH HOẠT CHẾ ĐỘ SIÊU MƯỢT ---")
