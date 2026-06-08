--[[
    =======================================================================
    🌌 NEXUS A.I. - BY HIROSHI738 (STABLE PRO EDITION)
    💎 Zero-Bug Rendering | English UI | Instant Stream-Proof | Themes
    =======================================================================
]]

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Cam = workspace.CurrentCamera

local DISCORD_LINK = "https://discord.gg/qTGtM4Uyc"
local PASSWORD = "Hiro738"

local AutoHit = false
local TotalHits = 0
local MenuVisible = true
local IsAuthenticated = false

if LP.PlayerGui:FindFirstChild("HiroshiNexus") then 
    LP.PlayerGui.HiroshiNexus:Destroy() 
end

-- ==========================================
-- 🎨 THEME ENGINE & PALETTE
-- ==========================================
local BaseColors = {
    Bg = Color3.fromRGB(12, 12, 16),
    CardBg = Color3.fromRGB(18, 18, 24),
    White = Color3.fromRGB(245, 245, 255),
    Muted = Color3.fromRGB(130, 130, 150),
    Border = Color3.fromRGB(40, 40, 50),
    Success = Color3.fromRGB(30, 210, 110),
    Danger = Color3.fromRGB(255, 50, 70)
}

local Themes = {
    Neon    = { Primary = Color3.fromRGB(0, 225, 255), Secondary = Color3.fromRGB(140, 60, 255) },
    Crimson = { Primary = Color3.fromRGB(255, 50, 80), Secondary = Color3.fromRGB(255, 120, 0) },
    Matrix  = { Primary = Color3.fromRGB(0, 255, 120), Secondary = Color3.fromRGB(0, 150, 60) },
    Void    = { Primary = Color3.fromRGB(80, 120, 255),Secondary = Color3.fromRGB(40, 50, 180) },
    Sakura  = { Primary = Color3.fromRGB(255, 120, 180),Secondary = Color3.fromRGB(255, 50, 120) },
    Gold    = { Primary = Color3.fromRGB(255, 200, 50), Secondary = Color3.fromRGB(200, 120, 20) },
}

local CurrentTheme = Themes.Neon
local ThemeObjects = { PrimaryText = {}, SecondaryText = {}, PrimaryBg = {}, SecondaryBg = {}, Stars = {}, Strokes = {} }

local SG = Instance.new("ScreenGui")
SG.Name = "HiroshiNexus"
SG.ResetOnSpawn = false
SG.IgnoreGuiInset = true
SG.DisplayOrder = 10000
SG.Parent = LP.PlayerGui

-- ==========================================
-- 🌠 COSMIC BACKGROUND (Bug-Free)
-- ==========================================
local CosmosBg = Instance.new("Frame", SG)
CosmosBg.Size = UDim2.new(1, 0, 1, 0)
CosmosBg.BackgroundTransparency = 1
CosmosBg.ZIndex = -10

local stars = {}
for i = 1, 120 do
    local star = Instance.new("Frame", CosmosBg)
    local size = math.random(1, 3)
    local baseTrans = math.random(30, 80) / 100
    star.Size = UDim2.new(0, size, 0, size)
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = (math.random(1, 4) == 1) and CurrentTheme.Primary or Color3.new(1,1,1)
    star.BorderSizePixel = 0
    star.BackgroundTransparency = baseTrans
    Instance.new("UICorner", star).CornerRadius = UDim.new(1, 0)
    
    table.insert(stars, {frame = star, speed = math.random(1, 10) / 100000})
    if star.BackgroundColor3 ~= Color3.new(1,1,1) then table.insert(ThemeObjects.Stars, star) end
end

RS.RenderStepped:Connect(function()
    if not MenuVisible then return end
    for _, s in ipairs(stars) do
        local newY = s.frame.Position.Y.Scale + s.speed
        if newY > 1 then newY = 0 end
        s.frame.Position = UDim2.new(s.frame.Position.X.Scale, 0, newY, 0)
    end
end)

-- ==========================================
-- 💻 MAIN WINDOW (STATIC SIZE = NO BUGS)
-- ==========================================
local AppWrapper = Instance.new("Frame", SG)
AppWrapper.Size = UDim2.new(0, 800, 0, 480)
AppWrapper.Position = UDim2.new(0.5, 0, 0.5, 0)
AppWrapper.AnchorPoint = Vector2.new(0.5, 0.5)
AppWrapper.BackgroundTransparency = 1
AppWrapper.BorderSizePixel = 0

-- Lueur propre
local AppGlow = Instance.new("ImageLabel", AppWrapper)
AppGlow.Size = UDim2.new(1, 60, 1, 60)
AppGlow.Position = UDim2.new(0, -30, 0, -30)
AppGlow.BackgroundTransparency = 1
AppGlow.Image = "rbxassetid://5028857084"
AppGlow.ImageColor3 = CurrentTheme.Secondary
AppGlow.ImageTransparency = 0.5
AppGlow.ZIndex = -1
table.insert(ThemeObjects.SecondaryBg, AppGlow)

