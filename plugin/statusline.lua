-- config status line.

local modes = {
    ["n"] = " NOR ",
    ["v"] = " VIS ",
    ["V"] = " V-L ",
    [""] = " V-B ",
    ["s"] = " SEL ",
    ["S"] = " S-L ",
    [""] = " S-B ",
    ["i"] = " INS ",
    ["R"] = " REP ", -- replace
    ["c"] = " CMD ",
    ["r"] = " PPT ", -- prompt
    ["!"] = " EXE ", -- shell or external command running
    ["t"] = " TER ", -- terminal
}

---@return string
function _G.render_statusline()
    local winid = vim.g.statusline_winid
    local curwin = vim.api.nvim_get_current_win()

    if winid == curwin then
        local mode_str = modes[vim.fn.mode()] or " UFO "

        return table.concat({
            "%",
            mode_str,
            " %f %h%w%m%r ",
            "%=",
            "%{% &showcmdloc == 'statusline' ? '%-10.S ' : '' %}",
            "%{% exists('b:keymap_name') ? '<'..b:keymap_name..'> ' : '' %}",
            "%{% &busy > 0 ? '◐ ' : '' %}",
            package.loaded["vim.diagnostic"] and vim.diagnostic.status() .. " " or " ",
            "%y %l:%c %P",
        })
    else
        return "% ***  %f %h%w%m%r %=%y"
    end
end

vim.opt.statusline = "%!v:lua.render_statusline()"
