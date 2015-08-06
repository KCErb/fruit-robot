class AppDelegate
  attr_reader :nav_controller, :home_controller, :window, :text_field, :button

  def application(application, didFinishLaunchingWithOptions: launchOptions)
    create_controllers
    create_window
    create_text_field
    create_button
    true
  end

  def create_controllers
    @home_controller = UIViewController.alloc.init
    home_controller.title = 'FirstApp'
    home_controller.view.backgroundColor = UIColor.whiteColor
    @nav_controller = UINavigationController.alloc.initWithRootViewController(home_controller)
  end

  def create_window
    screen_frame = UIScreen.mainScreen.bounds
    @window = UIWindow.alloc.initWithFrame(screen_frame)
    window.rootViewController = nav_controller
    window.makeKeyAndVisible
  end

  def create_text_field
    text_field_frame = CGRectMake(15, 80, 265, 40)
    @text_field = UITextField.alloc.initWithFrame(text_field_frame)
    style_text_field
    home_controller.view.addSubview(text_field)
  end

  def create_button
    @button = UIButton.buttonWithType(UIButtonTypeSystem)
    style_button
    home_controller.view.addSubview(button)
  end

  def send_message
    new_view_controller = UIViewController.alloc.init
    new_view_controller.title = 'Check Text'
    new_view_controller.view.backgroundColor = UIColor.whiteColor

    text_view_frame = CGRectMake(15, 80, 265, 40)
    text_view = UITextView.alloc.initWithFrame(text_view_frame)
    text_view.text = text_field.text
    text_view.font = UIFont.systemFontOfSize(25)
    text_view.editable = false
    new_view_controller.view = text_view

    nav_controller.pushViewController(new_view_controller, animated: true)
  end

  private

  def style_text_field
    text_field.borderStyle = UITextBorderStyleRoundedRect
    text_field.font = UIFont.systemFontOfSize(15)
    text_field.placeholder = 'Enter text here'
    text_field.autocorrectionType = UITextAutocorrectionTypeNo
    text_field.keyboardType = UIKeyboardTypeDefault
    text_field.returnKeyType = UIReturnKeyDone
    text_field.clearButtonMode = UITextFieldViewModeWhileEditing
    text_field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter
    text_field.delegate = self
  end

  def style_button
    button_frame = CGRectMake(285, 80, 80, 40)
    button.frame = button_frame
    button.setTitle('Send', forState: UIControlStateNormal)
    add_border(button)
    button.addTarget(self, action: :send_message, forControlEvents: UIControlEventTouchUpInside)
  end

  def add_border(view)
    view.layer.cornerRadius = 4
    view.layer.masksToBounds = true
    view.layer.borderColor = UIColor.colorWithRed(0.0, green: 122.0/255.0, blue: 1.0, alpha: 1.0).CGColor
    view.layer.borderWidth = 1
    view
  end
end
