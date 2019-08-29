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

protocol FirstViewControllerDelegateInCell: class {
    func navigateToSecondController()
}

class CustomCell: UICollectionViewCell{
    
    let categoryCellID = "categoryCellID"
    
    
    var show : CollectionOfShow?
    
    public weak var delegate: FirstViewControllerDelegateInCell!
    
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
        categoryCollectonView.heightAnchor.constraint(equalToConstant: 440).isActive = true
        categoryCollectonView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        categoryCollectonView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
}


extension CustomCell:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (show?.shows.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 60
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollectonView.dequeueReusableCell(withReuseIdentifier: categoryCellID, for: indexPath) as! CategoryCustomCell
        cell.imageView.image = UIImage(data: (show?.shows[indexPath.row].videos[0].imageData)!)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        coordinatorPlayList = (show?.shows[indexPath.row])!
       
        self.delegate?.navigateToSecondController()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 350, height: 440)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 60)
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
        setUpconteinerView()
        setUpImageCell()
        setUpheaderLabelofCell()
        setUpepisodesNumber()
        setVideDescription()
        
    }
    
    var conteinerViewTopAnchor:    NSLayoutConstraint?
    var conteinerViewHeightAnchor: NSLayoutConstraint?
    var conteinerViewLeftAnchor:   NSLayoutConstraint?
    var conteinerViewRightAnchor:  NSLayoutConstraint?
    
    func setUpconteinerView() {
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        conteinerViewTopAnchor = conteinerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 18)
        conteinerViewTopAnchor!.isActive = true
        conteinerViewHeightAnchor = conteinerView.heightAnchor.constraint(equalToConstant: 286)
        conteinerViewHeightAnchor!.isActive = true
        conteinerViewLeftAnchor = conteinerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0)
        conteinerViewLeftAnchor!.isActive = true
        conteinerViewRightAnchor = conteinerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0)
        conteinerViewRightAnchor!.isActive = true
    }
    
    func setVideDescription() {
        videDescription.translatesAutoresizingMaskIntoConstraints = false
        videDescription.heightAnchor.constraint(equalToConstant: 108).isActive = true
        videDescription.widthAnchor.constraint(equalToConstant: 350).isActive = true
        videDescription.topAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: 28).isActive = true
        videDescription.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
    }
    
    func setUpepisodesNumber() {
        episodesNumber.translatesAutoresizingMaskIntoConstraints = false
        episodesNumber.leftAnchor.constraint(equalTo: conteinerView.leftAnchor, constant: 28).isActive = true
        episodesNumber.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 68).isActive = true
    }
    
    func setUpheaderLabelofCell() {
        headerLabelofCell.translatesAutoresizingMaskIntoConstraints = false
        headerLabelofCell.leftAnchor.constraint(equalTo: conteinerView.leftAnchor, constant: 28).isActive = true
        headerLabelofCell.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -25).isActive = true
    }
    
    var imageViewTopAnchor:    NSLayoutConstraint?
    var imageViewHeightAnchor: NSLayoutConstraint?
    var imageViewWidthAnchor:  NSLayoutConstraint?
    var imageViewRightAnchor:  NSLayoutConstraint?
    
    func setUpImageCell() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageViewRightAnchor = imageView.rightAnchor.constraint(equalTo: conteinerView.rightAnchor, constant: 0)
        imageViewRightAnchor!.isActive = true
        imageViewTopAnchor = imageView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 0)
        imageViewTopAnchor!.isActive = true
        imageViewHeightAnchor = imageView.heightAnchor.constraint(equalToConstant: 286)
        imageViewHeightAnchor!.isActive = true
        imageViewWidthAnchor = imageView.widthAnchor.constraint(equalToConstant: 350)
        imageViewWidthAnchor!.isActive = true
    }
    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        if self.isFocused {
            handleAnimate(imageViewAnimationTOP: -21.5, imageViewAnimationHEIGHT: 329, imageViewAnimationWIDTH: 400, imageViewAnimationRIGHT: 25)
        } else {
            handleAnimate(imageViewAnimationTOP: 0, imageViewAnimationHEIGHT: 286, imageViewAnimationWIDTH: 350, imageViewAnimationRIGHT: 0)
        }
    }

    
    func handleAnimate(imageViewAnimationTOP: CGFloat, imageViewAnimationHEIGHT: CGFloat, imageViewAnimationWIDTH: CGFloat, imageViewAnimationRIGHT: CGFloat) {
        imageViewTopAnchor!.constant    = imageViewAnimationTOP
        imageViewHeightAnchor!.constant = imageViewAnimationHEIGHT
        imageViewWidthAnchor!.constant  = imageViewAnimationWIDTH
        imageViewRightAnchor!.constant  = imageViewAnimationRIGHT
        UIView.animate(withDuration: 0.35, delay: 0, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
}

