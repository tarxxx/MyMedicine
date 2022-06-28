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

struct User {
    
    
    var phone = ""
    var email = ""
    var password = ""
    
//    init(phone: String, email: String) {
//        self.phone = phone
//        self.email = email
//    }
    
//    static func getUser() -> User {
//        User(phone: "", email: "")
//    }
    
}
