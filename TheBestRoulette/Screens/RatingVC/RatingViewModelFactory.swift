//
//  RatingViewModelFactory.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol RatingViewModelFactoryProtocol {
  func makeViewModel() -> RatingViewModel
}

final class RatingViewModelFactory: RatingViewModelFactoryProtocol {
  
  func makeViewModel() -> RatingViewModel {
    let viewModel: RatingViewModel = RatingViewModel()
    return viewModel
  }
}
