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
    
    public weak var delegate: ThirdViewControllerDelegate?
    
    let playerViewController = AVPlayerViewController()
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
//        addChild(playerViewController)
//        view.addSubview(playerViewController.view)
//        playerViewController.didMove(toParent: self)
//
//        self.present(playerViewController, animated: true, completion: nil)
        
        
        self.addChild(playerViewController)
        self.view.addSubview(playerViewController.view)
        playerViewController.view.frame = self.view.frame
        
        YouTubeExtractor.instance.info(id: currentVideoForPlay?.videoID, quality: .x1080, completion: { url in
            self.playerViewController.player = AVPlayer(url: url!)
            self.playerViewController.player?.seek(to: CMTime(seconds: currentVideoForPlay!.stopTime, preferredTimescale: 1))
            self.playerViewController.player?.play()
            currentVideoForPlay!.fullTime = Double(CMTimeGetSeconds((self.playerViewController.player?.currentItem?.asset.duration)!))
//                    var stopTime : Double = 0
//                    //    TODO(mrocumare): убрать данный костыль сделать через асинхронщину
//                    while(playerViewController?.view.isUserInteractionEnabled != nil) {
//                        stopTime = Double(CMTimeGetSeconds((playerViewController?.player?.currentTime()) ?? .zero))
//                    }
//                    currentVideoForPlay!.stopTime = stopTime
//                    currentVideoForPlay!.stopMarker = CGFloat(drowMarker(fullTime:  currentVideoForPlay!.fullTime, stopTime: stopTime))
           
        })
        
        
    }
    func sdd() {
        self.delegate?.navigateBackToSecondPage()
    }
    
}




extension AVPlayerViewController : AVPlayerViewControllerDelegate{
   
    
    
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let menuPressRecognizer = UITapGestureRecognizer()
        menuPressRecognizer.addTarget(self, action: #selector(SecondViewController.menuButtonAction(recognizer:)))
        menuPressRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.menu.rawValue)]
        self.view.addGestureRecognizer(menuPressRecognizer)
    }
    
    @objc func menuButtonAction(recognizer:UITapGestureRecognizer) {
        print("finish")
        
        self.requiresLinearPlayback = false
        self.player?.play()
        let STOPTIME = Double(CMTimeGetSeconds((self.player?.currentTime()) ?? .zero))
        currentVideoForPlay!.stopTime = STOPTIME
        currentVideoForPlay!.stopMarker = CGFloat(drowMarker(fullTime:  currentVideoForPlay!.fullTime, stopTime: STOPTIME))
        self.player?.replaceCurrentItem(with: nil)
        
        if let myParent = self.parent as? ThirdViewController {
            myParent.sdd()
        }
        
        
    }
}

