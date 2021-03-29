//
//  Phone.swift
//  AnimationApp
//
//  Created by User on 29.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation
class Phone  {
    var name: String?
    var price: String?
    var descrip: String?
    var descrip2: String?
    
    init(_ name: String, _ price: String, _ descrip: String, _ descrip2: String) {
        self.name = name
        self.price = price
        self.descrip = descrip
        self.descrip2 = descrip2
    }
}
