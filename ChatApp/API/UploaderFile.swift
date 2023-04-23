//
//  UploaderFile.swift
//  ChatApp
//
//  Created by ahmed nagi on 22/04/2023.
//

import UIKit
import Firebase
class UploaderFile {
    static let shared = UploaderFile()
    
    func uploadImage(image: UIImage,completion: @escaping(String) -> Void){
        guard let imageData = image.jpegData(compressionQuality: 0.75) else { return} // compress image
        let uid = Auth.auth().currentUser?.uid ?? "/profileImage/"
        let filename = NSUUID().uuidString
        let ref = Storage.storage().reference(withPath: "/\(uid)/\(filename)")
        ref.putData(imageData, metadata: nil) { metaData, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            ref.downloadURL { url, error in
                if let error = error {
                    print(error.localizedDescription)
                    return
                }
                guard let fileUrl = url?.absoluteString else { return }
                completion(fileUrl)
            }
        }
    }
}
