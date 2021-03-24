//
//  ViewController.swift
//  MapApp
//
//  Created by User on 23.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class ViewController: UIViewController, MKMapViewDelegate {
    
    var mapType:[Int: MKMapType] = [0: .hybrid, 1: .standard,2: .satellite]
    @IBOutlet weak var myMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myMap.mapType = .standard
        myMap.delegate = self
        myMap.register(
            ArtworkMarkerView.self,
            forAnnotationViewWithReuseIdentifier:
            MKMapViewDefaultAnnotationViewReuseIdentifier)
        loadMap()
       
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
            let secondTextField = alertController.textFields![1] as UITextField
            
            let annotation = MKPointAnnotation()
            annotation.title = firstTextField.text
            annotation.subtitle = secondTextField.text
            annotation.coordinate = coordinate
        
            self?.myMap.addAnnotation(annotation)
            
            
            self?.saveToCoreData(firstTextField.text!, secondTextField.text!, coordinate)
        }
        //cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
        alertController.addAction(save)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
    func loadMap(){
       places = loadPlaces()
        for place in places{
            let annotation = MKPointAnnotation()
            annotation.title = place.name
            annotation.subtitle = place.descrip
            annotation.coordinate = CLLocationCoordinate2D(latitude: place.latitude,longitude:place.longitude)
            self.myMap.addAnnotation(annotation)
        }
    }
    func loadPlaces()->[Place]{
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<Place>(entityName: "Place")
            do{
                try places = context.fetch(fetchRequest)
            }catch{print("Error")}
        }
        return places
    }
   
    func saveToCoreData(_ name: String, _ description: String, _ coordinate: CLLocationCoordinate2D){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            //            let myPersistentStoreCoordinator = appDelegate.persistentContainer.persistentStoreCoordinator
            if let entity = NSEntityDescription.entity(forEntityName:"Place", in: context)
            {
                let place =  NSManagedObject(entity: entity,insertInto:context)
                place.setValue (name, forKey:"name")
                place.setValue (description, forKey:"descrip")
                let longtitude = coordinate.longitude
                let latitude = coordinate.latitude
                place.setValue (longtitude, forKey:"longitude")
                place.setValue (latitude, forKey:"latitude")
                
                do{
                    try context.save()
                    places.append(place as! Place)
                }
                catch{print("Error")}
                
                //delete
                //                let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Place")
                //                let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                //
                //                do {
                //                    try myPersistentStoreCoordinator.execute(deleteRequest, with: context)
                //                } catch {}
            }
        }
    }
}
class ArtworkMarkerView: MKMarkerAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            // 1
            guard let place = newValue as? Place else {
                return
            }
            canShowCallout = true
            calloutOffset = CGPoint(x: -5, y: 5)
            rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            
            // 2
            markerTintColor = .cyan
            if let letter = place.name?.first {
                glyphText = String(letter)
            }
        }
    }
}

