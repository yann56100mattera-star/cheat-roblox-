--[[
    =======================================================================
    🌌 HIROSHI OS - NEURAL PREMIUM ARCHITECTURE (v5.0)
    💎 Interface SaaS Haut de Gamme | UX/UI Redesign Total
    =======================================================================
]]

local Players = game:GetService("Players")
local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local LP = Players.LocalPlayer
local Cam = workspace.CurrentCamera

-- Variables globales
local DISCORD_LINK = "https://discord.gg/qTGtM4Uyc"
local PASSWORD = "Hiro738"
local AutoHit = false
local TotalHits = 0
local MenuVisible = true
local IsAuthenticated = false

if LP.PlayerGui:FindFirstChild("HiroshiOS") then 
    LP.PlayerGui.HiroshiOS:Destroy() 
end

-- ==========================================
-- 🎨 PALETTE & DESIGN SYSTEM
-- ==========================================
local Colors = {
    AppBg = Color3.fromRGB(10, 10, 15),       -- Fond principal très sombre
    CardBg = Color3.fromRGB(18, 18, 26),      -- Fond des cartes
    CardHover = Color3.fromRGB(24, 24, 34),   -- Fond des cartes au survol
    Cyan = Color3.fromRGB(0, 225, 255),       -- Accent primaire
    Purple = Color3.fromRGB(140, 60, 255),    -- Accent secondaire
    TextWhite = Color3.fromRGB(250, 250, 255),
    TextGray = Color3.fromRGB(150, 150, 170),
    Danger = Color3.fromRGB(255, 60, 80),
    Success = Color3.fromRGB(40, 220, 120)
}

local BlurAsset = "rbxassetid://5028857084" -- Pour les ombres/glows

-- Utilitaires de création d'UI pour garder le code propre
local function CreateGlow(parent, color, sizeMultiplier, transparency)
    local glow = Instance.new("ImageLabel", parent)
    glow.BackgroundTransparency = 1
    glow.Image = BlurAsset
    glow.ImageColor3 = color
    glow.ImageTransparency = transparency or 0.5
    glow.Size = UDim2.new(sizeMultiplier, 0, sizeMultiplier, 0)
    glow.Position = UDim2.new(0.5, 0, 0.5, 0)
    glow.AnchorPoint = Vector2.new(0.5, 0.5)
    glow.ZIndex = 0
    return glow
end

local function ApplyHover(element, targetScale, bgTargetColor)
    local origSize = element.Size
    local origBg = element.BackgroundColor3
    element.MouseEnter:Connect(function()
        local props = {Size = UDim2.new(origSize.X.Scale, origSize.X.Offset * targetScale, origSize.Y.Scale, origSize.Y.Offset * targetScale)}
        if bgTargetColor then props.BackgroundColor3 = bgTargetColor end
        TS:Create(element, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
    end)
    element.MouseLeave:Connect(function()
        local props = {Size = origSize}
        if bgTargetColor then props.BackgroundColor3 = origBg end
        TS:Create(element, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), props):Play()
    end)
end

-- ==========================================
-- 🌌 CRÉATION DE L'INTERFACE PRINCIPALE
-- ==========================================
local SG = Instance.new("ScreenGui")
SG.Name = "HiroshiOS"
SG.ResetOnSpawn = false
SG.IgnoreGuiInset = true
SG.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
SG.Parent = LP.PlayerGui

-- 🌠 1. FOND COSMOS (Stream-Proof)
local CosmicLayer = Instance.new("Frame", SG)
CosmicLayer.Size = UDim2.new(1, 0, 1, 0)
CosmicLayer.BackgroundTransparency = 1
CosmicLayer.ZIndex = -1

local stars = {}
for i = 1, 100 do
    local star = Instance.new("Frame", CosmicLayer)
    local size = math.random(1, 3)
    star.Size = UDim2.new(0, size, 0, size)
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = (math.random(1, 4) == 1) and Colors.Cyan or Color3.new(1,1,1)
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

