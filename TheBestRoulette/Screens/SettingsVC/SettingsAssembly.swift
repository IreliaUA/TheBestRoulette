//
//  SettingsAssembly.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol SettingsAssemblyProtocol {
    func assemble() -> UIViewController
}

final class SettingsAssembly: SettingsAssemblyProtocol {
    
    private let viewModelFactory: SettingsViewModelFactoryProtocol
    private let authManager: AuthManagerProtocol
    
    // MARK: - Initialization
    
    init(viewModelFactory: SettingsViewModelFactoryProtocol = SettingsViewModelFactory(), authManager: AuthManagerProtocol = AuthManager()) {
        self.viewModelFactory = viewModelFactory
        self.authManager = authManager
    }
    
    // MARK: - SettingsAssemblyProtocol
    
    func assemble() -> UIViewController {
        let presenter: SettingsPresenter = SettingsPresenter(
            viewModelFactory: viewModelFactory, authManager: authManager
        )
        
        let viewController: SettingsViewController = SettingsViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
