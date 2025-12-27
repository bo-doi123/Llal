-- 🌟 SUPER HACK MENU 2025 - PHIÊN BẢN NÂNG CẤP SIÊU MẠNH 🌟
-- Thêm: Kill Aura + Infinity Kill Aura | Speed tùy chỉnh | Gravity tùy chỉnh | Tàng hình | Anti Knockback | Fling Punch (đấm bay siêu xa) 
-- Boost FPS SIÊU MẠNH: Xóa skin, giảm pixel, dọn RAM liên tục, giảm chunk load, xóa toàn bộ hiệu ứng
-- An toàn: Chủ yếu client-side (một số tính năng như Kill Aura/Fling có thể bị detect ở game có anti-cheat mạnh - dùng acc phụ nhé!)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local StarterGui = game:GetService("StarterGui")
local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- Tạo GUI Siêu Đẹp (cập nhật thêm nhiều nút)
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "UltimateHackMenu2025"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 420, 0, 680)  -- To hơn để chứa thêm nút
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -340)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 18)
UICorner.Parent = MainFrame

local UIGradient = Instance.new("UIGradient")
UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0, Color3.fromRGB(50, 50, 80)), ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 20))}
UIGradient.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 60)
Title.BackgroundTransparency = 1
Title.Text = "🌟 ULTIMATE HACK MENU 2025 🌟"
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.TextScaled = true
Title.Font = Enum.Font.GothamBlack
Title.Parent = MainFrame

local CloseButton = Instance.new("TextButton")
CloseButton.Size = UDim2.new(0, 40, 0, 40)
CloseButton.Position = UDim2.new(1, -50, 0, 10)
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.new(1,1,1)
CloseButton.TextScaled = true
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Parent = MainFrame
Instance.new("UICorner", CloseButton).CornerRadius = UDim.new(0, 10)

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)

-- Biến trạng thái
local Toggles = {
    FPSBoost = false,
    Aimbot = false,
    ESP = false,
    Fly = false,
    Noclip = false,
    KillAura = false,
    InfinityAura = false,
    Invisible = false,
    AntiKB = false,
    FlingPunch = false
}

local Settings = {
    Speed = 50,
    Gravity = 196.2,
    AuraRange = 15,
    InfinityRange = 50
}

-- FPS + Ping Display
local StatsLabel = Instance.new("TextLabel")
StatsLabel.Size = UDim2.new(1, -20, 0, 40)
StatsLabel.Position = UDim2.new(0, 10, 1, -50)
StatsLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
StatsLabel.Text = "FPS: -- | Ping: -- ms"
StatsLabel.TextColor3 = Color3.fromRGB(0, 255, 100)
StatsLabel.TextScaled = true
StatsLabel.Font = Enum.Font.GothamSemibold
StatsLabel.Parent = MainFrame
Instance.new("UICorner", StatsLabel).CornerRadius = UDim.new(0, 10)

spawn(function()
    while wait(0.5) do
        local fps = math.floor(1 / RunService.RenderStepped:Wait())
        local ping = player:GetNetworkPing() * 1000
        StatsLabel.Text = string.format("FPS: %d 🔥 | Ping: %.0f ms", fps, ping)
        StatsLabel.TextColor3 = fps >= 144 and Color3.fromRGB(0,255,0) or fps >= 60 and Color3.fromRGB(255,255,0) or Color3.fromRGB(255,0,0)
    end
end)

-- Hàm tạo nút toggle
local function CreateToggle(name, text, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -40, 0, 50)
    btn.Position = UDim2.new(0, 20, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
    btn.Text = "❌ " .. text
    btn.TextColor3 = Color3.fromRGB(255, 100, 100)
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.Parent = MainFrame
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 12)
    
    btn.MouseButton1Click:Connect(function()
        Toggles[name] = not Toggles[name]
        if Toggles[name] then
            btn.Text = "✅ " .. text
            btn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
            btn.TextColor3 = Color3.fromRGB(200, 255, 200)
        else
            btn.Text = "❌ " .. text
            btn.BackgroundColor3 = Color3.fromRGB(40, 40, 55)
            btn.TextColor3 = Color3.fromRGB(255, 100, 100)
        end
    end)
    return btn
end

-- Tạo nút
CreateToggle("FPSBoost", "🚀 BOOST FPS SIÊU MẠNH (Max Opti)", 80)
CreateToggle("Aimbot", "🎯 AIMBOT + CIRCLE", 140)
CreateToggle("ESP", "👁️ ESP BOX + HEALTH + TRACER", 200)
CreateToggle("Fly", "🕊️ FLY (E để bay)", 260)
CreateToggle("Noclip", "👻 NOCLIP", 320)
CreateToggle("KillAura", "⚔️ KILL AURA (Gần)", 380)
CreateToggle("InfinityAura", "☠️ INFINITY KILL AURA", 440)
CreateToggle("Invisible", "🕶️ TÀNG HÌNH (Client)", 500)
CreateToggle("AntiKB", "🛡️ ANTI KNOCKBACK", 560)
CreateToggle("FlingPunch", "👊 ĐẤM PHÁT BAY SIÊU XA", 620)

