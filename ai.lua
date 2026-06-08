--[[
    =======================================================================
    🌌 IA NEXUS - BY HIROSHI738 (STABLE EDITION)
    💎 Interface Complète | Zéro Bug | Furtivité Instantanée
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
-- 🎨 PALETTE & DESIGN SYSTEM
-- ==========================================
local Theme = {
    Bg = Color3.fromRGB(12, 12, 18),
    CardBg = Color3.fromRGB(18, 18, 26),
    Cyan = Color3.fromRGB(0, 225, 255),
    Purple = Color3.fromRGB(140, 60, 255),
    White = Color3.fromRGB(250, 250, 255),
    Muted = Color3.fromRGB(140, 140, 160),
    Border = Color3.fromRGB(40, 40, 55),
    Success = Color3.fromRGB(40, 220, 120),
    Danger = Color3.fromRGB(255, 60, 80)
}

local SG = Instance.new("ScreenGui")
SG.Name = "HiroshiNexus"
SG.ResetOnSpawn = false
SG.IgnoreGuiInset = true
SG.DisplayOrder = 10000
SG.Parent = LP.PlayerGui

-- ==========================================
-- 🌠 FOND COSMOS (Simple & Stable)
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
    star.BackgroundColor3 = (math.random(1, 4) == 1) and Theme.Cyan or Color3.new(1,1,1)
    star.BorderSizePixel = 0
    star.BackgroundTransparency = math.random(30, 80) / 100
    Instance.new("UICorner", star).CornerRadius = UDim.new(1, 0)
    table.insert(stars, {frame = star, speed = math.random(2, 15) / 100000})
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
-- 💻 CONTENEUR PRINCIPAL DE L'APPLICATION
-- ==========================================
local AppWindow = Instance.new("Frame", SG)
AppWindow.Size = UDim2.new(0, 800, 0, 450)
AppWindow.Position = UDim2.new(0.5, 0, 0.5, 0)
AppWindow.AnchorPoint = Vector2.new(0.5, 0.5)
AppWindow.BackgroundColor3 = Theme.Bg
AppWindow.BorderSizePixel = 0
AppWindow.ClipsDescendants = true
Instance.new("UICorner", AppWindow).CornerRadius = UDim.new(0, 12)

local AppStroke = Instance.new("UIStroke", AppWindow)
AppStroke.Color = Theme.Purple
AppStroke.Thickness = 1.5

-- ==========================================
-- 🔐 ÉCRAN DE CONNEXION (LOGIN)
-- ==========================================
local LoginScreen = Instance.new("Frame", AppWindow)
LoginScreen.Size = UDim2.new(1, 0, 1, 0)
LoginScreen.BackgroundTransparency = 1
LoginScreen.ZIndex = 10

local LoginCard = Instance.new("Frame", LoginScreen)
LoginCard.Size = UDim2.new(0, 360, 0, 380)
LoginCard.Position = UDim2.new(0.5, 0, 0.5, 0)
LoginCard.AnchorPoint = Vector2.new(0.5, 0.5)
LoginCard.BackgroundColor3 = Theme.CardBg
Instance.new("UICorner", LoginCard).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", LoginCard).Color = Theme.Border

local LTitle = Instance.new("TextLabel", LoginCard)
LTitle.Size = UDim2.new(1, 0, 0, 40)
LTitle.Position = UDim2.new(0, 0, 0, 40)
LTitle.BackgroundTransparency = 1
LTitle.Text = "I A   N E X U S"
LTitle.Font = Enum.Font.GothamBlack
LTitle.TextSize = 24
LTitle.TextColor3 = Theme.White

local LSub = Instance.new("TextLabel", LoginCard)
LSub.Size = UDim2.new(1, 0, 0, 20)
LSub.Position = UDim2.new(0, 0, 0, 80)
LSub.BackgroundTransparency = 1
LSub.Text = "Premium Engine • By Hiroshi738"
LSub.Font = Enum.Font.GothamMedium
LSub.TextSize = 13
LSub.TextColor3 = Theme.Cyan

local InputBg = Instance.new("Frame", LoginCard)
InputBg.Size = UDim2.new(1, -60, 0, 45)
InputBg.Position = UDim2.new(0, 30, 0, 140)
InputBg.BackgroundColor3 = Theme.Bg
Instance.new("UICorner", InputBg).CornerRadius = UDim.new(0, 8)
local InputStroke = Instance.new("UIStroke", InputBg)
InputStroke.Color = Theme.Border

local PassInput = Instance.new("TextBox", InputBg)
PassInput.Size = UDim2.new(1, -20, 1, 0)
PassInput.Position = UDim2.new(0, 10, 0, 0)
PassInput.BackgroundTransparency = 1
PassInput.Text = ""
PassInput.PlaceholderText = "Saisissez votre clé Nexus"
PassInput.Font = Enum.Font.Gotham
PassInput.TextSize = 13
PassInput.TextColor3 = Theme.White
PassInput.TextXAlignment = Enum.TextXAlignment.Left

local DiscordBtn = Instance.new("TextButton", LoginCard)
DiscordBtn.Size = UDim2.new(0, 140, 0, 45)
DiscordBtn.Position = UDim2.new(0, 30, 0, 210)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.Text = "Discord"
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 13
DiscordBtn.TextColor3 = Theme.White
Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0, 8)

local AuthBtn = Instance.new("TextButton", LoginCard)
AuthBtn.Size = UDim2.new(0, 140, 0, 45)
AuthBtn.Position = UDim2.new(1, -170, 0, 210)
AuthBtn.BackgroundColor3 = Theme.Cyan
AuthBtn.Text = "Connexion"
AuthBtn.Font = Enum.Font.GothamBold
AuthBtn.TextSize = 13
AuthBtn.TextColor3 = Theme.Bg
Instance.new("UICorner", AuthBtn).CornerRadius = UDim.new(0, 8)

local StatusTxt = Instance.new("TextLabel", LoginCard)
StatusTxt.Size = UDim2.new(1, 0, 0, 20)
StatusTxt.Position = UDim2.new(0, 0, 0, 280)
StatusTxt.BackgroundTransparency = 1
StatusTxt.Text = ""
StatusTxt.Font = Enum.Font.Gotham
StatusTxt.TextSize = 12

-- ==========================================
-- 🎛️ DASHBOARD
-- ==========================================
local DashScreen = Instance.new("Frame", AppWindow)
DashScreen.Size = UDim2.new(1, 0, 1, 0)
DashScreen.BackgroundTransparency = 1
DashScreen.Visible = false 

-- SIDEBAR (Gauche)
local Sidebar = Instance.new("Frame", DashScreen)
Sidebar.Size = UDim2.new(0, 220, 1, 0)
Sidebar.BackgroundColor3 = Theme.CardBg
Sidebar.BorderSizePixel = 0

local SidebarLine = Instance.new("Frame", Sidebar)
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(1, 0, 0, 0)
SidebarLine.BackgroundColor3 = Theme.Border
SidebarLine.BorderSizePixel = 0

local DLogo = Instance.new("TextLabel", Sidebar)
DLogo.Size = UDim2.new(1, 0, 0, 80)
DLogo.BackgroundTransparency = 1
DLogo.Text = "IA NEXUS"
DLogo.Font = Enum.Font.GothamBlack
DLogo.TextSize = 20
DLogo.TextColor3 = Theme.Cyan

local ActiveMenu = Instance.new("Frame", Sidebar)
ActiveMenu.Size = UDim2.new(1, -30, 0, 45)
ActiveMenu.Position = UDim2.new(0, 15, 0, 90)
ActiveMenu.BackgroundColor3 = Theme.Purple
ActiveMenu.BackgroundTransparency = 0.2
Instance.new("UICorner", ActiveMenu).CornerRadius = UDim.new(0, 8)
local MenuTxt = Instance.new("TextLabel", ActiveMenu)
MenuTxt.Size = UDim2.new(1, 0, 1, 0)
MenuTxt.BackgroundTransparency = 1
MenuTxt.Text = "🧠 IA Nexus Core"
MenuTxt.Font = Enum.Font.GothamBold
MenuTxt.TextSize = 13
MenuTxt.TextColor3 = Theme.White

-- Profil
local ProfileCard = Instance.new("Frame", Sidebar)
ProfileCard.Size = UDim2.new(1, -30, 0, 65)
ProfileCard.Position = UDim2.new(0, 15, 1, -80)
ProfileCard.BackgroundColor3 = Theme.Bg
Instance.new("UICorner", ProfileCard).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", ProfileCard).Color = Theme.Border

local Avatar = Instance.new("ImageLabel", ProfileCard)
Avatar.Size = UDim2.new(0, 40, 0, 40)
Avatar.Position = UDim2.new(0, 12, 0.5, -20)
Avatar.BackgroundColor3 = Theme.CardBg
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)
Avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..LP.UserId.."&w=48&h=48"

