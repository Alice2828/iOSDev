//
//  RegisterViewController.swift
//  TwitterApp
//
//  Created by User on 09.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var dateOfBirthField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func registerClicked(_ sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        let name = nameField.text
        let surname = surnameField.text
        let date = dateOfBirthField.text
        indicator.startAnimating()
        if email != "" && password != "" && name != "" && surname != "" && date != ""{
            Auth.auth().createUser(withEmail: email!, password: password!)
            {[weak self] (result, error) in
                self?.indicator.stopAnimating()
                Auth.auth().currentUser?.sendEmailVerification(completion: nil)
                if error == nil{
                    self?.showMessage(title: "Success", message: "Please verify your email")
                    let db = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
                    let user = UserCustom(email!, (Auth.auth().currentUser?.uid)!, "", date!,name!,surname!)
                    db.setValue(user.dict)
                }
                else{
                    self?.showMessage(title: "Error", message: "Some problem occured")
                }
            }
        }
    }
    func showMessage(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default){
            (UIAlertAction) in
            if title != "Error"{
                self.dismiss(animated: true, completion: nil)
            }
            
        }
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
}
