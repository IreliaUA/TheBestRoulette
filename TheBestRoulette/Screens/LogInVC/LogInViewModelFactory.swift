//
//  LogInViewModelFactory.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol LogInViewModelFactoryProtocol {
    func makeViewModel() -> LogInViewModel
}

final class LogInViewModelFactory: LogInViewModelFactoryProtocol {
    
    func makeViewModel() -> LogInViewModel {
        let viewModel: LogInViewModel = LogInViewModel()
        return viewModel
    }
}
