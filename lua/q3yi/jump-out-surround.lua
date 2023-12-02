-- Quick jump out right surrounds.

local right_surrounds = "\"')]}>"

local function jump_out_surrounds()
    local unpack = unpack or table.unpack;
    local line, col = unpack(vim.api.nvim_win_get_cursor(0));
    local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    if col == text:len() then
        return
    end

    local found = false
    local idx = 1
    for char in string.gmatch(text:sub(col + 1), ".") do
        local pos = right_surrounds:find(char, 1, true)
        if pos then
            found = true
            break
        end
        idx = idx + 1
    end

    if found then
        vim.api.nvim_win_set_cursor(0, { line, col + idx })
    else
        vim.api.nvim_win_set_cursor(0, { line, text:len() })
    end
end

vim.keymap.set("i", "<C-e>", function() jump_out_surrounds() end, { silent = true })
