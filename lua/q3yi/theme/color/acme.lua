-- Custom plan9 acme theme color for dayfox.

local palette = {
    white = "#FFFFFF",
    black = "#000000",

    apricot_white = "#FFFFEA",
    white_rock = "#ECECD9",
    primrose = "#EEEE9E",
    olive = "#B7B75B",
    dew = "#EAFFFF",
    blizzard = "#AEEEEE",
    portage = "#8CAAE6",
    blue_bell = "#8888CC",
    amethyst = "#9866C2",

    stiletto = "#A0342F",
    san_felix = "#065905",

    tuatara = "#393934",
    silver = "#AAAAAA",

    mexican_red = "#A5222F",
    an_chico = "#955F61",
    chelsea_gem = "#AC5402",
    killarney = "#396847",
    governor_bay = "#2848A9",
}

local spec = {
    bg0    = palette.dew,           -- Dark bg (status line and float)
    bg1    = palette.apricot_white, -- Default bg
    bg2    = palette.white_rock,    -- Lighter bg (colorcolm folds)
    bg3    = palette.blue_bell,     -- Lighter bg (cursor line)
    bg4    = palette.black,         -- Conceal, border fg

    fg0    = palette.tuatara,       -- Lighter fg
    fg1    = palette.black,         -- Default fg
    fg2    = palette.black,         -- Darker fg (status line)
    fg3    = palette.silver,        -- Darker fg (line numbers, fold colums)

    sel0   = palette.primrose,      -- Popup bg, visual selection bg
    sel1   = palette.amethyst,      -- Popup sel bg, search bg

    syntax = {
        bracket     = palette.black,     -- Brackets and Punctuation
        builtin0    = palette.black,     -- Builtin variable
        builtin1    = palette.black,     -- Builtin type
        builtin2    = palette.black,     -- Builtin const
        builtin3    = palette.black,     -- Not used
        comment     = palette.san_felix, -- Comment
        conditional = palette.black,     -- Conditional and loop
        const       = palette.black,     -- Constants, imports and booleans
        dep         = palette.black,     -- Deprecated
        field       = palette.black,     -- Field
        func        = palette.black,     -- Functions and Titles
        ident       = palette.black,     -- Identifiers
        keyword     = palette.black,     -- Keywords
        number      = palette.black,     -- Numbers
        operator    = palette.black,     -- Operators
        preproc     = palette.black,     -- PreProc
        regex       = palette.black,     -- Regex
        statement   = palette.black,     -- Statements
        string      = palette.stiletto,  -- Strings
        type        = palette.black,     -- Types
        variable    = palette.black,     -- Variables
    },

    diag   = {
        error = palette.mexican_red,
        warn  = palette.chelsea_gem,
        info  = palette.governor_bay,
        hint  = palette.killarney,
        ok    = palette.killarney,
    },

    git    = {
        add      = palette.killarney,
        removed  = palette.mexican_red,
        changed  = palette.chelsea_gem,
        conflict = palette.an_chico,
        ignored  = palette.silver,
    }
}

local M = {}

function M.apply(opts)
    local overrides = {
        palettes = {
            dayfox = palette,
        },
        specs = {
            dayfox = spec,
        },
    }

    return vim.tbl_deep_extend("force", opts, overrides)
end

return M
