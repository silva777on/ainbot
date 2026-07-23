-- INTERCEPTADOR PARA DELTA - Execute isso PRIMEIRO
print("🔍 INICIANDO INTERCEPTADOR DELTA...")

-- Salva a função original
local oldHttpGet = game.HttpGet
local capturedContent = nil

-- Substitui a função
game.HttpGet = function(self, url, ...)
    print("📡 URL capturada:", url)
    
    if url and url:find("saiops.cc") then
        print("🎯 LOADER ENCONTRADO!")
        
        local success, content = pcall(function()
            return oldHttpGet(self, url, ...)
        end)
        
        if success and content then
            capturedContent = content
            print("✅ CONTEÚDO CAPTURADO! (" .. string.len(content) .. " caracteres)")
            
            -- Mostra as primeiras 10 linhas
            local lines = {}
            for line in content:gmatch("[^\n]+") do
                table.insert(lines, line)
                if #lines >= 10 then break end
            end
            print("📄 Primeiras 10 linhas:")
            for i, line in pairs(lines) do
                print(i .. ": " .. line)
            end
            
            -- Tenta copiar
            pcall(function()
                if setclipboard then
                    setclipboard(content)
                    print("📋 COPIADO PARA O CLIPBOARD!")
                end
            end)
            
            return content
        end
    end
    
    return oldHttpGet(self, url, ...)
end

print("✅ INTERCEPTADOR ATIVO! Agora execute o loader.")
