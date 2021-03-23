//
//  File.swift
//  MidtermApp
//
//  Created by User on 12.03.2021.
//  Copyright © 2021 User. All rights reserved.
//

import Foundation
class Alarm:Equatable{
    static func == (lhs: Alarm, rhs: Alarm) -> Bool {
        return lhs.timeAlarm == rhs.timeAlarm && lhs.descrAlarm == rhs.descrAlarm && lhs.switchAlarm == rhs.switchAlarm
    }
    
    var timeAlarm: String?
    var descrAlarm: String?
    var switchAlarm: Bool?
    
    init(_ time: String?, _ descr: String?, _ switchA: Bool?){
        self.timeAlarm=time
        self.descrAlarm=descr
        self.switchAlarm=switchA
    }
}
