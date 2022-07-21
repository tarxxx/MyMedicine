//
//  MainViewController.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 22.06.2022.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    var userdefaults = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVC()
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(logout))
    }
}

extension MainViewController {
    
    func setupVC() {
        view.backgroundColor = .white
        
        let profileVC = UINavigationController(rootViewController: ProfileViewController())
        profileVC.topViewController?.navigationItem.title = "Профиль"
        profileVC.tabBarItem.image = UIImage(named: "User.svg")
        profileVC.tabBarItem.title = "Профиль"
        
        let testsVC = UINavigationController(rootViewController: TestsViewController())
        testsVC.topViewController?.navigationItem.title = "Тест"
        testsVC.tabBarItem.image = UIImage(named: "Health.svg")
        testsVC.tabBarItem.title = "Тест"
        
        let historyVC = UINavigationController(rootViewController: HistoryViewController())
        historyVC.topViewController?.navigationItem.title = "История"
        historyVC.tabBarItem.image = UIImage(named: "History.svg")
        historyVC.tabBarItem.title = "История"
        
        let doctorVC = UINavigationController(rootViewController: DoctorViewController())
        doctorVC.topViewController?.navigationItem.title = "Врач"
        doctorVC.tabBarItem.image = UIImage(named: "Support.svg")
        doctorVC.tabBarItem.title = "Врач"
        
        viewControllers = [profileVC, testsVC, historyVC, doctorVC]
    }
    
    @objc func logout() {
        
        UserDefaults.resetStandardUserDefaults()
        userdefaults.removeObject(forKey: "login")
        
        let sivc = SignInViewController()
        self.navigationController?.pushViewController(sivc, animated: true)
    }
}
