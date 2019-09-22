// RetroProgress iOS Playground

import UIKit
import PlaygroundSupport
import RetroProgress

let progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 360, height: 30))
let progressColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1)

// Configure
progressView.fullProgressAnimationDuration = 3
progressView.progressInset = .zero
progressView.layer.cornerRadius = 15
progressView.layer.borderColor = progressColor.cgColor
progressView.trackColor = .white
progressView.progressColor = progressColor
progressView.separatorColor = UIColor(red: 218/255, green: 236/255, blue: 255/255, alpha: 1)

// Set progress
progressView.animateSteps(to: 5.5)

PlaygroundPage.current.liveView = progressView
