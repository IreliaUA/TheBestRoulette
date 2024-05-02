//
//  RatingViewModelFactory.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol RatingViewModelFactoryProtocol {
    func makeViewModel(users: [UserInfo]) -> RatingViewModel
}

final class RatingViewModelFactory: RatingViewModelFactoryProtocol {
    
    func makeViewModel(users: [UserInfo]) -> RatingViewModel {
        var cellModels: [RatingCellModel] = []
        
        for user in users {
                let cellModel = RatingCellModel(
                    title: user.name,
                    subtitle: "Win Rate: \(user.winRate)",
                    money: "Coins: \(user.coins)"
                )
                cellModels.append(cellModel)
        }
        
        let sortedUsersByMoney = cellModels.sorted(by: { $0.money > $1.money })
        
        let viewModel = RatingViewModel(cellModels: sortedUsersByMoney)
        return viewModel
    }
}
