-- SixAin - Arsenal Edition
print("CARREGANDO SIXAIN PARA ARSENAL...")

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

-- CONFIGURAÇÕES
local Config = {
    Aimbot = true,
    ESP = true,
    FOV = 150,
    FOVMin = 50,
    FOVMax = 350,
    Sensibilidade = 0.2,
    AimPart = "Head",
}

-- CRIAR GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SixAinGUI"
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 280)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -140)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 25)
MainFrame.BackgroundTransparency = 0.05
MainFrame.BorderSizePixel = 0
MainFrame.Parent = ScreenGui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 16)
Corner.Parent = MainFrame

-- Barra de Título (DRAG)
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 18, 30)
TitleBar.BorderSizePixel = 0
TitleBar.Parent = MainFrame

local TitleCorner = Instance.new("UICorner")
TitleCorner.CornerRadius = UDim.new(0, 16)
TitleCorner.Parent = TitleBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0.6, 0, 1, 0)
Title.Position = UDim2.new(0.05, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "SixAin ⚡ Arsenal"
Title.TextColor3 = Color3.fromRGB(160, 80, 255)
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Font = Enum.Font.GothamBold
Title.Parent = TitleBar

-- Botões
local function CriarBotao(texto, posX, cor, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 32, 0, 28)
    btn.Position = UDim2.new(posX, 0, 0.5, -14)
    btn.BackgroundColor3 = cor or Color3.fromRGB(40, 35, 55)
    btn.BackgroundTransparency = 0.3
    btn.Text = texto
    btn.TextColor3 = Color3.fromRGB(220, 210, 255)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamBold
    btn.BorderSizePixel = 0
    btn.Parent = TitleBar
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn
    
    btn.MouseButton1Click:Connect(callback)
    return btn
end

local function Fechar()
    ScreenGui:Destroy()
end

local function Minimizar()
    MainFrame.Visible = not MainFrame.Visible
end

CriarBotao("─", 0.85, nil, Minimizar)
CriarBotao("✕", 0.94, Color3.fromRGB(177, 58, 75), Fechar)

-- DRAG (mover a janela)
local dragging = false
local dragStartPos, startMousePos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStartPos = MainFrame.Position
        startMousePos = input.Position
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - startMousePos
        MainFrame.Position = UDim2.new(
            dragStartPos.X.Scale,
            dragStartPos.X.Offset + delta.X,
            dragStartPos.Y.Scale,
            dragStartPos.Y.Offset + delta.Y
        )
    end
end)

-- CONTEÚDO
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -50)
Content.Position = UDim2.new(0, 10, 0, 48)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Toggles
local function CriarToggle(texto, posY, configVar)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 35)
    frame.Position = UDim2.new(0, 0, 0, posY)
    frame.BackgroundTransparency = 1
    frame.Parent = Content
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.5, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = texto
    label.TextColor3 = Color3.fromRGB(200, 185, 230)
    label.TextSize = 14
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Font = Enum.Font.GothamMedium
    label.Parent = frame
    
    local toggle = Instance.new("Frame")
    toggle.Size = UDim2.new(0, 44, 0, 22)
    toggle.Position = UDim2.new(1, -50, 0.5, -11)
    toggle.BackgroundColor3 = Color3.fromRGB(40, 35, 55)
    toggle.BorderSizePixel = 0
    toggle.Parent = frame
    
    local toggleCorner = Instance.new("UICorner")
    toggleCorner.CornerRadius = UDim.new(0, 11)
    toggleCorner.Parent = toggle
    
    local indicator = Instance.new("Frame")
    indicator.Size = UDim2.new(0, 18, 0, 18)
    indicator.Position = UDim2.new(0, 2, 0.5, -9)
    indicator.BackgroundColor3 = Color3.fromRGB(100, 80, 150)
    indicator.BorderSizePixel = 0
    indicator.Parent = toggle
    
    local indicatorCorner = Instance.new("UICorner")
    indicatorCorner.CornerRadius = UDim.new(0, 9)
    indicatorCorner.Parent = indicator
    
    local function updateToggle(value)
        if value then
            toggle.BackgroundColor3 = Color3.fromRGB(80, 40, 150)
            indicator.BackgroundColor3 = Color3.fromRGB(200, 150, 255)
            indicator.Position = UDim2.new(1, -20, 0.5, -9)
        else
            toggle.BackgroundColor3 = Color3.fromRGB(40, 35, 55)
            indicator.BackgroundColor3 = Color3.fromRGB(100, 80, 150)
            indicator.Position = UDim2.new(0, 2, 0.5, -9)
        end
    end
    
    updateToggle(configVar)
    
    toggle.MouseButton1Click:Connect(function()
        configVar = not configVar
        updateToggle(configVar)
        if texto == "Aimbot" then Config.Aimbot = configVar end
        if texto == "ESP" then Config.ESP = configVar end
    end)
    
    return toggle
