//
//  CityWeather.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 12/11/2020.
//

import SwiftUI

struct CityWeather {
    
    private var _cityName: String!
    private var _temperature: Double!
    private var _weatherType: String!
    private var _weatherIcon: String!
    
    init() {
        //empty init
    }
    
    var cityName: String {
        get {
            return _cityName ?? ""
        }
        set {
            _cityName = newValue
        }
    }
    var temperature: Double {
        get {
            return _temperature ?? 0.0
        }
        set {
            _temperature = newValue
        }
    }
    var weatherType: String {
        get {
            return _weatherType ?? ""
        }
        set {
            _weatherType = newValue
        }
    }
    var weatherIcon: String {
        get {
            return _weatherIcon ?? ""
        }
        set {
            _weatherIcon = newValue
        }
        
    }
    
    
}

