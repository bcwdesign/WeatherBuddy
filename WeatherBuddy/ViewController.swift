//
//  ViewController.swift
//  WeatherBuddy
//
//  Created by bluecryjoe on 10/5/16.
//  Copyright © 2016 bluecryjoe. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mainTableView: UITableView!
    
    @IBOutlet var mainImage: UIImageView!
    
    
    @IBOutlet var weatherDescription: UILabel!
    @IBOutlet var weatherHigh: UILabel!
    @IBOutlet var weatherLow: UILabel!
    @IBOutlet var date: UILabel!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!

    var cellData:NSArray = []
    var tempMaxData = [NSNumber]()
    var tempMinData = [NSNumber]()
    var tempDayData = [String]()
    var weatherDetails = [WeatherDetails]()
    var currentWeatherDetails = WeatherDetails()
    var selectedDetailRow:Int = 0
    var imageTapped = false
    
    /*
     // MARK: - Internal TableView functions
     
     // Functions for handling the TableView data
     */
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Create a variable that you want to send based on the destination view controller
        // You can get a reference to the data by using indexPath shown below

        self.selectedDetailRow = indexPath.row

        self.performSegue(withIdentifier: "segueDetail", sender: self)
    }
    
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if weatherDetails.count > 0{
                return weatherDetails.count
        } else {
            return 1
        }
    }

    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "Cell")
        
        let cell = self.mainTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherCell
        
        //if cellData.count > 0{
        if weatherDetails.count > 0{
            cell.weatherDescription?.text = weatherDetails[indexPath.row].weatherDescription
            cell.dayOfWeek.text = weatherDetails[indexPath.row].dayOfTheWeek
            cell.weatherLow.text = String(describing: weatherDetails[indexPath.row].weatherLow)
            cell.weatherHigh.text = String(describing: weatherDetails[indexPath.row].weatherHigh)
            cell.photo.image = UIImage(named: weatherDetails[indexPath.row].photo)
            
            
        } else {
            cell.weatherDescription?.text = "Clear"
            cell.dayOfWeek.text = "Monday"
            cell.weatherLow.text = "80"
            cell.weatherHigh.text = "90"
            cell.photo.image = UIImage(named: "art_clear")
        }
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let appID = API.APIKey //"912bec1620beae9249bc9671994d455f"
        
        //Grab the 5-day forecast weather data
        getForecastedWeather ("http://api.openweathermap.org/data/2.5/forecast/daily?q=Atlanta,ga&units=imperial&cnt=6&appid=\(appID)", appID)
        
        //Grab the current weather
        getCurrentWeather("http://api.openweathermap.org/data/2.5/weather?q=Atlanta,ga&units=imperial&appid=\(appID)", appID)
        
        //print("Calling URL: \(url)")
        
        //Set main image and add segue if clicked
        self.mainImage.image = UIImage(named: "art_clear")
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tappedMe))
        self.mainImage.addGestureRecognizer(tap)
        self.mainImage.isUserInteractionEnabled = true
        
        self.activityIndicator.startAnimating()

    }

    /*
     // MARK: - Get Current Weather
     
     // Make an API call to the retrieve the current weather information
     */
    
    func getCurrentWeather (_ myURL:String, _ appID:String){
        
    
        let url = URL(string: myURL)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                
                
                if let urlContent = data {
                    
                    do {
                    
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                        
                        print(jsonResult)
                        
                        let main = jsonResult["main"]
                        
                        print(main?["temp"])
                        
                        //Set Constants
                        let currentTemp = main?["temp"] as! Int
                        let currentLow = main?["temp_min"] as! Int
                        let humidity = main?["humidity"] as! Int
                        let pressure = main?["pressure"] as! Int
                        let wind = jsonResult["wind"]?["speed"] as! Int
                        
                        //Set current Variable
                        self.currentWeatherDetails.weatherHigh = currentTemp
                        self.currentWeatherDetails.weatherLow = currentLow
                        self.currentWeatherDetails.humidity = humidity
                        self.currentWeatherDetails.pressure = pressure
                        self.currentWeatherDetails.wind = wind
                        
                        //let todayDate =
                        var forecast = "Unknown"
                        var photo = ""
                        
                        if let weather:NSArray = jsonResult["weather"] as! NSArray
                        {
                            //print("Weather Desc: \((weather[count.count]  as? AnyObject)?["description"] as? AnyObject)")
                             forecast = ((weather[0]  as? AnyObject)!["description"] as? String)!
                            
                             print(forecast)
                            //print("Weather Icon: \((weather[count.count]  as? AnyObject)?["icon"] as? AnyObject)")
                            if let iconValue = API.icons[((weather[0]  as? AnyObject)!["icon"] as? String)!] {
                                print("The value returned is \(iconValue).")
                                photo = API.icons[((weather[0]  as? AnyObject)!["icon"] as? String)!]!

                                                            }
                        }
                        //let forcast =
                        
                        self.currentWeatherDetails.weatherDescription = forecast
                        self.currentWeatherDetails.photo = photo
                        
                        //Day of the Week
                        var todayDate = "Today, "
                        if let dt = jsonResult["dt"]{
                            let dateFormat = String(describing: NSDate(timeIntervalSince1970: dt as! TimeInterval))
                            
                            //print(dateFormat)
                            
                            if let weekday = self.getDayOfWeek(dateFormat) {
                                //print("Weekday : \(weekday)")
                                self.tempDayData.append(weekday )
                                let formattedDate:String = self.getCurrentDate("MMMM dd")!
                                todayDate = "Today, \(formattedDate)"
                                
                            } else {
                                print("bad input")
                            }
                        }
                        
                        DispatchQueue.main.async(execute: {
                            //Update data store….
                            self.mainImage.image = UIImage(named: photo)
                            self.weatherHigh.text = String(describing: currentTemp)
                            self.weatherLow.text = String(describing: currentLow)
                            self.weatherDescription.text = forecast
                            self.date.text = todayDate
                        })
                    }  catch{
                        print("JSON parsing failed!")
                    }
                }
            }
        }
        task.resume()
        
    }
    
    /*
     // MARK: - Get Forecasted Weather
     
     // Make an API call to the retrieve the focasted weather information for the next 5 days
     */
    
    func getForecastedWeather (_ myURL:String, _ appID:String){
        let url = URL(string: myURL)!
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                
                
                if let urlContent = data {
                    
                    do {
                        
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as! [String:AnyObject]
                        let lists = jsonResult["list"] as? [[String:AnyObject]]
                        //let dataContent:NSArray = []
                        
                        var count = Counter()
                        var weatherDetail:WeatherDetails
                        
                        for list in lists! {
                            weatherDetail = WeatherDetails()
                            
                            if let weather:NSArray = list["weather"] as! NSArray
                            {
                                //print("Weather Desc: \((weather[count.count]  as? AnyObject)?["description"] as? AnyObject)")
                                weatherDetail.weatherDescription = ((weather[count.count]  as? AnyObject)!["main"] as? String)!
                                //print("Weather Icon: \((weather[count.count]  as? AnyObject)?["icon"] as? AnyObject)")
                                if let iconValue = API.icons[((weather[count.count]  as? AnyObject)!["icon"] as? String)!] {
                                    print("The value returned is \(iconValue).")
                                    weatherDetail.photo = API.icons[((weather[count.count]  as? AnyObject)!["icon"] as? String)!]!
                                }
                            }
                            
                            
                            if let tempMax = list["temp"]?["day"]
                            {
                                print("High: \(tempMax)")
                                self.tempMaxData.append(tempMax as! NSNumber)
                                weatherDetail.weatherHigh = tempMax as! Int
                                
                            }
                            
                            if let tempMin = list["temp"]?["night"]
                            {
                                //print("Low : \(tempMin)")
                                self.tempMinData.append(tempMin as! NSNumber)
                                weatherDetail.weatherLow = tempMin as! Int
                            }
                            
                            //Humidity
                            if let humidity = list["humidity"]
                            {
                                //print("Humidity : \(humidity)")
                                weatherDetail.humidity = humidity as! Int
                            }
                            
                            //Pressure
                            if let pressure = list["pressure"]
                            {
                                //print("Pressure : \(pressure)")
                                weatherDetail.pressure = pressure as! Int
                            }
                            
                            //Wind
                            if let speed = list["speed"]
                            {
                                //print("Wind : \(speed)")
                                weatherDetail.wind = speed as! Int
                            }
                            
                            if let deg = list["deg"]
                            {
                                //print(deg)
                            }
                            
                            //var weekdayFormat = ""
                            //Day of the Week
                            if let dt = list["dt"]{
                                let dateFormat = String(describing: NSDate(timeIntervalSince1970: dt as! TimeInterval))
                                
                                //print(dateFormat)
                                
                                if let weekday = self.getDayOfWeek(dateFormat) {
                                    //print("Weekday : \(weekday)")
                                    self.tempDayData.append(weekday )
                                    weatherDetail.dayOfTheWeek = weekday
                                    
                                } else {
                                    print("bad input")
                                }
                            }
                            //weatherDetail.date = "October 6"
                            //weatherDetail.weatherDescription = "Clear"
                            weatherDetail.hasDetails = true
                            self.weatherDetails.append(weatherDetail)
                        }
                        
                        //Reload the data after the call is made
                        
                        DispatchQueue.main.async(execute: {
                            //Update data store….
                            self.mainTableView.reloadData()
                        })
                        
                        //self.mainTableView.reloadData()
                        
                        
                    } catch{
                        print("JSON parsing failed!")
                    }
                }
            }
            
        }
        task.resume()
        
    }
  
    /*
     // MARK: - Build Days of Week
     
     // Functions to build the days of the week details
     */
    
    func getDayOfWeek(_ today:String) -> String? {
        let formatter  = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd HH:mm:ss Z"
        if let todayDate = formatter.date(from: today) {
            let myCalendar = Calendar(identifier: .gregorian)
            let weekDay = myCalendar.component(.weekday, from: todayDate)
            let dayOfWeek = getWeekDay(weekDay)
            return dayOfWeek
        } else {
            return nil
        }
    }
    
    func getWeekDay(_ today:Int) -> String? {
        
        var weekDay:String
        
        switch today {
            case 1:
                weekDay = "Sunday"
                break
            case 2:
                weekDay = "Monday"
            break
            case 3:
                weekDay = "Tuesday"
            break
        case 4:
                weekDay = "Wednesday"
            break
        case 5:
                weekDay = "Thursday"
            break
        case 6:
                weekDay = "Friday"
            break
        case 7:
                weekDay = "Saturday"
            break
        default:
                weekDay = "Invalid Number"
        }
            return weekDay
    }
    
    //Pass in formate for today's date. i.e. "MM-dd-yyyy HH:mm"
    func getCurrentDate (_ format:String) -> String? {
        var todaysDate:NSDate = NSDate()
        let formatter  = DateFormatter()
        formatter.dateFormat = format
        let DateInFormat:String = formatter.string(from: todaysDate as Date)
        return DateInFormat
    }
    /*
     // MARK: - Get Icon Image
     
     // Functions to build the days of the week details
     */
    
    func getIconImage(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func viewDidAppear(_ animated: Bool) {
        self.mainTableView.reloadData()
        self.activityIndicator.stopAnimating()
    }
    
    /*
     // MARK: - Segue Functions
     
     // Sending the data to the next view controller
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueDetail" {
            if (self.imageTapped == false){
                if let destination = segue.destination as? DetailsViewController {
                    //destination.weatherInformation = WeatherDetails
                    //Displayed selected row data
                    //print("Final selected the row \(self.selectedDetailRow)")
                    let indexPath:NSIndexPath = self.mainTableView.indexPathForSelectedRow! as NSIndexPath
                    destination.weatherInformation = weatherDetails[indexPath.row]
                
                    }
                } else {
                    self.imageTapped = false
                    if let destination = segue.destination as? DetailsViewController {
                        destination.weatherInformation = self.currentWeatherDetails
                }
            }
        }
        
    }
    
    func tappedMe()
    {
        print("Tapped on Image")
        self.imageTapped = true
        self.performSegue(withIdentifier: "segueDetail", sender: self)
    }
}

