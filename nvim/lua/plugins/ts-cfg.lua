return {
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"windwp/nvim-ts-autotag",
		},
		event = "BufReadPost",
		config = function()
			require("nvim-treesitter.configs").setup({

				-- Listado de parsers a instalar
				ensure_installed = {
					"astro",
					"bash",
					"css",
					"html",
					"javascript",
					"json",
					"jsonc",
					"lua",
					"markdown",
					"python",
					"typescript",
					"vim",
				},

				-- Permite la instalación automática de parsers
				auto_install = true,

				-- Resaltado de código
				highlight = {
					enable = true,
				},

				-- Indentación
				indent = {
					enable = true,
				},

				-- Autoetiquetado HTML
				autotag = {
					enable = true,
				},
			})

			vim.treesitter.language.register('markdown', 'mdx')
		end,
	},
}
