//
//  AppDelegate.swift
//  DISample
//
//  Created by DMI on 27/04/17.
//  Copyright © 2017 DMI. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    var window: UIWindow?
    
    var rootViewController: RootViewController?
    var navController: UINavigationController?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool
    {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        navController = UINavigationController()
        navController?.viewControllers = [self.rootViewController!]
        
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()

        return true
    }
}

