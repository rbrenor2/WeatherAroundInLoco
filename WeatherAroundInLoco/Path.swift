//
//  Path.swift
//  WeatherAroundInLoco
//
//  Created by Breno Ramos on 03/06/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import UIKit

class Path: NSObject {
    
    class func curvedHorizontalPath(startPoint: CGPoint, endPoint: CGPoint, bezierPointA: CGPoint, bezierPointB: CGPoint, randomnessAdd: Double, randomnessMultiplier:Double) -> CGPath{
        //create the curved view
        
        //A UIBezierPath is a line that can be curved using the concept of two anchor points that break the line and turn it into a curve
        let path = UIBezierPath()
        
        //Sets a starting point to the line moving it
        path.move(to: CGPoint(x: startPoint.x, y: startPoint.y))
        
        //Sets a endpont to the line. OBS.: the endpoints will give the line inclination too.
        let endpoint = CGPoint(x: endPoint.x, y: endPoint.y)
        
        //Creates a line that starts at 0,200 and goest to 200,200
        //path.addLine(to: endpoint)
        //Creates a curve that starts at 0,200 and goes to endpoint, but now with 2 control points to shape the curve
        //adding some randomness
        let randomYShift = randomnessAdd + drand48() * randomnessMultiplier
        let cp1 = CGPoint(x: bezierPointA.x, y: bezierPointA.y - CGFloat(randomYShift))
        let cp2 = CGPoint(x: bezierPointB.x, y: bezierPointB.y + CGFloat(randomYShift))
        
        path.addCurve(to: endpoint, controlPoint1: cp1, controlPoint2: cp2)
        
        return path.cgPath
    }
    
    
    

}
