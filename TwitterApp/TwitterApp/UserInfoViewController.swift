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

class UserInfoViewController: UIViewController , UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var dateOfBirth: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    var imagePicker: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load info
        let parent = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
        parent.observe(.value){
            [weak self](snapshot) in
            let user = UserCustom(snapshot: snapshot)
            self?.nameField.text = user.name
            self?.surnameField.text = user.surname
            self?.emailField.text = user.email
            self?.dateOfBirth.text = user.dateBirth
        }
        //image edit
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        imageView.isUserInteractionEnabled = true
        imageView.layer.cornerRadius = imageView.bounds.height / 2
        imageView.clipsToBounds = true
        imageView.addGestureRecognizer(imageTap)
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
    }
    
    @objc func openImagePicker(_ sender: Any?){
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveInfo(_ sender: UIButton) {
        
        let parent = Database.database().reference().child("users").child((Auth.auth().currentUser?.uid)!)
        let user = ["name": nameField.text!,
                    "surname": surnameField.text!,
                    "dateBirth": dateOfBirth.text!]
        parent.updateChildValues(user)
        imageProfile = imageView.image
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //imagePicker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            self.imageView.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