-- ============== BOOST FPS SIÊU MẠNH ==============
local function UltraFPSBoost()
    settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 0
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    
    -- Xóa toàn bộ Post Effects
    for _, v in pairs(Lighting:GetChildren()) do
        if v:IsA("PostEffect") then v:Destroy() end
    end
    
    -- Xóa skin, decal, texture (giảm pixel nặng)
    for _, obj in pairs(Workspace:GetDescendants()) do
        if obj:IsA("Decal") or obj:IsA("Texture") or obj:IsA("SurfaceAppearance") or obj:IsA("MeshPart") then
            obj.Transparency = 1
            if obj:FindFirstChild("MeshId") then obj.MeshId = "" end
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") or obj:IsA("Smoke") or obj:IsA("Fire") or obj:IsA("Sparkles") or obj:IsA("Beam") then
            obj.Enabled = false
        elseif obj:IsA("BasePart") then
            obj.Material = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
            obj.CastShadow = false
        end
    end
    
    -- Giảm chunk load & terrain detail
    pcall(function()
        Workspace.Terrain.WaterWaveSize = 0
        Workspace.Terrain.WaterWaveSpeed = 0
        Workspace.Terrain.WaterReflectance = 0
        Workspace.Terrain.WaterTransparency = 1
        settings().Rendering.EagerBulkExecution = true
    end)
    
    -- Unlock FPS + dọn RAM liên tục
    if setfpscap then setfpscap(9999) end
    spawn(function()
        while Toggles.FPSBoost do
            collectgarbage("collect")
            wait(2)
        end
    end)
end

-- ============== CÁC TÍNH NĂNG KHÁC (giữ nguyên từ trước) ==============
-- (Aimbot Circle, ESP, Fly, Noclip - giữ nguyên code cũ để ngắn gọn)

-- ============== KILL AURA & INFINITY AURA ==============
local function KillAuraLoop()
    if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then return end
    local root = player.Character.HumanoidRootPart
    local range = Toggles.InfinityAura and Settings.InfinityRange or Settings.AuraRange
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local dist = (p.Character.HumanoidRootPart.Position - root.Position).Magnitude
            if dist <= range then
                -- Tạo hit giả (client-side animation + damage nếu game cho phép)
                if player.Character:FindFirstChild("RightHand") or player.Character:FindFirstChild("Right Arm") then
                    local tool = player.Character:FindFirstChildOfClass("Tool") or player.Backpack:FindFirstChildOfClass("Tool")
                    if tool then
                        tool.Parent = player.Character
                        tool:Activate()
                    end
                end
            end
        end
    end
end

-- ============== SPEED & GRAVITY ==============
local SpeedConnection = nil
local function UpdateSpeedGravity()
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = Toggles.Fly and 16 or Settings.Speed
        player.Character.Humanoid.JumpPower = 50
        if player.Character:FindFirstChild("HumanoidRootPart") then
            local bv = player.Character.HumanoidRootPart:FindFirstChild("CustomGravity")
            if not bv then
                bv = Instance.new("BodyForce")
                bv.Name = "CustomGravity"
                bv.Parent = player.Character.HumanoidRootPart
            end
            bv.Force = Vector3.new(0, player.Character.HumanoidRootPart:GetMass() * Settings.Gravity, 0)
        end
    end
end

-- ============== TÀNG HÌNH (Client-side) ==============
local function ToggleInvisible()
    if player.Character then
        for _, part in pairs(player.Character:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Transparency = Toggles.Invisible and 1 or 0
            elseif part:IsA("Decal") then
                part.Transparency = Toggles.Invisible and 1 or 0
            end
        end
    end
end

-- ============== ANTI KNOCKBACK ==============
local AntiKBConnection = nil
local function AntiKnockback()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.Velocity = Vector3.new(0, player.Character.HumanoidRootPart.Velocity.Y, 0)
        player.Character.HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(0, player.Character.HumanoidRootPart.AssemblyLinearVelocity.Y, 0)
    end
end

-- ============== FLING PUNCH (Đấm phát bay siêu xa) ==============
local FlingActive = false
UserInputService.InputBegan:Connect(function(input)
    if Toggles.FlingPunch and input.UserInputType == Enum.UserInputType.MouseButton1 then
        local target = mouse.Target
        if target and target.Parent and target.Parent:FindFirstChild("Humanoid") then
            local hum = target.Parent.Humanoid
            local root = target.Parent:FindFirstChild("HumanoidRootPart")
            if root then
                local bv = Instance.new("BodyVelocity")
                bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
                bv.Velocity = (root.Position - player.Character.HumanoidRootPart.Position).Unit * 300 + Vector3.new(0, 100, 0)
                bv.Parent = root
                game.Debris:AddItem(bv, 0.5)
            end
        end
    end
end)

-- ============== MAIN LOOP ==============
RunService.RenderStepped:Connect(function()
    if Toggles.FPSBoost then UltraFPSBoost() end
    if Toggles.KillAura or Toggles.InfinityAura then KillAuraLoop() end
    if Toggles.Invisible then ToggleInvisible() end
    if Toggles.AntiKB then AntiKnockback() end
    UpdateSpeedGravity()
    -- (ESP, Aimbot, Fly, Noclip giữ nguyên)
end)

StarterGui:SetCore("SendNotification", {
    Title = "Ultimate Hack Menu 2025";
    Text = "Đã load thành công! Bật các tính năng và chiến thôi! ⚡";
    Duration = 8;
})

print("🌟 Ultimate Hack Menu 2025 - Phiên bản nâng cấp đã load! Chúc chơi vui! 🌟")
