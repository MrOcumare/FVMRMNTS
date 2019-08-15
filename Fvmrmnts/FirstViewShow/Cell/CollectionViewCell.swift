//
//  CollectionViewCell.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 23/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation
import UIKit
import ParallaxView
//    COMMENT(mrocumare): описание ячейки



class CustomCell: UICollectionViewCell{
    
    public weak var delegate: FirstViewControllerDelegate?
    
    let categoryCellID = "categoryCellID"
    
    let categoryCollectonView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectonView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        
        collectonView.backgroundColor = UIColor.Fvmrmnts.Color.Black
        collectonView.isScrollEnabled = true
        
        return collectonView
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        categoryCollectonView.delegate = self as UICollectionViewDelegate
        categoryCollectonView.dataSource = self as UICollectionViewDataSource
        categoryCollectonView.register(CategoryCustomCell.self, forCellWithReuseIdentifier: categoryCellID)
        
        setUpViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    func setUpViewCell() {
        addSubview(categoryCollectonView)
        
        setUPCategoryCollectonView()
    }
    
    func setUPCategoryCollectonView() {
        categoryCollectonView.translatesAutoresizingMaskIntoConstraints = false
        categoryCollectonView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        categoryCollectonView.heightAnchor.constraint(equalToConstant: 422).isActive = true
        categoryCollectonView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        categoryCollectonView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
}

extension CustomCell:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
   
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectonView.dequeueReusableCell(withReuseIdentifier: categoryCellID, for: indexPath) as! CategoryCustomCell
        return cell
    }
    
    //    TODO(mrocumare): добавить каординатор
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.navigateToNextPage()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 422)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 60)
    }
    
    
    
    
    
    
}



class CategoryCustomCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViewCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let conteinerView : UIView = {
        let conteinerView = UIView()
        return conteinerView
    }()
    
    let imageView : UIImageView = {
        var image: UIImage = UIImage(named: "cellImage")!
        let imageView = UIImageView(image: image)
        return imageView
    }()

    
    let headerLabelofCell : UILabel = {
        let headerLabelofCell = UILabel()
        headerLabelofCell.font = UIFont(name: "GTWalsheimProBold", size: 36)
        headerLabelofCell.numberOfLines = 0
        headerLabelofCell.text = "Blitz and \nCpipz"
        headerLabelofCell.textColor = UIColor.Fvmrmnts.Color.White
        headerLabelofCell.adjustsFontSizeToFitWidth = true
        return headerLabelofCell
    }()
    
    let episodesNumber : UILabel = {
        let episodesNumber = UILabel()
        episodesNumber.font = UIFont(name: "GTWalsheimProMedium", size: 16)
        episodesNumber.text = "12 ЭПИЗОДОВ"
        episodesNumber.textColor = UIColor.Fvmrmnts.Color.White.withAlphaComponent(0.72)
        episodesNumber.adjustsFontSizeToFitWidth = true
        episodesNumber.textAlignment = .left
        episodesNumber.layer.cornerRadius = 2
        return episodesNumber
    }()
    
    
    let videDescription : UILabel = {
        let videDescription = UILabel()
        videDescription.textColor = UIColor.Fvmrmnts.Color.Gray
        videDescription.text = "Тимур Каргинов и Андрей \nКоняев регулярно о самом \nразном и интересном"
        videDescription.numberOfLines = 0
        videDescription.font = UIFont(name: "GTWalsheimProRegular", size: 28)
        
        return videDescription
    }()
    
    func setUpViewCell() {
        addSubview(conteinerView)
        conteinerView.addSubview(imageView)
        imageView.addSubview(headerLabelofCell)
        imageView.addSubview(episodesNumber)
        addSubview(videDescription)
        //    COMMENT(mrocumare): установка ограничений
        setUpconteinerView()
        setUpImageCell()
        setUpheaderLabelofCell()
        setUpepisodesNumber()
        setVideDescription()
        
    }
    
    func setUpconteinerView() {
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        conteinerView.heightAnchor.constraint(equalToConstant: 286).isActive = true
        conteinerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        conteinerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
    func setVideDescription() {
        videDescription.translatesAutoresizingMaskIntoConstraints = false
        videDescription.heightAnchor.constraint(equalToConstant: 108).isActive = true
        videDescription.widthAnchor.constraint(equalToConstant: 350).isActive = true
        videDescription.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 28).isActive = true
        videDescription.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
    }
    
    func setUpepisodesNumber() {
        episodesNumber.translatesAutoresizingMaskIntoConstraints = false
        episodesNumber.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 28).isActive = true
        episodesNumber.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 68).isActive = true
    }
    
    func setUpheaderLabelofCell() {
        headerLabelofCell.translatesAutoresizingMaskIntoConstraints = false
        headerLabelofCell.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 28).isActive = true
        headerLabelofCell.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -25).isActive = true
    }
    
//    func setUpTranslucentView() {
//        translucentView.translatesAutoresizingMaskIntoConstraints = false
//        translucentView.leftAnchor.constraint(equalTo: conteinerView.leftAnchor, constant: 0).isActive = true
//        translucentView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 28).isActive = true
//        translucentView.heightAnchor.constraint(equalToConstant: 180).isActive = true
//        translucentView.rightAnchor.constraint(equalTo: conteinerView.rightAnchor, constant: 0).isActive = true
//    }
    
    func setUpImageCell() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.rightAnchor.constraint(equalTo: conteinerView.rightAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 286).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 350).isActive = true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        
        if self.isFocused {
            
            
            conteinerView.addParallaxMotionEffects()
        } else {
            conteinerView.removeParallaxMotionEffects()
        }
    }
}

