//
//  LogInViewController.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//

import UIKit

protocol LogInViewControllerProtocol: AnyObject {
    func setup(with: LogInViewModel)
    func continueMove()
}

final class LogInViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    
    // MARK: - Properties
    
    private let presenter: LogInPresenterProtocol
    private var login: String = ""
    private var pass: String = ""
    
    // MARK: - Lifecycle
    
    init(presenter: LogInPresenterProtocol) {
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
        
        loginTextField.delegate = self
        passTextField.delegate = self
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tapGesture)
        
        
//                let tabBarController = TabBarController()
//                tabBarController.modalPresentationStyle = .fullScreen
//                let transition = CATransition()
//                transition.duration = 0.40
//                transition.type = .fade
//                if let window = UIApplication.shared.windows.first {
//                    window.layer.add(transition, forKey: "fade")
//                    window.rootViewController = tabBarController
//                }
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    
    
    @IBAction func loginTextFieldAction(_ sender: UITextField) {
        if let text = sender.text {
            if isValidEmail(text) {
                login = text
            } else {
                print("error")
            }
        } else {
            print("no text")
        }
    }
    
    
    @IBAction func passTextFieldAction(_ sender: UITextField) {
        if let text = sender.text {
            pass = text
        } else {
            print("no text")
        }
    }
    @IBAction func loginAction(_ sender: UIButton) {
        presenter.logIn(email: login, pass: pass)
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        presenter.register(email: login, pass: pass, name: "")
    }
    
    @IBAction func anonAction(_ sender: UIButton) {
        presenter.signInAnonymously()
    }
    
}


// MARK: - Extensions

extension LogInViewController: LogInViewControllerProtocol {
    func setup(with viewModel: LogInViewModel) {
    }
    
    func continueMove() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        let transition = CATransition()
        transition.duration = 0.40
        transition.type = .fade
        if let window = UIApplication.shared.windows.first {
            window.layer.add(transition, forKey: "fade")
            window.rootViewController = tabBarController
        }
    }
}

extension LogInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
