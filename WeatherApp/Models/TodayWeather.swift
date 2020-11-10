//
//  TodayWeather.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 08/11/2020.
//

import SwiftUI

struct TodayWeather {
    
    private var _cityName: String!
    private var _date: String!
    private var _weatherType: String!
    private var _currentTemperature: Double!
    private var _weatherIcon: String!
    private var _pressure: Double!
    private var _humidity: Double!
    private var _visibility: Double!
    private var _wind: Double!
    private var _feelsLike: Double!
    
    init(){
        //empty init
        //get today date
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        dateFormatter.timeStyle = .none
        let todayDate = dateFormatter.string(from: Date())
        _date = todayDate
    }
    
    var cityName: String {
        get {
            return _cityName ?? ""
        }
        set {
            _cityName = newValue
        }
    }
    
    var date: String {
        get {
            return _date ?? ""
        }
        set {
            _date = newValue
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
    var currentTemperature: Double {
        get {
            return _currentTemperature ?? 0.0
        }
        set {
            _currentTemperature = newValue
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
    var pressure: Double {
        get {
            return _pressure ?? 0.0
        }
        set {
            _pressure = newValue
        }
    }
    var humidity: Double {
        get {
            return _humidity ?? 0.0
        }
        set {
            _humidity = newValue
        }
    }
    var visibility: Double {
        get {
            return _visibility ?? 0.0
        }
        
        set {
            _visibility = newValue
        }
    }
    var wind: Double {
        get {
            return _visibility ?? 0.0
        }
        set {
            _visibility = newValue
        }
        
    }
    var feelsLike: Double {
        get {
            return _feelsLike ?? 0.0
        }
        set {
            _feelsLike = newValue
        }
        
    }
    
}
