-- mini.nvim plugins

local M = {
    'nvim-mini/mini.nvim',
    version = false,
    event = "VeryLazy",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
    },
    keys = {
        { "-",          "<cmd>ToggleMiniFiles -<cr>",                      desc = "Open mini files" },
        { "<leader>-",  "<cmd>ToggleMiniFiles %<cr>",                      desc = "Open mini files in current directory" },

        -- buffers
        { "<leader>bb", "<cmd>Pick buffers<cr>",                           desc = "List all buffers" },
        { "<leader>bx", function() require("mini.bufremove").delete() end, desc = "Delete current buffer" },
        { "<leader>bg", "<cmd>Pick buf_lines<cr>",                         desc = "Ripgrep in all open buffers" },

        { "<leader>f",  "<cmd>Pick files<cr>",                             desc = "Find Files" },
        { "<leader>h",  "<cmd>Pick help<cr>",                              desc = "Search help docs" },
        { "<leader>m",  "<cmd>Pick marks<cr>",                             desc = "List all marks" },

        { "<leader>wq", "<cmd>Pick list scope='quickfix'",                 desc = "List all quickfixes" },
        { "<leader>wd", "<cmd>Pick diagnostic<cr>",                        desc = "List all diagnostics in workspace" },
        { "<leader>wg", "<cmd>Pick grep_live<cr>",                         desc = "Ripgrep in workspace" },

        { "<m-x>",      "<cmd>Pick commands<cr>",                          desc = "Run command" },

        -- git keys
        -- { "<leader>gs", function() Snacks.lazygit.open() end,                                                             desc = "Open lazy git" },
        -- { "<leader>gL", function() Snacks.lazygit.log() end,                                                              desc = "Open lazy git log" },
        { "<leader>gb", "<cmd>Pick git_branches<cr>",                      desc = "Git branches" },

        -- floating terminal
        -- { "<m-t>",      function() Snacks.terminal.toggle(nil, { win = { border = "rounded", position = "float" } }) end, desc = "Toggle floating terminal",            mode = { "n", "v", "t" } },

        { "<leader>.",  "<cmd>Pick resume<cr>",                            desc = "Resume last picker" },
    },
}

function M.setup_mini_ai()
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
            ['/'] = gen({ a = "@comment.outer", i = "@comment.inner" }),
        },
        n_lines = 200,
    })
end

function M.setup_mini_clue()
    local miniclue = require('mini.clue')
    miniclue.setup({
        triggers = {
            -- Leader triggers
            { mode = 'n', keys = '<Leader>' },
            { mode = 'x', keys = '<Leader>' },

            -- Built-in completion
            { mode = 'i', keys = '<C-x>' },

            -- `g` key
            { mode = 'n', keys = 'g' },
            { mode = 'x', keys = 'g' },

            -- Marks
            { mode = 'n', keys = "'" },
            { mode = 'n', keys = '`' },
            { mode = 'x', keys = "'" },
            { mode = 'x', keys = '`' },

            -- Registers
            { mode = 'n', keys = '"' },
            { mode = 'x', keys = '"' },
            { mode = 'i', keys = '<C-r>' },
            { mode = 'c', keys = '<C-r>' },

            -- Window commands
            { mode = 'n', keys = '<C-w>' },

            -- `z` key
            { mode = 'n', keys = 'z' },
            { mode = 'x', keys = 'z' },
        },

        clues = {
            miniclue.gen_clues.builtin_completion(),
            miniclue.gen_clues.g(),
            miniclue.gen_clues.marks(),
            miniclue.gen_clues.registers(),
            miniclue.gen_clues.windows(),
            miniclue.gen_clues.z(),
            miniclue.gen_clues.square_brackets(),
            { mode = "n", keys = "<leader>b", desc = "+Buffers" },
            { mode = "n", keys = "<leader>d", desc = "+Debugger" },
            { mode = "n", keys = "<leader>w", desc = "+Workspace" },
            { mode = "n", keys = "<leader>g", desc = "+Git" },
            { mode = "n", keys = "<leader>u", desc = "+Options" },
        },
        window = {
            config = {
                width = "auto",
            }
        }
    })
end

function M.config()
    M.setup_mini_ai()
    M.setup_mini_clue()

    require('mini.notify').setup({ window = { winblend = 0 } })
    require("mini.icons").setup()
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

    require("mini.pick").setup()
    require("mini.extra").setup()
end

vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("user.mini", {}),
    callback = function()
        if vim.g.minipairs_loaded then
            return
        end

        require("mini.pairs").setup()
        vim.g.minipairs_loaded = true
    end

})

vim.api.nvim_create_user_command("ToggleMiniFiles", function(args)
    local minifiles = require("mini.files")

    if not vim.g.minifiles_loaded then
        minifiles.setup()
        vim.g.minifiles_loaded = true
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
end, { nargs = "?", desc = "Open mini file explorer" })

return M
