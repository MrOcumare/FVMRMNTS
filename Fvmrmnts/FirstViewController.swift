//
//  ViewController.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 18/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

public protocol FirstViewControllerDelegate: class {
    func navigateToNextPage()
}

class FirstViewController: UIViewController {
    
    fileprivate let cellID = "cellID"
    fileprivate let header = "CollectionReusableView"
   
    public weak var delegate: FirstViewControllerDelegate?
    
    let arrayOfSectionsTittle = ["1","2","3","4","5","6","7","8","9","10","11","12"]

    var arrayOfPlayList = [PlaylistYouTube]()
    
    let collectonView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 40
        layout.minimumLineSpacing = 0
        let collectonView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        
        collectonView.backgroundColor = UIColor.Fvmrmnts.Color.Black
        collectonView.isScrollEnabled = true
        return collectonView
    }()
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//    TODO(mrocumare): рефактор с нормальной многопоточностью
        var i = 0
        for item in ArrayOfPlayListsID {
            let playListObj = PlaylistYouTube()
            playListObj.setPlaylistId(playlistId: item)
            downloadVideoInPlaylistByPlayListID(Playlist: playListObj, completion: {
                print("success download playlistinfo by id \(item)")
                downloadPlayListBunnerByID(Playlist: playListObj, completion: {
                    print("Banner is downloaded")
                    self.arrayOfPlayList.append(playListObj)
                    //    TODO(mrocumare): сделать по нормальному анализ загрузки данных
                    i = i + 1
                    if i == 3 {
                        sleep(4)
                        self.collectonView.reloadData()
                    }
                })
            })
        }
/////////////////////////////////////////////////////////////////////////////////
        
        
        let headerlayout = UICollectionViewFlowLayout()
        headerlayout.headerReferenceSize = CGSize(width: self.collectonView.frame.size.width, height: 65)
        
        collectonView.collectionViewLayout = headerlayout
        
       
        collectonView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionReusableView")
        
        UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            print(familyName, fontNames)
        })
        
        
        collectonView.delegate = self as UICollectionViewDelegate
        collectonView.dataSource = self as UICollectionViewDataSource
        collectonView.register(CustomCell.self, forCellWithReuseIdentifier: cellID)
        collectonView.contentInset = UIEdgeInsets(top: 208, left: 118, bottom: 0, right: 118)
        view.backgroundColor = UIColor.Fvmrmnts.Color.Black
        view.addSubview(collectonView)
       
        setupCollectionView()
        
    }
  
    //    TODO(mrocumare): понять как эту залупу вынести в отдельный файл
    
    
    func setupCollectionView() {
        collectonView.translatesAutoresizingMaskIntoConstraints = false
        collectonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectonView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        collectonView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //    TODO(mrocumare): продумать количество ячеек в секции возможна новая структура
       return 30
//        if section == 1 {
//            return 4
//        } else if section == 2 {
//            return 10
//        } else {
//            return 2
//        }
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectonView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CustomCell
//        cell.imageView.adjustsImageWhenAncestorFocused = true
//        cell.clipsToBounds = true
        cell.backgroundColor = UIColor.Fvmrmnts.Color.Black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.navigateToNextPage()
    }
   
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 268, height: 319)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
       return UIEdgeInsets(top: 63, left: 0, bottom: 120, right: 0)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                                 layout collectionViewLayout: UICollectionViewLayout,
                                 minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(bitPattern: 25)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if (kind == UICollectionView.elementKindSectionFooter) {
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CartFooterCollectionReusableView", for: indexPath)
            
            return footerView
        } else if (kind == UICollectionView.elementKindSectionHeader) {
            
           
            let headerView = collectonView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: header, for: indexPath) as! CollectionReusableView
            headerView.headerTitle.text = arrayOfSectionsTittle[indexPath.section]
            return headerView
        }
        fatalError()
    }
}

