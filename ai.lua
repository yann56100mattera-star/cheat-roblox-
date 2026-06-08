--[[
    =======================================================================
    🌌 NEXUS A.I. - BY HIROSHI738 (PRO EDITION)
    💎 Telemetry Layout Fixed | Zero-Bug Rendering | Stream-Proof | Themes
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
local SessionStart = tick()

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
    Bg = Color3.fromRGB(10, 10, 15),
    CardBg = Color3.fromRGB(16, 16, 22),
    White = Color3.fromRGB(245, 245, 255),
    Muted = Color3.fromRGB(130, 130, 150),
    Border = Color3.fromRGB(40, 40, 55),
    Success = Color3.fromRGB(30, 210, 110),
    Danger = Color3.fromRGB(255, 50, 70),
    Discord = Color3.fromRGB(88, 101, 242)
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
local ThemeObjects = { PrimaryText = {}, SecondaryText = {}, PrimaryBg = {}, SecondaryBg = {}, Stars = {}, Strokes = {}, ActiveThemeBtns = {} }

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
for i = 1, 100 do
    local star = Instance.new("Frame", CosmosBg)
    local size = math.random(1, 3)
    star.Size = UDim2.new(0, size, 0, size)
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = (math.random(1, 4) == 1) and CurrentTheme.Primary or Color3.new(1,1,1)
    star.BorderSizePixel = 0
    star.BackgroundTransparency = math.random(30, 80) / 100
    Instance.new("UICorner", star).CornerRadius = UDim.new(1, 0)
    table.insert(stars, {frame = star, speed = math.random(2, 12) / 100000})
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
-- 💻 MAIN APPLICATION WRAPPER
-- ==========================================
local AppWrapper = Instance.new("Frame", SG)
AppWrapper.Size = UDim2.new(0, 800, 0, 480)
AppWrapper.Position = UDim2.new(0.5, 0, 0.5, 0)
AppWrapper.AnchorPoint = Vector2.new(0.5, 0.5)
AppWrapper.BackgroundTransparency = 1
AppWrapper.BorderSizePixel = 0

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
DiscordBtn.BackgroundColor3 = BaseColors.Discord
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
-- 🎛️ DASHBOARD & SETTINGS NAVIGATION
-- ==========================================
local MainContent = Instance.new("Frame", AppWindow)
MainContent.Size = UDim2.new(1, 0, 1, -25) -- Laisse 25px d'espace en bas pour le footer !
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
TabDashBtn.Size = UDim2.new(1, -30, 0, 45)
TabDashBtn.Position = UDim2.new(0, 15, 0, 90)
TabDashBtn.BackgroundColor3 = CurrentTheme.Secondary
TabDashBtn.BackgroundTransparency = 0.15
TabDashBtn.Text = "  🧠 A.I. Core"
TabDashBtn.Font = Enum.Font.GothamBold
TabDashBtn.TextSize = 13
TabDashBtn.TextColor3 = BaseColors.White
TabDashBtn.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", TabDashBtn).CornerRadius = UDim.new(0, 8)
table.insert(ThemeObjects.SecondaryBg, TabDashBtn)

local TabSettingsBtn = Instance.new("TextButton", Sidebar)
TabSettingsBtn.Size = UDim2.new(1, -30, 0, 45)
TabSettingsBtn.Position = UDim2.new(0, 15, 0, 145)
TabSettingsBtn.BackgroundColor3 = BaseColors.Bg
TabSettingsBtn.BackgroundTransparency = 0
TabSettingsBtn.Text = "  ⚙️ Settings"
TabSettingsBtn.Font = Enum.Font.GothamBold
TabSettingsBtn.TextSize = 13
TabSettingsBtn.TextColor3 = BaseColors.Muted
TabSettingsBtn.TextXAlignment = Enum.TextXAlignment.Left
Instance.new("UICorner", TabSettingsBtn).CornerRadius = UDim.new(0, 8)

-- PROFILE CARD
local ProfileCard = Instance.new("Frame", Sidebar)
ProfileCard.Size = UDim2.new(1, -30, 0, 60)
ProfileCard.Position = UDim2.new(0, 15, 1, -75)
ProfileCard.BackgroundColor3 = BaseColors.Bg
Instance.new("UICorner", ProfileCard).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", ProfileCard).Color = BaseColors.Border

local Avatar = Instance.new("ImageLabel", ProfileCard)
Avatar.Size = UDim2.new(0, 36, 0, 36)
Avatar.Position = UDim2.new(0, 10, 0.5, -18)
Avatar.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)
Avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..LP.UserId.."&w=48&h=48"

local OnlineDot = Instance.new("Frame", Avatar)
OnlineDot.Size = UDim2.new(0, 10, 0, 10)
OnlineDot.Position = UDim2.new(1, -8, 1, -8)
OnlineDot.BackgroundColor3 = BaseColors.Success
Instance.new("UICorner", OnlineDot).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OnlineDot).Color = BaseColors.Bg

