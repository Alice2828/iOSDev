//
//  MenuVC.swift
//  KBTUApp
//
//  Created by User on 02.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class MenuVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Menu"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print (indexPath.row)
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
        switch indexPath.row{
        case 0:  NotificationCenter.default.post(name: NSNotification.Name("ShowNews"), object: nil)
        case 1: NotificationCenter.default.post(name: NSNotification.Name("ShowAboutUs"), object: nil)
        case 2: NotificationCenter.default.post(name: NSNotification.Name("ShowFaculties"), object: nil)
        case 3: NotificationCenter.default.post(name: NSNotification.Name("ShowFavorites"), object: nil)
        default:
            break
        }
    }
}
