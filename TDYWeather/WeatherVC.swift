//
//  WeatherVC.swift
//  TDYWeather
//
//  Created by Hannan Saleemi on 26/12/2016.
//  Copyright © 2016 Hannan Saleemi. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherVC: UIViewController, CLLocationManagerDelegate{

    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var weatherTypeLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var mintempLabel: UILabel!
    @IBOutlet weak var maxtempLabel: UILabel!
    @IBOutlet weak var weatherDescriptionLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    var timeh: String!
    var timem: String!
    var times: String!
    
    var sunseth: String!
    var sunsetm: String!
    var sunsets: String!
    
    var sunriseh: String!
    var sunrisem: String!
    var sunrises: String!
    
    var currentWeather: CurrentWeather!
    
    var locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getCurrentTime()
        
        currentWeather = CurrentWeather()
        
        //LOCATION SETUP START
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startMonitoringSignificantLocationChanges()
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationAuthStatus()

    }
    
    func locationAuthStatus(){
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            
            currentWeather = CurrentWeather()
            currentWeather.downloadWeatherDetails {
                print(CURRENT_WEATHER_URL)
                self.updateMainUI()
            }
            
            
        }else{
            
            locationManager.requestWhenInUseAuthorization()
            locationAuthStatus()
            
        }
        
    }
    
    func updateMainUI(){
        
        cityLabel.text = currentWeather.cityName
        weatherTypeLabel.text = currentWeather.weatherType
        
        tempLabel.text = currentWeather.temp
        mintempLabel.text = "▼ \(currentWeather.minTemp)"
        maxtempLabel.text = "▲ \(currentWeather.maxTemp)"
        weatherDescriptionLabel.text = currentWeather.weatherDescription
        humidityLabel.text = "\(currentWeather.humidity) %"
        dayLabel.text = currentWeather.day
        
        getCurrentTime()
        
        print(time)
        print(currentWeather.sunrise)
        print(currentWeather.sunset)
        
        pullByHourMinuteSecond()
        
        
        if ("\(timeh):\(timem)") >= ("\(sunseth):\(sunsetm)") && ("\(timeh):\(timem)") >= ("\(sunriseh):\(sunrisem)"){
            
            print("NIGHTTIME!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!")
                
            if currentWeather._weatherType == "Clouds"{
                    
                weatherImage.image = UIImage(named: "CloudsN")
                print("cloudsn")
                    
            }else if currentWeather._weatherType == "Rain"{
                
                weatherImage.image = UIImage(named: "RainN")
                print("rainn")
                
            }else if currentWeather._weatherType == "Clear"{
                    
                weatherImage.image = UIImage(named: "ClearN")
                print("clearn")
                    
            }else if currentWeather._weatherType == "Mist"{
            
                weatherImage.image = UIImage(named: "MistN")
                print("mistn")
            }else{
                weatherImage.image = UIImage(named: currentWeather.weatherType)
                print("invalidtype")
            }
                
        }else{
            weatherImage.image = UIImage(named: currentWeather.weatherType)
        }
        
    }

    @IBAction func refreshBtnPressed(_ sender: Any) {
        
        currentWeather = CurrentWeather()
        currentWeather.downloadWeatherDetails {
            self.updateMainUI()
        }
        
    }
    
    func getCurrentTime(){
        
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        let seconds = calendar.component(.second, from: date)
        timeh = "\(hour)"
        timem = "\(minutes)"
        times = "\(seconds)"
        
    }
    
    func pullByHourMinuteSecond(){
        
        let sunrisearray = currentWeather.sunrise.components(separatedBy: ":")
        
        sunriseh = sunrisearray[0]
        sunrisem = sunrisearray[1]
        sunrises = sunrisearray[2]
        
        let sunsetarray = currentWeather.sunset.components(separatedBy: ":")
        
        sunseth = sunsetarray[0]
        sunsetm = sunsetarray[1]
        sunsets = sunsetarray[2]
        
        
    }

}

