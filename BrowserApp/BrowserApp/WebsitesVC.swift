//
//  WebsitesVC.swift
//  BrowserApp
//
//  Created by User on 20.02.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class WebsitesVC: UITableViewController {
    private var websites: [Website] = [Website(name: "Google",url: "https://www.google.com"), Website(name: "Facebook",url: "https://www.facebook.com")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Websites"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        cell.textLabel?.text = websites[indexPath.row].name
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWebsite"{
            if let navcon = segue.destination as? UINavigationController{
                if let destination = navcon.visibleViewController as? DetailVC{
                    if let index = tableView.indexPathForSelectedRow?.row
                    {
                        destination.urlString =  websites[index].url
                        destination.navigationItem.title = websites[index].name
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
