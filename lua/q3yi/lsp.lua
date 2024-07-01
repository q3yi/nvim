-- Configurate language server

local M = {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        {
            "j-hui/fidget.nvim",
            opts = { notification = { window = { winblend = 0 } } },
        },
        "folke/neodev.nvim",

        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
}

local lsp_servers = {
    ocamllsp = {
        manual_install = true,
        settings = {
            -- codelens = { enable = true },
            inlayHints = { enable = true },
        },
    },
    lua_ls = {
        server_capabilities = {
            semanticTokensProvider = vim.NIL,
        },
        settings = {
            Lua = {
                workspace = { checkThirdParty = false },
                telemetry = { enable = false },
            },
        },
    },
    html = { filetypes = { "html", "twig", "hbs" } },
    gopls = {
        settings = {
            gopls = {
                hints = {
                    assignVariableTypes = true,
                    compositeLiteralFields = true,
                    compositeLiteralTypes = true,
                    constantValues = true,
                    functionTypeParameters = true,
                    parameterNames = true,
                    rangeVariableTypes = true,
                },
            },
        },
    },
    rust_analyzer = {
        manual_install = true,
    },
    solidity_ls_nomicfoundation = {
        server_capabilities = {
            documentFormattingProvider = false,
        },
    },
    tsserver = {
        server_capabilities = {
            documentFormattingProvider = false,
        },
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
                if client and client.server_capabilities.inlayHintProvider and vim.lsp.inlay_hint then
                    vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({}))
                    if vim.lsp.inlay_hint.is_enabled({}) then
                        vim.notify("inlay hint enabled.", vim.log.levels.INFO)
                    else
                        vim.notify("inlay hint disabled.", vim.log.levels.INFO)
                    end
                else
                    vim.notify("server not support inlayHint.", vim.log.levels.ERROR)
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

    -- Override server capabilities
    local setting = lsp_servers[client.name] or {}
    for k, v in ipairs(setting.server_capabilities or {}) do
        if v == vim.NIL then
            client.server_capabilities[k] = nil
        else
            client.server_capabilities[k] = v
        end
    end
end

function M.config()
    require("neodev").setup({})

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    for srv, cfg in pairs(lsp_servers) do
        if cfg.manual_install then
            require("lspconfig")[srv].setup({
                capabilities = vim.tbl_extend("force", {}, capabilities, cfg.capabilities or {}),
                on_attach = on_attach,
                settings = cfg.settings or {},
                filetypes = cfg.filetypes,
            })
        end
    end

    require("mason").setup({})
    local mason_lsp = require("mason-lspconfig")
    mason_lsp.setup({})

    -- Setup lspconfig automatically when install lsp server in mason
    mason_lsp.setup_handlers({
        -- default setting for server doesn't have a dedicated handler
        function(server_name)
            local cfg = lsp_servers[server_name] or {}
            require("lspconfig")[server_name].setup({
                capabilities = vim.tbl_extend("force", {}, capabilities, cfg.capabilities or {}),
                on_attach = on_attach,
                settings = cfg.settings or {},
                filetypes = cfg.filetypes,
            })
        end,
    })
end

return M
