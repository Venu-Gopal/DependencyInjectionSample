// WeatherReportDaoFileSystemImpl.swift
//  DISample
//
//  Created by DMI on 27/04/17.
//  Copyright © 2017 DMI. All rights reserved.


import Foundation

public class WeatherReportDaoFileSystemImpl : NSObject, WeatherReportDao {
    
    public func getReportForCityName(cityName: String!) -> WeatherReport? {
        
        let filePath = self.filePathFor(cityName: cityName)
        let weatherReport : WeatherReport? = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? WeatherReport
        return weatherReport
    }
    
    public func saveReport(weatherReport: WeatherReport!) {
        
        NSKeyedArchiver.archiveRootObject(weatherReport, toFile: self.filePathFor(cityName: weatherReport.cityDisplayName))
    }

    
    private func filePathFor(cityName : String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0] 
        let weatherReportKey = String(format: "weatherReport~>$%@", cityName)
        let filePath = documentsDirectory.appendingFormat(weatherReportKey)
        return filePath
    }
}
