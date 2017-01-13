//
//  DetailViewController.swift
//  WeatherAroundInLoco
//
//  Created by Breno Ramos on 11/01/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UINavigationControllerDelegate {

    
    @IBOutlet weak var cityMaxLabel: UILabel!
    @IBOutlet weak var cityMinLabel: UILabel!
    @IBOutlet weak var cityDescriptionLabel: UILabel!
    
    //Ad View
    
    var cityName:String = ""
    var cityMin:String = ""
    var cityMax:String = ""
    var cityDescription:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        
        self.title = cityName
        cityMinLabel.text = cityMin + " " + "℃"
        cityMaxLabel.text = cityMax + " " + "℃"
        cityDescriptionLabel.text = cityDescription
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.post(name: Notification.Name("GoingBackFromDetailViewController"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
