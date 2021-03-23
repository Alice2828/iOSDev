//
//  EditAlarmViewController.swift
//  MidtermApp
//
//  Created by User on 12.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
protocol EditDelegate{
   
    func changeAlarm(_ alarm: Alarm, time: String?, title: String?)
}
protocol DeleteDelegate{
   func deleteAlarm(_ alarm: Alarm)
}
let formatter = DateFormatter()

class EditAlarmViewController: UIViewController {
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var timePicer: UIDatePicker!
    var editDelegate: EditDelegate?
    var deleteDelegate: DeleteDelegate?
    var alarm: Alarm?
    var timeText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Change Alarm"
    
        descriptionText.text = alarm?.descrAlarm
        formatter.dateFormat = "HH:mm"
      
        timeText = alarm?.timeAlarm
        timePicer.datePickerMode = .time
        timePicer.locale = Locale(identifier: "ru_KZ")
        timePicer.date = formatter.date(from: (alarm?.timeAlarm)!)!
        timePicer.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        
    }
    
    @objc func timePickerValueChanged(sender: UIDatePicker){
        timeText = formatter.string(from: sender.date)
    }
    @IBAction func deleteAlarm(_ sender: UIButton) {
         deleteDelegate!.deleteAlarm(alarm!)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func changeAlarm(_ sender: UIButton) {
        editDelegate!.changeAlarm(alarm!, time: timeText, title: descriptionText.text)
        navigationController?.popViewController(animated: true)
    }

}
