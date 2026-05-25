-- Set diagnostic shortcuts

---@type vim.diagnostic.Opts
local opts = {
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = "‼",
            [vim.diagnostic.severity.WARN] = "!",
            [vim.diagnostic.severity.HINT] = "!",
            [vim.diagnostic.severity.INFO] = "!",
        },
    },
    virtual_text = false,
    virtual_lines = true,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
}

vim.diagnostic.config(opts)

vim.api.nvim_create_user_command("ToggleDiagnostic", function()
    vim.ui.select(
        { "Enable", "Disable", "Virtual Text", "Virtual Line" },
        { prompt = "Choose diagnostic status" },
        function(choice)
            if choice == "Virtual Text" then
                vim.diagnostic.config({ virtual_text = true, virtual_lines = false })
                vim.diagnostic.enable(true)
            elseif choice == "Virtual Line" then
                vim.diagnostic.config({ virtual_lines = { current_line = true }, virtual_text = false })
                vim.diagnostic.enable(true)
            elseif choice == "Disable" then
                vim.diagnostic.enable(false)
            elseif choice == "Enable" then
                vim.diagnostic.config({ virtual_lines = false, virtual_text = false })
                vim.diagnostic.enable(true)
            end
        end
    )
end, { desc = "Choice diagnostic display format" })

vim.keymap.set({ "n", "v", "x" }, "<leader>ud", "<cmd>ToggleDiagnostic<cr>", { desc = "Diagnostic settings" })
