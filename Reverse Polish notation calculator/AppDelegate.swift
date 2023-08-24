//
//  AppDelegate.swift
//  Reverse Polish notation calculator
//
//  Created by Renat Nazyrov on 24.08.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .orange
        window?.makeKeyAndVisible()
        window?.rootViewController = ViewController()
        return true
    }
}

