-- Este archivo recoge la configuración de los LSP (Protocolos de Servidores de Lenguaje) y autocompletado.
return {
    "neovim/nvim-lspconfig",
    event = "VeryLazy",
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
        local lspconfig = require("lspconfig")
        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local capabilities = cmp_nvim_lsp.default_capabilities()

        -- CONFIGS
        local servers = {
            "html",
            "cssls",
            "cssmodules_ls",
            "ts_ls",
            -- "tailwindcss",
            "astro",
            "biome",
            "pyright",
            "jsonls",
            "vimls",
            "lua_ls",
            "emmet_ls",
            "yamlls",
            "marksman"
        }

        for _, lsp in ipairs(servers) do
            lspconfig[lsp].setup({
                capabilities = capabilities,
            })
        end

        lspconfig["astro"].setup({
            capabilities = capabilities,
            cmd = { "astro-ls", "--stdio" },
            filetypes = { "astro" },
            init_options = {
                typescript = {
                    -- This line fixes the Astro LSP can't find tsserver.js error
                    tsdk = vim.fs.normalize('~/.bun/install/global/node_modules/typescript/lib')
                }
            }
        })

        -- CSS Modules
        lspconfig["cssmodules_ls"].setup({
            init_options = {
                camelCase = false
            }
        })

        lspconfig["lua_ls"].setup({
            capabilities = capabilities,
            settings = {
                Lua = {
                    diagnostics = {
                        globals = { "vim" },
                    },
                    workspace = {
                        library = {
                            [vim.fn.expand("$VIMRUNTIME/lua")] = true,
                            [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
                            [vim.fn.stdpath("data") .. "/lazy/lazy.nvim/lua/lazy"] = true,
                        },
                        maxPreload = 100000,
                        preloadFileSize = 10000,
                    },
                },
            },
        })
    end,
}
