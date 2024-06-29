-- Custom helix theme color for nightfox.

local palette = {
    white = "#FFFFFF",
    lilac = "#DBBFEF",
    lavender = "#A4A0E8",
    comet = "#5A5977",
    bossanova = "#452859",
    midnight = "#3B224C",
    revolver = "#281733",

    silver = "#CCCCCC",
    sirocco = "#697C81",
    mint = "#9FF28F",
    almond = "#ECCDBA",
    chamois = "#E8DCA0",
    honey = "#EFBA5D",

    purple = "#540099",
    amethyst = "#9866C2",

    violet_red = "#F22C86",
    shamrock = "#35BF86",
    apricot = "#F47868",
    lightning = "#FFCD1C",
    delta = "#6F44F0",
}

local spec = {
    bg0 = palette.revolver, -- Dark bg (status line and float)
    bg1 = palette.midnight, -- Default bg
    bg2 = palette.bossanova, -- Lighter bg (colorcolm folds)
    bg3 = palette.bossanova, -- Lighter bg (cursor line)
    bg4 = palette.comet, -- Conceal, border fg

    fg0 = palette.white, -- Lighter fg
    fg1 = palette.lavender, -- Default fg
    fg2 = palette.lilac, -- Darker fg (status line)
    fg3 = palette.comet, -- Darker fg (line numbers, fold colums)

    sel0 = palette.purple, -- Popup bg, visual selection bg
    sel1 = palette.amethyst, -- Popup sel bg, search bg

    syntax = {
        bracket = palette.lavender, -- Brackets and Punctuation
        builtin0 = palette.apricot, -- Builtin variable
        builtin1 = palette.lilac, -- Builtin type
        builtin2 = palette.white, -- Builtin const
        builtin3 = palette.apricot, -- Not used
        comment = palette.sirocco, -- Comment
        conditional = palette.almond, -- Conditional and loop
        const = palette.white, -- Constants, imports and booleans
        dep = palette.comet, -- Deprecated
        field = palette.white, -- Field
        func = palette.white, -- Functions and Titles
        ident = palette.almond, -- Identifiers
        keyword = palette.almond, -- Keywords
        number = palette.chamois, -- Numbers
        operator = palette.lilac, -- Operators
        preproc = palette.apricot, -- PreProc
        regex = palette.honey, -- Regex
        statement = palette.almond, -- Statements
        string = palette.silver, -- Strings
        type = palette.lilac, -- Types
        variable = palette.lavender, -- Variables
    },

    diag = {
        error = palette.violet_red,
        warn = palette.lightning,
        info = palette.delta,
        hint = palette.shamrock,
        ok = palette.shamrock,
    },

    git = {
        add = palette.shamrock,
        removed = palette.violet_red,
        changed = palette.delta,
        conflict = palette.lightning,
        ignored = palette.silver,
    },
}

local M = {}

function M.apply(opts)
    local overrides = {
        palettes = {
            nightfox = palette,
        },
        specs = {
            nightfox = spec,
        },
    }

    return vim.tbl_deep_extend("force", opts, overrides)
end

return M
