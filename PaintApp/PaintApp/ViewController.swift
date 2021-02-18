//
//  ViewController.swift
//  PaintApp
//
//  Created by User on 16.02.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var items: [UIColor] = [UIColor.red, UIColor.black, UIColor.green, UIColor.blue]
    var figures = [ "circle", "line","pen", "rectangle", "triangle"]
    
    @IBOutlet weak var colorCollection: UICollectionView!
    @IBOutlet weak var switchFill: UISwitch!
    @IBOutlet weak var customCanvas: CustomView!
    @IBOutlet weak var figureCollection: UICollectionView!
    @IBOutlet weak var undoBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tap))
        let longGesture = UILongPressGestureRecognizer(target: self, action: #selector(longPressed))
        tapGesture.numberOfTapsRequired = 1
        colorCollection.delegate = self
        colorCollection.dataSource = self
        figureCollection.delegate = self
        figureCollection.dataSource = self
        self.undoBtn.addGestureRecognizer(tapGesture)
        self.undoBtn.addGestureRecognizer(longGesture)
        self.switchFill.addTarget(self, action: #selector(stateChanged), for: .valueChanged)
    }
    @objc func stateChanged(switchState: UISwitch) {
        if switchState.isOn {
            fillMode = true
        } else {
            fillMode = false
        }
    }
    @objc func tap() {
        figureMode = FigureMode.Undo
        customCanvas.setNeedsDisplay()
    }
    @objc func longPressed()
    {
        figureMode = FigureMode.Clear
        customCanvas.setNeedsDisplay()
    }
    
}
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var number = 0
        switch(collectionView)
        {
        case colorCollection:
            number = items.count
        case figureCollection:
            number = figures.count
        default: break
        }
        return number
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell = UICollectionViewCell()
        
        switch (collectionView)
        {
        case (colorCollection):
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath)
            
            if let view = cell.viewWithTag(111){
                view.backgroundColor = items[indexPath.row]
                view.layer.cornerRadius = 3
            }
            return cell
            
        case (figureCollection):
            
            let newCell = (collectionView.dequeueReusableCell(withReuseIdentifier: "figureCell", for: indexPath) as? FigureCollectionCollectionViewCell)!
            newCell.imageFigure.image = UIImage(named: figures[indexPath.row])
            cell = newCell as UICollectionViewCell
            return cell
            
        default:
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == figureCollection
        {
            switch figures[indexPath.row] {
            case "circle":
                figureMode = FigureMode.Circle
            case "rectangle":
                figureMode = FigureMode.Rectangle
            case "line":
                figureMode = FigureMode.Line
            case "triangle":
                figureMode = FigureMode.Triangle
            case "pen":
                figureMode = FigureMode.Pen
            default:
                break
            }
        }
        else if collectionView == colorCollection {
            switch items[indexPath.row] {
            case UIColor.red:
                colorMode = ColorMode.redCol
            case UIColor.black:
                colorMode = ColorMode.blackCol
            case UIColor.green:
                colorMode = ColorMode.greenCol
            case UIColor.blue:
                colorMode = ColorMode.blueCol
            default:
                break
            }
        }
    }
    
}
