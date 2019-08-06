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


    
    let showLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "GTWalsheimProBold", size: 55)
        label.numberOfLines = 0
        label.text = "вДудь \n34 эпизода"
        label.textColor = UIColor.Fvmrmnts.Color.White
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    
    let playShowButton : UIButton = {
        let btn = UIButton()
        btn.backgroundColor = UIColor.Fvmrmnts.Color.DarkViolet.withAlphaComponent(0.9)
        let trianglePath = UIBezierPath()
        let triangleLayer = CAShapeLayer()
        trianglePath.move(to: CGPoint(x: 150 / 8 * 3, y: 150 / 3))
        trianglePath.addLine(to: CGPoint(x: 150 - (150 / 8 * 3), y: 150 / 2))
        trianglePath.addLine(to: CGPoint(x: 150 / 8 * 3, y: 150 - (150 / 3)))
        trianglePath.addLine(to: CGPoint(x: 150 / 8 * 3, y: 150 / 3))
        triangleLayer.path = trianglePath.cgPath
        triangleLayer.fillColor = UIColor.white.cgColor
        btn.layer.addSublayer(triangleLayer)
        btn.layer.cornerRadius = 10
        return btn
    }()

    
    
    let showImage : UIImageView = {
        var image: UIImage = UIImage(named: "cellImage")!
        let imageView = UIImageView(image: image)
        return imageView
    }()
    
    let collectonView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 40
        let collectonView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        
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
        
       
        
        view.addSubview(showLabel)
        view.addSubview(showImage)
        view.addSubview(collectonView)
        showImage.addSubview(playShowButton)
    
        setUPshowImage()
        setUPshowLabel()
        setUPplayShowButton()
        setupCollectionView()
        playShowButton.canBecomeFocused
    }
    
    func setupCollectionView() {
        collectonView.translatesAutoresizingMaskIntoConstraints = false
        collectonView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        collectonView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        collectonView.heightAnchor.constraint(equalToConstant: 400).isActive = true
        collectonView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    func setUPshowImage() {
        showImage.translatesAutoresizingMaskIntoConstraints = false
        showImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        showImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        showImage.heightAnchor.constraint(equalToConstant: 600).isActive = true
        showImage.widthAnchor.constraint(equalToConstant: 800).isActive = true
    }
    
    func setUPplayShowButton() {
        playShowButton.translatesAutoresizingMaskIntoConstraints = false
        playShowButton.leftAnchor.constraint(equalTo: showImage.leftAnchor, constant: (800 / 2) - 150 / 2).isActive = true
        playShowButton.topAnchor.constraint(equalTo: showImage.topAnchor, constant:
            (600 / 2) - 150 / 2).isActive = true
      
        playShowButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        playShowButton.heightAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func setUPshowLabel() {
        showLabel.translatesAutoresizingMaskIntoConstraints = false
        showLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50).isActive = true
        showLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
    }

    
}

extension SecondViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func refrash(){
        self.collectonView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectonView.dequeueReusableCell(withReuseIdentifier: secondCellID, for: indexPath) as! SecondCollectionViewCell
//        cell.imageView.adjustsImageWhenAncestorFocused = true
//        cell.clipsToBounds = true
        
        cell.backgroundColor = UIColor.Fvmrmnts.Color.Black
        return cell
    }
    

    
    
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Row \(indexPath.row) selected")
    }

    

    
    

    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 300, height: 319)
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
