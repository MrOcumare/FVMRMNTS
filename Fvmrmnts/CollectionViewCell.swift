//
//  CollectionViewCell.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 23/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation
import UIKit
//    COMMENT(mrocumare): описание ячейки
class CustomCell: UICollectionViewCell {
   
    
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
    
    let translucentView : UIView = {
        let translucentView = UIView()
        translucentView.backgroundColor =  UIColor.Fvmrmnts.Color.Violet.withAlphaComponent(0.3)
        translucentView.layer.cornerRadius = 4
        return translucentView
    }()
    
    let headerLabelofCell : UILabel = {
        let headerLabelofCell = UILabel()
        headerLabelofCell.font = UIFont(name: "GTWalsheimProBold", size: 21)
        headerLabelofCell.numberOfLines = 0
        headerLabelofCell.text = "Blitz and \nCpipz"
        headerLabelofCell.textColor = UIColor.Fvmrmnts.Color.White
        headerLabelofCell.adjustsFontSizeToFitWidth = true
        return headerLabelofCell
    }()
    
    let episodesNumber : UILabel = {
        let episodesNumber = UILabel()
        episodesNumber.font = UIFont(name: "GTWalsheimProMedium", size: 10)
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
        videDescription.font = UIFont(name: "GTWalsheimProRegular", size: 19)
        
        return videDescription
    }()
        
    func setUpViewCell() {
        addSubview(conteinerView)
        conteinerView.addSubview(imageView)
        conteinerView.addSubview(translucentView)
        translucentView.addSubview(headerLabelofCell)
        translucentView.addSubview(episodesNumber)
        addSubview(videDescription)
        //    COMMENT(mrocumare): установка ограничений
        setUpconteinerView()
        setUpImageCell()
        setUpTranslucentView()
        setUpheaderLabelofCell()
        setUpepisodesNumber()
        setVideDescription()
        
    }
    
    func setUpconteinerView() {
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        conteinerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        conteinerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        conteinerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
    func setVideDescription() {
        videDescription.translatesAutoresizingMaskIntoConstraints = false
        videDescription.heightAnchor.constraint(equalToConstant: 81).isActive = true
        videDescription.widthAnchor.constraint(equalToConstant: 260).isActive = true
        videDescription.topAnchor.constraint(equalTo: translucentView.bottomAnchor, constant: 25).isActive = true
        videDescription.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
    }
    
    func setUpepisodesNumber() {
        episodesNumber.translatesAutoresizingMaskIntoConstraints = false
        episodesNumber.leftAnchor.constraint(equalTo: translucentView.leftAnchor, constant: 20).isActive = true
        episodesNumber.topAnchor.constraint(equalTo: translucentView.topAnchor, constant: 20).isActive = true
        episodesNumber.heightAnchor.constraint(equalToConstant: 20).isActive = true
        episodesNumber.widthAnchor.constraint(equalToConstant: 98).isActive = true
    }
    
    func setUpheaderLabelofCell() {
        headerLabelofCell.translatesAutoresizingMaskIntoConstraints = false
        headerLabelofCell.leftAnchor.constraint(equalTo: translucentView.leftAnchor, constant: 20).isActive = true
        headerLabelofCell.bottomAnchor.constraint(equalTo: translucentView.bottomAnchor, constant: -16).isActive = true
        
        
    }
    
    func setUpTranslucentView() {
        translucentView.translatesAutoresizingMaskIntoConstraints = false
        translucentView.leftAnchor.constraint(equalTo: conteinerView.leftAnchor, constant: 0).isActive = true
        translucentView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 28).isActive = true
        translucentView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        translucentView.rightAnchor.constraint(equalTo: conteinerView.rightAnchor, constant: 0).isActive = true
    }
    
    func setUpImageCell() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.rightAnchor.constraint(equalTo: conteinerView.rightAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 208).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 239)
    }
}