-- ✨ 2. CURSEUR PREMIUM
RS.RenderStepped:Connect(function()
    if not MenuVisible then return end
    local mouseLoc = UIS:GetMouseLocation()
    if math.random(1, 2) == 1 then
        local p = Instance.new("Frame", CosmicLayer)
        p.Size = UDim2.new(0, 3, 0, 3)
        p.Position = UDim2.new(0, mouseLoc.X + math.random(-4, 4), 0, mouseLoc.Y + math.random(-4, 4))
        p.BackgroundColor3 = (math.random(1, 2) == 1) and Colors.Cyan or Colors.Purple
        p.BorderSizePixel = 0
        Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
        
        local tween = TS:Create(p, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, p.Position.X.Offset, 0, p.Position.Y.Offset + 20), BackgroundTransparency = 1
        })
        tween:Play()
        tween.Completed:Connect(function() p:Destroy() end)
    end
end)

-- 💻 3. CONTENEUR PRINCIPAL (Application)
local MainApp = Instance.new("CanvasGroup", SG)
MainApp.Size = UDim2.new(0, 780, 0, 480)
MainApp.Position = UDim2.new(0.5, 0, 0.5, 0)
MainApp.AnchorPoint = Vector2.new(0.5, 0.5)
MainApp.BackgroundColor3 = Colors.AppBg
MainApp.BackgroundTransparency = 0.05
MainApp.BorderSizePixel = 0
MainApp.GroupTransparency = 1 
Instance.new("UICorner", MainApp).CornerRadius = UDim.new(0, 14)

local AppStroke = Instance.new("UIStroke", MainApp)
AppStroke.Thickness = 1
AppStroke.Color = Color3.fromRGB(40, 40, 55)

CreateGlow(MainApp, Colors.Purple, 1.05, 0.6)

-- ==========================================
-- 🔐 ÉCRAN DE CONNEXION (Refonte Premium)
-- ==========================================
local LoginView = Instance.new("Frame", MainApp)
LoginView.Size = UDim2.new(1, 0, 1, 0)
LoginView.BackgroundTransparency = 1

local LoginCard = Instance.new("Frame", LoginView)
LoginCard.Size = UDim2.new(0, 340, 0, 360)
LoginCard.Position = UDim2.new(0.5, 0, 0.5, 0)
LoginCard.AnchorPoint = Vector2.new(0.5, 0.5)
LoginCard.BackgroundColor3 = Colors.CardBg
Instance.new("UICorner", LoginCard).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", LoginCard).Color = Color3.fromRGB(50, 50, 65)

local LogoGlow = CreateGlow(LoginCard, Colors.Cyan, 1.5, 0.8)
LogoGlow.Position = UDim2.new(0.5, 0, 0, 40)

local LLogo = Instance.new("TextLabel", LoginCard)
LLogo.Size = UDim2.new(1, 0, 0, 40)
LLogo.Position = UDim2.new(0, 0, 0, 35)
LLogo.BackgroundTransparency = 1
LLogo.Text = "H I R O S H I"
LLogo.Font = Enum.Font.GothamBlack
LLogo.TextSize = 24
LLogo.TextColor3 = Colors.TextWhite

local LSub = Instance.new("TextLabel", LoginCard)
LSub.Size = UDim2.new(1, 0, 0, 20)
LSub.Position = UDim2.new(0, 0, 0, 70)
LSub.BackgroundTransparency = 1
LSub.Text = "Neural Engine Access"
LSub.Font = Enum.Font.GothamMedium
LSub.TextSize = 12
LSub.TextColor3 = Colors.Cyan

local InputContainer = Instance.new("Frame", LoginCard)
InputContainer.Size = UDim2.new(1, -60, 0, 45)
InputContainer.Position = UDim2.new(0, 30, 0, 130)
InputContainer.BackgroundColor3 = Colors.AppBg
Instance.new("UICorner", InputContainer).CornerRadius = UDim.new(0, 8)
local InputStroke = Instance.new("UIStroke", InputContainer)
InputStroke.Color = Color3.fromRGB(60, 60, 75)

local PassInput = Instance.new("TextBox", InputContainer)
PassInput.Size = UDim2.new(1, -20, 1, 0)
PassInput.Position = UDim2.new(0, 10, 0, 0)
PassInput.BackgroundTransparency = 1
PassInput.Text = ""
PassInput.PlaceholderText = "Saisissez votre clé de licence..."
PassInput.Font = Enum.Font.Gotham
PassInput.TextSize = 13
PassInput.TextColor3 = Colors.TextWhite
PassInput.TextXAlignment = Enum.TextXAlignment.Left

