//
//  MainViewController.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 22.06.2022.
//

import UIKit

class MainViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMainVC()
    }
}


extension MainViewController {
        
         func setupMainVC() {
             view.backgroundColor = .white
             
             let profileVC = ProfileViewController()
             profileVC.navigationItem.title = "Профиль"
             profileVC.tabBarItem.image = UIImage(named: "User.svg")
             profileVC.tabBarItem.title = "Профиль"
             
             let testsVC = TestsViewController()
             testsVC.navigationItem.title = "Тест"
             testsVC.tabBarItem.image = UIImage(named: "Health.svg")
             testsVC.tabBarItem.title = "Тест"
             
             let historyVC = HistoryViewController()
             historyVC.navigationItem.title = "История"
             historyVC.tabBarItem.image = UIImage(named: "History.svg")
             historyVC.tabBarItem.title = "История"
             
             let doctorVC = DoctorViewController()
             doctorVC.navigationItem.title = "Врач"
             doctorVC.tabBarItem.image = UIImage(named: "Support.svg")
             doctorVC.tabBarItem.title = "Врач"

            viewControllers = [profileVC, testsVC, historyVC, doctorVC]
        }
    }



