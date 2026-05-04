return {
    "akinsho/toggleterm.nvim",
    version = "*",
    opts = {
        -- Tamaño de la terminal si fuera horizontal o vertical
        size = 20,
        -- Atajo de teclado para abrir/cerrar (Ctrl + \)
        open_mapping = [[<c-\>]],
        hide_numbers = true,
        shade_terminals = true,
        start_in_insert = true,
        insert_mappings = true,
        terminal_mappings = true,
        persist_size = true,
        direction = "float", -- Aquí es donde ocurre la magia (flotante)
        close_on_exit = true,
        shell = vim.o.shell,
        float_opts = {
            border = "curved", -- Puedes usar "single", "double", "shadow", "curved"
            winblend = 3,
        },
    },
}
