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
        self.delegate = self
        setupUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupVC()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
}
    extension MainViewController {
        
        private func setupUI() {
            view.backgroundColor = .white
        }
        
        private func setupVC() {
            let profileTab = UINavigationController(rootViewController: ProfileViewController())
            let profileTabBarItem = UITabBarItem(title: "Профиль", image: UIImage(named: "User.png"), tag: 0)
            profileTab.tabBarItem = profileTabBarItem
            
            let testsTab = UINavigationController(rootViewController: TestsViewController())
            let testsTabBarItem = UITabBarItem(title: "Тест", image: UIImage(named: "Health.png"), tag: 1)
            testsTab.tabBarItem = testsTabBarItem
            
            let historyTab = UINavigationController(rootViewController: HistoryViewController())
            let historyTabBarItem = UITabBarItem(title: "История", image: UIImage(named: "Time.png"), tag: 2)
            historyTab.tabBarItem = historyTabBarItem
            
            let doctorTab = UINavigationController(rootViewController: DoctorViewController())
            let doctorTabBarItem = UITabBarItem(title: "Врач", image: UIImage(named: "Support"), tag: 3)
            doctorTab.tabBarItem = doctorTabBarItem
            
            self.viewControllers = [profileTab, testsTab, historyTab, doctorTab]
        }
    }


