return {
    "nvim-telescope/telescope.nvim",
    dependencies = {"nvim-telescope/telescope-ui-select.nvim"},
    event = "VeryLazy",
    config = function()
        require("telescope").setup({
            defaults = {
                multi_icon = " ",
                layout_config = {
                    horizontal = {
                        width_padding = 0.25,
                        height_padding = 0.2,
                        preview_padding = 1,
                    },
                    vertical = {
                        width_padding = 0.05,
                        height_padding = 0.1,
                    },
                },
                color_devicons = true,
            },
            pickers = {
                -- Default configuration for builtin pickers goes here:
                -- picker_name = {
                --   picker_config_key = value,
                --   ...
                -- }
                -- Now the picker_config_key will be applied every time you call this
                -- builtin picker
            },
            extensions = {
                fzf = {
                    fuzzy = true, -- false will only do exact matching
                    override_generic_sorter = true, -- override the generic sorter
                    override_file_sorter = true, -- override the file sorter
                    case_mode = "smart_case", -- or "ignore_case" or "respect_case"
                    -- the default case_mode is "smart_case"
                },
            },
        })

        require("telescope").load_extension("ui-select")
        --require("telescope").load_extension("fzf")
        vim.keymap.set("n", "<leader>lg", ":Telescope live_grep<cr>", {silent = true, desc = "Telescope Live Grep"})
    end
}


