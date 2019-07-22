//
//  ViewController.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 18/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellID = "cellID"
    
    let mainLabel : UILabel = {
        let mainLabel = UILabel()
        mainLabel.font = UIFont(name: "GT Walsheim Pro", size: 120)
        mainLabel.text = "five more minutes"
        mainLabel.textColor = UIColor.Fvmrmnts.Color.White
        mainLabel.adjustsFontSizeToFitWidth = true
        return mainLabel
    }()
    
    let collectonView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectonView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collectonView.backgroundColor = UIColor.Fvmrmnts.Color.Black
        collectonView.isScrollEnabled = true
        return collectonView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
        mainLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 118).isActive = true
        mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 168).isActive = true
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

class CustomCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
            setUpViewCell()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView : UIImageView = {
        var image: UIImage = UIImage(named: "cellImage")!
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let translucentView : UIView = {
        let translucentView = UIView()
        translucentView.backgroundColor =  UIColor.Fvmrmnts.Color.Violet.withAlphaComponent(0.25)
        translucentView.layer.cornerRadius = 4
        return translucentView
    }()
    
    let headerLabelofCell : UILabel = {
        let headerLabelofCell = UILabel()
        headerLabelofCell.font = UIFont(name: "HelveticaNeue-Regular", size: 20)
        headerLabelofCell.text = "вДудь"
        headerLabelofCell.textColor = UIColor.Fvmrmnts.Color.White
        headerLabelofCell.adjustsFontSizeToFitWidth = true
        return headerLabelofCell
    }()
    
    let episodesNumber : UILabel = {
        let episodesNumber = UILabel()
        episodesNumber.font = UIFont(name: "HelveticaNeue-Medium", size: 10)
        episodesNumber.text = "12 ЭПИЗОДОВ"
        episodesNumber.textColor = UIColor.Fvmrmnts.Color.White
        episodesNumber.adjustsFontSizeToFitWidth = true
        episodesNumber.backgroundColor =  UIColor.Fvmrmnts.Color.Black.withAlphaComponent(0.6)
        episodesNumber.textAlignment = .center
        episodesNumber.layer.cornerRadius = 2
        return episodesNumber
    }()
    
    let is18label : UILabel = {
        let is18label = UILabel()
        is18label.font = UIFont(name: "HelveticaNeue-Medium", size: 10)
        is18label.text = "18+"
        is18label.textColor = UIColor.Fvmrmnts.Color.White
        is18label.adjustsFontSizeToFitWidth = true
        is18label.backgroundColor =  UIColor.Fvmrmnts.Color.Red
        is18label.textAlignment = .center
        is18label.layer.cornerRadius = 2
        return is18label
    }()
    
    let videDescription : UILabel = {
        let videDescription = UILabel()
        videDescription.textColor = UIColor.Fvmrmnts.Color.Gray
        videDescription.text = "Тимур Каргинов и Андрей \nКоняев регулярно о самом \nразном и интересном"
        videDescription.numberOfLines = 0
        videDescription.font = UIFont(name: "GT Walsheim Pro", size: 19)
        videDescription.backgroundColor = UIColor.Fvmrmnts.Color.Black
        return videDescription
    }()
     
   
    
    func setUpViewCell() {
        addSubview(imageView)
        addSubview(translucentView)
        translucentView.addSubview(headerLabelofCell)
        translucentView.addSubview(episodesNumber)
        translucentView.addSubview(is18label)
        addSubview(videDescription)
        setUpImageCell()
        setUpTranslucentView()
        setUpheaderLabelofCell()
        setUpepisodesNumber()
        setis18label()
        setVideDescription()
        
        
    }
    
    func setVideDescription() {
        videDescription.translatesAutoresizingMaskIntoConstraints = false
        videDescription.heightAnchor.constraint(equalToConstant: 81)
        videDescription.widthAnchor.constraint(equalToConstant: 260)
        videDescription.topAnchor.constraint(equalTo: translucentView.bottomAnchor, constant: 25).isActive = true
        videDescription.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
    }
    func setis18label() {
        is18label.translatesAutoresizingMaskIntoConstraints = false
        is18label.rightAnchor.constraint(equalTo: translucentView.rightAnchor, constant: -14).isActive = true
        is18label.bottomAnchor.constraint(equalTo: translucentView.bottomAnchor, constant: -8).isActive = true
        is18label.heightAnchor.constraint(equalToConstant: 20).isActive = true
        is18label.widthAnchor.constraint(equalToConstant: 36).isActive = true
    }
    func setUpepisodesNumber() {
        episodesNumber.translatesAutoresizingMaskIntoConstraints = false
        episodesNumber.rightAnchor.constraint(equalTo: translucentView.rightAnchor, constant: -58).isActive = true
        episodesNumber.bottomAnchor.constraint(equalTo: translucentView.bottomAnchor, constant: -8).isActive = true
        episodesNumber.heightAnchor.constraint(equalToConstant: 20).isActive = true
        episodesNumber.widthAnchor.constraint(equalToConstant: 98).isActive = true
    }
    
    func setUpheaderLabelofCell() {
        headerLabelofCell.translatesAutoresizingMaskIntoConstraints = false
        headerLabelofCell.leftAnchor.constraint(equalTo: translucentView.leftAnchor, constant: 16).isActive = true
        headerLabelofCell.topAnchor.constraint(equalTo: translucentView.topAnchor, constant: 16).isActive = true
        headerLabelofCell.heightAnchor.constraint(equalToConstant: 30).isActive = true
        headerLabelofCell.widthAnchor.constraint(equalToConstant: 58).isActive = true
    }
    
    func setUpTranslucentView() {
        translucentView.translatesAutoresizingMaskIntoConstraints = false
        translucentView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        translucentView.topAnchor.constraint(equalTo: self.topAnchor, constant: 28).isActive = true
        translucentView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        translucentView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
    }
    
    func setUpImageCell() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        imageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 208).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 239)
    }
}

extension UILabel {
    
    func setLineHeight(lineHeight: CGFloat) {
        let text = self.text
        if let text = text {
            let attributeString = NSMutableAttributedString(string: text)
            let style = NSMutableParagraphStyle()
            style.lineSpacing = lineHeight
            attributeString.addAttribute(NSAttributedString.Key.paragraphStyle, value: style, range: NSMakeRange(0, text.count))
            self.attributedText = attributeString
        }
    }
}

