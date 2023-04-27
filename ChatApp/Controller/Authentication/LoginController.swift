//
//  LoginController.swift
//  ChatApp
//
//  Created by ahmed nagi on 19/04/2023.
//


import UIKit
import Firebase
class LoginController: UIViewController {
// MARK: - Properties
    private var viewModel = LoginViewModel()
    // MARK: - Crearte UI
    private let welcomeLble = CustomLable(text: "HEY, WELCOME",font: .boldSystemFont(ofSize: 20),color: .black)
    private let profileImageView = CustomImageView(image: UIImage(named: "profile"),width: 50,height: 50)
    private let emailTF = CustomTextField(placeHolder: "Email",keyboardType: .emailAddress)
    private let passwordTF = CustomTextField(placeHolder: "Passsword",isSecuretext: true)
    
    private lazy var loginBtn: UIButton = {
        let button = UIButton(type: .system)
        button.blackButton(buttonText: "Login")
        button.addTarget(self, action: #selector(didTapLoginBtn), for: .touchUpInside)
        return button
    }()
    private lazy var forgotPasswordBtn: UIButton = {
        let button = UIButton(type: .system)
        button.attributes(firstString: "Forgot your password?", lastString: " Get Help Signing in")
        button.setHeight(50)
        button.addTarget(self, action: #selector(didTapForgotBtn), for: .touchUpInside)
        return button
    }()

    private let contLble = CustomLable(text: "or countinue with Google",font: .systemFont(ofSize: 14),color: .lightGray)
    private lazy var googleBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Google", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 5
        button.titleLabel?.font = .boldSystemFont(ofSize: 19)
        button.addTarget(self, action: #selector(didTapGoogleBtn), for: .touchUpInside)
        return button
    }()
    private lazy var signUpBtn: UIButton = {
        let button = UIButton(type: .system)
        button.attributes(firstString: "Dont Hava an account?", lastString: " Sign up")
        button.setHeight(50)
        button.addTarget(self, action: #selector(didTapsignUpBtn), for: .touchUpInside)
        return button
    }()
 // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        bindingView()
    
    }


// MARK: - Helpers
    func configUI(){
        view.backgroundColor = .white
        view.addSubview(welcomeLble)
        view.addSubview(profileImageView)
        view.addSubview(signUpBtn)
        view.addSubview(contLble)
        view.addSubview(googleBtn)
        configConstraints()
    }
    func configConstraints(){
        welcomeLble.anchor(top: view.safeAreaLayoutGuide.topAnchor,paddingTop: 20)
        welcomeLble.centerX(inView: view)
        profileImageView.setDimensions(height: 50, width: 50)
        profileImageView.anchor(top:welcomeLble.bottomAnchor,paddingTop: 20)
        profileImageView.centerX(inView: view)
        let stackView = UIStackView(arrangedSubviews:[emailTF,passwordTF,loginBtn,forgotPasswordBtn])
        stackView.axis = .vertical
        stackView.spacing = 20
        stackView.distribution = .fill
        view.addSubview(stackView)
        stackView.anchor(top:profileImageView.bottomAnchor,left: view.leftAnchor,right: view.rightAnchor, paddingTop: 30,paddingLeft: 30,paddingRight: 30)
        signUpBtn.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        signUpBtn.centerX(inView: view)
        contLble.centerX(inView: view, topAnchor: forgotPasswordBtn.bottomAnchor,paddingTop: 30)
        googleBtn.centerX(inView: view, topAnchor: contLble.bottomAnchor,paddingTop: 12)
        googleBtn.setDimensions(height: 50, width: view.bounds.width * 0.30)
        
    }
    func bindingView(){
        emailTF.addTarget(self, action: #selector(textDidChanded(sender:)), for: .editingChanged)
        passwordTF.addTarget(self, action: #selector(textDidChanded(sender:)), for: .editingChanged)
    }
// MARK: - Actions
        @objc func didTapLoginBtn(){
            guard let email = emailTF.text,
                  let password = passwordTF.text
            else { return }
            showLoader(true)
            AuthServices.shared.loginUser(withEmail: email, withPassword: password) { result, error in
                self.showLoader(false)
                if let error = error {
                    self.showMessage(title: "Error", message: error.localizedDescription)
                    return
                }
                self.showLoader(false)
                self.gotTOApp()
            }
            
        }
    func gotTOApp(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        showLoader(true)
        UserServices.shared.fetchUser(uid: uid) { [weak self] user in
            self?.showLoader(false)
            let controller = ConversationController(user: user)
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            self?.present(nav, animated: true)
        }
        
    }
        @objc func didTapForgotBtn(){
            print("DEBG: forGot button")
        }
        @objc func didTapsignUpBtn(){
            let controller = RegisterController()
            controller.delegate = self
            navigationController?.pushViewController(controller, animated: true)
            print("DEBG: signUp button")
        }
        @objc func didTapGoogleBtn(){
            setupGoogle()
            print("DEBG: Google button")
        }
    @objc func textDidChanded(sender: UITextField){
        if sender == emailTF {
            viewModel.email = emailTF.text
            viewModel.validateRegisterationForm()
        }else {
            viewModel.password = passwordTF.text
            viewModel.validateRegisterationForm()
        }
       updateForm()
    }
  
}

extension LoginController : LoginViewModelProtocol {
    func updateForm() {
        loginBtn.isEnabled = viewModel.isRegisterationFormValid
    }
    
    
}

extension LoginController: RegisterController_Delegate {
    func didSuccCreateAccount(_ vc: RegisterController) {
        vc.navigationController?.popViewController(animated: true)
        //showLoader(false)
        gotTOApp()
    }
    
    
}
