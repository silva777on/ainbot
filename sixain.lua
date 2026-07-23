-- MÉTODO DIRETO PARA DELTA
print("📥 Baixando loader diretamente...")

-- Tenta baixar o loader
local success, content = pcall(function()
    return game:HttpGet("https://saiops.cc/loader.lua")
end)

if success and content then
    print("✅ CONTEÚDO BAIXADO! (" .. string.len(content) .. " caracteres)")
    print("=" .. string.rep("=", 60))
    print("📦 CONTEÚDO DO LOADER:")
    print(content)
    print("=" .. string.rep("=", 60))
    
    -- Tenta salvar no clipboard
    pcall(function()
        if setclipboard then
            setclipboard(content)
            print("📋 CONTEÚDO COPIADO PARA O CLIPBOARD!")
            print("👉 Cole em um bloco de notas para analisar")
        end
    end)
    
    -- Tenta salvar como arquivo
    pcall(function()
        if writefile then
            writefile("loader_capturado.lua", content)
            print("💾 ARQUIVO SALVO: loader_capturado.lua")
        end
    end)
    
    -- Mostra as primeiras 20 linhas
    local lines = {}
    for line in content:gmatch("[^\n]+") do
        table.insert(lines, line)
        if #lines >= 20 then break end
    end
    print("📄 Primeiras 20 linhas:")
    for i, line in pairs(lines) do
        print(i .. ": " .. line)
    end
else
    print("❌ Falha ao baixar o loader.")
    print("Erro: " .. tostring(content))
end
