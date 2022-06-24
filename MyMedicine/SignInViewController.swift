//
//  SignInViewController.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 22.06.2022.
//

import UIKit


class SignInViewController: UIViewController, UITabBarControllerDelegate {
    
    var activityIndicator: UIActivityIndicatorView!
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        label.center = CGPoint(x: view.center.x, y: view.center.y - 250)
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.text = "Registration"
        label.textAlignment = .center
        return label
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton()
        button.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        button.center = CGPoint(x: view.center.x, y: view.frame.height - 100)
        button.backgroundColor = .white
        button.setTitle("Подтвердить", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(secondaryColor, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.alpha = 0.5
        button.addTarget(self, action: #selector(handlePresentingVC), for: .touchUpInside)
        return button
    }()
    
    lazy var phoneNumberTextField: UITextField = {
        
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        textField.center = CGPoint(x: view.center.x, y: view.center.y - 150)
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(string: "Enter your phone number")
        textField.textAlignment = .center
        
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    lazy var emailTextField: UITextField = {
        
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        textField.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(string: "Enter your email")
        textField.textAlignment = .center
        
        textField.backgroundColor = .systemGray6
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(continueButton)
        view.addSubview(phoneNumberTextField)
        view.addSubview(emailTextField)
        view.addSubview(mainLabel)
    }
    
    @objc func handlePresentingVC() {
        
        let pvc = MainViewController()
        pvc.setupVC()
        pvc.view.backgroundColor = .white
        pvc.modalPresentationStyle = .fullScreen
        present(pvc, animated: true)
    }
}
