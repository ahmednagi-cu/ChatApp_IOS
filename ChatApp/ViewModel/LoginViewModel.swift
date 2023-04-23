//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by ahmed nagi on 20/04/2023.
//

import Foundation
protocol LoginViewModelProtocol {
    func updateForm()
}
class LoginViewModel {
    
    var email: String?
    var password: String?
    var isRegisterationFormValid: Bool = false
    
    func validateRegisterationForm(){
        guard let email = email,
              let password = password else {
              isRegisterationFormValid = false
            return }
        
        isRegisterationFormValid = isValidEmail(email) && password.count >= 8
        
        
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
}
