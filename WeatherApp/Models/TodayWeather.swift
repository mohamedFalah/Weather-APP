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
            return _weatherIcon
        }
        set {
            _weatherIcon = newValue
        }
    }
    
}
