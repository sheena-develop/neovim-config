local vim = vim or require("vim")

-- lazy.nvim の設定
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 最新の安定版を使う
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim を使ってプラグインを導入
require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          "filename",
          {
            function()
              return os.date("%Y年%m月%d日(%a) %H:%M:%S")
            end,
            icon = "",
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  "nvim-tree/nvim-web-devicons",
  {
    "kdheepak/tabline.nvim",
    config = function()
      require("tabline").setup({
        enable = true,
        options = {
          section_separators = { "", "" },
          component_separators = { "", "" },
          max_bufferline_percent = 66,
          show_tabs_always = false,
          show_devicons = true,
          show_bufnr = false,
          show_filename_only = false,
          modified_icon = "+ ",
          modified_italic = false,
          show_tabs_only = false,
        },
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      symbol = "▏",
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      {
        "MunifTanjim/nui.nvim",
        config = function()
          local Popup = require("nui.popup")

          local command_list = [[
:w             - ファイルを保存
:q             - エディタを終了
:PackerInstall - パッケージのインストール
:PackerUpdate  - パッケージのアップデート
:PackerSync    - パッケージの同期

<移動>
十字キー無効化
Normal mode, h        - 左移動
Normal mode, l        - 右移動
Normal mode, j        - 下移動
Normal mode, k        - 上移動
Insert mode, Ctrl + h - 左移動
Insert mode, Ctrl + l - 右移動
Insert mode, Ctrl + j - 下移動
Insert mode, Ctrl + k - 上移動
Normal mode, 0        - 行頭に移動
Normal mode, $        - 行末に移動
Normal mode, gg       - 最初に移動
Normal mode, G        - 最後に移動
Normal mode, H        - 表示画面の最初の行に移動
Normal mode, M        - 表示画面の中央の行に移動
Normal mode, L        - 表示画面の最後の行に移動

<モード切替>
,,             - Normal modeに戻す
Normal mode, a - 次の位置に移動して、Insert modeにする
Normal mode, o - 下に行を挿入して、Insert modeにする
Normal mode, O - 上に行を挿入して、Insert modeにする

<コピー&切り取り&ペースト>
Normal mode, y        - コピー
Normal mode, dd       - 切り取り
Normal mode, p        - ペースト
Insert mode, Ctrl + p - ペースト

<検索>
Normal mode, / - 検索
Normal mode, Space + c - 検索結果のハイライトを取り消し

<バッファ>
Normal mode, Shift + j - バッファを左移動
Normal mode, Shift + k - バッファを右移動

<プラグイン>
Normal mode, Space + f - Prettierによるフォーマット
Normal mode, Space + nn - ファイルツリーを表示する
          ]]

          local function show_commands()
            local popup = Popup({
              enter = true,
              focusable = true,
              border = {
                style = "rounded",
                text = {
                  top = " コマンドリスト ",
                  top_align = "center",
                },
              },
              position = "50%",
              size = {
                width = 80,
                height = 30,
              },
              buf_options = {
                modifiable = false,
                readonly = true,
              },
            })

            vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, vim.split(command_list, "\n"))

            popup:map("n", ",,", function()
              popup:unmount()
            end, { noremap = true })

            popup:mount()
          end
          vim.api.nvim_create_user_command("S", show_commands, {})
        end,
      },
      "rcarriga/nvim-notify",
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  -- 'prettier.nvim' を削除しました
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            prefer_local = "node_modules/.bin",
          }),
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.goimports,
        },
      })
    end,
  },
  {
    "machakann/vim-highlightedyank",
    config = function()
      vim.g.highlightedyank_highlight_duration = 1000
    end,
  },
  {
    "mg979/vim-visual-multi",
    init = function()
      local t = {}
      t["Find Under"] = "<C-k>"
      vim.g.VM_maps = t
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
              return vim_item
            end,
          }),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- コマンドライン補完の設定
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "lua_ls",
          "yamlls",
          "jsonls",
          "taplo",
          "rust_analyzer",
          "ts_ls",
          "html",
          "cssls",
        },
      })

      local lspconfig = require("lspconfig")
      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gf", vim.lsp.buf.format, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "gn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "ge", vim.diagnostic.open_float, bufopts)
        vim.keymap.set("n", "g]", vim.diagnostic.goto_next, bufopts)
        vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, bufopts)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, server in ipairs({
        "bashls",
        "lua_ls",
        "yamlls",
        "jsonls",
        "taplo",
        "rust_analyzer",
        "ts_ls",
        "html",
        "cssls",
      }) do
        lspconfig[server].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        automatic_setup = true,
        ensure_installed = {
          "stylua",
          "shfmt",
          "prettier",
          "selene",
        },
        handlers = {},
      })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          separator = "  ",
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    event = { "BufRead", "BufNewFile" },
  },
}, {})
local vim = vim

