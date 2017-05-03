//
//  WeatherClientTest.swift
//  DISample
//
//  Created by DMI on 03/05/17.
//  Copyright © 2017 DMI. All rights reserved.
//

import XCTest
import Typhoon

@testable import DISample

class WeatherClientTest: XCTestCase {
    
    var weatherClient: WeatherClient!
    
    override func setUp()
    {
        super.setUp()
        
        let assembly = ApplicationAssembly().activated()
       
        let configurer = TyphoonConfigPostProcessor()
        configurer.useResource(withName: "Configuration.plist")
        assembly.attachDefinitionPostProcessor(postProcessor: configurer)

        self.weatherClient = assembly.coreAssembly.weatherClient() as! WeatherClient
    }
    
    
    public func test_weatherReport_for_a_city()
    {
        var receivedReport: WeatherReport?
        
        self.weatherClient.loadWeatherReportFor(city: "Noida", onSuccess:
        {
            (weatherReport) in
            
            receivedReport = weatherReport
            
        }, onError:
        {
            (message) in
            print("Unexpected error: " + message!)
        })
        
        /*
         * Provides a utility for performing asynchronous integration tests with Typhoon. If a method dispatches on a background thread or queue,
         * and responds via a block or delegate, this class can be used to test the the expected response occurred.
         */
        
        TyphoonTestUtils.wait( forCondition: { () -> Bool in
            return receivedReport != nil
        }, andPerformTests: {
            print(String(format: "Got report: %@", receivedReport!))
            
        })
    
    }
    
    override func tearDown() {
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
