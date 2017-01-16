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
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var buttonBackgroundView: UIView!
    
    var locationManager = CLLocationManager()
    var selectedCoordinate = CLLocationCoordinate2D()
    //
    var citiesArray = [City]()
    
    //
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Show navigation bar with instructions
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
            
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.topItem?.title = "Toque e segure para escolher a região"
            self.navigationController?.setNavigationBarHidden(false, animated: true)
        
        })
        
        //
        self.mapView.showsUserLocation = true

        
        //Hide activity indicator
        self.activityIndicator.isHidden = true
        // Set long press to set the location
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.didLongPress(longPress:)))
        gestureRecognizer.minimumPressDuration = 0.5 //press is detected after 0.5 seconds
        self.mapView.addGestureRecognizer(gestureRecognizer)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        //
        self.searchButton.isHidden = false
        
        //Navigation bar with instructions
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05, execute: {
            
            self.navigationController?.navigationBar.isTranslucent = true
            self.navigationController?.navigationBar.topItem?.title = "Toque e segure para escolher a região"
            self.navigationController?.setNavigationBarHidden(false, animated: true)
            
        })
    }
    
    @IBAction func searchButton(_ sender: UIButton) {

        let appId = "524901&APPID=7cfd7b0b361c2bb7f58b1515691a7bc9"
        let apiCall = "http://api.openweathermap.org/data/2.5/find?id=%@&lat=%.2f&lon=%.2f&cnt=%d"
        let numberOfCities = 15
        let latDelta:CLLocationDegrees = 2
        let lonDelta:CLLocationDegrees = 2
        
        //zoom in the selected region
        let span:MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(self.selectedCoordinate.latitude, self.selectedCoordinate.longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        self.mapView.setRegion(region, animated: true)
        
        //Check internet connectivity
        if(Reachability.isConnectedToNetwork() == false) {
            print("#1 - searchButton - Internet check - no Connection!")
            ErrorHandler.errorAlert(message:ErrorType.noInternetError.rawValue , viewController: self)
            return
        }
        
        //Clean array
        self.citiesArray.removeAll()
        
        //Enable activity indicator and hide search button
        sender.isHidden = true
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .userInitiated).async {
            print("#3 - searchButton - calls background queue to dispatch async")
            
            //Perform search
            let urlString = String(format: apiCall, arguments: [appId, self.selectedCoordinate.latitude,self.selectedCoordinate.longitude, numberOfCities])
            
            print("#4 - searchButton - urlString: %@", urlString)
            
            let domainURL = URL(string: urlString as String)
            var jsonData:Data!
            
            //Try download jsonData
            do{
                jsonData = try Data(contentsOf: domainURL!)
            }catch _{
                ErrorHandler.errorAlert(message: ErrorType.couldNotDownloadDataError.rawValue, viewController: self)
                return
            }
            var jsonSerializedDictionary:Dictionary<String, Any>
            
            //Try Json parse
            do{
               jsonSerializedDictionary = try JSONSerialization.jsonObject(with: jsonData!, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
            }catch _{
                ErrorHandler.errorAlert(message: ErrorType.genericError.rawValue, viewController: self)
                return
            }
            
            print("#6 - searchButton - jsonData Serialization", jsonSerializedDictionary)
                
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
                
                print("#8 - searchButton - newCity:",newCity.cityName, "minTemp:", newCity.cityMin, "maxTemp:",         newCity.cityMax, "description:", newCity.cityDescription)
                    
                //Append to the array of Cities
                self.citiesArray.append(newCity)
            }
            print("#5 - searchButton - jsonData download")
            
            //Try serialize download Json data
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
