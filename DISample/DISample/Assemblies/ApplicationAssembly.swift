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
    public var coreAssemblyObject: CoreAssembly!
    
    /*
     * This is the definition for our AppDelegate. Typhoon will inject the specified properties
     * at application startup.
     */
    public dynamic func appDelegate() -> Any
    {
        return TyphoonDefinition.withClass(AppDelegate.self) {
            (definition) in
            
            //definition.injectProperty("cityDao", with: self.coreComponents.cityDao())
            definition!.injectProperty(#selector(ApplicationAssembly.rootViewController), with: self.rootViewController())
        }
    }
    
    public dynamic func rootViewController() -> Any
    {
        return TyphoonDefinition.withClass(RootViewController.self) {
            (definition) in
            
            definition?.useInitializer(Selector(("initWithAssembly:arrCityData:")))
                        {
                            // Injecting with initilizer:
                            
                            (initializer) in
                            initializer?.injectParameter(with:self) // initWithwithAssembly:
                            initializer?.injectParameter(with:self.cityListArr()) // arrCityData:
                        }
            
            // Injecting with property:
            //definition?.injectProperty(Selector(("cityListFromApi")), with: self.coreAssemblyObject.getCityListFromApi())
            
            definition?.injectProperty(Selector(("cityListFromApi")),
                                       with: self.coreAssemblyObject.getCityListFromApi())
            
            definition!.scope = TyphoonScope.singleton
        }
    }

    public dynamic func cityListArr() -> NSArray
    {
        return ["Noida", "Delhi", "Punjab"]
    }
    
    
    /*
     * A config definition, referencing properties that will be loaded from a plist.
     */
    public dynamic func config() -> Any
    {
        return TyphoonDefinition.withConfigName("Configuration.plist")
    }
    
}
