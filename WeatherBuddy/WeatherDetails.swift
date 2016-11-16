//
//  WeatherDetails.swift
//  WeatherBuddy
//
//  Created by bluecryjoe on 10/6/16.
//  Copyright © 2016 bluecryjoe. All rights reserved.
//

import UIKit

class WeatherDetails {

    var hasDetails = false
    var humidity:Int = 0
    var dayOfTheWeek:String = ""
    var date: String = ""
    var weatherDescription: String = ""
    var pressure:Int = 0
    var wind:Int = 0
    var photo:String = ""
    var weatherHigh:Int = 0
    var weatherLow:Int = 0
    
    func addData(_ humidityInfo:Int, _ dayOfTheWeekInfo:String, _ dateInfo:String, _ description:String,
        _ pressureInfo:Int, _ windInfo:Int, _ weatherHighInfo:Int, _ weatherLowInfo:Int ) {
        
        humidity = humidityInfo
        dayOfTheWeek = dayOfTheWeekInfo
        date = dateInfo
        weatherDescription = description
        pressure = pressureInfo
        wind = windInfo
        weatherLow = weatherLowInfo
        weatherHigh = weatherHighInfo
        
        hasDetails = true
        
        
    }
}
