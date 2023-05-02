//
//  ConversationViewModel.swift
//  ChatApp
//
//  Created by ahmed nagi on 25/04/2023.
//

import Foundation
import Firebase

class NewConversationViewModel {
    // MARK: - Properties
    let user: UserModel
    var fullname: String {return user.fullname}
    var username: String { return user.username}
    var avatar: URL? {
        return URL(string: user.profileImage)
    }
    
     // MARK: - init
     init(user: UserModel) {
         self.user = user
     }
    

    
     
}
