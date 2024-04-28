//
//  SettingsPresenter.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol SettingsPresenterProtocol {
    func viewDidLoad()
    var viewModel: SettingsViewModel? { get }
}

final class SettingsPresenter: SettingsPresenterProtocol {
    
    weak var view: SettingsViewControllerProtocol?
    private let viewModelFactory: SettingsViewModelFactoryProtocol
    
    // MARK: - Initialization
    
    init(
        viewModelFactory: SettingsViewModelFactoryProtocol
    ) {
        self.viewModelFactory = viewModelFactory
    }
    
    // MARK: - SettingsPresenterProtocol
    
    var viewModel: SettingsViewModel?
    
    func viewDidLoad() {
        let createdViewModel = viewModelFactory.makeViewModel()
        viewModel = createdViewModel
        view?.setup(with: createdViewModel)
    }
}
