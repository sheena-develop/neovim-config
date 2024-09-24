-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local function map(mode, lhs, rhs, opts)
    local options = { noremap=true, silent=true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ','

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Leaderの設定（スペースキー）
vim.g.mapleader = " "

-- Disable arrow keys
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

-- Leader + nnでNeotree toggle
map("n", "<Leader>nn", ":Neotree toggle<Return>")

-- Map Esc to ,,
map("i", ",,", "<Esc>")
map("i", "、、", "<Esc>")
map("v", ",,", "<Esc>")
map("v", "、、", "<Esc>")

-- Clear search highlighting with space and c
map("n", "<leader>c", ":nohl<CR>")

-- <INSERT MODE> Ctrl + j, k, h, lで移動
map("i", "<C-j>", "<Down>")
map("i", "<C-k>", "<Up>")
map("i", "<C-h>", "<Left>")
map("i", "<C-l>", "<Right>")
map("i", "<C-ｊ>", "<Down>")
map("i", "<C-ｋ>", "<Up>")
map("i", "<C-ｈ>", "<Left>")
map("i", "<C-ｌ>", "<Right>")

-- <NORMAL MODE, VISUAL MODE> ggを押した時、行の最初の非空白文字に移動するようにマッピング
map("n", "gg", "gg^")
map("v", "gg", "gg^")

-- <NORMAL MODE, VISUAL MODE> Gを押した時、行の末尾の後ろに移動するようにマッピング
map("n", "G", "G$")
map("v", "G", "G$")

-- <NORMAL MODE, INSERT MODE> p, Ctrl + pでペースト時、INSERT MODEのペーストと同じ動作にするようにマッピング
map("n", "p", "i<C-r>+<Esc>")
map("i", "<C-p>", "<C-r>+")
map("i", "<C-ｐ>", "<C-r>+")

-- 
map("n", "K", ":bn<CR>")
map("n", "J", ":bp<CR>")

