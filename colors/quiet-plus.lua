-- A custom colorscheme that remove most syntax highlights
local palette

if vim.o.background == "dark" then
    palette = {
        bg = "#191724",
        bg_edge = "#100e1a",
        bg_edge2 = "#05040d",
        bg_mid = "#373544",
        bg_mid2 = "#575565",

        fg = "#e0def4",
        fg_edge = "#eae8fe",
        fg_edge2 = "#eeedff",
        fg_mid = "#bcbacf",
        fg_mid2 = "#6e6a86",

        accent = "#e8b3ff",
        accent_bg = "#281733",

        azure = "#86e0ff",
        azure_bg = "#00657f",
        blue = "#9bb8ff",
        blue_bg = "#080061",
        cyan = "#35BF86",
        cyan_bg = "#009890",
        green = "#9FF28F",
        green_bg = "#36c29d",
        orange = "#F47868",
        orange_bg = "#c65970",
        purple = "#540099",
        purple_bg = "#381974", -- not used
        red = "#F22C86",
        red_bg = "#9c337f",
        yellow = "#EFBA5D",
        yellow_bg = "#c26b65"
    }
    require("mini.hues").apply_palette(palette)
    require("q3yi.theme").mini_monochrome(palette, {
        { "Visual", { fg = nil, bg = palette.purple_bg } }
    })
else
    palette = {
        bg = "#FFFFEA",
        bg_edge = "#ffffeb",
        bg_edge2 = "#ffffec",
        bg_mid = "#d1d0bc",
        bg_mid2 = "#a2a28f",

        fg = "#000000",
        fg_edge = "#000000",
        fg_edge2 = "#000000",
        fg_mid = "#262626",
        fg_mid2 = "#4e4e4e",

        accent = "#000037",
        accent_bg = "#EAFFFF",

        azure_bg = "#86e0ff",
        azure = "#00657f",
        blue_bg = "#9bb8ff",
        blue = "#080061",
        cyan_bg = "#35BF86",
        cyan = "#009890",
        green_bg = "#9FF28F",
        green = "#36c29d",
        orange_bg = "#F47868",
        orange = "#c65970",
        purple_bg = "#540099",
        purple = "#381974",
        red_bg = "#F22C86",
        red = "#A5222F",
        yellow_bg = "#EFBA5D",
        yellow = "#c26b65"
    }
    require("mini.hues").apply_palette(palette)
    require("q3yi.theme").mini_monochrome(palette, {
        { "String", { fg = palette.red, bg = nil } },
        { "Visual", { fg = nil, bg = palette.yellow_bg } }
    })
end

vim.g.colors_name = "quiet-plus"
