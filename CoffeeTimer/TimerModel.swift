//
//  TimerModel.swift
//  CoffeeTimer
//
//  Created by Jeremy Beker on 5/4/15.
//  Copyright (c) 2015 Picosphere. All rights reserved.
//

import UIKit

class TimerModel: NSObject {
    var name = ""
    var duration = 0

    init(name: String, duration: Int)
    {
        self.name = name
        self.duration = duration
        super.init()
    }
    
    override var description: String {
        return "TimerModel(\(name))"
    }
}
