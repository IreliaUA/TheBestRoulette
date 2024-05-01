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
    
    @IBOutlet private weak var shareAppStack: UIStackView!
    @IBOutlet private weak var rateAppStack: UIStackView!
    @IBOutlet private weak var deleteAccStack: UIStackView!
    @IBOutlet private weak var logOutStack: UIStackView!
    
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
        let rateAppGesture = UITapGestureRecognizer(target: self, action: #selector(rateAppAction))
        rateAppStack.addGestureRecognizer(rateAppGesture)
        
        let shareAppGesture = UITapGestureRecognizer(target: self, action: #selector(shareAppAction))
        shareAppStack.addGestureRecognizer(shareAppGesture)
        
        let deleteAccAppGesture = UITapGestureRecognizer(target: self, action: #selector(deleteAccAction))
        deleteAccStack.addGestureRecognizer(deleteAccAppGesture)
        
        let logOutGesture = UITapGestureRecognizer(target: self, action: #selector(logOutAppAction))
        logOutStack.addGestureRecognizer(logOutGesture)
    }
    
    // MARK: - IBActions
    
    
    @objc func rateAppAction() {
        presenter.rateApp()
    }
    
    @objc func shareAppAction() {
        presenter.shareApp(completion: { activityViewController in
            self.present(activityViewController, animated: true, completion: nil)
        })
    }
    
    @objc func deleteAccAction() {
        presenter.deleteAccount()
    }
    
    @objc func logOutAppAction() {
        presenter.logOut()
    }
    
}

// MARK: - Extensions

extension SettingsViewController: SettingsViewControllerProtocol {
    func setup(with viewModel: SettingsViewModel) {
    }
}
