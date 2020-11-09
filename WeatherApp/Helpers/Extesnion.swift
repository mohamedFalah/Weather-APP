//
//  Extesnion.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 09/11/2020.
//

import Foundation


extension Date {
    //return the day of the week
    func getDayOfTheWeek () -> String {
        let dateFormatter = DateFormatter()
        //Wednesday, Sep 12, 2018 --> EEEE, MMM d, yyyy
        //Wed, Sep 12, 2018 --> E, MMM d, yyyy
        dateFormatter.dateFormat = "E"
        return dateFormatter.string(from: self)
    }
    
}
