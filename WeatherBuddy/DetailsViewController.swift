//
//  DetailsViewController.swift
//  WeatherBuddy
//
//  Created by bluecryjoe on 10/5/16.
//  Copyright © 2016 bluecryjoe. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet var weatherDescription: UILabel!
    @IBOutlet var weatherHigh: UILabel!
    @IBOutlet var weatherLow: UILabel!
    @IBOutlet var photo: UIImageView!
    @IBOutlet var humidity: UILabel!
    @IBOutlet var pressure: UILabel!
    @IBOutlet var wind: UILabel!
    @IBOutlet var dayOfTheWeek: UILabel!
    @IBOutlet var date: UILabel!
    
    var weatherInformation = WeatherDetails()
    
    var detailDescription:String = ""
    var detailHigh:Int = 0
    var detailLow:Int = 0
    var detailWind:String = ""
    var detailPressure:String = ""
    var detailHumility:String = ""
    var detailPhoto: UIImage = UIImage(named: "art_clear")!
    var detailDayOfTheWeek:String = ""
    var detailDate:String = ""
    
    let gradientLayer = CAGradientLayer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        // Define attributes for View
        
        weatherDescription.text = weatherInformation.weatherDescription
        weatherHigh.text = String(weatherInformation.weatherHigh)
        weatherLow.text = String(weatherInformation.weatherLow)
        pressure.text = "Pressure: \(String(weatherInformation.pressure)) h Pa"
        humidity.text = "Humidity: \(String(weatherInformation.humidity)) %"
        dayOfTheWeek.text = String(weatherInformation.dayOfTheWeek)
        wind.text = "Wind: \(String(weatherInformation.wind)) km/h"
        date.text = String(weatherInformation.date)
        photo.image = UIImage(named: weatherInformation.photo)
        
        //Set gradient background color
        self.view.backgroundColor = UIColor.white
        
        gradientLayer.frame = self.view.bounds
        
        let color1 = UIColor.clear.cgColor as CGColor
        let color3 = UIColor.clear.cgColor as CGColor
        let color4 = UIColor(white: 1.0, alpha: 0.7).cgColor as CGColor
        gradientLayer.colors = [color4, color3, color1]
        gradientLayer.locations = [0.0, 0.40, 0.65]

        self.view.layer.addSublayer(gradientLayer)
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
   /* func windDirectionByDegrees(_ windDegrees:Int) -> Int
        var directions:NSArray
            // Initialize array on first call.
         /*   directions = ["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE",
            "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"];
            });*/
            var windAddition = Double(windDegrees) + 11.25
            var i = windAddition/22.5
            var windFinal = Int(i) % 16
            print(windFinal)
            //directions[] as! Double
            return windFinal
    }*/

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
