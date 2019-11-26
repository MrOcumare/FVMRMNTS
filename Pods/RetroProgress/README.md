![RetroProgress](https://github.com/vadymmarkov/RetroProgress/blob/master/Images/cover.png)

[![CI Status](https://img.shields.io/circleci/project/github/vadymmarkov/RetroProgress.svg)](https://circleci.com/gh/vadymmarkov/RetroProgress)
[![Version](https://img.shields.io/cocoapods/v/RetroProgress.svg?style=flat)](http://cocoadocs.org/docsets/RetroProgress)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![License](https://img.shields.io/cocoapods/l/RetroProgress.svg?style=flat)](http://cocoadocs.org/docsets/RetroProgress)
[![Platform](https://img.shields.io/cocoapods/p/RetroProgress.svg?style=flat)](http://cocoadocs.org/docsets/RetroProgress)
![Swift](https://img.shields.io/badge/%20in-swift%204.0-orange.svg)

## Description

Do you miss the 90s? We know you do. Dial-up internet, flickering screens,
brightly colored websites and, of course, this annoyingly slow progress bar
that has been invented to test your patience. Yes, it was a while ago, but we
don't want it to be forgotten. Meet **RetroProgress**, a progress bar made to
cure your 90s nostalgia.

- [x] Easy to use and customizable progress bar.
- [x] Support for both progress value (0...1) and number of steps.
- [x] Progress animations.
- [x] No external dependencies.
- [x] [Playgrounds](https://github.com/vadymmarkov/RetroProgress/tree/master/Playgrounds).
- [x] [Demo project](https://github.com/vadymmarkov/RetroProgress/tree/master/Example/RetroProgressDemo).

## Table of Contents

<img src="https://github.com/vadymmarkov/RetroProgress/blob/master/Images/icon.png" width="202" height="203" alt="RetroProgress Icon" align="right" />

* [Usage](#usage)
* [Public properties](#public-properties)
* [Public methods](#public-methods)
* [Installation](#installation)
* [Author](#author)
* [Contributing](#contributing)
* [License](#license)

## Usage

Are you excited to bring this thing back from the dead? So are we. Let's use
default configuration and see what we get out-of-the-box:

```swift
let progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 360, height: 30))
progressView.animateProgress(to: 0.8)
```

<div align="center">
<img src="https://github.com/vadymmarkov/RetroProgress/blob/master/Images/example1.png" alt="RetroProgress" width="350" height="85" />
</div><br/>

Do you think it's way too retro? Let's try to make it more modern:

```swift
let progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 360, height: 30))

// Configure
progressView.layer.cornerRadius = 10
progressView.layer.borderColor = UIColor.black.cgColor
progressView.trackColor = .white
progressView.separatorColor = .black
progressView.progressColor = UIColor(
  red: 218/255,
  green: 236/255,
  blue: 255/255,
  alpha: 1
)

// Set progress
progressView.animateProgress(to: 0.8)
```

<div align="center">
<img src="https://github.com/vadymmarkov/RetroProgress/blob/master/Images/example2.png" alt="RetroProgress" width="350" height="85" />
</div><br/>

Not a fan of those separators? Let's try without them:

```swift
let progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 360, height: 30))

// Configure
progressView.numberOfSteps = 0
progressView.progressInset = .zero
progressView.layer.cornerRadius = 15
progressView.layer.borderColor = UIColor.white.cgColor
progressView.trackColor = .black
progressView.progressColor = .white

// Set progress
progressView.animateProgress(to: 0.8)
```

<div align="center">
<img src="https://github.com/vadymmarkov/RetroProgress/blob/master/Images/example3.png" alt="RetroProgress" width="350" height="85" />
</div><br/>

The options are limitless. Think big, now it's your turn to make the progress
bar great again.

## Public properties

* `numberOfSteps` - Maximum number of steps. Set to 0 to remove separators.
* `step` - Number of separators (0...numberOfSteps). Values outside are pinned.
* `progress` - 0...1, default is 0. Values outside are pinned.
* `progressInset` - The inner inset for progress bar and separators.
* `trackColor` - The color shown for the portion of the progress bar that is not filled.
* `progressColor` - The color shown for the portion of the progress bar that is filled.
* `separatorColor` - The color used for the step separators.
* `fullProgressAnimationDuration` - The duration for progress animation from 0 to 1.
* `separatorWidth` - The width of step separators.

## Public methods

* `animateProgress(to:duration:)` - Animates progress bar to the specified value (0...1).
* `animateSteps(to:duration:)` - Animates progress bar to the specified value (0...numberOfSteps).

## Installation

**RetroProgress** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RetroProgress'
```

**RetroProgress** is also available through [Carthage](https://github.com/Carthage/Carthage).
To install just write into your Cartfile:

```ruby
github "vadymmarkov/RetroProgress"
```

**RetroProgress** can also be installed manually. Just download and drop `Sources` folders in your project.

## Author

Vadym Markov, markov.vadym@gmail.com

## Credits

This library was originally done at [Hyper](http://hyper.no), a digital
communications agency with a passion for [good code](https://github.com/hyperoslo) and delightful user experiences.

## Contributing

Check the [CONTRIBUTING](https://github.com/vadymmarkov/RetroProgress/blob/master/CONTRIBUTING.md) file for more info.

## License

**RetroProgress** is available under the MIT license. See the [LICENSE](https://github.com/vadymmarkov/RetroProgress/blob/master/LICENSE.md) file for more info.
