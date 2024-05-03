//
//  GameViewModelFactory.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol GameViewModelFactoryProtocol {
  func makeViewModel(coins: Int) -> GameViewModel
}

final class GameViewModelFactory: GameViewModelFactoryProtocol {
  
  func makeViewModel(coins: Int) -> GameViewModel {
      let viewModel: GameViewModel = GameViewModel(coins: coins)
    return viewModel
  }
}
