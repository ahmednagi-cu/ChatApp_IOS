//
//  ChatCell.swift
//  ChatApp
//
//  Created by ahmed nagi on 25/04/2023.
//

import UIKit

class ChatCell: UICollectionViewCell{
    // MARK: - Properties
    var viewModel: MessageViewModel? {
        didSet {
            configure()
        }
    }
    static let identifier = "ChatCell"
     var profileImageView = CustomImageView(image: UIImage(named: "avatar"),width: 30, height: 30, cornarRadius: 15,backgroundColor: .black)
     var datLable = CustomLable(text: "Wed 4:08 PM 10/10/2022",font: .boldSystemFont(ofSize: 12),color: .systemGray4)
     var bubbleContainer: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9098039216, blue: 0.9137254902, alpha: 1)
        return view
    }()

    var bubbleRightAnchor: NSLayoutConstraint!
    var bubbleLeftAnchor: NSLayoutConstraint!
    
    var dateRightAnchor: NSLayoutConstraint!
    var dateLeftAnchor: NSLayoutConstraint!
    
     var textView : UITextView = {
        let TF = UITextView()
        TF.backgroundColor = .clear
        TF.isEditable = false
        TF.isScrollEnabled = false
        TF.text = ""
        TF.font = .systemFont(ofSize: 16)
        return TF
    }()
    // MARK: - LifeCycle
    override init(frame: CGRect) {
        super.init(frame: frame)
           Config_UI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Helpers
    func Config_UI(){
        addSubview(profileImageView)
        addSubview(bubbleContainer)
        addSubview(datLable)
        Add_Constraints()
    }
    func Add_Constraints(){
        /// avatar constarints
        profileImageView.anchor(left: leftAnchor,bottom: bottomAnchor, paddingLeft: 10)
        profileImageView.setHeight(30)
        /// bubbleContainer View constarints
   
        bubbleContainer.layer.cornerRadius = 12
        bubbleContainer.anchor(top: topAnchor,bottom: bottomAnchor)
        bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        bubbleContainer.addSubview(textView)
        textView.anchor(top: bubbleContainer.topAnchor,left: bubbleContainer.leftAnchor,bottom: bubbleContainer.bottomAnchor,right: bubbleContainer.rightAnchor,paddingTop: 4,paddingLeft: 12,paddingBottom: 4,paddingRight: 12)
        /// bubbleLeftAnchor
        bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor,constant: 12)
        bubbleLeftAnchor.isActive = false
        /// bubbleRightAnchor
        bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor,constant: -12)
        bubbleRightAnchor.isActive = false
        
        /// datLable constarints
        /// dateLeftAnchor
        dateLeftAnchor = datLable.leftAnchor.constraint(equalTo: bubbleContainer.rightAnchor,constant: 12)
        dateLeftAnchor.isActive = false
        
        /// dateRightAnchor
        dateRightAnchor = datLable.rightAnchor.constraint(equalTo: bubbleContainer.leftAnchor,constant: -12)
        dateRightAnchor.isActive = false
        
        datLable.anchor(bottom: bottomAnchor)
        
       
     
        
        
        
    }
    
    private func configure(){
        guard let viewModel = viewModel else { return }
        bubbleContainer.backgroundColor = viewModel.messageBackgrpundColor
        textView.text = viewModel.messageText
        textView.textColor = viewModel.messageColor
        profileImageView.sd_setImage(with: viewModel.profileImage)
        profileImageView.isHidden = viewModel.shoudHideProfileImage
        bubbleRightAnchor.isActive = viewModel.rightAnchorActive
        dateRightAnchor.isActive = viewModel.rightAnchorActive
        
        bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
        dateLeftAnchor.isActive = viewModel.leftAnchorActive
        guard let timestamp = viewModel.timestapeString else { return }

        datLable.text = timestamp
    }
//     func configure(){
//        bubbleLeftAnchor.isActive = true
//        dateLeftAnchor.isActive = true
//    }
    
}


