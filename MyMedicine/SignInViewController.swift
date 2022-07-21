//
//  SignInViewController.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 22.06.2022.
//

import UIKit
import CoreData

class SignInViewController: UIViewController, UITextFieldDelegate {
    
    private let context = StorageManager.shared.persistentContainer.viewContext
    
    var users = [User]()
    var login: Bool = false
    let userDefaults = UserDefaults()
    
    lazy var emailTextField: UITextField = {
        
        setupTextFields(withPlaceholder: "MyMail@mail.com", andColor: #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.968627451, alpha: 1), alignment: .center, cornerRadius: 10, andFont: UIFont(name: "Mont", size: 14) ?? UIFont.systemFont(ofSize: 14), hidden: false)
    }()
    
    lazy var passwordTextField: UITextField = {
        
        setupTextFields(withPlaceholder: "Password", andColor: #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.968627451, alpha: 1), alignment: .center, cornerRadius: 10, andFont: UIFont(name: "Mont", size: 14) ?? UIFont.systemFont(ofSize: 14), hidden: false)
    }()
    
    
    lazy var loginButton: UIButton = {
        createButton(withTitle: "Вход", andColor: #colorLiteral(red: 0.1411764706, green: 0.4078431373, blue: 0.9647058824, alpha: 1), action: UIAction { _ in
            self.toLogin()
        })
    }()
    
    lazy var toRegister: UIButton = {
        createButton(withTitle: "Регистрация", andColor: #colorLiteral(red: 0.1411764706, green: 0.4078431373, blue: 0.9647058824, alpha: 1), action: UIAction { _ in
            self.toSignUpVC()
        })
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(subviews: emailTextField,
                      passwordTextField,
                      toRegister,
                      loginButton)
        setConstraints()
        textFieldSetup()
        setLoginButton(enabled: false)
        registerKeyboardNotification()
        hideKeyboardWhenTappedAround()
        users = StorageManager.shared.fetchUser()
        if (userDefaults.value(forKey: "login") != nil) == true
        {
            toMainVC()
        }
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
    }
    
    private func toLogin() {
        
        if emailTextField.text!.isEmpty || passwordTextField.text!.isEmpty {
            
            showError("Error", "Fill all fields")
        }
        
        for user in users {
            if emailTextField.text == user.email && passwordTextField.text == user.password
            {
                login = true
                userDefaults.setValue(user.email, forKey: "name")
                userDefaults.setValue(user.password, forKey: "email")
                userDefaults.setValue(true, forKey: "login")
                toMainVC()
            }
        }
        
        if login == false {
            showError("Ошибка", "Есои у Вас нет учетной записи, пожалуйста зарегистрируйтесь")
            toClearAll()
        }
    }
    
    func showError(_ title:String,_ message : String) {
        
        self.present(CustomAlert.alertMessage(title, message), animated: true, completion: nil)
    }
    
    private func toClearAll () {
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    private func toSignUpVC() {
        let svc = SignUpViewController()
        svc.view.backgroundColor = .white
        self.navigationController?.pushViewController(svc, animated: true)
    }
    
    private func toMainVC() {
        let mvc = MainViewController()
        self.navigationController?.pushViewController(mvc, animated: true)
    }
    

    private func setConstraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 336),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            emailTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 42),
            passwordTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            passwordTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            passwordTextField.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            loginButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            loginButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            loginButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        toRegister.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            toRegister.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -30),
            toRegister.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            toRegister.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            toRegister.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}

extension SignInViewController {
    
    private func textFieldSetup() {
        
        let textFields = [emailTextField, passwordTextField ]
        
        for textField in textFields {
            textField.delegate = self
            textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        }
        
        textFields.first?.tag = 0
        textFields.first?.returnKeyType = .next
        
        textFields.last?.tag = 1
        textFields.last?.returnKeyType = .done
        
        registerKeyboardNotification()
        hideKeyboardWhenTappedAround()
    }
    
    @objc private func textFieldChanged() {
        
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
        else { return }
        
        let formFilled = !(email.isEmpty) && !(password.isEmpty)
        
        setLoginButton(enabled: formFilled)
    }
    
    private func setLoginButton(enabled:Bool) {
        
        if enabled {
            loginButton.alpha = 1.0
            loginButton.isEnabled = true
        } else {
            loginButton.alpha = 0.9
            loginButton.isEnabled = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField, emailTextField.text != "" {
            nextField.becomeFirstResponder()
        } else if textField == self.passwordTextField {
            textField.resignFirstResponder()
            
        }
        return true
    }
    
    func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignInViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        self.view.frame.origin.y = -250
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}


