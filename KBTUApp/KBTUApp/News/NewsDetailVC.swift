//
//  NewsDetailVC.swift
//  KBTUApp
//
//  Created by User on 09.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class NewsDetailVC: UIViewController {
    
    @IBOutlet weak var titleLabel: UITextView!
    @IBOutlet weak var textLabel: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    var image: UIImage?
    var text: String?
    var titleText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = text
        textLabel.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        imageView.image = image
        titleLabel.text = titleText
        
    }
}