-- lazy.nvim の設定
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- 最新の安定版を使う
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- lazy.nvim を使ってプラグインを導入
require("lazy").setup({
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
  },
  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          "filename",
          {
            function()
              return os.date("%Y年%m月%d日(%a) %H:%M:%S")
            end,
            icon = "",
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    },
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  {
    "nvim-tree/nvim-web-devicons",
  },
  {
    "kdheepak/tabline.nvim",
    config = function()
      require("tabline").setup({
        enable = true,
        options = {
          section_separators = { "", "" },
          component_separators = { "", "" },
          max_bufferline_percent = 66,
          show_tabs_always = false,
          show_devicons = true,
          show_bufnr = false,
          show_filename_only = false,
          modified_icon = "+ ",
          modified_italic = false,
          show_tabs_only = false,
        },
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",
    opts = {
      symbol = "▏",
    },
  },
  {
    "folke/noice.nvim",
    opts = {
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%",
          },
          size = {
            width = 60,
            height = "auto",
          },
        },
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = false,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
    },
    dependencies = {
      {
        "MunifTanjim/nui.nvim",
        config = function()
          local Popup = require("nui.popup")

          local command_list = [[
:w             - ファイルを保存
:q             - エディタを終了
:PackerInstall - パッケージのインストール
:PackerUpdate  - パッケージのアップデート
:PackerSync    - パッケージの同期

<移動>
十字キー無効化
Normal mode, h        - 左移動
Normal mode, l        - 右移動
Normal mode, j        - 下移動
Normal mode, k        - 上移動
Insert mode, Ctrl + h - 左移動
Insert mode, Ctrl + l - 右移動
Insert mode, Ctrl + j - 下移動
Insert mode, Ctrl + k - 上移動
Normal mode, 0        - 行頭に移動
Normal mode, $        - 行末に移動
Normal mode, gg       - 最初に移動
Normal mode, G        - 最後に移動
Normal mode, H        - 表示画面の最初の行に移動
Normal mode, M        - 表示画面の中央の行に移動
Normal mode, L        - 表示画面の最後の行に移動

<モード切替>
,,             - Normal modeに戻す
Normal mode, a - 次の位置に移動して、Insert modeにする
Normal mode, o - 下に行を挿入して、Insert modeにする
Normal mode, O - 上に行を挿入して、Insert modeにする

<コピー&切り取り&ペースト>
Normal mode, y        - コピー
Normal mode, dd       - 切り取り
Normal mode, p        - ペースト
Insert mode, Ctrl + p - ペースト

<検索>
Normal mode, / - 検索
Normal mode, Space + c - 検索結果のハイライトを取り消し

<バッファ>
Normal mode, Shift + j - バッファを左移動
Normal mode, Shift + k - バッファを右移動

<プラグイン>
Normal mode, Space + f - Prettierによるフォーマット
Normal mode, Space + nn - ファイルツリーを表示する
          ]]

          local function show_commands()
            local popup = Popup({
              enter = true,
              focusable = true,
              border = {
                style = "rounded",
                text = {
                  top = " コマンドリスト ",
                  top_align = "center",
                },
              },
              position = "50%",
              size = {
                width = 80,
                height = 30,
              },
              buf_options = {
                modifiable = false,
                readonly = true,
              },
            })

            vim.api.nvim_buf_set_lines(popup.bufnr, 0, -1, false, vim.split(command_list, "\n"))

            popup:map("n", ",,", function()
              popup:unmount()
            end, { noremap = true })

            popup:mount()
          end
          vim.api.nvim_create_user_command("S", show_commands, {})
        end,
      },
      "rcarriga/nvim-notify",
    },
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
  },
  {
    "lewis6991/gitsigns.nvim",
    config = function()
      require("gitsigns").setup()
    end,
  },
  -- 'prettier.nvim' を削除しました
  {
    "jose-elias-alvarez/null-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.prettier.with({
            prefer_local = "node_modules/.bin",
          }),
          null_ls.builtins.formatting.stylua,
          null_ls.builtins.formatting.goimports,
        },
      })
    end,
  },
  {
    "machakann/vim-highlightedyank",
    config = function()
      vim.g.highlightedyank_highlight_duration = 1000
    end,
  },
  {
    "mg979/vim-visual-multi",
    init = function()
      local t = {}
      t["Find Under"] = "<C-k>"
      vim.g.VM_maps = t
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-nvim-lua",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "onsails/lspkind.nvim",
    },
    config = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")
      vim.opt.completeopt = { "menu", "menuone", "noselect" }

      cmp.setup({
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol",
            maxwidth = 50,
            ellipsis_char = "...",
            before = function(entry, vim_item)
              return vim_item
            end,
          }),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "nvim_lua" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })

      -- コマンドライン補完の設定
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })
    end,
  },
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    opts = {},
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "neovim/nvim-lspconfig" },
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "bashls",
          "lua_ls",
          "yamlls",
          "jsonls",
          "taplo",
          "rust_analyzer",
          "ts_ls",
          "html",
          "cssls",
        },
      })

      local lspconfig = require("lspconfig")
      local on_attach = function(client, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
        vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
        vim.keymap.set("n", "gf", vim.lsp.buf.format, bufopts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
        vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
        vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
        vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, bufopts)
        vim.keymap.set("n", "gn", vim.lsp.buf.rename, bufopts)
        vim.keymap.set("n", "ga", vim.lsp.buf.code_action, bufopts)
        vim.keymap.set("n", "ge", vim.diagnostic.open_float, bufopts)
        vim.keymap.set("n", "g]", vim.diagnostic.goto_next, bufopts)
        vim.keymap.set("n", "g[", vim.diagnostic.goto_prev, bufopts)
      end

      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      for _, server in ipairs({
        "bashls",
        "lua_ls",
        "yamlls",
        "jsonls",
        "taplo",
        "rust_analyzer",
        "ts_ls",
        "html",
        "cssls",
      }) do
        lspconfig[server].setup({
          on_attach = on_attach,
          capabilities = capabilities,
        })
      end
    end,
  },
  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "jose-elias-alvarez/null-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        automatic_setup = true,
        ensure_installed = {
          "stylua",
          "shfmt",
          "prettier",
          "selene",
        },
        handlers = {},
      })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    config = function()
      require("lspsaga").setup({
        symbol_in_winbar = {
          separator = "  ",
        },
      })
    end,
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    event = { "BufRead", "BufNewFile" },
  },
}, {})
