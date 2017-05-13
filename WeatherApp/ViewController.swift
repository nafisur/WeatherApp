//
//  ViewController.swift
//  WeatherApp
//
//  Created by Nafisur Ahmed on 13/05/17.
//  Copyright © 2017 Nafisur Ahmed. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    var baseURL = "http://api.openweathermap.org/data/2.5/weather?q="
    var getAPI = "&appid="
    var api = "7d63c29153c21972ac3c2603a9af20f5"
    
    
    @IBOutlet weak var CityText: UITextField!
    
    
    @IBOutlet weak var Temp: UILabel!
    @IBOutlet weak var Weather: UILabel!
    @IBOutlet weak var WeatherButton: UIButton!
    
    var tempar = 0.0
    var weatherType = ""
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherButton.layer.cornerRadius = 10.0
        WeatherButton.isEnabled = false
    }
    
    @IBAction func WeatherTapped(_ sender: Any) {
        
        let runningURL = "\(baseURL)\(CityText.text!)\(getAPI)\(api)"
        Alamofire.request(runningURL).responseJSON { (response) in
            
            let result = response.result
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let main = dict["main"] as? Dictionary<String, AnyObject> {
                    
                    if let webTemp = main["temp"] as? Double {
                        
                        self.tempar = webTemp - 273.15
                        self.Temp.text = "Temparature is : \(self.tempar)"
                    }
                }
            }
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                
                
                if let webWeather = dict["weather"]?[0] as? Dictionary<String, AnyObject> {
                    if let webMain=webWeather["main"] as? String {
                        
                        self.weatherType = webMain
                        self.Weather.text = "Weather Type is : \(self.weatherType)"
                    }
                    
                }
            }
        }
    }
    
    @IBAction func TextFieldChanged(_ sender: Any) {
        
        if (CityText.text?.characters.count)! > 0 {
            
            WeatherButton.isEnabled = true
        }
        else {
            
            WeatherButton.isEnabled = false
        }
    }
    
}


