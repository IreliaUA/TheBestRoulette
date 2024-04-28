//
//  GameViewModelFactory.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol GameViewModelFactoryProtocol {
  func makeViewModel() -> GameViewModel
}

final class GameViewModelFactory: GameViewModelFactoryProtocol {
  
  func makeViewModel() -> GameViewModel {
    let viewModel: GameViewModel = GameViewModel()
    return viewModel
  }
}
