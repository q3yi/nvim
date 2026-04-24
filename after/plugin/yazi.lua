-- config yazi

local keys = {
    { "<leader>e", "<cmd>ToggleYazi<cr>",     "Open yazi at current file" },
    { "<leader>E", "<cmd>ToggleYazi cwd<cr>", "Open yazi at nvim cwd" },
}

for _, binding in ipairs(keys) do
    vim.keymap.set({ "n", "v" }, binding[1], binding[2], { desc = binding[3] })
end

local initialized = false
vim.api.nvim_create_user_command("ToggleYazi", function(opts)
    local y = require("yazi")

    if not initialized then
        y.setup {
            open_for_directories = true,
            floating_window_scaling_factor = 1,
            yazi_floating_window_border = "none",
        }
    end

    if #opts.fargs == 0 then
        y.yazi()
        return
    end

    if opts.fargs[1] == "cwd" then
        y.yazi(nil, vim.fn.getcwd())
        return
    end

    if opts.fargs[1] == "resume" then
        y.toggle()
    end
end, {
    nargs = "*",
    desc = "Valid commands are `ToggleYazi`, `ToggleYazi cwd`, `ToggleYazi resume`",
})
