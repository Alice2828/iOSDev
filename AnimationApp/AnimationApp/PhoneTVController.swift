//
//  PhoneTVController.swift
//  AnimationApp
//
//  Created by User on 29.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
var phones:[Phone] = [Phone.init("iPhone 12","2000$","AMX","BMX"),Phone.init("iPhone 12","2000$","AMX","BMX"),Phone.init("iPhone 12","2000$","AMX","BMX"),Phone.init("iPhone 12","2000$","AMX","BMX"),Phone.init("iPhone 12","2000$","AMX","BMX"),Phone.init("iPhone 12","2000$","AMX","BMX"),Phone.init("iPhone 12","2000$","AMX","BMX")]
class PhoneTVController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "PhoneTVCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "myCell")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return phones.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! PhoneTVCell
        
        cell.normalTitle?.text = phones[indexPath.row].name
        cell.normalSubtitle?.text = phones[indexPath.row].price
        cell.flippedTitle?.text = phones[indexPath.row].descrip
        cell.flippedSubtitle?.text = phones[indexPath.row].descrip2
        cell.frame.origin.x = -cell.frame.width
        cell.accessoryType = .detailButton
        //animation of cell
        let delay = Double(indexPath.row) * 0.2
        UIView.animate(withDuration: 0.7, delay: TimeInterval(delay), usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .allowUserInteraction, animations: {
            cell.frame.origin.x = 0
        }, completion: nil)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PhoneTVCell
        cell.accessoryType = .none
        UIView.transition(with: cell.contentView,
                          duration: 0.6,
                          options: .transitionFlipFromTop,
                          animations:  {
                            cell.contentView.insertSubview(cell.flippedView, aboveSubview: cell.normalView)
        },
                          completion: nil)
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
