local _handlers = {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded" }),
}

local mason_servers = {
    clangd = {},
    lua_ls = {},
    jdtls = {
        single_file_support = true,

    },
    phpactor = {
        root_dir = require('lspconfig').util.root_pattern('composer.json', '.git', 'index.php'),
    },
}

for _, config in pairs(mason_servers) do
    config.handlers = _handlers
end

return mason_servers
