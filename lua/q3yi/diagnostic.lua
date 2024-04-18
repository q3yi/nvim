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
        virtual_text = false,
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
        { "]e", jump("next", "E"),        { desc = "Next Error" } },
        { "[e", jump("prev", "E"),        { desc = "Prev Error" } },
        { "]w", jump("next", "W"),        { desc = "Next Warning" } },
        { "[w", jump("prev", "W"),        { desc = "Prev Warning" } },
    }
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
end

-- initial diagnostic config here.
setup_diagnostic(options)

local TroublePlugin = {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "Trouble", "TroubleToggle", },
    opts = {},
    keys = {
        { "<leader>da", "<cmd>TroubleToggle document_diagnostics<cr>",  desc = "Open buffer diagnostics list in trouble" },
        { "<leader>dl", "<cmd>TroubleToggle loclist<cr>",               desc = "Open location list in trouble" },
        { "<leader>wd", "<cmd>TroubleToggle workspace_diagnostics<cr>", desc = "Open workspace diagnostics list in trouble" },
        { "<leader>wq", "<cmd>TroubleToggle quickfix<cr>",              desc = "Open quickfix list in trouble" },
    },
    config = function()
        require("trouble").setup {
            mode = "document_diagnostics",
            action_keys = {
                open_split = { "<c-s>" },
            },
            auto_preview = false,
        }
    end
}

return { TroublePlugin }
