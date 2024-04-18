-- function and plugins to deal with pairs.

local right_parts = "\"')]}>"

---Move cursor out the pairs
local function move_out()
    local unpack = unpack or table.unpack;
    local line, col = unpack(vim.api.nvim_win_get_cursor(0));
    local text = vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]
    if col == text:len() then
        return
    end

    local found = false
    local idx = 1
    for char in string.gmatch(text:sub(col + 1), ".") do
        local pos = right_parts:find(char, 1, true)
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

local M = {
    "echasnovski/mini.pairs",
    version = false,
    event = "InsertEnter",
    config = function()
        require("mini.pairs").setup({})
        vim.keymap.set("i", "<C-e>", move_out, { silent = true })
    end
}

return M
