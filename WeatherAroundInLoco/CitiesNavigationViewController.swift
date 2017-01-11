//
//  CitiesNavigationViewController.swift
//  WeatherAroundInLoco
//
//  Created by Breno Ramos on 11/01/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit

class CitiesNavigationViewController: UINavigationController {
    
    var citiesArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let destinationSegue:CitiesTableViewController = CitiesTableViewController()
        
        destinationSegue.citiesArray = citiesArray

        // Pass the selected object to the new view controller.
    }
 

}
