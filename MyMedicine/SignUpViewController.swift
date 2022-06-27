//
//  SignUpViewController.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 22.06.2022.
//

import UIKit

class SignUpViewController: UIViewController {
    
    var activityIndicator: UIActivityIndicatorView!
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 30, y: 30, width: 200, height: 50)
        label.font = UIFont(name: "Mont" , size: 40)
        label.textColor = .black
        label.text = "Регистрация"
        return label
    }()
    
    lazy var phoneNumberTextField: UITextField = {
        
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: 355, height: 60)
        textField.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(string: "+7(XXX)XXXXXXX")
        textField.textAlignment = .center
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: 355, height: 60)
        textField.center = CGPoint(x: view.center.x, y: view.center.y + 50)
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(string: "mymail@gmail.com")
        textField.textAlignment = .center
        
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    lazy var smsTextField: UITextField = {
        
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: 355, height: 60)
        textField.center = CGPoint(x: view.center.x, y: view.center.y)
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(string: "----")
        textField.textAlignment = .center
        
        textField.backgroundColor = .systemGray6
        textField.isHidden = true
        return textField
    }()
    
    lazy var beginRegistrationButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 20, width: 355, height: 60)
        button.center = CGPoint(x: view.center.x, y: view.frame.height - 100)
        button.backgroundColor = .white
        button.setTitle("Подтвердить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Mont", size: 20)
        button.setTitleColor(secondaryColor, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.alpha = 0.5
        button.addTarget(self, action: #selector(beginRegistration), for: .touchUpInside)
        return button
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 20, y: 20, width: 355, height: 60)
        button.center = CGPoint(x: view.center.x, y: view.frame.height - 100)
        button.backgroundColor = .white
        button.setTitle("Подтвердить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Mont", size: 20)
        button.setTitleColor(secondaryColor, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.alpha = 0.5
        button.addTarget(self, action: #selector(beginRegistration), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupView()
    }
    
    @objc private func beginRegistration() {
        
        fetchNumberAndEmail()
        phoneNumberTextField.isHidden = true
        emailTextField.isHidden = true
        smsTextField.isHidden = false
        view.addSubview(smsTextField)
        view.addSubview(continueButton)
    }
    
    @objc private func completeRegistration() {
        
        saveUserdata()
        let pvc = MainViewController()
        pvc.setupVC()
        pvc.view.backgroundColor = .white
        pvc.modalPresentationStyle = .fullScreen
        present(pvc, animated: true)
    }
}

extension SignUpViewController {
    
    private func setupView() {
        view.addSubview(beginRegistrationButton)
        view.addSubview(phoneNumberTextField)
        view.addSubview(emailTextField)
        view.addSubview(mainLabel)
    }
    
    private func saveUserdata() {
        // func with fetch user data
    }
    
    private func fetchNumberAndEmail() {
        // func with fetch user number and email and get sms verification code()
    }
}
