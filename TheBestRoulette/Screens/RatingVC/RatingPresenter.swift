//
//  RatingPresenter.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol RatingPresenterProtocol {
    func viewDidLoad()
    var viewModel: RatingViewModel? { get }
}

final class RatingPresenter: RatingPresenterProtocol {
    
    weak var view: RatingViewControllerProtocol?
    private let viewModelFactory: RatingViewModelFactoryProtocol
    private let authManager: AuthManagerProtocol
    
    // MARK: - Initialization
    
    init(
        viewModelFactory: RatingViewModelFactoryProtocol, authManager: AuthManagerProtocol
    ) {
        self.viewModelFactory = viewModelFactory
        self.authManager = authManager
    }
    
    // MARK: - RatingPresenterProtocol
    
    var viewModel: RatingViewModel?
    
    func viewDidLoad() {
        getUsers { users in
            let createdViewModel = self.viewModelFactory.makeViewModel(users: users)
            self.viewModel = createdViewModel
            self.view?.setup(with: createdViewModel)
        }
    }
    
    func getUsers(completion: (([UserInfo]) -> Void)?) {
        authManager.getAllData { users in
            completion?(users)
        }
    }
}
