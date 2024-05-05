//
//  VariantTableViewCell.swift
//  TheBestRoulette
//
//  Created by Irina on 04.05.2024.
//

import UIKit

class VariantTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    @IBOutlet weak var cilorView: UIView!
    
    var selectCompletion: (() -> Void)?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(with model: Variant) {
        numberLabel.text = "\(model.number)"
        if let colour = model.colour {
            cilorView.isHidden = false
            colorLabel.isHidden = false
            colorLabel.text = "\(colour.rawValue)"
            switch colour {
            case .red:
                cilorView.backgroundColor = .red
            case .black:
                cilorView.backgroundColor = .black
            }
        } else {
            cilorView.isHidden = true
            colorLabel.isHidden = true
        }
        
    }
   
    
//    IBACTion func chooseButton() {
    @IBAction func choseThisBet(_ sender: UIButton) {
        selectCompletion?()
    }
}
