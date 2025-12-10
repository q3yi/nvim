-- Configurate language server

local M = {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy" },
    dependencies = {
        "mason-org/mason.nvim",
        "mason-org/mason-lspconfig.nvim",
    },
    config = function()
        require("mason").setup({ ui = { border = "single" } })
        require("mason-lspconfig").setup()

        -- Some lsp server should install with its own environment instead of install through Mason,
        -- so we just enable it manually.
        vim.lsp.enable({ "emmylua_ls", "pylsp", "ocamllsp", "gopls", "zls", "marksman" })
    end,
}

local function bind_keys(event)
    local buf = event.buf

    local bindings = {
        { "gd",          Snacks.picker.lsp_definitions,       "Goto definition" },
        { "gD",          Snacks.picker.lsp_declarations,      "Goto declaration" },

        { "grr",         Snacks.picker.lsp_references,        "Goto references" },
        { "gri",         Snacks.picker.lsp_implementations,   "Goto implementation" },
        { "grn",         vim.lsp.buf.rename,                  "Rename" },
        { "gra",         vim.lsp.buf.code_action,             "Code action" },
        { "grt",         Snacks.picker.lsp_type_definitions,  "Type definition" },

        { "gO",          Snacks.picker.lsp_symbols,           "Buffer symbols" },
        { "<leader>ws",  Snacks.picker.lsp_workspace_symbols, "Workspace symbols" },

        -- See `:help K` for why this keymap
        { "K",           vim.lsp.buf.hover,                   "Hover documentation" },
        { "<M-K>",       vim.lsp.buf.signature_help,          "Signature documentation" },

        -- Lesser used LSP functionality
        { "<leader>wfa", vim.lsp.buf.add_workspace_folder,    "Add folder to workspace" },
        { "<leader>wfr", vim.lsp.buf.remove_workspace_folder, "Remove folder from workspace" },
        {
            "<leader>wfl",
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "List workspace folders",
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

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user.lsp", {}),
    callback = bind_keys,
})

return M
