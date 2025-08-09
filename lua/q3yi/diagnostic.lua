-- Set diagnostic shortcuts

local opts = {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "‼",
            [vim.diagnostic.severity.WARN] = "!",
            [vim.diagnostic.severity.HINT] = "!",
            [vim.diagnostic.severity.INFO] = "!",
        },
    },
    virtual_text = function()
        if vim.g.diagnostic_show_virtual_text == nil then
            vim.g.diagnostic_show_virtual_text = true
        end
        return vim.g.diagnostic_show_virtual_text
    end,
    virtual_lines = function()
        if vim.g.diagnostic_show_virtual_text then
            return false
        end

        return { current_line = true }
    end,
    underline = true,
    update_in_insert = true,
    serverity_sort = true,
    float = {
        focusable = true,
        source = "always",
    },
}

vim.diagnostic.config(opts)
vim.keymap.set("n", "<leader>dk", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>dq", vim.diagnostic.setqflist, { desc = "Set diagnostic to quickfix" })
