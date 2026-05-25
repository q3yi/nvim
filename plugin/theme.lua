---@diagnostic disable-next-line: param-type-mismatch
function setup_rose_pine()
    require("rose-pine").setup({
        variant = "auto",
        dark_variant = "main",
        styles = { italic = false },
        highlight_groups = {
            Normal = { bg = "none" },
            NormalNC = { bg = "none" },
            -- StatusLine = { fg = "love", bg = "love", blend = 10 },
            -- StatusLineNC = { fg = "subtle", bg = "surface" },

            Comment = { italic = true },
            ["@markup.italic"] = { italic = true },

            DapBreak = { fg = "love", bg = "love", blend = 10 },
            DapStop = { fg = "gold", bg = "gold", blend = 10 },
        },
    })
end

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("colorscheme.loaded", { clear = true }),
    callback = function()
        if vim.g.colors_name == "rose-pine" then
            setup_rose_pine()
            return
        end
        if vim.g.colors_name == "vague" then return end
        require("q3yi.patch_theme").patch()
    end,
})

vim.cmd.colorscheme("default")
