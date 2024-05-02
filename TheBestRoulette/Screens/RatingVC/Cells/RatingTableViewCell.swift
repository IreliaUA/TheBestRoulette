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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setup(with model: RatingCellModel, currentNumber: Int) {
        nameLabel.text = model.title
        winRateLabel.text = "win rate: \(model.subtitle)%"
        coinsLabel.text = model.money
        
    }
    
}
