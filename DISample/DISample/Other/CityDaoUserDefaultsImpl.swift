// CityDaoUserDefaultsImpl.swift
//  DISample
//
//  Created by DMI on 27/04/17.
//  Copyright © 2017 DMI. All rights reserved.


import Foundation

public class CityDaoUserDefaultsImpl : NSObject, CityInfo
{
    var defaults : UserDefaults
    let citiesListKey = "pfWeather.cities"
    let currentCityKey = "pfWeather.currentCityKey"
    
    let defaultCities = [
        "Noida",
        "Delhi",
        "Punjab",
        "Haryana",
        "Dehradoon"
    ]
    
    
    init(defaults : UserDefaults) {
        self.defaults = defaults
    }
    
    public func listAllCities() -> [AnyObject]!
    {
        var cities : NSArray? = self.defaults.array(forKey: self.citiesListKey) as NSArray?
        if (cities == nil) {
            cities = defaultCities as NSArray?;
            self.defaults.set(cities, forKey:self.citiesListKey)
        }
        return cities as [AnyObject]!
    }
    
    public func saveCity(name: String!) {

//        let trimmedName = name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        let trimmedName = name.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        var savedCities : Array? = self.defaults.array(forKey: self.citiesListKey)
        if (savedCities == nil) {
            savedCities = defaultCities
        }
        
        let cities = NSMutableArray(array: savedCities!)
        
        var canAddCity = true
        for city in cities {
            if ((city as AnyObject).lowercased == trimmedName.lowercased()) {
                canAddCity = false
            }
        }
        if (canAddCity) {
            cities.add(trimmedName)
            self.defaults.set(cities, forKey: self.citiesListKey)
        }
    }
    
    public func deleteCity(name: String!) {
        
//        let trimmedName = name.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        let trimmedName = name.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        let cities = NSMutableArray(array: self.defaults.array(forKey: self.citiesListKey)!)
        var cityToRemove : String?
        for city in cities {
            if ((city as AnyObject).lowercased == trimmedName.lowercased()) {
                cityToRemove = city as? String
            }
        }
        if (cityToRemove != nil)
        {
            cities.remove(cityToRemove!)
        }

        self.defaults.set(cities, forKey: self.citiesListKey)
    }
    
    public func saveCurrentlySelectedCity(cityName: String!) {
        
//        let trimmed = cityName.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        let trimmed = cityName.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if (!trimmed.isEmpty) {
            self.defaults.set(trimmed, forKey: self.currentCityKey)
        }
    }
    
    
    public func clearCurrentlySelectedCity() {
        
        self.defaults.set(nil, forKey: self.currentCityKey)
        
    }
    
    public func loadSelectedCity() -> String? {
        return self.defaults.object(forKey: self.currentCityKey) as? String
    }

    
}
