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
    
    // MARK: - Initialization
    
    init(viewModelFactory: RatingViewModelFactoryProtocol = RatingViewModelFactory()) {
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - RatingAssemblyProtocol
    
    func assemble() -> UIViewController {
        let presenter: RatingPresenter = RatingPresenter(
            viewModelFactory: viewModelFactory
        )
        
        let viewController: RatingViewController = RatingViewController(presenter: presenter)
        presenter.view = viewController
        
        return viewController
    }
}
