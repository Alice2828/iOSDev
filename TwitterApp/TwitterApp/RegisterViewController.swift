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

class RegisterViewController: UIViewController {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func registerClicked(_ sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        indicator.startAnimating()
        if email != "" && password != ""{
            Auth.auth().createUser(withEmail: email!, password: password!)
            {[weak self] (result, error) in
                self?.indicator.stopAnimating()
                if error == nil{
                    self?.showMessage(title: "Success", message: "Please verify your email")
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
