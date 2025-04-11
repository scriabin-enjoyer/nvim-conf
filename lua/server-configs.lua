return {
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
    jdtls = {},
}
