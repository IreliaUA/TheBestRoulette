//
//  GameAssembly.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol GameAssemblyProtocol {
    func assemble() -> UIViewController
}

final class GameAssembly: GameAssemblyProtocol {
    
    private let viewModelFactory: GameViewModelFactoryProtocol
    private let authManager: AuthManagerProtocol
    
    // MARK: - Initialization
    
    init(viewModelFactory: GameViewModelFactoryProtocol = GameViewModelFactory(), authManager: AuthManagerProtocol = AuthManager()) {
        self.viewModelFactory = viewModelFactory
        self.authManager = authManager
    }
    
    // MARK: - GameAssemblyProtocol
    
    func assemble() -> UIViewController {
        let presenter: GamePresenter = GamePresenter(
            viewModelFactory: viewModelFactory, authManager: authManager
        )
        
        let viewController: GameViewController = GameViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
