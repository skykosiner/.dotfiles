-- Set the statusline options

require("statusLine").setup({
    ShowItems = {
        FileInfo = true,
        ModeInfo = true,
        LineInfo = true,
        GitInfo = true,
        LspInfo = true,
        HarpoonInfo = false,
        SaveInfo = false,
    },
    backgroundColor = "#7fa3c0",
})

-- require("statusLine").setStatus()
