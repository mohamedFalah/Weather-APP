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
    @State private var todayDate: String = ""
    @State private var temperature: String = ""
    @State private var city: String = ""
    @State private var weatherType:String = ""
    @State private var weatherIcon: String = ""
    @State private var isLoaded = false
    var body: some View {
        
        VStack(spacing: 0) {
            ZStack {
                Color(#colorLiteral(red: 0, green: 0.6941176471, blue: 0.8235294118, alpha: 1))
                
                VStack (alignment: .leading, spacing: 0){
                    VStack(alignment: .leading, spacing: 0) {
                        Text(isLoaded ? todayDate : "Sunday, 8 November 2020")
                            .font(.title)
                            .foregroundColor(Color.white.opacity(0.97))
                            .modifier(ShadowModifer())
                            .lineLimit(4)
                            .multilineTextAlignment(.leading)
                            .redacted(reason: isLoaded ? .init() : .placeholder)
                    }
                    .padding()
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 0){
                            Spacer()
                            Text(isLoaded ? "\(temperature)°" :"32°")
                                .font(.system(size: 56, weight: .bold))
                                .foregroundColor(Color.white.opacity(0.97))
                                .lineLimit(2)
                                .modifier(ShadowModifer())
                                .redacted(reason: isLoaded ? .init() : .placeholder)
                            Spacer()
                            Text(isLoaded ? city : "Al Qatif" )
                                .font(.title)
                                .foregroundColor(Color.white.opacity(0.97))
                                .lineLimit(2)
                                .modifier(ShadowModifer())
                                .redacted(reason: isLoaded ? .init() : .placeholder)
                            
                        }
                        Spacer()
                        VStack {
                            Spacer()
                            WebImage(url: URL(string: "\(BASE_ICON_URL)\(weatherIcon)\(ICON_FORMAT)"))
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100, alignment: .center)
                                .modifier(ShadowModifer())
//                                .redacted(reason: isLoaded ? .init() : .placeholder)
                            Text(isLoaded ? weatherType : "Clear Sky")
                                .font(.title)
                                .foregroundColor(Color.white.opacity(0.97))
                                .modifier(ShadowModifer())
                                .redacted(reason: isLoaded ? .init() : .placeholder)
                            
                        }
                    }
                    .padding()
                }
            }
            .frame(height: SCREEN.height/2)
            .shadow(color: Color(#colorLiteral(red: 0, green: 0.6941176471, blue: 0.8235294118, alpha: 1)).opacity(0.3), radius: 5, x: 0, y: 5)
            .onAppear(perform: {
                weatherVM.downloadTodayWeather {
                    self.todayDate = weatherVM.todayWeather.date
                    self.temperature = "\(weatherVM.todayWeather.currentTemperature)"
                    self.city = weatherVM.todayWeather.cityName
                    self.weatherType = weatherVM.todayWeather.weatherType
                    self.weatherIcon = weatherVM.todayWeather.weatherIcon
                    self.isLoaded = true
                }
                
            })

            
            
            VStack {
                ScrollView(.vertical, showsIndicators: false){
                    ForEach(weatherVM.fiveDaysforcast, id: \.self ) { day in
                        DaysWeatherCard(day: day)
                    }
                    .padding(.top, 5)
                    .padding(.bottom, 10)
                }
            }
            .frame(height: SCREEN.height/2)
            .onAppear {
                weatherVM.download5DaysForcast {
                    //getting data to list
                    //nothing here for now
                }
            }
            
        }
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
