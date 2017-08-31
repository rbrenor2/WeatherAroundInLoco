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

    
    var cityName:String = ""
    var cityMin:String = ""
    var cityMax:String = ""
    var cityDescription:String = ""
    var cityDescriptionImageView = UIImageView()
    var blurView = UIVisualEffectView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.isHidden = false
        
        //places the image outside sight
        cityDescriptionImageView.frame = CGRect(x: (self.view.frame.width/10) - 200, y: (self.view.frame.height/4) - 30, width: 150, height: 150)
        
        cityMaxLabel.frame = CGRect(x: (self.view.frame.width/2), y: (self.view.frame.height) + 100, width: 37.5, height: 65)
        cityMinLabel.frame = CGRect(x: (self.view.frame.width/2), y: (self.view.frame.height) + 100, width: 37.5, height: 65)
        
        cityMaxLabel.alpha = 0
        cityMinLabel.alpha = 0
        view.addSubview(cityDescriptionImageView)
    
        //animates the imageview to its final position
        UIView.animate(withDuration: 1.5, delay: 2, usingSpringWithDamping: 3, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: ({
            
            self.cityMaxLabel.frame = CGRect(x: self.view.frame.height/2 , y: self.view.frame.width/2, width: 37.5, height: 65)
            
        }), completion: {(Bool) in
            self.rainAnimation()
        })
        
        UIView.animate(withDuration: 1.5, delay: 2.5, usingSpringWithDamping: 3, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: ({
            self.cityMinLabel.frame = CGRect(x: self.view.frame.height/2, y: self.view.frame.width/2, width: 37.5, height: 65)
            self.cityMinLabel.alpha = 1
            
            
        }), completion: {(Bool) in
            self.rainAnimation()
        })
        
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 3, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: ({
                self.cityDescriptionImageView.frame = CGRect(x: (self.view.frame.width/2) - 80, y: (self.view.frame.height/4) - 30, width: 150, height: 150)
    
        }), completion: {(Bool) in
                self.rainAnimation()
            })
        
        

        
        
        switch cityDescription {
        case "Clouds":
            //clouds
            cityDescriptionImageView.image = #imageLiteral(resourceName: "clouds-2")
            //rainAnimation()
        case "overcast clouds":
            //overcast clouds
            cityDescriptionImageView.image = #imageLiteral(resourceName: "clouds-2")
            //rainAnimation()
        case "Sky is Clear":
            //clear
            cityDescriptionImageView.image = #imageLiteral(resourceName: "Sun")
            //iconAnimation(view: #imageLiteral(resourceName: "Sun"))
        case "broken clouds":
            //
            cityDescriptionImageView.image = #imageLiteral(resourceName: "cloudSun")
            //iconAnimation(view: #imageLiteral(resourceName: "cloudSun"))
        case "light rain":
            //
            cityDescriptionImageView.image = #imageLiteral(resourceName: "cloudsunRain")
            //iconAnimation(view: #imageLiteral(resourceName: "cloudsunRain"))
        default:
            cityDescriptionImageView.image = #imageLiteral(resourceName: "clouds-2")
            //rainAnimation()
        }
        
        self.title = cityName
        cityMinLabel.text = cityMin + " " + "℃"
        cityMaxLabel.text = cityMax + " " + "℃"
        
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    func alphaAnimation(image:UIImageView){
        let alphaAnimation = CABasicAnimation(keyPath: "opacity")
        alphaAnimation.fromValue = 0
        alphaAnimation.toValue = 1
        
    }
    
    
    func rainAnimation(){
        //creates 10 views
        (0...60).forEach {(_) in
            let randomTime = drand48()*10
            DispatchQueue.main.asyncAfter(deadline: .now() + randomTime, execute: {
                self.iconAnimation(view: #imageLiteral(resourceName: "drop"))
            })
        }
        //blurringDegrees()
    }
    
    
    func blurringDegrees(){
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurView.effect = blurEffect
        blurView.frame = cityMaxLabel.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        cityMaxLabel.addSubview(blurView)
    }
    
    func handleTap(){
        //creates 10 views
        (0...10).forEach {(_) in
            iconAnimation(view: #imageLiteral(resourceName: "drop"))
        }
    }
    
    func iconAnimation(view: UIImage){
        
        let startPointX = ((self.cityDescriptionImageView.frame.midX + 20) - CGFloat(drand48() * 80))
        let startPointY = (self.cityDescriptionImageView.frame.midY + 20)
        
        let bezierA = CGPoint.init(x: startPointX + 100, y: startPointY + 100)
        let bezierB = CGPoint.init(x: startPointX - 100, y: startPointY + 60)
        
        let path = Path.curvedHorizontalPath(startPoint: CGPoint.init(x:startPointX, y: startPointY), endPoint: CGPoint.init(x: startPointX , y: self.view.frame.height + 10), bezierPointA: bezierA, bezierPointB: bezierB, randomnessAdd: 200, randomnessMultiplier: 100)
        
        Animation.animationParticles(view: self.view, view1: view, view2: view, viewRandomnessBalance: 0.5, viewDimensionRandomnessAdd: 10, viewDimensionsRandomnessMultiplier: 10, durationRandomnessAdd: 2, durationRandomnessMultiplier: 3, path: path)
        
    }
    //Used to display In Loco's Ad
    
//    override func viewWillDisappear(_ animated: Bool) {
//        NotificationCenter.default.post(name: Notification.Name("GoingBackFromDetailViewController"), object: nil)
//    }

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
