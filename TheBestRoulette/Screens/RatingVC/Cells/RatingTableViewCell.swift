//
//  RatingTableViewCell.swift
//  TheBestRoulette
//
//  Created by Irina on 29.04.2024.
//

import UIKit

class RatingTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var winRateLabel: UILabel!
    @IBOutlet weak var coinsLabel: UILabel!
    @IBOutlet weak var numberRatingLabel: UILabel!
    @IBOutlet weak var userBGView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)  
    }
    
    func setup(with model: RatingCellModel, currentNumber: Int) {
        nameLabel.text = model.title
        winRateLabel.text = model.subtitle
        coinsLabel.text = String(model.money)
        numberRatingLabel.text = "\(currentNumber)"
        if model.isItMe {
            setBorder()
        } else {
            removeBorder()
        }
    }
    
    func removeBorder() {
        userBGView.layer.borderWidth = 0
    }
    
    func setBorder() {
        userBGView.layer.borderColor = UIColor(named: "neon")?.cgColor
        userBGView.layer.borderWidth = 2
    }
}
