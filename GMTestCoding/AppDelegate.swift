//
//  AppDelegate.swift
//  GMTestCoding
//
//  Created by Hansy Enrique Abrego on 30/07/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let rootController = ArtistListMediaViewController(nibName: "ArtistListMediaView",
                                                           bundle: .main)
        rootController.title = "Artist Media Finder"
        let navigation = UINavigationController(rootViewController: rootController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }
}

