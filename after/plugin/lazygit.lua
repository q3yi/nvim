--- Open lazygit in a floating window

---@param command string[]
local function open_float_with_command(command)
    if #command == 0 or vim.fn.executable(command[1] or "") == 0 then
        vim.notify("Command not found: " .. command[1] or "empty", vim.log.levels.ERROR)
        return
    end

    local width = vim.o.columns
    local height = vim.o.lines
    if width < 40 or height < 30 then
        vim.notify("Not enough space to show panel", vim.log.levels.ERROR)
        return
    end

    local float_opts = {
        relative = "editor",
        width = width,
        height = height - 2,
        col = 0,
        row = 0,
        style = "minimal",
        border = "none",
    }

    local buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buflisted = false

    local win = vim.api.nvim_open_win(buf, true, float_opts)

    local job_id = vim.fn.jobstart(command, {
        term = true,
        pty = true,
        stdout_buffered = true,
        term_name = command[1],
        on_exit = function(_id, _data, _event)
            if vim.api.nvim_win_is_valid(win) then
                vim.api.nvim_win_close(win, true)
            end

            if vim.api.nvim_buf_is_valid(buf) then
                vim.api.nvim_buf_delete(buf, { force = true })
            end
        end,

    })

    if job_id == -1 or job_id == 0 then
        if vim.api.nvim_win_is_valid(win) then
            vim.api.nvim_win_close(win, true)
        end
        if vim.api.nvim_buf_is_valid(buf) then
            vim.api.nvim_buf_delete(buf, { force = true })
        end
        vim.notify("Fail to run command: " .. command[1], vim.log.levels.ERROR)
        return
    end

    vim.api.nvim_set_current_win(win)
    vim.cmd("startinsert")
end

vim.api.nvim_create_user_command("Lazygit", function(args)
    if args.args == "log" then
        open_float_with_command({ "lazygit", "log" })
        return
    end
    open_float_with_command({ "lazygit" })
end, { nargs = "?", desc = "Open lazygit" })

vim.keymap.set({ "n", "v" }, "<leader>gs", "<cmd>Lazygit<cr>", { desc = "Git status" })
vim.keymap.set({ "n", "v" }, "<leader>gl", "<cmd>Lazygit log<cr>", { desc = "Git logs" })
