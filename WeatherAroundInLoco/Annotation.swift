//
//  Annotation.swift
//  WeatherAroundInLoco
//
//  Created by Breno Ramos on 11/01/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit
import MapKit

class Annotation: NSObject, MKAnnotation{
    
    let coordinate: CLLocationCoordinate2D
    
    init (coordinate:CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
