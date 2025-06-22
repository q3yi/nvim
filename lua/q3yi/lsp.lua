-- Configurate language server

local M = {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
}

local function on_attach(client, buf)
    local builtin = require("telescope.builtin")
    local bindings = {
        { "gd", builtin.lsp_definitions, "Goto definition" },
        { "gr", builtin.lsp_references, "Goto references" },
        { "gI", builtin.lsp_implementations, "Goto implementation" },
        { "gD", vim.lsp.buf.declaration, "Goto declaration" },

        { "<leader>lr", vim.lsp.buf.rename, "Rename" },
        { "<leader>la", vim.lsp.buf.code_action, "Code action" },
        { "<leader>lD", builtin.lsp_type_definitions, "Type definition" },
        { "<leader>ls", builtin.lsp_document_symbols, "Buffer symbols" },
        { "<leader>lS", builtin.lsp_dynamic_workspace_symbols, "Workspace symbols" },

        -- See `:help K` for why this keymap
        { "K", vim.lsp.buf.hover, "Hover documentation" },
        { "<leader>lk", vim.lsp.buf.signature_help, "Signature documentation" },

        -- Lesser used LSP functionality
        { "<leader>wfa", vim.lsp.buf.add_workspace_folder, "Add folder to workspace" },
        { "<leader>wfr", vim.lsp.buf.remove_workspace_folder, "Remove folder from workspace" },
        {
            "<leader>wfl",
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "List workspace folders",
        },

        { "<leader>li", "<cmd>LspInfo<cr>", "Show attached lsp server info" },
        { "<leader>lu", "<cmd>LspRestart<cr>", "Restart lsp server" },
        {
            "<leader>lh",
            function()
                local supported = client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint

                if not supported then
                    vim.notify("server not support inlayHint.", vim.log.levels.ERROR)
                    return
                end

                local enabled = not vim.lsp.inlay_hint.is_enabled({})
                vim.lsp.inlay_hint.enable(enabled)

                if enabled then
                    vim.notify("inlay hint enabled.", vim.log.levels.INFO)
                else
                    vim.notify("inlay hint disabled.", vim.log.levels.INFO)
                end
            end,
            "Toggle inlay hints",
        },
    }

    for _, binding in ipairs(bindings) do
        local key, cmd, desc = binding[1], binding[2], binding[3]
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", key, cmd, { buffer = buf, desc = desc })
    end
end

function M.config()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    vim.lsp.config("*", {
        capabilities = capabilities,
        on_attach = on_attach,
    })

    require("mason").setup()
    require("mason-lspconfig").setup({
        automatic_enable = true,
        ensure_installed = {},
    })

    -- Some lsp server should install with its own environment instead of install through Mason,
    -- so we just enable it manually.
    vim.lsp.enable({ "pylsp", "ocamllsp" })
end

return M
