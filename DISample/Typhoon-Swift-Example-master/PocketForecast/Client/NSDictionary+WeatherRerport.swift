////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Typhoon Framework Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

import Foundation

extension NSDictionary {
   
    public func parseError() -> NSError? {
        
        if let errors = self.value(forKeyPath: "data.error") as? NSArray {
            if let errorDict = errors[0] as? NSDictionary {
                if let message = errorDict["msg"] as? String {
                    return NSError(message: message)
                }
            }
        }
        return nil;
    }
    
    
    public func toWeatherReport() -> WeatherReport {
        
        let city = self.valueForKeyPath("data.request.query")![0] as! String
        
        
        let currentConditions = (self.valueForKeyPath("data.current_condition")![0] as! NSDictionary).toCurrentConditions()
        var forecastConditions : Array<ForecastConditions> = []
        for item in self.value(forKeyPath: "data.weather") as! NSArray {
            forecastConditions.append((item as AnyObject).toForecastConditions())
        }
        return WeatherReport(city: city, date: NSDate(), currentConditions: currentConditions, forecast: forecastConditions)
    }
    
    public func toCurrentConditions() -> CurrentConditions {
        
        let summary = self.valueForKeyPath("weatherDesc")![0]["value"] as! String
        let temperature = Temperature(fahrenheitString: self.value(forKeyPath: "temp_F") as! String)
        let humidity = self.value(forKeyPath: "humidity") as! String
        let wind = String(format: "Wind: %@ km %@", self.value(forKeyPath: "windspeedKmph") as! String,
            self.value(forKeyPath: "winddir16Point") as! String)
        let imageUri = self.valueForKeyPath("weatherIconUrl")![0]["value"] as! String
        
        return CurrentConditions(summary: summary, temperature: temperature, humidity: humidity, wind: wind, imageUri: imageUri)
    }
    
    public func toForecastConditions() -> ForecastConditions {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let date = formatter.date(from: self.value(forKeyPath: "date") as! String)!
        
        var low: Temperature?
        if self.value(forKeyPath: "tempMinF") != nil {
            low = Temperature(fahrenheitString: self.value(forKey: "tempMinF") as! String)
        }
                
        var high: Temperature?
        if self.value(forKey: "tempMaxF") != nil {
           high = Temperature(fahrenheitString: self.value(forKey: "tempMaxF") as! String)
        }
        
        var description = ""
        if self.value(forKeyPath: "weatherDesc") != nil {
          description = self.valueForKeyPath("weatherDesc")![0]["value"] as! String
        }
        
        var imageUri = ""
        if self.value(forKeyPath: "weatherIconUrl") != nil {
            imageUri = self.valueForKeyPath("weatherIconUrl")![0]["value"] as! String
        }
        
        return ForecastConditions(date: date as NSDate, low: low, high: high, summary: description, imageUri: imageUri)
    }
    
}

