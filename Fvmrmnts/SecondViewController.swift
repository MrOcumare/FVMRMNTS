//
//  SecondViewController.swift
//  CoordinatorDemo
//
//  Created by Saad El Oulladi on 29/09/2018.
//  Copyright © 2018 touti. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit
import XCDYouTubeKit


public protocol SecondViewControllerDelegate: class {
    func navigateToFirstPage()
    func navigateToThirdPage()
}

class SecondViewController: UIViewController {
    
    public weak var delegate: SecondViewControllerDelegate?
    
    fileprivate let secondCellID = "secondCellID"
    
    lazy var isExit = false
    
    lazy var showLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GTWalsheimProBold", size: 64)
        label.numberOfLines = 0
        label.text = "вДудь"
        label.textColor = UIColor.Fvmrmnts.Color.White
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    lazy var collectonView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 40
        let collectonView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical 
        
        collectonView.backgroundColor = UIColor.Fvmrmnts.Color.Black
        collectonView.isScrollEnabled = true
        return collectonView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.Fvmrmnts.Color.Black
        
        collectonView.delegate = self as UICollectionViewDelegate
        collectonView.dataSource = self as UICollectionViewDataSource
        collectonView.register(SecondCollectionViewCell.self, forCellWithReuseIdentifier: secondCellID)
        
        
        
       
        
        view.addSubview(collectonView)
        view.addSubview(showLabel)
        setUPshowLabel()
        
        setupCollectionView()
        
    }
    var collectionViewTopAnchor : NSLayoutConstraint?
    
    func setupCollectionView() {
        collectonView.translatesAutoresizingMaskIntoConstraints = false
        collectonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 92).isActive = true
        collectonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -92).isActive = true
        collectionViewTopAnchor = collectonView.topAnchor.constraint(equalTo: view.topAnchor, constant: 237)
        collectionViewTopAnchor?.isActive = true
        collectonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    
    var showLabelTopAnchor : NSLayoutConstraint?
    
    func setUPshowLabel() {
        showLabel.translatesAutoresizingMaskIntoConstraints = false
        showLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 140).isActive = true
        showLabelTopAnchor = showLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 96)
        showLabelTopAnchor?.isActive = true
    }
    
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return currntPlayList.countOfUpload
        return currntPlayList.videos.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectonView.dequeueReusableCell(withReuseIdentifier: secondCellID, for: indexPath) as! SecondCollectionViewCell
  
       
//            cell.setmarlerwidth(mar: CGFloat(drowMarker(fullTime: currntPlayList.videos[indexPath.row].fullTime, stopTime: currntPlayList.videos[indexPath.row].stopdTime)))
            cell.setmarlerwidth(marker: CGFloat(drowMarker(fullTime: currntPlayList.videos[indexPath.row].fullTime, stopTime: currntPlayList.videos[indexPath.row].stopdTime)), currentVideo: &currntPlayList.videos[indexPath.row])
            cell.imageView.image = UIImage(data: (currntPlayList.videos[indexPath.row].imageData!))
            cell.episodesNumber.text = String(currntPlayList.countTotal - indexPath.row)
            cell.headerLabelofCell.text = currntPlayList.videos[indexPath.row].videoTitle
           
//            cell.marlerwidth = CGFloat(drowMarker(fullTime: currntPlayList.videos[indexPath.row].fullTime, stopTime: currntPlayList.videos[indexPath.row].stopdTime))
//             cell.marlerwidth?.advanced(by: 50)
          
            
        
        
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let menuPressRecognizer = UITapGestureRecognizer()
        menuPressRecognizer.addTarget(self, action: #selector(SecondViewController.menuButtonAction(recognizer:)))
        menuPressRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.menu.rawValue)]
        self.view.addGestureRecognizer(menuPressRecognizer)
    }

    @objc func menuButtonAction(recognizer:UITapGestureRecognizer) {
        if isExit {
           self.delegate?.navigateToFirstPage()
        } else {
            isExit = true
            self.handleAnimate(collectionViewAnimation: 237, showLabelAnimation: 96)
            
        }
       
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
      
        if context.nextFocusedIndexPath?.item == currntPlayList.videos.count - 5 && !currntPlayList.checkTheFullDownload() {
            downloadVideoInPlaylistByPlayListID(Playlist: currntPlayList, collectionVideos: self.collectonView, completion: {
                print("UPload Data is succes")
            })
            
        }
        
        if context.nextFocusedIndexPath?.item == 0 {
            handleAnimate(collectionViewAnimation: 237, showLabelAnimation: 96)
            isExit = true
        } else {
            handleAnimate(collectionViewAnimation: 0, showLabelAnimation: -96)
            isExit = false
        }
       
    }
    
    func handleAnimate(collectionViewAnimation: CGFloat, showLabelAnimation: CGFloat) {
        showLabelTopAnchor?.constant = showLabelAnimation
        collectionViewTopAnchor?.constant = collectionViewAnimation
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let playerViewController = AVPlayerViewController()
        self.present(playerViewController, animated: true, completion: nil)
        XCDYouTubeClient.default().getVideoWithIdentifier("admcvvTMRtU") { [weak playerViewController] (video: XCDYouTubeVideo?, error: Error?) in
            if let streamURLs = video?.streamURLs, let streamURL = (streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? streamURLs[YouTubeVideoQuality.hd1080] ?? streamURLs[YouTubeVideoQuality.hd720] ?? streamURLs[YouTubeVideoQuality.medium360] ?? streamURLs[YouTubeVideoQuality.small240]) {
                YouTubeExtractor.instance.info(id: currntPlayList.videos[indexPath.row].videoID, quality: .x1080, completion: { url in
                    playerViewController?.player = AVPlayer(url: url!)
                    playerViewController?.player?.seek(to: CMTime(seconds: currntPlayList.videos[indexPath.row].stopdTime, preferredTimescale: 1))
                    
                    playerViewController?.player?.play()
                  
                    var stoptime : Double = 0
                    currntPlayList.videos[indexPath.row].fullTime = Double(CMTimeGetSeconds((playerViewController?.player?.currentItem?.asset.duration)!))
                    currntPlayList.videos[indexPath.row].isPlayed = true
                    //    TODO(mrocumare): убрать данный костыль сделать через асинхронщину
                    while(playerViewController?.view.isUserInteractionEnabled != nil) {
                        currntPlayList.videos[indexPath.row].stopdTime = Double(CMTimeGetSeconds((playerViewController?.player?.currentTime()) ?? .zero))
                    }
                    currntPlayList.videos[indexPath.row].stopdTime = stoptime
                    self.collectonView.reloadData()
                    print("sdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdfsdf")

                })
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
   

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectonView.frame.width, height: 240)
    }
}


//    @objc func navigateBackToFirstpage() {
//        self.delegate?.navigateToFirstPage()
//    }
//
//    @IBAction func navigateToThirdPageAction(_ sender: Any) {
//        self.delegate?.navigateToThirdPage()
//    }
//}
//
