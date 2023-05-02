//
//  constants.swift
//  ChatApp
//
//  Created by ahmed nagi on 22/04/2023.
//

import Firebase

//enum collectionUser: String {
//    case users
//}

let collection_user = Firestore.firestore().collection("users")
let collection_Messages = Firestore.firestore().collection("messages")
let ScreenWidth = UIScreen.main.bounds.width
let ScreenHeight = UIScreen.main.bounds.height
