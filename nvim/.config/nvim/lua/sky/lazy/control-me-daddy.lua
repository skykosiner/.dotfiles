return {
    dir = os.getenv("HOME") .. "/personal/python-control-my-computer/",
    config = function()
        vim.keymap.set("n", "<leader>ea", require("control-me-daddy").START)

        -- nvmd = no vim me daddy
        vim.keymap.set("n", "<leader>dea", require("control-me-daddy").STOP)
    end
}
