// ThemeFactory.swift
//  DISample
//
//  Created by DMI on 27/04/17.
//  Copyright © 2017 DMI. All rights reserved.

import Foundation

public class ThemeFactory : NSObject {
    
    private var _sequentialTheme : Theme?
    private(set) var themes : Array<Theme>
    
    init(themes : Array<Theme>) {
        self.themes = themes
        assert(themes.count > 0, "ThemeFactory requires at least one theme in collection")
    }
    
    public func sequentialTheme() -> Theme {
        if (_sequentialTheme == nil) {
            
            let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
            let documentsDirectory : NSString = paths[0] as NSString!
            let indexFileName = documentsDirectory.appendingPathComponent("PF_CURRENT_THEME_INDEX")
            var index = (try? NSString(contentsOfFile: indexFileName, encoding: String.Encoding.utf8.rawValue))?.integerValue
            if (index == nil || index! > themes.count - 1) {
                index = 0
            }
            _sequentialTheme = themes[index!]
            do {
                try NSString(format: "%i", (index! + 1)).write(toFile: indexFileName, atomically: false, encoding: String.Encoding.utf8.rawValue)
            } catch _ {
            }
        }
        return _sequentialTheme!
    }
    

    
}
