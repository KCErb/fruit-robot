---
layout: android_page
title: BluePotion
os: android
category: toolbox
order: 4
permalink: /android/toolbox/blue-potion/
---

Now for the moment you've been waiting for . . .

ladies and gentlemen . . .

I give you (a link to): [BluePotion](https://github.com/infinitered/bluepotion)

## Something Cool

BluePotion is very cool and it is also very alpha which means what I write here will
need to be updated as things . . . mature.

To build something cool (your first BluePotion app) do the following (as noted on the website):

```
gem install bluepotion
bluepotion create myapp
cd myapp
bundle
rake newclear
```

If that crashes (like it did for me) then you should do the following (not noted on the website):

```
brew install gradle
rake newclear
```

{% include image.html width='250px' src='blue_potion.png' page=page %}

Before we dig into the contents of your demo app, allow me to define some important terms that came up:

* **gradle** - In the old days android apps were built with maven / apache ant. Nowadays
we build'em with gradle. Since I don't know anything about `build`ing I'll leave it there.

* **newclear** - Newclear is a nice little rake-task for RubyMotion built by IconoclastLabs. You should definitely check out [their readme](https://github.com/IconoclastLabs/newclear) because it is entertaining and informative.

## Something Borrowed

If you dig into the project structure you'll see a lot of things. Let's start with
familiar territory by checking out the `Rakefile`:

```ruby
app.api_version = "16"
app.target_api_version = "16"

# Default build ONLY for Genymotion Emulator
app.archs = ["x86"] unless ARGV.include?("device") || ARGV.include?("archive")

app.name = "myapp"
app.package = "com.your_company.myapp"
app.theme = "@android:style/Theme.Holo.Light"
#app.permissions = [:internet, :access_network_state, :access_coarse_location,:access_fine_location, :write_external_storage]
app.version_name = "0.0.1"
app.icon = 'ic_launcher'

app.application_class = "BluePotionApplication"
app.main_activity = "PMHomeActivity"
app.sub_activities += %w(PMSingleFragmentActivity PMNavigationActivity)

app.gradle do
  # Google's networking API for Android
  dependency "com.mcxiaoke.volley", :artifact => "library", :version => "1.0.10"
end
```

Whereas our first look at a Rakefile used the bare minimum to get things going, this one is showing us the bare minimum for realistic app-development. Go ahead and absorb what you see here. As I continue to work through the Android docs, we'll come back to some of these, but today I'll point out two that are responsible for the nicer look:

* `app.theme` is responsible for the white background. The default is Holo.Dark, and those are the [only two](https://developer.android.com/training/basics/actionbar/styling.html#AndroidThemes) (standard themes that are) available.
* `app.icon` is responsible for the sleek icon in conjunction with the files in the `resources/drawable` directories (more on these in another lesson).

## Something New

Now let's take a look at that app folder! The only non-empty subdirectories are `screens/`, `stylesheets/`, and `views/`. The goal of BluePotion is to create a companion to RedPotion. We'll look more directly at RedPotion in the iOS tutorials, but for now I'll put it like this: RedPotion is a conglomerate gem for combining a bunch of useful gems that have been created for iOS-based RubyMotion development. The two we want to look at right now to better understand BluePotion are [ProMotion](https://github.com/clearsightstudio/ProMotion) and [Ruby Motion Query (RMQ)](http://rubymotionquery.com/).

Blue Potion is working to re-create both of these essential libraries for Android development so let's take a quick look at them.

### ProMotion

First let's take a look in our `views` directory at the appropriately named starter file: `bluepotion_application.rb`

```ruby
class BluePotionApplication < PMApplication

  home_screen HomeScreen

  def on_load
  end
end
```

This view gives our application *ProMotion* attributes by setting `PMApplication` as the super-class and then declares the app's Home Screen to be a class called `HomeScreen`. As all good screens we put this one in the `screens` directory.

```ruby
class HomeScreen < PMScreen

  # If you are using XML for this screen:
  #uses_xml :xml_file_name
  #xml_widgets :some_widget
  #xml_fragments :some_fragment

  uses_action_bar true
  title "Your title here"
  stylesheet HomeScreenStylesheet

  # This is optional, it will default to a RelativeLayout
  #def load_view
    #Potion::LinearLayout.new(self.activity)
  #end

  def on_load
    append(Potion::TextView, :hello_label)
  end
end
```

Does this remind you a little of our `MainActivity` class from the first tutorial? Can you immediately see how you could approach this either via XML or programmatically? Do the answers to these questions excite you the same way they excite me?

Good.


There's a lot to learn about BluePotion, so in this first lesson, I want a take-home message to be: instead of creating activities and placing views in them, we're going to create an application and place screens in it.

### RMQ

While we're looking at our first screen, we'll see some things that actually belong
to RMQ. (That's the whole point of BluePotion, to combine these tools!)

RMQ provides stylesheets and a jQuery-like interface for setting-up things like click events (often called "touch" or "tap" events), and appending / hiding / removing elements from the app. I definitely recommend giving [the docs](http://rubymotionquery.com/documentation) a quick peak because they are truly fantastic.

In this example app, we see some RMQ in action in the class-method `stylesheet` and
the `append` call in `on_load`. To round off this introduction, let's find out where those things are defined.

First the `home_screen_stylesheet`:

```ruby
class HomeScreenStylesheet < ApplicationStylesheet

  def setup
    # Add stylesheet specific setup stuff here.
    # Add application specific setup stuff in application_stylesheet.rb
  end

  def root_view(st)
    st.layout_width = :full
    st.layout_height = :full
    st.gravity = :center
  end

  def hello_label(st)
    standard_text_view(st)
    st.font = font.large
    st.color = color.black
    st.text = "Hello"
  end

end
```

We've moved *style* aspects of the screen over here. Recognize `layout_width` and `layout_height`? (We haven't talked about gravity yet).

Also notice that our string resource is found here as the method `hello_label` (look back at the screen; it referenced this method as a symbol).

One of RMQ's goals is "no magic", and that's a goal I can get down with. An example of this is that `font.large` is not a magic helper, but a thing defined in the other stylesheet this app has: the `ApplicationStylesheet`:

```ruby
class ApplicationStylesheet < RMQStylesheet

  def application_setup

    # An example of setting standard fonts and colors
    font_family = "sans-serif"
    font.add_named :xlarge,         font_family, 40, :normal
    font.add_named :large,          font_family, 30, :normal
    font.add_named :medium,         font_family, 24, :normal
    font.add_named :medium_bold,    font_family, 24, :bold
    font.add_named :small,          font_family, 18, :normal
    font.add_named :tiny,           font_family, 14, :normal

    color.add_named :potion_blue,   "#3759FE"
    color.add_named :mustard,       "#FFFF00"
  end

  def standard_text_view(st)
    st.layout_width = :wrap_content
    st.layout_height = :wrap_content
    st.margin_bottom = 12
  end

end
```

Access to these methods is (relatively) straight-forward since (if you look back) the `HomeScreenStylesheet` inherited from the `ApplicationStylesheet`.

## Something Blue

And that's it for my introduction to BluePotion. The rest of these tutorials will be written using BluePotion so don't worry, we'll be digging *a lot* more into this fantastic gem as time goes on!
