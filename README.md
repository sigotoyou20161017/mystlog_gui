# mystlog_gui
**Mystery Log Generator with GUI (Python and Ruby versions)**

せっかくなので、PythonとRubyのGUIそれぞれを触ってみて、  
その二つを比較してみることにする。
ついでにredomeはmd言語の練習にそれっぽく書く

---

## 📋 プラン

1. 適当なプログラム、今回はダミーログを吐き出す装置を作る  
2. それをPythonおよびRubyでGUI化する  
3. 視覚的に比較する

---

## 🧪 ログ生成部分のコード（バッチファイル）

それぞれのGUIコードからこのスクリプトを呼び出し、  
結果を受け取ってGUIに反映すればいいだろう。

```bat
@echo off
setlocal enabledelayedexpansion

:: 出力ファイル名
set "logfile=mystlog.txt"

:: ログメッセージの候補を配列的に持たせる
set count=6
set msg1=Sync complete: Node delta exceeded entropy limit.
set msg2=Warning: Temporal vector drift detected near anchor 4B.
set msg3=Info: Shadow trace preserved. Context level: green.
set msg4=Error: Entanglement pulse lost in channel 7A.
set msg5=Debug: Phase noise correction delayed by 12ms.
set msg6=Notice: Observer pattern mismatch in sector 21.

:: 現在時刻取得
for /f "tokens=1-3 delims=/: " %%a in ("%time%") do (
    set "hour=%%a"
    set "min=%%b"
    set "sec=%%c"
)

:: 日付取得（YYYY-MM-DD形式に整形）
for /f "tokens=1-3 delims=/ " %%a in ("%date%") do (
    set "year=%%c"
    set "month=%%a"
    set "day=%%b"
)
if 1%month% LSS 110 set month=0%month%
if 1%day% LSS 110 set day=0%day%

:: ランダム選択
set /a index=%random%%%count + 1
set "message=!msg%index%!"

:: ログ出力
echo [%year%-%month%-%day% %hour%:%min%:%sec%] !message! >> %logfile%

:: 実行後メッセージ
echo Log saved: %logfile%
::最後のpauseはテスト時はあったほうがいい、組み込んだ後は消したほうがいい
pause
```

## 🤷‍♂️ なんか書いとけ
いや、これだけのシンプルなツールなんで書いとくことない。
