//
//  Line.swift
//  PaintApp
//
//  Created by User on 16.02.2021.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation
import UIKit
class Line: FigureClass{
    private var p1: CGPoint
    private var p2: CGPoint
    
    init( withSome color:UIColor, and strokeWidth: CGFloat, isFilled: Bool, with p1:CGPoint, and p2: CGPoint) {
        self.p1 = p1
        self.p2 = p2
        super.init(withSome: color, and: strokeWidth, isFilled: isFilled)
    }
    override func drawPath(){
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.close()
        color.set()
        path.lineWidth = 3
        path.stroke()
    }
}
