return {
	"famiu/feline.nvim",
	event = "VeryLazy",
	dependencies = {
		"lewis6991/gitsigns.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		local opts = {}
		local lsp = require("feline.providers.lsp")
		local C = require("github-theme.palette").load("github_dark_high_contrast")
		local vi_mode_utils = require("feline.providers.vi_mode")

		local disable = {
			filetypes = {
				"^NvimTree$",
				"^packer$",
				"^startify$",
				"^fugitive$",
				"^fugitiveblame$",
				"^qf$",
				"^help$",
			},
			buftypes = {
				"^terminal$",
				"$term$",
				"^NvimTree$",
			},
			bufnames = {},
		}

		local components = {
			active = { {}, {}, {} },
			inactive = { {}, {}, {} },
		}

		local config = {
			left_separator = "left_rounded",
			right_separator = "right_rounded",
			file = "󰈙",
			lsp = {
				icons = {
					formatter = "󰛿",
					linter = "󰸥",
					server = " ",
					error = "",
					warning = "",
					info = "",
					hint = "",
				},
				exclude = {},
				server_to_name_map = {},
				update_in_insert = false,
			},
			git = {
				branch = "",
				added = "",
				changed = "",
				removed = "",
			},
		}

		---@diagnostic disable-next-line: redefined-local
		local config = vim.tbl_deep_extend("force", config, opts)

		local colors = {
			bg = C.black.base,
			black = C.black.base.base,
			yellow = C.yellow.base,
			cyan = C.cyan.base.base,
			oceanblue = "#45707a",
			green = C.green.base,
			orange = C.orange.base,
			violet = "#d3869b",
			magenta = "#c14a4a",
			white = C.white.base,
			fg = C.fg0,
			skyblue = "#7daea3",
			red = C.red.base,
		}

		local vi_mode_colors = {
			NORMAL = "green",
			OP = "green",
			INSERT = "red",
			VISUAL = "skyblue",
			LINES = "skyblue",
			BLOCK = "skyblue",
			REPLACE = "violet",
			["V-REPLACE"] = "violet",
			ENTER = "cyan",
			MORE = "cyan",
			SELECT = "orange",
			COMMAND = "green",
			SHELL = "green",
			TERM = "green",
			NONE = "yellow",
		}

		local vi_mode_text = {
			NORMAL = "NORMAL",
			OP = "OP",
			INSERT = "INSERTAR",
			VISUAL = "VISUAL",
			LINES = "LÍNEAS",
			BLOCK = "BLOQUE",
			REPLACE = "REEMPLAZAR",
			["V-REPLACE"] = "REEMPLAZO-V",
			ENTER = "INTRODUCIR",
			MORE = "MÁS",
			SELECT = "SELECCIONAR",
			COMMAND = "COMANDO",
			SHELL = "SHELL",
			TERM = "TERMINAL",
			NONE = "NINGUNO",
		}

		local create_highlight = function(bg, fg)
			return {
				bg = bg,
				fg = fg,
			}
		end

		local create_separator = function(bg, fg, sep)
			return {
				str = sep,
				hl = create_highlight(bg, fg),
			}
		end

		local create_icon = function(bg, fg, icon)
			return {
				str = icon,
				hl = create_highlight(bg, fg),
			}
		end

		-- LEFT

		-- vi-mode
		components.active[1][1] = {
			-- Give me the Neovim logo
			provider = " ",
			hl = function()
				local val = {
					bg = vi_mode_utils.get_mode_color(),
					name = vi_mode_utils.get_mode_highlight_name(),
					fg = "black",
				}

				return val
			end,
			left_sep = "left_rounded",
		}
		-- vi-symbol
		components.active[1][2] = {
			provider = function()
				return vi_mode_text[vi_mode_utils.get_vim_mode()]
			end,
			hl = function()
				local val = {}
				val.fg = vi_mode_utils.get_mode_color()
				val.bg = "#333388"
				val.style = "bold"
				return val
			end,
			left_sep = create_separator("#333388", "#333388", " "),
			right_sep = config.right_separator,
		}

		components.active[1][3] = {
			provider = " ",
		}

		-- fileIcon
		components.active[1][4] = {
			provider = function()
				local filename = vim.fn.expand("%:t")
				local extension = vim.fn.expand("%:e")
				local icon = require("nvim-web-devicons").get_icon(filename, extension)
				if icon == nil then
					icon = "󰈙"
				end
				return icon .. " "
			end,
			hl = function()
				local val = {}
				val.fg = "black"
				val.bg = C.cyan.base
				val.style = "bold"
				return val
			end,
			left_sep = create_separator(C.bg0, C.cyan.base, "left_rounded"),
		}

		-- Filename
		components.active[1][5] = {
			provider = function()
				local file = require("feline.providers.file")
				local filename = file.file_info(file, "shorten")
				return filename
			end,
			hl = {
				fg = C.fg0,
				bg = "#333388",
				style = "bold",
			},
			right_sep = config.right_separator,
		}

		-- MID
		-- gitBranch
		components.active[2][1] = {
			provider = "git_branch",
			hl = {
				fg = "yellow",
				bg = colors.bg,
				style = "bold",
			},
		}
		-- diffAdd
		components.active[2][2] = {
			provider = "git_diff_added",
			hl = {
				fg = "green",
				bg = colors.bg,
				style = "bold",
			},
		}
		-- diffModfified
		components.active[2][3] = {
			provider = "git_diff_changed",
			hl = {
				fg = "orange",
				bg = colors.bg,
				style = "bold",
			},
		}
		-- diffRemove
		components.active[2][4] = {
			provider = "git_diff_removed",
			hl = {
				fg = "red",
				bg = colors.bg,
				style = "bold",
			},
		}

		-- RIGHT
		-- diagnosticErrors
		components.active[3][1] = {
			provider = "diagnostic_errors",
			enabled = function()
				return lsp.diagnostics_exist(vim.diagnostic.severity.ERROR)
			end,
			hl = {
				fg = "red",
			},
		}
		-- diagnosticWarn
		components.active[3][2] = {
			provider = "diagnostic_warnings",
			enabled = function()
				return lsp.diagnostics_exist(vim.diagnostic.severity.WARN)
			end,
			hl = {
				fg = "yellow",
			},
		}
		-- diagnosticHint
		components.active[3][3] = {
			provider = "diagnostic_hints",
			enabled = function()
				return lsp.diagnostics_exist(vim.diagnostic.severity.HINT)
			end,
			hl = {
				fg = "cyan",
			},
		}
		-- diagnosticInfo
		components.active[3][4] = {
			provider = "diagnostic_info",
			enabled = function()
				return lsp.diagnostics_exist(vim.diagnostic.severity.INFO)
			end,
			hl = {
				fg = "skyblue",
			},
		}

		components.active[3][5] = {
			provider = " ",
		}

		-- LspName
		components.active[3][6] = {
			provider = function()
				local lsps = vim.lsp.get_clients({ bufnr = 0 })
				local lsp_names = ""
				local index = 0

				for _, lsp_config in ipairs(lsps) do
					index = index + 1

					if index == 1 then
						lsp_names = " " .. lsp_config.name
					else
						lsp_names = lsp_names .. " | " .. lsp_config.name
					end
				end

				return lsp_names
			end,
			hl = {
				fg = C.fg0,
				bg = "#333388",
			},
			icon = create_icon(C.cyan.base, C.black.base, config.lsp.icons.server),
			left_sep = create_separator(C.bg0, C.cyan.base, "left_rounded"),
			right_sep = "right_rounded",
		}

		components.active[3][7] = {
			provider = " ",
		}

		-- lineInfo
		components.active[3][8] = {
			provider = function()
				local line = vim.api.nvim_win_get_cursor(0)[1] + 1
				local col = vim.api.nvim_win_get_cursor(0)[2] + 1
				return " " .. line .. ":" .. col
			end,
			icon = create_icon(C.cyan.base, C.black.base, "󰗈 "),
			hl = {
				fg = C.fg0,
				bg = "#333388",
			},

			left_sep = create_separator(C.bg0, C.cyan.base, "left_rounded"),
			right_sep = "right_rounded",
		}

		-- INACTIVE

		-- fileType
		components.inactive[1][1] = {
			provider = "file_type",
			hl = {
				fg = "black",
				bg = "cyan",
				style = "bold",
			},
			left_sep = {
				str = " ",
				hl = {
					fg = "NONE",
					bg = "cyan",
				},
			},
			right_sep = {
				{
					str = " ",
					hl = {
						fg = "NONE",
						bg = "cyan",
					},
				},
				" ",
			},
		}

		require("feline").setup({
			theme = colors,
			default_bg = "#ffff00",
			-- default_fg = C.fg0,
			default_fg = "#ffff00",
			vi_mode_colors = vi_mode_colors,
			components = components,
			disable = disable,
		})

		require("gitsigns").setup()
	end,
}
