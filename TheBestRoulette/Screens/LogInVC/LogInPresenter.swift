//
//  LogInPresenter.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit
import FirebaseAuth
import Firebase


protocol LogInPresenterProtocol {
    func viewDidLoad()
    func logIn(email: String, pass: String)
    func register(email: String, pass: String, name: String)
    func signInAnonymously()
    var viewModel: LogInViewModel? { get }
}

final class LogInPresenter: LogInPresenterProtocol {
    
    weak var view: LogInViewControllerProtocol?
    private let viewModelFactory: LogInViewModelFactoryProtocol
    private let authManager: AuthManagerProtocol
    
    
    var isAuth = false
    
    // MARK: - Initialization
    
    init(
        viewModelFactory: LogInViewModelFactoryProtocol, authManager: AuthManagerProtocol
    ) {
        self.viewModelFactory = viewModelFactory
        self.authManager = authManager
    }
    
    // MARK: - LogInPresenterProtocol
    
    var viewModel: LogInViewModel?
    
    func viewDidLoad() {
        let createdViewModel = viewModelFactory.makeViewModel()
        viewModel = createdViewModel
        view?.setup(with: createdViewModel)
    }
    
    func logIn(email: String, pass: String) {
        authManager.logIn(email: email, pass: pass) { result in
            if result {
                print("покажи алерт удача")
                self.view?.continueMove()
            } else {
                print("покажи алерт грусть")
            }
        }
    }
    
    func register(email: String, pass: String, name: String) {
        authManager.register(email: email, pass: pass, name: name) { result in
            if result {
                print("покажи алерт удача")
                self.view?.continueMove()
            } else {
                print("покажи алерт грусть")
            }
        }
    }
    
    func signInAnonymously() {
        
        authManager.signInAnonymously { result in
            if result {
                print("покажи алерт удача")
                self.view?.continueMove()
            } else {
                print("покажи алерт грусть")
            }
        }
    }
}
