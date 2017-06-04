//
//  Animation.swift
//  WeatherAroundInLoco
//
//  Created by Breno Ramos on 03/06/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit


class Animation: NSObject {
    class func animationParticles(view: UIView, view1: UIImage, view2: UIImage, viewRandomnessBalance: Double, viewDimensionRandomnessAdd: Double, viewDimensionsRandomnessMultiplier: Double, durationRandomnessAdd: Double, durationRandomnessMultiplier: Double, path: CGPath) {
        //adding the icons
        //adding randomness
        let image = drand48() > viewRandomnessBalance ? view1 : view2
        let imageView = UIImageView(image: image)
        //adding some randomness to the sizing
        let dimensions = viewDimensionRandomnessAdd + drand48() * viewDimensionsRandomnessMultiplier //drand48() returns a value between 0 and 1
        //sets the size and initial position of our imageView
        imageView.frame = CGRect(x: 0, y: 0, width: dimensions, height: dimensions)
        
        //animating imageview
        //creating the animation, a keyframeAnimation
        let animation = CAKeyframeAnimation(keyPath: "position")
        
        animation.path = path
        //adding some randomness
        animation.duration = durationRandomnessAdd + drand48() * durationRandomnessMultiplier
        animation.fillMode = kCAFillModeForwards //the animation receiver stays visible at the end state of the animation
        animation.isRemovedOnCompletion = false // the animation is not removed from the targets layers animation
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut) //defines the pacing of the animation, not linear, but as a curve --- the easeOut function accelerates in the beggining and slows down at the end
        
        imageView.layer.add(animation, forKey: nil)
        view.addSubview(imageView)
        view.sendSubview(toBack: imageView)
    }

}
