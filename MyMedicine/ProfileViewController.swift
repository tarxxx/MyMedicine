//
//  ProfileViewController.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 22.06.2022.
//

import UIKit



class ProfileViewController: MainViewController {
    
    var bigButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        bigButton.addTarget(self, action: #selector(presentingVC), for: .touchUpInside)
        setConstraints()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    @objc func presentingVC() {
        
        let vc = SignInViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}


extension ProfileViewController {
    
    func setConstraints() {
        view.addSubview(bigButton)
        NSLayoutConstraint.activate([
            bigButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            bigButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            bigButton.heightAnchor.constraint(equalToConstant: 60),
            bigButton.widthAnchor.constraint(equalToConstant: 60)
        ])
    }
}