PassInput.Focused:Connect(function() TS:Create(InputStroke, TweenInfo.new(0.3), {Color = Colors.Purple}):Play() end)
PassInput.FocusLost:Connect(function() TS:Create(InputStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(60, 60, 75)}):Play() end)

local AuthBtn = Instance.new("TextButton", LoginCard)
AuthBtn.Size = UDim2.new(1, -60, 0, 45)
AuthBtn.Position = UDim2.new(0, 30, 0, 190)
AuthBtn.BackgroundColor3 = Colors.TextWhite
AuthBtn.Text = "Initialiser la connexion"
AuthBtn.Font = Enum.Font.GothamBold
AuthBtn.TextSize = 13
AuthBtn.TextColor3 = Colors.AppBg
Instance.new("UICorner", AuthBtn).CornerRadius = UDim.new(0, 8)
ApplyHover(AuthBtn, 1.02)

local LoginStatus = Instance.new("TextLabel", LoginCard)
LoginStatus.Size = UDim2.new(1, 0, 0, 20)
LoginStatus.Position = UDim2.new(0, 0, 0, 245)
LoginStatus.BackgroundTransparency = 1
LoginStatus.Text = ""
LoginStatus.Font = Enum.Font.Gotham
LoginStatus.TextSize = 12

local LDiscordBtn = Instance.new("TextButton", LoginCard)
LDiscordBtn.Size = UDim2.new(1, -60, 0, 40)
LDiscordBtn.Position = UDim2.new(0, 30, 1, -60)
LDiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
LDiscordBtn.Text = "Rejoindre le Discord Officiel"
LDiscordBtn.Font = Enum.Font.GothamMedium
LDiscordBtn.TextSize = 12
LDiscordBtn.TextColor3 = Colors.TextWhite
Instance.new("UICorner", LDiscordBtn).CornerRadius = UDim.new(0, 8)
ApplyHover(LDiscordBtn, 1.02)

-- ==========================================
-- 🎛️ TABLEAU DE BORD (DASHBOARD REDESIGN)
-- ==========================================
local DashView = Instance.new("Frame", MainApp)
DashView.Size = UDim2.new(1, 0, 1, 0)
DashView.BackgroundTransparency = 1
DashView.Visible = false

-- SIDEBAR
local Sidebar = Instance.new("Frame", DashView)
Sidebar.Size = UDim2.new(0, 220, 1, 0)
Sidebar.BackgroundColor3 = Colors.CardBg
Sidebar.BorderSizePixel = 0
local SideBorder = Instance.new("Frame", Sidebar)
SideBorder.Size = UDim2.new(0, 1, 1, 0)
SideBorder.Position = UDim2.new(1, 0, 0, 0)
SideBorder.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
SideBorder.BorderSizePixel = 0

local DLogo = Instance.new("TextLabel", Sidebar)
DLogo.Size = UDim2.new(1, 0, 0, 80)
DLogo.BackgroundTransparency = 1
DLogo.Text = "H I R O S H I"
DLogo.Font = Enum.Font.GothamBlack
DLogo.TextSize = 18
DLogo.TextColor3 = Colors.TextWhite

local MenuBtn = Instance.new("Frame", Sidebar)
MenuBtn.Size = UDim2.new(1, -40, 0, 45)
MenuBtn.Position = UDim2.new(0, 20, 0, 90)
MenuBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 45)
Instance.new("UICorner", MenuBtn).CornerRadius = UDim.new(0, 8)
Instance.new("UIStroke", MenuBtn).Color = Colors.Purple
local MenuIcon = Instance.new("TextLabel", MenuBtn)
MenuIcon.Size = UDim2.new(0, 40, 1, 0)
MenuIcon.BackgroundTransparency = 1
MenuIcon.Text = "🧠"
MenuIcon.Font = Enum.Font.Gotham
MenuIcon.TextSize = 16
local MenuTxt = Instance.new("TextLabel", MenuBtn)
MenuTxt.Size = UDim2.new(1, -40, 1, 0)
MenuTxt.Position = UDim2.new(0, 40, 0, 0)
MenuTxt.BackgroundTransparency = 1
MenuTxt.Text = "Neural A.I. Core"
MenuTxt.Font = Enum.Font.GothamBold
MenuTxt.TextSize = 13
MenuTxt.TextColor3 = Colors.TextWhite
MenuTxt.TextXAlignment = Enum.TextXAlignment.Left

