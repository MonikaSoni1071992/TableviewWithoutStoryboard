//
//  AppDelegate.swift
//  TableViewWithoutStoryboard
//
//  Created by mac on 24/07/21.
//  Copyright © 2021 Monika_Soni. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        Utility.setNavigationBarColor(color: UIColor.blue)
        Utility.setBarButtonColor(color: UIColor.gray)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: HomeMainViewController())
        window?.makeKeyAndVisible()
        return true
    }
}
