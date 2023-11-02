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
    local set_keymap = function(keys, func, desc)
        if desc then
            desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = buf, desc = desc })
    end

    local telescope = require("telescope.builtin")

    set_keymap("<leader>lr", vim.lsp.buf.rename, "Rename")
    set_keymap("<leader>la", vim.lsp.buf.code_action, "Code action")

    set_keymap("gd", telescope.lsp_definitions, "Goto definition")
    set_keymap("gr", telescope.lsp_references, "Goto references")
    set_keymap("gI", telescope.lsp_implementations, "Goto implementation")
    set_keymap("<leader>lD", telescope.lsp_type_definitions, "Type definition")
    set_keymap("<leader>ls", telescope.lsp_document_symbols, "Buffer symbols")
    set_keymap("<leader>lS", telescope.lsp_dynamic_workspace_symbols, "Workspace symbols")
    set_keymap("<leader>lf", function() vim.lsp.buf.format { async = true } end, "Format current buffer")

    -- See `:help K` for why this keymap
    set_keymap("K", vim.lsp.buf.hover, "Hover documentation")
    set_keymap("<C-k>", vim.lsp.buf.signature_help, "Signature documentation")

    -- Lesser used LSP functionality
    set_keymap("gD", vim.lsp.buf.declaration, "Goto declaration")
    set_keymap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Add folder to workspace")
    set_keymap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove folder from workspace")
    set_keymap("<leader>wl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, "List workspace folders")

    -- Create a command `:Format` local to the LSP buffer
    vim.api.nvim_buf_create_user_command(buf, "Format", function(_)
        vim.lsp.buf.format()
    end, { desc = "Format current buffer with LSP" })
end

local servers = {
    -- clangd = {},
    gopls = {},
    hls = {},
    html = { filetypes = { "html", "twig", "hbs"} },
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
