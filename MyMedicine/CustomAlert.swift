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



func createButton(withTitle title: String, andColor color: UIColor, action: UIAction) -> UIButton {
    var buttonConfiguration = UIButton.Configuration.filled()
    buttonConfiguration.baseBackgroundColor = color
    
    var attributes = AttributeContainer()
    attributes.font = UIFont.systemFont(ofSize: 14)
    buttonConfiguration.attributedTitle = AttributedString(title, attributes: attributes)
    return UIButton(configuration: buttonConfiguration, primaryAction: action)
}

func setupTextFields(withPlaceholder title: String) -> UITextField {
    let textField = UITextField()
    textField.placeholder = title
    
    return textField
}

func setupTextFields(withPlaceholder title: String, andColor color: UIColor, alignment textPosition: NSTextAlignment, cornerRadius radius: CGFloat, andFont font: UIFont, hidden isHidden: Bool) -> UITextField {
    let textField = UITextField()
    textField.placeholder = title
    textField.font = UIFont(name: "Mont", size: 14)
    textField.backgroundColor = color
    textField.textAlignment = textPosition
    textField.layer.cornerRadius = radius
    textField.font = font
    textField.isHidden = isHidden

    return textField
}


