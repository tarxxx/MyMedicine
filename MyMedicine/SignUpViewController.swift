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
        button.setTitle("Проодолжить", for: .normal)
        button.titleLabel?.font = UIFont(name: "Mont", size: 20)
        button.setTitleColor(secondaryColor, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = .blue
        button.alpha = 0.5
        button.addTarget(self, action: #selector(closeVC), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSignUpView()
        textFieldSetup()
        setContinueButton(enabled: false)
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(backToSignIn))
    }
    
    @objc private func backToSignIn() {
        dismiss(animated: true)
        let sivc = UINavigationController(rootViewController: SignInViewController())
        sivc.view.backgroundColor = .white
        sivc.modalPresentationStyle = .automatic
        present(sivc, animated: true)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(keyboardWillAppear),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
    }
    
    deinit {
        removeKeyboardNotification()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @objc private func beginRegistration() {
        fetchUserData()
    }
    
    @objc private func textFieldChanged() {
        
        guard
            let login = loginTextField.text,
            let email = emailTextField.text
        else { return }
        
        let formFilled = !(email.isEmpty) && !(login.isEmpty)
        
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
    
    private func fetchUserData() {
        if let name = loginTextField.text, let email = emailTextField.text
        {
            if name.isEmpty || email.isEmpty {
                
                // create the alert
                showError("Error", "Fill all fields")
            }
            else {
                let newUser = User(context: StorageManager.shared.context)
                newUser.name = name
                newUser.email = email
                

                StorageManager.shared.saveContext()
                
                
                    
                self.toClearAll()
                beginRegistrationButton.isHidden = true
                continueButton.isHidden = false
                emailTextField.isHidden = true
                loginTextField.isHidden = true
                let sivc = SignInViewController()
                self.navigationController?.pushViewController(sivc, animated: true)
                }
            
            
            }
//        let (error_title,error_text) = validateTextFields()
//
//        if  error_title != nil && error_text != nil {
//            showError(error_title!,error_text!)
//        }
//
//        newUser.email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        newUser.login = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        let userEntity = NSEntityDescription.entity(forEntityName: "Human", in: manageContext)!
//        let user = NSManagedObject(entity: userEntity, insertInto: manageContext)
//
//        user.setValue(newUser.email, forKey: "humanEmail")
//        user.setValue(newUser.login, forKey: "login")
//
//        do {
//            try manageContext.save()
//            print("Значения сохранены")
//            self.showError("Регистрация завершена", "Теперь вы можете войти, используя свои логин и пароль")
//            self.toClearAll()
//            beginRegistrationButton.isHidden = true
//            continueButton.isHidden = false
//            emailTextField.isHidden = true
//            loginTextField.isHidden = true
//        }
//        catch {
//            self.showError("Пользователь с таким именем уже существует", "Попробуйте другой логин")
//        }
    }
    
    @objc func closeVC() {
        self.dismiss(animated: true, completion: nil)
        let sivc = SignInViewController()
        sivc.modalPresentationStyle = .automatic
        present(sivc, animated: true)
    }
    
    func validateTextFields ()  -> (String?,String?) {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || loginTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            
        {
            
            return ("Одно из полей не заполнено","Пожалуйста заполните все поля")
        }
        return (nil,nil)
    }
    
    func showError(_ title:String,_ message : String) {
        
        self.present(CustomAlert.alertMessage(title, message), animated: true, completion: nil)
        
    }
    
    private func toClearAll () {
        loginTextField.text = ""
        emailTextField.text = ""
    }
    
    
    
    // MARK: Setup View
    
    
    private func setupRegistrationView() {
        loginTextField.isHidden = true
        emailTextField.isHidden = true
        view.addSubview(continueButton)
    }
    
    
    // MARK: Firebase
    
    private func fetchNumberAndEmailToFirebase() {
        // func with fetch user number and email and get sms verification code()
    }
}

// MARK: Keyboard

extension SignUpViewController {
    
    private func textFieldSetup() {
        loginTextField.delegate = self
        loginTextField.tag = 0
        loginTextField.returnKeyType = .next
        loginTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailTextField.delegate = self
        emailTextField.tag = 1
        emailTextField.returnKeyType = .done
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        registerKeyboardNotification()
        hideKeyboardWhenTappedAround()
    }
    
    private func setupSignUpView() {
        view.backgroundColor = .white
        view.addSubview(beginRegistrationButton)
        view.addSubview(continueButton)
        view.addSubview(loginTextField)
        view.addSubview(emailTextField)
        view.addSubview(mainLabel)
    }
}

extension SignUpViewController {
    
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let userInfo = notification.userInfo!
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        continueButton.center = CGPoint(x: view.center.x,
                                        y: view.frame.height - keyboardFrame.height - 16.0 - continueButton.frame.height / 2)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField, loginTextField.text != "" {
            nextField.becomeFirstResponder()
        } else if textField == self.emailTextField {
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
        self.view.frame.origin.y = -200
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
