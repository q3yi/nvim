-- Miscellaneous functions and commands

local function set_tab_width(param)
    if param.args == "" then
        vim.print("Tab width: " .. vim.o.shiftwidth)
        return
    end

    local size = tonumber(param.args) or 4
    vim.opt.shiftwidth = size
    vim.opt.tabstop = size
    vim.opt.softtabstop = size

    vim.print("Tab width: " .. size)
end

-- Create command to change tab width
vim.api.nvim_create_user_command("TabWidth", set_tab_width, { nargs = "?", desc = "Change tab width." })

-- Highlight text copied when yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.hl.on_yank()
    end,
    group = highlight_group,
    pattern = "*",
})

-- Update packages with command
vim.api.nvim_create_user_command("PackUpdate", function(param)
    if #param.fargs ~= 0 then
        vim.pack.update(param.fargs)
        return
    end
    vim.pack.update()
end, { nargs = "*", desc = "Update plugins" })

-- Async make
vim.api.nvim_create_user_command("Make", function(_param)
    local lines = {}
    local makeprg = vim.bo.makeprg
    if not makeprg or makeprg == "" then
        vim.notify("makeprg not set.", vim.log.levels.WARN)
        return
    end

    local cmd = vim.fn.expandcmd(makeprg)

    vim.fn.jobstart(cmd, {
        stdout_buffered = true,
        stderr_buffered = true,
        on_stdout = function(_, data)
            if data then for _, line in ipairs(data) do table.insert(lines, line) end end
        end,
        on_stderr = function(_, data)
            if data then for _, line in ipairs(data) do table.insert(lines, line) end end
        end,
        on_exit = function(_, exit_code)
            vim.fn.setqflist({}, "r", {
                title = cmd,
                lines = lines,
                efm = vim.bo.errorformat
            })

            if exit_code == 0 then
                vim.notify("make successfully.", vim.log.levels.INFO)
                vim.cmd("cclose")
            else
                vim.cmd("copen")
            end
        end
    })
end, { desc = "Async make" })
