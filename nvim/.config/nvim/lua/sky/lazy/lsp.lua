return {
  {
    "VonHeikemen/lsp-zero.nvim",
    dependencies = {
      {
        "jsongerber/nvim-px-to-rem",
        config = function()
          require("nvim-px-to-rem").setup({})
        end
      },
      "folke/neodev.nvim",
      "hrsh7th/cmp-path",
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/nvim-cmp",
      "j-hui/fidget.nvim",
      "onsails/lspkind-nvim",
      "simrat39/symbols-outline.nvim"
    },
    config = function()
      local lsp = require("lsp-zero")
      local lspkind = require("lspkind")
      local cmp = require("cmp")

      vim.api.nvim_set_hl(0, "CmpNormal", { bg = "#000000" })
      require("fidget").setup({})
      require("neodev").setup({})

      require("mason").setup({})
      require('mason-lspconfig').setup({
        ensure_installed = {
          "bashls",
          "clangd",
          "cssls",
          "eslint",
          "gopls",
          "html",
          "lemminx",
          "ltex",
          "lua_ls",
          "pyright",
          "rust_analyzer",
          "tailwindcss",
          "taplo",
          "texlab",
          "tsserver",
          "vimls",
          "yamlls",
        },
        handlers = {
          lsp.default_setup,
        },
      })

      lsp.preset("recommended")

      cmp.setup({
        window = {
          completion = {
            -- border = "rounded",
            winhighlight = "Normal:CmpNormal",
          }
        },
        formatting = {
          format = lspkind.cmp_format {
            with_text = true,
            menu = {
              copilot = "[Copilot]",
              buffer = "[buf]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[api]",
              path = "[path]",
              luasnip = "[snip]",
              nvim_px_to_rem = "[px-rem]",
            },
          },
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete({}),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
        }),
        experimental = {
          ghost_text = true,
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "nvim_lua" },
          { name = "copilot" },
          { name = "nvim_lsp" },
          { name = "path" },
          { name = "luasnip" },
          { name = "buffer",        keyword_length = 5 },
          { name = "nvim_px_to_rem" }
        }
      })

      lsp.on_attach(function(client, bufnr)
        local opts = { buffer = bufnr, remap = false }
        vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
        vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
        vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
        vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
        vim.keymap.set("n", "[d", function() vim.diagnostic.goto_next() end, opts)
        vim.keymap.set("n", "]d", function() vim.diagnostic.goto_prev() end, opts)
        vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
        vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
        vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
        vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
      end)

      lsp.set_sign_icons({
        error = "E",
        Warn = "W",
        Hint = "H",
        Info = "I",
      })

      local opts = {
        highlight_hovered_item = true,
        show_guides = true,
      }

      require("symbols-outline").setup(opts)

      vim.g.lsp_zero_ui_float_border = "none"

      lspkind.init({
        symbol_map = {
          Copilot = "",
        },
      })

      vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })

      lsp.setup()

      vim.diagnostic.config({
        -- Get the errors on the side
        float = {
          focusable = false,
          style = "minimal",
          border = "rounded",
          source = "always",
          header = "",
          prefix = "",
        },
      })
    end
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      vim.keymap.set("n", "<leader>do", function() require("trouble").toggle() end)
      vim.keymap.set("n", "[d", function() require("trouble").next({ skip_groups = true, jump = true }) end)
      vim.keymap.set("n", "]d", function() require("trouble").previous({ skip_groups = true, jump = true }) end)
    end
  }
}
