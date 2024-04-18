-- config language server and formattor

require("q3yi.lsp.autoformat").setup()

return {
    require("q3yi.lsp.lsp-config"),
    require("q3yi.lsp.none-lsp"),
}
