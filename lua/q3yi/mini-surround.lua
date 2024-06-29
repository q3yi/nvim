-- config for editing surrounding.

return {
    "echasnovski/mini.surround",
    version = false,
    event = { "VeryLazy" },
    config = function()
        require("mini.surround").setup({
            n_lines = 100,
            respect_selection_type = true,
        })
    end,
}
