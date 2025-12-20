-- custom theme

local M = {}
local function hi(name, val) vim.api.nvim_set_hl(0, name, val) end

local syntax_groups = {
    "Boolean",
    "Character",
    -- "Comment",
    "Conditional",
    "Constant",
    "Debug",
    "Define",
    "Delimiter",
    "Error",
    "Exception",
    "Float",
    "Function",
    "Identifier",
    "Ignore",
    "Include",
    "Keyword",
    "Label",
    "Macro",
    "Number",
    "Operator",
    "PreCondit",
    "PreProc",
    "Repeat",
    "Special",
    "SpecialChar",
    "SpecialComment",
    "Statement",
    "StorageClass",
    -- "String",
    "Structure",
    "Tag",
    "Type",
    "Typedef",
}

local function remove_syntax_highlights()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal", link = false })
    for _, group in ipairs(syntax_groups) do
        local exists = vim.api.nvim_get_hl(0, { name = group })
        if not exists.link then
            exists.fg = normal.fg
            hi(group, exists)
        end
    end
end

local patches = {
    Comment                  = { "PATCH", { italic = true } },
    Normal                   = { "PATCH", { bg = "NONE" } },
    FloatBorder              = { "REPLACE", { link = "NormalFloat" } },
    FloatTitle               = { "NormalFloat", { bold = true } },
    CursorLineNr             = { "PATCH", { bg = "NONE", bold = true } },

    DiagnosticUnderlineError = { "PATCH", { undercurl = true } },
    DiagnosticUnderlineHint  = { "PATCH", { undercurl = true } },
    DiagnosticUnderlineInfo  = { "PATCH", { undercurl = true } },
    DiagnosticUnderlineOk    = { "PATCH", { undercurl = true } },
    DiagnosticUnderlineWarn  = { "PATCH", { undercurl = true } },

    MiniPickPrompt           = { "NormalFloat", { bold = true } },
}

function M.patch()
    if vim.g.colors_name == "default" then
        remove_syntax_highlights()
        if vim.o.background == "light" then
            hi("NormalFloat", { bg = "#EAFFFF" })
            hi("String", { fg = "#A5222F" })
            hi("StatusLine", { fg = "#14161b", bg = "#8888CC" })
            hi("StatusLineNC", { fg = "#2C2E33", bg = "#EAFFFF" })
            hi("Visual", { bg = "#eeee9e" })
        else
            hi("String", { fg = "#f6c177" })
            hi("StatusLine", { fg = "#E0E2EA", bg = "#3A0F2F" })
            hi("StatusLineNC", { fg = "#C4C6CD", bg = "#1A141D" })
        end
    end

    for group, patch in pairs(patches) do
        if patch[1] == "PATCH" then
            local exists = vim.api.nvim_get_hl(0, { name = group })
            hi(group, vim.tbl_extend("force", exists, patch[2]))
        elseif patch[1] == "REPLACE" then
            hi(group, patch[2])
        else
            local exists = vim.api.nvim_get_hl(0, { name = patch[1], link = false })
            hi(group, vim.tbl_extend("force", exists, patch[2]))
        end
    end
end

return M
