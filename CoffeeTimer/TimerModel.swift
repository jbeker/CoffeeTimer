//
//  TimerModel.swift
//  CoffeeTimer
//
//  Created by Jeremy Beker on 5/4/15.
//  Copyright (c) 2015 Picosphere. All rights reserved.
//

import UIKit



class TimerModel: NSObject {
    
    enum TimerType {
        case Coffee
        case Tea
    }
    
    dynamic var name = ""
    dynamic var duration = 0
    var type = TimerType.Coffee

    init(name: String, duration: Int, type: TimerType)
    {
        self.name = name
        self.duration = duration
        super.init()
    }
    
    override var description: String {
        return "TimerModel(\(name))"
    }
}
