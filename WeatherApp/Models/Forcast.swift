//
//  Forcast.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 09/11/2020.
//

import SwiftUI

struct Forcast:  Identifiable, Hashable {
    let id = UUID()
    
    private var _weatherIcon: String!
    private var _day: String!
    private var _weatherType: String!
    private var _minTemperature: Double!
    private var _maxTemperature: Double!
    
    init() {
        //emty init
    }
    var weatherIcon:String {
        get {
            return _weatherIcon
        }
        set {
            _weatherIcon = newValue
        }
    }
    
    var day:String {
        get {
            return _day
        }
        set {
            _day = newValue
        }
    }
    
    var weatherType:String {
        get {
            return _weatherType
        }
        set {
            _weatherType = newValue
        }
    }
    
    var minTemperature:Double {
        get {
            return _minTemperature
        }
        set {
            _minTemperature = newValue
        }
    }
    var maxTemperature:Double {
        get {
            return _maxTemperature
        }
        set {
            _maxTemperature = newValue
        }
    }
    
    
}