-- PROFIL UTILISATEUR (Dans la sidebar en bas)
local ProfileCard = Instance.new("Frame", Sidebar)
ProfileCard.Size = UDim2.new(1, -40, 0, 60)
ProfileCard.Position = UDim2.new(0, 20, 1, -80)
ProfileCard.BackgroundColor3 = Colors.AppBg
Instance.new("UICorner", ProfileCard).CornerRadius = UDim.new(0, 10)
Instance.new("UIStroke", ProfileCard).Color = Color3.fromRGB(40, 40, 50)

local Avatar = Instance.new("ImageLabel", ProfileCard)
Avatar.Size = UDim2.new(0, 36, 0, 36)
Avatar.Position = UDim2.new(0, 12, 0.5, -18)
Avatar.BackgroundColor3 = Colors.CardBg
Instance.new("UICorner", Avatar).CornerRadius = UDim.new(1, 0)
Avatar.Image = "rbxthumb://type=AvatarHeadShot&id="..LP.UserId.."&w=48&h=48"

local OnlineDot = Instance.new("Frame", Avatar)
OnlineDot.Size = UDim2.new(0, 10, 0, 10)
OnlineDot.Position = UDim2.new(1, -8, 1, -8)
OnlineDot.BackgroundColor3 = Colors.Success
Instance.new("UICorner", OnlineDot).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OnlineDot).Color = Colors.AppBg

local PName = Instance.new("TextLabel", ProfileCard)
PName.Size = UDim2.new(1, -60, 0, 18)
PName.Position = UDim2.new(0, 58, 0, 12)
PName.BackgroundTransparency = 1
PName.Text = LP.Name
PName.Font = Enum.Font.GothamBold
PName.TextSize = 12
PName.TextColor3 = Colors.TextWhite
PName.TextXAlignment = Enum.TextXAlignment.Left

local PRank = Instance.new("TextLabel", ProfileCard)
PRank.Size = UDim2.new(1, -60, 0, 15)
PRank.Position = UDim2.new(0, 58, 0, 32)
PRank.BackgroundTransparency = 1
PRank.Text = "Licence Lifetime 💎"
PRank.Font = Enum.Font.GothamMedium
PRank.TextSize = 10
PRank.TextColor3 = Colors.Cyan
PRank.TextXAlignment = Enum.TextXAlignment.Left

-- CONTENU DROITE (Dashboard)
local Content = Instance.new("Frame", DashView)
Content.Size = UDim2.new(1, -220, 1, 0)
Content.Position = UDim2.new(0, 220, 0, 0)
Content.BackgroundTransparency = 1

-- Header Top
local TopHeader = Instance.new("Frame", Content)
TopHeader.Size = UDim2.new(1, 0, 0, 80)
TopHeader.BackgroundTransparency = 1

local WelcomeMsg = Instance.new("TextLabel", TopHeader)
WelcomeMsg.Size = UDim2.new(0, 300, 0, 30)
WelcomeMsg.Position = UDim2.new(0, 30, 0, 25)
WelcomeMsg.BackgroundTransparency = 1
WelcomeMsg.Text = "Tableau de Bord / Aperçu"
WelcomeMsg.Font = Enum.Font.GothamBold
WelcomeMsg.TextSize = 16
WelcomeMsg.TextColor3 = Colors.TextWhite
WelcomeMsg.TextXAlignment = Enum.TextXAlignment.Left

local TimeLbl = Instance.new("TextLabel", TopHeader)
TimeLbl.Size = UDim2.new(0, 100, 0, 30)
TimeLbl.Position = UDim2.new(1, -130, 0, 25)
TimeLbl.BackgroundTransparency = 1
TimeLbl.Font = Enum.Font.GothamMedium
TimeLbl.TextSize = 13
TimeLbl.TextColor3 = Colors.TextGray
TimeLbl.TextXAlignment = Enum.TextXAlignment.Right
RS.RenderStepped:Connect(function()
    local d = os.date("*t")
    TimeLbl.Text = string.format("%02d:%02d:%02d", d.hour, d.min, d.sec)
end)

-- CARTE PRINCIPALE : AIMBOT ENGINE
local EngineCard = Instance.new("Frame", Content)
EngineCard.Size = UDim2.new(1, -60, 0, 160)
EngineCard.Position = UDim2.new(0, 30, 0, 80)
EngineCard.BackgroundColor3 = Colors.CardBg
Instance.new("UICorner", EngineCard).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", EngineCard).Color = Color3.fromRGB(40, 40, 55)