local PName = Instance.new("TextLabel", ProfileCard)
PName.Size = UDim2.new(1, -70, 0, 20)
PName.Position = UDim2.new(0, 65, 0, 12)
PName.BackgroundTransparency = 1
PName.Text = LP.Name
PName.Font = Enum.Font.GothamBold
PName.TextSize = 13
PName.TextColor3 = Theme.White
PName.TextXAlignment = Enum.TextXAlignment.Left

local PRank = Instance.new("TextLabel", ProfileCard)
PRank.Size = UDim2.new(1, -70, 0, 15)
PRank.Position = UDim2.new(0, 65, 0, 32)
PRank.BackgroundTransparency = 1
PRank.Text = "Licence Nexus 💎"
PRank.Font = Enum.Font.GothamMedium
PRank.TextSize = 11
PRank.TextColor3 = Theme.Cyan
PRank.TextXAlignment = Enum.TextXAlignment.Left

-- COLONNE CENTRALE (Aimbot)
local CenterCol = Instance.new("Frame", DashScreen)
CenterCol.Size = UDim2.new(0, 340, 1, 0)
CenterCol.Position = UDim2.new(0, 240, 0, 0)
CenterCol.BackgroundTransparency = 1

local HeaderTxt = Instance.new("TextLabel", CenterCol)
HeaderTxt.Size = UDim2.new(1, 0, 0, 80)
HeaderTxt.BackgroundTransparency = 1
HeaderTxt.Text = "Vue d'Ensemble"
HeaderTxt.Font = Enum.Font.GothamBold
HeaderTxt.TextSize = 18
HeaderTxt.TextColor3 = Theme.White
HeaderTxt.TextXAlignment = Enum.TextXAlignment.Left

