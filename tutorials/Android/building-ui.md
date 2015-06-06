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

For this app, the goal is to have the user input some text, push a button, and have it displayed in a new window. This is based (loosely) on [a training](https://developer.android.com/training/basics/firstapp/building-ui.html) from the android developer [website](https://developer.android.com/training/index.html). You may find it helpful to read through that tutorial to get a feel for similarities and differences between Motion and traditional app development.

## Activities

Hopefully by now you've had a chance to read both the [guide on activities](https://developer.android.com/guide/components/activities.html) and have perused the [reference on them](https://developer.android.com/reference/android/app/Activity.html). You can quickly access either by going to the top right corner where the magnifying glass is, and typing in the word "activity" like this:

{% include image.html width='' src='reference_search.png' page=page %}

From these guides you will have learned that an activity is the basic unit of display in Android OS architecture. If you want to show the user something, then you had better put that something into an activity. It's also important to understand that each activity acts as a new door into your app. None of them is inherently the "main" access point.

## Views

As explained in the Activity reference:

> Almost all activities interact with the user, so the Activity class takes care of creating a window for you in which you can place your UI with `setContentView(View)`

So we've got to build a view and attach it to the window.

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

## Add a TextField

## Add a Button


{% include image.html width='250px' src='basic_widget.png' page=page %}
