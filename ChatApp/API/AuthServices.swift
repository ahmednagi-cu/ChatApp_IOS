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

struct AuthCreadintionalEmail {
    var email: String
    var uid: String
    var username: String
    var fullname: String
    let profileImage: UIImage
}
final class AuthServices {
    
    static let shared = AuthServices()
    
    func loginUser(withEmail email: String, withPassword password: String,completion: (AuthDataResultCallback?)){
        Auth.auth().signIn(withEmail: email, password: password,completion: completion)
        
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
    
    func registerWithGoogle(credintail: AuthCreadintionalEmail, completion: @escaping(Error?) -> Void){
        UploaderFile.shared.uploadImage(image: credintail.profileImage) { imageURL in
            
            let data: [String: Any] = [
                "email": credintail.email,
                "username": credintail.username,
                "fullname": credintail.fullname,
                "uid": credintail.uid,
                "profileImage": imageURL
            ]
            collection_user.document(credintail.uid).setData(data,completion: completion)
        }
    }
}
