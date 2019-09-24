//
//  LoaderViewController.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 27/08/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit
import Network
import RetroProgress

public protocol LoaderCoordinatorDelegate: class {
    func navigateToPlayList()
    func navigateToFirstView()
}

class LoaderViewController: UIViewController {

    //    COMMENT(mrocumare): шедулер для проверки соединения
    var timer: Timer?
    
    public weak var delegate: LoaderCoordinatorDelegate?
    
    lazy var lowInternetConnection : UIImageView = {
        let image = UIImage(named: "LowInternet")
        let imageView = UIImageView(image: image!)
        return imageView
    }()
    
    lazy var progressBar :  ProgressView = {
        let progressView = ProgressView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        
        // Configure
        progressView.layer.cornerRadius = 10
        progressView.layer.borderColor = UIColor.white.cgColor
        progressView.trackColor = .white
        progressView.separatorColor = .white
        progressView.progressColor = UIColor.Fvmrmnts.Color.DarkViolet
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.addSubview(spinner)
        self.view.addSubview(lowInternetConnection)
        self.view.addSubview(progressBar)
        setUpProgressBar()
        setUpImageLowInternetConnection()
        lowInternetConnection.isHidden = true
        self.progressBar.animateProgress(to: 1)
        timer?.invalidate()
        let networkObserver = DispatchGroup()
        networkObserver.enter()
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { [weak self] _ in
            if Connectivity.isConnectedToInternet() {
                self!.lowInternetConnection.isHidden = true
                self!.timer?.invalidate()
                networkObserver.leave()
            } else {
                self!.lowInternetConnection.isHidden = false
            }
        })
        networkObserver.notify(queue: DispatchQueue.main) {
            //    COMMENT(mrocumare): при первом запуске происходит загрузка сразу всех плейлистов по 10 элементов
            
            if isFirstInput {
                
                let requestGroup =  DispatchGroup()
                for item in ArrayOFShow {
                    let showCollection = CollectionOfShow()
                    for id in item {
                        let buffer = PlaylistYouTube()
                        buffer.setPlaylistId(playlistId: id)
                        requestGroup.enter()
                        downloadVideoInPlaylistByPlayListID(Playlist: buffer, completion: {
                            showCollection.addToCollectionOfShow(show: buffer)
                            requestGroup.leave()
                        })
                    }
                    arrayOfShow.append(showCollection)
                }
                requestGroup.notify(queue: DispatchQueue.main) {
                    isFirstInput = false
                    arrayOfShow = sortShow(arrayOfShow: arrayOfShow)
                    self.delegate?.navigateToFirstView()
                }
            //    COMMENT(mrocumare): при последующем заходе в playlist идет полная подгрузка
            } else if !(coordinatorPlayList?.checkTheFullDownload())!{
                let requestGroup =  DispatchGroup()
                requestGroup.enter()
                downloadVideoInPlaylistByPlayListID(Playlist: coordinatorPlayList!, fulldownload: true) {
                    requestGroup.leave()
                }
                requestGroup.notify(queue: DispatchQueue.main) {
                    currntPlayList = coordinatorPlayList!
                    self.delegate?.navigateToPlayList()
                }
            } else {
                currntPlayList = coordinatorPlayList!
                self.delegate?.navigateToPlayList()
            }
        }
        // Do any additional setup after loading the view.
    }

    
    func setUpProgressBar() {
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        progressBar.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 100).isActive = true
        progressBar.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -100).isActive = true
        progressBar.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 400).isActive = true
        progressBar.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    func setUpImageLowInternetConnection() {
        lowInternetConnection.translatesAutoresizingMaskIntoConstraints = false
        lowInternetConnection.widthAnchor.constraint(equalToConstant: 300).isActive = true
        lowInternetConnection.heightAnchor.constraint(equalToConstant: 300).isActive = true
        lowInternetConnection.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: self.view.frame.width / 2 - 150).isActive = true
        lowInternetConnection.topAnchor.constraint(equalTo: view.topAnchor, constant: self.view.frame.height / 2 - 150).isActive = true
        
    }
    private func pineapplesCountUniversal(count: UInt) -> String{
        let formatString : String = NSLocalizedString("number_of_episodes_in_show", comment: "Count of episodes Localize.stringsdict")
        let resultString : String = String.localizedStringWithFormat(formatString, count)
        return resultString;
    }
    
   
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
