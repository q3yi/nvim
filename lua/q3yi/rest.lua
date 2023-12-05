-- Send restful request in neovim

local M = {
    "rest-nvim/rest.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    ft = "http",
}

function M.config()
    local rest = require("rest-nvim")
    rest.setup({
        skip_ssl_verification = true,
        formatters = {
            json = "prettier",
            html = "prettier",
        },
    })

    vim.keymap.set("n", "<leader>r", rest.run, { desc = "Send request under cursor" })
end

return M