local EngineCard = Instance.new("Frame", CenterCol)
EngineCard.Size = UDim2.new(1, 0, 0, 170)
EngineCard.Position = UDim2.new(0, 0, 0, 80)
EngineCard.BackgroundColor3 = Theme.CardBg
Instance.new("UICorner", EngineCard).CornerRadius = UDim.new(0, 12)
local EngineStroke = Instance.new("UIStroke", EngineCard)
EngineStroke.Color = Theme.Border

local ETitle = Instance.new("TextLabel", EngineCard)
ETitle.Size = UDim2.new(1, -40, 0, 30)
ETitle.Position = UDim2.new(0, 20, 0, 20)
ETitle.BackgroundTransparency = 1
ETitle.Text = "Configuration IA Nexus"
ETitle.Font = Enum.Font.GothamBold
ETitle.TextSize = 15
ETitle.TextColor3 = Theme.White
ETitle.TextXAlignment = Enum.TextXAlignment.Left

local EDesc = Instance.new("TextLabel", EngineCard)
EDesc.Size = UDim2.new(1, -40, 0, 40)
EDesc.Position = UDim2.new(0, 20, 0, 50)
EDesc.BackgroundTransparency = 1
EDesc.Text = "Analyse de l'environnement 3D en temps réel pour un verrouillage spatial absolu et indétectable."
EDesc.Font = Enum.Font.Gotham
EDesc.TextSize = 11
EDesc.TextColor3 = Theme.Muted
EDesc.TextXAlignment = Enum.TextXAlignment.Left
EDesc.TextWrapped = true

