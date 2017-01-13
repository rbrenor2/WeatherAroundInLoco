//
//  MapViewController.swift
//  WeatherAroundInLoco
//
//  Created by Breno Ramos on 11/01/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    //
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var selectedCoordinate = CLLocationCoordinate2D()
    //
    var citiesArray = [City]()
    
    //
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //Hide navigation bar
        self.navigationController?.navigationBar.isHidden = true
        //Hide activity indicator
        self.activityIndicator.isHidden = true
        // Set long press to set the location
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.didLongPress(longPress:)))
        gestureRecognizer.minimumPressDuration = 0.5 //press is detected after 0.5 seconds
        self.mapView.addGestureRecognizer(gestureRecognizer)
    }
    

    @IBAction func searchButton(_ sender: Any) {

        let appId = "524901&APPID=7cfd7b0b361c2bb7f58b1515691a7bc9"
        let apiCall = "http://api.openweathermap.org/data/2.5/find?id=%@&lat=%.2f&lon=%.2f&cnt=%d"
        let numberOfCities = 15
        
        //Clean array
        self.citiesArray.removeAll()
        
        //Enable activity indicator
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .utility).async {
            print("#1 - searchButton - calls background queue to dispatch async")
            
            //Perform search
            let urlString = String(format: apiCall, arguments: [appId, self.selectedCoordinate.latitude,self.selectedCoordinate.longitude, numberOfCities])
            print("#2 - searchButton - urlString: %@", urlString)
            
            let domainURL = URL(string: urlString as String)
            var jsonData:Data
            
            //Try download jsonData
            do{
                jsonData = try! Data(contentsOf: domainURL!)
                print("#3 - searchButton - jsonData download")
                
            }
            catch{
                print("#4 - searchButton - gettingDataERROR: %@",error)
            }
            
            //Try serialize download Json data
            var jsonSerializedDictionary:Dictionary<String, Any>
            
            do{
                jsonSerializedDictionary = try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
                print("#5 - searchButton - jsonData Serialization", jsonSerializedDictionary)
            }
            catch{
                print("#6 - searchButton - deserializingJSONERROR: %@",error)
            }
            
            //Turn Json into Objects using the names in the jSON structure
            let list:Array<Any> = jsonSerializedDictionary["list"] as! Array
            
            for case let city as NSDictionary in list{
                let name:String = city.object(forKey: "name") as! String
                let main:NSDictionary = city.object(forKey: "main") as! NSDictionary
                let minTemperature:Float = main.object(forKey: "temp_min") as! Float
                let maxTemperature:Float = main.object(forKey: "temp_max") as! Float
                
                
                let weather:NSArray = city.object(forKey: "weather") as! NSArray
                let weatherProperties:NSDictionary = weather[0] as! NSDictionary
                let weatherDescription:String = weatherProperties.object(forKey: "description") as! String
                
                let newCity = City(cityName: name, cityMin: self.convertToCelsius(temperatureInFarenheit: minTemperature), cityMax: self.convertToCelsius(temperatureInFarenheit: maxTemperature), cityDescription: weatherDescription)
                
                print("#7 - searchButton - newCity:",newCity.cityName, "minTemp:", newCity.cityMin, "maxTemp:", newCity.cityMax, "description:", newCity.cityDescription)
                
                //append to the array of Cities
                self.citiesArray.append(newCity)
            }
            
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                self.performSegue(withIdentifier: "citiesTableSegue", sender: self)
            }
        }

    }
    
    func convertToCelsius(temperatureInFarenheit:Float)->Float{
        let temperatureInCelsius = temperatureInFarenheit - 273
        
        return temperatureInCelsius
    }
    
   
    
    func didLongPress(longPress:UIGestureRecognizer){
    
        if(longPress.state == UIGestureRecognizerState.began){
            
            //Remove previous annotations
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            //Get the coordinates
            let touchPoint:CGPoint = longPress.location(in: self.mapView)
            self.selectedCoordinate = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            print("#1 - didLongPress - Touched Location: %@ %@", self.selectedCoordinate.latitude, self.selectedCoordinate.longitude)
            
            //Create an add a new annotation to the mapView
            let newAnnotation:MKAnnotation = Annotation(coordinate:self.selectedCoordinate)
            self.mapView.addAnnotation(newAnnotation)
            print("#2 - didLongPress - Annotation added")
        }

    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let destinationViewController : CitiesTableViewController = segue.destination as! CitiesTableViewController
        destinationViewController.citiesArray = citiesArray
        
    }

}
