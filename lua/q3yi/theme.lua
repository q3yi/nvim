-- custom theme

local M = {}

local function hi(name, val) vim.api.nvim_set_hl(0, name, val) end

function M.mini_monochrome(p, extra)
    hi("Normal", { fg = p.fg, bg = nil })
    hi("FloatBorder", { link = "NormalFloat" })
    -- hi("Visual", { fg = nil, bg = p.bg_mid2 })
    -- hi("VisualNOS", { fg = nil, bg = p.bg_mid })

    hi("DapBreak", { fg = p.red, bg = p.red, blend = 10 })
    hi("DapStop", { fg = p.yellow, bg = p.yellow, blend = 10 })

    hi("DiagnosticUnderlineError", { fg = nil, bg = nil, sp = p.red, undercurl = true })
    hi("DiagnosticUnderlineHint", { fg = nil, bg = nil, sp = p.cyan, undercurl = true })
    hi("DiagnosticUnderlineInfo", { fg = nil, bg = nil, sp = p.blue, undercurl = true })
    hi("DiagnosticUnderlineOk", { fg = nil, bg = nil, sp = p.green, undercurl = true })
    hi("DiagnosticUnderlineWarn", { fg = nil, bg = nil, sp = p.yellow, undercurl = true })

    hi("Boolean", { link = "Constant" })
    hi("Character", { link = "Constant" })
    hi("Comment", { fg = p.fg_mid2, bg = nil, italic = true })
    hi("Conditional", { link = "Statement" })
    hi("Constant", { fg = p.fg, bg = nil })
    hi("Debug", { link = "Special" })
    hi("Define", { link = "PreProc" })
    hi("Delimiter", { fg = p.fg, bg = nil })
    hi("Error", { fg = nil, bg = p.red_bg })
    hi("Exception", { link = "Statement" })
    hi("Float", { link = "Constant" })
    hi("Function", { fg = p.fg, bg = nil })
    hi("Identifier", { fg = p.fg, bg = nil })
    hi("Ignore", { fg = nil, bg = nil })
    hi("Include", { link = "PreProc" })
    hi("Keyword", { link = "Statement" })
    hi("Label", { link = "Statement" })
    hi("Macro", { link = "PreProc" })
    hi("Number", { link = "Constant" })
    hi("Operator", { fg = p.fg, bg = nil })
    hi("PreCondit", { link = "PreProc" })
    hi("PreProc", { fg = p.fg, bg = nil })
    hi("Repeat", { link = "Statement" })
    hi("Special", { fg = p.fg, bg = nil })
    hi("SpecialChar", { link = "Special" })
    hi("SpecialComment", { link = "Special" })
    hi("Statement", { fg = p.fg, bg = nil, bold = true })
    hi("StorageClass", { link = "Type" })
    hi("String", { fg = p.yellow, bg = nil })
    hi("Structure", { link = "Type" })
    hi("Tag", { link = "Special" })
    hi("Type", { fg = p.fg, bg = nil })
    hi("Typedef", { link = "Type" })

    hi("@parameter", { fg = p.fg, bg = nil })
    hi("@keyword.return", { fg = p.fg, bg = nil, bold = true })
    hi("@variable", { fg = p.fg, bg = nil })
    hi("@keyword.import", { fg = p.fg, bg = nil, bold = true })
    hi("@keyword.debug", { fg = p.fg, bg = nil, bold = true })
    hi("@keyword.directive", { fg = p.fg, bg = nil, bold = true })

    if extra ~= nil then
        for _, hl in ipairs(extra) do
            hi(hl[1], hl[2])
        end
    end
end

return M
