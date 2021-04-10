//
//  User.swift
//  TwitterApp
//
//  Created by User on 10.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import FirebaseAuth

class UserCustom{
    var uid: String?
    var name: String?
    var surname: String?
    var email: String?
    var photoURL: String?
    var dateBirth: String?
    
    var dict: [String: String]{
        return [
            "uid": uid!,
            "email": email!,
            "name": name!,
            "surname": surname!,
            "photoURL": photoURL!,
            "dateBirth": dateBirth!
        ]
    }
    init(_ email: String,_ uid:String, _ photoURL: String, _ dateBirth: String, _ name:String, _ surname: String){
        self.email = email
        self.uid = uid
        self.name = name
        self.surname = surname
        self.photoURL = photoURL
        self.dateBirth = dateBirth
    }
    init(snapshot: DataSnapshot){
        if let value = snapshot.value as? [String:String]{
            email = value["email"]
            name = value["name"]
            surname = value["surname"]
            photoURL = value["photoURL"]
            dateBirth = value["dateBirth"]
            uid = value["uid"]
        }
    }
}
