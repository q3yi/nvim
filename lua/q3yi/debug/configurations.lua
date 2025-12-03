-- Dap configurations

---@return []string
local function inputArguments()
    return vim.split(vim.fn.input("Arguments: "), " +")
end

local go = {
    {
        type = "delve",
        name = "Debug",
        request = "launch",
        program = "${file}",
    },
    {
        type = "delve",
        name = "Debug with args",
        request = "launch",
        program = "${file}",
        args = inputArguments,
    },
    {
        type = "delve",
        name = "Debug test", -- configuration for debugging test files
        request = "launch",
        mode = "test",
        program = "${file}",
    },
    {
        type = "delve",
        name = "Debug test (go.mod)",
        request = "launch",
        mode = "test",
        program = "./${relativeFileDirname}",
    },
}

local zig = {
    {
        name = "Run Program (gdb)",
        type = "gdb",
        request = "launch",
        program = function()
            local workspace = vim.fn.getcwd()
            return workspace .. "/zig-out/bin/" .. vim.fs.basename(workspace)
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = false,
    },
    {
        name = "Run Program (lldb)",
        type = "lldb",
        request = "launch",
        program = function()
            local workspace = vim.fn.getcwd()
            return workspace .. "/zig-out/bin/" .. vim.fs.basename(workspace)
        end,
        cwd = "${workspaceFolder}",
        env = function()
            local variables = {}
            for k, v in pairs(vim.fn.environ()) do
                table.insert(variables, string.format("%s=%s", k, v))
            end
            return variables
        end,
    },
}

return {
    go = go,
    zig = zig,
}