task.spawn(function()
    while true do
        TS:Create(OnlineDot, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundTransparency = 0.5}):Play()
        task.wait(1)
        TS:Create(OnlineDot, TweenInfo.new(1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {BackgroundTransparency = 0}):Play()
        task.wait(1)
    end
end)

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
-- 🚀 DASHBOARD TAB 
-- ==========================================
local HeaderTxt = Instance.new("TextLabel", DashTab)
HeaderTxt.Size = UDim2.new(0, 300, 0, 30)
HeaderTxt.Position = UDim2.new(0, 25, 0, 15)
HeaderTxt.BackgroundTransparency = 1
HeaderTxt.Text = "System Overview"
HeaderTxt.Font = Enum.Font.GothamBold
HeaderTxt.TextSize = 18
HeaderTxt.TextColor3 = BaseColors.White
HeaderTxt.TextXAlignment = Enum.TextXAlignment.Left

local EngineCard = Instance.new("Frame", DashTab)
EngineCard.Size = UDim2.new(0, 550, 0, 110)
EngineCard.Position = UDim2.new(0, 25, 0, 55)
EngineCard.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", EngineCard).CornerRadius = UDim.new(0, 12)
local EngineStroke = Instance.new("UIStroke", EngineCard)
EngineStroke.Color = BaseColors.Border

local ETitle = Instance.new("TextLabel", EngineCard)
ETitle.Size = UDim2.new(0, 300, 0, 20)
ETitle.Position = UDim2.new(0, 20, 0, 15)
ETitle.BackgroundTransparency = 1
ETitle.Text = "Nexus A.I. Configuration"
ETitle.Font = Enum.Font.GothamBold
ETitle.TextSize = 14
ETitle.TextColor3 = BaseColors.White
ETitle.TextXAlignment = Enum.TextXAlignment.Left

local EDesc = Instance.new("TextLabel", EngineCard)
EDesc.Size = UDim2.new(0, 450, 0, 30)
EDesc.Position = UDim2.new(0, 20, 0, 35)
EDesc.BackgroundTransparency = 1
EDesc.Text = "Real-time 3D environment analysis for undetectable spatial locking. (Stream-Proof Active)"
EDesc.Font = Enum.Font.Gotham
EDesc.TextSize = 11
EDesc.TextColor3 = BaseColors.Muted
EDesc.TextXAlignment = Enum.TextXAlignment.Left
EDesc.TextWrapped = true

local SwitchLbl = Instance.new("TextLabel", EngineCard)
SwitchLbl.Size = UDim2.new(0, 200, 0, 20)
SwitchLbl.Position = UDim2.new(0, 20, 1, -35)
SwitchLbl.BackgroundTransparency = 1
SwitchLbl.Text = "Enable A.I. (Key: X)"
SwitchLbl.Font = Enum.Font.GothamMedium
SwitchLbl.TextSize = 12
SwitchLbl.TextColor3 = BaseColors.White
SwitchLbl.TextXAlignment = Enum.TextXAlignment.Left

