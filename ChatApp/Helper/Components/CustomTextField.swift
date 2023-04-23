//
//  CustomTextField.swift
//  ChatApp
//
//  Created by ahmed nagi on 19/04/2023.
//

import UIKit

final class CustomTextField: UITextField {
    
    
    init(placeHolder: String,keyboardType: UIKeyboardType = .default, isSecuretext: Bool = false) {
        super.init(frame: .zero)
        borderStyle = .none
        textColor = .black
        keyboardAppearance = .light
        clearButtonMode = .whileEditing
        backgroundColor = UIColor(red: 244/255, green: 244/255, blue: 244/255, alpha: 1)
        setHeight(50)
        self.keyboardType = keyboardType
        isSecureTextEntry = isSecuretext
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 0))
        leftViewMode = .always
        attributedPlaceholder = NSAttributedString(string: placeHolder,attributes: [.foregroundColor : UIColor.black.withAlphaComponent(0.7)])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
