#  Source Switcher

A menu bar app to change input source swiftly using shortcuts on macOS Big Sur and later.

## Introduction

This app uses `Applescript` to manipulate `UI operation` which is better than using `Carbon` (a framework most of whose APIs are deprecated) in other tools to change input source.

## Installation / Usage

Download the release version and drop `Source Switcher.app`  into your `Application` folder. (may not be the latest version)

Or clone this repo and build it on your Mac.

**Notice**: You should go to `System Preferences -> Security & Privacy -> Privacy -> Accessiblity` to make `Source Switcher` able to execute Applescript on your Mac.

## Background

Search "input source mac" on GitHub and there are plenty of repositories such as [hnakamur / inputsource](https://github.com/hnakamur/inputsource) and [minoki / InputSourceSelector](https://github.com/minoki/InputSourceSelector). They are command line software, but you can easily use Alfred to add shortcuts to switch input source conviniently. However, they have a common problem: when it comes to CJK such as Japanese, they don't work. (check [InputSourceSelector issues #2](https://github.com/minoki/InputSourceSelector/issues/2) (Japanese) and [stackoverflow questions #22885767](https://stackoverflow.com/questions/22885767/how-to-programmatically-switch-an-input-method-on-os-x) (English) to get more details)

After some analysis, I find that they all use `Carbon Core`, most of whose APIs are deprecated after macOS 10.8, and the `input source id` (eg. `com.apple.inputmethod.Kotoeri.RomajiTyping.Japanese`) to identify different input sources. 

[laishulu / macism](https://github.com/laishulu/macism) said it solves this problem. I'm not sure whether it works: it uses Carbon APIs and just stops for some time to deal with that problem...

Then how to solve it? The fact is, if we uses some mature exposed APIs provided by the system, issues not appear! To be concrete, we click the control center in the menu bar or switch input source in System Preferences instead of calling macOS APIs. They are kind of `UI things`.  

So one way is what [hatashiro / kawa](https://github.com/hatashiro/kawa) uses, which really solves that problem by using a method in `System Preferences -> Keyboard -> Shortcuts -> Input Sources -> Select the previous input source`. But issue still exists: if you change input source quickly, you find [kawa](https://github.com/hatashiro/kawa) doesn't work. This is because `Select the previous input source` has different functions when tap the shortcut (⌃␣ if you haven't changed it) at different speed. And this project also uses Carbon APIs. This will work (as far as I consider) if change `Select the previous input source` to `Select next source in input menu` (see [kawa pull #21](https://github.com/hatashiro/kawa/pull/21)). By the way, this repo closes issues...

**I use a completely _UI_ way to solve that problem.** Referring to [Geoff Taylor | Scripting the menu bar in macOS Big Sur](https://www.geofftaylor.me/2020/scripting-the-menu-bar-in-macos-big-sur/), I use  [UI Browser](https://pfiddlesoft.com/uibrowser/index.html) to find how to use Applesript to express the Input Source Panel in the menu bar (Control Center). Then refer to [Chris J. | How to launch an AppleScript from AppKit on Catalina with Swift](https://medium.com/macoclock/everything-you-need-to-do-to-launch-an-applescript-from-appkit-on-macos-catalina-with-swift-1ba82537f7c3) to use Applescript in macOS app (*which has a drawback that sandbox has to be disabled*). After getting the prototype, I design the UI of this app, make this app a menu bar app, add shortcuts to it and better its code logic to avoid some potential bugs.

## Open Source Projects that This App Uses

[menubarpopoverswiftui2](https://github.com/zaferarican/menubarpopoverswiftui2)

[LICENSE](https://github.com/zaferarican/menubarpopoverswiftui2/blob/master/LICENSE)


[KeyboardShortcuts](https://github.com/sindresorhus/KeyboardShortcuts)

[LICENSE](https://github.com/sindresorhus/KeyboardShortcuts/blob/main/license)

## About

Discuss about this app in the Discussion part. Any issue or pull request are welcome!

If you find this app saves your time or improves your efficency, feel free to [buy me a cup of coffee](https://yang-xijie.github.io/postscript/support.html) using WeChat Pay or Alipay.
