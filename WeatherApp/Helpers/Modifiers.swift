//
//  Modifiers.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 07/11/2020.
//

import SwiftUI

struct ShadowModifer: ViewModifier {
    
    func body(content: Content) -> some View {
        content
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
            .shadow(color: Color.white, radius: 1, x: 0, y: 1)
    }
    
    
}
