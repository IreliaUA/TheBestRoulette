//
//  SettingsViewModelFactory.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol SettingsViewModelFactoryProtocol {
    func makeViewModel() -> SettingsViewModel
}

final class SettingsViewModelFactory: SettingsViewModelFactoryProtocol {
    
    func makeViewModel() -> SettingsViewModel {
        let viewModel: SettingsViewModel = SettingsViewModel()
        return viewModel
    }
}
