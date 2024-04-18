-- Auto format buffer before save if Lsp server support formatting

local M = {}

function M.setup()
    local format_enabled = true
    vim.api.nvim_create_user_command("ToggleAutoFormat", function()
        format_enabled = not format_enabled
        if format_enabled then
            print("Autoformatting enabled.")
        else
            print("Autoformatting disabled.")
        end
    end, {})

    local _augroups = {}
    local get_augroup = function(client)
        if not _augroups[client.id] then
            local group_name = "lsp-format-group-" .. client.name
            local id = vim.api.nvim_create_augroup(group_name, { clear = true })
            _augroups[client.id] = id
        end

        return _augroups[client.id]
    end

    vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach-format", { clear = true }),
        callback = function(args)
            local client_id = args.data.client_id
            local client = vim.lsp.get_client_by_id(client_id)
            local bufnr = args.buf

            if not client.server_capabilities.documentFormattingProvider then
                return
            end

            if client.name == 'tsserver' then
                return
            end

            vim.api.nvim_create_autocmd('BufWritePre', {
                group = get_augroup(client),
                buffer = bufnr,
                callback = function()
                    if not format_enabled then
                        return
                    end

                    vim.lsp.buf.format {
                        async = false,
                        filter = function(c)
                            return c.id == client.id
                        end,
                    }
                end,
            })
        end,
    })
end

return M
