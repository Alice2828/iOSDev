//
//  Figure.swift
//  PaintApp
//
//  Created by User on 16.02.2021.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation
import UIKit

class FigureClass{
    var color: UIColor 
    var strokeWidth: CGFloat = 0.0
    var isFilled:Bool
    
    init(withSome color:UIColor, and strokeWidth: CGFloat, isFilled: Bool){
        self.color = color
        self.strokeWidth = strokeWidth
        self.isFilled = isFilled
    }
    func drawPath(){}
}
