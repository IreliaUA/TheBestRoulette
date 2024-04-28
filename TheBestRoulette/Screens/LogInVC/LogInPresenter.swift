//
//  LogInPresenter.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol LogInPresenterProtocol {
    func viewDidLoad()
    var viewModel: LogInViewModel? { get }
}

final class LogInPresenter: LogInPresenterProtocol {
    
    weak var view: LogInViewControllerProtocol?
    private let viewModelFactory: LogInViewModelFactoryProtocol
    
    // MARK: - Initialization
    
    init(
        viewModelFactory: LogInViewModelFactoryProtocol
    ) {
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - LogInPresenterProtocol
    
    var viewModel: LogInViewModel?
    
    func viewDidLoad() {
        let createdViewModel = viewModelFactory.makeViewModel()
        viewModel = createdViewModel
        view?.setup(with: createdViewModel)
    }
}
