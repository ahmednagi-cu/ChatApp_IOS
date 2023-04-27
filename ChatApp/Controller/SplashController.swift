//
//  SplashController.swift
//  ChatApp
//
//  Created by ahmed nagi on 24/04/2023.
//

import UIKit
import Firebase
class SplashController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        checklogin()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          checklogin()
    }
    
    
    func checklogin(){
        if Auth.auth().currentUser?.uid == nil {
            let controller = LoginController()
            let nav = UINavigationController(rootViewController: controller)
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }else {
            guard let uid = Auth.auth().currentUser?.uid else { return}
            showLoader(true)
            UserServices.shared.fetchUser(uid: uid) {[weak self] user in
                self?.showLoader(false)
                let controller = ConversationController(user: user)
                let nav = UINavigationController(rootViewController: controller)
                nav.modalPresentationStyle = .fullScreen
                self?.present(nav, animated: true)
            }
        }
    }
 

}
