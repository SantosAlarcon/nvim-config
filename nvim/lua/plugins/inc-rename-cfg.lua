return {
    "smjonas/inc-rename.nvim",
    event = "BufRead",
    config = function()
        require("inc_rename").setup({
            vim.keymap.set("n", "<leader>rn", function()
                return ":IncRename " .. vim.fn.expand("<cword>")
            end, { expr = true, desc = "Reemplazar palabra sobre el cursor" }),
        })
    end,
}
