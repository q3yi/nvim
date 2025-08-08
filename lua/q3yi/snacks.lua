-- config snacks

local function stop_insert()
    vim.cmd.stopinsert()
end

---@param toggle snacks.toggle
local function register_toggles(toggle)
    toggle.indent():map("<leader>ug")
    toggle.diagnostics():map("<leader>ud")
    toggle.zen():map("<leader>uz")
    toggle.zoom():map("<leader>uZ")
    toggle.inlay_hints():map("<leader>uh")
    toggle.scroll():map("<leader>uS")
    toggle.words():map("<leader>uW")

    toggle.option("background", { off = "light", on = "dark", name = "dark background" }):map("<leader>ub")
    toggle.option("list", { name = "whitespace chars" }):map("<leader>uw")
    toggle.option("wrap", { name = "line wrap" }):map("<leader>ur")
    toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")
    toggle.line_number():map("<leader>ul")
    toggle({
        id = "colorcolumn",
        name = "color column",
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
    }, nil):map("<leader>uc")

    toggle({
        id = "diagnostic_virtual_text",
        name = "diagnostic virtual text",
        get = function()
            return vim.g.diagnostic_show_virtual_text
        end,
        set = function(state)
            vim.g.diagnostic_show_virtual_text = state
        end,
    }):map("<leader>uD")
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
        styles = {
            notification = { border = "single" },
            notification_history = { border = "single" },
        },
        -- scroll = { enabled = true },
        -- statuscolumn = {},
        quickfile = { enabled = true },
        picker = {
            matcher = { frecency = true },
            layouts = {
                default = {
                    layout = {
                        box = "horizontal",
                        width = 0.8,
                        min_width = 120,
                        height = 0.8,
                        {
                            box = "vertical",
                            border = "single",
                            title = "{title} {live} {flags}",
                            { win = "input", height = 1, border = "bottom" },
                            { win = "list", border = "none" },
                        },
                        { win = "preview", title = "{preview}", border = "single", width = 0.5 },
                    },
                },
                dropdown = {
                    layout = {
                        backdrop = false,
                        row = 1,
                        width = 0.4,
                        min_width = 80,
                        height = 0.8,
                        border = "none",
                        box = "vertical",
                        { win = "preview", title = "{preview}", height = 0.4, border = "single" },
                        {
                            box = "vertical",
                            border = "rounded",
                            title = "{title} {live} {flags}",
                            title_pos = "center",
                            { win = "input", height = 1, border = "bottom" },
                            { win = "list", border = "none" },
                        },
                    },
                },
                sidebar = {
                    preview = "main",
                    layout = {
                        backdrop = false,
                        width = 40,
                        min_width = 40,
                        height = 0,
                        position = "left",
                        border = "none",
                        box = "vertical",
                        {
                            win = "input",
                            height = 1,
                            border = "single",
                            title = "{title} {live} {flags}",
                            title_pos = "center",
                        },
                        { win = "list", border = "none" },
                        { win = "preview", title = "{preview}", height = 0.4, border = "top" },
                    },
                },
                select = {
                    preview = false,
                    layout = {
                        backdrop = false,
                        width = 0.5,
                        min_width = 80,
                        height = 0.4,
                        min_height = 3,
                        box = "vertical",
                        border = "single",
                        title = "{title}",
                        title_pos = "center",
                        { win = "input", height = 1, border = "bottom" },
                        { win = "list", border = "none" },
                        { win = "preview", title = "{preview}", height = 0.4, border = "top" },
                    },
                },
                vertical = {
                    layout = {
                        backdrop = false,
                        width = 0.5,
                        min_width = 80,
                        height = 0.8,
                        min_height = 30,
                        box = "vertical",
                        border = "single",
                        title = "{title} {live} {flags}",
                        title_pos = "center",
                        { win = "input", height = 1, border = "bottom" },
                        { win = "list", border = "none" },
                        { win = "preview", title = "{preview}", height = 0.4, border = "top" },
                    },
                },
            },
        },
    },
    keys = {
        -- buffers
        {
            "<leader>bb",
            function()
                Snacks.picker.buffers({ layout = "select", on_show = stop_insert })
            end,
            desc = "List all buffers",
        },
        {
            "<leader>bd",
            function()
                Snacks.bufdelete()
            end,
            desc = "Delete current buffer",
        },
        {
            "<leader>br",
            function()
                Snacks.rename()
            end,
            desc = "Rename buffer file",
        },
        {
            "<leader>bg",
            function()
                Snacks.picker.grep_buffers({ cmd = "rg" })
            end,
            desc = "Ripgrep in all open buffers",
        },
        {
            "<leader>f",
            function()
                Snacks.picker.files()
            end,
            desc = "Find Files",
        },

        {
            "<leader>h",
            function()
                Snacks.picker.help()
            end,
            desc = "Search help docs",
        },
        {
            "<leader>x",
            function()
                Snacks.picker.pickers({ layout = "select" })
            end,
            desc = "List all pickers",
        },
        {
            "<leader>m",
            function()
                Snacks.picker.marks({ on_show = stop_insert })
            end,
            desc = "List all marks",
        },
        {
            "<leader>q",
            function()
                Snacks.picker.qflist({ layout = "select", on_show = stop_insert })
            end,
            desc = "List all quickfixes",
        },
        {
            "<leader>dl",
            function()
                Snacks.picker.diagnostics_buffer({ layout = "select", on_show = stop_insert })
            end,
            desc = "List all diagnostics in buffer",
        },

        {
            "<leader>wd",
            function()
                Snacks.picker.diagnostics({ on_show = stop_insert })
            end,
            desc = "List all diagnostics in workspace",
        },
        {
            "<leader>wg",
            function()
                Snacks.picker.grep({ cmd = "rg" })
            end,
            desc = "Ripgrep in workspace",
        },

        {
            "<m-x>",
            function()
                Snacks.picker.commands({ layout = "select" })
            end,
            desc = "Run command",
        },

        -- git keys
        {
            "<leader>gs",
            function()
                Snacks.lazygit.open()
            end,
            desc = "Open lazy git",
        },
        {
            "<leader>gL",
            function()
                Snacks.lazygit.log()
            end,
            desc = "Open lazy git log",
        },
        {
            "<leader>gb",
            function()
                Snacks.picker.git_branches()
            end,
            desc = "Git branches",
        },

        -- file explorer
        {
            "<leader>t",
            function()
                Snacks.explorer()
            end,
            desc = "File tree",
        },

        -- floating terminal
        {
            "<m-t>",
            function()
                Snacks.terminal.toggle(nil, {
                    win = {
                        border = "single",
                        position = "float",
                    },
                })
            end,
            desc = "Toggle floating terminal",
            mode = { "n", "v", "t" },
        },

        -- undo tree
        {
            "U",
            function()
                Snacks.picker.undo({ on_show = stop_insert })
            end,
            desc = "Snacks undo",
            mode = { "n", "v" },
        },

        {
            "<leader>R",
            function()
                Snacks.picker.resume()
            end,
            desc = "Resume last picker",
        },

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