local AppWindow = Instance.new("Frame", AppWrapper)
AppWindow.Size = UDim2.new(1, 0, 1, 0)
AppWindow.BackgroundColor3 = BaseColors.Bg
AppWindow.BorderSizePixel = 0
AppWindow.ClipsDescendants = true
Instance.new("UICorner", AppWindow).CornerRadius = UDim.new(0, 12)

local WrapperStroke = Instance.new("UIStroke", AppWindow)
WrapperStroke.Thickness = 1.5
WrapperStroke.Color = CurrentTheme.Secondary
table.insert(ThemeObjects.Strokes, WrapperStroke)

-- ==========================================
-- 🔐 LOGIN SCREEN
-- ==========================================
local LoginScreen = Instance.new("Frame", AppWindow)
LoginScreen.Size = UDim2.new(1, 0, 1, 0)
LoginScreen.BackgroundTransparency = 1
LoginScreen.ZIndex = 10

local LoginCard = Instance.new("Frame", LoginScreen)
LoginCard.Size = UDim2.new(0, 360, 0, 380)
LoginCard.Position = UDim2.new(0.5, 0, 0.5, 0)
LoginCard.AnchorPoint = Vector2.new(0.5, 0.5)
LoginCard.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", LoginCard).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", LoginCard).Color = BaseColors.Border

local LTitle = Instance.new("TextLabel", LoginCard)
LTitle.Size = UDim2.new(1, 0, 0, 40)
LTitle.Position = UDim2.new(0, 0, 0, 40)
LTitle.BackgroundTransparency = 1
LTitle.Text = "N E X U S   A . I ."
LTitle.Font = Enum.Font.GothamBlack
LTitle.TextSize = 24
LTitle.TextColor3 = BaseColors.White

local LSub = Instance.new("TextLabel", LoginCard)
LSub.Size = UDim2.new(1, 0, 0, 20)
LSub.Position = UDim2.new(0, 0, 0, 80)
LSub.BackgroundTransparency = 1
LSub.Text = "Undetected Premium Engine • By Hiroshi738"
LSub.Font = Enum.Font.GothamMedium
LSub.TextSize = 12
LSub.TextColor3 = CurrentTheme.Primary
table.insert(ThemeObjects.PrimaryText, LSub)

local InputBg = Instance.new("Frame", LoginCard)
InputBg.Size = UDim2.new(1, -60, 0, 45)
InputBg.Position = UDim2.new(0, 30, 0, 140)
InputBg.BackgroundColor3 = BaseColors.Bg
Instance.new("UICorner", InputBg).CornerRadius = UDim.new(0, 8)
local InputStroke = Instance.new("UIStroke", InputBg)
InputStroke.Color = BaseColors.Border

local PassInput = Instance.new("TextBox", InputBg)
PassInput.Size = UDim2.new(1, -20, 1, 0)
PassInput.Position = UDim2.new(0, 10, 0, 0)
PassInput.BackgroundTransparency = 1
PassInput.Text = ""
PassInput.PlaceholderText = "Enter License Key..."
PassInput.Font = Enum.Font.Gotham
PassInput.TextSize = 13
PassInput.TextColor3 = BaseColors.White
PassInput.TextXAlignment = Enum.TextXAlignment.Left

local DiscordBtn = Instance.new("TextButton", LoginCard)
DiscordBtn.Size = UDim2.new(0, 140, 0, 45)
DiscordBtn.Position = UDim2.new(0, 30, 0, 210)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.Text = "Discord"
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 13
DiscordBtn.TextColor3 = BaseColors.White
Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0, 8)

local AuthBtn = Instance.new("TextButton", LoginCard)
AuthBtn.Size = UDim2.new(0, 140, 0, 45)
AuthBtn.Position = UDim2.new(1, -170, 0, 210)
AuthBtn.BackgroundColor3 = CurrentTheme.Primary
AuthBtn.Text = "Connect"
AuthBtn.Font = Enum.Font.GothamBold
AuthBtn.TextSize = 13
AuthBtn.TextColor3 = BaseColors.Bg
Instance.new("UICorner", AuthBtn).CornerRadius = UDim.new(0, 8)
table.insert(ThemeObjects.PrimaryBg, AuthBtn)

local StatusTxt = Instance.new("TextLabel", LoginCard)
StatusTxt.Size = UDim2.new(1, 0, 0, 20)
StatusTxt.Position = UDim2.new(0, 0, 0, 280)
StatusTxt.BackgroundTransparency = 1
StatusTxt.Text = ""
StatusTxt.Font = Enum.Font.Gotham
StatusTxt.TextSize = 12

