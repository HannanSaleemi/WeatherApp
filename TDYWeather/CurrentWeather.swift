//
//  CurrentWeather.swift
//  TDYWeather
//
//  Created by Hannan Saleemi on 26/12/2016.
//  Copyright © 2016 Hannan Saleemi. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather{
    
    var _cityName: String!
    var _weatherType: String!
    var _weatherDescription: String!
    var _temp: String!
    var _minTemp: String!
    var _maxTemp: String!
    var _humidty: String!
    var _day: String!
    
    var _sunrise: String!
    var _sunset: String!
    
    var weathervc = WeatherVC()
    
    var cityName: String{
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var weatherDescription: String{
        if _weatherDescription == nil{
            _weatherDescription = ""
        }
        return _weatherDescription
    }
    
    var temp: String{
        if _temp == nil{
            _temp = ""
        }
        return _temp
    }
    
    var minTemp: String{
        if _minTemp == nil{
            _minTemp = ""
        }
        return _minTemp
    }
    
    var maxTemp: String{
        if _maxTemp == nil{
            _maxTemp = ""
        }
        return _maxTemp
    }
    
    var humidity: String{
        if _humidty == nil{
            _humidty = ""
        }
        return _humidty
    }
    
    var day: String{
        if _day == nil{
            _day = ""
        }
        
        self._day = Date().dayOfWeek()!.uppercased()                     //USE EXTENSION TO GET DAT OF THE WEEK
        
        return _day
    }
    
    var sunrise: String{
        if _sunrise == nil{
            _sunrise = ""
        }
        return _sunrise
    }
    
    var sunset: String{
        if _sunset == nil{
            _sunset = ""
        }
        return _sunset
    }
    
    ///////DOWNLOAD DATA FROM THE INTERNET USING ALAMOFIRE AND PARSING JSON RESPONSE/////////
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        
        //Tell alamofire where to download from
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL)
        
        //Start alamofire downloads
        
        Alamofire.request(currentWeatherURL!).responseJSON{ response in
            
            let result = response.result
            
            //Put all into dictionary and PARSE
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let name = dict["name"] as? String{                              //Find key name with value as String
                    
                    self._cityName = name.capitalized                               //Store name in _cityName var
                    
                    print(self._cityName)
                    
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{        //Go inside weather which is an array then a dictionary
                    
                    if let main = weather[0]["main"] as? String{                             //In weather array [0], find key main
                        
                        self._weatherType = main.capitalized                                 //assign main value to _weatherType var
                        
                        print(self._weatherType)
                        
                    }
                    
                    if let details = weather[0]["description"] as? String{                  //In weather array at pos[0], find key description
                        
                        self._weatherDescription = details.capitalized                      //store value in _weatherdescription var
                        
                        print(self._weatherDescription)
                        
                    }
                    
                }
                
                
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    
                    if let currentTemp = main["temp"] as? Double{
                        
                        let roundedtemp = Double(round(100 * currentTemp) / 100)
                        
                        self._temp = "\(roundedtemp)"
                        
                        print(self._temp)
                        
                    }
                    
                    if let minimumtemp = main["temp_min"] as? Double{
                        
                        self._minTemp = "\(minimumtemp)"
                        
                        print(self._minTemp)
                        
                    }
                    
                    if let maximumtemp = main["temp_max"] as? Double{
                        
                        self._maxTemp = "\(maximumtemp)"
                        
                        print(self._maxTemp)
                        
                    }
                    
                    if let humid = main["humidity"] as? Double{
                        
                        self._humidty = "\(humid)"
                        
                        print(self._humidty)
                        
                    }
                    
                }
                
                if let system = dict["sys"] as? Dictionary<String, AnyObject>{
                    
                    if let sunrisetime = system["sunrise"] as? Double{
                        
                        let newtime = (sunrisetime).unixConvertedDate()
                        
                        self._sunrise = "\(newtime)"
                        
                        print(self._sunrise)
                        
                    }
                    
                    if let sunsettime = system["sunset"] as? Double{
                        
                        let newtime2 = (sunsettime).unixConvertedDate()
                        
                        self._sunset = "\(newtime2)"
                        
                        print(self._sunset)
                        
                    }
                    
                }
                
                
            }
            completed()
            
        }
            
            
        
    }

}

//PRINT DAY OF THE WEEK EG) TUESDAY
extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}

extension Double{
    
    func unixConvertedDate() -> String{
        
        let date = Date(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.timeStyle = .medium
        return dateFormatter.string(from: date)
        
    }
    
}
