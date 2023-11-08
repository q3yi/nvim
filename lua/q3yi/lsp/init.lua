-- Configurate language server

local M = {
    -- LSP Configuration & Plugins
    'neovim/nvim-lspconfig',
    dependencies = {
        -- Adds LSP completion capabilities
        "hrsh7th/cmp-nvim-lsp",

        -- Useful status updates for LSP
        -- NOTE: `opts = {}` is the same as calling `require('fidget').setup({})`
        { 'j-hui/fidget.nvim', tag = 'legacy', opts = {} },

        -- Additional lua configuration, makes nvim stuff amazing!
        'folke/neodev.nvim',
    },
}

local function on_attach(_, buf)
    -- In this case, we create a function that lets us more easily define mappings specific
    -- for LSP related items. It sets the mode, buffer and description for us each time.
    local kmap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
    end

    local telescope = require("telescope.builtin")

    kmap("<leader>lr", vim.lsp.buf.rename, "Rename")
    kmap("<leader>la", vim.lsp.buf.code_action, "Code action")

    kmap("gd", telescope.lsp_definitions, "Goto definition")
    kmap("gr", telescope.lsp_references, "Goto references")
    kmap("gI", telescope.lsp_implementations, "Goto implementation")

    kmap("<leader>lD", telescope.lsp_type_definitions, "Type definition")
    kmap("<leader>ls", telescope.lsp_document_symbols, "Buffer symbols")
    kmap("<leader>lS", telescope.lsp_dynamic_workspace_symbols, "Workspace symbols")
    kmap("<leader>lf", function() vim.lsp.buf.format { async = true } end, "Format current buffer")

    -- See `:help K` for why this keymap
    kmap("K", vim.lsp.buf.hover, "Hover documentation")
    kmap("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")

    -- Lesser used LSP functionality
    kmap("gD", vim.lsp.buf.declaration, "Goto declaration")
    kmap("<leader>wfa", vim.lsp.buf.add_workspace_folder, "Add folder to workspace")
    kmap("<leader>wfr", vim.lsp.buf.remove_workspace_folder, "Remove folder from workspace")
    kmap("<leader>wfl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")
end

local servers = {
    -- clangd = {},
    gopls = {},
    hls = {},
    html = { filetypes = { "html", "twig", "hbs" } },
    jsonls = {},
    pylsp = {},
    rust_analyzer = {},
    tsserver = {},
    marksman = {},

    lua_ls = {
        Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
        },
    },
}

function M.config()
    require("neodev").setup({})

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    local lspconfig = require("lspconfig")

    for server, opt in pairs(servers) do
        lspconfig[server].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            settings = opt,
        }
    end
    -- require("q3yi.lsp.mason")
end

return M
