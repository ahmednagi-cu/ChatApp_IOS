//
//  UserServices.swift
//  ChatApp
//
//  Created by ahmed nagi on 24/04/2023.
//

import Foundation
import Firebase
final class UserServices {
    static let shared = UserServices()
    
    func fetchUser(uid: String, completion: @escaping(UserModel) -> Void){
        collection_user.document(uid).getDocument { result, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let dic = result?.data() else { return }
            let user = UserModel(dictionary: dic)
            completion(user)
        }
    }
    
/// Fetch users data
    
    func fetchUsers(completion: @escaping([UserModel]) -> Void) {
        collection_user.getDocuments { userData, error in
            guard let userData = userData, error == nil else { return }
            let users = userData.documents.map {
                UserModel(dictionary: $0.data())
                
            }
            completion(users)
        }
    }
}
