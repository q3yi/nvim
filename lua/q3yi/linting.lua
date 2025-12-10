-- config linters

local M = {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
}

M.config = function()
    require("lint").linters_by_ft = {
        fish = { "fish" },
    }
end

M.init = function()
    local lint_group = vim.api.nvim_create_augroup("linting", { clear = true })
    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        pattern = { "*.fish" },
        group = lint_group,
        callback = function()
            require("lint").try_lint()
        end,
    })

    vim.keymap.set("n", "<leader>bl", function()
        require("lint").try_lint()
    end, { desc = "Lint current buffer" })
end

return M