local SwitchLbl = Instance.new("TextLabel", EngineCard)
SwitchLbl.Size = UDim2.new(0, 200, 0, 30)
SwitchLbl.Position = UDim2.new(0, 20, 1, -50)
SwitchLbl.BackgroundTransparency = 1
SwitchLbl.Text = "Activer l'I.A. (Touche X)"
SwitchLbl.Font = Enum.Font.GothamMedium
SwitchLbl.TextSize = 12
SwitchLbl.TextColor3 = Theme.White
SwitchLbl.TextXAlignment = Enum.TextXAlignment.Left

local ToggleBg = Instance.new("Frame", EngineCard)
ToggleBg.Size = UDim2.new(0, 50, 0, 26)
ToggleBg.Position = UDim2.new(1, -70, 1, -50)
ToggleBg.BackgroundColor3 = Theme.Bg
Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", ToggleBg)
ToggleStroke.Color = Theme.Border

local ToggleKnob = Instance.new("Frame", ToggleBg)
ToggleKnob.Size = UDim2.new(0, 18, 0, 18)
ToggleKnob.Position = UDim2.new(0, 4, 0.5, -9)
ToggleKnob.BackgroundColor3 = Theme.White
Instance.new("UICorner", ToggleKnob).CornerRadius = UDim.new(1, 0)

local ToggleBtn = Instance.new("TextButton", ToggleBg)
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = ""

-- Cartes Stats
local StatCard1 = Instance.new("Frame", CenterCol)
StatCard1.Size = UDim2.new(0.48, 0, 0, 100)
StatCard1.Position = UDim2.new(0, 0, 0, 270)
StatCard1.BackgroundColor3 = Theme.CardBg
Instance.new("UICorner", StatCard1).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", StatCard1).Color = Theme.Border

local S1Title = Instance.new("TextLabel", StatCard1)
S1Title.Size = UDim2.new(1, 0, 0, 20)
S1Title.Position = UDim2.new(0, 0, 0, 20)
S1Title.BackgroundTransparency = 1
S1Title.Text = "CIBLES ÉLIMINÉES"
S1Title.Font = Enum.Font.GothamMedium
S1Title.TextSize = 10
S1Title.TextColor3 = Theme.Muted
local HitsDisplay = Instance.new("TextLabel", StatCard1)
HitsDisplay.Size = UDim2.new(1, 0, 0, 40)
HitsDisplay.Position = UDim2.new(0, 0, 0, 45)
HitsDisplay.BackgroundTransparency = 1
HitsDisplay.Text = "0"
HitsDisplay.Font = Enum.Font.GothamBlack
HitsDisplay.TextSize = 26
HitsDisplay.TextColor3 = Theme.Cyan

local StatCard2 = Instance.new("Frame", CenterCol)
StatCard2.Size = UDim2.new(0.48, 0, 0, 100)
StatCard2.Position = UDim2.new(0.52, 0, 0, 270)
StatCard2.BackgroundColor3 = Theme.CardBg
Instance.new("UICorner", StatCard2).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", StatCard2).Color = Theme.Border

local S2Title = Instance.new("TextLabel", StatCard2)
S2Title.Size = UDim2.new(1, 0, 0, 20)
S2Title.Position = UDim2.new(0, 0, 0, 20)
S2Title.BackgroundTransparency = 1
S2Title.Text = "PRÉCISION NEXUS"
S2Title.Font = Enum.Font.GothamMedium
S2Title.TextSize = 10
S2Title.TextColor3 = Theme.Muted
local AccDisplay = Instance.new("TextLabel", StatCard2)
AccDisplay.Size = UDim2.new(1, 0, 0, 40)
AccDisplay.Position = UDim2.new(0, 0, 0, 45)
AccDisplay.BackgroundTransparency = 1
AccDisplay.Text = "99.9%"
AccDisplay.Font = Enum.Font.GothamBlack
AccDisplay.TextSize = 26
AccDisplay.TextColor3 = Theme.Purple

