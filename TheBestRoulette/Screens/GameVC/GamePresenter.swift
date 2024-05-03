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
    var name: String = "User 1"
    
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
        getCoins { (coins, name) in
            self.coins = coins
            let createdViewModel = self.viewModelFactory.makeViewModel(coins: coins, name: name)
            self.viewModel = createdViewModel
            self.view?.setup(with: createdViewModel)
        }
    }
    
    func getCoins(completion: (((Int, String)) -> Void)?) {
        authManager.getUserCoins { (coins, name) in
            completion?((coins, name))
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
