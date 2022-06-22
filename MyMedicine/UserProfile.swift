//
//  UserProfile.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 22.06.2022.
//

import Foundation

struct UserProfile {
    
    let name: String?
    let email: String?
    
    init(data: [String: Any]) {
        let name = data["name"] as? String
        let email = data["email"] as? String
        
        self.name = name
        self.email = email
    }
}
