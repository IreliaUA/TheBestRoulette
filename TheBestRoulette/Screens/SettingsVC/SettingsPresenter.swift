//
//  SettingsPresenter.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//
//

import UIKit
import StoreKit
import Firebase

protocol SettingsPresenterProtocol {
    func viewDidLoad()
    func rateApp()
    func shareApp(completion: @escaping (UIActivityViewController) -> Void)
    func deleteAccount()
    func logOut()
    
    var viewModel: SettingsViewModel? { get }
}

final class SettingsPresenter: SettingsPresenterProtocol {
    
    weak var view: SettingsViewControllerProtocol?
    private let viewModelFactory: SettingsViewModelFactoryProtocol
    private let authManager: AuthManagerProtocol
    
    // MARK: - Initialization
    
    init(
        viewModelFactory: SettingsViewModelFactoryProtocol, authManager: AuthManagerProtocol
    ) {
        self.viewModelFactory = viewModelFactory
        self.authManager = authManager
    }
    
    // MARK: - SettingsPresenterProtocol
    
    var viewModel: SettingsViewModel?
    
    func viewDidLoad() {
        let createdViewModel = viewModelFactory.makeViewModel()
        viewModel = createdViewModel
        view?.setup(with: createdViewModel)
    }
    
    func rateApp() {
        SKStoreReviewController.requestReview()
    }
    
    func shareApp(completion: @escaping (UIActivityViewController) -> Void) {
        let url = URL(string: "https://apps.apple.com/app/idYOUR_APP_ID")!
        let activityViewController = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        completion(activityViewController)
    }
    
    func deleteAccount() {
        authManager.deleteAccount()
    }
    
    private func deleteUserDataFromFirestore(uuid: String, completion: @escaping (Error?) -> Void) {
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uuid)
        
        userRef.delete { error in
            completion(error)
        }
    }
    
    func logOut() {
        authManager.logOut()
    }
}
