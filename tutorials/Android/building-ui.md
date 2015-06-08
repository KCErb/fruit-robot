---
layout: page
title: Building a Simple User Interface
category: android-start
order: 3
permalink: /android/firstapp/building-ui/
---

The first thing we're going to do is build a simple user interface.
To start, let's create a new project like so:

    $ motion create --template=android first_app

Let's go into the new directory that was created and open up `app/main_activity.rb`.

```ruby
class MainActivity < Android::App::Activity
  def onCreate(savedInstanceState)
    super
  end
end
```

For this app, the goal is to have the user input some text, push a button, and have it displayed in a new window. This is based (loosely) on [a training](https://developer.android.com/training/basics/firstapp/building-ui.html) from the android developer [website](https://developer.android.com/training/index.html). You may find it helpful to read through that tutorial to get a feel for similarities and differences between RubyMotion and traditional app development.

## Activities

Hopefully by now you've had a chance to read both the [guide on activities](https://developer.android.com/guide/components/activities.html) and have perused the [reference on them](https://developer.android.com/reference/android/app/Activity.html). You can quickly access either by going to the top right corner where the magnifying glass is, and typing in the word "activity" like this:

{% include image.html width='' src='reference_search.png' page=page %}

From these guides you will have learned that an activity is the basic unit of display in Android OS architecture. If you want to show the user something, then you had better put that something into an activity. It's also important to understand that each activity acts as a new door into your app. None of them is inherently the "main" access point.

## Views

As explained in the Activity reference:

> Almost all activities interact with the user, so the Activity class takes care of creating a window for you in which you can place your UI with `setContentView(View)`

So we've got to build a view and attach *it* to the window.

The view that we'll be using today is the [`LinearLayout`](https://developer.android.com/reference/android/widget/LinearLayout.html). Reading through [the guide](https://developer.android.com/guide/topics/ui/layout/linear.html) a bit you'll learn that a `LinearLayout` is a view group that we can use to combine several UI elements together:

{% include image.html width='' src='viewgroup_chart.png' page=page %}

<div style='font-size: 12px; text-align: right;'>
Image Source: <a href="https://developer.android.com/guide/topics/ui/overview.html">https://developer.android.com/guide/topics/ui/overview.html </a>
</div>

We'll use the horizontal orientation like so:

```ruby
layout = Android::Widget::LinearLayout.new(self)
layout.orientation = Android::Widget::LinearLayout::HORIZONTAL
```

Go ahead and fire that up and you should see . . . nothing, because the layout hasn't been
set as the content view of the activity (also because it's empty).

## Experiment

#### Set the orientation

Before going on, let's experiment a little. I'm just going to think of a bunch of alternate ways to do the same thing
and see if any of them work. I encourage you to do the same!

In the above code we used the constant `HORIZONTAL` that belongs to the `LinearLayout` class (go ahead and search through the reference and see if you can find each of the places this constant is mentioned), but could we also do a more ruby thing like:

```ruby
layout = Android::Widget::LinearLayout.new(self, orientation: :horizontal) # no
```

or this?

```ruby
layout = Android::Widget::LinearLayout.new(self)
layout.orientation = :horizontal # nope
```

what about
```ruby
layout.orientation = 'horizontal' # no
```

According to the reference the `HORIZONTAL` constant is just a reference to 0! So
does this work?

```ruby
layout.orientation = 0 # yes
```

#### More Methods: `get` and `set`

Note that `orientation=` is not a method defined on the `LinearLayout` class according to the docs. But we do have a `setOrientation`. So can we use that instead?

```ruby
layout.setOrientation(Android::Widget::LinearLayout::HORIZONTAL) # success
```

Similarly, the `getOrientation` method can be substituted for `orientation`.

```ruby
def onCreate(savedInstanceState)
  super
  layout = Android::Widget::LinearLayout.new(self)
  layout.orientation = Android::Widget::LinearLayout::HORIZONTAL

  puts layout.orientation.inspect
  puts layout.getOrientation.inspect
end
```

My output is:

```
I/com/yourcompany/first_app(12627): 0
I/com/yourcompany/first_app(12627): 0
```

(We'll get more into debugging in the future.)

You'll find it always true that a Java getter method can be replaced with the Ruby-like equivalent by dropping
 `get` from the beginning of the method name and using a snake_case version of the method name. And the
 setter can be replaced by a `method=` syntax. Like so:

 ```ruby
getMaxHeight => max_height
setMaxHeight => max_height=
 ```

## Add a TextField

OK, let's put a `View` into that `ViewGroup`. We want the app to accept some text as an input
and do something with it. A good widget for this is the [`EditText`](https://developer.android.com/reference/android/widget/EditText.html).

We create one and add it to the view like so:

```ruby
edit_text = Android::Widget::EditText.new(self)
layout.addView edit_text
```

and now we can put it all together by setting the `layout` as the `contentView` of
the activity

```ruby
class MainActivity < Android::App::Activity
  def onCreate(savedInstanceState)
    super
    layout = Android::Widget::LinearLayout.new(self)
    layout.orientation = Android::Widget::LinearLayout::HORIZONTAL

    edit_text = Android::Widget::EditText.new(self)
    layout.addView edit_text

    self.contentView = layout
  end
end
```

Please note that the `self` above is required in the call to `contentView`! (See
what happens when you leave it off.)

Now, when I run that with `rake device` I get the following:

{% include image.html width='250px' src='basic_widget.png' page=page %}


### Digging a Little Deeper

Since this is the first lesson, let's keep going into detail and exploring around.
These are just suggestions for things to play around with. I definitely encourage you
to ask lots of questions, experiment and search for answers in the docs.

#### Constructor vs Initialize

Both Java and Ruby create instances of classes by calling the
`.new` method on the class. For Ruby, `new` calls the `initialize` method that you define
and in Java `new` calls up a `constructor` of that class

So far I've taken for granted that we create instances of widgets like the `LinearLayout` or
`EditText` by calling `.new(self)`. To see what's really going on here, let's
 take a look at the `EditText` reference. We'll focus on the part that explains the constructors:

{% include image.html width='' src='edit_text_constructors.png' page=page %}

From these we see first that we always need a `Context`. The `Activity` is a Context so we pass in `self`.
The next two things that we can pass in have to do with creating customized widgets (such as subclassing
`Button` to make your own special `Button` class) and use XML. For now in the tutorials I don't want to talk much about
Android and XML so we'll leave these off.

#### More Methods: Weight

Our `EditText` looks kinda stumpy. If you hunt around for methods that handle size, width, and length you'll see
a lot of methods that go in the right direction, but you might feel like something is missing. The thing you're missing
is the concept of `weight`. There's a great little explanation from [the developer training](https://developer.android.com/training/basics/firstapp/building-ui.html) that this tutorial is based on:

> The weight value is a number that specifies the amount of remaining space each view should consume, relative to the amount consumed by sibling views. This works kind of like the amount of ingredients in a drink recipe: "2 parts soda, 1 part syrup" means two-thirds of the drink is soda. For example, if you give one view a weight of 2 and another one a weight of 1, the sum is 3, so the first view fills 2/3 of the remaining space and the second view fills the rest. If you add a third view and give it a weight of 1, then the first view (with weight of 2) now gets 1/2 the remaining space, while the remaining two each get 1/4.

So if we want the `EditText` to fill the width of the screen we'll give it a weight of 1.

 . . . work in progress . . .



## Add a Button
