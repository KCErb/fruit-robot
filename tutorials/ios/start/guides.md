---
layout: page
title: The Guides
os: ios
category: start
order: 2
permalink: /ios/start/guides/
---

Throughout these tutorials one of my primary goals is to teach you how to translate the existing documentation for iOS into the actual code you'll be writing for RubyMotion.

For instance, in the template app that's
created when you call `motion create Hello`, we get the following `app_delegate.rb`

```ruby
class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    rootViewController = UIViewController.alloc.init
    rootViewController.title = 'Hello'
    rootViewController.view.backgroundColor = UIColor.whiteColor

    navigationController = UINavigationController.alloc.initWithRootViewController(rootViewController)

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigationController
    @window.makeKeyAndVisible

    true
  end
end
```

I want you to be able to get answers to questions like these on your own:

* What is a `UIViewController`? Why `alloc.init`?
* What is an `AppDelegate` and why is the first method `application` defined taking
two arguments, where the second one has . . . is that colon in the middle?!

# iOS Documentation

The iOS library is truly huge! There are 3 ways (that I know of) to access these documents.
Let's take a quick look at each

### Through the website

If you go to the main page for the iOS developer library you'll just find a [long-winded
list of seemingly random documents](https://developer.apple.com/library/ios/navigation/).

 If you already know which part of the API your class belongs to (unlikely), then you can navigate to it using the sidebar. Otherwise you'll just need to use the search feature.

{% include image.html width='' src='web-search.png' page=page %}

It's kinda picky, but in general you can tack "class ref" on the end of the class name you're looking for and get what you want.

Before I move on, I want you to notice something:

The result from the search tells us that the `UIViewController` belongs to the `UIKit` framework (inside the "Cocoa Touch Layer"). What does all that mean?
To answer this, you should definitely read (at least) the first page of the [iOS technology overview](https://developer.apple.com/library/ios/documentation/Miscellaneous/Conceptual/iPhoneOSTechOverview/Introduction/Introduction.html). It explains the concepts of layers and frameworks and is a great starting point. If you're interested, there is also a [framework index](https://developer.apple.com/library/ios/documentation/Miscellaneous/Conceptual/iPhoneOSTechOverview/iPhoneOSFrameworks/iPhoneOSFrameworks.html).

### Central Apple Developer Search

Another option available is the much cleaner [developer.apple.com/search](https://developer.apple.com/search/)

{% include image.html width='' src='apple-search.png' page=page %}

This will search the documentation I just showed you and much more. One nice feature of this tool is that it uses a smarter search algorithm to find relevant documents instead of doing a simple regex match.

### Xcode

The last option we'll look at is using the Xcode application. Just fire up Xcode and select `Help > Documentation and API Reference` from the menu. This tool definitely feels smarter, but be warned, it is only loading documentation from online, if you run out of internet you won't be getting any docs today.

{% include image.html width='' src='xcode-search.png' page=page %}

### Guides

Like Android, the iOS Library includes guides which are less technical and more topical. They are actually pretty hard to find unless you are using the Xcode search feature, but once you get there, they are a great resource that is well-worth perusing. The iOS development culture comes with strong [user experience recommendations](https://developer.apple.com/library/ios/documentation/UserExperience/Conceptual/MobileHIG/) and plenty of help to get you there.