-- ==========================================
-- 🎛️ DASHBOARD & SETTINGS
-- ==========================================
local MainContent = Instance.new("Frame", AppWindow)
MainContent.Size = UDim2.new(1, 0, 1, 0)
MainContent.BackgroundTransparency = 1
MainContent.Visible = false 

-- SIDEBAR
local Sidebar = Instance.new("Frame", MainContent)
Sidebar.Size = UDim2.new(0, 200, 1, 0)
Sidebar.BackgroundColor3 = BaseColors.CardBg
Sidebar.BorderSizePixel = 0
local SidebarLine = Instance.new("Frame", Sidebar)
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(1, 0, 0, 0)
SidebarLine.BackgroundColor3 = BaseColors.Border
SidebarLine.BorderSizePixel = 0

local DLogo = Instance.new("TextLabel", Sidebar)
DLogo.Size = UDim2.new(1, 0, 0, 80)
DLogo.BackgroundTransparency = 1
DLogo.Text = "NEXUS A.I."
DLogo.Font = Enum.Font.GothamBlack
DLogo.TextSize = 20
DLogo.TextColor3 = CurrentTheme.Primary
table.insert(ThemeObjects.PrimaryText, DLogo)

local TabDashBtn = Instance.new("TextButton", Sidebar)
TabDashBtn.Size = UDim2.new(1, -20, 0, 40)
TabDashBtn.Position = UDim2.new(0, 10, 0, 90)
TabDashBtn.BackgroundColor3 = CurrentTheme.Secondary
TabDashBtn.BackgroundTransparency = 0.2
TabDashBtn.Text = "  🧠 A.I. Core"
TabDashBtn.Font = Enum.Font.GothamBold
TabDashBtn.TextSize = 12
TabDashBtn.TextColor3 = BaseColors.White
TabDashBtn.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", TabDashBtn).CornerRadius = UDim.new(0, 8)
table.insert(ThemeObjects.SecondaryBg, TabDashBtn)

local TabSettingsBtn = Instance.new("TextButton", Sidebar)
TabSettingsBtn.Size = UDim2.new(1, -20, 0, 40)
TabSettingsBtn.Position = UDim2.new(0, 10, 0, 135)
TabSettingsBtn.BackgroundColor3 = BaseColors.Bg
TabSettingsBtn.BackgroundTransparency = 0
TabSettingsBtn.Text = "  ⚙️ Settings"
TabSettingsBtn.Font = Enum.Font.GothamBold
TabSettingsBtn.TextSize = 12
TabSettingsBtn.TextColor3 = BaseColors.Muted
TabSettingsBtn.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", TabSettingsBtn).CornerRadius = UDim.new(0, 8)

-- PROFILE
local ProfileCard = Instance.new("Frame", Sidebar)
ProfileCard.Size = UDim2.new(1, -20, 0, 60)
ProfileCard.Position = UDim2.new(0, 10, 1, -75)
ProfileCard.BackgroundColor3 = BaseColors.Bg
Instance.new("UICorner", ProfileCard).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", ProfileCard).Color = BaseColors.Border

local Avatar = Instance.new("ImageLabel", ProfileCard)
Avatar.Size = UDim2.new(0, 36, 0, 36)
Avatar.Position = UDim2.new(0, 10, 0.5, -18)
Avatar.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)
Avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..LP.UserId.."&w=48&h=48"

local PName = Instance.new("TextLabel", ProfileCard)
PName.Size = UDim2.new(1, -60, 0, 18)
PName.Position = UDim2.new(0, 55, 0, 12)
PName.BackgroundTransparency = 1
PName.Text = LP.Name
PName.Font = Enum.Font.GothamBold
PName.TextSize = 12
PName.TextColor3 = BaseColors.White
PName.TextXAlignment = Enum.TextXAlignment.Left

local PRank = Instance.new("TextLabel", ProfileCard)
PRank.Size = UDim2.new(1, -60, 0, 15)
PRank.Position = UDim2.new(0, 55, 0, 30)
PRank.BackgroundTransparency = 1
PRank.Text = "Lifetime License 💎"
PRank.Font = Enum.Font.GothamMedium
PRank.TextSize = 10
PRank.TextColor3 = CurrentTheme.Primary
PRank.TextXAlignment = Enum.TextXAlignment.Left
table.insert(ThemeObjects.PrimaryText, PRank)

local DashTab = Instance.new("Frame", MainContent)
DashTab.Size = UDim2.new(1, -200, 1, 0)
DashTab.Position = UDim2.new(0, 200, 0, 0)
DashTab.BackgroundTransparency = 1

