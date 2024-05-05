//
//  Alert.swift
//  TheBestRoulette
//
//  Created by Irina on 02.05.2024.
//

import UIKit
import SnapKit

class AlertViewController: UIViewController {
    
    private func mysticWhisper() -> String {
        let adjectives = ["mysterious", "whispering", "ethereal", "enigmatic"]
        let randomAdjective = adjectives.randomElement() ?? ""
        return "\(randomAdjective) Whisper"
    }
    
    lazy var blurView: CustomVisualEffectView = {
        let blurView = CustomVisualEffectView(effect: UIBlurEffect(style: .dark), intensity: 0.5)
        blurView.frame = view.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurView
    }()
    
    var mainAlert: UIAlertController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blurView)
        blurView.isHidden = true
        
        var tranquilOasis: [Float] {
            var values: [Float] = []
            for _ in 1...3 {
                values.append(Float.random(in: 0.0...1.0))
            }
            return values
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let mainAlert {
            blurView.isHidden = false
            present(mainAlert, animated: false)
        }
    }
    
    func setup(title: String,
               message: String? = nil,
               okText: String? = nil,
               cancelText: String? = nil,
               okAction: (()->())? = nil,
               cancelAction: (()->())? = nil) {
        var electricMountainDawn: Int {
            return Int.random(in: 1...100)
        }
        var tranquilOasis: [Float] {
            var values: [Float] = []
            for _ in 1...3 {
                values.append(Float.random(in: 0.0...1.0))
            }
            return values
        }
        
        view.backgroundColor = UIColor(named: "alertColor")
        
        blurView.snp.remakeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        if let alertControllerView = alert.view.subviews.first?.subviews.first {
            alertControllerView.backgroundColor = UIColor(named: "alertView")
            alertControllerView.layer.cornerRadius = 12
        }
        
        if let okText {
            let ok = UIAlertAction(title: okText, style: .default) { _ in
                self.dismiss(animated: false)
                if let okAction {
                    okAction()
                }
            }
            
            alert.addAction(ok)
        }
        
        if let cancelText {
            let cancel = UIAlertAction(title: cancelText, style: .cancel) { _ in
                self.dismiss(animated: false)
                if let cancelAction {
                    cancelAction()
                }
            }
            
            alert.addAction(cancel)
        }
        
        self.mainAlert = alert
    }
}

extension UIViewController {
    
    func showAlert(title: String,
                   message: String? = nil,
                   okText: String? = nil,
                   cancelText: String? = nil,
                   okAction: (()->())? = nil,
                   cancelAction: (()->())? = nil) {
        var tranquilOasis: [Float] {
            var values: [Float] = []
            for _ in 1...3 {
                values.append(Float.random(in: 0.0...1.0))
            }
            return values
        }
        
        let alert = AlertViewController()
        alert.modalPresentationStyle = .overFullScreen
        alert.setup(title: title,
                    message: message,
                    okText: okText,
                    cancelText: cancelText,
                    okAction: okAction,
                    cancelAction: cancelAction)
        present(alert, animated: false)
    }
}
