-- mini components that load after plugin folder

local mini_ai = require("mini.ai")
local gen = mini_ai.gen_spec.treesitter

mini_ai.setup({
    custom_textobjects = {
        f = gen({ a = "@function.outer", i = "@function.inner" }),
        c = gen({ a = "@class.outer", i = "@class.inner" }),
        o = gen({
            a = { "@statement.outer", "@conditional.outer", "@loop.outer", "@block.outer" },
            i = { "@conditional.inner", "@loop.inner", "@block.inner" },
        }),
        ["/"] = gen({ a = "@comment.outer", i = "@comment.inner" }),
        e = function()
            local node = vim.treesitter.get_node()
            if not node then return end

            local from_line, from_col, to_line, to_col = node:range()
            -- mini.ai uses 1-based line and 1-based from_col, but to_col is exclusive (same as TSNode:range end_col)
            local region = {
                from = { line = from_line + 1, col = from_col + 1 },
                to = { line = to_line + 1, col = to_col }
            }
            -- Handle "row-exclusive, col-0" range (node ends at start of line)
            if region.to.col == 0 then
                region.to.line = region.to.line - 1
                region.to.col = vim.fn.col({ region.to.line, '$' })
            end
            return region
        end
    },
    n_lines = 200,
})

local map_lsp_selection = function(lhs, desc)
    local s = vim.startswith(desc, "Increase") and 1 or -1
    local rhs = function() vim.lsp.buf.selection_range(s * vim.v.count1) end
    vim.keymap.set({ "n", "x" }, lhs, rhs, { desc = desc })
end

map_lsp_selection("<M-o>", "Increase selection")
map_lsp_selection("<M-i>", "Decrease selection")

local miniclue = require("mini.clue")
miniclue.setup({
    triggers = {
        -- Leader triggers
        { mode = "n", keys = "<Leader>" },
        { mode = "x", keys = "<Leader>" },

        -- Built-in completion
        { mode = "i", keys = "<C-x>" },

        -- `g` key
        { mode = "n", keys = "g" },
        { mode = "x", keys = "g" },

        -- Marks
        { mode = "n", keys = "'" },
        { mode = "n", keys = "`" },
        { mode = "x", keys = "'" },
        { mode = "x", keys = "`" },

        -- Registers
        { mode = "n", keys = '"' },
        { mode = "x", keys = '"' },
        { mode = "i", keys = "<C-r>" },
        { mode = "c", keys = "<C-r>" },

        -- Window commands
        { mode = "n", keys = "<C-w>" },

        -- Brackets
        { mode = "n", keys = "]" },
        { mode = "n", keys = "[" },

        -- `z` key
        { mode = "n", keys = "z" },
        { mode = "x", keys = "z" },
    },

    clues = {
        miniclue.gen_clues.builtin_completion(),
        miniclue.gen_clues.g(),
        miniclue.gen_clues.marks(),
        miniclue.gen_clues.registers(),
        miniclue.gen_clues.windows(),
        miniclue.gen_clues.z(),
        miniclue.gen_clues.square_brackets(),
        { mode = "n", keys = "<leader>b",  desc = "+Buffers" },
        { mode = "n", keys = "<leader>d",  desc = "+Debugger" },
        { mode = "n", keys = "<leader>w",  desc = "+Workspace" },
        { mode = "n", keys = "<leader>wf", desc = "+Workspace Folders" },
        { mode = "n", keys = "<leader>g",  desc = "+Git" },
        { mode = "n", keys = "<leader>u",  desc = "+Options" },
    },
    window = {
        config = {
            width = "auto",
        }
    }
})

require("mini.jump2d").setup({
    view = { dim = true },
    mappings = {
        start_jumping = "gw",
    },
})

require("mini.surround").setup({
    n_lines = 100,
    respect_selection_type = true,
})

require("mini.splitjoin").setup()

vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("init.minipairs", {}),
    once = true,
    callback = function()
        require("mini.pairs").setup()
    end

})

vim.api.nvim_create_autocmd("BufReadPost", {
    group = vim.api.nvim_create_augroup("init.minidiff", {}),
    once = true,
    callback = function()
        require("mini.diff").setup({
            view = {
                style = "sign",
                signs = { add = "┃", change = "┃", delete = "_" },
            },
            mappings = {
                apply = "",
                reset = "<leader>gx",
                textobject = "ah"
            }
        })
    end
})
