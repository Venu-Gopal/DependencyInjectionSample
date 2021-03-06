////////////////////////////////////////////////////////////////////////////////
//
//
////////////////////////////////////////////////////////////////////////////////

import Foundation

public class WeatherReport : NSObject, NSCoding
{
    
    public private(set) var city : String
    public private(set) var date : NSDate
    public private(set) var currentConditions : CurrentConditions
    public private(set) var forecast : Array<ForecastConditions>
    
    public var cityDisplayName : String {
        var displayName : String
        let components : Array<String> = self.city.components(separatedBy:",")
        if (components.count > 1) {
            displayName = components[0]
        }
        else {
            displayName = self.city.capitalized
        }
        
        return displayName
    }
    
    
    public init(city : String, date : NSDate, currentConditions : CurrentConditions,
        forecast : Array<ForecastConditions>)
    {

        self.city = city
        self.date = date
        self.currentConditions = currentConditions
        self.forecast = forecast
    }
    
    public required init?(coder : NSCoder)
    {
        self.city = coder.decodeObject(forKey: "city") as! String
        self.date = coder.decodeObject(forKey: "date") as! NSDate
        self.currentConditions = coder.decodeObject(forKey: "currentConditions") as! CurrentConditions
        self.forecast = coder.decodeObject(forKey: "forecast") as! Array<ForecastConditions>
    }
    
    public func reportDateAsString() -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd',' yyyy 'at' hh:mm a"
        dateFormatter.locale = NSLocale.current
        return dateFormatter.string(from: self.date as Date)
    }
    
    public override var description: String
    {
        return String(format: "Weather Report: city=%@, current conditions = %@, forecast=%@", self.city, self.currentConditions, self.forecast )
    }
    
    public func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.city, forKey:"city")
        aCoder.encode(self.date, forKey:"date")
        aCoder.encode(self.currentConditions, forKey:"currentConditions")
        aCoder.encode(self.forecast, forKey:"forecast")
    }
}
