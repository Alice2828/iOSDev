//
//  MainVC.swift
//  KBTUApp
//
//  Created by User on 02.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class MainVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    @IBAction func menuTap(_ sender: UIBarButtonItem) {
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
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
