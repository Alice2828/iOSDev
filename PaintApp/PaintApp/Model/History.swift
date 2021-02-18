//
//  History.swift
//  PaintApp
//
//  Created by User on 16.02.2021.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation
import UIKit
var figureMode = FigureMode.Circle
var colorMode = ColorMode.blackCol
var fillMode = false
var history = History()

enum ColorMode{
    case redCol
    case blackCol
    case greenCol
    case blueCol
}

enum FigureMode{
    case Circle
    case Rectangle
    case Triangle
    case Line
    case Pen
    case Undo
    case Clear
}

struct History{
    var drawings = [FigureClass]()
    mutating func addDrawings(drawing: FigureClass){
        drawings.append(drawing)
    }
    mutating func deleteDrawings(){
        drawings.removeAll()
    }
    func getDrawings() -> [FigureClass]{
        return drawings
    }
    mutating func undo()
    {
        drawings.removeLast()
    }
}
