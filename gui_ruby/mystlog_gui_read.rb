require 'fox16'  # FXRubyライブラリ(ruby用 FOX Toolkitライブラリ、
#ウインドウとかボタンのまとまり)を読み込む

include Fox  # 名前空間Foxを省略してに使えるようにする、この場合、FOXライブラリの頭が省略できる

# メインウィンドウクラスの定義、文字通りウインドウ作っている
#クラスMystLogAppを作って、FXMainWindow、FXRubyライブラリを継承させる
class MystLogApp < FXMainWindow
  def initialize(app)
    # ウィンドウの基本設定（タイトル、サイズ）
    #親クラスFXMainWindow、要はFXRubyを引き出して初期化してくる
    #んで600*600のウインドウ作る
    super(app, "Mystery Log Viewer (FXRuby)", width: 600, height: 400)

    # 縦方向のレイアウトフレーム（中身を縦に積む）
    #ウインドウの上に土台作ってる
    vframe = FXVerticalFrame.new(self, LAYOUT_FILL_X|LAYOUT_FILL_Y)

    # テキストビュー（ログ表示用の読み取り専用エリア）
    #の部品群、コンテナ内いっぱいに、折り返しで、読み取り専用、
    #自動改行を読みだしてる
    @text_view = FXText.new(vframe, nil, 0,
      LAYOUT_FILL_X|LAYOUT_FILL_Y|TEXT_WORDWRAP|TEXT_READONLY|TEXT_AUTOSCROLL)

    # ボタン（押すとバッチ実行→ログ表示）
    #押した後の挙動(ログ生成メソッド)はあとにつくってある
    button = FXButton.new(vframe, "ログ生成＆表示")
    button.connect(SEL_COMMAND) do
      generate_and_show_log  # ボタンが押されたらログ生成＆表示メソッドを呼び出す
    end
  end

  # ウィンドウの作成（FXRubyではcreate後にshowが必要）
  #ウインドウ作る部分とウインドウ表示する部分が分かれてる、誤爆防止
  def create
    super
    show(PLACEMENT_SCREEN)  # 画面中央にウィンドウを表示
  end

  # ログ生成バッチの実行と、ログファイルの読み込み表示
  #ボタンの呼び出し先
  def generate_and_show_log
    system("cmd /c mystlog.bat")  # 外部バッチファイルを実行（cmd経由）

    if File.exist?("mystlog.txt")  # 出力ファイルがあれば読み込んで表示
      content = File.read("mystlog.txt", encoding: 'UTF-8')
      @text_view.text = content
    else
      @text_view.text = "ログファイルが見つかりません"
    end
  end
end

# アプリケーション起動処理（最初にFXAppを作るのがポイント）
#一回起動したら操作待ち、対応をし続けてる
if __FILE__ == $0
  app = FXApp.new("MystLogApp", "FXRuby")  # FXRubyアプリのインスタンス作成
  MystLogApp.new(app)                      # メインウィンドウを作成
  app.create                               # ウィジェットの構造を作成
  app.run                                  # メインループを開始
end
