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
    
    @IBOutlet weak var usersTableView: UITableView!
    @IBOutlet weak var loadingLabel: UILabel!
    
    
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
        presenter.viewDidLoad()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        usersTableView.separatorColor = .clear
        usersTableView.register(UINib(nibName: "RatingTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingCell")
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.rowHeight = 107
        
    }
    
    // MARK: - IBActions
    
}

// MARK: - Extensions

extension RatingViewController: RatingViewControllerProtocol {
    func setup(with viewModel: RatingViewModel) {
        loadingLabel.isHidden = true
        usersTableView.reloadData()
    }
}

extension RatingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.viewModel?.cellModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = presenter.viewModel?.cellModels[indexPath.row]
        
        if let ratingCell = tableView.dequeueReusableCell(withIdentifier: "RatingCell", for: indexPath) as? RatingTableViewCell, let cellModel = data {
            ratingCell.selectionStyle = .none
            ratingCell.setup(with: cellModel, currentNumber: indexPath.row + 1)
            return ratingCell
        } else {
            return UITableViewCell()
        }
    }
}
