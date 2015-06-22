//
//  Arry+moveFrom.swift
//  CoffeeTimer
//
//  Created by Jeremy Beker on 6/22/15.
//  Copyright (c) 2015 Picosphere. All rights reserved.
//

import Foundation

extension Array {
    mutating func moveFrom(source: Int, toDestination destination: Int) {
    let object = removeAtIndex(source)
    insert(object, atIndex: destination)
    }
}