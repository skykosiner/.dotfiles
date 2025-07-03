return {
    "glacambre/firenvim",
    build = ":call firenvim#install(0)",
    config = function()
        vim.api.nvim_create_autocmd({ 'UIEnter' }, {
            callback = function(event)
                local client = vim.api.nvim_get_chan_info(vim.v.event.chan).client
                if client ~= nil and client.name == "Firenvim" then
                    vim.o.laststatus = 0
                end
            end
        })
    end
}
