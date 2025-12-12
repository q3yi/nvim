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