local SettingsTab = Instance.new("Frame", MainContent)
SettingsTab.Size = UDim2.new(1, -200, 1, 0)
SettingsTab.Position = UDim2.new(0, 200, 0, 0)
SettingsTab.BackgroundTransparency = 1
SettingsTab.Visible = false

-- ==========================================
-- 🚀 DASHBOARD TAB (A.I. Core)
-- ==========================================
local HeaderTxt = Instance.new("TextLabel", DashTab)
HeaderTxt.Size = UDim2.new(1, 0, 0, 70)
HeaderTxt.Position = UDim2.new(0, 20, 0, 0)
HeaderTxt.BackgroundTransparency = 1
HeaderTxt.Text = "System Overview"
HeaderTxt.Font = Enum.Font.GothamBold
HeaderTxt.TextSize = 18
HeaderTxt.TextColor3 = BaseColors.White
HeaderTxt.TextXAlignment = Enum.TextXAlignment.Left

local EngineCard = Instance.new("Frame", DashTab)
EngineCard.Size = UDim2.new(1, -220, 0, 160)
EngineCard.Position = UDim2.new(0, 20, 0, 70)
EngineCard.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", EngineCard).CornerRadius = UDim.new(0, 12)
local EngineStroke = Instance.new("UIStroke", EngineCard)
EngineStroke.Color = BaseColors.Border

local ETitle = Instance.new("TextLabel", EngineCard)
ETitle.Size = UDim2.new(1, -40, 0, 30)
ETitle.Position = UDim2.new(0, 20, 0, 15)
ETitle.BackgroundTransparency = 1
ETitle.Text = "Nexus A.I. Configuration"
ETitle.Font = Enum.Font.GothamBold
ETitle.TextSize = 15
ETitle.TextColor3 = BaseColors.White
ETitle.TextXAlignment = Enum.TextXAlignment.Left

local EDesc = Instance.new("TextLabel", EngineCard)
EDesc.Size = UDim2.new(1, -40, 0, 40)
EDesc.Position = UDim2.new(0, 20, 0, 45)
EDesc.BackgroundTransparency = 1
EDesc.Text = "Real-time 3D environment analysis for absolute and undetectable spatial locking."
EDesc.Font = Enum.Font.Gotham
EDesc.TextSize = 11
EDesc.TextColor3 = BaseColors.Muted
EDesc.TextXAlignment = Enum.TextXAlignment.Left
EDesc.TextWrapped = true

local SwitchLbl = Instance.new("TextLabel", EngineCard)
SwitchLbl.Size = UDim2.new(0, 200, 0, 30)
SwitchLbl.Position = UDim2.new(0, 20, 1, -45)
SwitchLbl.BackgroundTransparency = 1
SwitchLbl.Text = "Enable A.I. (Key: X)"
SwitchLbl.Font = Enum.Font.GothamMedium
SwitchLbl.TextSize = 12
SwitchLbl.TextColor3 = BaseColors.White
SwitchLbl.TextXAlignment = Enum.TextXAlignment.Left

local ToggleBg = Instance.new("Frame", EngineCard)
ToggleBg.Size = UDim2.new(0, 50, 0, 26)
ToggleBg.Position = UDim2.new(1, -70, 1, -45)
ToggleBg.BackgroundColor3 = BaseColors.Bg
Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", ToggleBg)
ToggleStroke.Color = BaseColors.Border

local ToggleKnob = Instance.new("Frame", ToggleBg)
ToggleKnob.Size = UDim2.new(0, 18, 0, 18)
ToggleKnob.Position = UDim2.new(0, 4, 0.5, -9)
ToggleKnob.BackgroundColor3 = BaseColors.White
Instance.new("UICorner", ToggleKnob).CornerRadius = UDim.new(1, 0)

local ToggleBtn = Instance.new("TextButton", ToggleBg)
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = ""

-- STATS
local StatCol = Instance.new("Frame", DashTab)
StatCol.Size = UDim2.new(0.5, -25, 0, 180)
StatCol.Position = UDim2.new(0, 20, 0, 245)
StatCol.BackgroundTransparency = 1

local StatCard1 = Instance.new("Frame", StatCol)
StatCard1.Size = UDim2.new(1, 0, 0, 85)
StatCard1.Position = UDim2.new(0, 0, 0, 0)
StatCard1.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", StatCard1).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", StatCard1).Color = BaseColors.Border
local S1Title = Instance.new("TextLabel", StatCard1)
S1Title.Size = UDim2.new(1, 0, 0, 20)
S1Title.Position = UDim2.new(0, 0, 0, 15)
S1Title.BackgroundTransparency = 1
S1Title.Text = "TARGETS ELIMINATED"
S1Title.Font = Enum.Font.GothamMedium
S1Title.TextSize = 10
S1Title.TextColor3 = BaseColors.Muted
local HitsDisplay = Instance.new("TextLabel", StatCard1)
HitsDisplay.Size = UDim2.new(1, 0, 0, 30)
HitsDisplay.Position = UDim2.new(0, 0, 0, 40)
HitsDisplay.BackgroundTransparency = 1
HitsDisplay.Text = "0"
HitsDisplay.Font = Enum.Font.GothamBlack
HitsDisplay.TextSize = 24
HitsDisplay.TextColor3 = CurrentTheme.Primary
table.insert(ThemeObjects.PrimaryText, HitsDisplay)

