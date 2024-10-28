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
                top_align = "center"
            }
        },
        position = "50%",
        size = {
            width = 80,
            height = 30
        },
        buf_options = {
            modifiable = false,
            readonly = true
        }
    })

    vim.api.nvim_buf_set_lines(popup.bufnr, 0, 1, false, vim.split(command_list, "\n"))

    popup:map("n", ",,", function()
        popup:unmount()
    end, { noremap = true })

    popup:mount()
end

vim.api.nvim_create_user_command("S", show_commands, {})

