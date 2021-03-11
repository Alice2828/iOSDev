//
//  FacultyDetailsVC.swift
//  KBTUApp
//
//  Created by User on 09.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class FacultyDetailVC: UIViewController {
    
    @IBOutlet weak var textBottom: UITextView!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dekanImage: UIImageView!
    var image: UIImage?
    var text: String?
    var textMore: String?
    var textTitle:String?
    var faculty: Faculty?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = textTitle
        dekanImage.image = image
        textView.text = text
        textBottom.text = textMore
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        textBottom.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
    }
  
    @IBAction func addToFav(_ sender: UIButton) {
        favorites.append(faculty!)
    }
    
}
