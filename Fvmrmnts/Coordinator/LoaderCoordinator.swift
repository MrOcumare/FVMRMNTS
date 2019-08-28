//
//  LoaderCoordinator.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 27/08/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class LoaderCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController : UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let loaderController : LoaderViewController = LoaderViewController()
        loaderController.delegate = self
        self.navigationController.viewControllers = [loaderController]
        
    }
}

extension LoaderCoordinator: LoaderCoordinatorDelegate {
    
    func navigateToNextPage() {
        let firstCoordinator = FirstCoordinator(navigationController: navigationController)
//        childCoordinators.removeLast()
        childCoordinators.append(firstCoordinator)
        firstCoordinator.start()
    }
    
    //    COMMENT(mrocumare): вызов в родительской коллекции
   
    
}




