//
//  LoaderCoordinator.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 27/08/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit
//
//
var coordinatorPlayList: PlaylistYouTube?
//
//class LoaderCoordinator: Coordinator {
//    
//    var childCoordinators: [Coordinator] = []
//    
//    unowned let navigationController : UINavigationController
//    
//    weak var delegate: BackToFirstViewControllerDelegate?
//    
//    required init(navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//    
//    func start() {
//        let loaderController : LoaderViewController = LoaderViewController()
//        loaderController.delegate = self
//        self.navigationController.viewControllers = [loaderController]
//        
//    }
//}
//
//extension LoaderCoordinator: LoaderCoordinatorDelegate {
//    
//    func navigateToNextPage() {
//        let firstCoordinator = FirstCoordinator(navigationController: navigationController)
//        childCoordinators.append(firstCoordinator)
//        firstCoordinator.start()
//    }
//    
//    func navigateToPlayList() {
////        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
////        childCoordinators.append(secondCoordinator)
////        secondCoordinator.start()
//        let secondCoordinator = SecondCoordinator(navigationController: navigationController)
//        childCoordinators.append(secondCoordinator)
//        secondCoordinator.start()
//    }
//    //    COMMENT(mrocumare): вызов в родительской коллекции
//   
//    
//}
//
//


