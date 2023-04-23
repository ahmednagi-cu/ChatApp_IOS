//
//  AuthServices.swift
//  ChatApp
//
//  Created by ahmed nagi on 21/04/2023.
//


import UIKit
import Firebase

struct AuthCreadintional {
    var email: String
    var password: String
    var username: String
    var fullname: String
    let profileImage: UIImage
}
final class AuthServices {
    
    static let shared = AuthServices()
    
    func loginUser(){
        
    }
    
    
    func registerUser(creadintional: AuthCreadintional,completion: @escaping(Error?) -> Void){
        UploaderFile.shared.uploadImage(image: creadintional.profileImage) { imageURL in
          //  print("ImageUel: \(imageURL)")
            Auth.auth().createUser(withEmail: creadintional.email, password: creadintional.password) { result, error in
                if let error = error {
                    print("error create account\(error.localizedDescription)")
                    return
                }
                guard let uid = result?.user.uid else {return }
                let data: [String: Any] = [
                    "email": creadintional.email,
                    "username": creadintional.username,
                    "fullname": creadintional.fullname,
                    "uid": uid,
                    "profileImage": imageURL
                ]
            
                collection_user.document(uid).setData(data,completion: completion)
            }
        }
    }
}
