//
//  SignInViewController.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 22.06.2022.
//

import UIKit
import CoreData


class SignInViewController: UIViewController, UITextFieldDelegate {
    
    let manageContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
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
    
    lazy var phoneTextField: UITextField = {
        
        let textField = UITextField()
        textField.frame = CGRect(x: 0, y: 0, width: 355, height: 60)
        textField.center = CGPoint(x: view.center.x, y: view.center.y - 50)
        textField.layer.cornerRadius = 10
        textField.attributedPlaceholder = NSAttributedString(string: "+7(XXX)XXXXXXX")
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
        button.addTarget(self, action: #selector(login), for: .touchUpInside)
        button.setTitle("Вход", for: .normal)
        return button
    }()
    
    
    var currentUser = User()
    
    override func viewDidLoad() {
        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(phoneTextField)
        view.addSubview(toRegister)
        view.addSubview(loginButton)
    }
    
    @objc func login() {
        let (error_title,error_text) = validateTextFields()
        
        if  error_title != nil && error_text != nil {
            showError(error_title!,error_text!)
        }
        
        currentUser.email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        currentUser.phone = phoneTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let fetchData = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        fetchData.predicate = NSPredicate(format:"email = %@",currentUser.email)
        fetchData.predicate = NSPredicate(format:"phone = %@",currentUser.phone)
        
        do
        {
            let results = try manageContext.fetch(fetchData)
            
            if results.isEmpty
            {
                self.showError("Invalid Credentials", "If you don't have a account try to SignUp...")
            }
            
            for data in results as! [NSManagedObject]
            {
                currentUser.email = data.value(forKey: "email") as! String
                currentUser.phone =  data.value(forKey: "phone") as! String
                
            }
            self.toMainVC()
            self.toClearAll()
            
        }
        
        catch
        {
            self.showError("User Not Found", "Try to Sign Up")
        }
      
    }
    
    
    func validateTextFields ()  -> (String?,String?) {
        
        if emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            
            return ("Empty Fields","Please Enter in all Fields")
        }
        return (nil,nil)
    }
    
    
    func showError(_ title:String,_ message : String) {
        
        self.present(CustomAlert.alertMessage(title, message), animated: true, completion: nil)
        
    }
    
    func toClearAll () {
        phoneTextField.text = ""
        emailTextField.text = ""
    }
    
    @objc func toSignUpVC() {
        let svc = SignUpViewController()
        svc.view.backgroundColor = .white
        svc.modalPresentationStyle = .fullScreen
        present(svc, animated: true)
    }
    
    func toMainVC() {
        let mvc = MainViewController()
        mvc.setupVC()
        mvc.modalPresentationStyle = .fullScreen
        present(mvc, animated: true)
    }
    
}
