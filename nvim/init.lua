require("base")
require("autocmds")
require("options")
require("keymaps")
require("colorscheme")
require("plugins")

require("lualine-config")
require("tabline-config")
require("mini-indentscope-config")
require("noice-config")

-- リストモードを有効にする
vim.o.list = true

-- スペース、タブ、全角スペースの可視化
vim.o.listchars = "space:·,tab:→\\ ,trail:·,nbsp:␣"

-- 全角スペースの可視化（オプション）
if vim.fn.has("multi_byte") == 1 then
    vim.o.listchars = vim.o.listchars .. ",multispace:□"
end

-- require("noice").notify("wwwwwwwwwwwwwwwwwwww")
