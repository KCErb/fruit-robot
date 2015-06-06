class MainActivity < Android::App::Activity
  def onCreate(savedInstanceState)
    super
    layout = Android::Widget::LinearLayout.new(self)
    layout.orientation = Android::Widget::LinearLayout::HORIZONTAL

    @edit_text = Android::Widget::EditText.new(self)
    layout.addView @edit_text
    self.contentView = layout
  end
end
