-- config snacks

local function stop_insert()
    vim.cmd.stopinsert()
end

local M = {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        bigfile = { enabled = true },
        explorer = { enabled = true },
        notifier = { enabled = true },
        toggle = { icon = { enabled = "✓", disabled = "✗" } },
        zen = { enabled = true },
        scope = { enabled = true },
        -- scroll = { enabled = true },
        -- statuscolumn = {},
        quickfile = { enabled = true },
    },

    -- stylua: ignore
    keys = {
        -- buffers
        { "<leader>bb", function() Snacks.picker.buffers({ layout = "select", on_show = stop_insert }) end, desc = "List all buffers" },
        { "<leader>bx", function() Snacks.bufdelete() end, desc = "Delete current buffer" },
        { "<leader>br", function() Snacks.rename() end, desc = "Rename buffer file" },
        { "<leader>bg", function() Snacks.picker.grep_buffers({ cmd = "rg" }) end, desc = "Ripgrep in all open buffers" },
        { "<leader>bd", function() Snacks.picker.diagnostics_buffer({ layout = "select", on_show = stop_insert }) end, desc = "List buffer diagnostics" },

        { "<leader><space>", function() Snacks.picker.smart() end, desc = "Smart Finder" },
        { "<leader>f", function() Snacks.picker.files() end, desc = "Find Files" },
        { "<leader>h", function() Snacks.picker.help() end, desc = "Search help docs" },
        { "<leader>x", function() Snacks.picker.pickers({ layout = "select" }) end, desc = "List all pickers" },
        { "<leader>m", function() Snacks.picker.marks({ on_show = stop_insert }) end, desc = "List all marks" },

        { "<leader>wq", function() Snacks.picker.qflist({ layout = "select", on_show = stop_insert }) end, desc = "List all quickfixes" },
        { "<leader>wd", function() Snacks.picker.diagnostics({ on_show = stop_insert }) end, desc = "List all diagnostics in workspace" },
        { "<leader>wg", function() Snacks.picker.grep({ cmd = "rg" }) end, desc = "Ripgrep in workspace" },

        { "<m-x>", function() Snacks.picker.commands({ layout = "select" }) end, desc = "Run command" },

        -- git keys
        { "<leader>gs", function() Snacks.lazygit.open() end, desc = "Open lazy git" },
        { "<leader>gL", function() Snacks.lazygit.log() end, desc = "Open lazy git log" },
        { "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git branches" },

        -- file explorer
        { "<leader>t", function() Snacks.explorer() end, desc = "File tree" },

        -- floating terminal
        { "<m-t>", function() Snacks.terminal.toggle(nil, { win = { border = "rounded", position = "float" } }) end, desc = "Toggle floating terminal", mode = { "n", "v", "t" } },

        -- undo tree
        { "U", function() Snacks.picker.undo({ on_show = stop_insert }) end, desc = "Snacks undo", mode = { "n", "v" } },

        { "<leader>R", function() Snacks.picker.resume() end, desc = "Resume last picker" },

        -- lsp word
        {
            "]w",
            function()
                if not Snacks.words.is_enabled() then
                    vim.notify("Fail to jump: LSP words disabled.", vim.log.levels.ERROR)
                    return
                end
                Snacks.words.jump(1, true)
            end,
            desc = "Next LSP word",
        },
        {
            "[w",
            function()
                if not Snacks.words.is_enabled() then
                    vim.notify("Fail to jump: LSP words disabled.", vim.log.levels.ERROR)
                    return
                end
                Snacks.words.jump(-1, true)
            end,
            desc = "Next LSP word",
        },
    },
}

---@param toggle snacks.toggle
local function register_toggles(toggle)
    toggle.indent():map("<leader>ug")
    toggle.diagnostics():map("<leader>udd")
    toggle.zen():map("<leader>uz")
    toggle.zoom():map("<leader>uZ")
    toggle.inlay_hints():map("<leader>uh")
    toggle.scroll():map("<leader>uS")
    toggle.words():map("<leader>uW")

    toggle.option("background", { off = "light", on = "dark", name = "Dark background" }):map("<leader>ub")
    toggle.option("list", { name = "Whitespace chars" }):map("<leader>uw")
    toggle.option("wrap", { name = "Line wrap" }):map("<leader>ur")
    toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    toggle.line_number():map("<leader>ul")
    toggle({
        id = "colorcolumn",
        name = "Color column",
        get = function()
            local col = vim.opt.colorcolumn:get()
            if #col > 0 then
                return true
            else
                return false
            end
        end,
        set = function(state)
            if state then
                vim.opt.colorcolumn = { 80, 120 }
            else
                vim.opt.colorcolumn = {}
            end
        end,
    }):map("<leader>uc")

    toggle({
        id = "diagnostic_virtual_text",
        name = "Diagnostic virtual text",
        get = function()
            return vim.g.show_virtual_diagnostic == "text"
        end,
        set = function(state)
            if state then
                vim.g.show_virtual_diagnostic = "text"
            else
                vim.g.show_virtual_diagnostic = "none"
            end
        end,
    }):map("<leader>udt")

    toggle({
        id = "diagnostic_virtual_line",
        name = "Diagnostic virtual line",
        get = function()
            return vim.g.show_virtual_diagnostic == "line"
        end,
        set = function(state)
            if state then
                vim.g.show_virtual_diagnostic = "line"
            else
                vim.g.show_virtual_diagnostic = "none"
            end
        end,
    }):map("<leader>udl")

    toggle({
        id = "auto_im",
        name = "Auto switch IM",
        get = function()
            return vim.g.auto_im_enabled
        end,
        set = function(state)
            vim.g.auto_im_enabled = state
        end,
    }):map("<leader>uC")
end

M.config = function()
    local snacks = require("snacks")
    snacks.setup(M.opts)

    register_toggles(snacks.toggle)
end

M.init = function()
    -- create lsp progress notification
    vim.api.nvim_create_autocmd("LspProgress", {
        ---@param ev {data: {client_id: integer, params: lsp.ProgressParams}}
        callback = function(ev)
            local spinner = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
            vim.notify(vim.lsp.status(), "info", {
                id = "lsp_progress",
                title = "LSP Progress",
                opts = function(notif)
                    notif.icon = ev.data.params.value.kind == "end" and " "
                        or spinner[math.floor(vim.uv.hrtime() / (1e6 * 80)) % #spinner + 1]
                end,
            })
        end,
    })
end

return M
