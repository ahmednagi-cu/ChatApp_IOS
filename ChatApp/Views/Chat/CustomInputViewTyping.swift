//
//  CustomInputViewTyping.swift
//  ChatApp
//
//  Created by ahmed nagi on 27/04/2023.
//

import UIKit

class CustomInputViewTyping: UIView {
    
    // MARK:- Properties
     let inputTextView = CustomInputView()
    
    // MARK:- init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        
        addSubview(inputTextView)
        inputTextView.anchor(top: topAnchor,left: leftAnchor,bottom: safeAreaLayoutGuide.bottomAnchor,right: rightAnchor,paddingTop: 12,paddingLeft: 8,paddingBottom: 5,paddingRight: 8)
        
        let dividerView = UIView()
        dividerView.backgroundColor = .lightGray
        addSubview(dividerView)
        dividerView.anchor(top: topAnchor,left: leftAnchor,right: rightAnchor,height: 0.75)
       // dividerView.setHeight(0.75)
    }
    
    
    // MARK:- Helpers
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
}
