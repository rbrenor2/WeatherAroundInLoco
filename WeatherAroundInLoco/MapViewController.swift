//
//  MapViewController.swift
//  WeatherAroundInLoco
//
//  Created by Breno Ramos on 11/01/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {

    
    @IBOutlet weak var mapView: MKMapView!
    
    
    var citiesArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func searchButton(_ sender: Any) {
        //1.Perform search in a background thread
        //2.Perform segue passing citiesArray
        self.performSegue(withIdentifier: "citiesTableSegue", sender: self)
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let destinationSegue : CitiesNavigationViewController = CitiesNavigationViewController()
        destinationSegue.citiesArray = citiesArray
        // Pass the selected object to the new view controller.
        
    }

}
