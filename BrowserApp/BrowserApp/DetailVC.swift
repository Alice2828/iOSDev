//
//  DetailVC.swift
//  BrowserApp
//
//  Created by User on 20.02.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import WebKit

class DetailVC: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    var urlString: String?
    var id = 0
    var website = websites[0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.uiDelegate = self
        webView.load(URLRequest(url: URL(string: urlString ?? "https://www.google.com")!))
        if (navigationItem.title == nil)
        {
            navigationItem.title = "Google"
        }
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        tapGesture.numberOfTapsRequired = 3
        self.webView.addGestureRecognizer(tapGesture)
        
        if(allArrays[1].contains(where: {$0.url == urlString}))
        {
            navigationController?.navigationBar.barTintColor = UIColor.yellow
        }
        else {
            navigationController?.navigationBar.barTintColor = UIColor.gray
        }
        
    }
    
    
    @objc func tap() {
        if(!allArrays[1].contains(where: {$0.url == urlString}))
        {
            allArrays[1].append(website)
            navigationController?.navigationBar.barTintColor = UIColor.yellow
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        }
        else {
            allArrays[1].remove(at: id)
            navigationController?.navigationBar.barTintColor = UIColor.gray
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        }
        
    }
    
}
