-- Mason
return {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    dependencies = "williamboman/mason-lspconfig.nvim",
    config = function()
        require("mason").setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        require("mason-lspconfig").setup({
            ensure_installed = {
                --"tsserver",
                --"cssls",
                --"html",
                "jsonls",
                --"pyright",
                "lua_ls",
                --"emmet_ls",
                --"prettierd",
                --"eslint_d",
                --"tailwindcss",
            },
            automatic_installation = true,
        })
    end,
}
