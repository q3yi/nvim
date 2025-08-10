--

local M = {
    "echasnovski/mini.files",
    version = false,
    event = { "VeryLazy" },
    -- cmd = { "OpenMiniFiles" },
    keys = {
        { "-", "<cmd>ToggleMiniFiles -<cr>", desc = "Open mini files" },
        { "<leader>-", "<cmd>ToggleMiniFiles %<cr>", desc = "Open mini files in current directory" },
    },

    init = function()
        vim.api.nvim_create_user_command("ToggleMiniFiles", function(args)
            local MiniFiles = require("mini.files")

            if MiniFiles.get_explorer_state() ~= nil then
                MiniFiles.close()
                return
            end

            if args.args == "%" then
                MiniFiles.open(vim.api.nvim_buf_get_name(0))
                return
            end

            if args.args == "-" then
                MiniFiles.open(MiniFiles.get_latest_path())
                return
            end

            MiniFiles.open()
        end, { nargs = "?", desc = "Open mini file explorer" })
    end,

    config = function()
        require("mini.files").setup()
    end,
}

return M
