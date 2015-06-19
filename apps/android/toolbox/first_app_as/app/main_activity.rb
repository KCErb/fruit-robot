class MainActivity < Android::App::Activity

  TOAST = Android::Widget::Toast

  def onCreate(savedInstanceState)
    super
    setContentView(R::Layout::First_layout)
    button = findViewById(R::Id::My_button)
    button.onClickListener = self
  end

  def onClick(view)
    # get message from edit text
    edit_text = findViewById(R::Id::Edit_message)
    message = edit_text.text.toString

    # create intent and start next activity
    intent = Android::Content::Intent.new(self, DisplayMessageActivity)
    intent.putExtra('message', message)
    startActivity intent
  end

  def toast
    message = 'Howdy'
    toast = TOAST.makeText(self, message, TOAST::LENGTH_SHORT)
    toast.show
  end
end
