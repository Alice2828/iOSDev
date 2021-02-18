//
//  Triangle.swift
//  PaintApp
//
//  Created by User on 16.02.2021.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation
import UIKit
class Triangle: FigureClass{
    private var p1: CGPoint
    private var p2: CGPoint
    private var p3: CGPoint
    
    init( withSome color:UIColor, and strokeWidth: CGFloat, isFilled: Bool, with p1:CGPoint, and p2: CGPoint) {
        self.p1 = p1
        self.p2 = p2
        if(p1.y==p2.y)
        {
            self.p3 = CGPoint(x: min(p1.x,p2.x)+abs(p1.x-p2.x)/2, y: min(p1.y,p2.y)+abs(p1.x-p2.x))
        }
        else if(p1.x==p2.x){
            self.p3 = CGPoint(x: min(p1.x,p2.x)+abs(p1.y-p2.y)/2, y: min(p1.y,p2.y)+abs(p1.y-p2.y))
        }
        else{
            self.p3 = CGPoint(x: min(p1.x,p2.x)+abs(p1.y-p2.y)/2, y: min(p1.y,p2.y)+abs(p1.y-p2.y))
        }
        super.init(withSome: color, and: strokeWidth, isFilled: isFilled)
    }
    override func drawPath(){
        let path = UIBezierPath()
        path.move(to: p1)
        path.addLine(to: p2)
        path.addLine(to: p3)
        path.addLine(to: p1)
        path.close()
        color.set()
        path.lineWidth = 3
        (isFilled) ? (path.fill()) :(path.stroke())
    }
}