local ETitle = Instance.new("TextLabel", EngineCard)
ETitle.Size = UDim2.new(1, -40, 0, 30)
ETitle.Position = UDim2.new(0, 25, 0, 20)
ETitle.BackgroundTransparency = 1
ETitle.Text = "Configuration Neurale"
ETitle.Font = Enum.Font.GothamBold
ETitle.TextSize = 15
ETitle.TextColor3 = Colors.TextWhite
ETitle.TextXAlignment = Enum.TextXAlignment.Left

local EDesc = Instance.new("TextLabel", EngineCard)
EDesc.Size = UDim2.new(1, -40, 0, 35)
EDesc.Position = UDim2.new(0, 25, 0, 50)
EDesc.BackgroundTransparency = 1
EDesc.Text = "Le système analyse l'environnement 3D en temps réel pour verrouiller les objets spatiaux de manière chirurgicale."
EDesc.Font = Enum.Font.Gotham
EDesc.TextSize = 12
EDesc.TextColor3 = Colors.TextGray
EDesc.TextXAlignment = Enum.TextXAlignment.Left
EDesc.TextWrapped = true

-- Switch iOS / Premium
local SwitchLabel = Instance.new("TextLabel", EngineCard)
SwitchLabel.Size = UDim2.new(0, 200, 0, 30)
SwitchLabel.Position = UDim2.new(0, 25, 1, -45)
SwitchLabel.BackgroundTransparency = 1
SwitchLabel.Text = "Activer l'Engine (Touche X)"
SwitchLabel.Font = Enum.Font.GothamMedium
SwitchLabel.TextSize = 13
SwitchLabel.TextColor3 = Colors.TextWhite
SwitchLabel.TextXAlignment = Enum.TextXAlignment.Left

local ToggleBg = Instance.new("Frame", EngineCard)
ToggleBg.Size = UDim2.new(0, 54, 0, 28)
ToggleBg.Position = UDim2.new(1, -80, 1, -45)
ToggleBg.BackgroundColor3 = Colors.AppBg
Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", ToggleBg)
ToggleStroke.Color = Color3.fromRGB(60, 60, 75)

local ToggleKnob = Instance.new("Frame", ToggleBg)
ToggleKnob.Size = UDim2.new(0, 20, 0, 20)
ToggleKnob.Position = UDim2.new(0, 4, 0.5, -10)
ToggleKnob.BackgroundColor3 = Colors.TextGray
Instance.new("UICorner", ToggleKnob).CornerRadius = UDim.new(1, 0)

local ToggleBtn = Instance.new("TextButton", ToggleBg)
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = ""

-- GRILLE DU BAS (Stats & Discord)
local BottomGrid = Instance.new("Frame", Content)
BottomGrid.Size = UDim2.new(1, -60, 0, 110)
BottomGrid.Position = UDim2.new(0, 30, 0, 260)
BottomGrid.BackgroundTransparency = 1

local UIListLayout = Instance.new("UIListLayout", BottomGrid)
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.SpaceBetween

-- Card: Cibles
local StatCard1 = Instance.new("Frame", BottomGrid)
StatCard1.Size = UDim2.new(0.31, 0, 1, 0)
StatCard1.BackgroundColor3 = Colors.CardBg
Instance.new("UICorner", StatCard1).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", StatCard1).Color = Color3.fromRGB(40, 40, 55)
ApplyHover(StatCard1, 1.02, Colors.CardHover)

local S1Icon = Instance.new("TextLabel", StatCard1)
S1Icon.Size = UDim2.new(1, 0, 0, 30)
S1Icon.Position = UDim2.new(0, 0, 0, 15)
S1Icon.BackgroundTransparency = 1
S1Icon.Text = "🎯"
S1Icon.Font = Enum.Font.Gotham
S1Icon.TextSize = 18
local S1Title = Instance.new("TextLabel", StatCard1)
S1Title.Size = UDim2.new(1, 0, 0, 20)
S1Title.Position = UDim2.new(0, 0, 0, 45)
S1Title.BackgroundTransparency = 1
S1Title.Text = "Cibles Éliminées"
S1Title.Font = Enum.Font.GothamMedium
S1Title.TextSize = 11
S1Title.TextColor3 = Colors.TextGray
local HitsDisplay = Instance.new("TextLabel", StatCard1)
HitsDisplay.Size = UDim2.new(1, 0, 0, 30)
HitsDisplay.Position = UDim2.new(0, 0, 0, 65)
HitsDisplay.BackgroundTransparency = 1
HitsDisplay.Text = "0"
HitsDisplay.Font = Enum.Font.GothamBlack
HitsDisplay.TextSize = 22
HitsDisplay.TextColor3 = Colors.Cyan

