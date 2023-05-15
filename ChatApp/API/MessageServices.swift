//
//  MessageServices.swift
//  ChatApp
//
//  Created by ahmed nagi on 29/04/2023.
//

import Foundation
import Firebase
final class MessageServices {
    // MARK: - Singolten
    static let shared = MessageServices()
    /// fetch message from firebase
    func fetchMessages(otherUser: UserModel, completion: @escaping([MessageModel]) -> Void ){
        guard let uid = Auth.auth().currentUser?.uid else {return }
        var message = [MessageModel]()
        let query = collection_Messages.document(uid).collection(otherUser.uid).order(by: "timeStamp")
        
        query.addSnapshotListener { snapshot, _ in
            guard let documentChange = snapshot?.documentChanges.filter({ $0.type == .added}) else { return }
            message.append(contentsOf: documentChange.map({ MessageModel(dictionary: $0.document.data())}))
            completion(message)
        }
    }
    /// fetch recent message
    func fetchRecentMessages(completion: @escaping([MessageModel]) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let query = collection_Messages.document(uid).collection("recent-message").order(by: "timeStamp",descending: true)
        query.addSnapshotListener { snapshot, _ in
         guard let documentChange = snapshot?.documentChanges else { return }
            let messages = documentChange.map { MessageModel(dictionary: $0.document.data())}
            completion(messages)
        }
    }
    /// fetch upload message to firebase
    func uploadMessage(message: String, currentUser: UserModel, otherUser: UserModel,unReadeCount: Int,completion: ((Error?)
    -> Void)?){
        let dataFrom: [String: Any] = [
            "text": message,
            "fromId": currentUser.uid,
            "toID": otherUser.uid,
            "timeStamp": Timestamp(date: Date()),
            
            "username": otherUser.username,
            "fullname": otherUser.fullname,
            "profileImage": otherUser.profileImage,
            "new_msg": 0
        ]
        let dataTo: [String:Any] = [
            "text": message,
            "fromId": currentUser.uid,
            "toID": otherUser.uid,
            "timeStamp": Timestamp(date: Date()),
            
            "username": currentUser.username,
            "fullname": currentUser.fullname,
            "profileImage": currentUser.profileImage,
            "new_msg": unReadeCount
        
        ]
        
        collection_Messages.document(currentUser.uid).collection(otherUser.uid).addDocument(data: dataFrom) { _ in
            collection_Messages.document(otherUser.uid).collection(currentUser.uid).addDocument(data: dataTo,completion: completion)
            collection_Messages.document(currentUser.uid).collection("recent-message").document(otherUser.uid).setData(dataFrom)
            collection_Messages.document(otherUser.uid).collection("recent-message").document(currentUser.uid).setData(dataTo)
        }
    }
    
    func fetchSingleRecentMsg(otherUser: UserModel, completion: @escaping(Int) -> Void){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        collection_Messages.document(otherUser.uid).collection("recent-message").document(uid).getDocument { snapshot, error in
            guard let data = snapshot?.data() else {
                completion(0)
                return
            }
            let message = MessageModel(dictionary: data)
            completion(message.new_msg)
        }
    }
    
    func markReadAllMessage(otherUser: UserModel){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        let dataUpdate: [String: Any] = [
            "new_msg": 0
        ]
        collection_Messages.document(uid).collection("recent-message").document(otherUser.uid).updateData(dataUpdate)
    }
}
