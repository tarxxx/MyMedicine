//
//  RegistrationViewController.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 27.06.2022.
//

import UIKit

class RegistrationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    
    @objc private func completeRegistration() {
        
        saveUserdata()
        toMainVC()
    }
    
    private func saveUserdata() {
        // func with fetch user data
    }
    
    private func toMainVC() {
        let pvc = MainViewController()
        pvc.setupVC()
        pvc.view.backgroundColor = .white
        pvc.modalPresentationStyle = .fullScreen
        present(pvc, animated: true)
    }
}
