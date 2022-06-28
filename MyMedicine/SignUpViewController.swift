//
//  SignUpViewController.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 22.06.2022.
//

import UIKit
import CoreData

class SignUpViewController: UIViewController, UITextFieldDelegate {
    
    let manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var someUser = User()
    
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
        setupSignUpView()
        textFieldSetup()
        setContinueButton(enabled: false)
        phoneNumberTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
     
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
        
//        fetchNumberAndEmail()
//        setupRegistrationView()
        saveData()
    }
    
    @objc private func textFieldChanged() {
        
        guard
            let phoneNumber = phoneNumberTextField.text,
            let email = emailTextField.text
            else { return }
        
        let formFilled = !(email.isEmpty) && !(phoneNumber.isEmpty)
        
        setContinueButton(enabled: formFilled)
    }
    
    
    
    private func setContinueButton(enabled:Bool) {
        
        if enabled {
            continueButton.alpha = 1.0
            continueButton.isEnabled = true
        } else {
            continueButton.alpha = 0.5
            continueButton.isEnabled = false
        }
    }
    
   
    
    // MARK: Core Data
    
    private func saveData() {
        
        let (error_title,error_text) = validateTextFields()
        
        if  error_title != nil && error_text != nil {
            showError(error_title!,error_text!)
        }
        
        someUser.phone = phoneNumberTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        someUser.email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let userEntity = NSEntityDescription.entity(forEntityName: "Users", in: manageContext)!
        let user = NSManagedObject(entity: userEntity, insertInto: manageContext)
        
        user.setValue(someUser.phone, forKey: "phone")
        user.setValue(someUser.email, forKey: "email")
        
        do {
            try manageContext.save()
            print("Value Saved")
            
            self.showError("Sucessfully Signed Up", "Go to Login and try ..")
            self.toClearAll()
        }
        catch {
            self.showError("Try Again", "Try with another email and password")
        }
    }
    
    
    func validateTextFields ()  -> (String?,String?) {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""
            
        {
            
            return ("Empty Fields","Please Enter in all Fields")
        }
        return (nil,nil)
    }
    
    func showError(_ title:String,_ message : String) {
        
        self.present(CustomAlert.alertMessage(title, message), animated: true, completion: nil)
        
    }
    
    func toClearAll () {
        phoneNumberTextField.text = ""
        emailTextField.text = ""
    }

 
    
// MARK: Setup View
    private func setupSignUpView() {
        
        view.addSubview(beginRegistrationButton)
        view.addSubview(phoneNumberTextField)
        view.addSubview(emailTextField)
        view.addSubview(mainLabel)
    }
    
    private func setupRegistrationView() {
        phoneNumberTextField.isHidden = true
        emailTextField.isHidden = true
//        smsTextField.isHidden = false
//        view.addSubview(smsTextField)
        view.addSubview(continueButton)
    }
    
    
    // MARK: Firebase
    
    private func fetchNumberAndEmail() {
        // func with fetch user number and email and get sms verification code()
    }
    
    private func textFieldSetup() {
        phoneNumberTextField.delegate = self
        phoneNumberTextField.tag = 0
        phoneNumberTextField.returnKeyType = .next
        emailTextField.delegate = self
        emailTextField.tag = 1
        emailTextField.returnKeyType = .done
        registerKeyboardNotification()
        hideKeyboardWhenTappedAround()
    }
}

// MARK: Keyboard

extension SignUpViewController {
    
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let userInfo = notification.userInfo!
        let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        continueButton.center = CGPoint(x: view.center.x,
                                        y: view.frame.height - keyboardFrame.height - 16.0 - continueButton.frame.height / 2)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField, phoneNumberTextField.text != "" {
            nextField.becomeFirstResponder()
        } else if textField == self.emailTextField {
            textField.resignFirstResponder()
            beginRegistration()
        }
        return true
    }
    
    private func registerKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func removeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        self.view.frame.origin.y = -200
        
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        self.view.frame.origin.y = 0
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
