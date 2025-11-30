local _handlers = {
    ["textDocument/hover"] =  vim.lsp.with(vim.lsp.handlers.hover, {border = "rounded"}),
    ["textDocument/signatureHelp"] =  vim.lsp.with(vim.lsp.handlers.signature_help, {border = "rounded" }),
}

local custom_servers = {
    rubocop = {
        -- autostart = false,
        -- see # https://github.com/rubocop/rubocop/issues/14681
        -- rubocop >= 1.81.0 introduced some yucky performance issues with their language server
        -- so use 1.80.2 until they fix this shit AIYAA
        cmd = { vim.fn.expand("~/.rbenv/shims/rubocop"), "_1.80.2_", "--lsp" },
        single_file_support = true,
        filetypes = { 'ruby' },
        root_markers = { 'Gemfile', '.git' },
        -- flags = {
        --     allow_incremental_sync = false,
        -- },
    },
    ruby_lsp = {
        -- autostart = false,
        cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") },
        single_file_support = true,
        init_options = {
            enabledFeatures = {
                diagnostics = false,
                experimentalFeaturesEnabled = true,
            },
        },
    },
}

for _, config in pairs(custom_servers) do
    config.handlers = _handlers
end

return custom_servers
