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
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setup(with model: Variant) {
        if let numberAsInt = Int(model.number) {
            numberLabel.text = "Number: \(model.number)"
        } else {
            numberLabel.text = "\(model.number)"
        }
        
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
 
    @IBAction func choseThisBet(_ sender: UIButton) {
        selectCompletion?()
    }
}
