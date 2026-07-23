-- SCRIPT PARA CAPTURAR PET SEM LASSO (BASEADO NA PISTA)
print("🔍 TESTANDO CAPTURA DIRETA...")

local function CapturePetDirect(pet)
    if not pet then return false end
    
    -- Procura a pasta "Pets" onde os pets capturados vão
    local petsFolder = workspace:FindFirstChild("Pets") 
        or workspace:FindFirstChild("PlayerPets")
        or workspace:FindFirstChild("CapturedPets")
        or Player:FindFirstChild("Pets")
    
    if not petsFolder then
        print("❌ Pasta 'Pets' não encontrada! Criando uma...")
        petsFolder = Instance.new("Folder")
        petsFolder.Name = "Pets"
        petsFolder.Parent = workspace
    end
    
    print("📁 Pasta Pets encontrada:", petsFolder.Name)
    print("🎯 Tentando capturar:", pet.Name)
    
    -- Tenta mover o pet para a pasta Pets
    local success = pcall(function()
        pet.Parent = petsFolder
        
        -- Se tiver Humanoid, desativa ele
        local humanoid = pet:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.Health = 0
            task.wait(0.1)
            humanoid:Destroy()
        end
    end)
    
    if success then
        print("✅ " .. pet.Name .. " capturado com sucesso!")
        return true
    else
        print("❌ Falha ao capturar " .. pet.Name)
        return false
    end
end

-- ==== FUNÇÃO PARA ENCONTRAR PETS ====
local function FindNearbyPets()
    local pets = {}
    local character = game:GetService("Players").LocalPlayer.Character
    if not character then return pets end
    
    local root = character:FindFirstChild("HumanoidRootPart")
    if not root then return pets end
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("HumanoidRootPart") then
            if obj == character then continue end
            
            local name = obj.Name:lower()
            if name:find("base") or name:find("floor") or name:find("wall") then continue end
            if name:find("npc") or name:find("humano") then continue end
            
            local hrp = obj:FindFirstChild("HumanoidRootPart")
            if hrp then
                local dist = (root.Position - hrp.Position).Magnitude
                if dist < 50 then -- Só pets próximos
                    table.insert(pets, obj)
                end
            end
        end
    end
    return pets
end

-- ==== TESTE: CAPTURA O PET MAIS PRÓXIMO ====
local pets = FindNearbyPets()
if #pets > 0 then
    print("🔍 Encontrados " .. #pets .. " pets próximos")
    
    -- Pega o mais próximo
    local target = pets[1]
    CapturePetDirect(target)
else
    print("❌ Nenhum pet encontrado por perto")
end
