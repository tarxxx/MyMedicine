//
//  SignUpViewController.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 22.06.2022.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    let manageContext = StorageManager.shared.persistentContainer.viewContext
    
    lazy var mainLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 30, y: 30, width: 200, height: 50)
        label.font = UIFont(name: "Mont" , size: 40)
        label.textColor = .black
        label.text = "Регистрация"
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        
        setupTextFields(withPlaceholder: "Иван", andColor: #colorLiteral(red: 0.1411764706, green: 0.4078431373, blue: 0.9647058824, alpha: 1), alignment: .center, cornerRadius: 10, andFont: UIFont(name: "Mont", size: 14) ?? UIFont.systemFont(ofSize: 14), hidden: true)
    }()
    
    lazy var emailTextField: UITextField = {
        
        setupTextFields(withPlaceholder: "MyMail@mail.com", andColor: #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.968627451, alpha: 1), alignment: .center, cornerRadius: 10, andFont: UIFont(name: "Mont", size: 14) ?? UIFont.systemFont(ofSize: 14), hidden: true)
        
    }()
    
    lazy var passwordTextField: UITextField = {
        
        setupTextFields(withPlaceholder: "Пароль", andColor: #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.968627451, alpha: 1), alignment: .center, cornerRadius: 10, andFont: UIFont(name: "Mont", size: 14) ?? UIFont.systemFont(ofSize: 14), hidden: false)
    }()
    
    
    lazy var surnameTextField: UITextField = {
        
        setupTextFields(withPlaceholder: "Иванов", andColor: #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.968627451, alpha: 1), alignment: .center, cornerRadius: 10, andFont: UIFont(name: "Mont", size: 14) ?? UIFont.systemFont(ofSize: 14), hidden: false)
    }()
    
    lazy var ageTextField: UITextField = {
        
        setupTextFields(withPlaceholder: "30", andColor: #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.968627451, alpha: 1), alignment: .center, cornerRadius: 10, andFont: UIFont(name: "Mont", size: 14) ?? UIFont.systemFont(ofSize: 14), hidden: true)
    }()
    
    lazy var maleTextField: UITextField = {
        
        setupTextFields(withPlaceholder: "М", andColor: #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.968627451, alpha: 1), alignment: .center, cornerRadius: 10, andFont: UIFont(name: "Mont", size: 14) ?? UIFont.systemFont(ofSize: 14), hidden: true)
    }()
    
    lazy var heightTextField: UITextField = {
        
        setupTextFields(withPlaceholder: "180", andColor: #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.968627451, alpha: 1), alignment: .center, cornerRadius: 10, andFont: UIFont(name: "Mont", size: 14) ?? UIFont.systemFont(ofSize: 14), hidden: true)
    }()
    
    lazy var weightTextField: UITextField = {
        
        setupTextFields(withPlaceholder: "80", andColor: #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.968627451, alpha: 1), alignment: .center, cornerRadius: 10, andFont: UIFont(name: "Mont", size: 14) ?? UIFont.systemFont(ofSize: 14), hidden: true)
    }()
    
    lazy var birthdayDateTextField: UITextField = {
        
        setupTextFields(withPlaceholder: "30", andColor: #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.968627451, alpha: 1), alignment: .center, cornerRadius: 10, andFont: UIFont(name: "Mont", size: 14) ?? UIFont.systemFont(ofSize: 14), hidden: true)
    }()
    
    lazy var beginRegistrationButton: UIButton = {
        
        createButton(withTitle: "Далее", andColor: #colorLiteral(red: 0.1411764706, green: 0.4078431373, blue: 0.9647058824, alpha: 1), action: UIAction { _ in
            self.visuals()
        })
    }()
    
    lazy var continueButton: UIButton = {
        createButton(withTitle: "На страницу входа", andColor: #colorLiteral(red: 0.1411764706, green: 0.4078431373, blue: 0.9647058824, alpha: 1), action: UIAction { _ in
            self.backToSignIn()
        })
    }()
    
    lazy var finishRegistrationButton: UIButton = {
        createButton(withTitle: "Finish", andColor: #colorLiteral(red: 0.1411764706, green: 0.4078431373, blue: 0.9647058824, alpha: 1), action: UIAction { _ in
            self.completeRegistration()
        })
    }()
    
    //    func setupAllTextFields() {
    //        let textFields = [emailTextField, nameTextField, loginTextField]
    //        for textField in textFields {
    //            textField.textAlignment = .center
    //            textField.backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9607843137, blue: 0.968627451, alpha: 1)
    //            textField.font = UIFont(name: "Mont", size: 14) ?? UIFont.systemFont(ofSize: 14)
    //            textField.layer.cornerRadius = 10
    //        }
    //    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupSubviews(subviews: mainLabel,
                      emailTextField,
                      passwordTextField,
                      beginRegistrationButton,
                      finishRegistrationButton,
                      continueButton,
                      nameTextField,
                      surnameTextField,
                      maleTextField,
                      heightTextField,
                      weightTextField,
                      ageTextField)
        setConstraints()
        textFieldSetup()
        setContinueButton(enabled: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(backToSignIn))
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    func visuals() {
        finishRegistrationButton.isHidden = true
        emailTextField.isHidden = true
        passwordTextField.isHidden = true
        nameTextField.isHidden = false
    }
    
    @objc private func backToSignIn() {
        dismiss(animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @objc private func textFieldChanged() {
        
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text
        else { return }
        
        let formFilled = !(email.isEmpty) && !(password.isEmpty)
        
        setContinueButton(enabled: formFilled)
    }
    
    private func setContinueButton(enabled:Bool) {
        
        if enabled {
            continueButton.alpha = 1.0
            continueButton.isEnabled = true
        } else {
            continueButton.alpha = 0.3
            continueButton.isEnabled = false
        }
    }
    
    // MARK: Core Data
    
    private func fetchEmailAndPassword() {
        if let password = passwordTextField.text, let email = emailTextField.text
        {
            if password.isEmpty || email.isEmpty {
                
                showError("Error", "Bla-bla")
            }
            else {
                let newUser = User(context: StorageManager.shared.context)
                newUser.password = password
                newUser.email = email
                
                StorageManager.shared.saveContext()
                
                showError("Успех", "Охладите трахание")
            }
        }
    }
    
    private func fetchUserData() {
        if let name = nameTextField.text,
           let surname = surnameTextField.text,
           let male = maleTextField.text,
           let height = heightTextField.text,
           let weight = weightTextField.text
        {
            
            if name.isEmpty || surname.isEmpty || male.isEmpty || height.isEmpty || weight.isEmpty {
                
                showError("Error", "Bla")
            }
            else {
                let newUser = User(context: StorageManager.shared.context)
                newUser.name = name
                newUser.surname = surname
                newUser.male = male
                newUser.weight = weight
                newUser.height = height
                
                StorageManager.shared.saveContext()
                
                showError("Registration complete", "Now you can login with your login and password")
                
            }
        }
    }
    
    // MARK: Registration
    
    private func beginRegistration() {
//        fetchEmailAndPassword()
        continueRegistration()
    }
    
    private func continueRegistration() {
//        fetchUserData()
        self.toClearAll()
        beginRegistrationButton.isHidden = true
        finishRegistrationButton.isHidden = true
        emailTextField.isHidden = true
        passwordTextField.isHidden = true
        nameTextField.isHidden = false
//        let userdataTextFields = [nameTextField, surnameTextField, heightTextField, weightTextField, ageTextField, maleTextField]
//        for userdataTextField in userdataTextFields {
//            userdataTextField.isHidden = false
//        }
    }
    
    private func completeRegistration() {
        
        let userdataTextFields = [nameTextField, surnameTextField, heightTextField, weightTextField, ageTextField, maleTextField]
        for userdataTextField in userdataTextFields {
            userdataTextField.isHidden = true
        }
        fetchUserData()
        toSignInVC()
    }
    
    private func toSignInVC() {
        let sivc = SignUpViewController()
        sivc.view.backgroundColor = .white
        self.navigationController?.pushViewController(sivc, animated: true)
    }
    
    //    func validateTextFields ()  -> (String?,String?) {
    //
    //        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || loginTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
    //
    //        {
    //
    //            return ("Одно из полей не заполнено","Пожалуйста заполните все поля")
    //        }
    //        return (nil,nil)
    //    }
    
    private func showError(_ title:String,_ message : String) {
        
        self.present(CustomAlert.alertMessage(title, message), animated: true)
        
    }
    
    private func toClearAll () {
        passwordTextField.text = ""
        emailTextField.text = ""
    }
    
    // MARK: Setup View
    
    func setupSubviews(subviews: UIView...) {
        subviews.forEach { subview in
            view.addSubview(subview)
        }
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
        
        beginRegistrationButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            beginRegistrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            beginRegistrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            beginRegistrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            beginRegistrationButton.heightAnchor.constraint(equalToConstant: 60)
        ])

        nameTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            nameTextField.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            nameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            nameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            nameTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
//
        surnameTextField.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            surnameTextField.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 90),
            surnameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            surnameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            surnameTextField.heightAnchor.constraint(equalToConstant: 60)
        ])
//
//        finishRegistrationButton.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            finishRegistrationButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
//            finishRegistrationButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            finishRegistrationButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
//            finishRegistrationButton.heightAnchor.constraint(equalToConstant: 60)
//        ])
        
    }
    
    // MARK: Firebase
    
    private func fetchNumberAndEmailToFirebase() {
        // func with fetch user number and email and get sms verification code()
    }
}

// MARK: Keyboard

extension SignUpViewController {
    
    private func textFieldSetup() {
        
        let textFields = [passwordTextField, emailTextField]
        
        for textField in textFields {
            textField.delegate = self
            textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        }
        
        textFields.first?.tag = 1
        textFields.first?.returnKeyType = .done
        
        textFields.last?.tag = 0
        textFields.last?.returnKeyType = .next
        
        registerKeyboardNotification()
        hideKeyboardWhenTappedAround()
    }
}

extension SignUpViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField, emailTextField.text != "" {
            nextField.becomeFirstResponder()
        } else if textField == self.passwordTextField {
            textField.resignFirstResponder()
            beginRegistration()
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
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func keyboardWillShow(notification: Notification) {
        //        self.view.frame.origin.y = -200
        self.beginRegistrationButton.frame.origin.y = 50
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