-- Card: Précision
local StatCard2 = Instance.new("Frame", BottomGrid)
StatCard2.Size = UDim2.new(0.31, 0, 1, 0)
StatCard2.BackgroundColor3 = Colors.CardBg
Instance.new("UICorner", StatCard2).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", StatCard2).Color = Color3.fromRGB(40, 40, 55)
ApplyHover(StatCard2, 1.02, Colors.CardHover)

local S2Icon = Instance.new("TextLabel", StatCard2)
S2Icon.Size = UDim2.new(1, 0, 0, 30)
S2Icon.Position = UDim2.new(0, 0, 0, 15)
S2Icon.BackgroundTransparency = 1
S2Icon.Text = "⚡"
S2Icon.Font = Enum.Font.Gotham
S2Icon.TextSize = 18
local S2Title = Instance.new("TextLabel", StatCard2)
S2Title.Size = UDim2.new(1, 0, 0, 20)
S2Title.Position = UDim2.new(0, 0, 0, 45)
S2Title.BackgroundTransparency = 1
S2Title.Text = "Précision IA"
S2Title.Font = Enum.Font.GothamMedium
S2Title.TextSize = 11
S2Title.TextColor3 = Colors.TextGray
local AccDisplay = Instance.new("TextLabel", StatCard2)
AccDisplay.Size = UDim2.new(1, 0, 0, 30)
AccDisplay.Position = UDim2.new(0, 0, 0, 65)
AccDisplay.BackgroundTransparency = 1
AccDisplay.Text = "99.9%"
AccDisplay.Font = Enum.Font.GothamBlack
AccDisplay.TextSize = 22
AccDisplay.TextColor3 = Colors.Purple

-- Card: Discord
local DiscordCard = Instance.new("Frame", BottomGrid)
DiscordCard.Size = UDim2.new(0.31, 0, 1, 0)
DiscordCard.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
Instance.new("UICorner", DiscordCard).CornerRadius = UDim.new(0, 12)
ApplyHover(DiscordCard, 1.02)

local DIcon = Instance.new("TextLabel", DiscordCard)
DIcon.Size = UDim2.new(1, 0, 0, 30)
DIcon.Position = UDim2.new(0, 0, 0, 15)
DIcon.BackgroundTransparency = 1
DIcon.Text = "💬"
DIcon.Font = Enum.Font.Gotham
DIcon.TextSize = 22
local DTitle = Instance.new("TextLabel", DiscordCard)
DTitle.Size = UDim2.new(1, 0, 0, 20)
DTitle.Position = UDim2.new(0, 0, 0, 45)
DTitle.BackgroundTransparency = 1
DTitle.Text = "Communauté"
DTitle.Font = Enum.Font.GothamMedium
DTitle.TextSize = 11
DTitle.TextColor3 = Color3.new(1,1,1)
local DCopyBtn = Instance.new("TextButton", DiscordCard)
DCopyBtn.Size = UDim2.new(0, 100, 0, 26)
DCopyBtn.Position = UDim2.new(0.5, -50, 0, 70)
DCopyBtn.BackgroundColor3 = Color3.fromRGB(70, 80, 200)
DCopyBtn.Text = "Copier le Lien"
DCopyBtn.Font = Enum.Font.GothamBold
DCopyBtn.TextSize = 11
DCopyBtn.TextColor3 = Color3.new(1,1,1)
Instance.new("UICorner", DCopyBtn).CornerRadius = UDim.new(0, 6)

local InfoFooter = Instance.new("TextLabel", Content)
InfoFooter.Size = UDim2.new(1, 0, 0, 20)
InfoFooter.Position = UDim2.new(0, 0, 1, -35)
InfoFooter.BackgroundTransparency = 1
InfoFooter.Text = "Mode Furtif : Appuyez sur [CTRL] pour cacher l'interface."
InfoFooter.Font = Enum.Font.Gotham
InfoFooter.TextSize = 11
InfoFooter.TextColor3 = Color3.fromRGB(100, 100, 115)

