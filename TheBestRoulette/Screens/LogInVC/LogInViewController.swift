//
//  LogInViewController.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//

import UIKit

protocol LogInViewControllerProtocol: AnyObject {
    func setup(with: LogInViewModel)
}

final class LogInViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    // MARK: - Properties
    
    private let presenter: LogInPresenterProtocol
    
    // MARK: - Lifecycle
    
    init(presenter: LogInPresenterProtocol) {
        self.presenter = presenter
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        presenter.viewDidLoad()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        
        //        let vc = OnboardingViewControllerAzure()
        //        let nc = NavigationControllerWhimsical(rootViewController: vc)
        //        nc.isNavigationBarHidden = true
        //        let transition = CATransition()
        //        transition.duration = 0.40
        //        transition.type = .fade
        //        if let window = UIApplication.shared.windows.first {
        //            window.layer.add(transition, forKey: "fade")
        //            window.rootViewController = nc
        //        }
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.40
        transition.type = .fade
        if let window = UIApplication.shared.windows.first {
            window.layer.add(transition, forKey: "fade")
            window.rootViewController = tabBarController
        }
    }
    
    // MARK: - IBActions
    
}

// MARK: - Extensions

extension LogInViewController: LogInViewControllerProtocol {
    func setup(with viewModel: LogInViewModel) {
    }
}
