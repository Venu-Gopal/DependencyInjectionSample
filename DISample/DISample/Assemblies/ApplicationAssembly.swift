//
//  ApplicationAssembly.swift
//  DISample
//
//  Created by DMI on 27/04/17.
//  Copyright © 2017 DMI. All rights reserved.
//

import Typhoon

public class ApplicationAssembly:TyphoonAssembly
{
    dynamic var coreAssembly: CoreAssembly!
    
    /*
     * This is the definition for our AppDelegate. Typhoon will inject the specified properties
     * at application startup.
     */
    public dynamic func appDelegate() -> Any
    {
        return TyphoonDefinition.withClass(AppDelegate.self) {
            (definition) in
            
            
            definition!.injectProperty(#selector(ApplicationAssembly.rootViewController), with: self.rootViewController())
        }
    }
    
    public dynamic func rootViewController() -> Any
    {
        return TyphoonDefinition.withClass(RootViewController.self) {
            (definition) in
            
            definition?.useInitializer(Selector(("initWithAssembly:arrCityData:weatherReportVC:")))
                        {
                            // Injecting with initilizer:
                            
                            (initializer) in
                            initializer?.injectParameter(with:self) // initWithwithAssembly:
                            initializer?.injectParameter(with:self.cityListArr()) // arrCityData:
                            initializer?.injectParameter(with: self.weatherReportController())
                        }
            
            // Injecting with property:
            
//            definition?.injectProperty(#selector(setter: RootViewController.cityInfo), with: self.coreAssembly.cityInfo())
            
            definition?.injectProperty(Selector(("cityInfo")), with: self.coreAssembly.cityInfo())
            
            definition!.scope = TyphoonScope.singleton
        }
    }


    public dynamic func cityListArr() -> NSArray
    {
        return ["Noida", "Delhi", "Punjab"]
    }
    
    public dynamic func weatherReportController() -> Any
    {
        return TyphoonDefinition.withClass(WeatherReportViewController.self) {
            (definition) in
            definition!.useInitializer(Selector(("initWithWeatherClient:weatherReportDao:cityInfo:assembly:")))
            {
                (initializer) in
    
                initializer?.injectParameter(with: self.coreAssembly.weatherClient())
                initializer?.injectParameter(with: self.coreAssembly.weatherReportDao())
                initializer?.injectParameter(with: self.coreAssembly.cityInfo())
                initializer?.injectParameter(with: self)
            }
        };
    }
    
    /*
     * A config definition, referencing properties that will be loaded from a plist.
     */
    
    public dynamic func config() -> Any
    {
        return TyphoonDefinition.withConfigName("Configuration.plist")
    }
    
}
