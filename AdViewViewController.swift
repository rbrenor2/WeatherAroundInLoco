//
//  AdViewViewController.swift
//  WeatherAroundInLoco
//
//  Created by Breno Ramos on 13/01/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit
import InLocoMediaAPI


//- (void)ilmAdViewWillLeaveApplication:(ILMAdView *)adView;
//- (BOOL)ilmAdViewWillPerformClick:(ILMAdView *)adView;
//- (void)ilmAdViewExpanded:(ILMAdView *)adView;
//- (void)ilmAdViewResized:(ILMAdView *)adView;

//- (void)presentFromViewController:(UIViewController *)viewController;


class AdViewViewController: UIViewController, ILMInterstitialAdDelegate {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var interstitialAdView: ILMAdView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        //
        self.interstitialAdView.refreshInterval()
    }
    
    func createAd(){
        let ad = ILMInterstitialAd()
        ad.delegate = self
        ad.load()
    }
    
    func ilmInterstitialAdDidReceive(_ interstitialAd: ILMInterstitialAd!) {
        self.navigationController?.navigationBar.isHidden = true
        self.activityIndicator.isHidden = true
        self.activityIndicator.stopAnimating()
        interstitialAd.present()
        print("#1 - ilmInterstitialAdDidReceive - ad presented")

    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.createAd()
    }
    
    func ilmInterstitialAdDidDisappear(_ interstitialAd: ILMInterstitialAd!) {
        self.navigationController?.navigationBar.isHidden = false
        self.dismiss(animated: true, completion: nil)
        print("#2 - ilmInterstitialAdDidDisappear - AdViewController dismissed")
    }
    
    func ilmInterstitialAd(_ adView: ILMInterstitialAd!, didFailToReceiveAdWithError error: ILMError!) {
        self.dismiss(animated: true, completion: nil)
        print("#3 - didFailToReceiveAdWithError - AdViewController dismissed")
    }
    
    func ilmInterstitialAdViewWillLeaveApplication(_ interstitialAd: ILMInterstitialAd!) {
        
        print("#4 - ilmInterstitialAdViewWillLeaveApplication - AdViewController dismissed")
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
