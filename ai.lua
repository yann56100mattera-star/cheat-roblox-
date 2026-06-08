--[[
    =======================================================================
    🌌 IA NEXUS - BY HIROSHI738 (ULTIMATE EDITION)
    💎 Design v4 (Discord/Gradients) + Animation Singularité (Ctrl)
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
local IsAnimating = false 

if LP.PlayerGui:FindFirstChild("HiroshiNexus") then 
    LP.PlayerGui.HiroshiNexus:Destroy() 
end

-- ==========================================
-- 🎨 PALETTE & DESIGN SYSTEM
-- ==========================================
local Theme = {
    GlassBg = Color3.fromRGB(15, 15, 22),
    SpaceBlack = Color3.fromRGB(8, 8, 12),
    CardBg = Color3.fromRGB(18, 18, 26),
    Cyan = Color3.fromRGB(0, 225, 255),
    Purple = Color3.fromRGB(140, 60, 255),
    TextWhite = Color3.fromRGB(250, 250, 255),
    TextMuted = Color3.fromRGB(140, 140, 160),
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
-- 🌠 MOTEUR COSMIQUE (ÉTOILES & NÉBULEUSES)
-- ==========================================
local CosmosBg = Instance.new("Frame", SG)
CosmosBg.Size = UDim2.new(1, 0, 1, 0)
CosmosBg.BackgroundTransparency = 1
CosmosBg.ZIndex = -10

local CosmosElements = {} 

local function CreateNebula(color, pos, size, baseTrans)
    local nebula = Instance.new("ImageLabel", CosmosBg)
    nebula.Size = size
    nebula.Position = pos
    nebula.AnchorPoint = Vector2.new(0.5, 0.5)
    nebula.BackgroundTransparency = 1
    nebula.Image = "rbxassetid://5028857084"
    nebula.ImageColor3 = color
    nebula.ImageTransparency = baseTrans
    table.insert(CosmosElements, {inst = nebula, prop = "ImageTransparency", base = baseTrans, isStar = false})
end

CreateNebula(Theme.Purple, UDim2.new(0.2, 0, 0.3, 0), UDim2.new(0, 800, 0, 800), 0.6)
CreateNebula(Theme.Cyan, UDim2.new(0.8, 0, 0.7, 0), UDim2.new(0, 900, 0, 900), 0.7)

local stars = {}
for i = 1, 150 do
    local star = Instance.new("Frame", CosmosBg)
    local size = math.random(1, 3)
    local baseTrans = math.random(20, 80) / 100
    star.Size = UDim2.new(0, size, 0, size)
    star.Position = UDim2.new(math.random(), 0, math.random(), 0)
    star.BackgroundColor3 = (math.random(1, 5) == 1) and Theme.Cyan or Color3.new(1,1,1)
    star.BorderSizePixel = 0
    star.BackgroundTransparency = baseTrans
    Instance.new("UICorner", star).CornerRadius = UDim.new(1, 0)
    
    table.insert(stars, {frame = star, speed = math.random(1, 10) / 100000})
    table.insert(CosmosElements, {inst = star, prop = "BackgroundTransparency", base = baseTrans, isStar = true, baseSize = size})
end

RS.RenderStepped:Connect(function()
    for _, s in ipairs(stars) do
        local newY = s.frame.Position.Y.Scale + s.speed
        if newY > 1 then newY = 0 end
        s.frame.Position = UDim2.new(s.frame.Position.X.Scale, 0, newY, 0)
    end
    
    if MenuVisible and not IsAnimating then
        if math.random(1, 200) == 1 then
            local fs = Instance.new("Frame", CosmosBg)
            fs.Size = UDim2.new(0, 40, 0, 2)
            fs.Position = UDim2.new(math.random(), 0, 0, -50)
            fs.BackgroundColor3 = Theme.Cyan
            fs.BorderSizePixel = 0
            fs.Rotation = 45
            TS:Create(fs, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {Position = UDim2.new(fs.Position.X.Scale - 0.2, 0, 1.2, 0), BackgroundTransparency = 1}):Play()
            game.Debris:AddItem(fs, 1)
        end
    end
end)

RS.RenderStepped:Connect(function()
    if not MenuVisible or IsAnimating then return end
    local mouseLoc = UIS:GetMouseLocation()
    if math.random(1, 2) == 1 then
        local p = Instance.new("Frame", CosmosBg)
        p.Size = UDim2.new(0, 4, 0, 4)
        p.Position = UDim2.new(0, mouseLoc.X + math.random(-6, 6), 0, mouseLoc.Y + math.random(-6, 6))
        p.BackgroundColor3 = (math.random(1, 2) == 1) and Theme.Cyan or Theme.Purple
        p.BorderSizePixel = 0
        Instance.new("UICorner", p).CornerRadius = UDim.new(1, 0)
        
        TS:Create(p, TweenInfo.new(0.6, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Position = UDim2.new(0, p.Position.X.Offset, 0, p.Position.Y.Offset + 20),
            BackgroundTransparency = 1, Size = UDim2.new(0, 0, 0, 0)
        }):Play()
        game.Debris:AddItem(p, 0.6)
    end
end)

-- ==========================================
-- 💻 CONTENEUR PRINCIPAL (Correction du "Trait")
-- ==========================================
-- Le Wrapper gère la bordure et le glow
local AppWrapper = Instance.new("Frame", SG)
AppWrapper.Size = UDim2.new(0, 750, 0, 450)
AppWrapper.Position = UDim2.new(0.5, 0, 0.5, 0)
AppWrapper.AnchorPoint = Vector2.new(0.5, 0.5)
AppWrapper.BackgroundTransparency = 1
AppWrapper.BorderSizePixel = 0
AppWrapper.ClipsDescendants = false

local AppGlow = Instance.new("ImageLabel", AppWrapper)
AppGlow.Size = UDim2.new(1, 60, 1, 60)
AppGlow.Position = UDim2.new(0, -30, 0, -30)
AppGlow.BackgroundTransparency = 1
AppGlow.Image = "rbxassetid://5028857084"
AppGlow.ImageColor3 = Theme.Purple
AppGlow.ImageTransparency = 0.5
AppGlow.ZIndex = -1
table.insert(CosmosElements, {inst = AppGlow, prop = "ImageTransparency", base = 0.5, isStar = false})

local WrapperStroke = Instance.new("UIStroke", AppWrapper)
WrapperStroke.Thickness = 1.5
local GradientStroke = Instance.new("UIGradient", WrapperStroke)
GradientStroke.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Theme.Cyan),
    ColorSequenceKeypoint.new(0.5, Theme.Purple),
    ColorSequenceKeypoint.new(1, Theme.Cyan)
}
Instance.new("UICorner", AppWrapper).CornerRadius = UDim.new(0, 14)

-- La Window gère le contenu et coupe proprement ce qui dépasse (ClipsDescendants) sans buguer
local AppWindow = Instance.new("Frame", AppWrapper)
AppWindow.Size = UDim2.new(1, 0, 1, 0)
AppWindow.BackgroundColor3 = Theme.GlassBg
AppWindow.BackgroundTransparency = 0.1
AppWindow.BorderSizePixel = 0
AppWindow.ClipsDescendants = true
Instance.new("UICorner", AppWindow).CornerRadius = UDim.new(0, 14)

-- ==========================================
-- 🔐 ÉCRAN DE CONNEXION (Retour du Design V4)
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
Instance.new("UIStroke", LoginCard).Color = Color3.fromRGB(40, 40, 55)

local LTitle = Instance.new("TextLabel", LoginCard)
LTitle.Size = UDim2.new(1, 0, 0, 40)
LTitle.Position = UDim2.new(0, 0, 0, 40)
LTitle.BackgroundTransparency = 1
LTitle.Text = "I A   N E X U S"
LTitle.Font = Enum.Font.GothamBlack
LTitle.TextSize = 26
LTitle.TextColor3 = Theme.TextWhite

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
InputBg.BackgroundColor3 = Theme.SpaceBlack
Instance.new("UICorner", InputBg).CornerRadius = UDim.new(0, 8)
local InputStroke = Instance.new("UIStroke", InputBg)
InputStroke.Color = Theme.Purple

local PassInput = Instance.new("TextBox", InputBg)
PassInput.Size = UDim2.new(1, -20, 1, 0)
PassInput.Position = UDim2.new(0, 10, 0, 0)
PassInput.BackgroundTransparency = 1
PassInput.Text = ""
PassInput.PlaceholderText = "Saisissez votre clé Nexus"
PassInput.Font = Enum.Font.Gotham
PassInput.TextSize = 13
PassInput.TextColor3 = Theme.TextWhite
PassInput.TextXAlignment = Enum.TextXAlignment.Left

local DiscordBtn = Instance.new("TextButton", LoginCard)
DiscordBtn.Size = UDim2.new(0, 140, 0, 45)
DiscordBtn.Position = UDim2.new(0, 30, 0, 210)
DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
DiscordBtn.Text = "Discord"
DiscordBtn.Font = Enum.Font.GothamBold
DiscordBtn.TextSize = 13
DiscordBtn.TextColor3 = Theme.TextWhite
Instance.new("UICorner", DiscordBtn).CornerRadius = UDim.new(0, 8)

local AuthBtn = Instance.new("TextButton", LoginCard)
AuthBtn.Size = UDim2.new(0, 140, 0, 45)
AuthBtn.Position = UDim2.new(1, -170, 0, 210)
AuthBtn.BackgroundColor3 = Theme.Cyan
AuthBtn.Text = "Connexion"
AuthBtn.Font = Enum.Font.GothamBold
AuthBtn.TextSize = 13
AuthBtn.TextColor3 = Theme.SpaceBlack
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
DashScreen.Position = UDim2.new(1, 0, 0, 0) 
DashScreen.BackgroundTransparency = 1
DashScreen.Visible = false -- Masqué par défaut pour empêcher le bug du trait

local Sidebar = Instance.new("Frame", DashScreen)
Sidebar.Size = UDim2.new(0, 220, 1, 0)
Sidebar.BackgroundColor3 = Theme.SpaceBlack
Sidebar.BackgroundTransparency = 0.3
Sidebar.BorderSizePixel = 0
local SidebarLine = Instance.new("Frame", Sidebar)
SidebarLine.Size = UDim2.new(0, 1, 1, 0)
SidebarLine.Position = UDim2.new(1, 0, 0, 0)
SidebarLine.BackgroundColor3 = Theme.Purple
SidebarLine.BorderSizePixel = 0
SidebarLine.Transparency = 0.5

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
MenuTxt.TextColor3 = Theme.TextWhite

local ProfileCard = Instance.new("Frame", Sidebar)
ProfileCard.Size = UDim2.new(1, -30, 0, 65)
ProfileCard.Position = UDim2.new(0, 15, 1, -80)
ProfileCard.BackgroundColor3 = Theme.SpaceBlack
Instance.new("UICorner", ProfileCard).CornerRadius = UDim.new(0, 10)
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
PName.TextColor3 = Theme.TextWhite
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

local CenterCol = Instance.new("Frame", DashScreen)
CenterCol.Size = UDim2.new(0, 330, 1, 0)
CenterCol.Position = UDim2.new(0, 220, 0, 0)
CenterCol.BackgroundTransparency = 1

local EngineCard = Instance.new("Frame", CenterCol)
EngineCard.Size = UDim2.new(1, -20, 0, 160)
EngineCard.Position = UDim2.new(0, 20, 0, 80)
EngineCard.BackgroundColor3 = Theme.CardBg
Instance.new("UICorner", EngineCard).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", EngineCard).Color = Color3.fromRGB(40, 40, 55)

local ETitle = Instance.new("TextLabel", EngineCard)
ETitle.Size = UDim2.new(1, -40, 0, 30)
ETitle.Position = UDim2.new(0, 20, 0, 20)
ETitle.BackgroundTransparency = 1
ETitle.Text = "Configuration IA Nexus"
ETitle.Font = Enum.Font.GothamBold
ETitle.TextSize = 15
ETitle.TextColor3 = Theme.TextWhite
ETitle.TextXAlignment = Enum.TextXAlignment.Left
local EDesc = Instance.new("TextLabel", EngineCard)
EDesc.Size = UDim2.new(1, -40, 0, 40)
EDesc.Position = UDim2.new(0, 20, 0, 50)
EDesc.BackgroundTransparency = 1
EDesc.Text = "Analyse de l'environnement 3D en temps réel pour un verrouillage spatial absolu et indétectable."
EDesc.Font = Enum.Font.Gotham
EDesc.TextSize = 11
EDesc.TextColor3 = Theme.TextMuted
EDesc.TextXAlignment = Enum.TextXAlignment.Left
EDesc.TextWrapped = true

local SwitchLbl = Instance.new("TextLabel", EngineCard)
SwitchLbl.Size = UDim2.new(0, 200, 0, 30)
SwitchLbl.Position = UDim2.new(0, 20, 1, -50)
SwitchLbl.BackgroundTransparency = 1
SwitchLbl.Text = "Activer l'I.A. (Touche X)"
SwitchLbl.Font = Enum.Font.GothamMedium
SwitchLbl.TextSize = 12
SwitchLbl.TextColor3 = Theme.TextWhite
SwitchLbl.TextXAlignment = Enum.TextXAlignment.Left

local ToggleBg = Instance.new("Frame", EngineCard)
ToggleBg.Size = UDim2.new(0, 50, 0, 26)
ToggleBg.Position = UDim2.new(1, -70, 1, -50)
ToggleBg.BackgroundColor3 = Theme.SpaceBlack
Instance.new("UICorner", ToggleBg).CornerRadius = UDim.new(1, 0)
local ToggleStroke = Instance.new("UIStroke", ToggleBg)
ToggleStroke.Color = Color3.fromRGB(60, 60, 75)
local ToggleKnob = Instance.new("Frame", ToggleBg)
ToggleKnob.Size = UDim2.new(0, 18, 0, 18)
ToggleKnob.Position = UDim2.new(0, 4, 0.5, -9)
ToggleKnob.BackgroundColor3 = Theme.TextWhite
Instance.new("UICorner", ToggleKnob).CornerRadius = UDim.new(1, 0)
local ToggleBtn = Instance.new("TextButton", ToggleBg)
ToggleBtn.Size = UDim2.new(1, 0, 1, 0)
ToggleBtn.BackgroundTransparency = 1
ToggleBtn.Text = ""

local StatContainer = Instance.new("Frame", CenterCol)
StatContainer.Size = UDim2.new(1, -20, 0, 110)
StatContainer.Position = UDim2.new(0, 20, 0, 260)
StatContainer.BackgroundTransparency = 1

local StatCard1 = Instance.new("Frame", StatContainer)
StatCard1.Size = UDim2.new(0.48, 0, 1, 0)
StatCard1.BackgroundColor3 = Theme.CardBg
Instance.new("UICorner", StatCard1).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", StatCard1).Color = Color3.fromRGB(40, 40, 55)
local S1Title = Instance.new("TextLabel", StatCard1)
S1Title.Size = UDim2.new(1, 0, 0, 20)
S1Title.Position = UDim2.new(0, 0, 0, 20)
S1Title.BackgroundTransparency = 1
S1Title.Text = "CIBLES ÉLIMINÉES"
S1Title.Font = Enum.Font.GothamMedium
S1Title.TextSize = 10
S1Title.TextColor3 = Theme.TextMuted
local HitsDisplay = Instance.new("TextLabel", StatCard1)
HitsDisplay.Size = UDim2.new(1, 0, 0, 40)
HitsDisplay.Position = UDim2.new(0, 0, 0, 45)
HitsDisplay.BackgroundTransparency = 1
HitsDisplay.Text = "0"
HitsDisplay.Font = Enum.Font.GothamBlack
HitsDisplay.TextSize = 26
HitsDisplay.TextColor3 = Theme.Cyan

local StatCard2 = Instance.new("Frame", StatContainer)
StatCard2.Size = UDim2.new(0.48, 0, 1, 0)
StatCard2.Position = UDim2.new(0.52, 0, 0, 0)
StatCard2.BackgroundColor3 = Theme.CardBg
Instance.new("UICorner", StatCard2).CornerRadius = UDim.new(0, 12)
Instance.new("UIStroke", StatCard2).Color = Color3.fromRGB(40, 40, 55)
local S2Title = Instance.new("TextLabel", StatCard2)
S2Title.Size = UDim2.new(1, 0, 0, 20)
S2Title.Position = UDim2.new(0, 0, 0, 20)
S2Title.BackgroundTransparency = 1
S2Title.Text = "PRÉCISION NEXUS"
S2Title.Font = Enum.Font.GothamMedium
S2Title.TextSize = 10
S2Title.TextColor3 = Theme.TextMuted
local AccDisplay = Instance.new("TextLabel", StatCard2)
AccDisplay.Size = UDim2.new(1, 0, 0, 40)
AccDisplay.Position = UDim2.new(0, 0, 0, 45)
AccDisplay.BackgroundTransparency = 1
AccDisplay.Text = "99.9%"
AccDisplay.Font = Enum.Font.GothamBlack
AccDisplay.TextSize = 26
AccDisplay.TextColor3 = Theme.Purple

-- ==========================================
-- 🔄 LOGIQUE, ANIMATIONS & SINGULARITÉ
-- ==========================================
local function AddHover(btn, scale)
    local orig = btn.Size
    btn.MouseEnter:Connect(function() TS:Create(btn, TweenInfo.new(0.2), {Size = UDim2.new(orig.X.Scale, orig.X.Offset*scale, orig.Y.Scale, orig.Y.Offset*scale)}):Play() end)
    btn.MouseLeave:Connect(function() TS:Create(btn, TweenInfo.new(0.2), {Size = orig}):Play() end)
end
AddHover(AuthBtn, 1.02)
AddHover(DiscordBtn, 1.02)

DiscordBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(DISCORD_LINK)
        DiscordBtn.Text = "Lien Copié !"
        DiscordBtn.BackgroundColor3 = Theme.Success
        task.wait(2)
        DiscordBtn.Text = "Discord"
        DiscordBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    end
end)

