//
//  City.swift
//  WeatherAroundInLoco
//
//  Created by Breno Ramos on 11/01/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit
import CoreLocation

class City: NSObject {
    let cityName:String
    let cityMin:Float
    let cityMax:Float
    let cityDescription:String
    
    init(cityName:String, cityMin:Float, cityMax:Float, cityDescription:String) {
        self.cityName = cityName
        self.cityMax = cityMax
        self.cityMin = cityMin
        self.cityDescription = cityDescription
    }

}
