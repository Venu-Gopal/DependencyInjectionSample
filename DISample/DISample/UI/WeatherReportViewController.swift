//  WeatherReportViewController.swift
//  DISample
//
//  Created by DMI on 27/04/17.
//  Copyright © 2017 DMI. All rights reserved.


import UIKit

public class WeatherReportViewController: UIViewController
{
    public private(set) var weatherClient : WeatherClient
    public private(set) var weatherReportDao : WeatherReportDao
    public private(set) var cityInfo : CityInfo
    public private(set) var assembly : ApplicationAssembly
    
    private var cityName : String?
    private var weatherReport : WeatherReport?
    
    @IBOutlet var lblCity: UILabel!
    @IBOutlet var lblWind: UILabel!
    @IBOutlet var lblTemp: UILabel!
    @IBOutlet var txtView: UITextView!
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Initialization & Destruction
    //-------------------------------------------------------------------------------------------
    
    public dynamic init(weatherClient : WeatherClient,
                        weatherReportDao : WeatherReportDao,
                        cityInfo : CityInfo,
                        assembly : ApplicationAssembly)
    {
        
        self.weatherClient = weatherClient
        self.weatherReportDao = weatherReportDao
        self.cityInfo = cityInfo
        self.assembly = assembly
        self.cityName  = cityInfo.loadSelectedCity()
            
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //-------------------------------------------------------------------------------------------
    // MARK: - Overridden Methods
    //-------------------------------------------------------------------------------------------
    
    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.isNavigationBarHidden = false

        if (self.cityName != nil)
        {
            self.weatherReport = self.weatherReportDao.getReportForCityName(cityName: self.cityName)
            
            if (self.weatherReport != nil)
            {
                lblCity.text = weatherReport?.city
                lblWind.text = weatherReport?.currentConditions.wind
                lblTemp.text = weatherReport?.currentConditions.temperature?.inCelcius().stringValue
                
                txtView.text = weatherReport?.currentConditions.longSummary()
            }
            else if (self.cityName != nil) {
                self.refreshData()
            }
        }
    }

    public override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
    }

    
    public override func viewWillDisappear(_ animated: Bool) {
        self.navigationController!.isNavigationBarHidden = false
        super.viewWillDisappear(animated)
    }
    
    private dynamic func refreshData()
    {
        self.weatherClient.loadWeatherReportFor(city: self.cityName, onSuccess: {
            (weatherReport) in
            
        }, onError:
        {
            (message) in
        })
    }
    
    @IBAction func myAdd(sender: Any)
    {
        let name: String = sender as! String
        
        self.cityInfo.saveCity(name: name)
    }

}
