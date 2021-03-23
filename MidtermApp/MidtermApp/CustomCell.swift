//
//  CustomCell.swift
//  MidtermApp
//
//  Created by User on 12.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {

    @IBOutlet weak var switchAlarm: UISwitch!
    @IBOutlet weak var descrAlarm: UILabel!
    @IBOutlet weak var timeAlarm: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
