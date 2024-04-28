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
    
    // MARK: - Initialization
    
    init(viewModelFactory: LogInViewModelFactoryProtocol = LogInViewModelFactory()) {
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - ILogInAssembly
    
    func assemble() -> UIViewController {
        let presenter: LogInPresenter = LogInPresenter(
            viewModelFactory: viewModelFactory
        )
        
        let viewController: LogInViewController = LogInViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
