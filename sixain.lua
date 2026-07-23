-- Método alternativo: Baixar direto
print("📥 Baixando loader diretamente...")
local content = game:HttpGet("https://saiops.cc/loader.lua")
print("📦 Conteúdo:")
print(content)

-- Tenta salvar
pcall(function()
    if writefile then
        writefile("loader.lua", content)
        print("✅ Salvo como 'loader.lua'")
    end
    if setclipboard then
        setclipboard(content)
        print("📋 Copiado para o clipboard!")
    end
end)
