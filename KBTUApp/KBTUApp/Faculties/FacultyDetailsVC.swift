//
//  FacultyDetailsVC.swift
//  KBTUApp
//
//  Created by User on 09.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class FacultyDetailsVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var dekanImage: UIImageView!
    var image: UIImage?
    var text: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        dekanImage.image = image
        textView.text = text
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
