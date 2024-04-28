//
//  SettingsViewController.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//

import UIKit

protocol SettingsViewControllerProtocol: AnyObject {
    func setup(with: SettingsViewModel)
}

final class SettingsViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    // MARK: - Properties
    
    private let presenter: SettingsPresenterProtocol
    
    // MARK: - Lifecycle
    
    init(presenter: SettingsPresenterProtocol) {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
    }
    
    // MARK: - IBActions
    
}

// MARK: - Extensions

extension SettingsViewController: SettingsViewControllerProtocol {
    func setup(with viewModel: SettingsViewModel) {
    }
}
