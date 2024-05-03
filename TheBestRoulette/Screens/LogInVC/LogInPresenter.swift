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
                self.view?.showAlert(title: "You have successfully logged into your account")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.view?.continueMove()
                }
            } else {
                self.view?.showAlert(title: "This account doesn't exist", message: "Let's create a new one", okText: "OK")
            }
        }
    }
    
    func register(email: String, pass: String, name: String) {
        authManager.register(email: email, pass: pass, name: name) { result in
            if result {
                self.view?.showAlert(title: "Account was successfully registered")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.view?.continueMove()
                }
            } else {
                self.view?.showAlert(title: "This account is already exist", message: "Let's log in", okText: "OK")
            }
        }
    }
    
    func signInAnonymously() {
        authManager.signInAnonymously { result in
            if result {
                self.view?.showAlert(title: "Account was created successfully")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.view?.continueMove()
                }
            } else {
            }
        }
    }
}
