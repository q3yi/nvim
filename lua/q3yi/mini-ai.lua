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
                o = gen({
                    a = { "@statement.outer", "@conditional.outer", "@loop.outer", "@block.outer" },
                    i = { "@conditional.inner", "@loop.inner", "@block.inner" },
                }),
                m = gen({ a = "@comment.outer", i = "@comment.inner" }),
            },
            n_lines = 200,
        })
    end,
}

return M
