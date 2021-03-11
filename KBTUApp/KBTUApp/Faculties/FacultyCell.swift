//
//  FacultyCell.swift
//  KBTUApp
//
//  Created by User on 09.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class FacultyCell: UICollectionViewCell {
    @IBOutlet weak var deleteBtn: UIButton!
    var delegateDelete: DeleteProtocol?
    @IBOutlet weak var facultyLabel: UITextView!
    @IBOutlet weak var facultyImageView: UIImageView!
    var faculty: Faculty?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBAction func deleteFromFav(_ sender: UIButton) {
        delegateDelete?.deleteFav(item: faculty!)
    }
    func visibilityBtn(visibility : Bool){
        self.deleteBtn.isHidden = !visibility
    }

}
