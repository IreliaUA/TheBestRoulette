//
//  LogInAssembly.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol ILogInAssembly {
    func assemble() -> UIViewController
}

final class LogInAssembly: ILogInAssembly {
    
    private let viewModelFactory: LogInViewModelFactoryProtocol
    private let authManager: AuthManagerProtocol
    
    // MARK: - Initialization
    
    init(viewModelFactory: LogInViewModelFactoryProtocol = LogInViewModelFactory(), authManager: AuthManagerProtocol = AuthManager()) {
        self.viewModelFactory = viewModelFactory
        self.authManager = authManager
    }
    
    // MARK: - ILogInAssembly
    
    func assemble() -> UIViewController {
        let presenter: LogInPresenter = LogInPresenter(
            viewModelFactory: viewModelFactory, authManager: authManager
        )
        
        let viewController: LogInViewController = LogInViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
