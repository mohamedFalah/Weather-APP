//
//  CityWeatherCard.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 12/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI

struct CityWeatherCard: View {
    
    var cityWeather: CityWeather!
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Text(cityWeather.cityName )
                        .font(.title)
                    Spacer()
                    Text(String(format:"%.2f", cityWeather.temperature)+"°")
                        .font(.title)
                }
                .padding()
                .offset(y: -90)
                
                VStack {
                    WebImage(url: URL(string: BASE_ICON_URL + cityWeather.weatherIcon + ICON_FORMAT))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .scaledToFit()
                        .shadow(color: Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)), radius: 5, x: 0.0, y: 10)
                        .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0.0, y: 10)
                }
                
                HStack{
                    Text(cityWeather.weatherType)
                        .font(.title)
                }
                .padding()
                .offset(y: 110)
            }
        }
        .frame(width:350, height: 275)
        .background(
            BlurView(style: .systemUltraThinMaterial)
        )
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .shadow(color: Color(#colorLiteral(red: 1, green: 0.9440771983, blue: 0.9732110334, alpha: 1)), radius: 5, x: 0.0, y: 10)
        .shadow(color: Color.black.opacity(0.5), radius: 10, x: 0.0, y: 10)
        
        .offset(y: -70)
    }
}


struct CityWeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        CityWeatherCard()
    }
}
