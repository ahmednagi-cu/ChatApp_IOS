//
//  UserCell.swift
//  ChatApp
//
//  Created by ahmed nagi on 25/04/2023.
//

import UIKit
import SDWebImage
class UserCell: UITableViewCell {

    // MARK: - Properties
    var viewModel: NewConversationViewModel? {
        didSet {
            configure()
        }
    }
    
    // MARK: - UI
       static let identifier = "UserCell"
       private let profileImageView = CustomImageView(image: UIImage(named: "avatar"))
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
        imageUI()
        Add_Constraints()
    }
    /// image
    func imageUI(){
        profileImageView.setDimensions(height: 60, width: 60)
        profileImageView.layer.cornerRadius = 30
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.systemGreen.cgColor
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
    
    private func configure(){
        guard let viewModel = viewModel else { return}
        self.userName.text = viewModel.username
        self.fullName.text = viewModel.fullname
        self.profileImageView.sd_setImage(with: viewModel.avatar)
    }

}