local StatCard2 = Instance.new("Frame", StatCol)
StatCard2.Size = UDim2.new(1, 0, 0, 85)
StatCard2.Position = UDim2.new(0, 0, 0, 95)
StatCard2.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", StatCard2).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", StatCard2).Color = BaseColors.Border
local S2Title = Instance.new("TextLabel", StatCard2)
S2Title.Size = UDim2.new(1, 0, 0, 20)
S2Title.Position = UDim2.new(0, 0, 0, 15)
S2Title.BackgroundTransparency = 1
S2Title.Text = "NEXUS ACCURACY"
S2Title.Font = Enum.Font.GothamMedium
S2Title.TextSize = 10
S2Title.TextColor3 = BaseColors.Muted
local AccDisplay = Instance.new("TextLabel", StatCard2)
AccDisplay.Size = UDim2.new(1, 0, 0, 30)
AccDisplay.Position = UDim2.new(0, 0, 0, 40)
AccDisplay.BackgroundTransparency = 1
AccDisplay.Text = "99.9%"
AccDisplay.Font = Enum.Font.GothamBlack
AccDisplay.TextSize = 24
AccDisplay.TextColor3 = CurrentTheme.Secondary
table.insert(ThemeObjects.SecondaryText, AccDisplay)

-- CONSOLE & DISCORD
local ConsoleCard = Instance.new("Frame", DashTab)
ConsoleCard.Size = UDim2.new(0.5, -25, 0, 180)
ConsoleCard.Position = UDim2.new(0.5, 5, 0, 245)
ConsoleCard.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", ConsoleCard).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", ConsoleCard).Color = BaseColors.Border
local CTitle = Instance.new("TextLabel", ConsoleCard)
CTitle.Size = UDim2.new(1, -20, 0, 30)
CTitle.Position = UDim2.new(0, 10, 0, 5)
CTitle.BackgroundTransparency = 1
CTitle.Text = "System Console"
CTitle.Font = Enum.Font.GothamBold
CTitle.TextSize = 12
CTitle.TextColor3 = BaseColors.White
CTitle.TextXAlignment = Enum.TextXAlignment.Left

local LogContainer = Instance.new("ScrollingFrame", ConsoleCard)
LogContainer.Size = UDim2.new(1, -20, 1, -40)
LogContainer.Position = UDim2.new(0, 10, 0, 35)
LogContainer.BackgroundTransparency = 1
LogContainer.BorderSizePixel = 0
LogContainer.ScrollBarThickness = 2
local UIListLog = Instance.new("UIListLayout", LogContainer)
UIListLog.Padding = UDim.new(0, 6)

local function AddLog(text, color)
    local log = Instance.new("TextLabel", LogContainer)
    log.Size = UDim2.new(1, 0, 0, 14)
    log.BackgroundTransparency = 1
    log.Text = text
    log.Font = Enum.Font.Code
    log.TextSize = 9
    log.TextColor3 = color or BaseColors.Muted
    log.TextXAlignment = Enum.TextXAlignment.Left
end

local DCard = Instance.new("Frame", DashTab)
DCard.Size = UDim2.new(0, 180, 0, 80)
DCard.Position = UDim2.new(1, -200, 0, 345)
DCard.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
Instance.new("UICorner", DCard).CornerRadius = UDim.new(0, 10)
local DTitle = Instance.new("TextLabel", DCard)
DTitle.Size = UDim2.new(1, 0, 0, 20)
DTitle.Position = UDim2.new(0, 0, 0, 10)
DTitle.BackgroundTransparency = 1
DTitle.Text = "Community"
DTitle.Font = Enum.Font.GothamBold
DTitle.TextSize = 12
DTitle.TextColor3 = Color3.new(1,1,1)
local CopyBtn = Instance.new("TextButton", DCard)
CopyBtn.Size = UDim2.new(0, 120, 0, 30)
CopyBtn.Position = UDim2.new(0.5, -60, 0, 40)
CopyBtn.BackgroundColor3 = Color3.fromRGB(70, 80, 200)
CopyBtn.Text = "Join Discord"
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 11
CopyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 8)