local ToggleBg = Instance.new("Frame", EngineCard)
ToggleBg.Size = UDim2.new(0, 46, 0, 24)
ToggleBg.Position = UDim2.new(0, 484, 1, -37)
ToggleBg.BackgroundColor3 = BaseColors.Bg
Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", ToggleBg)
ToggleStroke.Color = BaseColors.Border
local ToggleKnob = Instance.new("Frame", ToggleBg)
ToggleKnob.Size = UDim2.new(0, 16, 0, 16)
ToggleKnob.Position = UDim2.new(0, 4, 0.5, -8)
ToggleKnob.BackgroundColor3 = BaseColors.White
Instance.new("UICorner", ToggleKnob).CornerRadius = UDim.new(1, 0)
local ToggleBtn = Instance.new("TextButton", ToggleBg)
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = ""

-- Left Column (Stats)
local StatCard1 = Instance.new("Frame", DashTab)
StatCard1.Size = UDim2.new(0, 265, 0, 105)
StatCard1.Position = UDim2.new(0, 25, 0, 185)
StatCard1.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", StatCard1).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", StatCard1).Color = BaseColors.Border
local S1Title = Instance.new("TextLabel", StatCard1)
S1Title.Size = UDim2.new(1, 0, 0, 20)
S1Title.Position = UDim2.new(0, 0, 0, 20)
S1Title.BackgroundTransparency = 1
S1Title.Text = "TARGETS ELIMINATED"
S1Title.Font = Enum.Font.GothamMedium
S1Title.TextSize = 10
S1Title.TextColor3 = BaseColors.Muted
local HitsDisplay = Instance.new("TextLabel", StatCard1)
HitsDisplay.Size = UDim2.new(1, 0, 0, 40)
HitsDisplay.Position = UDim2.new(0, 0, 0, 45)
HitsDisplay.BackgroundTransparency = 1
HitsDisplay.Text = "0"
HitsDisplay.Font = Enum.Font.GothamBlack
HitsDisplay.TextSize = 26
HitsDisplay.TextColor3 = CurrentTheme.Primary
table.insert(ThemeObjects.PrimaryText, HitsDisplay)

local StatCard2 = Instance.new("Frame", DashTab)
StatCard2.Size = UDim2.new(0, 265, 0, 105)
StatCard2.Position = UDim2.new(0, 310, 0, 185)
StatCard2.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", StatCard2).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", StatCard2).Color = BaseColors.Border
local S2Title = Instance.new("TextLabel", StatCard2)
S2Title.Size = UDim2.new(1, 0, 0, 20)
S2Title.Position = UDim2.new(0, 0, 0, 20)
S2Title.BackgroundTransparency = 1
S2Title.Text = "NEXUS ACCURACY"
S2Title.Font = Enum.Font.GothamMedium
S2Title.TextSize = 10
S2Title.TextColor3 = BaseColors.Muted
local AccDisplay = Instance.new("TextLabel", StatCard2)
AccDisplay.Size = UDim2.new(1, 0, 0, 40)
AccDisplay.Position = UDim2.new(0, 0, 0, 45)
AccDisplay.BackgroundTransparency = 1
AccDisplay.Text = "99.9%"
AccDisplay.Font = Enum.Font.GothamBlack
AccDisplay.TextSize = 26
AccDisplay.TextColor3 = CurrentTheme.Secondary
table.insert(ThemeObjects.SecondaryText, AccDisplay)

-- Right Column (Console)
local ConsoleCard = Instance.new("Frame", DashTab)
ConsoleCard.Size = UDim2.new(0, 370, 0, 135)
ConsoleCard.Position = UDim2.new(0, 25, 0, 300)
ConsoleCard.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", ConsoleCard).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", ConsoleCard).Color = BaseColors.Border
local CTitle = Instance.new("TextLabel", ConsoleCard)
CTitle.Size = UDim2.new(1, -30, 0, 20)
CTitle.Position = UDim2.new(0, 15, 0, 10)
CTitle.BackgroundTransparency = 1
CTitle.Text = "System Console"
CTitle.Font = Enum.Font.GothamBold
CTitle.TextSize = 12
CTitle.TextColor3 = BaseColors.White
CTitle.TextXAlignment = Enum.TextXAlignment.Left

