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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.uiDelegate = self
        webView.load(URLRequest(url: URL(string: urlString ?? "https://www.google.com")!))
        
    }
}
