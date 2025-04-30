return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		require("which-key").add({
			{ "<leader>w", "<cmd>WhichKey<cr>", desc = "WhichKey" },
		})

		require("which-key").setup({
			preset = "modern",
		})
	end,
}