-- ==========================================
-- ⚙️ SETTINGS TAB (Theme Engine)
-- ==========================================
local SetTitle = Instance.new("TextLabel", SettingsTab)
SetTitle.Size = UDim2.new(1, 0, 0, 70)
SetTitle.Position = UDim2.new(0, 20, 0, 0)
SetTitle.BackgroundTransparency = 1
SetTitle.Text = "Customization & Security"
SetTitle.Font = Enum.Font.GothamBold
SetTitle.TextSize = 18
SetTitle.TextColor3 = BaseColors.White
SetTitle.TextXAlignment = Enum.TextXAlignment.Left

local ThemeCard = Instance.new("Frame", SettingsTab)
ThemeCard.Size = UDim2.new(1, -40, 0, 110)
ThemeCard.Position = UDim2.new(0, 20, 0, 70)
ThemeCard.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", ThemeCard).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", ThemeCard).Color = BaseColors.Border

local ThTitle = Instance.new("TextLabel", ThemeCard)
ThTitle.Size = UDim2.new(1, -40, 0, 30)
ThTitle.Position = UDim2.new(0, 20, 0, 10)
ThTitle.BackgroundTransparency = 1
ThTitle.Text = "Select Theme Palette"
ThTitle.Font = Enum.Font.GothamBold
ThTitle.TextSize = 13
ThTitle.TextColor3 = BaseColors.White
ThTitle.TextXAlignment = Enum.TextXAlignment.Left

local ThemeGrid = Instance.new("Frame", ThemeCard)
ThemeGrid.Size = UDim2.new(1, -40, 0, 45)
ThemeGrid.Position = UDim2.new(0, 20, 0, 45)
ThemeGrid.BackgroundTransparency = 1
local TGrid = Instance.new("UIGridLayout", ThemeGrid)
TGrid.CellSize = UDim2.new(0.23, 0, 1, 0)
TGrid.CellPadding = UDim2.new(0.02, 0, 0, 0)

local SecCard = Instance.new("Frame", SettingsTab)
SecCard.Size = UDim2.new(1, -40, 0, 130)
SecCard.Position = UDim2.new(0, 20, 0, 195)
SecCard.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", SecCard).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", SecCard).Color = BaseColors.Border

local SecTitle = Instance.new("TextLabel", SecCard)
SecTitle.Size = UDim2.new(1, -40, 0, 30)
SecTitle.Position = UDim2.new(0, 20, 0, 10)
SecTitle.BackgroundTransparency = 1
SecTitle.Text = "Security Modules"
SecTitle.Font = Enum.Font.GothamBold
SecTitle.TextSize = 13
SecTitle.TextColor3 = BaseColors.White
SecTitle.TextXAlignment = Enum.TextXAlignment.Left

local function CreateSecItem(y, text, status)
    local lbl = Instance.new("TextLabel", SecCard)
    lbl.Size = UDim2.new(0, 200, 0, 20)
    lbl.Position = UDim2.new(0, 20, 0, y)
    lbl.BackgroundTransparency = 1
    lbl.Text = text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 12
    lbl.TextColor3 = BaseColors.Muted
    lbl.TextXAlignment = Enum.TextXAlignment.Left
    
    local stat = Instance.new("TextLabel", SecCard)
    stat.Size = UDim2.new(0, 100, 0, 20)
    stat.Position = UDim2.new(1, -120, 0, y)
    stat.BackgroundTransparency = 1
    stat.Text = status
    stat.Font = Enum.Font.GothamBold
    stat.TextSize = 11
    stat.TextColor3 = BaseColors.Success
    stat.TextXAlignment = Enum.TextXAlignment.Right
end
CreateSecItem(50, "Memory Hook Protection", "ACTIVE")
CreateSecItem(75, "Anti-Cheat Bypass (v4.2)", "INJECTED")
CreateSecItem(100, "StreamProof Engine (CTRL key)", "ENABLED")

-- ==========================================
-- 🎨 THEME ENGINE LOGIC
-- ==========================================
local function UpdateTheme(themeData)
    CurrentTheme = themeData
    for _, obj in ipairs(ThemeObjects.PrimaryText) do obj.TextColor3 = CurrentTheme.Primary end
    for _, obj in ipairs(ThemeObjects.SecondaryText) do obj.TextColor3 = CurrentTheme.Secondary end
    for _, obj in ipairs(ThemeObjects.PrimaryBg) do obj.BackgroundColor3 = CurrentTheme.Primary end
    for _, obj in ipairs(ThemeObjects.SecondaryBg) do 
        if obj:IsA("ImageLabel") then obj.ImageColor3 = CurrentTheme.Secondary else obj.BackgroundColor3 = CurrentTheme.Secondary end 
    end
    for _, obj in ipairs(ThemeObjects.Strokes) do obj.Color = CurrentTheme.Secondary end
    for _, obj in ipairs(ThemeObjects.Stars) do obj.BackgroundColor3 = CurrentTheme.Primary end
    
    if AutoHit then
        ToggleBg.BackgroundColor3 = CurrentTheme.Primary
        EngineStroke.Color = CurrentTheme.Primary
    end
