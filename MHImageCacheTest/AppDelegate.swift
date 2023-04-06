//
//  AppDelegate.swift
//  MHImageCacheTest
//
//  Created by LittleFoxiOSDeveloper on 2023/03/31.
//

import UIKit
import MHImageCache

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = ViewController(ic: MHImageCache())
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

