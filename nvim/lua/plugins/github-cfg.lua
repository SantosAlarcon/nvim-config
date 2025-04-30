return {
    -- Github Theme
    {
        "projekt0n/github-nvim-theme",
        config = function()
            require("github-theme").setup({
                options = {
                    hide_end_of_buffer = true,
                    styles = {
                        functions = "bold",
                        keywords = "bold",
                        comments = "italic",
                        types = "bold",
                        constants = "bold",
                    },
                },
            })

            vim.cmd("colorscheme github_dark_high_contrast")
        end,
    },
}
