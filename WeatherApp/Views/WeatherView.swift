//
//  ContentView.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 07/11/2020.
//

import SwiftUI

let screen = UIScreen.main.bounds

struct WeatherView: View {
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack {
                Color(#colorLiteral(red: 0, green: 0.6941176471, blue: 0.8235294118, alpha: 1))
                
                HStack {
                    VStack(alignment: .leading, spacing: 60){
                        Text("Today, 7 November, 2020")
                            .font(.title)
                            .foregroundColor(Color.white.opacity(0.97))
                            .modifier(ShadowModifer())
                        Text("26°")
                            .font(.system(size: 56, weight: .bold))
                            .foregroundColor(Color.white.opacity(0.97))
                            .modifier(ShadowModifer())
                        Text("Al Qatif")
                            .font(.title)
                            .foregroundColor(Color.white.opacity(0.97))
                            .modifier(ShadowModifer())
                        
                    }
                    .padding()

                    VStack {
                        Spacer()
                        Image(systemName: "cloud.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.white.opacity(0.97))
                            .modifier(ShadowModifer())
                        Text("Cloudy")
                            .font(.title)
                            .foregroundColor(Color.white.opacity(0.97))
                            .modifier(ShadowModifer())
                        
                    }
                    .padding()

                }
            }
            .frame(height: screen.height/2)

            
            
            VStack {
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(1..<5) { _ in
                        DaysWeatherCard()
                    }
                }
            }
            .padding(.top, 5)
            .padding(.bottom, 10)
            .frame(height: screen.height/2)

            
        }.edgesIgnoringSafeArea(.all)
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
