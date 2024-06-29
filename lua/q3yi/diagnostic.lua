-- Set diagnostic shortcuts

local function jump(direction, serverity)
    local move = vim.diagnostic.goto_next
    if direction == "prev" then
        move = vim.diagnostic.goto_prev
    end

    local s = vim.diagnostic.severity[serverity]

    return function()
        move({ serverity = s })
    end
end

local options = {
    signs = {
        { name = "DiagnosticSignError", text = "‼" },
        { name = "DiagnosticSignWarn", text = "ǃ" },
        { name = "DiagnosticSignHint", text = "!" },
        { name = "DiagnosticSignInfo", text = "!" },
    },
    config = {
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
    keys = {
        { "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" } },
        { "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" } },
        { "]e", jump("next", "E"), { desc = "Next Error" } },
        { "[e", jump("prev", "E"), { desc = "Prev Error" } },
        { "]w", jump("next", "W"), { desc = "Next Warning" } },
        { "[w", jump("prev", "W"), { desc = "Prev Warning" } },
    },
}

local function setup_diagnostic(opts)
    -- set diagnostic signs
    for _, sign in ipairs(opts.signs) do
        vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
    end

    vim.diagnostic.config(opts.config)

    for _, binding in ipairs(opts.keys) do
        local key, cmd, opt = binding[1], binding[2], binding[3]
        vim.keymap.set("n", key, cmd, opt)
    end

    vim.keymap.set("n", "<leader>dk", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
    vim.keymap.set("n", "<leader>ud", function()
        vim.g.diagnostic_show_virtual_text = not vim.g.diagnostic_show_virtual_text
        if vim.g.diagnostic_show_virtual_text then
            vim.notify("diagnostic virtual text enabled", vim.log.levels.INFO)
        else
            vim.notify("diagnostic virtual text disabled", vim.log.levels.INFO)
        end
    end, { desc = "Toggle diagnostic virtual text" })
end

-- initial diagnostic config here.
setup_diagnostic(options)

local TroublePlugin = {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
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
