return {
    "kndndrj/nvim-dbee",
    dependencies = {
        "MunifTanjim/nui.nvim",
        "nvim-lua/plenary.nvim",
    },
    build = function()
        -- Esto intentará descargar el binario necesario automáticamente
        require("dbee").install()
    end,
    cmd = { "Dbee" }, -- Solo carga el plugin cuando uses el comando :Dbee
    keys = {
        {
            "<leader>db",
            function()
                require("dbee").toggle()
            end,
            desc = "Toggle DBee",
        },
    },
    config = function()
        require("dbee").setup({
            -- Aquí puedes añadir tus fuentes de datos (sources) más adelante
        })
    end,
}
