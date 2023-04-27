//
//  CustomInputView.swift
//  ChatApp
//
//  Created by ahmed nagi on 27/04/2023.
//

import UIKit

class CustomInputView: UITextView {
    
    // MARK:- Properties
    let placeHolder = CustomLable(text: " Type a message... ",color: .lightGray)
    
    // MARK:- init
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        
        backgroundColor = #colorLiteral(red: 0.9568627451, green: 0.9568627451, blue: 0.9568627451, alpha: 1)
        layer.cornerRadius = 20
        isScrollEnabled = false
        
        addSubview(placeHolder)
        font = .systemFont(ofSize: 16)
        placeHolder.centerY(inView: self)
        addPadding()
        placeHolder.anchor(left: leftAnchor,right: rightAnchor,paddingLeft: 8)
        NotificationCenter.default.addObserver(self, selector: #selector(handelTextDidChange), name: UITextView.textDidChangeNotification, object: nil)
        
    }
    
  
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK:- Helpers
    @objc func handelTextDidChange(){
        placeHolder.isHidden = !text.isEmpty
    }
    func addPadding(){
        self.textContainerInset = UIEdgeInsets(top: 10, left: 12, bottom: 10, right: 12)
    }
}
