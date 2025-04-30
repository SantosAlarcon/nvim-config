local map = vim.keymap.set

vim.g.mapleader = ","

map("n", "<c-s>", ":w<cr>", { silent = true, desc = "Guardar archivo actual" })
map("n", "<c-r>", ":source %<cr>", { silent = true, desc = "Recargar archivo actual" })
map("n", "<c-l>", "Vyp", { desc = "Duplicar línea" })
map("n", "<c-a>", "ggVG", { desc = "Seleccionar todo" })

-- Buffer
map("n", "bd", ":bd<cr>", { silent = true, desc = "Borrar búfer" })
map("n", "bn", ":bn<cr>", { silent = true, desc = "Búfer siguiente" })
map("n", "bp", ":bp<cr>", { silent = true, desc = "Búfer anterior" })

map("n", "<leader>f", ":lua vim.lsp.buf.format()<cr>", { silent = true, desc = "Formatear documento" })
map("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<cr>", { silent = true, desc = "Acciones de código" })
map("n", "<leader>h", ":lua vim.lsp.buf.hover()<cr>", { silent = true, desc = "Información de código" })

-- Plugins
map("n", "<leader>l", ":Lazy<cr>", { silent = true, desc = "Cargar Lazy" })
map("n", "<leader>m", ":Mason<cr>", { silent = true, desc = "Cargar Mason" })
