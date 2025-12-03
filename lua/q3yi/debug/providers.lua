-- Dap configuration providers

---@return dap.Configuration
local function zigProvider()
    local input_args = vim.split(vim.fn.input("Program: ", vim.fn.getcwd() .. "/zig-out/bin/", "file"), " +")
    local cmd = input_args[1]
    local args = {}
    if #input_args ~= 1 then
        args = { unpack(input_args, 2, #input_args) }
    end

    local name = "Debug " .. vim.fs.basename(cmd) .. " " .. table.concat(args, " ")
    if string.len(name) > 40 then
        name = string.sub(name, 1, 37) .. "..."
    end

    return {
        type = "gdb",
        name = name,
        request = "launch",
        program = cmd,
        args = args,
    }
end

---@type table<string, fun():dap.Configuration>
return {
    zig = zigProvider,
}
