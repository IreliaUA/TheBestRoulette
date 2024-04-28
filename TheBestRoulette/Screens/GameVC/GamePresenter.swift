//
//  GamePresenter.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol GamePresenterProtocol {
    func viewDidLoad()
    var viewModel: GameViewModel? { get }
}

final class GamePresenter: GamePresenterProtocol {
    
    // Dependencies
    weak var view: GameViewControllerProtocol?
    private let viewModelFactory: GameViewModelFactoryProtocol
    
    // MARK: - Initialization
    
    init(
        viewModelFactory: GameViewModelFactoryProtocol
    ) {
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - GamePresenterProtocol
    
    var viewModel: GameViewModel?
    
    func viewDidLoad() {
        let createdViewModel = viewModelFactory.makeViewModel()
        viewModel = createdViewModel
        view?.setup(with: createdViewModel)
    }
}
