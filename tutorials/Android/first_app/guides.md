---
layout: page
title: The Guides
os: android
category: first_app
order: 2
permalink: /android/firstapp/guides/
---

One of my primary focuses in these tutorials is to set you free, give you wings of your own! When we are through here, I want you to be able to build any app you can dream of. That means I've got to get you using the Android [API Guides](https://developer.android.com/guide/index.html) and [Reference](https://developer.android.com/reference/packages.html) like a pro.

In these tutorials, I'm going to spend some time teaching you how to understand these manuals and convert them into RubyMotion. If you're already familiar with the Android API, or the Java programming language, then some of this might seem a little tedious because I'm going to assume you are like me: completely unfamiliar with Java, and new to the Android APIs.

## Guides vs Reference

Before I go further, I want to be clear that when I say the "guides" I mean [these](https://developer.android.com/guide/index.html) and when I say the API "reference" or docs I mean [this](https://developer.android.com/reference/packages.html).

They are different things! If you'll explore these two pages for a bit you'll see that they have different but
related purposes.

If learning Android development is like traveling to a foreign country, the guides are written to help familiarize you with Android culture, philosophy, and language. It's expected that you'll peruse them before you get on the plane and continue to read them while there. On the other hand, the reference is meant to be your pocket dictionary, ready at hand if you should find yourself surrounded by hostile natives,
or worse, unsure of how to order your eggs!

## Example

As an example of what I mean, let's take a preview of the first app (next lesson).

> The first thing we're going to do is build a simple user interface.
To start, let's create a new project like so:

> `$ motion create --template=android first_app`

> Let's go into the new directory that was created and open up `app/main_activity.rb`.

>```ruby
class MainActivity < Android::App::Activity
  def onCreate(savedInstanceState)
    super
  end
end
```

What's an `Activity`? Why is the method called `onCreate` instead of `initialize`?
And what does the `savedInstanceState` variable hold in store for us?

In short, you'll want to read about Activities [here](https://developer.android.com/guide/components/activities.html) and you can
learn more about the `onCreate` method of an [`Android::App::Activity`](https://developer.android.com/reference/android/app/Activity.html) [here](https://developer.android.com/reference/android/app/Activity.html#onCreate(android.os.Bundle)). But don't worry about that right now. We'll slowly get into these things at the right time. For now, I recommend you pause and give the [App Fundamentals](https://developer.android.com/guide/components/fundamentals.html) a quick read. And if you're interested keep on going. What I put here will make more sense if you read those, but on the flip side, I think those
will make more sense after you've seen what's in here.

So do both!
