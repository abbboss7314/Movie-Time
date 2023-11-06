//
//  AppDelegate.swift
//  Movie-Time
//
//  Created by Death Heart on 08/09/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        let vc = TabBarController(nibName: "TabBarController", bundle: nil)
        let nav = UINavigationController(rootViewController: vc)
        
        window?.rootViewController = nav
        
        return true
    }

   


}

