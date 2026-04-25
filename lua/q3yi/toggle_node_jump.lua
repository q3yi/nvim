-- Toggle jump between current treesitter node's start and end positions

local M = {}

--- Jump between treesitter node
function M.node_jump()
    local node = vim.treesitter.get_node()
    if not node then return end

    local srow, scol, erow, ecol = node:range()
    local cur = vim.api.nvim_win_get_cursor(0)

    local last_row, last_col
    if ecol == 0 then
        last_row = erow - 1
        local line = vim.api.nvim_buf_get_lines(0, last_row, last_row + 1, false)[1] or ""
        last_col = math.max(0, #line - 1)
    else
        last_row = erow
        last_col = ecol - 1
    end

    local at_last = (cur[1] - 1 == last_row) and (cur[2] == last_col)

    if at_last then
        vim.api.nvim_win_set_cursor(0, { srow + 1, scol })
    else
        vim.api.nvim_win_set_cursor(0, { last_row + 1, last_col })
    end
end

return M
