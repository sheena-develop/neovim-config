local vim = vim or require("vim")

-- 警告の出ているPerlとRubyのproviderを使わないので、無効化
vim.g.loaded_perl_provider = 0
vim.g.loaded_ruby_provider = 0

require("base")
require("autocmds")
require("options")
require("keymaps")
require("plugins")
require("win32yank-config")

-- require("noice").notify("Test notice.")

