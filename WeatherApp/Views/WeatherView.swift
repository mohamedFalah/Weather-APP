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
    
    @Binding var isLocationAvailable: Bool
    @Binding var searchCancelled: Bool
    
    var body: some View {
        
        VStack(spacing: 0) {
            CurrentWeatherView(isLoaded: $isLoaded, currentWeatherTapped: $currentWeatherTapped, todayWeather: $todayWeather)
                .onAppear(perform: {
                    if isLocationAvailable {
                        weatherVM.downloadTodayWeather {
                            print("hi")
                            self.isLoaded = true
                            self.todayWeather = weatherVM.todayWeather
                        }
                    }
                })
                .onChange(of: isLocationAvailable, perform: { _ in
                    if isLocationAvailable {
                        weatherVM.downloadTodayWeather {
                            print("hi2")
                            self.isLoaded = true
                            self.todayWeather = weatherVM.todayWeather
                        }
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
                if isLoaded {
                    weatherVM.download5DaysForcast {
                        //getting data to list
                        //nothing here for now
                        print("forcast ")
                    }
                }
            }
            .onChange(of: isLoaded, perform: { _ in
                if isLocationAvailable {
                    weatherVM.download5DaysForcast {
                        //getting data to list
                        //nothing here for now
                        print("forcast ")
                    }
                }
            })
            .offset(y: currentWeatherTapped ?  SCREEN.height/2 : 0)
            
        }
        .background(Color.black.opacity(0.1))
        .edgesIgnoringSafeArea(.all)
        .blur(radius: searchCancelled ? withAnimation {0} : withAnimation{5})
        .scaleEffect(searchCancelled ? withAnimation{1} : withAnimation{0.6})
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WeatherView(isLocationAvailable: .constant(false), searchCancelled: .constant(true))
                .previewDevice(PreviewDevice(rawValue: "iPhone 8"))
            WeatherView(isLocationAvailable: .constant(false), searchCancelled: .constant(true))
                .previewDevice(PreviewDevice(rawValue: "iPhone 12 mini"))
        }
    }
}

