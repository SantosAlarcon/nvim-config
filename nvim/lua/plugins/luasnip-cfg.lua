-- Carga los snippets de VSCode de manera discreta
--Snippets
return {
    "L3MON4D3/LuaSnip",
    dependencies = "rafamadriz/friendly-snippets",
    event = "VeryLazy",
    config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
        require("luasnip.loaders.from_vscode").lazy_load({paths = "~/.config/nvim/snippets"})
        require("luasnip.loaders.from_lua").lazy_load()
    end,
}
