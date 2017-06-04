//
//  WeatherAroundInLocoTests.swift
//  WeatherAroundInLocoTests
//
//  Created by Breno Ramos on 04/06/17.
//  Copyright © 2017 brenor2. All rights reserved.
//

import XCTest
@testable import WeatherAroundInLoco

class WeatherAroundInLocoTests: XCTestCase {
    
    func testHelloWorld(){
        var helloWorld : String?
        
        XCTAssertNil(helloWorld)
        
        helloWorld = "hello World"
        
        XCTAssertEqual(helloWorld, "hello World")
    }
}
