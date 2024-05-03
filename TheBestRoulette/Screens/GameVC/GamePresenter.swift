//
//  GamePresenter.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit

protocol GamePresenterProtocol {
    func viewDidLoad()
    var viewModel: GameViewModel? { get }
    func loose(bet: Int)
    func win(bet: Int)
    func addCoinsIfNeed(completion: (() -> Void)?)
}

final class GamePresenter: GamePresenterProtocol {
    
    // Dependencies
    weak var view: GameViewControllerProtocol?
    private let viewModelFactory: GameViewModelFactoryProtocol
    private let authManager: AuthManagerProtocol
    var coins: Int = 0
    
    // MARK: - Initialization
    
    init(
        viewModelFactory: GameViewModelFactoryProtocol, authManager: AuthManagerProtocol
    ) {
        self.viewModelFactory = viewModelFactory
        self.authManager = authManager
    }
    
    // MARK: - GamePresenterProtocol
    
    var viewModel: GameViewModel?
    
    func viewDidLoad() {
        //        let createdViewModel = viewModelFactory.makeViewModel()
        //        viewModel = createdViewModel
        //        view?.setup(with: createdViewModel)
        getCoins { coins in
            if let coins = coins {
                self.coins = coins
                let createdViewModel = self.viewModelFactory.makeViewModel(coins: coins)
                self.viewModel = createdViewModel
                self.view?.setup(with: createdViewModel)
            } else {
                // Handle the case where coins is nil
            }
        }
    }
    func getCoins(completion: ((Int?) -> Void)?) {
        authManager.getUserCoins { coins in
            completion?(coins)
        }
    }
    
    func play(bet: Int) {
        addCoinsIfNeed {
            
            
            var iswin = Bool.random()
            if true {
                self.loose(bet: bet)
            } else {
                self.win(bet: bet)
            }
        }
    }
    
    func loose(bet: Int) {
        if coins != 0 {
            coins -= bet
        }
        changeUserCoins(newCoins: coins)
    }
    
    func win(bet: Int) {
        if coins != 0 {
            coins += bet
        }
        changeUserCoins(newCoins: coins)
    }
    
    func addCoinsIfNeed(completion: (() -> Void)?) {
        if coins < 100 {
            coins += 100
            changeUserCoins(newCoins: coins, completion: completion)
        } else {
            completion?()
        }
    }
    
    func changeUserCoins(newCoins: Int, completion: (() -> Void)? = nil) {
        authManager.changeUserCoins(with: newCoins) {
            self.view?.updateCoinsLabel(coins: newCoins)
            completion?()
        }
    }
}