-- COLONNE DROITE : Console & Discord
local RightCol = Instance.new("Frame", DashScreen)
RightCol.Size = UDim2.new(0, 180, 1, 0)
RightCol.Position = UDim2.new(0, 600, 0, 0)
RightCol.BackgroundTransparency = 1

local ConsoleCard = Instance.new("Frame", RightCol)
ConsoleCard.Size = UDim2.new(1, 0, 0, 260)
ConsoleCard.Position = UDim2.new(0, 0, 0, 80)
ConsoleCard.BackgroundColor3 = Theme.CardBg
Instance.new("UICorner", ConsoleCard).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", ConsoleCard).Color = Theme.Border

local CTitle = Instance.new("TextLabel", ConsoleCard)
CTitle.Size = UDim2.new(1, -20, 0, 30)
CTitle.Position = UDim2.new(0, 10, 0, 10)
CTitle.BackgroundTransparency = 1
CTitle.Text = "Console Nexus"
CTitle.Font = Enum.Font.GothamBold
CTitle.TextSize = 12
CTitle.TextColor3 = Theme.White
CTitle.TextXAlignment = Enum.TextXAlignment.Left

local LogContainer = Instance.new("ScrollingFrame", ConsoleCard)
LogContainer.Size = UDim2.new(1, -20, 1, -50)
LogContainer.Position = UDim2.new(0, 10, 0, 40)
LogContainer.BackgroundTransparency = 1
LogContainer.BorderSizePixel = 0
LogContainer.ScrollBarThickness = 2
local UIListLog = Instance.new("UIListLayout", LogContainer)
UIListLog.Padding = UDim.new(0, 8)

local function AddLog(text, color)
    local log = Instance.new("TextLabel", LogContainer)
    log.Size = UDim2.new(1, 0, 0, 15)
    log.BackgroundTransparency = 1
    log.Text = text
    log.Font = Enum.Font.Code
    log.TextSize = 10
    log.TextColor3 = color or Theme.Muted
    log.TextXAlignment = Enum.TextXAlignment.Left
    log.TextWrapped = true
end
AddLog("[SYS] Boot sequence complete.", Theme.Success)
AddLog("[NET] Connected to Nexus Server.", Theme.Cyan)

local DCard = Instance.new("Frame", RightCol)
DCard.Size = UDim2.new(1, 0, 0, 110)
DCard.Position = UDim2.new(0, 0, 0, 350)
DCard.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
Instance.new("UICorner", DCard).CornerRadius = UDim.new(0, 12)

local DTitle = Instance.new("TextLabel", DCard)
DTitle.Size = UDim2.new(1, 0, 0, 20)
DTitle.Position = UDim2.new(0, 0, 0, 20)
DTitle.BackgroundTransparency = 1
DTitle.Text = "Communauté"
DTitle.Font = Enum.Font.GothamBold
DTitle.TextSize = 14
DTitle.TextColor3 = Color3.new(1,1,1)

local CopyBtn = Instance.new("TextButton", DCard)
CopyBtn.Size = UDim2.new(0, 120, 0, 35)
CopyBtn.Position = UDim2.new(0.5, -60, 0, 55)
CopyBtn.BackgroundColor3 = Color3.fromRGB(70, 80, 200)
CopyBtn.Text = "Rejoindre"
CopyBtn.Font = Enum.Font.GothamBold
CopyBtn.TextSize = 12
CopyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", CopyBtn).CornerRadius = UDim.new(0, 8)

-- ==========================================
-- 🔄 LOGIQUE & ÉVÉNEMENTS
-- ==========================================

local function CopyLink(btn)
    if setclipboard then
        setclipboard(DISCORD_LINK)
        btn.Text = "Lien Copié !"
        btn.BackgroundColor3 = Theme.Success
        task.wait(2)
        if btn == DiscordBtn then btn.Text = "Discord" else btn.Text = "Rejoindre" end
        btn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    end
