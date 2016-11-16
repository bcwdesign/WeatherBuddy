//
//  Configuration.swift
//  WeatherBuddy
//
//  Created by bluecryjoe on 10/6/16.
//  Copyright © 2016 bluecryjoe. All rights reserved.
//

import Foundation

// MARK: - API Keys
struct API {
    
    static let APIKey = ""
    static let BaseURL = URL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?appid=\(APIKey)")!
    static let icons: [String: String] = ["01d": "art_clear", "01n": "ic_clear", "02d": "art_light_clouds", "02n": "ic_light_clouds", "03d": "art_clouds", "03n": "ic_cloudy", "04d": "art_clouds", "04n": "ic_cloudy", "09d": "art_light_rain", "09n": "ic_light_rain", "10d": "art_rain", "10n": "ic_rain", "11d": "art_storm", "11n": "ic_storm", "13d": "art_snow", "13n": "ic_snow", "50d": "art_fog", "50n": "ic_fog"]
    
}
