//
//  GameViewModelFactory.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol GameViewModelFactoryProtocol {
    func makeViewModel(coins: Int, name: String) -> GameViewModel
}

final class GameViewModelFactory: GameViewModelFactoryProtocol {
  
  func makeViewModel(coins: Int, name: String) -> GameViewModel {
      let viewModel: GameViewModel = GameViewModel(coins: coins, name: name)
    return viewModel
  }
}
