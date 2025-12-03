-- mini icons

return {
    "nvim-mini/mini.icons",
    version = false,
    event = "VeryLazy",
    config = function()
        require("mini.icons").setup()
    end,
}
