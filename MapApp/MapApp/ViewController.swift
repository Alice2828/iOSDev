//
//  ViewController.swift
//  MapApp
//
//  Created by User on 23.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController {
    
    var mapType:[Int: MKMapType] = [0: .hybrid, 1: .standard,2: .satellite]
    @IBOutlet weak var myMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myMap.mapType = .standard
    }
    
    
    @IBAction func segmentSelected(_ sender: UISegmentedControl) {
        myMap.mapType = mapType[sender.selectedSegmentIndex] ?? .standard
    }
    
    @IBAction func longTap(_ sender: UILongPressGestureRecognizer) {
        
        //touchToCoord
        let touchPoint = sender.location(in: self.myMap)
        let coordinate = self.myMap.convert(touchPoint, toCoordinateFrom: self.myMap)
        
        //alert
        let alertController = UIAlertController(title: "New location", message: "Fill the fields", preferredStyle: .alert)
        
        alertController.addTextField{(textField) in
            textField.placeholder = "Location"
        }
        alertController.addTextField{(textField) in
            textField.placeholder = "Description"
        }
        //save button
        let save =  UIAlertAction(title: "OK", style: .default){    [weak self](alert) in
            let firstTextField = alertController.textFields![0] as UITextField
            let secondTextField = alertController.textFields![0] as UITextField
            
            let annotation = MKPointAnnotation()
            annotation.title = firstTextField.text
            annotation.subtitle = secondTextField.text
            annotation.coordinate = coordinate
            
            self?.myMap.addAnnotation(annotation)
        }
        //cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(save)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

