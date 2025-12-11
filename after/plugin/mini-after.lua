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
    },
    n_lines = 200,
})

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

local minifiles = nil
vim.api.nvim_create_user_command("ToggleMiniFiles", function(args)
    if minifiles == nil then
        minifiles = require("mini.files")
        minifiles.setup()
    end

    if minifiles.get_explorer_state() ~= nil then
        minifiles.close()
        return
    end

    if args.args == "%" then
        minifiles.open(vim.api.nvim_buf_get_name(0))
        return
    end

    if args.args == "-" then
        minifiles.open(minifiles.get_latest_path())
        return
    end

    minifiles.open()
end, { nargs = "?", desc = "Open file explorer" })
