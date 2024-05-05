//
//  GameViewController.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//

import UIKit

protocol GameViewControllerProtocol: UIViewController {
    func setup(with: GameViewModel)
    func updateCoinsLabel(coins: Double)
    func resultOfPlay(result: String, isWin: String)
}

final class GameViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var stepperBet: UIStepper!
    @IBOutlet weak var rouletteSpinView: UIView!
    @IBOutlet weak var ballSpinView: UIView!
    
    @IBOutlet weak var betTableView: UITableView!
    @IBOutlet weak var choosenVariantLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var chooseBetButton: UIButton!
    
    
    @IBOutlet weak var winLooseView: UIView!
    @IBOutlet weak var youWinLooseLabel: UILabel!
    @IBOutlet weak var howManyLabel: UILabel!
    @IBOutlet weak var closeWinLooseButton: UIButton!
    // MARK: - Properties
    
    private let presenter: GamePresenterProtocol
    var bet: Double = 0
    var choosenVariat: Variant? = nil
    var isTableViewVisible = false
   // var currentBallSpinAngle: CGFloat = Double.pi
    
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
        betTableView.isHidden = true
        winLooseView.isHidden = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    //    presenter.addCoinsIfNeed(completion: <#(() -> Void)?#>)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        
        betTableView.separatorColor = .clear
        betTableView.register(UINib(nibName: "VariantTableViewCell", bundle: nil), forCellReuseIdentifier: "VariantCell")
        betTableView.delegate = self
        betTableView.dataSource = self
        betTableView.rowHeight = 50
        betTableView.contentInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        
        let plusImage = UIImage(systemName: "plus.circle.fill")
                stepperBet.setIncrementImage(plusImage, for: .normal)
        stepperBet.tintColor = UIColor(named: "neon")
                
        let minusImage = UIImage(systemName: "minus.circle.fill")
        stepperBet.setDecrementImage(minusImage, for: .normal)
        stepperBet.tintColor = UIColor(named: "neon")
        
    }
    
    func refreshStepper() {
        let maxBet = presenter.coins
        let stepValue = maxBet / 10
        let selectedValue = Int(stepperBet.value * stepValue)
        let cappedValue = min(selectedValue, Int(maxBet))
        stepperLabel.text = "\(cappedValue)"
        bet = Double(cappedValue)
    }
    
    func resultOfPlay(result: String, isWin: String) {
        winLooseView.isHidden.toggle()
        howManyLabel.text = "\(result)"
        youWinLooseLabel.text = "\(isWin)"
    }
    
    func spinRoulete(variant: Variant) {
        
        UIView.animate(withDuration: 5, delay: 0, options: [.curveEaseOut], animations: {
            for _ in 0..<Int.random(in: 5...7) {
                self.rouletteSpinView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 1))
                self.rouletteSpinView.transform = CGAffineTransform(rotationAngle: 0)
            }
        })
        
        UIView.animate(withDuration: 5.5, delay: 0) {
            for _ in 0..<Int.random(in: 9...10) {
                self.ballSpinView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.random(in: 0...(2 * Double.pi))))
                self.ballSpinView.transform = CGAffineTransform(rotationAngle: Double.random(in: 0...(2 * Double.pi)))
            }
        } completion: { istrrue in
            self.presenter.play(bet: self.bet, userVariant: variant)
            self.refreshStepper()
        }
    }
    
    // MARK: - IBActions
    
    @IBAction func temp(_ sender: Any) {
        
        if self.bet <= 0.0 || self.choosenVariat == nil {
            showAlert(title: "Choose your bet", okText: "ok")
        } else {
            if presenter.coins >= bet, let choosenVariat {
                chooseBetButton.isUserInteractionEnabled = false
                playButton.isUserInteractionEnabled = false
                stepperBet.isUserInteractionEnabled = false
                spinRoulete(variant: choosenVariat)
            }
        }
//        
//        if presenter.coins >= bet {
//            spinRoulete()
//        }
        
    }
    
    @IBAction func closeWinLooseButtonAction(_ sender: UIButton) {
        winLooseView.isHidden = true
        presenter.addCoinsIfNeed(completion: nil)
        
        self.chooseBetButton.isUserInteractionEnabled = true
        self.playButton.isUserInteractionEnabled = true
        self.stepperBet.isUserInteractionEnabled = true
    }
    
    @IBAction func stepperBetAction(_ sender: UIStepper) {
        let maxBet = presenter.coins
        let stepValue = maxBet / 10
        let selectedValue = Int(sender.value * stepValue)
        let cappedValue = min(selectedValue, Int(maxBet))
        stepperLabel.text = "\(cappedValue)"
        bet = Double(cappedValue)
        
        if selectedValue > Int(maxBet) {
            showAlert(title: "This is your max bet", okText: "ok")
        }
    }
    
    @IBAction func chooseBetAction(_ sender: UIButton) {
        self.betTableView.isHidden.toggle()
    }
}

// MARK: - Extensions

extension GameViewController: GameViewControllerProtocol {
    func setup(with viewModel: GameViewModel) {
        coinsLabel.text = "\(viewModel.coins)"
        nameLabel.text = viewModel.name
        betTableView.reloadData()
        let coins = viewModel.coins
        //stepperBet.minimumValue = coins < 10 ? 0 : coins / 10
       // stepperBet.minimumValue = Double(coins < 10 ? 0 : coins / 10)
        stepperBet.minimumValue = Double(0)
        stepperLabel.text = "\(stepperBet.value)"
//        menu.items = viewModel.variants
    }
    func updateCoinsLabel(coins: Double) {
        coinsLabel.text = String(coins)
    }
}


extension GameViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.viewModel?.variants.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellData = presenter.viewModel?.variants[indexPath.row]
        
        if let variantCell = tableView.dequeueReusableCell(withIdentifier: "VariantCell", for: indexPath) as? VariantTableViewCell, let cellModel = cellData {
            variantCell.selectionStyle = .none
            variantCell.setup(with: cellModel)
            variantCell.selectCompletion = {
//                self.betTableView.isHidden = true
//                self.betTableView.isUserInteractionEnabled = false
                self.betTableView.isHidden.toggle()
                
                self.choosenVariat = cellModel
                var resultString = ""
                resultString += String(cellModel.number)
                if let colorName = cellModel.colour?.rawValue {
                    resultString += " \(colorName)"
                }
                
                
                self.choosenVariantLabel.text = resultString
            }
            return variantCell
        } else {
            return UITableViewCell()
        }
    }
}
