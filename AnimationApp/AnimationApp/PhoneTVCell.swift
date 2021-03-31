//
//  PhoneTVCell.swift
//  AnimationApp
//
//  Created by User on 29.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class PhoneTVCell: UITableViewCell {
    
    @IBOutlet weak var flippedSubtitle: UILabel!
    @IBOutlet weak var flippedTitle: UILabel!
    @IBOutlet weak var normalView: UIView!
    @IBOutlet weak var flippedView: UIView!
    @IBOutlet weak var normalTitle: UILabel!
    
    @IBOutlet weak var hideBtn: UIButton!
    @IBOutlet weak var normalSubtitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    @IBAction func hide(_ sender: UIButton) {
    
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {
            self.flippedView.transform = CGAffineTransform(translationX: self.flippedView.bounds.width, y: 0)
            
            self.flippedView.alpha = 0
            
        }, completion: {_ in
            self.contentView.insertSubview(self.normalView, aboveSubview: self.flippedView)
            self.flippedView.transform = CGAffineTransform(translationX: 0, y: 0)
            self.flippedView.alpha = 1
             self.layer.backgroundColor = self.normalView.layer.backgroundColor
            self.accessoryType = .detailButton
        })
       
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
