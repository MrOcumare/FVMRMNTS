//
//  ViewController.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 18/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate let cellID = "cellID"
    fileprivate let header = "CollectionReusableView"
   
    
    let arrayOfSectionsTittle = ["Интервью и подкасты","Юмор и сатира","Новости"]

    
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
        
        let headerlayout = UICollectionViewFlowLayout()
        headerlayout.headerReferenceSize = CGSize(width: self.collectonView.frame.size.width, height: 128)
        
        collectonView.collectionViewLayout = headerlayout
        
       
        collectonView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionReusableView")
        
//        UIFont.familyNames.forEach({ familyName in
//            let fontNames = UIFont.fontNames(forFamilyName: familyName)
//            print(familyName, fontNames)
//        })
        
        
        collectonView.delegate = self as! UICollectionViewDelegate
        collectonView.dataSource = self as! UICollectionViewDataSource
        collectonView.register(CustomCell.self, forCellWithReuseIdentifier: cellID)
        view.backgroundColor = UIColor.Fvmrmnts.Color.Black
        view.addSubview(collectonView)
        setupCollectionView()
    }
  
    //    TODO(mrocumare): понять как эту залупу вынести в отдельный файл
    func setupCollectionView() {
        collectonView.translatesAutoresizingMaskIntoConstraints = false
        collectonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 118).isActive = true
        collectonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -118).isActive = true
        collectonView.topAnchor.constraint(equalTo: view.topAnchor, constant: 208).isActive = true
        collectonView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrayOfSectionsTittle.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return 4
        } else if section == 2 {
            return 10
        } else {
            return 2
        }
    }
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectonView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CustomCell
        cell.imageView.adjustsImageWhenAncestorFocused = true
        cell.clipsToBounds = true
        cell.backgroundColor = UIColor.Fvmrmnts.Color.Black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 268, height: 319)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 120, right: 0)
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