end

CriarToggle("🎯 Aimbot", 0, Config.Aimbot)
CriarToggle("👁️ ESP", 40, Config.ESP)

-- FOV Slider
local FOVFrame = Instance.new("Frame")
FOVFrame.Size = UDim2.new(1, 0, 0, 50)
FOVFrame.Position = UDim2.new(0, 0, 0, 80)
FOVFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 20)
FOVFrame.BorderSizePixel = 1
FOVFrame.BorderColor3 = Color3.fromRGB(35, 30, 50)
FOVFrame.Parent = Content

local FOVCorner = Instance.new("UICorner")
FOVCorner.CornerRadius = UDim.new(0, 10)
FOVCorner.Parent = FOVFrame

local FOVLabel = Instance.new("TextLabel")
FOVLabel.Size = UDim2.new(0.2, 0, 1, 0)
FOVLabel.Position = UDim2.new(0.05, 0, 0, 0)
FOVLabel.BackgroundTransparency = 1
FOVLabel.Text = "FOV:"
FOVLabel.TextColor3 = Color3.fromRGB(180, 165, 210)
FOVLabel.TextSize = 13
FOVLabel.TextXAlignment = Enum.TextXAlignment.Left
FOVLabel.Font = Enum.Font.GothamMedium
FOVLabel.Parent = FOVFrame

local FOVValue = Instance.new("TextLabel")
FOVValue.Size = UDim2.new(0.1, 0, 1, 0)
FOVValue.Position = UDim2.new(0.85, 0, 0, 0)
FOVValue.BackgroundTransparency = 1
FOVValue.Text = tostring(Config.FOV)
FOVValue.TextColor3 = Color3.fromRGB(200, 180, 255)
FOVValue.TextSize = 14
FOVValue.Font = Enum.Font.GothamBold
FOVValue.Parent = FOVFrame

local Slider = Instance.new("Frame")
Slider.Size = UDim2.new(0.5, 0, 0.35, 0)
Slider.Position = UDim2.new(0.25, 0, 0.5, -0.15)
Slider.BackgroundColor3 = Color3.fromRGB(40, 35, 55)
Slider.BorderSizePixel = 0
Slider.Parent = FOVFrame

local SliderCorner = Instance.new("UICorner")
SliderCorner.CornerRadius = UDim.new(0, 6)
SliderCorner.Parent = Slider

local Fill = Instance.new("Frame")
Fill.Size = UDim2.new((Config.FOV - Config.FOVMin) / (Config.FOVMax - Config.FOVMin), 0, 1, 0)
Fill.BackgroundColor3 = Color3.fromRGB(160, 80, 255)
Fill.BorderSizePixel = 0
Fill.Parent = Slider

local FillCorner = Instance.new("UICorner")
FillCorner.CornerRadius = UDim.new(0, 6)
FillCorner.Parent = Fill

local Handle = Instance.new("TextButton")
Handle.Size = UDim2.new(0, 16, 0, 16)
Handle.Position = UDim2.new(Fill.Size.X.Scale, -8, 0.5, -8)
Handle.BackgroundColor3 = Color3.fromRGB(200, 150, 255)
Handle.Text = ""
Handle.BorderSizePixel = 0
Handle.Parent = Slider

local HandleCorner = Instance.new("UICorner")
HandleCorner.CornerRadius = UDim.new(0, 8)
HandleCorner.Parent = Handle

