//
//  CustomInputViewTyping.swift
//  ChatApp
//
//  Created by ahmed nagi on 27/04/2023.
//

import UIKit
protocol CustomInputViewTypingDelegate : AnyObject {
    func customInputViewTyping(_ view: CustomInputViewTyping, wantUploadMessage message: String, sendbtn: UIButton)
}
class CustomInputViewTyping: UIView {
    
    // MARK: - Properties
    public weak var delegate: CustomInputViewTypingDelegate?
     let inputTextView = CustomInputView()
     let dividerView = UIView()
    private let buttonbackGround : CustomImageView = {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapSendMessage))
        let iv =  CustomImageView(cornarRadius: 20, backgroundColor: .red)
        iv.isUserInteractionEnabled = true
        iv.addGestureRecognizer(gesture)
        return iv
    }()
    public lazy var sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "paperplane.fill"), for: .normal)
        button.setDimensions(height: 28, width: 28)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
       let stackView = UIStackView(arrangedSubviews: [inputTextView,buttonbackGround])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .fillProportionally
        return stackView
    }()
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
         Config_UI()
         Add_Target()
    }
    
    
    override var intrinsicContentSize: CGSize {
        return .zero
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    // MARK: - Helpers
    func Config_UI(){
        backgroundColor = .white
        autoresizingMask = .flexibleHeight
        addSubview(stackView)
        addSubview(dividerView)
        addSubview(sendButton)
        buttonbackGround.setDimensions(height: 40, width: 40)
        dividerView.backgroundColor = .lightGray
        add_Constraints()
    }
    
    func add_Constraints(){
        stackView.anchor(top: topAnchor,left: leftAnchor,right: rightAnchor,paddingLeft:5 ,paddingRight: 5)
        
        inputTextView.anchor(top: topAnchor,left: leftAnchor,bottom: safeAreaLayoutGuide.bottomAnchor,right: buttonbackGround.leftAnchor,paddingTop: 12,paddingLeft: 8,paddingBottom: 5,paddingRight: 8)
        
        sendButton.center(inView: buttonbackGround)
        dividerView.anchor(top: topAnchor,left: leftAnchor,right: rightAnchor,height: 0.75)
    }
    
    func cleartextView(){
        inputTextView.text = ""
        inputTextView.placeHolder.isHidden = false
        
        
    }
    // MARK: - add target
    func Add_Target(){
        sendButton.addTarget(self, action: #selector(didTapSendMessage), for: .touchUpInside)
    }
    // MARK: - Add button Actions
    @objc func didTapSendMessage(_ button: UIButton){
        delegate?.customInputViewTyping(self, wantUploadMessage: inputTextView.text, sendbtn: button)
    }
}
