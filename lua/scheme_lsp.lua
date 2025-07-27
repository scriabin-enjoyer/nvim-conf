vim.api.nvim_create_autocmd("FileType", {
    pattern = "scheme",
    callback = function()
        local client, err = vim.lsp.start_client {
            name = "MySchemeLsp",
            cmd = { "/home/scriabin/Repos/Personal/SimpleSchemeLsp/exe/server.sh" }
        }

        if not client then
            vim.notify "vim.lsp.start_client returned nil for client_id"
            print(err)
            return
        end

        vim.lsp.set_log_level("DEBUG")
        vim.lsp.buf_attach_client(0, client)
    end,
})


-- vim.api.nvim_create_autocmd('LspRequest', {
--   callback = function(args)
--     -- local bufnr = args.buf
--     -- local client_id = args.data.client_id
--     -- local request_id = args.data.request_id
--     local request = args.data.request
--     if request.type == 'pending' then
--       -- do something with pending requests
--       track_pending(client_id, bufnr, request_id, request)
--     elseif request.type == 'cancel' then
--       -- do something with pending cancel requests
--       track_canceling(client_id, bufnr, request_id, request)
--     elseif request.type == 'complete' then
--       -- do something with finished requests. this pending
--       -- request entry is about to be removed since it is complete
--       track_finish(client_id, bufnr, request_id, request)
--     end
--   end,
-- })