local sliderDragging = false
local function updateSlider(inputPos)
    local relX = math.clamp((inputPos.X - Slider.AbsolutePosition.X) / Slider.AbsoluteSize.X, 0, 1)
    local newFOV = Config.FOVMin + (Config.FOVMax - Config.FOVMin) * relX
    newFOV = math.round(newFOV / 5) * 5
    Config.FOV = math.clamp(newFOV, Config.FOVMin, Config.FOVMax)
    
    Fill.Size = UDim2.new((Config.FOV - Config.FOVMin) / (Config.FOVMax - Config.FOVMin), 0, 1, 0)
    Handle.Position = UDim2.new(Fill.Size.X.Scale, -8, 0.5, -8)
    FOVValue.Text = tostring(Config.FOV)
end

Handle.MouseButton1Down:Connect(function()
    sliderDragging = true
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        sliderDragging = false
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if sliderDragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateSlider(input.Position)
    end
end)

-- Status ESP
local ESPStatus = Instance.new("Frame")
ESPStatus.Size = UDim2.new(0.7, 0, 0, 28)
ESPStatus.Position = UDim2.new(0.15, 0, 0, 138)
ESPStatus.BackgroundColor3 = Color3.fromRGB(10, 10, 18)
ESPStatus.BorderSizePixel = 1
ESPStatus.BorderColor3 = Color3.fromRGB(40, 35, 55)
ESPStatus.Parent = Content

local ESPCorner = Instance.new("UICorner")
ESPCorner.CornerRadius = UDim.new(0, 14)
ESPCorner.Parent = ESPStatus

local Dot = Instance.new("Frame")
Dot.Size = UDim2.new(0, 8, 0, 8)
Dot.Position = UDim2.new(0.08, 0, 0.5, -4)
Dot.BackgroundColor3 = Config.ESP and Color3.fromRGB(160, 80, 255) or Color3.fromRGB(70, 50, 100)
Dot.BorderSizePixel = 0
Dot.Parent = ESPStatus

local DotCorner = Instance.new("UICorner")
DotCorner.CornerRadius = UDim.new(0, 4)
DotCorner.Parent = Dot

local ESPLabel = Instance.new("TextLabel")
ESPLabel.Size = UDim2.new(0.8, 0, 1, 0)
ESPLabel.Position = UDim2.new(0.15, 0, 0, 0)
ESPLabel.BackgroundTransparency = 1
ESPLabel.Text = Config.ESP and "ESP Ativo" or "ESP Inativo"
ESPLabel.TextColor3 = Color3.fromRGB(180, 165, 210)
ESPLabel.TextSize = 12
ESPLabel.TextXAlignment = Enum.TextXAlignment.Left
ESPLabel.Font = Enum.Font.GothamMedium
ESPLabel.Parent = ESPStatus

-- SISTEMA AIMBOT (ESPECÍFICO ARSENAL)
local function GetClosestPlayer()
    local closest = nil
    local closestDist = Config.FOV
    
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 then
            local character = player.Character
            -- Arsenal usa "Head" ou "UpperTorso"
            local targetPart = character:FindFirstChild("Head") or character:FindFirstChild("UpperTorso") or character:FindFirstChild("HumanoidRootPart")
            
            if targetPart then
                local screenPos, onScreen = Camera:WorldToScreenPoint(targetPart.Position)
                if onScreen then
                    local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    
                    if distance < closestDist then
                        closestDist = distance
                        closest = player
                    end
                end
            end
        end
    end
    
    return closest
end

-- SISTEMA ESP (ESPECÍFICO ARSENAL)
local ESPObjects = {}

