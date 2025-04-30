-- Null LS (Resaltado de sintaxis)

return {
    "nvimtools/none-ls.nvim",
    event = "BufRead",
    config = function()
        local null_ls = require("null-ls")

        local diagnostics = null_ls.builtins.diagnostics
        local formatting = null_ls.builtins.formatting
        local actions = null_ls.builtins.code_actions

        null_ls.setup({
            debug = false,
            sources = {
                --Formateador del Prettier
                --formatting.prettierd.with { extra_args = { "--no-semi", "--double-quotes" }, disabled_filetypes = { "markdown" } },
                formatting.biome,

                --Formateador para Lua
                formatting.stylua,

                --Formateador Markdown
                formatting.markdownlint,

                --Formateador para Python
                formatting.black,

                --Formateador para YAML
                formatting.yamlfmt,

                --Eslint para JS y TS
                --diagnostics.eslint_d,

                --Linter para el JSON
                --´diagnostics.jsonlint,

                --Linter para Markdown
                diagnostics.markdownlint_cli2,

                --Linter para YAML
                diagnostics.yamllint,

                --Linter para Python
                --diagnostics.flake8,

                --Linter para CSS
                diagnostics.stylelint,

                diagnostics.vint,

                --Acciones de código
                --actions.eslint_d,
                actions.refactoring,
            },
        })
    end,
}
