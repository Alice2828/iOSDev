//
//  ZoomingSegue.swift
//  AnimationApp
//
//  Created by User on 30.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import UIKit

class ZoomingSegue: UIStoryboardSegue{
    override func perform() {
        let destination_view = self.destination.view
        let source_view = self.source.view
        destination_view?.transform = CGAffineTransform(scaleX: 0.2, y: 0.2)
        source_view?.alpha = 0
        self.source.present(self.destination, animated: false){
            UIView.animate(withDuration: 2, animations: {
                destination_view?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)})
        }
    }
}
