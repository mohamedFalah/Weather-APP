//
//  Extesnion.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 09/11/2020.
//

import Foundation
import SwiftUI
import UIKit

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


extension Double {
   // return celsius from kelvin temp
    mutating func convertKelvinToCelcius() -> Double {
        let K = self
        let C = K - 273.15
        return C
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: self, for: nil)
    }
}
#endif
