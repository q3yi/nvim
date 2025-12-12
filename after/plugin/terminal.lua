--- Toggle floating terminal

---@param buf integer
---@return table
local function create_floating_win(buf)
    local width = vim.o.columns
    local height = vim.o.lines

    if width < 40 or height < 20 then
        vim.notify("Not enough space to show panel", vim.log.levels.ERROR)
    end

    if vim.o.winborder ~= "none" then
        width = width - 2
        height = height - 2
    end

    local win_opts = {
        relative = "editor",
        width = width - 12,
        height = height - 2,
        col = 6,
        row = 0,
        style = "minimal",
        border = vim.o.winborder,
    }

    if not vim.api.nvim_buf_is_valid(buf) then
        buf = vim.api.nvim_create_buf(false, true)
    end

    ---@diagnostic disable-next-line: param-type-mismatch
    local win = vim.api.nvim_open_win(buf, true, win_opts)

    vim.api.nvim_set_current_win(win)

    if vim.bo[buf].buftype ~= "terminal" then
        vim.bo[buf].buflisted = false
        vim.cmd.terminal()
    end

    return { buf = buf, win = win }
end

local state = {
    floating = {
        buf = -1,
        win = -1
    }
}

vim.api.nvim_create_user_command("ToggleTerm", function()
    if not vim.api.nvim_win_is_valid(state.floating.win) then
        state.floating = create_floating_win(state.floating.buf)
        vim.cmd("startinsert")
    else
        vim.api.nvim_win_hide(state.floating.win)
    end
end, { desc = "Toggle floating terminal" })

vim.keymap.set({ "n", "v", "t" }, "<C-t>", "<cmd>ToggleTerm<cr>", { desc = "Toggle floating terminal" })
