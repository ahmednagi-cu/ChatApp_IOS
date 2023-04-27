//
//  UserCell.swift
//  ChatApp
//
//  Created by ahmed nagi on 25/04/2023.
//

import UIKit

class UserCell: UITableViewCell {

    // MARK: - Properties
       static let identifier = "UserCell"
       private let profileImageView = CustomImageView(image: UIImage(named: "avatar"),width: 64,height: 64,cornarRadius: 32)
       private let userName = CustomLable(text: "userName",font: .boldSystemFont(ofSize: 17))
       private let fullName = CustomLable(text: "fullName",color: .lightGray)
     
    // MARK: - LifeCycle
       
       override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
           Config_UI()
       }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
       
    // MARK: - Helpers
    private func Config_UI(){
        backgroundColor = .clear
        selectionStyle = .none
        addSubview(profileImageView)
        Add_Constraints()
    }
    private func Add_Constraints(){
        profileImageView.centerY(inView: self,leftAnchor: leftAnchor,paddingLeft: 10)
        let stackView = UIStackView(arrangedSubviews: [userName,fullName])
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .leading
        addSubview(stackView)
        stackView.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 10)
       
    }

}
