////////////////////////////////////////////////////////////////////////////////
//
//
////////////////////////////////////////////////////////////////////////////////

import Foundation

public class CurrentConditions : NSObject, NSCoding {
    
    private(set) var summary : String?
    private(set) var temperature : Temperature?
    private(set) var humidity : String?
    private(set) var wind : String?
    private(set) var imageUri : String?
    
    public init(summary : String, temperature : Temperature, humidity : String, wind : String, imageUri : String) {
        self.summary = summary
        self.temperature = temperature
        self.humidity = humidity
        self.wind = wind
        self.imageUri = imageUri
    }
    
    public required init?(coder : NSCoder) {
        self.summary = coder.decodeObject(forKey: "summary") as? String
        self.temperature = coder.decodeObject(forKey: "temperature") as? Temperature
        self.humidity = coder.decodeObject(forKey: "humidity") as? String
        self.wind = coder.decodeObject(forKey: "wind") as? String
        self.imageUri = coder.decodeObject(forKey: "imageUri") as? String
    }
    
    public func longSummary() -> String {
        return String(format: "%@. %@.", self.summary!, self.wind!)
    }
    
    public override var description: String {
        return String(format: "Current Conditions: summary=%@, temperature=%@", self.summary!, self.temperature!)
    }
    
    public func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.summary!, forKey:"summary")
        aCoder.encode(self.temperature!, forKey:"temperature")
        aCoder.encode(self.humidity!, forKey:"humidity")
        aCoder.encode(self.wind!, forKey:"wind")
        aCoder.encode(self.imageUri!, forKey:"imageUri")
    }
}