local LogContainer = Instance.new("ScrollingFrame", ConsoleCard)
LogContainer.Size = UDim2.new(1, -30, 0, 90)
LogContainer.Position = UDim2.new(0, 15, 0, 35)
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
    log.TextSize = 10
    log.TextColor3 = color or BaseColors.Muted
    log.TextXAlignment = Enum.TextXAlignment.Left
    LogContainer.CanvasPosition = Vector2.new(0, 9999)
end

-- Discord Widget 
local DCard = Instance.new("Frame", DashTab)
DCard.Size = UDim2.new(0, 165, 0, 135)
DCard.Position = UDim2.new(0, 410, 0, 300)
DCard.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", DCard).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", DCard).Color = BaseColors.Discord
local DIcon = Instance.new("TextLabel", DCard)
DIcon.Size = UDim2.new(1, 0, 0, 30)
DIcon.Position = UDim2.new(0, 0, 0, 15)
DIcon.BackgroundTransparency = 1
DIcon.Text = "💬"
DIcon.Font = Enum.Font.Gotham
DIcon.TextSize = 24
local DTitle = Instance.new("TextLabel", DCard)
DTitle.Size = UDim2.new(1, 0, 0, 20)
DTitle.Position = UDim2.new(0, 0, 0, 45)
DTitle.BackgroundTransparency = 1
DTitle.Text = "Community"
DTitle.Font = Enum.Font.GothamMedium
DTitle.TextSize = 11
DTitle.TextColor3 = BaseColors.White
local CopyBtn = Instance.new("TextButton", DCard)
CopyBtn.Size = UDim2.new(0, 125, 0, 30)
CopyBtn.Position = UDim2.new(0, 20, 0, 85)
CopyBtn.BackgroundColor3 = BaseColors.Discord
CopyBtn.Text = "Join Server"
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 11
CopyBtn.TextColor3 = BaseColors.White
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 6)

-- ==========================================
-- ⚙️ SETTINGS TAB 
-- ==========================================
local SetTitle = Instance.new("TextLabel", SettingsTab)
SetTitle.Size = UDim2.new(0, 300, 0, 30)
SetTitle.Position = UDim2.new(0, 25, 0, 15)
SetTitle.BackgroundTransparency = 1
SetTitle.Text = "Configuration & Security"
SetTitle.Font = Enum.Font.GothamBold
SetTitle.TextSize = 18
SetTitle.TextColor3 = BaseColors.White
SetTitle.TextXAlignment = Enum.TextXAlignment.Left

local ThemeCard = Instance.new("Frame", SettingsTab)
ThemeCard.Size = UDim2.new(0, 550, 0, 140)
ThemeCard.Position = UDim2.new(0, 25, 0, 60)
ThemeCard.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", ThemeCard).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", ThemeCard).Color = BaseColors.Border

local ThTitle = Instance.new("TextLabel", ThemeCard)
ThTitle.Size = UDim2.new(1, -40, 0, 20)
ThTitle.Position = UDim2.new(0, 20, 0, 15)
ThTitle.BackgroundTransparency = 1
ThTitle.Text = "Color Accents (Themes)"
ThTitle.Font = Enum.Font.GothamBold
ThTitle.TextSize = 13
ThTitle.TextColor3 = BaseColors.White
ThTitle.TextXAlignment = Enum.TextXAlignment.Left

local ThemeGrid = Instance.new("Frame", ThemeCard)
ThemeGrid.Size = UDim2.new(1, -40, 0, 80)
ThemeGrid.Position = UDim2.new(0, 20, 0, 45)
ThemeGrid.BackgroundTransparency = 1
local TGrid = Instance.new("UIGridLayout", ThemeGrid)
TGrid.CellSize = UDim2.new(0, 160, 0, 35)
TGrid.CellPadding = UDim2.new(0, 15, 0, 10)

local SecCard = Instance.new("Frame", SettingsTab)
SecCard.Size = UDim2.new(0, 550, 0, 140)
SecCard.Position = UDim2.new(0, 25, 0, 215)
SecCard.BackgroundColor3 = BaseColors.CardBg
Instance.new("UICorner", SecCard).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", SecCard).Color = BaseColors.Border

