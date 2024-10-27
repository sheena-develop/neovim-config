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
    use({
        "nvim-treesitter/nvim-treesitter",
        run = ":TSUpdate"
    })
    use({
        "nvim-lualine/lualine.nvim",
        requires = { "nvim-tree/nvim-web-devicons", opt = true }
    })
    use("nvim-tree/nvim-web-devicons")
    use {
        "kdheepak/tabline.nvim",
        config = function()
            require"tabline".setup {
                enable = true,
                options = {
                    section_separators = {"", ""},
                    component_separators = {"", ""},
                    max_bufferline_percent = 66,
                    show_tabs_always = false,
                    show_devicons = true,
                    show_bufnr = false,
                    show_filename_only = false,
                    modified_icon = "+ ",
                    modified_italic = false,
                    show_tabs_only = false
                }
            }
        end
    }
    use("echasnovski/mini.indentscope")
    use({
        "folke/noice.nvim",
        config = function()
            require("noice").setup({
            })
        end,
        requires = {
            "MunifTanjim/nui.nvim",
            "rcarriga/nvim-notify"
        }
    })
    use({
        "nvim-neo-tree/neo-tree.nvim",
        branch = "v3.x",
        requires = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "MunifTanjim/nui.nvim",
            "3rd/image.nvim"
        }
    })
    use({
        "lewis6991/gitsigns.nvim",
        config = function()
            require("gitsigns").setup()
        end
    })
    use("neovim/nvim-lspconfig")
    use("jose-elias-alvarez/null-ls.nvim")
    use("MunifTanjim/prettier.nvim")
end)

