//
//  RegisterController.swift
//  ChatApp
//
//  Created by ahmed nagi on 20/04/2023.
//

import UIKit
protocol RegisterController_Delegate: AnyObject {
    func didSuccCreateAccount(_ vc: RegisterController)
}
class RegisterController: UIViewController {
// MARK: - Properties
    private var viewModel = RegisterViewMode()
    weak var delegate: RegisterController_Delegate?
    // MARK: - Crearte UI
    private lazy var profileImageBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "plus_photo"), for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(didChoosePhoto), for: .touchUpInside)
        return button
    }()
    private let emailTF = CustomTextField(placeHolder: "Email",keyboardType: .emailAddress)
    private let passwordTF = CustomTextField(placeHolder: "Passsword",isSecuretext: true)
    private let fullnameTF = CustomTextField(placeHolder: "Fullname")
    private let usernameTF = CustomTextField(placeHolder: "Username")
    
    private lazy var signupBtn: UIButton = {
        let button = UIButton(type: .system)
        button.blackButton(buttonText: "Sign Up")
        button.addTarget(self, action: #selector(didTapSignupBtn), for: .touchUpInside)
        return button
    }()
    
    private lazy var signinBtn: UIButton = {
        let button = UIButton(type: .system)
        button.attributes(firstString: "Already Hava an account?", lastString: " Sign In")
        button.setHeight(50)
        button.addTarget(self, action: #selector(didTapsignInBtn), for: .touchUpInside)
        return button
    }()
    
    private var profileImage: UIImage?
// MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bindingView()
    }
    
// MARK: - Helpers
    func configUI(){
        view.backgroundColor = .white
        view.addSubview(profileImageBtn)
        view.addSubview(signinBtn)
        configConstraints()
    }
    
    func configConstraints(){
        profileImageBtn.centerX(inView: view,topAnchor: view.safeAreaLayoutGuide.topAnchor)
        profileImageBtn.setDimensions(height: view.bounds.width * 0.30, width: view.bounds.width * 0.30)
        let stackView = UIStackView(arrangedSubviews:[emailTF,passwordTF,fullnameTF,usernameTF,signupBtn])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        view.addSubview(stackView)
        stackView.anchor(top:profileImageBtn.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor, paddingTop: 30,paddingLeft: 30,paddingRight: 30)
        signinBtn.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        signinBtn.centerX(inView: view)
        
    }
    func bindingView(){
        emailTF.addTarget(self, action: #selector(textDidChanded(sender:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textDidChanded(sender:)), for: .editingChanged)
        fullnameTF.addTarget(self, action: #selector(textDidChanded(sender:)), for: .editingChanged)
        usernameTF.addTarget(self, action: #selector(textDidChanded(sender:)), for: .editingChanged)
    }
// MARK: - Actions
    @objc func didTapSignupBtn(){
        guard let email = emailTF.text?.lowercased(),
              let password = passwordTF.text,
              let username = usernameTF.text?.lowercased(),
              let fullname = fullnameTF.text,
              let profileImage = profileImage    else { return }
       let creadtional = AuthCreadintional(email: email, password: password, username: username, fullname: fullname, profileImage: profileImage)
        showLoader(true)
        AuthServices.shared.registerUser(creadintional: creadtional) { error in
            self.showLoader(false)
            if let error = error {
                self.showMessage(title: "Error", message: error.localizedDescription)
                return
            }
            print("DEBG: Registration Compltion")
            self.delegate?.didSuccCreateAccount(self)
        }
        
    }
    @objc func didTapsignInBtn(){
        navigationController?.popViewController(animated: true)
        
    }
    @objc func textDidChanded(sender: UITextField){
        if sender == emailTF {
            viewModel.email = emailTF.text
            viewModel.validateRegisterationForm()
        }else if sender == passwordTF {
            viewModel.password = passwordTF.text
            viewModel.validateRegisterationForm()
        }else if sender == fullnameTF {
            viewModel.fullname = fullnameTF.text
            viewModel.validateRegisterationForm()
          
        }else {
            viewModel.username = usernameTF.text
            viewModel.validateRegisterationForm()
        }
         updateForm()
    }
    @objc func didChoosePhoto(){
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
}

extension RegisterController: RegisterViewModeProtocol {
    func updateForm() {
        signupBtn.isEnabled = viewModel.isRegisterationFormValid
    }
    
    
}

extension RegisterController : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage else { return }
        self.profileImage = selectedImage
        profileImageBtn.layer.cornerRadius = profileImageBtn.frame.width / 2
        profileImageBtn.layer.masksToBounds = true
        profileImageBtn.layer.borderColor = UIColor.gray.cgColor
        profileImageBtn.layer.borderWidth = 1
        profileImageBtn.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
        dismiss(animated: true)
    }
    
    
}