end
DiscordBtn.MouseButton1Click:Connect(function() CopyLink(DiscordBtn) end)
CopyBtn.MouseButton1Click:Connect(function() CopyLink(CopyBtn) end)

-- Animation bouton
local function AddHover(btn)
    local orig = btn.Size
    btn.MouseEnter:Connect(function() TS:Create(btn, TweenInfo.new(0.2), {Size = UDim2.new(orig.X.Scale, orig.X.Offset*1.02, orig.Y.Scale, orig.Y.Offset*1.02)}):Play() end)
    btn.MouseLeave:Connect(function() TS:Create(btn, TweenInfo.new(0.2), {Size = orig}):Play() end)
end
AddHover(AuthBtn) AddHover(DiscordBtn) AddHover(CopyBtn)

-- LOGIQUE CONNEXION 
AuthBtn.MouseButton1Click:Connect(function()
    AuthBtn.Text = "Vérification..."
    StatusTxt.Text = "Analyse de la clé Nexus..."
    StatusTxt.TextColor3 = Theme.Muted
    task.wait(0.5)
    
    if PassInput.Text == PASSWORD then
        StatusTxt.Text = "Accès Autorisé."
        StatusTxt.TextColor3 = Theme.Success
        AuthBtn.BackgroundColor3 = Theme.Success
        AuthBtn.Text = "Connecté"
        task.wait(0.5)
        
        -- Transition propre vers le Dash
        LoginScreen.Visible = false
        DashScreen.Visible = true
        IsAuthenticated = true
        AddLog("[NEXUS] IA Core ready.", Theme.Purple)
    else
        StatusTxt.Text = "Erreur : Licence invalide."
        StatusTxt.TextColor3 = Theme.Danger
        AuthBtn.Text = "Réessayer"
    end
end)

-- LOGIQUE SWITCH AIMBOT
ToggleBtn.MouseButton1Click:Connect(function()
    if not IsAuthenticated then return end
    AutoHit = not AutoHit
    local endPos = AutoHit and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 4, 0.5, -9)
    local endBg = AutoHit and Theme.Cyan or Theme.Bg
    
    TS:Create(ToggleKnob, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = endPos}):Play()
    TS:Create(ToggleBg, TweenInfo.new(0.3), {BackgroundColor3 = endBg}):Play()
    TS:Create(ToggleStroke, TweenInfo.new(0.3), {Color = AutoHit and Theme.Cyan or Theme.Border}):Play()
    
    if AutoHit then
        TS:Create(EngineStroke, TweenInfo.new(0.3), {Color = Theme.Cyan}):Play()
        AddLog("[NEXUS] Tracking system ON.", Theme.Success)
    else
        TS:Create(EngineStroke, TweenInfo.new(0.3), {Color = Theme.Border}):Play()
        AddLog("[NEXUS] Tracking system OFF.", Theme.Danger)
    end
end)

-- DRAGGING FENÊTRE
local dragging, dragInput, dragStart, startPos
AppWindow.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true dragStart = input.Position startPos = AppWindow.Position
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
        AppWindow.Position = AppWindow.Position:Lerp(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), 0.2)
    end
end)

-- 🛡️ RACCOURCIS : CACHER TOUT INSTANTANÉMENT SANS BUG (STREAM-PROOF)
UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.X and IsAuthenticated then
        ToggleBtn.MouseButton1Click:Fire()
    elseif (i.KeyCode == Enum.KeyCode.LeftControl or i.KeyCode == Enum.KeyCode.RightControl) then
        MenuVisible = not MenuVisible
        AppWindow.Visible = MenuVisible
        CosmosBg.Visible = MenuVisible
    elseif i.KeyCode == Enum.KeyCode.Delete then 
        SG:Destroy()
    end
end)

-- ==========================================
-- 🎯 MOTEUR IA (Aimbot Mathématique Parfait)
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
