-- Set diagnostic shortcuts

local signs = {
    { name = "DiagnosticSignError", text = "‼" },
    { name = "DiagnosticSignWarn", text = "ǃ" },
    { name = "DiagnosticSignHint", text = "!" },
    { name = "DiagnosticSignInfo", text = "!" },
}

for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
end

local config = {
    virtual_text = false,
    underline = true,
    update_in_insert = true,
    serverity_sort = true,
    float = {
        focusable = true,
        border = "rounded",
        source = "always",
    },
}

vim.diagnostic.config(config)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = "rounded" })
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

local function goto_diagnostic(serverity, forward)
    local goto = forward and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
    serverity = vim.diagnostic.severity[serverity]
    return function ()
        goto({ serverity = serverity })
    end
end

local kmap = vim.keymap.set

kmap("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })
kmap("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
kmap("n", "]e", goto_diagnostic("E", true), { desc = "Next Error" })
kmap("n", "[e", goto_diagnostic("E", false), { desc = "Prev Error" })
kmap("n", "]w", goto_diagnostic("W", true), { desc = "Next Warning" })
kmap("n", "[w", goto_diagnostic("W", false), { desc = "Prev Warning" })

vim.keymap.set("n", "<leader>dk", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
