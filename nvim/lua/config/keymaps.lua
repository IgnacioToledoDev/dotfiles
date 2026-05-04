-- Este archivo se carga automáticamente por el plugin LazyVim
-- Aquí puedes añadir tus atajos personalizados

local keymap = vim.keymap

-- Abrir terminal en split vertical a la derecha
keymap.set("n", "<leader>fv", function()
    -- Intentamos usar Snacks (la versión moderna de LazyVim)
    if package.loaded["snacks"] then
        Snacks.terminal(nil, { win = { position = "right", width = 0.4 } })
    else
        -- Si tu versión es más antigua, usa el comando estándar
        vim.cmd("vsplit | terminal")
    end
end, { desc = "Terminal Vertical (Derecha)" })

-- Salir del modo terminal con Esc
vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], { desc = "Escape terminal mode" })

-- Navegación fácil entre ventanas desde la terminal
vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Move left" })
vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Move down" })
vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Move up" })
vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Move right" })
