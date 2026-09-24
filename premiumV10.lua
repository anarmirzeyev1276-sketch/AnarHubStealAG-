-- ==========================================
-- STEAL AN EGG - PREMIUM ULTIMATE HUB V10 (BY ANAR)
-- ==========================================

local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local Title = Instance.new("TextLabel")
local Subtitle = Instance.new("TextLabel")
local UIListLayout = Instance.new("UIListLayout")

ScreenGui.Name = "AnarUltimateHubV10"
ScreenGui.Parent = game:GetService("CoreGui") or game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 22)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.05, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 240, 0, 250)
MainFrame.Active = true
MainFrame.Draggable = true

Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(22, 22, 32)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 35)
Title.Font = Enum.Font.GothamBold
Title.Text = "Anar etdi!"
Title.TextColor3 = Color3.fromRGB(0, 255, 150)
Title.TextSize = 18.000

Subtitle.Name = "Subtitle"
Subtitle.Parent = MainFrame
Subtitle.BackgroundTransparency = 1.000
Subtitle.Position = UDim2.new(0, 0, 0, 35)
Subtitle.Size = UDim2.new(1, 0, 0, 20)
Subtitle.Font = Enum.Font.Gotham
Subtitle.Text = "Premium Pro Mod Menu V10"
Subtitle.TextColor3 = Color3.fromRGB(160, 160, 160)
Subtitle.TextSize = 11.000

UIListLayout.Parent = MainFrame
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 6)

-- RGB / RAINBOW MENYU EFFEKTİ
task.spawn(function()
    while true do
        for i = 0, 1, 0.001 do
            Title.TextColor3 = Color3.fromHSV(i, 1, 1)
            task.wait(0.01)
        end
    end
end)

-- BİRBRAŞA KLİK DÜYMƏSİ YARATMA
local function CreateSimpleButton(name, text, callback)
    local Button = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")

    Button.Name = name .. "Btn"
    Button.Parent = MainFrame
    Button.BackgroundColor3 = Color3.fromRGB(30, 45, 60)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(0, 210, 0, 30)
    Button.Font = Enum.Font.GothamBold
    Button.Text = text
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 12.000
    
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        pcall(callback)
    end)
end

-- AÇILIB-BAĞLANAN DÜYMƏ SİSTEMİ
local function CreateToggle(name, defaultOffText, defaultOnText, callback)
    local Button = Instance.new("TextButton")
    local UICorner = Instance.new("UICorner")
    local enabled = false

    Button.Name = name .. "Btn"
    Button.Parent = MainFrame
    Button.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(0, 210, 0, 30)
    Button.Font = Enum.Font.GothamSemibold
    Button.Text = defaultOffText
    Button.TextColor3 = Color3.fromRGB(255, 90, 90)
    Button.TextSize = 12.000
    
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Button

    Button.MouseButton1Click:Connect(function()
        enabled = not enabled
        if enabled then
            Button.BackgroundColor3 = Color3.fromRGB(35, 55, 40)
            Button.TextColor3 = Color3.fromRGB(90, 255, 90)
            Button.Text = defaultOnText
        else
            Button.BackgroundColor3 = Color3.fromRGB(28, 28, 38)
            Button.TextColor3 = Color3.fromRGB(255, 90, 90)
            Button.Text = defaultOffText
        end
        pcall(callback, enabled)
    end)
end

-- ==========================================
-- SİSTEM VƏ MODULLAR
-- ==========================================
local Players = game:Service("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:Service("RunService")
local Workspace = game:Service("Workspace")
local UserInputService = game:Service("UserInputService")
local MarketplaceService = game:GetService("MarketplaceService")

-- 1. CUSTOM FOV MODIFIER (KAMERA GÜCÜ)
local fovActive = false
local _FovValue = 120

RunService.RenderStepped:Connect(function()
    if fovActive then
        Workspace.CurrentCamera.FieldOfView = _FovValue
    else
        Workspace.CurrentCamera.FieldOfView = 70
    end
end)

-- 2. BUY ALL GAMEPASSES FREE
local allGamepassesUnlocked = false
local function BuyAllGamepassesFree()
    allGamepassesUnlocked = true
    local hook
    hook = hookmetamethod(game, "__index", function(self, key)
        if allGamepassesUnlocked and self == MarketplaceService and (key == "UserOwnsGamePassAsync" or key == "PlayerOwnsAsset") then
            return function() return true end
        end
        return hook(self, key)
    end)
end

-- 3. K DÜYMƏSİ İLƏ MENYUNU GİZLƏDİB-AÇMAQ
UserInputService.InputBegan:Connect(function(input, gpe)
    if not gpe and input.KeyCode == Enum.KeyCode.K then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- 4. MANUEL KICK YOU
local function ManualKick()
    LocalPlayer:Kick("Təcili Çıxış: Düyməyə basaraq oyundan özünüz çıxdınız.")
end

-- ==========================================
-- DÜYMƏLƏRİ INTERFEYSƏ YERLƏŞDİRMƏK
-- ==========================================
task.wait(0.2)
CreateSimpleButton("BuyAll", "🎁 Buy All Gamepass Free!", function() BuyAllGamepassesFree() end)
CreateToggle("FovToggle", "Kamera Gücü (FOV): OFF", "Kamera Gücü (FOV): ON", function(state) fovActive = state end)
CreateSimpleButton("KickYou", "🛑 KICK YOU (Oyundan Çıx)", function() ManualKick() end)

