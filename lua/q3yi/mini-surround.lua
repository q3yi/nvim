-- mini.surround

local M = {
    "echasnovski/mini.surround",
    version = false,
    keys = {"sa", "sd", "sf", "sF", "sh", "sr", "sn"},
    config = function ()
        require("mini.surround").setup()
    end
}

return M
