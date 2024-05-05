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
            var winRateResult = ""
            let totalWins = Double(user.win)
            let totalLosses = Double(user.loose)
            let totalGames = totalWins + totalLosses
            
            if totalWins == 0 {
                winRateResult = String(0)
            } else {
                let winRate = Double(totalWins) / Double(totalGames) * 100
                winRateResult = String(winRate.truncate(places: 1))
            }
            
            let cellModel = RatingCellModel(
                title: user.name,
                subtitle: "win rate: \(winRateResult)%",
                money: user.coins,
                isItMe: user.isItMe
            )
            cellModels.append(cellModel)
        }
        
        let sortedUsersByMoney = cellModels.sorted(by: { $0.money > $1.money })
        
        let viewModel = RatingViewModel(cellModels: sortedUsersByMoney)
        return viewModel
    }
}
