-- config debugger
if package.loaded["q3yi.dap"] ~= nil then
    local dap_cfg = require("q3yi.dap")
    if not dap_cfg.alreadyConfigurated("gdb") then
        dap_cfg.setAdapter("gdb", {
            type = "executable",
            command = "gdb",
            args = { "--interpreter=dap" },
        })
    end

    if not dap_cfg.alreadyConfigurated("zig") then
        dap_cfg.addConfigurations("zig", {
            {
                name = "Run Program (Without args)",
                type = "gdb",
                request = "launch",
                program = function()
                    local workspace = vim.fn.getcwd()
                    return workspace .. "/zig-out/bin/" .. vim.fs.basename(workspace)
                end,
                cwd = "${workspaceFolder}",
                stopOnEntry = false,
            },
        })

        dap_cfg.setDebugProfileCreator("zig", function()
            local input_args = vim.split(vim.fn.input("Program: ", vim.fn.getcwd() .. "/zig-out/bin/", "file"), " +")
            local cmd = input_args[1]
            local args = {}
            if #input_args ~= 1 then
                args = { unpack(input_args, 2, #input_args) }
            end

            return {
                type = "gdb",
                name = "Debug " .. vim.fs.basename(cmd),
                request = "launch",
                program = cmd,
                args = args,
            }
        end)
    end
end
