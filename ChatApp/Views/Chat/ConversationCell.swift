//
//  ConversationCell.swift
//  ChatApp
//
//  Created by ahmed nagi on 25/04/2023.
//

import UIKit
import SDWebImage
class ConversationCell: UITableViewCell {
 // MARK: - Properties
    static let identifier = "ConversationCell"
    var viewModel : MessageViewModel? {
        didSet {
            configureCell()
        }
    }
    private let profileImageView = CustomImageView(image: UIImage(named: "avatar"),cornarRadius: 30)
    private let fullname = CustomLable(text: "FullName")
    private let recentMessage = CustomLable(text: "recent message",color: .lightGray)
    private let dataLable = CustomLable(text: "10/10/2023",color: .lightGray)
    
    private let unReadMsgLable: UILabel = {
       let lable = UILabel()
        lable.text = "2"
        lable.font = .boldSystemFont(ofSize: 18)
        lable.textColor = .white
        lable.backgroundColor = .green
        lable.setDimensions(height: 30, width: 30)
        lable.layer.cornerRadius = 15
        lable.textAlignment = .center
        lable.translatesAutoresizingMaskIntoConstraints = false
        lable.clipsToBounds = true
        return lable
    }()
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
        addSubviews(profileImageView)
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
    
        let stackView = UIStackView(arrangedSubviews: [fullname,recentMessage])
        stackView.axis = .vertical
        stackView.spacing = 7
        stackView.alignment = .leading
        addSubview(stackView)
        stackView.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 10)
        
        let stackDate = UIStackView(arrangedSubviews: [dataLable,unReadMsgLable])
        stackDate.axis = .vertical
        stackDate.spacing = 7
        stackDate.alignment = .trailing
        
        addSubview(stackDate)
        stackDate.centerY(inView: profileImageView, rightAnchor: rightAnchor,paddingRight: 8)
    
    }
    
    private func configureCell(){
        guard let viewModel = viewModel else { return }
        self.profileImageView.sd_setImage(with: viewModel.profileImage)
        self.fullname.text = viewModel.message.fullname
        self.recentMessage.text = viewModel.messageText
        self.dataLable.text = viewModel.timestapeString
        self.unReadMsgLable.text = "\(viewModel.unReadCount)"
        self.unReadMsgLable.isHidden = viewModel.shouldHidenunReadLable
    }
}