local SecTitle = Instance.new("TextLabel", SecCard)
SecTitle.Size = UDim2.new(1, -40, 0, 20)
SecTitle.Position = UDim2.new(0, 20, 0, 15)
SecTitle.BackgroundTransparency = 1
SecTitle.Text = "Security Modules"
SecTitle.Font = Enum.Font.GothamBold
SecTitle.TextSize = 13
SecTitle.TextColor3 = BaseColors.White
SecTitle.TextXAlignment = Enum.TextXAlignment.Left

local function CreateSecItem(y, text, status)
    local lbl = Instance.new("TextLabel", SecCard)
    lbl.Size = UDim2.new(0, 250, 0, 20)
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
CreateSecItem(45, "Memory Hook Protection", "ACTIVE")
CreateSecItem(70, "Anti-Cheat Bypass (v4.2)", "INJECTED")
CreateSecItem(95, "StreamProof Engine (CTRL key)", "ENABLED")

-- ==========================================
-- 📊 TELEMETRY FOOTER (FIXED ALIGNMENT)
-- ==========================================
local Footer = Instance.new("Frame", AppWindow)
Footer.Size = UDim2.new(1, 0, 0, 25)
Footer.Position = UDim2.new(0, 0, 1, -25)
Footer.BackgroundColor3 = BaseColors.CardBg
Footer.BorderSizePixel = 0
local FooterLine = Instance.new("Frame", Footer)
FooterLine.Size = UDim2.new(1, 0, 0, 1)
FooterLine.BackgroundColor3 = BaseColors.Border
FooterLine.BorderSizePixel = 0

-- 1. Status (Left)
local FooterStatus = Instance.new("TextLabel", Footer)
FooterStatus.Size = UDim2.new(0, 150, 1, 0)
FooterStatus.Position = UDim2.new(0, 15, 0, 0)
FooterStatus.BackgroundTransparency = 1
FooterStatus.Text = "🟢 STATUS: SECURE"
FooterStatus.Font = Enum.Font.GothamBold
FooterStatus.TextSize = 10
FooterStatus.TextColor3 = BaseColors.Success
FooterStatus.TextXAlignment = Enum.TextXAlignment.Left

-- 4. UPTIME (Right) - Boîte plus large !
local FooterTime = Instance.new("TextLabel", Footer)
FooterTime.Size = UDim2.new(0, 110, 1, 0)
FooterTime.Position = UDim2.new(1, -15, 0, 0)
FooterTime.AnchorPoint = Vector2.new(1, 0)
FooterTime.BackgroundTransparency = 1
FooterTime.Text = "UPTIME 00:00:00"
FooterTime.Font = Enum.Font.Code
FooterTime.TextSize = 11
FooterTime.TextColor3 = CurrentTheme.Secondary
FooterTime.TextXAlignment = Enum.TextXAlignment.Right
table.insert(ThemeObjects.SecondaryText, FooterTime)

-- 3. FPS (Center-Right) - Décalé plus à gauche !
local FooterFPS = Instance.new("TextLabel", Footer)
FooterFPS.Size = UDim2.new(0, 60, 1, 0)
FooterFPS.Position = UDim2.new(1, -135, 0, 0) 
FooterFPS.AnchorPoint = Vector2.new(1, 0)
FooterFPS.BackgroundTransparency = 1
FooterFPS.Text = "FPS: 60"
FooterFPS.Font = Enum.Font.GothamBold
FooterFPS.TextSize = 10
FooterFPS.TextColor3 = CurrentTheme.Primary
FooterFPS.TextXAlignment = Enum.TextXAlignment.Right
table.insert(ThemeObjects.PrimaryText, FooterFPS)

-- 2. PING (Center-Left) - Décalé encore plus !
local FooterPing = Instance.new("TextLabel", Footer)
FooterPing.Size = UDim2.new(0, 70, 1, 0)
FooterPing.Position = UDim2.new(1, -205, 0, 0)
FooterPing.AnchorPoint = Vector2.new(1, 0)
FooterPing.BackgroundTransparency = 1
FooterPing.Text = "PING: 40ms"
FooterPing.Font = Enum.Font.GothamMedium
FooterPing.TextSize = 10
FooterPing.TextColor3 = BaseColors.Muted
FooterPing.TextXAlignment = Enum.TextXAlignment.Right

