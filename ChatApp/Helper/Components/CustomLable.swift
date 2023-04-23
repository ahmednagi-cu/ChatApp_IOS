//
//  CustomLable.swift
//  ChatApp
//
//  Created by ahmed nagi on 19/04/2023.
//


import UIKit

final class CustomLable: UILabel {
    
    init(text: String,font: UIFont = .systemFont(ofSize: 17),color: UIColor = .black, textAlignment: NSTextAlignment = .center) {
        super.init(frame: .zero)
        self.text = text
        self.font = font
        self.textColor = color
        self.textAlignment = textAlignment
        numberOfLines = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
