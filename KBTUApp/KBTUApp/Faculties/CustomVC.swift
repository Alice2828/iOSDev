//
//  CustomVC.swift
//  KBTUApp
//
//  Created by User on 09.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class CustomVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.view.layer.cornerRadius = 20
        self.view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        self.view.layer.shadowColor = UIColor.black.cgColor
        self.view.layer.shadowOffset = .init(width: 0, height: -2)
        self.view.layer.shadowRadius = 20
        self.view.layer.shadowOpacity = 0.5
        // Do any additional setup after loading the view.
    }
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = WelcomeContainerViewController(
            contentViewController: HelloViewController(),
            bottomSheetViewController: MyCustomViewController(),
            bottomSheetConfiguration: .init(
                height: UIScreen.main.bounds.height * 0.8,
                initialOffset: 60 + window!.safeAreaInsets.bottom
            )
        )
        window?.makeKeyAndVisible()
        
        return true
    }
}

final class WelcomeContainerViewController: BottomSheetContainerViewController
<HelloViewController, MyCustomViewController> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do something
    }
    
}
