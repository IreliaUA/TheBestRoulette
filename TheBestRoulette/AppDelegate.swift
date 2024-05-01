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

        var logInVC = LogInAssembly().assemble()

        window?.rootViewController = logInVC
        window?.makeKeyAndVisible()
        return true
    }
}
