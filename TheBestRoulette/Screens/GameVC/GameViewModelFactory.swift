//
//  GameViewModelFactory.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol GameViewModelFactoryProtocol {
    func makeViewModel(coins: Double, name: String) -> GameViewModel
}

final class GameViewModelFactory: GameViewModelFactoryProtocol {
  
  func makeViewModel(coins: Double, name: String) -> GameViewModel {
      let viewModel: GameViewModel = GameViewModel(coins: coins, name: name, variants: [
        Variant(number: "1", colour: .red, coef: 11, variantType: .number),
        Variant(number: "2", colour: .black, coef: 11, variantType: .number),
        Variant(number: "3", colour: .red, coef: 11, variantType: .number),
        Variant(number: "4", colour: .black, coef: 11, variantType: .number),
        Variant(number: "5", colour: .red, coef: 11, variantType: .number),
        Variant(number: "6", colour: .black, coef: 11, variantType: .number),
        Variant(number: "7", colour: .black, coef: 11, variantType: .number),
        Variant(number: "8", colour: .red, coef: 11, variantType: .number),
        Variant(number: "9", colour: .black, coef: 11, variantType: .number),
        Variant(number: "10", colour: .red, coef: 11, variantType: .number),
        Variant(number: "11", colour: .black, coef: 11, variantType: .number),
        Variant(number: "12", colour: .red, coef: 11, variantType: .number),
        Variant(number: "", colour: .red, coef: 2, variantType: .color),
        Variant(number: "", colour: .black, coef: 2, variantType: .color),
        Variant(number: "Even", colour: nil, coef: 2, variantType: .even),
        Variant(number: "Odd", colour: nil, coef: 2, variantType: .odd),
        Variant(number: "Range 1 - 6", colour: nil, coef: 2, variantType: .rangeVariant(1...6)),
        Variant(number: "Range 7 - 12", colour: nil, coef: 2, variantType: .rangeVariant(7...12))
      ])
    return viewModel
  }
}
