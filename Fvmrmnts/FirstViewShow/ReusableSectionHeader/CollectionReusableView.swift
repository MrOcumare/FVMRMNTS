//
//  CollectionReusableView.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 24/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class CollectionReusableView: UICollectionReusableView {
    

    @IBOutlet weak var headerTitle: UILabel!
    
    func setup(title: String) {
        self.headerTitle.text = title
    }
    
}
