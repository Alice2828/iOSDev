//
//  CustomView.swift
//  PaintApp
//
//  Created by User on 16.02.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class CustomView: UIView {
    var point1: CGPoint?
    var point2: CGPoint!
    var points = [CGPoint]()
    var color: Dictionary<ColorMode, UIColor> =
        [ColorMode.redCol: .red,
         ColorMode.blackCol: .black,
         ColorMode.greenCol: .green,
         ColorMode.blueCol: .blue]
    override func draw(_ rect: CGRect) {
        
        switch figureMode{
        case FigureMode.Rectangle:
            if let p1 = point1{
                let rect: FigureClass = Rectangle( withSome: color[colorMode]!, and: 3, isFilled: fillMode, with: p1, and: point2)
                rect.drawPath()
                history.addDrawings(drawing: rect)
            }
        case FigureMode.Circle:
            if let p1 = point1{
                let circ:FigureClass = Circle(withSome: color[colorMode]!, and: 3, isFilled: fillMode, with: point2.x-p1.x, and: point2)
                circ.drawPath()
                history.addDrawings(drawing: circ)
            }
        case FigureMode.Line:
            if let p1 = point1{
                let line: FigureClass = Line( withSome: color[colorMode]!, and: 3, isFilled: fillMode, with: p1, and: point2)
                line.drawPath()
                history.addDrawings(drawing: line)
            }
        case FigureMode.Triangle:
            if let p1 = point1{
                let triangle: FigureClass = Triangle( withSome: color[colorMode]!, and: 3, isFilled: fillMode, with: p1, and: point2)
                triangle.drawPath()
                history.addDrawings(drawing: triangle)
            }
        case FigureMode.Pen:
            let pen: FigureClass = Pen( withSome: color[colorMode]!, and: 3, isFilled: fillMode, with: points)
            pen.drawPath()
            history.addDrawings(drawing: pen)
            points = [CGPoint]()
        case FigureMode.Undo:
            point1 = nil
            point2 = nil
            history.undo()
            switch history.getDrawings().last{
            case is Circle:
                figureMode = FigureMode.Circle
            case is Rectangle:
                figureMode = FigureMode.Rectangle
            case is Line:
                figureMode = FigureMode.Line
            case is Pen:
                figureMode = FigureMode.Pen
            case is Triangle:
                figureMode = FigureMode.Triangle
            default:
                break
            }
        case FigureMode.Clear:
            history.deleteDrawings()
            figureMode = FigureMode.Circle
        }
        
        for figure in history.getDrawings(){
            figure.drawPath()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch =  touches.first{
            if figureMode == FigureMode.Pen
            {
                points.append(touch.location(in: self))
            }
            else{
                point1 = touch.location(in: self)
            }
            
        }
    }
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if figureMode == FigureMode.Pen{
            guard let touch = touches.first?.location(in: self)  else
            {return}
            points.append(touch)
        }
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch =  touches.first{
            point2 = touch.location(in: self)
            if figureMode == FigureMode.Pen{
                points.append(point2)
            }
        }
        
        setNeedsDisplay()
    }
}

