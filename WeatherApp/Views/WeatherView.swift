//
//  ContentView.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 07/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct WeatherView: View {
    
    @ObservedObject var weatherVM = WeatherViewModel()
    @State private var isLoaded = false
    @State private var currentWeatherTapped = false
    @State private var todayWeather = TodayWeather()
    
    @Binding var searchCancelled: Bool

    var body: some View {
        
        VStack(spacing: 0) {
            CurrentWeatherView(isLoaded: $isLoaded, currentWeatherTapped: $currentWeatherTapped, todayWeather: $todayWeather)
                .onAppear(perform: {
                    weatherVM.downloadTodayWeather {
                        self.isLoaded = true
                        self.todayWeather = weatherVM.todayWeather
                    }
                    
                })
                .onTapGesture {
                    currentWeatherTapped.toggle()
                }
            
            VStack {
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(weatherVM.fiveDaysforcast, id: \.self ) { day in
                            DaysWeatherCard(day: day)
                                //.animation(.easeOut(duration:0.1 ))
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                }
            }
            .frame(height: SCREEN.height/2)
            .transition(.move(edge: .bottom))
            .animation(.spring(response: 0.5, dampingFraction: 0.9, blendDuration: 0))
            .onAppear {
                weatherVM.download5DaysForcast {
                    //getting data to list
                    //nothing here for now
                }
            }
            .offset(y: currentWeatherTapped ?  SCREEN.height/2 : 0)
            
        }
        .background(Color.black.opacity(0.1))
        .edgesIgnoringSafeArea(.all)
        .blur(radius: searchCancelled ? 0 : 5)
        .animation(searchCancelled ? .none : .default)
        
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(searchCancelled: .constant(false))
    }
}
