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
        -- cmd = { vim.fn.expand("~/.rbenv/shims/rubocop"), "_1.80.2_", "--lsp" },
        cmd = { vim.fn.expand("~/.rbenv/shims/rubocop"), "--lsp" },
        single_file_support = true,
        filetypes = { 'ruby' },
        root_markers = { 'Gemfile', '.git' },
        -- flags = {
        --     allow_incremental_sync = false,
        -- },
    },
    ruby_lsp = {
        -- autostart = false,
        root_dir = function() return vim.fn.getcwd() end,
        -- cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") }, -- fallback
        -- NOTE: on_new_config is an nvim-lspconfig specific option, it is not
        -- a valid field in the vim.lsp.ClientConfig table as of time of writing
        on_new_config = function(new_config, root_dir)
            local gemfile_lock = root_dir .. "/Gemfile.lock"

            if vim.fn.filereadable(gemfile_lock) == 1 then
                print("Gemfile.lock found; Executing: bundle exec ruby-lsp")
                new_config.cmd = { "bundle", "exec", "ruby-lsp" }
            else
                print("Executing: global ruby-lsp")
                new_config.cmd = { vim.fn.expand("~/.rbenv/shims/ruby-lsp") }
            end
        end,
        filetypes = { 'ruby' },
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
