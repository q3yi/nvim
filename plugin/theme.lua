--- setup theme

local theme_opts = {
    light = "ef-duo-light",
    dark = "ef-duo-dark",
    modules = {
        mini = true,
    },
    options = {
        compile = false, -- compile will hardcode vim.o.background, disable auto theme switch
    },
} ---@as Ef-Themes.Config

require("ef-themes").setup(theme_opts)

vim.cmd.colorscheme("ef-theme")
