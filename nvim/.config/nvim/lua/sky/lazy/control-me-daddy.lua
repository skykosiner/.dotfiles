return {
    dir = os.getenv("HOME") .. "/personal/python-control-my-computer/",
    config = function()
        -- vmd = vim me daddy
        vim.keymap.set("n", "<leader>vmd", require("control-me-daddy").START)

        -- nvmd = no vim me daddy
        vim.keymap.set("n", "<leader>nvmd", require("control-me-daddy").STOP)
    end
}
