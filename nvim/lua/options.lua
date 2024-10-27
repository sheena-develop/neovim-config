-----------------------------------------------------------
-- General Neovim settings and configuration
-----------------------------------------------------------
local opt = vim.opt                          -- オプションを設定 (グローバル/バッファ/ウィンドウ範囲)
vim.cmd("highlight LineNr guifg=#8A70AC")    -- 行番号の色を変更

-----------------------------------------------------------
-- General
-----------------------------------------------------------
opt.clipboard = "unnamedplus"    -- システムクリップボードへのコピー/ペースト
opt.mouse = ""                   -- マウスサポートを有効化

-----------------------------------------------------------
-- File
-----------------------------------------------------------
opt.encoding = "UTF-8"        -- ファイルのエンコーディング
opt.fileencoding = "UTF-8"    -- ファイルのエンコーディング
opt.swapfile = false          -- スワップファイルを使用しない
opt.hidden = true             -- バックグラウンドバッファを有効にする

-----------------------------------------------------------
-- Menu, Command
-----------------------------------------------------------
opt.laststatus = 2     -- グローバルステータスラインを設定
opt.wildmenu = true    -- コマンドラインで補完を有効化
opt.cmdheight = 1      -- コマンドラインの表示行数
opt.showcmd = true     -- コマンドラインに入力されたコマンドを表示

-----------------------------------------------------------
-- Search, Replace
-----------------------------------------------------------
opt.hlsearch = true     -- ハイライト検索を有効にする
opt.incsearch = true    -- インクリメンタルサーチを有効にする
opt.matchtime = 1       -- 入力された文字列がマッチするまでにかかる時間

-----------------------------------------------------------
-- Neovim UI
-----------------------------------------------------------
opt.background = "dark"          -- ダークカラーを使用する
opt.termguicolors = true         -- 24ビットカラーを使用
opt.number = true                -- 行番号を表示
opt.cursorline = true            -- カーソル行をハイライト
opt.guicursor = { "a:block" }    -- GUIカーソルスタイルを設定
opt.showtabline = 1              -- タブラインを表示する設定
opt.showmatch = true             -- 対応する括弧をハイライト表示
opt.signcolumn = "yes"           -- サインカラムを表示
opt.wrap = true                  -- テキストの自動折り返しを有効に
opt.visualbell = false           -- ビープ音の代わりに画面をフラッシュ
opt.winblend = 0                 -- ウィンドウの不透明度
opt.pumblend = 0                 -- ポップアップメニューの不透明度

-----------------------------------------------------------
-- Tabs, indent
-----------------------------------------------------------
opt.expandtab = true      -- タブ文字をスペースに置き換える
opt.autoindent = true     -- 自動インデントを有効にする
opt.smartindent = true    -- インデントをスマートに調整する
opt.shiftwidth = 4        -- シフト幅を4に設定する
opt.tabstop = 4           -- タブ幅を4に設定する
opt.list = true           -- リストを有効化
-- 半角スペース、タブ、改行を可視化
opt.listchars = { space = "·", tab = "-->", eol = "↵" }
-- 全角スペースを可視化
vim.cmd[[
  hi DoubleByteSpace term=underline ctermbg=blue guibg=darkgray
  match DoubleByteSpace /　/
]]

