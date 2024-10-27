# Neovim Configuration Guide

このガイドは、以下の環境でNeovimをセットアップする手順を説明しています。

## 対象環境

- **OS**: Windows 10/11
- **サブシステム**: WSL2(Ubuntu)
- **エディタ**: Neovim
- **ターミナル**: Windows Terminal
- **フォント**: 0xProto Nerd Font

---

## 1. Neovimのセットアップコマンド

1. プラグインマネージャのセットアップ:</br>
   `:PackerInstall`
   `:PackerSync`
   `:PackerUpdate`

2. Treesitterのインストール:</br>
   `:TSInstall all`

3. **Ubuntu環境の準備**
   コンパイルに必要なツールをインストールします:</br>
   `sudo apt install build-essential`

---

## 2. フォント設定

Neovimでアイコンなどを表示するため、Nerdフォントのインストールを推奨します。

- **フォントのダウンロード**:
  [0xProto GitHubページ](https://github.com/0xType/0xProto)

---

## 3. Windows Terminalの設定

Windows Terminalで使用するフォントや透明度をカスタマイズするには、`settings.json`を編集します。

```
{
  "profiles": {
    "defaults": {
      "font": {
        "face": "0xProto Nerd Font"
      },
      "opacity": 85,
      "useAcrylic": false
    },
    "list": [
      ...
    ]
  }
}
```

---

## 4. リポジトリのクローン

Neovimの設定リポジトリをクローンするためのコマンド:</br>
`git clone [Repository URL] ~/.config`

**注意**: `~/.config`ディレクトリが既に存在し、他の設定が保存されている場合、このコマンドは上書きのリスクがあるため注意してください。

---

## 5. README.mdの表示方法

Chrome拡張機能を利用し、README.mdをブラウザで表示できます。

- **拡張機能**: [Markdown Viewer](https://chromewebstore.google.com/detail/markdown-viewer/ckkdlimhmcjmikdlpkmbgfkaikojcbjk?hl=ja)
- **表示コマンド**: Chromeで`README.md`を表示するスクリプトを用意します。
  `sh open-readme.sh`

---

## 6. コミットメッセージの規則

コミットメッセージの一貫性と明確さを保つために、Semantic Commit Message の規則を採用しています

:wrench: chore: (タスクファイルなどプロダクションに影響のない修正、実稼働のコードの変更は含めない)

    🔧 chore: デバッグ用のログを削除

:memo: docs: (ドキュメントの更新)

    📝 docs: API の使用方法を README に追記

:sparkles: feat: (ユーザー向けの機能の追加や変更)

    ✨ feat: ユーザープロフィール画面の追加

:bug: fix: (ユーザー向けの不具合の修正)

    🐛 fix: ログイン時のエラーハンドリングを修正

:recycle: refactor: (リファクタリングを目的とした修正)

    ♻️ refactor: 変数名を明確にするためのリファクタリング

:art: style: (スタイルやセミコロンの欠落などの修正、実稼働のコードの変更は含めない)

    🎨 style: コードのインデントを修正

:microscope: test: (テストコードの追加や修正、実稼働のコードの変更は含めない)

    🔬 test: 新規登録機能のユニットテストを追加

:construction_worker: ci: (環境構築に関わる追加や修正)

    👷 ci: バージョン変更に伴う Dockerfile の修正

---

## 7. プラグイン情報

- **`packer.nvim`**
  - **役割**: Neovimのプラグインマネージャーで、プラグインのインストールや管理、依存関係の設定を簡単に行えます。
  - **URL**: [packer.nvim](https://github.com/wbthomason/packer.nvim)

- **`tokyonight.nvim`**
  - **役割**: `Tokyo Night`カラースキームを提供するプラグインで、NeovimのUI全体をスタイリッシュにカスタマイズできます。
  - **URL**: [tokyonight.nvim](https://github.com/folke/tokyonight.nvim)

- **`nvim-treesitter`**
  - **役割**: Neovimにシンタックスハイライトを追加し、コード解析やリファクタリングなどの機能を強化します。
  - **URL**: [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter)

- **`lualine.nvim`**
  - **役割**: 高機能なステータスラインプラグインで、状態表示のデザインを向上させます。
  - **URL**: [lualine.nvim](https://github.com/nvim-lualine/lualine.nvim)

- **`nvim-web-devicons`**
  - **役割**: ファイルアイコンを提供するプラグインで、さまざまなプラグインと連携してファイルタイプのアイコン表示をサポートします。
  - **URL**: [nvim-web-devicons](https://github.com/nvim-tree/nvim-web-devicons)

- **`tabline.nvim`**
  - **役割**: タブやバッファーのリストを表示するためのプラグイン。`nvim-web-devicons`との連携により、ファイルアイコンも表示できます。
  - **URL**: [tabline.nvim](https://github.com/kdheepak/tabline.nvim)

- **`mini.indentscope`**
  - **役割**: インデントガイドを表示するプラグインで、コードの構造を可視化しやすくします。
  - **URL**: [mini.indentscope](https://github.com/echasnovski/mini.nvim)（`mini.indentscope`は`mini.nvim`のモジュールです）

- **`noice.nvim`**
  - **役割**: コマンドラインや通知の表示方法をカスタマイズし、NeovimのUXを改善します。
  - **URL**: [noice.nvim](https://github.com/folke/noice.nvim)

- **`nui.nvim`**
  - **役割**: NeovimのUIをカスタマイズするためのライブラリで、他のプラグイン（例: `noice.nvim`）と連携してモーダルウィンドウやポップアップの表示を支援します。
  - **URL**: [nui.nvim](https://github.com/MunifTanjim/nui.nvim)

- **`nvim-notify`**
  - **役割**: Neovim内での通知を表示するためのプラグインで、`noice.nvim`や他のプラグインと連携して使われます。
  - **URL**: [nvim-notify](https://github.com/rcarriga/nvim-notify)

- **`neo-tree.nvim`**
  - **役割**: 高機能なファイルエクスプローラ-で、Neovim内でのファイル操作を簡単に行えます。
  - **URL**: [neo-tree.nvim](https://github.com/nvim-neo-tree/neo-tree.nvim)

- **`plenary.nvim`**
  - **役割**: Neovimプラグイン開発向けの共通ライブラリで、便利な関数や機能を提供し、他の多くのプラグインの依存先として使用されます。
  - **URL**: [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)

- **`gitsigns.nvim`**
  - **役割**: Gitの変更を行ごとに表示するプラグインで、行の変更、追加、削除が視覚的にわかりやすくなります。
  - **URL**: [gitsigns.nvim](https://github.com/lewis6991/gitsigns.nvim)

- **`image.nvim`**
  - **役割**: `neo-tree` で画像のプレビューなどをサポートするプラグインです。
  - **URL**: [image.nvim](https://github.com/3rd/image.nvim)

