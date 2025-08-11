-- Set diagnostic shortcuts

vim.g.show_virtual_diagnostic = "text"

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
        return vim.g.show_virtual_diagnostic == "text"
    end,
    virtual_lines = function()
        if vim.g.show_virtual_diagnostic == "line" then
            return { current_line = true }
        end

        return false
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
