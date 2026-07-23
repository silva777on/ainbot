-- Rode isso ANTES do loader
print("🔍 ANALISANDO REMOTES...")

local replicatedStorage = game:GetService("ReplicatedStorage")
local remoteEvents = {}

-- Lista todos os RemoteEvents
for _, obj in pairs(replicatedStorage:GetDescendants()) do
    if obj:IsA("RemoteEvent") then
        table.insert(remoteEvents, obj.Name)
        print("📡 RemoteEvent encontrado:", obj.Name)
    end
end

print("=" .. string.rep("=", 50))
print("🔍 Total de RemoteEvents:", #remoteEvents)

-- Roda o loader
print("🚀 Executando loader...")
getgenv().KEY_SYSTEM_CONFIG = { ScriptId = 2, Standalone = true }
loadstring(game:HttpGet("https://saiops.cc/loader.lua"))()

-- Depois de 5 segundos, verifica o que mudou
task.wait(5)
print("🔍 Verificando mudanças...")

-- Procura por novos objetos ou funções
for _, obj in pairs(replicatedStorage:GetDescendants()) do
    if obj:IsA("RemoteEvent") and not table.find(remoteEvents, obj.Name) then
        print("🆕 NOVO RemoteEvent detectado:", obj.Name)
    end
end

-- Procura por funções globais que podem ter sido criadas
print("🔍 Funções globais:")
for key, value in pairs(getgenv()) do
    if type(value) == "function" then
        print("  -", key, "é uma função")
    end
end
