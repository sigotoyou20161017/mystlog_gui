require 'fox16'

include Fox

class MystLogApp < FXMainWindow
  def initialize(app)
    super(app, "Mystery Log Viewer (FXRuby)", width: 600, height: 400)

    vframe = FXVerticalFrame.new(self, LAYOUT_FILL_X|LAYOUT_FILL_Y)

    @text_view = FXText.new(vframe, nil, 0,
      LAYOUT_FILL_X|LAYOUT_FILL_Y|TEXT_WORDWRAP|TEXT_READONLY|TEXT_AUTOSCROLL)

    button = FXButton.new(vframe, "ログ生成＆表示")
    button.connect(SEL_COMMAND) do
      generate_and_show_log
    end
  end

  def create
    super
    show(PLACEMENT_SCREEN)
  end

  def generate_and_show_log
    system("cmd /c mystlog.bat")

    if File.exist?("mystlog.txt")
      content = File.read("mystlog.txt", encoding: 'UTF-8')
      @text_view.text = content
    else
      @text_view.text = "ログファイルが見つかりません"
    end
  end
end

if __FILE__ == $0
  app = FXApp.new("MystLogApp", "FXRuby")   # ← ここを先に作るのが重要
  MystLogApp.new(app)
  app.create
  app.run
end
