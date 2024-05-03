//
//  RatingAssembly.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol RatingAssemblyProtocol {
    func assemble() -> UIViewController
}

final class RatingAssembly: RatingAssemblyProtocol {
    
    // Dependencies
    private let viewModelFactory: RatingViewModelFactoryProtocol
    private let authManager: AuthManagerProtocol
    
    // MARK: - Initialization
    
    init(viewModelFactory: RatingViewModelFactoryProtocol = RatingViewModelFactory(), authManager: AuthManagerProtocol = AuthManager()) {
        self.viewModelFactory = viewModelFactory
        self.authManager = authManager
    }
    
    // MARK: - RatingAssemblyProtocol
    
    func assemble() -> UIViewController {
        let presenter: RatingPresenter = RatingPresenter(
            viewModelFactory: viewModelFactory, authManager: authManager
        )
        
        let viewController: RatingViewController = RatingViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
