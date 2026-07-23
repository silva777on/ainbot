-- SCRIPT PARA ANALISAR O JOGO DIRETAMENTE
print("🔍 ANALISANDO O JOGO...")

-- 1. Procura por funções de captura no jogo
local function findCaptureFunctions()
    print("📡 Procurando funções de captura...")
    
    -- Procura em ReplicatedStorage
    local replicatedStorage = game:GetService("ReplicatedStorage")
    
    for _, obj in pairs(replicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            local name = obj.Name:lower()
            if name:find("captur") or name:find("catch") or name:find("pet") or name:find("lasso") or name:find("tame") then
                print("🔍 RemoteEvent encontrado:", obj.Name)
            end
        elseif obj:IsA("RemoteFunction") then
            local name = obj.Name:lower()
            if name:find("captur") or name:find("catch") or name:find("pet") or name:find("lasso") or name:find("tame") then
                print("🔍 RemoteFunction encontrado:", obj.Name)
            end
        end
    end
    
    -- Procura em Workspace
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
            local name = obj.Name:lower()
            if name:find("pet") or name:find("animal") then
                -- Verifica se tem alguma função de clique
                if obj:FindFirstChild("ClickDetector") then
                    print("🔍 Pet com ClickDetector:", obj.Name)
                end
            end
        end
    end
end

-- 2. Tenta capturar manualmente e ver o que acontece
local function testCapture()
    print("🎯 Testando captura manual...")
    print("👉 Clique em um pet agora!")
    
    -- Monitora cliques
    local mouse = game:GetService("Players").LocalPlayer:GetMouse()
    mouse.Button1Down:Connect(function()
        print("🖱️ Clique detectado!")
        
        -- Verifica o que foi clicado
        local target = mouse.Target
        if target then
            print("   Alvo:", target.Name)
            print("   Parent:", target.Parent and target.Parent.Name)
            
            -- Procura por RemoteEvents próximos
            local remote = target.Parent and target.Parent:FindFirstChild("RemoteEvent")
            if remote then
                print("   RemoteEvent encontrado:", remote.Name)
            end
        end
    end)
end

-- Executa as análises
print("=" .. string.rep("=", 50))
findCaptureFunctions()
print("=" .. string.rep("=", 50))
testCapture()
print("✅ Análise iniciada! Clique em um pet para ver o que acontece.")
