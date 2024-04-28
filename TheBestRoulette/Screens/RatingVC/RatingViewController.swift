//
//  RatingViewController.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//

import UIKit

protocol RatingViewControllerProtocol: AnyObject {
    func setup(with: RatingViewModel)
}

final class RatingViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    // MARK: - Properties
    
    private let presenter: RatingPresenterProtocol
    
    // MARK: - Lifecycle
    
    init(presenter: RatingPresenterProtocol) {
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

extension RatingViewController: RatingViewControllerProtocol {
    func setup(with viewModel: RatingViewModel) {
    }
}
