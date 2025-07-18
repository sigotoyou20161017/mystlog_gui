#いろいろライブラリ読み込む
import tkinter as tk
import subprocess
import os

# === 設定 ===
#実行するバッチと読み込むファイルを指名

BAT_FILE = "mystlog.bat"
LOG_FILE = "mystlog.txt"

# === バッチファイル実行関数 ===
def run_batch():
    try:
        # バッチファイルを現在のフォルダで実行（cmdを非表示で）
        #成功したら何もしない、失敗したらエラーを返す、って処理
        #- 「EAFP」（Easier to Ask Forgiveness than Permission）というらしい
        subprocess.run(["cmd", "/c", BAT_FILE], check=True)
    except subprocess.CalledProcessError as e:
        log_text.set(f"Error: バッチファイルの実行に失敗しました\n{e}")
        return

    # ログファイル読み込み
    if os.path.exists(LOG_FILE):
        with open(LOG_FILE, "r", encoding="utf-8") as f:
            lines = f.readlines()
            if lines:
                log_text.set(lines[-1].strip())  # 最終行だけ表示
            else:
                log_text.set("ログファイルが空です")
    else:
        log_text.set("ログファイルが見つかりません")

# === GUIセットアップ ===
#GUI系積み立てていく
#ウインドウ本体
root = tk.Tk()
#タイトル
root.title("Mystery Log Viewer")

# ラベル
#テキスト入れる変数
log_text = tk.StringVar()
#テキスト欄
log_label = tk.Label(root, textvariable=log_text, font=("Consolas", 12), wraplength=500, padx=10, pady=10)
#ここで組み立て
log_label.pack()

# 実行ボタン
run_button = tk.Button(root, text="ログ生成＆表示", command=run_batch)
run_button.pack(pady=10)

# 初期状態（まだログは読み込まない）
log_text.set("ボタンを押してログを生成")

# ウィンドウ起動
root.mainloop()

#全体的に上から読めばけりが付く
#再利用を考えてないシンプルな構造