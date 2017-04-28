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

public class WeatherClientBasicImpl: NSObject, WeatherClient {

    var weatherReportDao: WeatherReportDao?
    var serviceUrl: NSURL?
    var daysToRetrieve: NSNumber?

    var apiKey: String? {
        willSet(newValue) {
            assert(newValue != "$$YOUR_API_KEY_HERE$$", "Please get an API key (v2) from: http://free.worldweatheronline.com, and then " +
                    "edit 'Configuration.plist'")
        }
    }

    public func loadWeatherReportFor(city: String!, onSuccess successBlock: ((WeatherReport?) -> Void)!, onError errorBlock: ((String?) -> Void)!) {

        /*
        dispatch_async(DispatchQueue.global(DISPATCH_QUEUE_PRIORITY_HIGH, 0))
        {
            let url = self.queryURL(city)
            let data : NSData! = NSData(contentsOfURL: url)!
            
            let dictionary = (try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary

            if let error = dictionary.parseError() {
                dispatch_async(dispatch_get_main_queue()) {
                    errorBlock(error.rootCause())
                    return
                }
            }
            else
            {
                let weatherReport: WeatherReport = dictionary.toWeatherReport()
                self.weatherReportDao!.saveReport(weatherReport)
                dispatch_async(dispatch_get_main_queue()) {
                    successBlock(weatherReport)
                    return
                }
            }
        }
         */
        
        if #available(iOS 8.0, *)
        {
            DispatchQueue.global(qos: .default).async
            {
                let url = self.queryURL(city: city)
                let data : NSData! = NSData(contentsOf: url as URL)!
                
                let dictionary = (try! JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers)) as! NSDictionary
                
                if let error = dictionary.parseError() {
                    DispatchQueue.main.async
                    {
                        errorBlock(error.rootCause())
                        return
                    }
                }
                else
                {
                    let weatherReport: WeatherReport = dictionary.toWeatherReport()
                    self.weatherReportDao!.saveReport(weatherReport: weatherReport)
                    DispatchQueue.main.async
                    {
                        successBlock(weatherReport)
                        return
                    }
                }
            }
        }
        else
        {
            // Fallback on earlier versions
        }
        
    }

    private func queryURL(city: String) -> NSURL
    {
        let serviceUrl: NSURL = self.serviceUrl!
        let url: NSURL = serviceUrl.uq_URL(byAppendingQueryDictionary: [
                "q": city,
                "format": "json",
                "num_of_days": daysToRetrieve!.stringValue,
                "key": apiKey!
        ]) as NSURL

        return url
    }
}