AuthBtn.MouseButton1Click:Connect(function()
    AuthBtn.Text = "Analyse neurale..."
    StatusTxt.Text = "Vérification de la clé dans le système..."
    StatusTxt.TextColor3 = Theme.TextMuted
    task.wait(0.6)
    if PassInput.Text == PASSWORD then
        StatusTxt.Text = "Accès Autorisé."
        StatusTxt.TextColor3 = Theme.Success
        AuthBtn.BackgroundColor3 = Theme.Success
        AuthBtn.Text = "Connecté"
        
        task.wait(0.5)
        local slideOut = TS:Create(LoginScreen, TweenInfo.new(0.6, Enum.EasingStyle.Cubic, Enum.EasingDirection.In), {Position = UDim2.new(-1, 0, 0, 0)})
        slideOut:Play()
        slideOut.Completed:Wait()
        LoginScreen.Visible = false
        
        DashScreen.Visible = true -- Le trait ne peut plus apparaître avant !
        TS:Create(DashScreen, TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = UDim2.new(0, 0, 0, 0)}):Play()
        IsAuthenticated = true
    else
        StatusTxt.Text = "Erreur : Licence invalide."
        StatusTxt.TextColor3 = Theme.Danger
        AuthBtn.Text = "Réessayer"
        local origX = InputBg.Position.X.Offset
        for i = 1, 4 do
            InputBg.Position = UDim2.new(0, origX + (i%2==0 and 6 or -6), 0, 140)
            task.wait(0.05)
        end
        InputBg.Position = UDim2.new(0, origX, 0, 140)
    end
