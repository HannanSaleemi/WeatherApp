//
//  Location.swift
//  TDYWeather
//
//  Created by Hannan Saleemi on 27/12/2016.
//  Copyright © 2016 Hannan Saleemi. All rights reserved.
//

import Foundation
import CoreLocation

class Location{
    
    static var sharedInstance = Location()
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}

