//
//  HomeView.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 10/11/2020.
//

import SwiftUI

struct HomeView: View {
    @State var Cancelled = true
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 1, green: 0.9440771983, blue: 0.9732110334, alpha: 1))
            WeatherView(searchCancelled: $Cancelled)
            
            SearchButtonView(Cancelled: $Cancelled)

        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

