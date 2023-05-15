//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by ahmed nagi on 29/04/2023.
//

import Foundation
import UIKit
final class MessageViewModel {
    let message: MessageModel
    
    var messageText: String { return message.text}
    var messageBackgrpundColor: UIColor { return message.isFromCurrentUser ? #colorLiteral(red: 0.4196078431, green: 0.831372549, blue: 0.431372549, alpha: 1) : #colorLiteral(red: 0.9058823529, green: 0.9098039216, blue: 0.9137254902, alpha: 1) }
    var messageColor: UIColor { return message.isFromCurrentUser ? .white : .black}
    var shoudHideProfileImage: Bool { return message.isFromCurrentUser}
    var profileImage: URL? { return URL(string:  message.profileImage)}
    var rightAnchorActive: Bool { return message.isFromCurrentUser}
    var leftAnchorActive: Bool { return !message.isFromCurrentUser}
    var unReadCount: Int { return message.new_msg}
    var shouldHidenunReadLable: Bool { return message.new_msg == 0}
    var timestapeString: String? {
        let data = message.timeStamp.dateValue()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-mm-yy - hh:mm a"
        return dateFormatter.string(from: data)

    }
    
    init(message: MessageModel) {
        self.message = message
    }
}
