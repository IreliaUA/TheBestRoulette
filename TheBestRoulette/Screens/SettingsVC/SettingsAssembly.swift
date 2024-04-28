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
    
    // MARK: - Initialization
    
    init(viewModelFactory: SettingsViewModelFactoryProtocol = SettingsViewModelFactory()) {
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - SettingsAssemblyProtocol
    
    func assemble() -> UIViewController {
        let presenter: SettingsPresenter = SettingsPresenter(
            viewModelFactory: viewModelFactory
        )
        
        let viewController: SettingsViewController = SettingsViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
