//
//  ConversationCell.swift
//  ChatApp
//
//  Created by ahmed nagi on 25/04/2023.
//

import UIKit

class ConversationCell: UITableViewCell {
 // MARK: - Properties
    static let identifier = "ConversationCell"
    private let profileImageView = CustomImageView(image: UIImage(named: "avatar"),width: 60,height: 60,cornarRadius: 30)
    private let fullname = CustomLable(text: "FullName")
    private let recentMessage = CustomLable(text: "recent message",color: .lightGray)
    private let dataLable = CustomLable(text: "10/10/2023",color: .lightGray)
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
        addSubviews(profileImageView,dataLable)
        Add_Constraints()
    }
    private func Add_Constraints(){
        profileImageView.centerY(inView: self,leftAnchor: leftAnchor,paddingLeft: 10)
    
        let stackView = UIStackView(arrangedSubviews: [fullname,recentMessage])
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .leading
        addSubview(stackView)
        stackView.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 10)
        dataLable.centerY(inView: self, rightAnchor: rightAnchor,paddingRight: 10)
    }
}