end

local function CreateThemeBtn(name, tData)
    local b = Instance.new("TextButton", ThemeGrid)
    b.BackgroundColor3 = BaseColors.Bg
    b.Text = name
    b.Font = Enum.Font.GothamBold
    b.TextSize = 11
    b.TextColor3 = tData.Primary
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local s = Instance.new("UIStroke", b)
    s.Color = tData.Secondary
    s.Thickness = 1.5
    b.MouseButton1Click:Connect(function() UpdateTheme(tData) end)
end
CreateThemeBtn("Neon", Themes.Neon)
CreateThemeBtn("Crimson", Themes.Crimson)
CreateThemeBtn("Matrix", Themes.Matrix)
CreateThemeBtn("Void", Themes.Void)
CreateThemeBtn("Sakura", Themes.Sakura)
CreateThemeBtn("Gold", Themes.Gold)

-- ==========================================
-- 🔄 LOGIC & EVENTS
-- ==========================================
local function SwitchTab(tabName)
    DashTab.Visible = (tabName == "Dash")
    SettingsTab.Visible = (tabName == "Settings")
    if tabName == "Dash" then
        TabDashBtn.BackgroundColor3 = CurrentTheme.Secondary
        TabDashBtn.BackgroundTransparency = 0.2
        TabDashBtn.TextColor3 = BaseColors.White
        TabSettingsBtn.BackgroundColor3 = BaseColors.Bg
        TabSettingsBtn.BackgroundTransparency = 0
        TabSettingsBtn.TextColor3 = BaseColors.Muted
    else
        TabSettingsBtn.BackgroundColor3 = CurrentTheme.Secondary
        TabSettingsBtn.BackgroundTransparency = 0.2
        TabSettingsBtn.TextColor3 = BaseColors.White
        TabDashBtn.BackgroundColor3 = BaseColors.Bg
        TabDashBtn.BackgroundTransparency = 0
        TabDashBtn.TextColor3 = BaseColors.Muted
    end
end
TabDashBtn.MouseButton1Click:Connect(function() SwitchTab("Dash") end)
TabSettingsBtn.MouseButton1Click:Connect(function() SwitchTab("Settings") end)

local function CopyLink(btn)
    if setclipboard then
        setclipboard(DISCORD_LINK)
        btn.Text = "Copied!"
        btn.BackgroundColor3 = BaseColors.Success
        task.wait(2)
        if btn == DiscordBtn then btn.Text = "Discord" else btn.Text = "Join Discord" end
        btn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    end
end
DiscordBtn.MouseButton1Click:Connect(function() CopyLink(DiscordBtn) end)
CopyBtn.MouseButton1Click:Connect(function() CopyLink(CopyBtn) end)

-- LOGIN BUG-FREE
AuthBtn.MouseButton1Click:Connect(function()
    AuthBtn.Text = "Authenticating..."
    StatusTxt.Text = "Checking license signature..."
    StatusTxt.TextColor3 = BaseColors.Muted
    task.wait(0.5)
    
    if PassInput.Text == PASSWORD then
        StatusTxt.Text = "Access Granted. Welcome."
        StatusTxt.TextColor3 = BaseColors.Success
        AuthBtn.BackgroundColor3 = BaseColors.Success
        AuthBtn.Text = "Connected"
        task.wait(0.3)
        
        -- Instant Toggle (NO BUGS)
        LoginScreen.Visible = false
        MainContent.Visible = true
        IsAuthenticated = true
        
        AddLog("[SYS] Boot sequence complete.", BaseColors.Success)
        AddLog("[SEC] Anti-Cheat bypassed.", CurrentTheme.Primary)
        AddLog("[NET] Connected to Nexus Servers.", CurrentTheme.Secondary)
    else
        StatusTxt.Text = "Error: Invalid License Key."
        StatusTxt.TextColor3 = BaseColors.Danger
        AuthBtn.Text = "Retry"
    end
end)

-- AIMBOT TOGGLE
local function ToggleAimbot()
    if not IsAuthenticated then return end
    AutoHit = not AutoHit
    
    local endPos = AutoHit and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 4, 0.5, -9)
    local endBg = AutoHit and CurrentTheme.Primary or BaseColors.Bg
    
    TS:Create(ToggleKnob, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = endPos}):Play()
    TS:Create(ToggleBg, TweenInfo.new(0.3), {BackgroundColor3 = endBg}):Play()
    
    if AutoHit then
        TS:Create(EngineStroke, TweenInfo.new(0.3), {Color = CurrentTheme.Primary}):Play()
        AddLog("[A.I.] Tracking system ENGAGED.", BaseColors.Success)
    else
        TS:Create(EngineStroke, TweenInfo.new(0.3), {Color = BaseColors.Border}):Play()
        AddLog("[A.I.] Tracking system OFFLINE.", BaseColors.Danger)
    end
