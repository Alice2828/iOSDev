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
        //source
    

        //destination
        self.source.present(self.destination, animated: false){
            source_view?.alpha = 0
            destination_view?.transform = CGAffineTransform(scaleX: 0.00001, y: 0.00001)
            UIView.animate(withDuration: 1, animations: {
                destination_view?.transform = CGAffineTransform.identity
            })
        }
    }
}
