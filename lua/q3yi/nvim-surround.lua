local M = {
    "kylechui/nvim-surround",
    version = "*",
    -- event = "VeryLazy",
    keys = { "ys", "cs", "ds", "gS", "yS" },
    config = function()
        require("nvim-surround").setup({})
    end
}

return M
