class DisplayMessageActivity < Android::App::Activity
  TEXT_VIEW = Android::Widget::TextView
  attr_accessor :text_view

  def onCreate(savedInstanceState)
    super
    create_text_view
    setContentView(text_view)
  end

  def create_text_view
    @text_view = TEXT_VIEW.new(self)
    message = intent.getStringExtra('message')
    text_view.textSize = 40
    text_view.text = message
  end
end
