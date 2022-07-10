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
    
//    private var currentUser = User()
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
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc private func backToSignIn() {
        
    }
    
    
//    @objc func push() {
//        toLogin()
//    }
    
    @objc func toLogin() {
        
        if emailTextField.text!.isEmpty || loginTextField.text!.isEmpty{
            
            // create the alert
            showError("Error", "Fill all fields")
        }
        
        // here we are looping through each and every user present inside database
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
            
            // create the alert
            showError("Ошибка", "Есои у Вас нет учетной записи, пожалуйста зарегистрируйтесь")
            toClearAll()
        }
    
//        let (error_title,error_text) = validateTextFields()
//
//        if  error_title != nil && error_text != nil {
//            showError(error_title!,error_text!)
//        }
//
//        currentUser.email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//        currentUser.login = loginTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Human")
//        fetchData.predicate = NSPredicate(format:"humanEmail = %@",currentUser.email)
//        fetchData.predicate = NSPredicate(format:"login = %@",currentUser.login)
//
//        do
//        {
//            let results = try context.fetch(fetchData)
//
//            if results.isEmpty
//            {
//                self.showError("Ошибка", "Есои у Вас нет учетной записи, пожалуйста зарегистрируйтесь")
//            }
//
//            for data in results as! [NSManagedObject]
//            {
//                currentUser.email = data.value(forKey: "humanEmail") as! String
//                currentUser.login =  data.value(forKey: "login") as! String
//
//            }
//
//            self.toMainVC()
//         self.toClearAll()
            
        }
        
//        catch
//        {
//            self.showError("Пользователь не найден", "Пройдите регистрацию")
//        }
      
    
    
    func validateTextFields ()  -> (String?,String?) {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || loginTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return ("Empty Fields","Please Enter in all Fields")
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

