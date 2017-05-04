//
//  Constants.swift
//  TDYWeather
//
//  Created by Hannan Saleemi on 27/12/2016.
//  Copyright © 2016 Hannan Saleemi. All rights reserved.
//

import Foundation

//http://api.openweathermap.org/data/2.5/weather?lat=51.533086&lon=0.113924&units=metric&appid=c43b3c6b6febb0c9f3ff113066801956

typealias DownloadComplete = () -> ()

////let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=51.533086&lon=0.113924&units=metric&appid=c43b3c6b6febb0c9f3ff113066801956"



let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&units=metric&appid=c43b3c6b6febb0c9f3ff113066801956"
