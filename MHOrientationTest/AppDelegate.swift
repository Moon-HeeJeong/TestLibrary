//
//  AppDelegate.swift
//  MHOrientationTest
//
//  Created by LittleFoxiOSDeveloper on 2023/04/06.
//

import UIKit
import MHOrientation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let vc = ViewController()
        vc.orientation = MHOrientation(vc: vc)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = vc
        
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