end)

ToggleBtn.MouseButton1Click:Connect(function()
    if not IsAuthenticated then return end
    AutoHit = not AutoHit
    local endPos = AutoHit and UDim2.new(1, -22, 0.5, -9) or UDim2.new(0, 4, 0.5, -9)
    local endBg = AutoHit and Theme.Cyan or Theme.SpaceBlack
    local endKnob = AutoHit and Theme.SpaceBlack or Theme.TextWhite
    TS:Create(ToggleKnob, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Position = endPos, BackgroundColor3 = endKnob}):Play()
    TS:Create(ToggleBg, TweenInfo.new(0.3), {BackgroundColor3 = endBg}):Play()
    TS:Create(ToggleStroke, TweenInfo.new(0.3), {Color = AutoHit and Theme.Cyan or Color3.fromRGB(60, 60, 75)}):Play()
    if AutoHit then TS:Create(EngineCard.UIStroke, TweenInfo.new(0.3), {Color = Theme.Cyan}):Play()
    else TS:Create(EngineCard.UIStroke, TweenInfo.new(0.3), {Color = Color3.fromRGB(40, 40, 55)}):Play() end
end)

local dragging, dragInput, dragStart, startPos
AppWrapper.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true dragStart = input.Position startPos = AppWrapper.Position end
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

