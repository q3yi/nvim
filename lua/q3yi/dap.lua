-- Configurate debugger

local M = {
    "mfussenegger/nvim-dap",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
    },
    cmd = { "DapToggleBreakpoint" },
}

---@type table<string, dap.Adapter>
local _adapters = {}

---@type table<string, dap.Configuration>
local _configurations = {}

---@param key string
function M.alreadyConfigurated(key)
    if _adapters[key] ~= nil then
        return true
    end

    if _configurations[key] ~= nil then
        return true
    end

    return false
end

---@param id string
---@param adapter dap.Adapter
function M.setAdapter(id, adapter)
    _adapters[id] = adapter
end

---@param filetype string
---@param configuration []dap.Configuration
function M.addConfigurations(filetype, configurations)
    if _configurations[filetype] == nil then
        _configurations[filetype] = {}
    end

    for _, cfg in ipairs(configurations) do
        table.insert(_configurations[filetype], cfg)
    end
end

---@type table<string, fun(): dap.Configuration>
local debugProfileFactory = {}

---@param filetype string
---@param creator fun(): dap.Configuration
function M.setDebugProfileCreator(filetype, creator)
    debugProfileFactory[filetype] = creator
end

function M.config()
    local dap = require("dap")
    local dapui = require("dapui")

    dap.adapters = _adapters
    dap.configurations = _configurations

    dapui.setup()
end

local function addDebugProfile()
    local filetype = vim.bo.filetype
    if debugProfileFactory[filetype] == nil then
        vim.notify("unsupported filetype: " .. filetype, vim.log.levels.WARN)
        return
    end

    local profile = debugProfileFactory[filetype]()
    if profile == nil then
        vim.notify("empty profile, ignored", vim.log.levels.WARN)
        return
    end

    local dap = require("dap")
    table.insert(dap.configurations[filetype], profile)

    vim.notify("New debug profile added.", vim.log.levels.INFO)
end

local function enableDebugger()
    vim.g.debug_ui_enabled = true

    local dap = require("dap")
    local dapui = require("dapui")

    vim.keymap.set("n", "<F3>", dap.continue, { desc = "Debugger: Start/Continue" })
    vim.keymap.set("n", "<F4>", dap.run_to_cursor, { desc = "Debugger: Run to cursor" })
    vim.keymap.set("n", "<F5>", dap.step_over, { desc = "Debugger: Step over" })
    vim.keymap.set("n", "<F6>", dap.step_into, { desc = "Debugger: Step into" })
    vim.keymap.set("n", "<F7>", dap.step_out, { desc = "Debugger: Step out" })
    vim.keymap.set("n", "<F11>", dap.restart, { desc = "Debugger: Restart" })

    dapui.open()
end

local function disableDebugger()
    vim.g.debug_ui_enabled = false

    vim.keymap.del("n", "<F3>")
    vim.keymap.del("n", "<F4>")
    vim.keymap.del("n", "<F5>")
    vim.keymap.del("n", "<F6>")
    vim.keymap.del("n", "<F7>")
    vim.keymap.del("n", "<F11>")

    require("dapui").close()
end

local function toggleDebugger()
    if vim.g.debug_ui_enabled then
        disableDebugger()
        return
    end

    local dap = require("dap")
    local filetype = vim.bo.filetype
    if dap.configurations[filetype] == nil then
        vim.notify("unsupported filetype: " .. filetype, vim.log.levels.WARN)
        return
    end

    enableDebugger()
end

function M.init()
    vim.keymap.set("n", "<Leader>dD", toggleDebugger, { desc = "Toggle debug UI" })
    vim.keymap.set("n", "<Leader>db", "<cmd>DapToggleBreakpoint<cr>", { desc = "Toggle breakpoint" })
    vim.keymap.set("n", "<Leader>dB", function()
        require("dap").toggle_breakpoint(vim.fn.input("Breakpoint condition: "))
    end, { desc = "Toggle condtional breakpoint" })
    vim.keymap.set("n", "<Leader>dp", addDebugProfile, { desc = "Add debug profile" })
end

return M
