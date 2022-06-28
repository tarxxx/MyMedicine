//
//  CustomAlert.swift
//  MyMedicine
//
//  Created by Kirill Tarasko on 28.06.2022.
//


import UIKit

class CustomAlert {
    static  func alertMessage (_ title : String?, _ message : String?) -> UIAlertController {
        
        let alert = UIAlertController(title:  title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:"Ok", style:.default, handler: nil))
        return alert
    }
}
