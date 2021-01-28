//
//  Constants.swift
//  SwiftUIChat
//
//  Created by Stephen Dowless on 1/25/21.
//

import Firebase

let COLLECTION_USERS = Firestore.firestore().collection("users")
let COLLECTION_MESSAGES = Firestore.firestore().collection("messages")
let COLLECTION_CHANNELS = Firestore.firestore().collection("channels")
