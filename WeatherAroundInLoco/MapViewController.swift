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
import Foundation

class MapViewController: UIViewController, CLLocationManagerDelegate {

    //
    @IBOutlet weak var mapView: MKMapView!
    var locationManager = CLLocationManager()
    var selectedCoordinate = CLLocationCoordinate2D()
    //
    var citiesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Set long press to set the location
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.didLongPress(longPress:)))
        gestureRecognizer.minimumPressDuration = 0.5 //press is detected after 0.5 seconds
        self.mapView.addGestureRecognizer(gestureRecognizer)
    }
    

    @IBAction func searchButton(_ sender: Any) {
        
        let appId = "42aa90839a45ca64f1066c806391c5fb"
        let apiCall = "http://api.openweathermap.org/data/2.5/find?id=%@&lat=%@&lon=%@&cnt=%d"
        let numberOfCities = 15
        
        DispatchQueue.global(qos: .background).async {
            //Perform search
            let urlString = String(format: apiCall, arguments: [appId, self.selectedCoordinate.latitude, self.selectedCoordinate.longitude, numberOfCities])
            let domainURL = URL(string: urlString)
            var jsonData:Data
                
            do{
                jsonData = try! Data(contentsOf: domainURL!)
            }
            catch{
                print("#1 - searchButton - gettingDataERROR: %@",error)
            }
            
            var jsonDeserializedArray:Dictionary<String, Any>
            
            do{
                jsonDeserializedArray = try! JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as! Dictionary<String, Any>
            }
            catch{
                print("#2 - searchButton - deserializingJSONERROR: %@",error)
            }
            
            

            
            DispatchQueue.main.async {
            //Perform segue
            self.performSegue(withIdentifier: "citiesTableSegue", sender: self)
            }
        }
        
    }
    
    func didLongPress(longPress:UIGestureRecognizer){
        if(longPress.state == UIGestureRecognizerState.began){
            
            //Get the coordinates
            let touchPoint:CGPoint = longPress.location(in: self.mapView)
            self.selectedCoordinate = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            print("#1 - didLongPress - Touched Location: %@ %@", self.selectedCoordinate.latitude, self.selectedCoordinate.longitude)
            
            //Create an add a new annotation to the mapView
            let newAnnotation:MKAnnotation = Annotation(coordinate:self.selectedCoordinate)
            self.mapView.addAnnotation(newAnnotation)
            print("#2 - didLongPress - Annotation added")

        }
        else{
            print("#3 - didLongPress - longPress not detected")
        }
        
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let destinationSegue : CitiesNavigationViewController = CitiesNavigationViewController()
        destinationSegue.citiesArray = citiesArray
        // Pass the selected object to the new view controller.
        
    }

}
