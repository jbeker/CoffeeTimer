//
//  TimerModel.swift
//  CoffeeTimer
//
//  Created by Jeremy Beker on 5/4/15.
//  Copyright (c) 2015 Picosphere. All rights reserved.
//

import UIKit

class TimerModel: NSObject {
    var coffeeName = ""
    var duration = 0

    init(coffeeName: String, duration: Int)
    {
        self.coffeeName = coffeeName
        self.duration = duration
        super.init()
    }
    
    override var description: String {
        return "TimerModel(\(coffeeName))"
    }
}
