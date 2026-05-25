-- Config treesitter

local languages = {
    "bash",
    "c",
    "c_sharp",
    "cpp",
    "css",
    "dockerfile",
    "fish",
    "gitignore",
    "go",
    "gomod",
    "gosum",
    "html",
    "javascript",
    "json",
    "lua",
    "mermaid",
    "make",
    "markdown",
    "markdown_inline",
    "python",
    "rust",
    "tsx",
    "typescript",
    "typst",
    "toml",
    "yaml",
    "zig",
}

require("tree-sitter-manager").setup({
    ensure_installed = languages,
    auto_install = true,
    border = "single",
})

-- ts_move move by treesiiter object
--
---@param query_string string|string[]
---@param forward boolean
local function ts_move(query_string, forward)
    local ts = require("nvim-treesitter-textobjects.move")
    local fn = forward and ts.goto_next_start or ts.goto_previous_start
    fn(query_string, "textobjects")
end

local mode = { "n", "x", "o" }

vim.keymap.set(mode, "]a", function() ts_move("@parameter.inner", true) end, { desc = "Next argument" })
vim.keymap.set(mode, "[a", function() ts_move("@parameter.inner", false) end, { desc = "Next argument" })
vim.keymap.set(mode, "]f", function() ts_move("@function.outer", true) end, { desc = "Next function" })
vim.keymap.set(mode, "[f", function() ts_move("@function.outer", false) end, { desc = "Previous function" })
vim.keymap.set(mode, "]c", function() ts_move("@class.outer", true) end, { desc = "Next class" })
vim.keymap.set(mode, "[c", function() ts_move("@class.outer", false) end, { desc = "Previous class" })
