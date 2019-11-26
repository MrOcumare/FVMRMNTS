//
//  VideoPlayerUtils.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 12/08/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation

import XCDYouTubeKit

struct YouTubeVideoQuality {
    static let hd1080 = NSNumber(value: XCDYouTubeVideoQuality.HD1080.rawValue)
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}

func drowMarker(fullTime: Double, stopTime : Double) -> Double{
    let onePercentOfPlay = fullTime / 100
    if onePercentOfPlay == 0 {
        return 0
    }
    let countPercent = stopTime / onePercentOfPlay
    return (1736 * countPercent / 100)
}
