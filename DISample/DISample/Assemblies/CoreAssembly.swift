//
//  CoreAssembly.swift
//  DISample
//
//  Created by DMI on 28/04/17.
//  Copyright © 2017 DMI. All rights reserved.
//

import Typhoon

public class CoreAssembly: TyphoonAssembly
{
    public dynamic func weatherClient() -> Any
    {
        return TyphoonDefinition.withClass(WeatherClientBasicImpl.self)
        {
            (definition) in
            definition?.injectProperty(Selector(("serviceUrl")), with:TyphoonConfig("service.url"))
            definition?.injectProperty(Selector(("apiKey")), with:TyphoonConfig("api.key"))
            definition?.injectProperty(#selector(CoreAssembly.weatherReportDao), with:self.weatherReportDao())
            definition?.injectProperty(Selector(("daysToRetrieve")), with:TyphoonConfig("days.to.retrieve"))
        }
    }
    
    public dynamic func weatherReportDao() -> Any
    {
        return TyphoonDefinition.withClass(WeatherReportDaoFileSystemImpl.self)
    }
    
    public dynamic func cityDao() -> Any
    {
        return TyphoonDefinition.withClass(CityDaoUserDefaultsImpl.self) {
            (definition) in
            
            definition!.useInitializer(Selector(("initWithDefaults:")))
            {
                (initializer) in
                
                initializer!.injectParameter(with: UserDefaults.standard)
            }
        }
    }
    
    public dynamic func getCityListFromApi() -> NSArray
    {
         return ["Noida", "Delhi", "Punjab"]
    }
}