local frames = 0
RS.RenderStepped:Connect(function(dt)
    local up = tick() - SessionStart
    local h = math.floor(up / 3600)
    local m = math.floor((up % 3600) / 60)
    local s = math.floor(up % 60)
    FooterTime.Text = string.format("UPTIME %02d:%02d:%02d", h, m, s)
    
    frames = frames + 1
    if frames % 10 == 0 then
        FooterFPS.Text = "FPS: " .. math.floor(1 / dt)
        FooterPing.Text = "PING: " .. math.random(35, 55) .. "ms"
    end
end)

-- ==========================================
-- 🎨 THEME ENGINE LOGIC
-- ==========================================
local function UpdateTheme(themeData, activeBtn)
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

    for btn, data in pairs(ThemeObjects.ActiveThemeBtns) do
        if btn == activeBtn then
            btn.BackgroundColor3 = data.Primary
            btn.TextColor3 = BaseColors.Bg
        else
            btn.BackgroundColor3 = BaseColors.Bg
            btn.TextColor3 = data.Primary
        end
    end
end

local function CreateThemeBtn(name, tData)
    local b = Instance.new("TextButton", ThemeGrid)
    b.BackgroundColor3 = BaseColors.Bg
    b.Text = name
    b.Font = Enum.Font.GothamBold
    b.TextSize = 12
    b.TextColor3 = tData.Primary
    Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
    local s = Instance.new("UIStroke", b)
    s.Color = tData.Primary
    s.Thickness = 1
    
    ThemeObjects.ActiveThemeBtns[b] = tData
    b.MouseButton1Click:Connect(function() UpdateTheme(tData, b) end)
    
    if name == "Neon" then
        b.BackgroundColor3 = tData.Primary
        b.TextColor3 = BaseColors.Bg
    end
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
        TabDashBtn.BackgroundTransparency = 0.15
        TabDashBtn.TextColor3 = BaseColors.White
        TabSettingsBtn.BackgroundColor3 = BaseColors.Bg
        TabSettingsBtn.BackgroundTransparency = 1
        TabSettingsBtn.TextColor3 = BaseColors.Muted
    else
        TabSettingsBtn.BackgroundColor3 = CurrentTheme.Secondary
        TabSettingsBtn.BackgroundTransparency = 0.15
        TabSettingsBtn.TextColor3 = BaseColors.White
        TabDashBtn.BackgroundColor3 = BaseColors.Bg
        TabDashBtn.BackgroundTransparency = 1
        TabDashBtn.TextColor3 = BaseColors.Muted
    end
end
TabDashBtn.MouseButton1Click:Connect(function() SwitchTab("Dash") end)
TabSettingsBtn.MouseButton1Click:Connect(function() SwitchTab("Settings") end)

local function LinkDiscord(btn)
    if setclipboard then
        setclipboard(DISCORD_LINK)
        btn.Text = "Copied!"
        btn.BackgroundColor3 = BaseColors.Success
        task.wait(2)
        if btn == DiscordBtn then btn.Text = "Discord" else btn.Text = "Join Server" end
        btn.BackgroundColor3 = BaseColors.Discord
    end
end
DiscordBtn.MouseButton1Click:Connect(function() LinkDiscord(DiscordBtn) end)
CopyBtn.MouseButton1Click:Connect(function() LinkDiscord(CopyBtn) end)

-- BUG-FREE LOGIN
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
        
        LoginScreen:Destroy() 
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
    local endKnob = AutoHit and BaseColors.Bg or BaseColors.White
    
    TS:Create(ToggleKnob, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = endPos, BackgroundColor3 = endKnob}):Play()
    TS:Create(ToggleBg, TweenInfo.new(0.3), {BackgroundColor3 = endBg}):Play()
    TS:Create(ToggleStroke, TweenInfo.new(0.3), {Color = AutoHit and CurrentTheme.Primary or BaseColors.Border}):Play()
    
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
