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
    func addCoinsIfNeed(completion: (() -> Void)?)
    func play(bet: Double, userVariant: Variant)
    var coins: Double { get }
}

final class GamePresenter: GamePresenterProtocol {
    
    // Dependencies
    weak var view: GameViewControllerProtocol?
    private let viewModelFactory: GameViewModelFactoryProtocol
    private let authManager: AuthManagerProtocol
    var coins: Double = 0
    var name: String = "User 1"
    var variants: [Variant] = []
    
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
        getCoins { (coins, name) in
            self.coins = coins
            let createdViewModel = self.viewModelFactory.makeViewModel(coins: coins, name: name)
            self.viewModel = createdViewModel
            self.view?.setup(with: createdViewModel)
        }
    }
    
    func getCoins(completion: (((Double, String)) -> Void)?) {
        authManager.getCurrentUserData { userData in
            if let name = userData?.name, let coins = userData?.coins {
                completion?((coins, name))
            }
        }
    }
    
    func play(bet: Double, userVariant: Variant) {
        guard
            let viewModelNew = self.viewModel,
            coins >= bet else {
            return
        }
        addCoinsIfNeed {
            var customVariants: [Variant] = viewModelNew.variants
            let elementsToRemove = 6
            
            if customVariants.count >= elementsToRemove {
                customVariants.removeLast(elementsToRemove)
            }
            
            if let randomElement = customVariants.randomElement() {
                print("Random variant = \(randomElement)")
                print("User variant = \(userVariant)")
                switch userVariant.variantType {
                case .rangeVariant(let closedRange):
                    if let numberAsInt = Int(randomElement.number) {
                        if closedRange.contains(numberAsInt) {
                            self.win(bet: bet * userVariant.coef, variant: randomElement)
                            print("Win Range")
                        } else {
                            print("loose range")
                            self.loose(bet: bet, variant: randomElement)
                        }
                    }
                case .even:
                    if let numberAsInt = Int(randomElement.number) {
                        if numberAsInt % 2 == 0 {
                            self.win(bet: bet * userVariant.coef, variant: randomElement)
                        } else {
                            self.loose(bet: bet, variant: randomElement)
                        }
                    }
                case .odd:
                    if let numberAsInt = Int(randomElement.number) {
                        if numberAsInt % 2 != 0 {
                            self.win(bet: bet * userVariant.coef, variant: randomElement)
                        } else {
                            self.loose(bet: bet, variant: randomElement)
                        }
                    }
                case .number:
                    if
                        let numberAsDouble = Double(userVariant.number),
                        let randomNumberAsDouble = Double(randomElement.number)
                    {
                        if numberAsDouble == randomNumberAsDouble {
                            self.win(bet: bet * randomElement.coef, variant: randomElement)
                        } else {
                            self.loose(bet: bet, variant: randomElement)
                        }
                    }
                case .color:
                    if let userColor = userVariant.colour,
                       let randomColor = randomElement.colour {
                        if userColor == randomColor {
                            self.win(bet: bet * userVariant.coef, variant: randomElement)
                        } else {
                            self.loose(bet: bet, variant: randomElement)
                        }
                    } else {
                        self.loose(bet: bet, variant: randomElement)
                    }
                }
            } else {
                print("error with view model")
            }
        }
    }
    
    func loose(bet: Double, variant: Variant) {
        if coins != 0 {
            coins -= bet
        }
        self.view?.resultOfPlay(result: "Try again!", isWin: "Better luck next time!", variant: variant)
        changeUserCoins(newCoins: coins, winRate: .loose)
    }
    
    func win(bet: Double, variant: Variant) {
        if coins != 0 {
            coins += bet
        }
        self.view?.resultOfPlay(result: "+ \(bet) coins", isWin: "You win!", variant: variant)
        changeUserCoins(newCoins: coins, winRate: .win)
    }
    
    func addCoinsIfNeed(completion: (() -> Void)?) {
        if coins < 100 {
            coins += 100
            changeUserCoins(newCoins: coins, winRate: .all, completion: completion)
            self.view?.showAlert(title: "Your balance is less than 100 so keep some more coins!", okText: "Ok", okAction: {
                self.view?.refreshStepper()
            })
            
        } else {
            completion?()
        }
    }
    
    func changeUserCoins(newCoins: Double, winRate: WinRate, completion: (() -> Void)? = nil) {
        authManager.changeUserCoins(with: newCoins, winRate: winRate) {
            self.view?.updateCoinsLabel(coins: newCoins)
            completion?()
        }
    }
}

struct Variant {
    let number: String
    let colour: VariantColours?
    let coef: Double
    let variantType: VariantType
}

enum VariantColours: String {
    case red = "Red"
    case black = "Black"
    
}

enum VariantType {
    case rangeVariant((ClosedRange<Int>)), even, odd, number, color
}

enum WinRate {
    case win, loose, all
}
