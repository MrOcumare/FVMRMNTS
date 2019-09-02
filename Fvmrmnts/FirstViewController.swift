//
//  ViewController.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 18/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

//public protocol FirstViewControllerDelegate: class {
//    func navigateToNextPage()
//
//}

protocol FirstViewControllerDelegateInCell: class {
    func navigateToSecondController()
    func exitFromApp()
}

class FirstViewController: UIViewController {
    
    
    fileprivate let cellID = "cellID"
    fileprivate let header = "CollectionReusableView"
    
     public weak var delegate: FirstViewControllerDelegateInCell!
    
//    public weak var delegate: FirstViewControllerDelegate?
    
    let arrayOfSectionsTittle = ["Музыка немузыканта","Блог на блогера","Скандал интриги расследования","Интервью и подкасты","5","6","7","8","9","10","11","12"]
    
//    var arrayOfShow = [CollectionOfShow]()
    
    lazy var mainProjectLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GTWalsheimProBold", size: 32)
        label.numberOfLines = 0
        label.text = "five more minutes"
        label.textColor = UIColor.Fvmrmnts.Color.White
        label.adjustsFontSizeToFitWidth = true
        
        return label
    }()
    
    
    let collectonView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectonView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        collectonView.backgroundColor = UIColor.Fvmrmnts.Color.Black
        collectonView.isScrollEnabled = true
        return collectonView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectonView.reloadData()

        
        
       
        
        
        let headerlayout = UICollectionViewFlowLayout()
        headerlayout.headerReferenceSize = CGSize(width: self.collectonView.frame.size.width, height: 80)
        collectonView.collectionViewLayout = headerlayout
        collectonView.register(UINib(nibName: "CollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "CollectionReusableView")
        
        //    TODO(mrocumare): удалить отобрвжение шрифтов перед релизом
//        UIFont.familyNames.forEach({ familyName in
//            let fontNames = UIFont.fontNames(forFamilyName: familyName)
//            print(familyName, fontNames)
//        })
        
        collectonView.delegate = self as UICollectionViewDelegate
        collectonView.dataSource = self as UICollectionViewDataSource
        collectonView.register(CustomCell.self, forCellWithReuseIdentifier: cellID)
        collectonView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        view.backgroundColor = UIColor.Fvmrmnts.Color.Black
        view.addSubview(collectonView)
        view.addSubview(mainProjectLabel)
        
        setupMainProjectLabel()
        setupCollectionView()
        
    }
    
    //    TODO(mrocumare): понять как эту залупу вынести в отдельный файл
    
    var collectionViewTopAnchor: NSLayoutConstraint?
    
    func setupCollectionView() {
        collectonView.translatesAutoresizingMaskIntoConstraints = false
        collectonView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 0).isActive = true
        collectonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        collectionViewTopAnchor = collectonView.topAnchor.constraint(equalTo: view.topAnchor, constant: 214)
        collectionViewTopAnchor!.isActive = true
        collectonView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
    
    var mainProjectLabelTopAnchor: NSLayoutConstraint?
    
    func setupMainProjectLabel() {
        mainProjectLabel.translatesAutoresizingMaskIntoConstraints = false
        mainProjectLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 130).isActive = true
        mainProjectLabelTopAnchor = mainProjectLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 64)
        mainProjectLabelTopAnchor!.isActive = true
    }
}

extension FirstViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrayOfShow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, canFocusItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectonView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CustomCell
        cell.delegate = self.delegate
        cell.show = arrayOfShow[indexPath.section]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.collectonView.frame.width, height: 440)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 60, left: 0, bottom: 120, right: 0)
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        let menuPressRecognizer = UITapGestureRecognizer()
//        menuPressRecognizer.addTarget(self, action: #selector(FirstViewController.menuButtonAction(recognizer:)))
//        menuPressRecognizer.allowedPressTypes = [NSNumber(value: UIPress.PressType.menu.rawValue)]
//        self.view.addGestureRecognizer(menuPressRecognizer)
//    }
//    
//    @objc func menuButtonAction(recognizer:UITapGestureRecognizer) {
//        self.delegate?.exitFromApp()
//    }

    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedIndexPath?.section == 0 {
            handleAnimate(collectionViewAnimation: 214, showLabelAnimation: 64)
            
        } else {
            handleAnimate(collectionViewAnimation: 0, showLabelAnimation: -64)
            
        }
    }
    
    func handleAnimate(collectionViewAnimation: CGFloat, showLabelAnimation: CGFloat) {
        mainProjectLabelTopAnchor!.constant = showLabelAnimation
        collectionViewTopAnchor!.constant = collectionViewAnimation
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
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

