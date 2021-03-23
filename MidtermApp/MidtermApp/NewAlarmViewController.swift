//
//  NewAlarmViewController.swift
//  MidtermApp
//
//  Created by User on 12.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit
protocol SaveDelegate{
    func saveAlarm(_ alarm: Alarm?)
}
class NewAlarmViewController: UIViewController {
    
    @IBOutlet weak var descrText: UITextView!
    @IBOutlet weak var timePicker: UIDatePicker!
    var saveDelegate: SaveDelegate?
    var alarm: Alarm?
    var timeText: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "HH:mm"
      
        timeText = "12:00"
        timePicker.datePickerMode = .time
        timePicker.locale = Locale(identifier: "ru_KZ")
        timePicker.date = formatter.date(from: (timeText)!)!
        timePicker.addTarget(self, action: #selector(timePickerValueChanged(sender:)), for: UIControl.Event.valueChanged)
        alarm = Alarm(timeText, "Default", true)
    }
    @objc func timePickerValueChanged(sender: UIDatePicker){
        timeText = formatter.string(from: sender.date)
    }
    @IBAction func saveAlarm(_ sender: Any) {
        alarm = Alarm(timeText, descrText.text, true)
        saveDelegate?.saveAlarm(alarm!)
        navigationController?.popViewController(animated: true)
    }
}
