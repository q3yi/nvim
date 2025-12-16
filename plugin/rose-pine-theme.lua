---@diagnostic disable-next-line: param-type-mismatch
require("rose-pine").setup({
    variant = "auto",
    dark_variant = "main",
    styles = { italic = false },
    highlight_groups = {
        Normal = { bg = "none" },
        NormalNC = { bg = "none" },

        Comment = { italic = true },
        ["@markup.italic"] = { italic = true },

        DapBreak = { fg = "love", bg = "love", blend = 10 },
        DapStop = { fg = "gold", bg = "gold", blend = 10 },
    },
})

vim.cmd.colorscheme("rose-pine")
