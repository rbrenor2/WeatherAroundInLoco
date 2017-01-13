//
//  CitiesTableViewController.swift
//  WeatherAroundInLoco
//
//  Created by Breno Ramos on 11/01/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit

class CitiesTableViewController: UITableViewController {
    
    var citiesArray = [City]()
    var selectedCityIndex:NSInteger = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Show navigation bar
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.isTranslucent = true

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("#1 - numberOfRowsInSections - array range:", citiesArray.count)
        return citiesArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        // Configure the cell...
        cell.textLabel?.text = citiesArray[indexPath.row].cityName

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedCityIndex = indexPath.row
        self.performSegue(withIdentifier: "selectedCitySegue", sender: self)
    }
 
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationViewController:DetailViewController = segue.destination as! DetailViewController
        let selectedCity:City = citiesArray[(self.tableView.indexPathForSelectedRow?.row)!]
        
        destinationViewController.cityName = selectedCity.cityName
        destinationViewController.cityMin = NSString(format:"%.1f", selectedCity.cityMin) as String
        destinationViewController.cityMax = NSString(format:"%.1f", selectedCity.cityMax) as String
        destinationViewController.cityDescription = selectedCity.cityDescription
    }
  

}
