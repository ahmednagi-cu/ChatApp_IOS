//
//  UserModel.swift
//  ChatApp
//
//  Created by ahmed nagi on 24/04/2023.
//

import Foundation

struct UserModel {
    let email: String
    let username: String
    let fullname: String
    let uid: String
    let profileImage: String
    
    init(dictionary: [String: Any]){
        self.email = dictionary["email"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
    }
}
