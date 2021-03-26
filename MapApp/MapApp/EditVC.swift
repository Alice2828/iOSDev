//
//  EditVC.swift
//  MapApp
//
//  Created by User on 25.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
import CoreData
protocol UpdateDelegate{
    func  updatePlace()
}
class EditVC: UIViewController {
    
    @IBOutlet weak var descripTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    var descrip:String?
    var name:String?
    var updateDelegate: UpdateDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        descripTF.text = descrip ?? ""
        nameTF.text = name ?? ""
    }
    
    @IBAction func saveBtn(_ sender: UIButton) {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Place")
            let namePredicate = NSPredicate(format: "name = %@", name!)
            let descrPredicate = NSPredicate(format: "descrip = %@", descrip!)
            let andPredicate = NSCompoundPredicate(type: NSCompoundPredicate.LogicalType.and, subpredicates: [namePredicate, descrPredicate])
            fetchRequest.predicate = andPredicate
            
            do{
                let test =  try context.fetch(fetchRequest)
                
                
                let objectUpdate = test[0] as! NSManagedObject
                objectUpdate.setValue(nameTF.text!, forKey: "name")
                objectUpdate.setValue(descripTF.text!, forKey: "descrip")
                do{
                    try context.save()
                }catch{print("Error")}
                
            }catch{print("Error")}
            updateDelegate?.updatePlace()
            navigationController?.popViewController(animated: true)
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
