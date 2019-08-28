//
//  LoaderViewController.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 27/08/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit
public protocol LoaderCoordinatorDelegate: class {
    func navigateToNextPage()
    
}

class LoaderViewController: UIViewController {

    public weak var delegate: LoaderCoordinatorDelegate?
    
    lazy var spinner : Spinner = {
       var spinner = Spinner()
        spinner.Style = .Dark
        return spinner
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(spinner)
        setupSpinner()
        self.spinner.startAnimating()
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
          
            self.delegate?.navigateToNextPage()
        }
        // Do any additional setup after loading the view.
    }
    func setupSpinner() {
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        spinner.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        spinner.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        spinner.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
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
