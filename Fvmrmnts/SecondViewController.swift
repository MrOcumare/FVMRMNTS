//
//  SecondViewController.swift
//  CoordinatorDemo
//
//  Created by Saad El Oulladi on 29/09/2018.
//  Copyright © 2018 touti. All rights reserved.
//

import UIKit
import ParallaxView



public protocol SecondViewControllerDelegate: class {
    func navigateToFirstPage()
    func navigateToThirdPage()
}



class SecondViewController: UIViewController {
    
    public weak var delegate: SecondViewControllerDelegate?
    
    fileprivate let secondCellID = "secondCellID"
    
    lazy var isExit = false
    
    
    let showLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GTWalsheimProBold", size: 64)
        label.numberOfLines = 0
        label.text = "вДудь"
        label.textColor = UIColor.Fvmrmnts.Color.White
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let collectonView : UICollectionView = {
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
        collectonView.addSubview(showLabel)
        setUPshowLabel()
        
        setupCollectionView()
        
    }
    
    func setupCollectionView() {
        collectonView.translatesAutoresizingMaskIntoConstraints = false
        collectonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 92).isActive = true
        collectonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -92).isActive = true
        collectonView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setUPshowLabel() {
        showLabel.translatesAutoresizingMaskIntoConstraints = false
        showLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 140).isActive = true
        showLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 96).isActive = true
    }
    
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
   
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectonView.dequeueReusableCell(withReuseIdentifier: secondCellID, for: indexPath) as! SecondCollectionViewCell
//        cell.imageView.adjustsImageWhenAncestorFocused = true
//        cell.clipsToBounds = true
    
       
        
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
            
        }
        collectonView.contentInset = UIEdgeInsets(top: 97, left: 0, bottom: 0, right: 0)
        showLabel.isHidden = false
        isExit = true
        
//        self.dismiss(animated: true, completion: nil)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didUpdateFocusIn context: UICollectionViewFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        if context.nextFocusedIndexPath!.item == 0 {
            collectonView.contentInset = UIEdgeInsets(top: 237, left: 0, bottom: 0, right: 0)
            isExit = true
            showLabel.isHidden = false
            
        } else {
            
            showLabel.isHidden = true
            collectonView.contentInset = UIEdgeInsets(top: 97, left: 0, bottom: 0, right: 0)
            isExit = false
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Row \(indexPath.row) selected")
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
