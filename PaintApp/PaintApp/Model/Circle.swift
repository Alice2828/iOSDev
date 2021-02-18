//
//  Circle.swift
//  PaintApp
//
//  Created by User on 16.02.2021.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation
import UIKit

class Circle: FigureClass{
    private var radius: CGFloat = 0.0
    private var circleCenter: CGPoint
    
    init(withSome color:UIColor, and strokeWidth: CGFloat, isFilled: Bool, with radius: CGFloat, and circleCenter: CGPoint) {
        self.radius = radius
        self.circleCenter = circleCenter
        super.init(withSome: color, and: strokeWidth, isFilled: isFilled)
    }
    override func drawPath(){
        let path = UIBezierPath(arcCenter: circleCenter,
                                radius: radius,
                                startAngle: 0,
                                endAngle: 2*Double.pi.cg,
                                clockwise: true)
        color.set()
        path.lineWidth = 3
        (isFilled) ? (path.fill()) :(path.stroke())
    }
}
