//
//  RatingViewModelFactory.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol RatingViewModelFactoryProtocol {
    func makeViewModel(users: [[String: Any]]) -> RatingViewModel
}

final class RatingViewModelFactory: RatingViewModelFactoryProtocol {
    
    func makeViewModel(users: [[String: Any]]) -> RatingViewModel {
        var cellModels: [RatingCellModel] = []
        
        for user in users {
            if let name = user["name"] as? String,
               let winRate = user["winRate"] as? Int,
               let coins = user["coins"] as? Int {
                let cellModel = RatingCellModel(
                    title: name,
                    subtitle: "Win Rate: \(winRate)",
                    money: "Coins: \(coins)"
                )
                cellModels.append(cellModel)
            }
        }
        
        let sortedUsersByMoney = cellModels.sorted(by: { $0.money > $1.money })
        
        let viewModel = RatingViewModel(cellModels: sortedUsersByMoney)
        return viewModel
    }
}
