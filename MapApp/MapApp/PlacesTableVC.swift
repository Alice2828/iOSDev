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
protocol DeleteDelegat{
    func deletePlace(_ name: String, _ descrip: String)
}
protocol GoToDelegat{
    func goToPlace(_ name: String, _ descrip: String)
}
class PlacesTableVC: UITableViewController {
    var deleteDelegate: DeleteDelegat?
    var goToDelegate: GoToDelegat?
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
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        goToDelegate?.goToPlace(places[indexPath.row].name!, places[indexPath.row].descrip!)
        navigationController?.popViewController(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        deleteDelegate?.deletePlace(places[indexPath.row].name!, places[indexPath.row].descrip!)
        if editingStyle == UITableViewCell.EditingStyle.delete {
            
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
                let context = appDelegate.persistentContainer.viewContext
                if editingStyle == .delete {
                    context.delete(places[indexPath.row])
                    
                    do {
                        try context.save()
                    } catch let error as NSError {
                        print("Error While Deleting Note: \(error.userInfo)")
                    }
                    
                }
                
                // Fetch new data/reload table
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Place")
                
                do {
                    places = try context.fetch(fetchRequest) as! [NSManagedObject] as! [Place]
                } catch let error as NSError {
                    print("Error While Fetching Data From DB: \(error.userInfo)")
                }
                
                tableView.reloadData()
            }
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
    
}
