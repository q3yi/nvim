-- mini.ai

local M = {
    "echasnovski/mini.ai",
    event = { "VeryLazy" },
    version = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        local mini = require("mini.ai")
        local gen = mini.gen_spec.treesitter

        mini.setup({
            custom_textobjects = {
                f = gen({ a = "@function.outer", i = "@function.inner" }),
                c = gen({ a = "@class.outer", i = "@class.inner" }),
                o = gen({ a = "@block.outer", i = "@block.inner" }),
            },
            n_lines = 200,
        })
    end,
}

return M
