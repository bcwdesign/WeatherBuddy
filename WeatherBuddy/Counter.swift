//
//  Count.swift
//  WeatherBuddy
//
//  Created by bluecryjoe on 10/6/16.
//  Copyright © 2016 bluecryjoe. All rights reserved.
//

import UIKit

class Counter {
    var count = 0
    func increment() {
        count += 1
    }
    func increment(by amount: Int) {
        count += amount
    }
    func reset() {
        count = 0
    }
}
