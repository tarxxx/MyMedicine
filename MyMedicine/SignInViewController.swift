//
//  SignInViewController.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 22.06.2022.
//

import UIKit


class SignInViewController: UIViewController, UITabBarControllerDelegate {
    
    var button: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "trash"), for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        button.addTarget(self, action: #selector(handlePresentingVC), for: .touchUpInside)
    }
    
    
    @objc func handlePresentingVC() {
        
        let pvc = ProfileViewController()
        pvc.setupVC()
        pvc.bigButton.isHidden = true
        pvc.view.backgroundColor = .white
        present(pvc, animated: true)
    }
}

extension SignInViewController {
    
    func setConstraints() {
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            button.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            button.heightAnchor.constraint(equalToConstant: 40),
            button.widthAnchor.constraint(equalToConstant: 40)
        ])
    }
}