-- ==========================================
-- 🔄 LOGIQUE ET ANIMATIONS
-- ==========================================

-- Animation de lancement
MainApp.Size = UDim2.new(0, 700, 0, 430)
TS:Create(MainApp, TweenInfo.new(1, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {GroupTransparency = 0, Size = UDim2.new(0, 780, 0, 480)}):Play()

-- Logique Discord (Login & Dashboard)
local function CopyDiscord()
    if setclipboard then
        setclipboard(DISCORD_LINK)
        DCopyBtn.Text = "Copié !"
        DCopyBtn.BackgroundColor3 = Colors.Success
        task.wait(2)
        DCopyBtn.Text = "Copier le Lien"
        DCopyBtn.BackgroundColor3 = Color3.fromRGB(70, 80, 200)
    end
end
LDiscordBtn.MouseButton1Click:Connect(CopyDiscord)
DCopyBtn.MouseButton1Click:Connect(CopyDiscord)

-- LOGIQUE DE CONNEXION (Sans bug d'écran noir)
AuthBtn.MouseButton1Click:Connect(function()
    AuthBtn.Text = "Analyse neurale..."
    LoginStatus.Text = "Vérification de la clé de licence dans la base de données..."
    LoginStatus.TextColor3 = Colors.TextGray
    
    task.wait(0.6) -- Délai premium
    
    if PassInput.Text == PASSWORD then
        LoginStatus.Text = "Accès autorisé. Chargement du profil..."
        LoginStatus.TextColor3 = Colors.Success
        AuthBtn.BackgroundColor3 = Colors.Success
        AuthBtn.Text = "Connecté"
        
        task.wait(0.5)
        
        -- Transition Parfaite (Fade Out Login)
        local fadeOut = TS:Create(LoginView, TweenInfo.new(0.4), {BackgroundTransparency = 1})
        for _, v in ipairs(LoginView:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextBox") or v:IsA("TextButton") then
                TS:Create(v, TweenInfo.new(0.4), {TextTransparency = 1, BackgroundTransparency = 1}):Play()
            elseif v:IsA("Frame") or v:IsA("ImageLabel") then
                TS:Create(v, TweenInfo.new(0.4), {BackgroundTransparency = 1, ImageTransparency = 1}):Play()
            end
        end
        fadeOut:Play()
        fadeOut.Completed:Wait()
        
        LoginView.Visible = false
        
        -- Fade In Dashboard
        DashView.Visible = true
        for _, v in ipairs(DashView:GetDescendants()) do
            if v:IsA("TextLabel") or v:IsA("TextButton") then
                v.TextTransparency = 1
                TS:Create(v, TweenInfo.new(0.5), {TextTransparency = 0}):Play()
            end
        end
        IsAuthenticated = true
    else
        LoginStatus.Text = "Erreur : Clé de licence invalide ou expirée."
        LoginStatus.TextColor3 = Colors.Danger
        AuthBtn.Text = "Réessayer"
        
        local origX = InputContainer.Position.X.Offset
        for i = 1, 4 do
            InputContainer.Position = UDim2.new(0, origX + (i%2==0 and 6 or -6), 0, 130)
            task.wait(0.05)
        end
        InputContainer.Position = UDim2.new(0, origX, 0, 130)
    end
end)

-- Switch Aimbot
local function ToggleEngine()
    if not IsAuthenticated then return end
    AutoHit = not AutoHit
    
    local endPos = AutoHit and UDim2.new(1, -24, 0.5, -10) or UDim2.new(0, 4, 0.5, -10)
    local endBg = AutoHit and Colors.Cyan or Colors.AppBg
    local endKnob = AutoHit and Colors.AppBg or Colors.TextGray
    
    TS:Create(ToggleKnob, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = endPos, BackgroundColor3 = endKnob}):Play()
    TS:Create(ToggleBg, TweenInfo.new(0.3), {BackgroundColor3 = endBg}):Play()
    TS:Create(ToggleStroke, TweenInfo.new(0.3), {Color = AutoHit and Colors.Cyan or Color3.fromRGB(60, 60, 75)}):Play()
    
    if AutoHit then
        EngineCard.UIStroke.Color = Colors.Cyan
    else
        EngineCard.UIStroke.Color = Color3.fromRGB(40, 40, 55)
    end
end
ToggleBtn.MouseButton1Click:Connect(ToggleEngine)

-- Dragging Fenêtre
local dragging, dragInput, dragStart, startPos
MainApp.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true dragStart = input.Position startPos = MainApp.Position
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
        MainApp.Position = MainApp.Position:Lerp(UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y), 0.15)
    end
end)

