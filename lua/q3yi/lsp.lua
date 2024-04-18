-- Configurate language server

local M = {
    'neovim/nvim-lspconfig',
    event = { "VeryLazy" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        {
            "j-hui/fidget.nvim",
            opts = {
                notification = {
                    window = { winblend = 0, border = "single" },
                }
            }
        },
        'folke/neodev.nvim',

        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
}

local function on_attach(_, buf)
    local function kmap(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
    end

    kmap("<leader>lr", vim.lsp.buf.rename, "Rename")
    kmap("<leader>la", vim.lsp.buf.code_action, "Code action")

    kmap("gd", "<cmd>Telescope lsp_definitions theme=dropdown<cr>", "Goto definition")
    kmap("gr", "<cmd>Telescope lsp_references theme=dropdown<cr>", "Goto references")
    kmap("gI", "<cmd>Telescope lsp_implementations theme=dropdown<cr>", "Goto implementation")

    kmap("<leader>lD", "<cmd>Telescope lsp_type_definitions theme=dropdown", "Type definition")
    kmap("<leader>ls", "<cmd>Telescope lsp_document_symbols theme=dropdown", "Buffer symbols")
    kmap("<leader>lS", "<cmd>Telescope lsp_dynamic_workspace_symbols", "Workspace symbols")
    kmap("<leader>lf", function() vim.lsp.buf.format { async = true } end, "Format current buffer")

    -- See `:help K` for why this keymap
    kmap("K", vim.lsp.buf.hover, "Hover documentation")
    kmap("<m-k>", vim.lsp.buf.signature_help, "Signature documentation")

    -- Lesser used LSP functionality
    kmap("gD", vim.lsp.buf.declaration, "Goto declaration")
    kmap("<leader>wfa", vim.lsp.buf.add_workspace_folder, "Add folder to workspace")
    kmap("<leader>wfr", vim.lsp.buf.remove_workspace_folder, "Remove folder from workspace")
    kmap("<leader>wfl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")

    kmap("<leader>li", "<cmd>LspInfo<cr>", "Show attached lsp server info")
    kmap("<leader>lu", "<cmd>LspRestart<cr>", "Restart lsp server")
end

function M.config()
    require("neodev").setup({})

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local function setup_lsp(server_name, settings)
        require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = settings,
        }
    end

    require("mason").setup({})
    local mason_lsp = require("mason-lspconfig")
    mason_lsp.setup({})

    -- Setup lspconfig automatically when install lsp server in mason
    mason_lsp.setup_handlers {
        -- default setting for server doesn't have a dedicated handler
        function(server_name)
            setup_lsp(server_name, {})
        end,

        -- override lsp server settings with a dedicated handler
        ["lua_ls"] = function()
            local opt = {
                Lua = {
                    workspace = { checkThirdParty = false },
                    telemetry = { enable = false },
                },
            }
            setup_lsp("lua_ls", opt)
        end,
        ["html"] = function()
            local opt = { filetypes = { "html", "twig", "hbs" } }
            setup_lsp("html", opt)
        end
    }
end

return M
