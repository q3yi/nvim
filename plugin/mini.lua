-- Config mini.nvim

require("mini.icons").setup()
require("mini.notify").setup({ window = { winblend = 0 } })

require("mini.pick").setup()
require("mini.extra").setup()

local keys = {
    { "-",          "<cmd>ToggleMiniFiles -<cr>",                      "Open mini files" },
    { "<leader>-",  "<cmd>ToggleMiniFiles %<cr>",                      "Open mini files in current directory" },

    -- buffers
    { "<leader>bb", "<cmd>Pick buffers<cr>",                           "List all buffers" },
    { "<leader>bx", function() require("mini.bufremove").delete() end, "Delete current buffer" },
    { "<leader>bg", "<cmd>Pick buf_lines<cr>",                         "Ripgrep in all open buffers" },

    { "<leader>f",  "<cmd>Pick files<cr>",                             "Find Files" },
    { "<leader>h",  "<cmd>Pick help<cr>",                              "Search help docs" },
    { "<leader>m",  "<cmd>Pick marks<cr>",                             "List all marks" },

    { "<leader>wq", "<cmd>Pick list scope='quickfix'<cr>",             "List all quickfixes" },
    { "<leader>wd", "<cmd>Pick diagnostic<cr>",                        "List all diagnostics in workspace" },
    { "<leader>wg", "<cmd>Pick grep_live<cr>",                         "Ripgrep in workspace" },
    { "<m-x>",      "<cmd>Pick commands<cr>",                          "Run command" },
    { "<leader>gb", "<cmd>Pick git_branches<cr>",                      "Git branches" },
    { "<leader>.",  "<cmd>Pick resume<cr>",                            "Resume last picker" },
}

for _, binding in ipairs(keys) do
    vim.keymap.set("n", binding[1], binding[2], { desc = binding[3] })
end
