//
//  TabBarVC.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//

import UIKit

class TabBarController: UIViewController, UITabBarControllerDelegate {
    
    private var integrateTabBarVC: UITabBarController = UITabBarController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        initialSetup()
    }
}

private extension TabBarController {
    
    func initialSetup() {
        
        view.backgroundColor = .black
        integrateTabBarVC.delegate = self
        integrateTabBarVC.tabBar.isTranslucent = false

        integrateTabBarVC.viewControllers = [instantiateRatingsScreen(), instantiateGameScreen(), instantiateSettingsScreen()]
        
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .black
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "lightGrey")!]
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor(named: "lightOrange")!]
        integrateTabBarVC.tabBar.standardAppearance = appearance

        addChild(integrateTabBarVC, toContainer: view)
        self.setSelectedIndex(index: 1)
    }
}

extension TabBarController {
    
    private func setSelectedIndex(index: Int) {
        self.integrateTabBarVC.selectedIndex = index
    }
    
    private func instantiateGameScreen() -> UINavigationController {
        let mainScreen = GameAssembly().assemble()
        
        let navigationVC = UINavigationController(rootViewController: mainScreen)
        
        mainScreen.tabBarItem = UITabBarItem(
            title: "Game", image: UIImage(named: "gameItem")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "gameItemSelect")?.withRenderingMode(.alwaysOriginal)
        )
        return navigationVC
    }
    
    private func instantiateRatingsScreen() -> UINavigationController {
        let ratingScreen = RatingAssembly().assemble()
        
        let navigationVC = UINavigationController(rootViewController: ratingScreen)
        
        ratingScreen.tabBarItem = UITabBarItem(
            title: "Rating", image: UIImage(named: "ratingItem")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "ratingItemSelect")?.withRenderingMode(.alwaysOriginal)
        )
        
        return navigationVC
    }
    
    private func instantiateSettingsScreen() -> UINavigationController {
        let settingsScreen = SettingsAssembly().assemble()
        
        let navigationVC = UINavigationController(rootViewController: settingsScreen)
        
        settingsScreen.tabBarItem = UITabBarItem(
            title: "Settings", image: UIImage(named: "settingsItem")?.withRenderingMode(.alwaysOriginal), selectedImage: UIImage(named: "settingsItemSelect")?.withRenderingMode(.alwaysOriginal)
        )
        
        return navigationVC
    }
}
