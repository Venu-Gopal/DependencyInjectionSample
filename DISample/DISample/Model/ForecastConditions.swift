////////////////////////////////////////////////////////////////////////////////
//
//
////////////////////////////////////////////////////////////////////////////////

import Foundation

public class ForecastConditions : NSObject, NSCoding {

	private(set) var date : NSDate?
    private(set) var low : Temperature?
	private(set) var high : Temperature?
	private(set) var summary : String?
	private(set) var imageUri : String?
    
    public init(date : NSDate, low : Temperature?, high : Temperature?, summary : String, imageUri : String) {
        self.date = date
        self.low = low
        self.high = high
        self.summary = summary
        self.imageUri = imageUri
    }
    
    public required init?(coder : NSCoder) {
        self.date = coder.decodeObject(forKey: "date") as? NSDate
        self.low = coder.decodeObject(forKey: "low") as? Temperature
        self.high = coder.decodeObject(forKey: "high") as? Temperature
        self.summary = coder.decodeObject(forKey: "summary") as? String
        self.imageUri = coder.decodeObject(forKey: "imageUri") as? String
    }
    
    public func longDayOfTheWeek() -> String? {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter.string(from: self.date! as Date)
    }
    
    public override var description: String {
        if self.low != nil && self.high != nil {
            return String(format: "Forecast : day=%@, low=%@, high=%@", self.longDayOfTheWeek()!, self.low!, self.high!)
        } else {
            return String(format: "Forecast : day=%@, low=%@, high=%@", self.longDayOfTheWeek()!, "", "")
        }
    }
    
     public func encode(with aCoder: NSCoder)
     {
        aCoder.encode(self.date!, forKey:"date")
        aCoder.encode(self.low, forKey:"low")
        aCoder.encode(self.high, forKey:"high")
        aCoder.encode(self.summary!, forKey:"summary")
        aCoder.encode(self.imageUri!, forKey:"imageUri")
    }
    
}
