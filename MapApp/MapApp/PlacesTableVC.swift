//
//  PlacesTableVC.swift
//  MapApp
//
//  Created by User on 24.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import CoreData
var places: [Place] = []
class PlacesTableVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        places = loadPlaces()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "placeCell", for: indexPath)
        cell.textLabel?.text = places[indexPath.row].name
        cell.detailTextLabel?.text = places[indexPath.row].descrip
        
        return cell
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
    
}
