//
//  RootViewController.swift
//  DISample
//
//  Created by DMI on 27/04/17.
//  Copyright © 2017 DMI. All rights reserved.
//

import UIKit

public class RootViewController : UIViewController,
                                                    UITableViewDelegate,
                                                    UITableViewDataSource
{
    //Typhoon injected properties------------------------------------------
    // Its good practise not to expose properties untill required.

    private var assembly : ApplicationAssembly!
    private var arrCityList: NSArray?
    
    var cityListFromApi : NSArray?
    
     //public private(set) var cityInfo: CityInfo!
    
    var cityInfo:CityInfo!
   {
        didSet
        {
             cityListFromApi = self.cityInfo.listAllCities() as NSArray
        }
    }

    
    //Interface Builder injected properties-----------------------------
    @IBOutlet var citiesListTableView : UITableView!
    
    //-----------------------------------------------------------------------------------
    
    public init(withAssembly : ApplicationAssembly,
                arrCityData:NSArray)
    {
        super.init(nibName : nil, bundle : nil)
        self.assembly = withAssembly
        self.arrCityList = arrCityData
    }
    
    required public init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: UITableView Delegates:
    
    public func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        if (self.cityInfo != nil) {
            return self.cityInfo.listAllCities().count
        }
        return 0
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let reuseId = "Cities"
        
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: reuseId)
        
        if (cell == nil)
        {
            cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: reuseId)
        }
        
        cell!.selectionStyle = UITableViewCellSelectionStyle.gray
        cell!.textLabel?.font = UIFont.systemFont(ofSize: 16)
        cell!.textLabel?.textColor = UIColor.darkGray
        cell!.textLabel?.text = cityListFromApi?.object(at: indexPath.row) as? String
        
        cell!.accessoryType = UITableViewCellAccessoryType.disclosureIndicator
        
        return cell!
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //let cityName : String = cityListFromApi!.object(at: indexPath.row) as! String
        
        //NSLog(cityName)
       // cityDao.saveCurrentlySelectedCity(cityName)
    }
    
}
