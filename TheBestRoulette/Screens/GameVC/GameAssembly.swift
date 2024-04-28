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
    
    // MARK: - Initialization
    
    init(viewModelFactory: GameViewModelFactoryProtocol = GameViewModelFactory()) {
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - GameAssemblyProtocol
    
    func assemble() -> UIViewController {
        let presenter: GamePresenter = GamePresenter(
            viewModelFactory: viewModelFactory
        )
        
        let viewController: GameViewController = GameViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
