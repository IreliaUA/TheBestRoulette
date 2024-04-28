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
    
    // Dependencies
    weak var view: RatingViewControllerProtocol?
    private let viewModelFactory: RatingViewModelFactoryProtocol
    
    // MARK: - Initialization
    
    init(
        viewModelFactory: RatingViewModelFactoryProtocol
    ) {
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - RatingPresenterProtocol
    
    var viewModel: RatingViewModel?
    
    func viewDidLoad() {
        let createdViewModel = viewModelFactory.makeViewModel()
        viewModel = createdViewModel
        view?.setup(with: createdViewModel)
    }
}
