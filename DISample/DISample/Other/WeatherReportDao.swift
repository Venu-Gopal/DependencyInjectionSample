//WeatherReportDao.swift
//  DISample
//
//  Created by DMI on 27/04/17.
//  Copyright © 2017 DMI. All rights reserved.


import Foundation

/*
* Weather report DAO (persistence) protocol.
* (Currently, injected protocols require the @objc annotation).
*/
@objc public protocol WeatherReportDao {
    
    func getReportForCityName(cityName: String!) -> WeatherReport?
    
    func saveReport(weatherReport: WeatherReport!)
        
}
