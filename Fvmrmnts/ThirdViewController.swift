//
//  ThirdViewController.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 01/08/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

//
//  ThirdViewController.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 31/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

public class ThirdViewController: UIViewController {
    
    public weak var delegate: SecondViewControllerDelegate?
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ThirdViewController"
    }
    
    @IBAction func navigateToFirstPageAction(_ sender: Any) {
        self.delegate?.navigateToFirstPage()
    }
}

