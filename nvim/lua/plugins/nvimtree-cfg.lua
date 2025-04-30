return {
	"nvim-tree/nvim-tree.lua",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	event = "VeryLazy",
	config = function()
		local function my_on_attach(bufnr)
			local api = require("nvim-tree.api")

			local function opts(desc)
				return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
			end

			-- default mappings
			api.config.mappings.default_on_attach(bufnr)

			-- custom mappings
			vim.keymap.set("n", "<Tab>", api.node.open.tab, opts("Open: New Tab"))
		end
		require("nvim-tree").setup({
			vim.keymap.set(
				"n",
				"<Tab>",
				":NvimTreeToggle<cr>",
				{ silent = true, desc = "Abrir/ocultar arbol de archivos" }
			),
			sort = {
				sorter = "case_sensitive",
			},
			view = {
				width = 40,
			},
			renderer = {
				group_empty = true,
			},
			filters = {
				dotfiles = false,
				custom = { ".git", "node_modules", ".next" },
			},
			on_attach = my_on_attach,
		})
	end,
}
