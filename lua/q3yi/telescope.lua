-- telescope fuzzy Finder

local M = {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
        -- Fuzzy Finder Algorithm which requires local dependencies to be built.
        -- Only load if `make` is available. Make sure you have the system
        -- requirements installed.
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            -- NOTE: If you are having trouble with this installation,
            --       refer to the README for telescope-fzf-native for more instructions.
            build = 'make',
            cond = function()
                return vim.fn.executable 'make' == 1
            end,
        },
    },
}

-- [[ Configure Telescope ]]
-- See `:help telescope` and `:help telescope.setup()`
function M.config()
    local telescope = require("telescope")

    telescope.setup {
        defaults = {
            mappings = {
                i = {
                    ['<C-u>'] = false,
                    ['<C-d>'] = false,
                },
            },
        },
        pickers = {
            buffers = { theme = "ivy" },
            commands = { theme = "ivy" },
            find_files = { theme = "ivy" },
            oldfiles = { theme = "ivy" },
            git_files = { theme = "ivy" },
            help_tags = { theme = "ivy" },
        },
    }

    pcall(telescope.load_extension, "fzf")

    local set_keymap = vim.keymap.set
    local builtin = require("telescope.builtin")

    set_keymap("n", "<leader>x", builtin.commands, { desc = "Execute command" })
    set_keymap("n", "<leader>b", builtin.buffers, { desc = "Switch buffer" })
    set_keymap("n", "<leader>f", builtin.find_files, { desc = "Find files" })
    set_keymap("n", "<leader>F", builtin.oldfiles, { desc= "Recent opened files" })
    set_keymap("n", "<leader>/", function()
        builtin.current_buffer_fuzzy_find(require("telescope.themes").get_ivy {
            previewer = false,
        })
    end, { desc = "Fuzzily search in current buffer" })

    set_keymap("n", "<leader>wg", builtin.git_files, { desc = "Search file in workspace git" })
    set_keymap("n", "<leader>wr", builtin.live_grep, { desc = "Search in workspace files" })
    set_keymap("n", "<leader>w!", builtin.diagnostics, { desc = "Search diagnostics in workspace" })

    set_keymap("n", "<leader>h", builtin.help_tags, { desc = "Search help" })

end

return M
