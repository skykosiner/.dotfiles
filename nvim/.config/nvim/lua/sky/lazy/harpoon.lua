return {
    "ThePrimeagen/harpoon",
    -- dir = "~/personal/harpoon.git/get-current-mark/",
    branch = "harpoon2",
    dependencies = {
        "nvim-lua/popup.nvim"
    },
    config = function()
        local harpoon = require("harpoon")

        harpoon:setup({})

        vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
        vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)

        vim.keymap.set("n", "<M-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list("term")) end)

        vim.keymap.set("n", "<M-h>", function() harpoon:list("term"):select(1) end)
        vim.keymap.set("n", "<M-t>", function() harpoon:list("term"):select(2) end)

        vim.keymap.set("n", "<C-h>", function() harpoon:list():select(1) end)
        vim.keymap.set("n", "<C-t>", function() harpoon:list():select(2) end)
        vim.keymap.set("n", "<C-n>", function() harpoon:list():select(3) end)
        vim.keymap.set("n", "<C-s>", function() harpoon:list():select(4) end)
    end
}
