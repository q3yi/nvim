-- Set color theme and status line

local NightfoxTheme = {
    "EdenEast/nightfox.nvim",
    priority = 1000,
    config = function()
        require("nightfox").setup({
            options = {
                styles = {
                    comments = "italic"
                },
            }
        })
        vim.cmd.colorscheme "carbonfox"
    end
}

-- local MiniStatus = {
--     "echasnovski/mini.statusline",
--     version = false,
--     config = function()
--         require("mini.statusline").setup({})
--     end
-- }

return {
    NightfoxTheme,
    -- MiniStatus,
}
