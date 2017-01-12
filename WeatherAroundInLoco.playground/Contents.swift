//: Playground - noun: a place where people can play

import UIKit
import CoreLocation


let appId = "42aa90839a45ca64f1066c806391c5fb"
let apiCall = "http://api.openweathermap.org/data/2.5/find?id=%@&lat=%.2f&lon=%.2f&cnt=%d"
let numberOfCities = 15
var selectedCoordinate = CLLocationCoordinate2D()


//let urlString = String(format: apiCall, appId, selectedCoordinate.latitude,selectedCoordinate.longitude, numberOfCities)

let urlString = String(format: apiCall, arguments: [appId, selectedCoordinate.latitude,selectedCoordinate.longitude, numberOfCities])

print(urlString)
