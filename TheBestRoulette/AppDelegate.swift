//
//  AppDelegate.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        Auth.auth().addStateDidChangeListener { auth, user in
            if user == nil {
                self.window?.rootViewController = LogInAssembly().assemble()
                self.window?.makeKeyAndVisible()
            } else {
                self.window?.rootViewController = TabBarController()
                self.window?.makeKeyAndVisible()
            }
        }
        
        
        return true
    }
}
