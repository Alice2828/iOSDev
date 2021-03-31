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
    var xPosStart1: CGFloat?
    var xPosStart2 : CGFloat?
    var xPosition1: CGFloat?
    var xPosition2 : CGFloat?
    var yPosition1 : CGFloat?
    var yPosition2: CGFloat?
    override func viewDidLoad() {
        super.viewDidLoad()
        nextBtn.layer.cornerRadius = 5
        nextBtn.layer.borderWidth = 1
        nextBtn.layer.borderColor = UIColor.white.cgColor
        xPosStart1 = field1.center.x
        xPosStart2 = field2.center.x
        xPosition1 = field1.bounds.width
        xPosition2 = field2.bounds.width
        
        yPosition1 = field1.center.y
        yPosition2 = field2.center.y
        let options: UIView.AnimationOptions = [.curveEaseOut]
        UIView.animate(withDuration:1, delay: 0, options: options, animations: {
            
            self.field1.center = CGPoint(x: self.xPosition1!,y:self.yPosition1!)
            self.field2.center = CGPoint(x: self.xPosition2!,y:self.yPosition2!)
        }, completion: nil)
        UIView.animate(withDuration:1, delay: 1, options: options, animations: {
            self.nextBtn.alpha = 1
        }, completion: nil)
    }
    
    @IBAction func nextPressed(_ sender: UIButton) {
        let options: UIView.AnimationOptions = [.curveEaseOut]
        
        UIView.animate(withDuration:2, delay: 0, options: options, animations: {
            self.field1.center = CGPoint(x: self.xPosStart1!,y: self.field1.center.y)
            self.field2.center = CGPoint(x: self.xPosStart2!+self.xPosition2!,y: self.field2.center.y)
            
        }, completion: {_ in
            self.performSegue(withIdentifier: "mySegue", sender: nil)
        })
        
    }
}

