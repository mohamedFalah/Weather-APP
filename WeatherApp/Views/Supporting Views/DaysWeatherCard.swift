//
//  DaysWeatherCard.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 07/11/2020.
//

import SwiftUI
import SDWebImageSwiftUI
struct DaysWeatherCard: View {
    
    var day: Forcast!
    
    var body: some View {
        HStack (){
            VStack {
                WebImage(url: URL(string: "\(BASE_ICON_URL)\(day.weatherIcon)\(ICON_FORMAT)"))
                    .resizable()
                    .scaledToFill()
                    //.aspectRatio(1,contentMode: .fill)
                    .shadow(color: Color.white, radius: 3, x: 1, y: 2)
                    .shadow(color: Color.black, radius: 3, x: 0, y: 3)
            }
            .frame(width: 100, height: 100, alignment: .leading)
            
            VStack(alignment: .leading , spacing: 5) {
                Text(day.day)
                    .font(.title)
                Text(day.weatherType)
                    .font(.title)
            }
            .padding(.leading, 8)
            Spacer()
            VStack(alignment: .leading , spacing: 5) {
                Text("\(Int(day.maxTemperature))°")
                    .font(.title)
                Text("\(Int(day.minTemperature))°")
                    .font(.title)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(LinearGradient(
                                gradient: Gradient(
                                    colors: [Color(#colorLiteral(red: 0.9921568627, green: 0.8588235294, blue: 0.1529411765, alpha: 0.5)), Color(#colorLiteral(red: 0.9921568627, green: 0.8588235294, blue: 0.1529411765, alpha: 1))]),
                                    startPoint: .leading,
                                    endPoint: .trailing)
                        )
        )
        .frame(width: SCREEN.width - 10)
        .shadow(color: Color(#colorLiteral(red: 0.9921568627, green: 0.8588235294, blue: 0.1529411765, alpha: 1)).opacity(0.3), radius: 10, x: 0, y: 8)
    }
}

struct DaysWeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        DaysWeatherCard()
    }
}
