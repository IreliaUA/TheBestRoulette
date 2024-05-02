//
//  LogInViewController.swift
//  TheBestRoulette
//
//  Created by Irina on 28.04.2024.
//

import UIKit

protocol LogInViewControllerProtocol: UIViewController {
    func setup(with: LogInViewModel)
    func continueMove()
}

final class LogInViewController: UIViewController {
    
    // MARK: - IBOutlet
    
    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passTextField: UITextField!
    @IBOutlet weak var nameTexField: UITextField!
    
    // MARK: - Properties
    
    private var presenter: LogInPresenterProtocol
    private var login: String = ""
    private var pass: String = ""
    private var name: String = ""
    
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
        textFieldSetUp()
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
    
    func textFieldSetUp() {
        loginTextField.textColor = UIColor.white
        let placeholderText = "Enter your email."
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor(named: "lightGrey") ?? .lightGrey,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        loginTextField.attributedPlaceholder = NSAttributedString(string: placeholderText, attributes: attributes)
        
        passTextField.textColor = UIColor.white
        let placeholderTex = "Enter your password."
        passTextField.attributedPlaceholder = NSAttributedString(string: placeholderTex, attributes: attributes)
        
        nameTexField.textColor = UIColor.white
        let placeholderTe = "If you are a new user."
        nameTexField.attributedPlaceholder = NSAttributedString(string: placeholderTe, attributes: attributes)
    }
    
    @objc func hideKeyboard() {
        view.endEditing(true)
    }
    
    func checkCreds() -> Bool {
        pass = passTextField.text ?? ""
        login = loginTextField.text ?? ""
        if pass.count >= 6 && isValidEmail(login) {
            return true
        } else {
            return false
        }
    }
    
    // MARK: - IBActions
    
    
    @IBAction func loginTextFieldAction(_ sender: UITextField) {
        if let text = sender.text {
            if isValidEmail(text) {
                login = text
            }
        }
    }
    
    
    @IBAction func passTextFieldAction(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            pass = text
        }
    }
    @IBAction func loginAction(_ sender: UIButton) {
        if checkCreds() {
            presenter.logIn(email: login, pass: pass)
        } else {
            self.showAlert(title: "Incorrect password or login", message: "Password must have 6 characters or more", okText: "OK")
        }
        
    }
    
    @IBAction func nameAction(_ sender: UITextField) {
        if let text = sender.text, !text.isEmpty {
            name = nameTexField.text ?? ""
            name = text
        }
    }
    
    @IBAction func signUpAction(_ sender: UIButton) {
        
        if checkCreds() {
            if name.count >= 1 {
                presenter.register(email: login, pass: pass, name: name)
            } else {
                self.showAlert(title: "Enter your name", okText: "OK")
            }
            
        } else {
            self.showAlert(title: "Incorrect password or login", message: "Password must have 6 characters or more", okText: "OK")
        }
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
