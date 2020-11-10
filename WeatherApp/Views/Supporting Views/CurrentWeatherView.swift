//
//  CurrentWeatherView.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 10/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct CurrentWeatherView: View {

    @Binding  var isLoaded: Bool
    @Binding  var currentWeatherTapped: Bool
    @Binding  var todayWeather: TodayWeather
    @State  private var dragState = CGSize.zero
    @State  private var isDragging = false
    var body: some View {
        ZStack {
           
            VStack(alignment: .leading, spacing: 10){
                Text("Weather Details")
                    .font(.title).bold()
                    .modifier(ShadowModifer())
                Text(isLoaded ? "Feels Like: \(String(format: "%.2f",todayWeather.feelsLike))°" :"32°" )
                    .font(.title2).bold()
                    .modifier(ShadowModifer())
                Text(isLoaded ? "Pressure: \(Int(todayWeather.pressure)) hPa" : "90 hPa")
                    .font(.title2).bold()
                    .modifier(ShadowModifer())
                Text(isLoaded ? "Humidity: \(Int(todayWeather.humidity))%" : "50%")
                    .font(.title2).bold()
                    .modifier(ShadowModifer())
                Text(isLoaded ? "Visibility: \(String(format: "%.2f", todayWeather.visibility)) km" : "500 m")
                    .font(.title2).bold()
                    .modifier(ShadowModifer())
                Text(isLoaded ? "Wind: \(String(format: "%.2f", todayWeather.wind)) m/s" : "33 m/s")
                    .font(.title2).bold()
                    .modifier(ShadowModifer())
            }
            .padding()
            .frame(width:SCREEN.width, height: SCREEN.height/2)
            .background(RoundedRectangle(cornerRadius: 15, style: .continuous).fill(Color(#colorLiteral(red: 0.4980392157, green: 0.7764705882, blue: 0.4901960784, alpha: 1))))
            .animation(.easeInOut)
            .offset(y: currentWeatherTapped ? SCREEN.height/2 : 0)
            .blur(radius: currentWeatherTapped ? 0 : 10)
            .gesture(
                DragGesture().onChanged {
                    value in
                    if (value.translation.height < 0) {
                        isDragging = true
                        dragState = value.translation
                    }
                    
                }
                .onEnded {
                    value in
                    dragState = .zero
                    isDragging = false
                }
                
            )
            
           Color(#colorLiteral(red: 0, green: 0.6941176471, blue: 0.8235294118, alpha: 1))
           VStack (alignment: .leading, spacing: 0){
            VStack(alignment: .leading, spacing: 0) {
                Text(isLoaded ? todayWeather.date : "Sunday, 8 November 2020")
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
                    Text(isLoaded ? "\(String(format: "%.2f",todayWeather.currentTemperature))°" :"32°")
                        .font(.system(size: 44, weight: .bold))
                        .foregroundColor(Color.white.opacity(0.97))
                        .lineLimit(2)
                        .modifier(ShadowModifer())
                        .redacted(reason: isLoaded ? .init() : .placeholder)

                    Spacer()
                    Text(isLoaded ? todayWeather.cityName : "Al Qatif" )
                        .font(.title)
                        .foregroundColor(Color.white.opacity(0.97))
                        .lineLimit(2)
                        .modifier(ShadowModifer())
                        .redacted(reason: isLoaded ? .init() : .placeholder)


                }
                Spacer()
                VStack {
                    Spacer()
                    WebImage(url: URL(string: "\(BASE_ICON_URL)\(todayWeather.weatherIcon)\(ICON_FORMAT)"))
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100, alignment: .center)
                        .modifier(ShadowModifer())
                    //                                .redacted(reason: isLoaded ? .init() : .placeholder)

                    Text(isLoaded ? todayWeather.weatherType : "Clear Sky")
                        .font(.headline)
                        .foregroundColor(Color.white.opacity(0.97))
                        .modifier(ShadowModifer())
                        .redacted(reason: isLoaded ? .init() : .placeholder)


                }
            }
            .padding()
        }
            
           
        }
        .frame(height: SCREEN.height/2)
        .shadow(color: Color(#colorLiteral(red: 0, green: 0.6941176471, blue: 0.8235294118, alpha: 1)).opacity(0.3), radius: 5, x: 0, y: 2)
        .animation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0))
        
    }
}


struct CurrentWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWeatherView(isLoaded: .constant(false), currentWeatherTapped: .constant(false), todayWeather: .constant(TodayWeather()))
    }
}
