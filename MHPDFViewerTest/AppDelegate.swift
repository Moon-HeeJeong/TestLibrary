//
//  AppDelegate.swift
//  MHPDFViewerTest
//
//  Created by LittleFoxiOSDeveloper on 2023/04/07.
//

import UIKit
import MHPDFViewer

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        let vc = ViewController()
        let pdfViewer = MHPDFViewer(presenter: vc)
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = vc
        vc.pdfViewer = pdfViewer
        self.window?.makeKeyAndVisible()
        
        return true
    }
}

