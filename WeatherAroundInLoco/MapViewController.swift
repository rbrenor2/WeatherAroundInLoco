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
    var citiesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // Set long press to set the location
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: Selector("didLongPress"))
        
    }
    

    @IBAction func searchButton(_ sender: Any) {
        
        let appId = "42aa90839a45ca64f1066c806391c5fb"
        let apiCall = "http://api.openweathermap.org/data/2.5/find?id=%@&lat=%f&lon=%f&cnt=%d"
        
        DispatchQueue.global(qos: .background).async {
            //Perform search
            let domainUrl = String(format: apiCall, arguments: appId)

            
            DispatchQueue.main.async {
            //Perform segue
            self.performSegue(withIdentifier: "citiesTableSegue", sender: self)
            }
        }
        
    }
    
    func didLongPress(longPress:UIGestureRecognizer){
        if(longPress.state == UIGestureRecognizerState.began){
            let touchPoint:CGPoint = longPress.location(in: self.mapView)
            selectedCoordinate = mapView.convert(touchPoint, toCoordinateFrom: self.mapView)
            NSLog("Touched Location: %@ %@", selectedCoordinate.latitude, selectedCoordinate.longitude)

            
        }
        
        
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let destinationSegue : CitiesNavigationViewController = CitiesNavigationViewController()
        destinationSegue.citiesArray = citiesArray
        // Pass the selected object to the new view controller.
        
    }

}
