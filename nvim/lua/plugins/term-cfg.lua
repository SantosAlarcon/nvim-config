return {
	{
		"akinsho/toggleterm.nvim",
		event = "VeryLazy",
		version = "*",
		config = function()
			require("toggleterm").setup({
				-- Abre/cierra una terminal dentro de Neovim
				open_mapping = [[<leader>t]],
				winbar = {
					enabled = false,
					name_formatter = function(term) --  term: Terminal
						return term.name
					end,
				},
			})
		end,
	},
}
