-- config linter

local lint = require("lint")

lint.linters_by_ft = {
    fish = { "fish" },
}

local lint_augroup = vim.api.nvim_create_augroup("init.lint", {})

vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost" }, {
    group = lint_augroup,
    callback = function(args)
        if vim.bo[args.buf].buftype ~= "" then return end

        vim.api.nvim_buf_call(args.buf, function()
            lint.try_lint()
            lint.try_lint("typos")
        end)
    end,
})

vim.api.nvim_create_user_command("Lint", function()
    lint.try_lint()
    lint.try_lint("typos")
end, { desc = "Lint current buffer" })
