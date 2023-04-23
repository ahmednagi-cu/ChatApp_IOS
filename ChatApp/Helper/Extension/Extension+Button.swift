//
//  Extension+Button.swift
//  ChatApp
//
//  Created by ahmed nagi on 19/04/2023.
//

import UIKit


extension UIButton {
    func attributes(firstString: String, lastString: String){
        let atts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.gray.cgColor,.font: UIFont.systemFont(ofSize: 16)]
        let atttitle = NSMutableAttributedString(string: firstString,attributes: atts)
        let secondAtts: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black.cgColor,.font: UIFont.boldSystemFont(ofSize: 16)]
        atttitle.append(NSAttributedString(string: lastString, attributes: secondAtts))
        setAttributedTitle(atttitle, for: .normal)
    }
    func blackButton(buttonText: String){
        setTitle(buttonText, for: .normal)
        tintColor = .white
        backgroundColor = .black
        setHeight(50)
        layer.cornerRadius = 12
        titleLabel?.font = .boldSystemFont(ofSize: 19)
        isEnabled = false
    }
}





//
//class RegisterController: UIViewController {
//// MARK: - Properties
//// MARK: - LifeCycle
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//    }
//
//
//    // MARK: - Helpers
//    // MARK: - Actions
//
//
//}
