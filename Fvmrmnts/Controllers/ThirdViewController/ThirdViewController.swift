//
//  ThirdViewController.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 01/08/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

//
//  ThirdViewController.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 31/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import XCDYouTubeKit

public protocol ThirdViewControllerDelegate: class {
    
    func navigateBackToSecondPage()
}

public class ThirdViewController: UIViewController, AVPlayerViewControllerDelegate{
    
    var currentVideo = Video()
    
    public weak var delegate: ThirdViewControllerDelegate?
    
    let playerViewController = AVPlayerViewController()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        self.addChild(playerViewController)
        self.view.addSubview(playerViewController.view)
        playerViewController.view.frame = self.view.frame
        
        playVideo(currentVideo: currntPlayList.videos[indexOfVideoForPlay!])
        
        NotificationCenter.default.addObserver(self, selector:#selector(self.playerDidFinishPlaying(note:)),name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerViewController.player?.currentItem)
    }
    
    func playVideo(currentVideo: Video) {
        XCDYouTubeClient.default().getVideoWithIdentifier(currentVideo.videoID) { [weak playerViewController] (video: XCDYouTubeVideo?, error: Error?) in
            if let streamURLs = video?.streamURLs, let streamURL = (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs[YouTubeVideoQuality.hd1080] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.medium360] ?? streamURLs[YouTubeVideoQuality.small240]) {
                self.playerViewController.player = AVPlayer(url: streamURL)
                self.playerViewController.player?.seek(to: CMTime(seconds: currentVideo.stopTime, preferredTimescale: 1))
                self.playerViewController.player?.play()
                currentVideo.fullTime = Double(CMTimeGetSeconds((self.playerViewController.player?.currentItem?.asset.duration)!))
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func navigateBack() {
        self.delegate?.navigateBackToSecondPage()
    }
    
    @objc func playerDidFinishPlaying(note: NSNotification) {
        setStopTime()
        if indexOfVideoForPlay! + 1 < currntPlayList.videos.count {
            indexOfVideoForPlay = indexOfVideoForPlay! + 1
            playVideo(currentVideo: currntPlayList.videos[indexOfVideoForPlay!])
        } else {
            self.navigateBack()
        }
    }
    
    func setStopTime() {
        let STOPTIME = Double(CMTimeGetSeconds((playerViewController.player?.currentTime()) ?? .zero))
        currntPlayList.videos[indexOfVideoForPlay!].stopTime = STOPTIME
        currntPlayList.videos[indexOfVideoForPlay!].stopMarker = CGFloat(drowMarker(fullTime:  currntPlayList.videos[indexOfVideoForPlay!].fullTime, stopTime: STOPTIME))
    }
}




extension AVPlayerViewController : AVPlayerViewControllerDelegate {
   
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let menuPressRecognizer = UITapGestureRecognizer()
        menuPressRecognizer.addTarget(self, action: #selector(SecondViewController.menuButtonAction(recognizer:)))
        menuPressRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.menu.rawValue)]
        self.view.addGestureRecognizer(menuPressRecognizer)
    }
    
    @objc func menuButtonAction(recognizer:UITapGestureRecognizer) {
        
        self.requiresLinearPlayback = false
        self.player?.pause()
        
        if let myParent = self.parent as? ThirdViewController {
            myParent.setStopTime()
        }
        
        self.player?.replaceCurrentItem(with: nil)
        
        if let myParent = self.parent as? ThirdViewController {
            myParent.navigateBack()
        }
        
        
    }
}

