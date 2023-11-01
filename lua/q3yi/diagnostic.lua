-- Set diagnostic shortcuts

local signs = {
    { name = "DiagnosticSignError", text = "‼" },
    { name = "DiagnosticSignWarn", text = "ǃ" },
    { name = "DiagnosticSignHint", text = "!" },
    { name = "DiagnosticSignInfo", text = "!" },
}

-- local signs = {
--     { name = "DiagnosticSignError", text = "󰅚" },
--     { name = "DiagnosticSignWarn", text = "󰀪" },
--     { name = "DiagnosticSignHint", text = "󰌶" },
--     { name = "DiagnosticSignInfo", text = "󰋽" },
-- }

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
    virtual_text = true,
    underline = true,
    update_in_insert = true,
    serverity_sort = true,
    float = {
        focusable = false,
        -- style = "minimal",
        border = "rounded",
        source = "always",
    },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

-- Diagnostic keymaps
vim.keymap.set("n", "<leader>dn", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic message" })
vim.keymap.set("n", "<leader>dp", vim.diagnostic.goto_next, { desc = "Go to next diagnostic message" })
vim.keymap.set("n", "<leader>dk", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })
