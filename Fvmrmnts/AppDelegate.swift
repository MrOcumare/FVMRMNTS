//
//  AppDelegate.swift
//  Fvmrmnts
//
//  Created by Mr.Ocumare on 18/07/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    // Make the first coordinator with a strong reference
    
//    var fisrtCoordinator : FirstCoordinator?
    var firstcoordinator : FirstCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController()
        
        // Initialise the first coordinator with the main navigation controller
        firstcoordinator = FirstCoordinator(navigationController: window?.rootViewController as! UINavigationController)
        
        // The start method will actually display the main view
        firstcoordinator?.start()
        
        window?.makeKeyAndVisible()
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
      
        // Initialise the first coordinator with the main navigation controller
       
        
        // The start method will actually display the main view
      
         print("----exi767t")
        
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

//    var bgTask : UIBackgroundTaskIdentifier!
    
    func applicationDidEnterBackground(_ application: UIApplication) {
//        bgTask = application.beginBackgroundTask(expirationHandler: { () -> Void in
//            application.endBackgroundTask(self.bgTask)
//            self.bgTask = UIBackgroundTaskIdentifier.invalid
//        })
//
//        DispatchQueue.global(qos : .background).async() { () -> Void in
//            self.bgTask = UIBackgroundTaskIdentifier.invalid
//            application.endBackgroundTask(self.bgTask)
//        }
//         print("----exi767dsdfsfsdt")
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        print("----exsdfasdfasdfsadfasdfasdasdfai767t")
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
         print("=================exi767t")
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
       
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
       
        let container = NSPersistentContainer(name: "Fvmrmnts")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
               
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

