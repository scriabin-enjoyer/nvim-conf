return {
    clangd = {},
    lua_ls = {},
    ruby_lsp = {
        mason = false,
        cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
    },
}
