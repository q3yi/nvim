-- Automatically highlighting other uses of the word under the cursor.

local M = {
    "RRethy/vim-illuminate",
    event = "VeryLazy",
}

function M.config()
    require("illuminate").configure({
        providers = {
            "lsp",
            "treesitter",
        },
        delay = 100,
        filetypes_denylist = {
            "dirbuf",
            "dirvish",
            "fugitive",
            "NvimTree",
        },
        -- large_file_cutoff: number of lines at which to use large_file_config
        -- The `under_cursor` option is disabled when this cutoff is hit
        large_file_cutoff = 10000,
    })

    -- vim.cmd [[hi IlluminatedWordText gui=bold]]
    -- vim.cmd [[hi IlluminatedWordRead gui=bold]]
    -- vim.cmd [[hi IlluminatedWordWrite gui=bold]]
end

return M
