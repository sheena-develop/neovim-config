local config = {
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
            "filename",
            {
                function()
                    return os.date("%Y年%m月%d日(%a) %H:%M:%S")
                end,
                icon = ""
            }
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" }
    }
}

require("lualine").setup(config)

