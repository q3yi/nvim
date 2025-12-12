-- config colorscheme

require("rose-pine").setup({
    variant = "auto",
    dark_variant = "main",
    styles = {
        -- bold = true,
        italic = false,
    },
    highlight_groups = {
        DapBreak = { fg = "love", bg = "love", blend = 10 },
        DapStop = { fg = "gold", bg = "gold", blend = 10 },
    },
})

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("theme.transparency", {}),
    callback = function()
        vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
        vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
        vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
    end,
})

vim.cmd("colorscheme rose-pine")
