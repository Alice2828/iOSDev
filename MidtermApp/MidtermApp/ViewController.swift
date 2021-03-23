//
//  ViewController.swift
//  MidtermApp
//
//  Created by User on 12.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
var alarms:[Alarm]=[Alarm.init("13:00","Launch",true),
                    Alarm.init("15:00","Android",true),
                    Alarm.init("16:00","Break",false),
                    Alarm.init("19:00","Launch",true),
                    Alarm.init("12:00","Launch",false)]
class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, EditDelegate, DeleteDelegate, SaveDelegate {
    
    @IBOutlet weak var myTableView: UITableView!
    
    
    func deleteAlarm(_ alarm: Alarm) {
        if let index = alarms.firstIndex(where: {$0 == alarm}){
            alarms.remove(at: index)
        }
        myTableView.reloadData()
    }
    
    func changeAlarm(_ alarm: Alarm, time: String?, title: String?) {
        alarms.filter({$0 == alarm}).first?.timeAlarm = time
        alarms.filter({$0 == alarm}).first?.descrAlarm = title
        myTableView.reloadData()
    }
    func saveAlarm(_ alarm: Alarm?) {
        alarms.append(alarm!)
        myTableView.beginUpdates()
        myTableView.insertRows(at: [NSIndexPath(row: alarms.count-1, section: 0) as IndexPath], with: .automatic)
        myTableView.endUpdates()
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            alarms.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  alarms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell") as? CustomCell
        cell?.timeAlarm.text = alarms[indexPath.row].timeAlarm
        cell?.descrAlarm.text = alarms[indexPath.row].descrAlarm
        cell?.switchAlarm.isOn = alarms[indexPath.row].switchAlarm!
        return cell!
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier=="showEdit"){
            let destination = segue.destination as! EditAlarmViewController
            let index = (myTableView.indexPathForSelectedRow?.row)!
            destination.alarm = alarms[index]
            destination.editDelegate = self
            destination.deleteDelegate = self
        }
        else if(segue.identifier=="showAdd"){
            let backBtn = UIBarButtonItem()
            backBtn.title = "Cancel"
            navigationItem.backBarButtonItem = backBtn
            let destination = segue.destination as! NewAlarmViewController
            destination.saveDelegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Alarms"
    }
}

