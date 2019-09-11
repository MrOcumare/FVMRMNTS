//
//  SecindCoordinator.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 31/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class SecondFocus {
    public var section : Int
    public var cell : Int
    init(section: Int, cell: Int) {
        self.section = section
        self.cell = cell
    }
}
var secondFocus = SecondFocus(section: 0, cell: 0)
protocol BackToFirstViewControllerDelegate: class {
    
    func navigateBackToFirstPage(newOrderCoordinator: SecondCoordinator)
    
}

var indexOfVideoForPlay : Int?

var currntPlayList = PlaylistYouTube()

class SecondCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController:UINavigationController

    weak var delegate: BackToFirstViewControllerDelegate?
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let secondViewController : SecondViewController = SecondViewController()
        secondViewController.delegate = self
        self.navigationController.pushViewController(secondViewController, animated: true)
    }
}

extension SecondCoordinator : SecondViewControllerDelegate {
    
    // Navigate to third page
    func navigateToThirdPage() {
        
        let thirdViewController : ThirdViewController = ThirdViewController()
        thirdViewController.delegate = self
        self.navigationController.pushViewController(thirdViewController, animated: true)
    }
    
    // Navigate to first page
    func navigateToFirstPage() {
        let firstCoordinator = FirstCoordinator(navigationController: navigationController)
        childCoordinators.append(firstCoordinator)
        self.delegate?.navigateBackToFirstPage(newOrderCoordinator: self)
    }
}

extension SecondCoordinator : ThirdViewControllerDelegate {
    
    // Navigate to third page
    func navigateBackToSecondPage() {
        let secondViewController : SecondViewController = SecondViewController()
        secondViewController.delegate = self
        self.navigationController.viewControllers = [secondViewController]
    }
}
