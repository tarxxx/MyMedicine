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
        
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: 355, height: 60)
        textField.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(string: "mymail@gmail.com")
        textField.textAlignment = .center
        
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    lazy var loginTextField: UITextField = {
        
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: 355, height: 60)
        textField.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(string: "Login")
        textField.textAlignment = .center
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    lazy var toRegister: UIButton = {
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 355, height: 60)
        button.center = CGPoint(x: view.center.x, y: view.center.y + 150)
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.alpha = 0.5
        button.addTarget(self, action: #selector(toSignUpVC), for: .touchUpInside)
        button.setTitle("Регистрация", for: .normal)
        return button
    }()
    
    lazy var loginButton: UIButton = {
        
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 355, height: 60)
        button.center = CGPoint(x: view.center.x, y: view.center.y + 250)
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.alpha = 1
        button.addTarget(self, action: #selector(toLogin), for: .touchUpInside)
        button.setTitle("Вход", for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        setupSignInView()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(backToSignIn))
        users = StorageManager.shared.fetchUser()
        if (userDefaults.value(forKey: "login") != nil) == true
        {
            toMainVC()
        }
        
    }
    
    @objc private func backToSignIn() {
        
    }
    
    @objc func toLogin() {
        
        if emailTextField.text!.isEmpty || loginTextField.text!.isEmpty{
            
            showError("Error", "Fill all fields")
        }
        
        for user in users {
            if emailTextField.text == user.email && loginTextField.text == user.name
            {
                login = true
                
                userDefaults.setValue(user.name, forKey: "name")
                userDefaults.setValue(user.email, forKey: "email")
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
        loginTextField.text = ""
        emailTextField.text = ""
    }
    
    @objc func toSignUpVC() {
        let svc = UINavigationController(rootViewController: SignUpViewController())
        svc.view.backgroundColor = .white
        svc.modalPresentationStyle = .automatic
        present(svc, animated: true)
    }
    
    private func toMainVC() {
        //      dismiss(animated: true)
        let mvc = UINavigationController(rootViewController: MainViewController())
        mvc.modalPresentationStyle = .fullScreen
        present(mvc, animated: true)
    }
    
    private func setupSignInView() {
        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(loginTextField)
        view.addSubview(toRegister)
        view.addSubview(loginButton)
    }
}

