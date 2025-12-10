-- Configurate language server

local M = {
    "neovim/nvim-lspconfig",
    event = { "VeryLazy" },
    config = function()
        vim.lsp.enable({
            "denojs",
            "emmylua_ls",
            "gopls",
            "marksman",
            "ocamllsp",
            "pylsp",
            "rust_analyzer",
            "zls",
        })
    end,
}

local function bind_keys(event)
    local buf = event.buf
    local pickers = require("mini.extra").pickers

    local bindings = {
        { "gd",          vim.lsp.buf.definition,                                     "Goto definition" },
        { "gD",          vim.lsp.buf.declaration,                                    "Goto declaration" },
        { "grr",         function() pickers.lsp({ scope = "references" }) end,       "Goto references" },
        { "gri",         function() pickers.lsp({ scope = "implementation" }) end,   "Goto implementation" },
        { "grn",         vim.lsp.buf.rename,                                         "Rename" },
        { "gra",         vim.lsp.buf.code_action,                                    "Code action" },
        { "grt",         function() pickers.lsp({ scope = "type_definition" }) end,  "Type definition" },
        --
        { "gO",          function() pickers.lsp({ scope = "document_symbol" }) end,  "Buffer symbols" },
        { "<leader>ws",  function() pickers.lsp({ scope = "workspace_symbol" }) end, "Workspace symbols" },

        -- See `:help K` for why this keymap
        { "K",           vim.lsp.buf.hover,                                          "Hover documentation" },
        { "<M-K>",       vim.lsp.buf.signature_help,                                 "Signature documentation" },

        -- Lesser used LSP functionality
        { "<leader>wfa", vim.lsp.buf.add_workspace_folder,                           "Add folder to workspace" },
        { "<leader>wfr", vim.lsp.buf.remove_workspace_folder,                        "Remove folder from workspace" },
        {
            "<leader>wfl",
            function()
                print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
            end,
            "List workspace folders",
        },
    }

    for _, binding in ipairs(bindings) do
        local key, cmd, desc = binding[1], binding[2], "LSP: " .. binding[3]
        vim.keymap.set("n", key, cmd, { buffer = buf, desc = desc })
    end
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user.lsp", {}),
    callback = bind_keys,
})

return M
