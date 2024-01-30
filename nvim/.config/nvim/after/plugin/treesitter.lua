-- Stollen from tjdevries

if not pcall(require, "nvim-treesitter") then
  return
end

local list = require("nvim-treesitter.parsers").get_parser_configs()
list.lua = {
  install_info = {
    url = "https://github.com/tjdevries/tree-sitter-lua",
    revision = "0e860f697901c9b610104eb61d3812755d5211fc",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "master",
  },
}
list.rsx = {
  install_info = {
    url = "https://github.com/tjdevries/tree-sitter-rsx",
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "master",
  },
}
list.perl = {
  install_info = {
    url = "https://github.com/tree-sitter-perl/tree-sitter-perl",
    -- revision = "release",
    branch = "master",
    files = { "src/parser.c", "src/scanner.c" },
    requires_generate_from_grammar = true,
  },
}
list.just = {
  install_info = {
    url = "https://github.com/IndianBoy42/tree-sitter-just", -- local path or git repo
    files = { "src/parser.c", "src/scanner.cc" },
    branch = "main",
    -- use_makefile = true -- this may be necessary on MacOS (try if you see compiler errors)
  },
  maintainers = { "@IndianBoy42" },
}

-- alt+<space>, alt+p -> swap next
-- alt+<backspace>, alt+p -> swap previous
-- swap_previous = {
--   ["<M-s><M-P>"] = "@parameter.inner",
--   ["<M-s><M-F>"] = "@function.outer",
-- },
local swap_next, swap_prev = (function()
  local swap_objects = {
    p = "@parameter.inner",
    f = "@function.outer",
    e = "@element",
  }

  local n, p = {}, {}
  for key, obj in pairs(swap_objects) do
    n[string.format("<M-Space><M-%s>", key)] = obj
    p[string.format("<M-BS><M-%s>", key)] = obj
  end

  return n, p
end)()

local _ = require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "go",
    "html",
    "javascript",
    "json",
    "markdown",
    "ocaml",
    "python",
    "query",
    "rust",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "org"
  },

  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'org' }
  },

  refactor = {
    highlight_definitions = { enable = true },
    highlight_current_scope = { enable = false },

    smart_rename = {
      enable = false,
      keymaps = {
        -- mapping to rename reference under cursor
        smart_rename = "grr",
      },
    },

    navigation = {
      enable = false,
      keymaps = {
        goto_definition = "gnd", -- mapping to go to definition of symbol under cursor
        list_definitions = "gnD", -- mapping to list all definitions in current file
      },
    },
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<M-w>", -- maps in normal mode to init the node/scope selection
      node_incremental = "<M-w>", -- increment to the upper named parent
      node_decremental = "<M-C-w>", -- decrement to the previous node
      scope_incremental = "<M-e>", -- increment to the upper scope (as defined in locals.scm)
    },
  },

  textobjects = {
    move = {
      enable = true,
      set_jumps = true,

      goto_next_start = {
        ["]p"] = "@parameter.inner",
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer",
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer",
      },
      goto_previous_start = {
        ["[p"] = "@parameter.inner",
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer",
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer",
      },
    },

    select = {
      enable = true,
      lookahead = true,

      keymaps = {
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",

        ["ac"] = "@conditional.outer",
        ["ic"] = "@conditional.inner",

        ["aa"] = "@parameter.outer",
        ["ia"] = "@parameter.inner",

        ["av"] = "@variable.outer",
        ["iv"] = "@variable.inner",
      },
    },

    swap = {
      enable = true,
      swap_next = swap_next,
      swap_previous = swap_prev,
    },
  },

  playground = {
    enable = true,
    updatetime = 25,
    persist_queries = true,
    keybindings = {
      toggle_query_editor = "o",
      toggle_hl_groups = "i",
      toggle_injected_languages = "t",

      -- This shows stuff like literal strings, commas, etc.
      toggle_anonymous_nodes = "a",
      toggle_language_display = "I",
      focus_language = "f",
      unfocus_language = "F",
      update = "R",
      goto_node = "<cr>",
      show_help = "?",
    },
  },
}

require("treesitter-context").setup { enable = true }
vim.treesitter.query.set("lua", "context", "")
vim.treesitter.query.set("ocaml", "context", "")
