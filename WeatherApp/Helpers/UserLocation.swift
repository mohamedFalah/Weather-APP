//
//  UserLocation.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 11/11/2020.
//

import Foundation

class UserLocation {
    
    static let sharedInstance = UserLocation()
    private init () {
        
    }
    var userLatitude: Double!
    var userLongitude: Double!
    
    
    
}
