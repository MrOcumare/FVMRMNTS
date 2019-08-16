//
//  FirstCoordinator.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 31/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class FirstCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController : UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let firstViewController : FirstViewController = FirstViewController()
        firstViewController.delegate = self
        self.navigationController.viewControllers = [firstViewController]
        let customeCell :CustomCell = CustomCell()
        customeCell.delegate = self
        
    }
}

extension FirstCoordinator: FirstViewControllerDelegate {
    //    COMMENT(mrocumare): вызов в родительской коллекции
    func navigateToNextPage() {
        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
        secondCoordinator.delegate = self
        childCoordinators.append(secondCoordinator)
        secondCoordinator.start()
    }
    
}

extension FirstCoordinator: FirstViewControllerDelegateInCell {
    //    COMMENT(mrocumare): вызов в дочерней коллекции
    func navigateToSecondController() {
        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
        secondCoordinator.delegate = self
        childCoordinators.append(secondCoordinator)
        secondCoordinator.start()
    }

    
}
extension FirstCoordinator: BackToFirstViewControllerDelegate {

    func navigateBackToFirstPage(newOrderCoordinator: SecondCoordinator) {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}
