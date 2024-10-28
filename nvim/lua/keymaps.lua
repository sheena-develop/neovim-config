-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
    local options = { noremap=true, silent=true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-----------------------------------------------------------
-- Notify message
-----------------------------------------------------------

local function notify_msg(msg)
    require("noice").notify(msg)
end

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

vim.g.mapleader = " "

map("n", "<up>", "<nop>")
map("n", "<down>", "<nop>")
map("n", "<left>", "<nop>")
map("n", "<right>", "<nop>")
map("i", "<up>", "<nop>")
map("i", "<down>", "<nop>")
map("i", "<left>", "<nop>")
map("i", "<right>", "<nop>")
map("v", "<up>", "<nop>")
map("v", "<down>", "<nop>")
map("v", "<left>", "<nop>")
map("v", "<right>", "<nop>")

map("i", ",,", "<Esc>")
map("i", "、、", "<Esc>")
map("v", ",,", "<Esc>")
map("v", "、、", "<Esc>")

map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-ｊ>", "<Down>")
map("i", "<C-ｋ>", "<Up>")
map("i", "<C-ｈ>", "<Left>")
map("i", "<C-ｌ>", "<Right>")

map("n", "gg", "gg^")
map("v", "gg", "gg^")

map("n", "G", "G$")
map("v", "G", "G$")

map("n", "p", "i<C-r>+<Esc>")
map("i", "<C-p>", "<C-r>+")
map("i", "<C-ｐ>", "<C-r>+")

map("n", "K", ":bn<CR>")
map("n", "J", ":bp<CR>")

map("c", ",,", "<C-c>")

map("n", "<leader>c", ":nohl<CR>")

map("n", "<Leader>nn", ":Neotree toggle<CR>")

map("n", "<Leader>f", ":Prettier<CR>")

