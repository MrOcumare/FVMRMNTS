//
//  HeaderOfSectionView.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 23/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class HeaderOfSectionView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: - Initialization

    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.backgroundColor = .red
        // Configure Title Label
        titleLabel.textColor = .white
    }
        
    
}
