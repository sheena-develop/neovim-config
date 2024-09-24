local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
        vim.cmd([[packadd packer.nvim]])
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
    use("wbthomason/packer.nvim")

    use("folke/tokyonight.nvim")
    
    -- https://github.com/nvim-lualine/lualine.nvim
    use({
        "nvim-lualine/lualine.nvim",
        -- ステータスバーにアイコンを設定できるようにする
        requires = { "nvim-tree/nvim-web-devicons", opt = true },
    })
    
    -- ステータスバーにアイコンを設定できるようにする
    use("nvim-tree/nvim-web-devicons")
    
    -- https://github.com/kdheepak/tabline.nvim
    use{
        "kdheepak/tabline.nvim",
        config = function()
            require'tabline'.setup {
                enable = true,
                options = {
                    section_separators = {'', ''},
                    component_separators = {'', ''},
                    max_bufferline_percent = 66, -- set to nil by default, and it uses vim.o.columns * 2/3
                    show_tabs_always = false, -- this shows tabs only when there are more than one tab or if the first tab is named
                    show_devicons = true, -- this shows devicons in buffer section
                    show_bufnr = false, -- this appends [bufnr] to buffer section,
                    show_filename_only = false, -- shows base filename only instead of relative path in filename
                    modified_icon = "+ ", -- change the default modified icon
                    modified_italic = false, -- set to true by default; this determines whether the filename turns italic if modified
                    show_tabs_only = false, -- this shows only tabs instead of tabs + buffers
                }
            }
        end
    }

    use("echasnovski/mini.indentscope")

    -- use {
    --     'nvim-treesitter/nvim-treesitter',
    --     run = ':TSUpdate',
    --     config = function()
    --         require'nvim-treesitter.configs'.setup {
    --             ensure_installed = "all",
    --             highlight = {
    --                 enable = true,
    --                 additional_vim_regex_highlighting = false,
    --             },
    --             indent = {
    --                 enable = true
    --             },
    --         }
    --     end
    -- }

    use({
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
                -- add any options here
            })
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify",
        },
    })

    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim",
        },
    })

    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end,
    })

    use {
        'folke/which-key.nvim',
        config = function()
            local wk = require("which-key")
            wk.setup {}

            -- 全コマンドを登録
            local mappings = {
                f = {
                    name = "file", -- グループ名
                    e = { ":e<CR>", "Edit File" }, -- :e コマンドのマッピング
                    s = { ":w<CR>", "Save File" }, -- :w コマンドのマッピング
                },
                b = {
                    name = "buffer",
                    n = { ":bnext<CR>", "Next Buffer" },
                    p = { ":bprevious<CR>", "Previous Buffer" },
                },
            } 

            -- <leader>キーでのマッピングを登録
            wk.register(mappings, { prefix = "<leader>" })

            -- <leader>? で全コマンドを表示するマッピングを追加
            wk.register({
                ["?"] = { function() wk.show(mappings) end, "Show All Commands" }
            }, { prefix = "<leader>" })
        end
    }
end)

