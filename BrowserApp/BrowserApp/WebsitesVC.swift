//
//  WebsitesVC.swift
//  BrowserApp
//
//  Created by User on 20.02.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
var websites: [Website] = [Website(name: "Google",url: "https://www.google.com"), Website(name: "Facebook",url: "https://www.facebook.com")]
var favorites: [Website] = [Website]()
var allArrays = [websites, favorites]
class WebsitesVC: UITableViewController {
    
   
    private var currentTableView: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
        navigationItem.title = "Websites"
        currentTableView = 0
    }
    
    @objc func refresh() {
        
        self.tableView.reloadData() // a refresh the tableView.
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allArrays[currentTableView!].count
    }
    
    @IBAction func addWebSite(_ sender: UIBarButtonItem) {
        let alert = UIAlertController(title: "Add website", message: "Fill all the fields", preferredStyle: UIAlertController.Style.alert)
        alert.addTextField()
        alert.addTextField()
        let submitAction = UIAlertAction(title: "Add", style: .default) { [unowned alert] _ in
            let name = alert.textFields![0].text
            let url = alert.textFields![1].text
            allArrays[0].append(Website(name: name, url: url))
            self.tableView.reloadData()
        }
        
        alert.addAction(submitAction)
        self.present(alert, animated: true, completion: nil)
        
        
    }
    @IBAction func switchTV(_ sender: UISegmentedControl) {
        currentTableView = sender.selectedSegmentIndex
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = allArrays[currentTableView!][indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebsite"{
            if let navcon = segue.destination as? UINavigationController{
                if let destination = navcon.visibleViewController as? DetailVC{
                    if let index = tableView.indexPathForSelectedRow?.row
                    {
                        destination.urlString =  allArrays[currentTableView!][index].url
                        destination.navigationItem.title = allArrays[currentTableView!][index].name
                        destination.website = allArrays[currentTableView!][index]
                        destination.id = index
                    }
                }
            }
        }
    }
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
}
