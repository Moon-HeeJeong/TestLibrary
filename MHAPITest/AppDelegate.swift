//
//  AppDelegate.swift
//  MHAPITest
//
//  Created by LittleFoxiOSDeveloper on 2023/04/10.
//

import UIKit
import MHAPI

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let vc = ViewController()
        vc.api = AppleAPI()
        self.window?.rootViewController = vc
        self.window?.makeKeyAndVisible()
        
        return true
    }
}
