local _handlers = {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded" }),
}

local servers = {
    clangd = {},
    lua_ls = {},
    ruby_lsp = {
        mason = false,
        cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
        init_options = {
            diagnostics = true,
        },
        -- on_attach = function(client, buffer) end
    },
    jdtls = {
        single_file_support = true,

    },
    phpactor = {
        root_dir = require('lspconfig').util.root_pattern('composer.json', '.git', 'index.php'),
    },
}

for _, config in pairs(servers) do
    config.handlers = _handlers
end

return servers
