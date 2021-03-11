//
//  OnlineRegisterVC.swift
//  KBTUApp
//
//  Created by User on 11.03.2021.
//  Copyright © 2021 User. All rights reserved.
//
import WebKit
import UIKit

class OnlineRegisterVC: UIViewController, WKUIDelegate {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.uiDelegate = self
        webView.load(URLRequest(url: URL(string: "https://kbtu.studyspace.kz/login#sign-in")!))
    }
}
