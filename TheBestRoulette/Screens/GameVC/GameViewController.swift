//
//  GameViewController.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//

import UIKit

protocol GameViewControllerProtocol: AnyObject {
    func setup(with: GameViewModel)
}

final class GameViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    // MARK: - Properties
    
    private let presenter: GamePresenterProtocol
    
    // MARK: - Lifecycle
    
    init(presenter: GamePresenterProtocol) {
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
    }
    
    // MARK: - IBActions
    
}

// MARK: - Extensions

extension GameViewController: GameViewControllerProtocol {
    func setup(with viewModel: GameViewModel) {
    }
}