local function CriarESP(player)
    if not player.Character then return end
    
    local character = player.Character
    local humanoid = character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    -- Caixa ao redor
    local box = Instance.new("BoxHandleAdornment")
    box.Size = Vector3.new(3, 5, 2)
    box.Color3 = Color3.fromRGB(160, 80, 255)
    box.Transparency = 0.25
    box.ZIndex = 0
    box.AlwaysOnTop = true
    box.Adornee = character
    box.Parent = character
    
    -- Nome
    local nameTag = Instance.new("BillboardGui")
    nameTag.Size = UDim2.new(0, 100, 0, 25)
    nameTag.Adornee = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
    nameTag.Parent = character
    
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(1, 0, 1, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = player.Name
    nameLabel.TextColor3 = Color3.fromRGB(160, 80, 255)
    nameLabel.TextSize = 12
    nameLabel.Font = Enum.Font.GothamBold
    nameLabel.TextStrokeTransparency = 0.5
    nameLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    nameLabel.Parent = nameTag
    
    -- Barra de Vida
    local healthBar = Instance.new("BillboardGui")
    healthBar.Size = UDim2.new(0, 50, 0, 4)
    healthBar.Position = UDim2.new(0, -25, 0, 22)
    healthBar.Adornee = character:FindFirstChild("Head") or character:FindFirstChild("HumanoidRootPart")
    healthBar.Parent = character
    
    local healthBackground = Instance.new("Frame")
    healthBackground.Size = UDim2.new(1, 0, 1, 0)
    healthBackground.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    healthBackground.BorderSizePixel = 0
    healthBackground.Parent = healthBar
    
    local healthFill = Instance.new("Frame")
    healthFill.Size = UDim2.new(1, 0, 1, 0)
    healthFill.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
    healthFill.BorderSizePixel = 0
    healthFill.Parent = healthBackground
    
    ESPObjects[player] = {
        Box = box,
        NameTag = nameTag,
        HealthBar = healthBackground,
        HealthFill = healthFill,
    }
end

local function UpdateESP()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            if Config.ESP and player.Character and player.Character:FindFirstChild("Humanoid") then
                if not ESPObjects[player] then
                    CriarESP(player)
                else
                    local humanoid = player.Character:FindFirstChild("Humanoid")
                    if humanoid and ESPObjects[player].HealthFill then
                        local healthPercent = humanoid.Health / humanoid.MaxHealth
                        ESPObjects[player].HealthFill.Size = UDim2.new(healthPercent, 0, 1, 0)
                        ESPObjects[player].HealthFill.BackgroundColor3 = Color3.fromRGB(
                            255 - (255 * healthPercent),
                            255 * healthPercent,
                            0
                        )
                    end
                end
            else
                if ESPObjects[player] then
                    if ESPObjects[player].Box then ESPObjects[player].Box:Destroy() end
                    if ESPObjects[player].NameTag then ESPObjects[player].NameTag:Destroy() end
                    if ESPObjects[player].HealthBar then ESPObjects[player].HealthBar:Destroy() end
                    ESPObjects[player] = nil
                end
            end
        end
    end
end

-- LOOP PRINCIPAL
local function MainLoop()
    -- Aimbot
    if Config.Aimbot then
        local target = GetClosestPlayer()
        if target and target.Character then
            local targetPart = target.Character:FindFirstChild("Head") or target.Character:FindFirstChild("UpperTorso") or target.Character:FindFirstChild("HumanoidRootPart")
            if targetPart then
                local screenPos = Camera:WorldToScreenPoint(targetPart.Position)
                if screenPos then
                    local mousePos = Vector2.new(Mouse.X, Mouse.Y)
                    local targetPos = Vector2.new(screenPos.X, screenPos.Y)
                    local delta = (targetPos - mousePos) * Config.Sensibilidade
                    mousemoverel(delta.X, delta.Y)
                end
            end
        end
    end
    
    -- ESP
    if Config.ESP then
        UpdateESP()
    else
        for player, data in pairs(ESPObjects) do
            if data.Box then data.Box:Destroy() end
            if data.NameTag then data.NameTag:Destroy() end
            if data.HealthBar then data.HealthBar:Destroy() end
            ESPObjects[player] = nil
        end
    end
end

RunService.RenderStepped:Connect(MainLoop)

-- Limpar quando o personagem mudar
LocalPlayer.CharacterAdded:Connect(function()
    for player, data in pairs(ESPObjects) do
        if data.Box then data.Box:Destroy() end
        if data.NameTag then data.NameTag:Destroy() end
        if data.HealthBar then data.HealthBar:Destroy() end
        ESPObjects[player] = nil
    end
end)

print("✅ SixAin Arsenal carregado!")
print("🎯 Aimbot: " .. (Config.Aimbot and "ATIVO" or "DESATIVADO"))
print("👁️ ESP: " .. (Config.ESP and "ATIVO" or "DESATIVADO"))
print("📐 FOV: " .. Config.FOV)
print("Use a interface para configurar!")
