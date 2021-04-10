//
//  UserInfoViewController.swift
//  TwitterApp
//
//  Created by User on 10.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class UserInfoViewController: UIViewController {
    
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let parent = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
        parent.observe(.value){
            [weak self](snapshot) in
            let user = UserCustom(snapshot: snapshot)
            self?.nameField.text = user.name
            self?.surnameField.text = user.surname
            self?.emailField.text = user.email
            self?.dateOfBirth.text = user.dateBirth
        }
        
    }
    @IBAction func saveInfo(_ sender: UIButton) {
        
        let parent = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
        let user = ["name": nameField.text!,
                    "surname": surnameField.text!,
                    "dateBirth": dateOfBirth.text!]
        parent.updateChildValues(user)
         self.dismiss(animated: true, completion: nil)
    }
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
