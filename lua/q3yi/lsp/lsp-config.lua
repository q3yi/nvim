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
    local bindings = {
        { "gd",          "<cmd>Telescope lsp_definitions<cr>",               "Goto definition" },
        { "gr",          "<cmd>Telescope lsp_references<cr>",                "Goto references" },
        { "gI",          "<cmd>Telescope lsp_implementations<cr>",           "Goto implementation" },
        { "gD",          vim.lsp.buf.declaration,                            "Goto declaration" },

        { "<leader>lr",  vim.lsp.buf.rename,                                 "Rename" },
        { "<leader>la",  vim.lsp.buf.code_action,                            "Code action" },

        { "<leader>lD",  "<cmd>Telescope lsp_type_definitions<cr>",          "Type definition" },
        { "<leader>ls",  "<cmd>Telescope lsp_document_symbols<cr>",          "Buffer symbols" },
        { "<leader>lS",  "<cmd>Telescope lsp_dynamic_workspace_symbols<cr>", "Workspace symbols" },
        { "<leader>lf",  function() vim.lsp.buf.format { async = true } end, "Format current buffer" },

        -- See `:help K` for why this keymap
        { "K",           vim.lsp.buf.hover,                                  "Hover documentation" },
        { "<m-k>",       vim.lsp.buf.signature_help,                         "Signature documentation" },

        -- Lesser used LSP functionality
        { "<leader>wfa", vim.lsp.buf.add_workspace_folder,                   "Add folder to workspace" },
        { "<leader>wfr", vim.lsp.buf.remove_workspace_folder,                "Remove folder from workspace" },
        {
            "<leader>wfl",
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "List workspace folders"
        },

        { "<leader>li", "<cmd>LspInfo<cr>",    "Show attached lsp server info" },
        { "<leader>lu", "<cmd>LspRestart<cr>", "Restart lsp server" },
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
