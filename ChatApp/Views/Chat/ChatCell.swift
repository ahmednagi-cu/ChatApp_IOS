//
//  ChatCell.swift
//  ChatApp
//
//  Created by ahmed nagi on 25/04/2023.
//

import UIKit

class ChatCell: UICollectionViewCell{
    // MARK: - Properties
    static let identifier = "ChatCell"
     let profileImageView = CustomImageView(image: UIImage(named: "avatar"),width: 30, height: 30, cornarRadius: 15,backgroundColor: .black)
     let datLable = CustomLable(text: "Wed 4:08 PM 10/10/2022",font: .boldSystemFont(ofSize: 12),color: .systemGray5)
     let containerView: UIView = {
       let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9098039216, blue: 0.9137254902, alpha: 1)
        return view
    }()

    
     let textView : UITextView = {
        let TF = UITextView()
        TF.backgroundColor = .clear
        TF.isEditable = false
        TF.isScrollEnabled = false
        TF.text = "init(coder:) has not been implemented init(coder:) has not been implemented"
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
        addSubview(containerView)
        addSubview(datLable)
        Add_Constraints()
    }
    func Add_Constraints(){
        /// avatar constarints
        profileImageView.anchor(left: leftAnchor,bottom: bottomAnchor, paddingLeft: 10,paddingBottom: 12)
        profileImageView.setHeight(30)
        /// containerView constarints
        containerView.addSubview(textView)
        containerView.layer.cornerRadius = 12
        containerView.anchor(top: topAnchor,left: profileImageView.rightAnchor,paddingLeft: 12)
        /// textView constarints
        textView.anchor(top: containerView.topAnchor,left: containerView.leftAnchor,bottom: containerView.bottomAnchor,right: containerView.rightAnchor,paddingTop: 4,paddingLeft: 10,paddingBottom: 4,paddingRight: 10)
        textView.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
        /// datLable constarints
        datLable.centerX(inView: self)
        datLable.anchor(top: containerView.bottomAnchor,paddingTop: 10)
        
        
        
    }
    
    func config(text: String){
        textView.text = text
    }
    
}


/// another constraint
//    var containerRightAnchor : NSLayoutConstraint!
//    var containerLeftAnchor : NSLayoutConstraint!
//
//    var dateRightAnchor: NSLayoutConstraint!
//    var dateLeftAnchor: NSLayoutConstraint!
