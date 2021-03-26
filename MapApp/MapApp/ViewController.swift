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

var showingNow = 0

class ViewController: UIViewController, MKMapViewDelegate, DeleteDelegat, UpdateDelegate, GoToDelegat {
    
    func goToPlace(_ name: String, _ descrip: String) {
        for annotation in self.myMap.annotations {
            if let title = annotation.title, title == name {
                if let subtitle = annotation.subtitle, subtitle == descrip{
                    self.myMap.showAnnotations([annotation], animated: true)
                    self.title = annotation.title!
                
                }
            }
        }
    }
    
    @IBAction func prevBtn(_ sender: UIButton) {
        if(showingNow == 0)
        {
            showingNow = places.count
        }
        for annotation in self.myMap.annotations {
            if let title = annotation.title, title == places[showingNow-1].name {
                if let subtitle = annotation.subtitle, subtitle == places[showingNow-1].descrip{
                    self.myMap.showAnnotations([annotation], animated: true)
                    self.title = annotation.title!
                }
            }
        }
        showingNow = showingNow-1
    }
    
    @IBAction func nextBtn(_ sender: UIButton) {
        if(showingNow == places.count-1)
        {
            showingNow = -1
        }
        for annotation in self.myMap.annotations {
            if let title = annotation.title, title == places[showingNow+1].name {
                if let subtitle = annotation.subtitle, subtitle == places[showingNow+1].descrip{
                    self.myMap.showAnnotations([annotation], animated: true)
                    self.title = annotation.title!
                }
            }
        }
        showingNow = showingNow+1
    }
    func updatePlace() {
        self.myMap.removeAnnotations(self.myMap.annotations)
        loadMap()
    }
    
    func deletePlace(_ name: String, _ descrip: String) {
        for annotation in self.myMap.annotations {
            if let title = annotation.title, title == name {
                if let subtitle = annotation.subtitle, subtitle == descrip{
                    self.myMap.removeAnnotation(annotation)
                }
            }
        }
    }
    
    var mapType:[Int: MKMapType] = [0: .hybrid, 1: .standard,2: .satellite]
    @IBOutlet weak var myMap: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        myMap.mapType = .standard
        myMap.delegate = self
        loadMap()
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard annotation is MKPointAnnotation else { return nil }
        
        let identifier = "Annotation"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView!.canShowCallout = true
            //button
            let rightButton = UIButton(type: .detailDisclosure)
            annotationView!.rightCalloutAccessoryView = rightButton
            
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            self.performSegue(withIdentifier: "toEdit", sender: view)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toEdit" )
        {
            let destination = segue.destination as! EditVC
            destination.name = (sender as! MKAnnotationView).annotation!.title!
            destination.descrip = (sender as! MKAnnotationView).annotation!.subtitle!
            destination.updateDelegate = self
            
        }
        else   if segue.identifier == "toPlacesTVC"
        {
            let destination = segue.destination as! PlacesTableVC
            destination.deleteDelegate = self
            destination.goToDelegate = self
        }
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
        self.myMap.showAnnotations(self.myMap.annotations, animated: true)
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


