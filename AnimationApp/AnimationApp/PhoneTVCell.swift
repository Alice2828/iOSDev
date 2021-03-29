//
//  PhoneTVCell.swift
//  AnimationApp
//
//  Created by User on 29.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class PhoneTVCell: UITableViewCell {
    
    @IBOutlet weak var normalView: UIView!
    @IBOutlet weak var flippedView: UIView!
    @IBOutlet weak var normalTitle: UILabel!
    @IBOutlet weak var conentView: UIView!
    @IBOutlet weak var normalSubtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        (self.accessoryView as! UIButton).addTarget(self, action: #selector (self.accessoryButtonTapped), for: .touchUpInside)
        
    }
    let options: UIView.AnimationOptions = [.transitionFlipFromRight]

    @objc func accessoryButtonTapped(sender:UIButton) {
        UIView.animate(withDuration:1, delay: 1, options:options, animations: {
            self.contentView.insertSubview(self.flippedView, at: 0)
        }, completion: nil)
        
    }
   
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
