//
//  DISampleTests.swift
//  DISampleTests
//
//  Created by DMI on 27/04/17.
//  Copyright © 2017 DMI. All rights reserved.
//

import XCTest
@testable import DISample

class DISampleTests: XCTestCase {
    
    var cityInfo: CityInfo!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let assembly = ApplicationAssembly().activated()
        self.cityInfo = assembly.coreAssembly.cityInfo() as! CityInfo
    }
    
    public func test_it_lists_cities()
    {
        let cities = self.cityInfo.listAllCities()
        XCTAssertTrue((cities?.count)! > 0)
    }
    
    public func test_for_adding_city()
    {
        self.cityInfo.saveCity(name: "calcutta")
        
        let cities: [String] = self.cityInfo.listAllCities() as! [String]
        
        XCTAssert(cities.filter{$0 == "calcutta"}.count == 1)
    }
    
    override func tearDown()
    {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
