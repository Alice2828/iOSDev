//
//  LoginViewController.swift
//  TwitterApp
//
//  Created by User on 09.04.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    var currentUser: User?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewDidAppear(_ animated: Bool) {
        currentUser = Auth.auth().currentUser
        if currentUser != nil && currentUser!.isEmailVerified{
            goToMainPage()
        }
    }
    @IBAction func loginClicked(_ sender: UIButton) {
        let email = emailField.text
        let password = passwordField.text
        indicator.startAnimating()
        if email != "" && password != ""{
            Auth.auth().signIn(withEmail: email!, password: password!){
                [weak self]  (result, error) in
                self?.indicator.stopAnimating()
                if error == nil{
                    if Auth.auth().currentUser!.isEmailVerified{
                        self?.goToMainPage()
                    }
                    else{
                        self?.showMessage(title: "Warning", message: "Your email is not verified")
                    }
                }
                else
                {
                    
                }
            }
        }
    }
    func showMessage(title:String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let ok = UIAlertAction(title: "OK", style: .default)
        alert.addAction(ok)
        self.present(alert, animated: true, completion: nil)
    }
    func goToMainPage(){
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        if let mainPage = storyBoard.instantiateViewController(withIdentifier: "MainPageViewController") as? MainPageViewController{
            mainPage.modalPresentationStyle = .fullScreen
            present(mainPage, animated: true, completion: nil)
        }
    }
}