-- Raccourcis & Stream Proof
UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.X and IsAuthenticated then
        ToggleEngine()
    elseif (i.KeyCode == Enum.KeyCode.LeftControl or i.KeyCode == Enum.KeyCode.RightControl) then
        MenuVisible = not MenuVisible
        if MenuVisible then
            MainApp.Visible = true
            CosmicLayer.Visible = true 
            TS:Create(MainApp, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {GroupTransparency = 0, Size = UDim2.new(0, 780, 0, 480)}):Play()
        else
            local t = TS:Create(MainApp, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {GroupTransparency = 1, Size = UDim2.new(0, 750, 0, 450)})
            t:Play()
            t.Completed:Wait()
            MainApp.Visible = false
            CosmicLayer.Visible = false 
        end
    elseif i.KeyCode == Enum.KeyCode.Delete then 
        SG:Destroy()
    end
end)

-- ==========================================
-- 🎯 MOTEUR IA (Aimbot Intact)
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
                if v.Name == "Cursor" and v:IsA("BasePart") then
                    cachedCursor = v break
                end
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
        for _,v in ipairs(gf:GetChildren()) do
            if v:IsA("BasePart") and v ~= cursor and v.Transparency < 0.9 then
                local nm = v.Name:lower()
                if not IGNORE[nm] and not nm:find("cursor") and not nm:find("particle")
                   and not nm:find("emitter") and not nm:find("beat") and not nm:find("light")
                   and not nm:find("camera") and not nm:find("song") and not nm:find("lobby")
                   and not nm:find("status") and not nm:find("mod") and not nm:find("spec")
                   and not nm:find("fade") and not nm:find("spawn") then
                    if v.Size.X <= 6 and v.Size.Y <= 6 and v.Size.Z <= 6 then
                        table.insert(notes, v)
                    end
                end
            end
        end
        for _,folder in ipairs(gf:GetChildren()) do
            if folder:IsA("Folder") or folder:IsA("Model") then
                local fn = folder.Name:lower()
                if fn ~= "scores" and fn ~= "spawneffects" and fn ~= "noteeffects" then
                    for _,v in ipairs(folder:GetDescendants()) do
                        if v:IsA("BasePart") and v.Transparency < 0.9 and v.Size.X <= 6 then
                            table.insert(notes, v)
                        end
                    end
                end
            end
        end
    end)

    if #notes == 0 then 
        currentTarget = nil 
        return 
    end

    local scored = {}
    for _,note in ipairs(notes) do
        local sp, vis = Cam:WorldToViewportPoint(note.Position)
        if vis and sp.Z > 0 then
            table.insert(scored, {part = note, sx = sp.X, sy = sp.Y, depth = sp.Z})
        end
    end

    if #scored == 0 then 
        currentTarget = nil 
        return 
    end

    table.sort(scored, function(a, b) return a.depth < b.depth end)

    local targetStillExists = false
    if currentTarget then
        for _, s in ipairs(scored) do
            if s.part == currentTarget then
                targetStillExists = true
                break
            end
        end
    end

    local target = nil
    if targetStillExists then
        for _, s in ipairs(scored) do
            if s.part == currentTarget then
                target = s break
            end
        end
    else
        target = scored[1]
        currentTarget = target.part
    end

    local speed = 0.85
    cursorX = cursorX + (target.sx - cursorX) * speed
    cursorY = cursorY + (target.sy - cursorY) * speed

    local mousePos = UIS:GetMouseLocation()
    local dx = cursorX - mousePos.X
    local dy = cursorY - mousePos.Y

    if typeof(mousemoverel) == "function" then
        mousemoverel(dx, dy)
    end

    local distToTarget = math.sqrt((cursorX - target.sx)^2 + (cursorY - target.sy)^2)
    if distToTarget < 5 then
        TotalHits = TotalHits + 1
        currentTarget = nil
    end
end)
