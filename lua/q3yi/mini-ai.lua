-- extend i, a textobjects.

local M = {
    "echasnovski/mini.ai",
    version = false,
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = "VeryLazy",
    config = function()
        local ai = require("mini.ai")
        ai.setup({
            custom_textobjects = {
                a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
                c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
                f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
                o = ai.gen_spec.treesitter({
                    a = { "@conditional.outer", "@loop.outer" },
                    i = { "@conditional.inner", "@loop.inner" },
                })
            },
            n_lines = 100,
            goto_left = "[[",
            goto_right = "]]",
        })
    end
}

return M
