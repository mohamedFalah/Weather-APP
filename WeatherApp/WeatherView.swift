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
        
        VStack {
            ZStack {
                Color(#colorLiteral(red: 0.3219612935, green: 0.8010270506, blue: 0.9294446244, alpha: 1))
                
                HStack {
                    VStack(alignment: .leading, spacing: 60){
                        Text("Today, 7 November, 2020")
                            .font(.title)
                            .foregroundColor(Color.white.opacity(0.97))
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                            .shadow(color: Color.white, radius: 1, x: 0, y: 1)
                        Text("26°")
                            .font(.system(size: 56, weight: .bold))
                            .foregroundColor(Color.white.opacity(0.97))
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                            .shadow(color: Color.white, radius: 1, x: 0, y: 1)
                        Text("Al Qatif")
                            .font(.title)
                            .foregroundColor(Color.white.opacity(0.97))
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                            .shadow(color: Color.white, radius: 1, x: 0, y: 1)
                        
                    }
                    .padding()

                    VStack {
                        Spacer()
                        Image(systemName: "cloud.fill")
                            .font(.largeTitle)
                            .foregroundColor(Color.white.opacity(0.97))
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                            .shadow(color: Color.white, radius: 1, x: 0, y: 1)
                        Text("Cloudy")
                            .font(.title)
                            .foregroundColor(Color.white.opacity(0.97))
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                            .shadow(color: Color.white, radius: 1, x: 0, y: 1)
                        
                    }
                    .padding()

                }
                
                
            }
            .frame(height: screen.height/2)
            .edgesIgnoringSafeArea(.all)
            
    
            Spacer()
            
            
            
        }
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
