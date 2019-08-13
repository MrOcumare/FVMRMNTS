//
//  VideoPlayerUtils.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 12/08/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation
import YoutubeDirectLinkExtractor
import XCDYouTubeKit

struct YouTubeVideoQuality {
    static let hd1080 = NSNumber(value: XCDYouTubeVideoQuality.HD1080.rawValue)
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}

