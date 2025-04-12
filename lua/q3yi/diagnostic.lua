-- Set diagnostic shortcuts

local options = {
    config = {
        signs = {
            text = {
                [vim.diagnostic.severity.ERROR] = "‼",
                [vim.diagnostic.severity.WARN] = "!",
                [vim.diagnostic.severity.HINT] = "!",
                [vim.diagnostic.severity.INFO] = "!",
            },
        },
        virtual_text = function()
            return vim.g.diagnostic_show_virtual_text or false
        end,
        underline = true,
        update_in_insert = true,
        serverity_sort = true,
        float = {
            focusable = true,
            source = "always",
        },
    },
}

local function setup_diagnostic(opts)
    vim.diagnostic.config(opts.config)
    vim.keymap.set("n", "<leader>dk", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
end

-- initial diagnostic config here.
setup_diagnostic(options)

local TroublePlugin = {
    "folke/trouble.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    cmd = { "Trouble", "TroubleToggle" },
    opts = {},
    keys = {
        {
            "<leader>da",
            "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
            desc = "Open buffer diagnostics list in trouble",
        },
        { "<leader>dl", "<cmd>Trouble loclist toggle<cr>", desc = "Open location list in trouble" },
        { "<leader>wd", "<cmd>Trouble diagnostics toggle<cr>", desc = "Open workspace diagnostics list in trouble" },
        { "<leader>wq", "<cmd>Trouble qflist toggle<cr>", desc = "Open quickfix list in trouble" },
    },
    config = function()
        require("trouble").setup({
            mode = "document_diagnostics",
            action_keys = {
                open_split = { "<c-s>" },
            },
            auto_preview = false,
        })
    end,
}

return { TroublePlugin }
