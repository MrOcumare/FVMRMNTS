//
//  SecondCollectionViewCell.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 01/08/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import Foundation
import UIKit
import ParallaxView
//    COMMENT(mrocumare): описание ячейки



class SecondCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        setUpViewCell()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
    let conteinerView : UIView = {
        let conteinerView = UIView()
        conteinerView.layer.cornerRadius = 12
        conteinerView.backgroundColor = UIColor.Fvmrmnts.Color.Black
        return conteinerView
    }()
    

    
    let imageView : UIImageView = {
        var image: UIImage = UIImage(named: "cellImage")!
        let imageView = UIImageView(image: image)
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 4
        return imageView
    }()
    
    
    
    let headerLabelofCell : UILabel = {
        let headerLabelofCell = UILabel()
        headerLabelofCell.font = UIFont(name: "GTWalsheimProBold", size: 40)
        headerLabelofCell.numberOfLines = 0
        headerLabelofCell.text = "Ивлеева — про Элджея, секс и пластику"
        headerLabelofCell.textColor = UIColor.Fvmrmnts.Color.White
        headerLabelofCell.adjustsFontSizeToFitWidth = true
        return headerLabelofCell
    }()
    
    let episodesNumber : UILabel = {
        let episodesNumber = UILabel()
        episodesNumber.font = UIFont(name: "GTWalsheimProRegular", size: 32)
        episodesNumber.text = "Эпизод 12"
        episodesNumber.textColor = UIColor.Fvmrmnts.Color.White.withAlphaComponent(0.72)
        episodesNumber.adjustsFontSizeToFitWidth = true
        episodesNumber.textAlignment = .left
        return episodesNumber
    }()
    
    
    func setUpViewCell() {
        addSubview(conteinerView)
        
        conteinerView.addSubview(imageView)
        conteinerView.addSubview(headerLabelofCell)
        conteinerView.addSubview(episodesNumber)
//        conteinerView.addSubview(translucentView)
        //        conteinerView.addSubview(translucentView_2)
//        translucentView.addSubview(headerLabelofCell)
//        translucentView.addSubview(episodesNumber)
  
        //    COMMENT(mrocumare): установка ограничений
        setUpconteinerView()
        setUpImageCell()

        setUpheaderLabelofCell()
        setUpepisodesNumber()
    }
    
    
    
    var conteinerViewTBottomAnchor : NSLayoutConstraint?
    var conteinerViewLeftAnchor : NSLayoutConstraint?
    var conteinerViewRightAnchor : NSLayoutConstraint?
    var conteinerViewTopAnchor : NSLayoutConstraint?
    
    func setUpconteinerView() {
        conteinerView.translatesAutoresizingMaskIntoConstraints = false
        conteinerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        conteinerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        conteinerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        conteinerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
    func setUpImageCell() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.leftAnchor.constraint(equalTo: conteinerView.leftAnchor, constant: 48).isActive = true
        imageView.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 48).isActive = true
        imageView.bottomAnchor.constraint(equalTo: conteinerView.bottomAnchor, constant: -48).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 144).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 268).isActive = true
    }
    
    
    
    func setUpheaderLabelofCell() {
        headerLabelofCell.translatesAutoresizingMaskIntoConstraints = false
        headerLabelofCell.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 48).isActive = true
        headerLabelofCell.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 112).isActive = true
    }
    
    func setUpepisodesNumber() {
        episodesNumber.translatesAutoresizingMaskIntoConstraints = false
        episodesNumber.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 48).isActive = true
        episodesNumber.topAnchor.constraint(equalTo: conteinerView.topAnchor, constant: 69).isActive = true
    }
    

    
    override func didUpdateFocus(in context: UIFocusUpdateContext, with coordinator: UIFocusAnimationCoordinator) {
        
        
        if self.isFocused {
            conteinerView.backgroundColor = UIColor.Fvmrmnts.Color.White.withAlphaComponent(0.12)
        } else {
            conteinerView.backgroundColor = UIColor.Fvmrmnts.Color.Black
        }
    }
    
    
   
    
    

}