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
   
    
    let arrayOfSectionsTittle = ["Интервью и подкасты","Юмор и сатира","Новости"]
    
    let mainLabel : UILabel = {
        let mainLabel = UILabel()
        mainLabel.font = UIFont(name: "GTWalsheimProBold", size: 55)
        mainLabel.text = "Интервью и подкасты"
        mainLabel.textColor = UIColor.Fvmrmnts.Color.White
        mainLabel.adjustsFontSizeToFitWidth = true
        return mainLabel
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
        UIFont.familyNames.forEach({ familyName in
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            print(familyName, fontNames)
        })
        collectonView.register(UINib.init(nibName: "HeaderOfSectionView", bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collectonView.delegate = self as! UICollectionViewDelegate
        collectonView.dataSource = self as! UICollectionViewDataSource
        collectonView.register(CustomCell.self, forCellWithReuseIdentifier: cellID)
        view.backgroundColor = UIColor.Fvmrmnts.Color.Black
        view.addSubview(mainLabel)
        view.addSubview(collectonView)
        setupmainLabel()
        setupCollectionView()
    }
  
    //    TODO(mrocumare): понять как эту залупу вынести в отдельный файл

    func setupmainLabel() {
       
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 140).isActive = true
        mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 208).isActive = true
        mainLabel.heightAnchor.constraint(equalToConstant: 120).isActive = true
       
    }
    func setupCollectionView() {
        collectonView.translatesAutoresizingMaskIntoConstraints = false
        collectonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 118).isActive = true
        collectonView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -118).isActive = true
        collectonView.topAnchor.constraint(equalTo: view.topAnchor, constant: 400).isActive = true
        collectonView.heightAnchor.constraint(equalToConstant: 700).isActive = true
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return arrayOfSectionsTittle.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectonView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = UIColor.Fvmrmnts.Color.Black
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 268, height: 304)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 38)
    }
    
   
    
}



