-- config colorscheme

require("rose-pine").setup({
    variant = "auto",
    dark_variant = "moon",
    styles = {
        italic = false,
        transparency = true,
    },
    highlight_groups = {
        DapBreak = { fg = "love", bg = "love", blend = 10 },
        DapStop = { fg = "gold", bg = "gold", blend = 10 },
    },
})

vim.cmd("colorscheme rose-pine")
