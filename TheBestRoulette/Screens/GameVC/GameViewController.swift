//
//  GameViewController.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//

import UIKit

protocol GameViewControllerProtocol: AnyObject {
    func setup(with: GameViewModel)
    func updateCoinsLabel(coins: Int)
}

final class GameViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var stepperLabel: UILabel!
    @IBOutlet weak var stepperBet: UIStepper!
    @IBOutlet weak var rouletteSpinView: UIView!
    @IBOutlet weak var ballSpinView: UIView!
    
    
    // MARK: - Properties
    
    private let presenter: GamePresenterProtocol
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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    //    presenter.addCoinsIfNeed(completion: <#(() -> Void)?#>)
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        let coins = Double(coinsLabel.text ?? "0") ?? 0
        //stepperBet.minimumValue = coins < 10 ? 0 : coins / 10
        stepperBet.minimumValue = Double(coins < 10 ? 0 : coins / 10)
        stepperLabel.text = "\(Int(stepperBet.value))"
        
    }
    
    func spinRoulete() {
        UIView.animate(withDuration: 5, delay: 0, options: [.curveEaseOut], animations: {
            for _ in 0..<Int.random(in: 5...7) {
                self.rouletteSpinView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi * 1))
                self.rouletteSpinView.transform = CGAffineTransform(rotationAngle: 0)
            }
        })
        UIView.animate(withDuration: 5.5, delay: 0, options: [.curveEaseOut], animations: {
            for _ in 0..<Int.random(in: 9...10) {
//                let randomAngleInRange = Double.random(in: 0...(270 * Double.pi / 180))
//                let randomAngle = randomAngleInRange + (90 * Double.pi / 180)
                self.ballSpinView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.random(in: 0...(2 * Double.pi))))
                self.ballSpinView.transform = CGAffineTransform(rotationAngle: Double.random(in: 0...(2 * Double.pi)))
            }
        })
    }
    
    // MARK: - IBActions
    
    @IBAction func temp(_ sender: Any) {
        let bet = Int(stepperLabel.text ?? "0") ?? 0
        //presenter.loose(bet: bet)
        presenter.win(bet: bet)
        spinRoulete()
    }
    
    @IBAction func stepperBetAction(_ sender: UIStepper) {
        let maxBet = Double(coinsLabel.text ?? "0") ?? 0
        let stepValue = maxBet / 10
        let selectedValue = Int(sender.value * stepValue)
        let cappedValue = min(selectedValue, Int(maxBet))
        stepperLabel.text = "\(cappedValue)"
        if cappedValue == Int(maxBet) {
            showAlert(title: "This is your max bet", okText: "ok")
        }
    }
}

// MARK: - Extensions

extension GameViewController: GameViewControllerProtocol {
    func setup(with viewModel: GameViewModel) {
        coinsLabel.text = "\(viewModel.coins)"
        nameLabel.text = viewModel.name
    }
    func updateCoinsLabel(coins: Int) {
        coinsLabel.text = String(coins)
    }
}
