//
//  FirstCoordinator.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 31/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit

class FirstFocus {
    public var section : Int
    public var cell : Int
    init(section: Int, cell: Int) {
        self.section = section
        self.cell = cell
    }
}

var firstFocusPosition = FirstFocus(section: 0, cell: 0)

class FirstCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    unowned let navigationController : UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    
    
    func start() {
        
        let loaderViewController: LoaderViewController = LoaderViewController()
        loaderViewController.delegate = self
        self.navigationController.viewControllers = [loaderViewController]
//            let firstViewController : FirstViewController = FirstViewController()
//            firstViewController.delegate = self
//            self.navigationController.viewControllers = [firstViewController]
        
       
    }
}

extension FirstCoordinator: LoaderCoordinatorDelegate {
    func navigateToPlayList() {
        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
        secondCoordinator.delegate = self
        childCoordinators.append(secondCoordinator)
        secondCoordinator.start()
    }
    
    
    func navigateToFirstView() {
        let firstViewController : FirstViewController = FirstViewController()
        firstViewController.delegate = self
        self.navigationController.viewControllers = [firstViewController]
    }
    
    
}

//extension FirstCoordinator: FirstViewControllerDelegate {
//    //    COMMENT(mrocumare): вызов в родительской коллекции
//    func navigateToNextPage() {
//        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
//        secondCoordinator.delegate = self
//        childCoordinators.append(secondCoordinator)
//        secondCoordinator.start()
//    }
//    
//}

extension FirstCoordinator: FirstViewControllerDelegateInCell {
    func navigateToSecondController() {
        let loaderViewController: LoaderViewController = LoaderViewController()
        loaderViewController.delegate = self
        self.navigationController.viewControllers.append(loaderViewController)
//        self.navigationController.pushViewController(loaderViewController, animated: true)
    }
    
    
    func exitFromApp() {
        self.navigationController.viewControllers.removeAll()
        childCoordinators.removeAll()
        exit(EXIT_SUCCESS)
        
    }
    
    //    COMMENT(mrocumare): вызов в дочерней коллекции
//    func navigateToSecondController() {
//        let loader = LoaderCoordinator(navigationController: navigationController)
//        loader.delegate = self
//        childCoordinators.append(loader)
//        loader.start()
//    }

    
}
extension FirstCoordinator: BackToFirstViewControllerDelegate {

    func navigateBackToFirstPage(newOrderCoordinator: SecondCoordinator) {
        let firstViewController : FirstViewController = FirstViewController()
        firstViewController.delegate = self
        self.navigationController.viewControllers = [firstViewController]
        childCoordinators.removeLast()
    }
}
