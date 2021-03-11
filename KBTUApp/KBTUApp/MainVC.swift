//
//  MainVC.swift
//  KBTUApp
//
//  Created by User on 02.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var onlineBtn: UIButton!
    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onlineBtn.layer.backgroundColor = UIColor(red: 85, green: 120, blue: 245).cgColor
        onlineBtn.layer.cornerRadius = onlineBtn.frame.height/2
        onlineBtn.layer.shadowPath = UIBezierPath(roundedRect: onlineBtn.bounds, cornerRadius: 20).cgPath
        onlineBtn.titleLabel!.numberOfLines = 0; // Dynamic number of lines
        onlineBtn.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping;
        onlineBtn.titleLabel!.textAlignment = NSTextAlignment.center
        onlineBtn.contentEdgeInsets  = UIEdgeInsets(top: 10,left: 10,bottom: 10,right: 10)
        onlineBtn.layer.shadowRadius = 10
        onlineBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
        onlineBtn.layer.shadowOpacity = 0.5
        onlineBtn.layer.shadowColor = UIColor(red: 85, green: 200, blue: 245).cgColor
        textView.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showNews),
                                               name: NSNotification.Name("ShowNews"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showAboutUs),
                                               name: NSNotification.Name("ShowAboutUs"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showFaculties),
                                               name: NSNotification.Name("ShowFaculties"),
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(showFavorites),
                                               name: NSNotification.Name("ShowFavorites"),
                                               object: nil)
    }
    @objc func showNews(){
        performSegue(withIdentifier: "ShowNews", sender: nil)
    }
    @objc func showAboutUs(){
        performSegue(withIdentifier: "ShowAboutUs", sender: nil)
    }
    @objc func showFaculties(){
        performSegue(withIdentifier: "ShowFaculties", sender: nil)
    }
    @objc func showFavorites(){
        performSegue(withIdentifier: "ShowFavorites", sender: nil)
    }
    @IBAction func menuTap(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
}
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
