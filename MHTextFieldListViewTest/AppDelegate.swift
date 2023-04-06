//
//  AppDelegate.swift
//  MHTextFieldListViewTest
//
//  Created by LittleFoxiOSDeveloper on 2023/04/06.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController()
//        self.window?.rootViewController = ViewControllerByRx()
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

