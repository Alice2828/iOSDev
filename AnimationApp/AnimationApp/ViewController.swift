//
//  ViewController.swift
//  AnimationApp
//
//  Created by User on 29.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var field1: UITextField!
    @IBOutlet weak var field2: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        let options: UIView.AnimationOptions = [.curveEaseOut]
        UIView.animate(withDuration:1, delay: 0, options: options, animations: {
            let xPosition1 = self.field1.bounds.width
            let xPosition2 = self.field2.bounds.width
            let yPosition1 = self.field1.center.y
            let yPosition2 = self.field2.center.y
            self.field1.center = CGPoint(x:xPosition1,y:yPosition1)
            self.field2.center = CGPoint(x: xPosition2,y:yPosition2)
        }, completion: nil)
        UIView.animate(withDuration:1, delay: 1, options: options, animations: {
            self.nextBtn.alpha = 1
        }, completion: nil)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
    }
    
}