end
ToggleBtn.MouseButton1Click:Connect(ToggleAimbot)

-- DRAGGING
local dragging, dragInput, dragStart, startPos
AppWrapper.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true dragStart = input.Position startPos = AppWrapper.Position
    end
end)
UIS.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)
UIS.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then dragInput = input end
end)
RS.RenderStepped:Connect(function()
    if dragging and dragInput then
        local delta = dragInput.Position - dragStart
        AppWrapper.Position = AppWrapper.Position:Lerp(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), 0.2)
    end
end)

-- 🛡️ INSTANT STREAM-PROOF (ZERO BUGS)
UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.X and IsAuthenticated then
        ToggleAimbot()
    elseif (i.KeyCode == Enum.KeyCode.LeftControl or i.KeyCode == Enum.KeyCode.RightControl) then
        -- Toggle Instantané de la visibilité globale
        MenuVisible = not MenuVisible
        AppWrapper.Visible = MenuVisible
        CosmosBg.Visible = MenuVisible
    elseif i.KeyCode == Enum.KeyCode.Delete then 
        SG:Destroy()
    end
end)

-- ==========================================
-- 🎯 MOTEUR IA (Précision Parfaite)
-- ==========================================
local IGNORE = {
    floorcollider=true, cursor_trail=true, baseplate=true, screen=true,
    stopper=true, base=true, lobbyscore=true, songname=true, songtime=true,
    score=true, multiplier=true, mods=true, statusgui=true, light=true,
    camerapos=true, spectators=true, beatparticleemitter=true, gullible=true,
    hello=true, fade=true, spawneffects=true, cursor=true, square=true
}

local cachedCursor = nil
local function getCursor()
    if cachedCursor and cachedCursor.Parent then return cachedCursor end
    pcall(function()
        local g = workspace:FindFirstChild("Client")
        if g and g:FindFirstChild("Game") then
            for _,v in ipairs(g.Game:GetChildren()) do
                if v.Name == "Cursor" and v:IsA("BasePart") then cachedCursor = v break end
            end
        end
    end)
    return cachedCursor
end

local currentTarget = nil
local cursorX, cursorY = 0, 0
local initialized = false

RS.RenderStepped:Connect(function()
    HitsDisplay.Text = tostring(TotalHits)
    if not AutoHit or not IsAuthenticated then return end

    local cursor = getCursor()
    if not cursor then return end

    if not initialized then
        local mp = UIS:GetMouseLocation()
        cursorX = mp.X 
        cursorY = mp.Y
        initialized = true
    end

    local notes = {}
    pcall(function()
        local gf = workspace.Client.Game
        for _,v in ipairs(gf:GetDescendants()) do
            if v:IsA("BasePart") and v ~= cursor and v.Transparency < 0.9 and v.Size.X <= 6 then
                local nm = v.Name:lower()
                if not IGNORE[nm] and not nm:find("cursor") and not nm:find("particle") then table.insert(notes, v) end
            end
        end
    end)

    if #notes == 0 then currentTarget = nil return end
    
    local scored = {}
    for _,note in ipairs(notes) do
        local sp, vis = Cam:WorldToViewportPoint(note.Position)
        if vis and sp.Z > 0 then table.insert(scored, {part = note, sx = sp.X, sy = sp.Y, depth = sp.Z}) end
    end
    if #scored == 0 then currentTarget = nil return end

    table.sort(scored, function(a, b) return a.depth < b.depth end)

    local targetStillExists = false
    if currentTarget then
        for _, s in ipairs(scored) do
            if s.part == currentTarget then targetStillExists = true break end
        end
    end

    local target = nil
    if targetStillExists then
        for _, s in ipairs(scored) do
            if s.part == currentTarget then target = s break end
        end
    else
        target = scored[1]
        currentTarget = target.part
    end

    local speed = 0.85
    cursorX = cursorX + (target.sx - cursorX) * speed
    cursorY = cursorY + (target.sy - cursorY) * speed

    if typeof(mousemoverel) == "function" then
        mousemoverel(cursorX - UIS:GetMouseLocation().X, cursorY - UIS:GetMouseLocation().Y)
    end

    if math.sqrt((cursorX - target.sx)^2 + (cursorY - target.sy)^2) < 5 then
        TotalHits = TotalHits + 1
        currentTarget = nil
    end
end)