-- 💥 MOTEUR DE SINGULARITÉ (ANIMATION CTRL)
local function PlaySingularity(showing)
    if IsAnimating then return end
    IsAnimating = true
    local animSpeed = 0.8
    local cosmosInfo = TweenInfo.new(1.2, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)

    if showing then
        MenuVisible = true
        AppWrapper.Visible = true
        
        -- Flash d'apparition
        local flash = Instance.new("Frame", SG)
        flash.Size = UDim2.new(1, 0, 1, 0)
        flash.BackgroundColor3 = Theme.Cyan
        flash.BackgroundTransparency = 0.8
        flash.ZIndex = 100
        TS:Create(flash, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundTransparency = 1}):Play()
        game.Debris:AddItem(flash, 0.5)

        -- Expansion de la fenêtre
        AppWrapper.Size = UDim2.new(0, 0, 0, 0)
        TS:Create(AppWrapper, TweenInfo.new(0.9, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = UDim2.new(0, 750, 0, 450)}):Play()

        -- Rallumage progressif de l'univers
        for _, item in ipairs(CosmosElements) do
            local props = {}
            props[item.prop] = item.base
            if item.isStar then props.Size = UDim2.new(0, item.baseSize, 0, item.baseSize) end
            TS:Create(item.inst, cosmosInfo, props):Play()
        end
        task.wait(1)
        IsAnimating = false
    else
        -- Aspiration / Contraction
        local collapse = TS:Create(AppWrapper, TweenInfo.new(animSpeed, Enum.EasingStyle.Exponential, Enum.EasingDirection.In), {Size = UDim2.new(0, 0, 0, 0)})
        collapse:Play()
        
        -- Dissipation TOTALE de l'espace (Stream-Proof)
        for _, item in ipairs(CosmosElements) do
            local props = {}
            props[item.prop] = 1 -- Totalement invisible
            if item.isStar then props.Size = UDim2.new(0, 0, 0, 0) end
            TS:Create(item.inst, cosmosInfo, props):Play()
        end

        collapse.Completed:Wait()
        AppWrapper.Visible = false
        MenuVisible = false
        IsAnimating = false
    end
end

UIS.InputBegan:Connect(function(i, g)
    if g then return end
    if i.KeyCode == Enum.KeyCode.X and IsAuthenticated then
        ToggleBtn.MouseButton1Click:Fire()
    elseif (i.KeyCode == Enum.KeyCode.LeftControl or i.KeyCode == Enum.KeyCode.RightControl) then
        PlaySingularity(not MenuVisible)
    elseif i.KeyCode == Enum.KeyCode.Delete then 
        SG:Destroy()
    end
end)

-- ==========================================
-- 🎯 MOTEUR IA
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
