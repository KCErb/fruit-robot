class MainActivity < Android::App::Activity

  LAYOUT = Android::Widget::LinearLayout
  EDIT_TEXT = Android::Widget::EditText
  BUTTON = Android::Widget::Button
  TOAST = Android::Widget::Toast

  attr_accessor :layout, :edit_text, :button

  def onCreate(savedInstanceState)
    super
    create_layout
    create_edit_text
    create_button
    self.contentView = layout
  end

  def create_layout
    @layout = LAYOUT.new(self)
    layout.orientation = LAYOUT::HORIZONTAL
  end

  def create_edit_text
    @edit_text = EDIT_TEXT.new(self)
    edit_text.hint = 'Enter Some Text!'
    layout.addView edit_text
    layout_params = edit_text.layoutParams
    layout_params.weight = 1
  end

  def create_button
    @button = BUTTON.new(self)
    button.text = 'Send'
    layout.addView button
    button.onClickListener = self
  end

  def onClick(view)
    # get message from edit text
    message = edit_text.text.toString

    # create intent and start next activity
    intent = Android::Content::Intent.new(self, DisplayMessageActivity)
    intent.putExtra('message', message)
    startActivity intent
  end
end
