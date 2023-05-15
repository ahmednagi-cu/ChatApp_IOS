//
//  MessageModel.swift
//  ChatApp
//
//  Created by ahmed nagi on 29/04/2023.
//

import Foundation
import Firebase
struct MessageModel {
    let text: String
    let fromId: String
    let toID: String
    let timeStamp: Timestamp
    let username: String
    let fullname: String
    let profileImage: String
    let new_msg: Int
    var isFromCurrentUser: Bool
    
    var chatPartnerID: String { return isFromCurrentUser ? toID : fromId}
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.toID = dictionary["toID"] as? String ?? ""
        self.username = dictionary["username"] as? String ?? ""
        self.fullname = dictionary["fullname"] as? String ?? ""
        self.profileImage = dictionary["profileImage"] as? String ?? ""
        self.timeStamp = dictionary["timeStamp"] as? Timestamp ?? Timestamp(date: Date())
        self.isFromCurrentUser = fromId == Auth.auth().currentUser?.uid
        
        self.new_msg = dictionary["new_msg"] as? Int ?? 0 
        
    }
}

