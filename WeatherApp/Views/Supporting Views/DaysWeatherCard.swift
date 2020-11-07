//
//  DaysWeatherCard.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 07/11/2020.
//

import SwiftUI

struct DaysWeatherCard: View {
    var body: some View {
        HStack (){
            Image(systemName: "cloud.fill")
                .resizable()
                .renderingMode(.original)
                .font(.largeTitle)
                .foregroundColor(Color.white.opacity(0.97))
                .frame(width: 75, height: 50, alignment: .center)
                
            VStack(alignment: .leading , spacing: 5) {
                Text("Sunday")
                    .font(.title)
                Text("8 Nov")
                    .font(.title)
            }
            .padding(.leading, 8)
            Spacer()
            VStack(alignment: .leading , spacing: 5) {
                Text("32°")
                    .font(.title)
                Text("21°")
                    .font(.title)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(LinearGradient(
                                gradient: Gradient(
                                    colors: [Color(#colorLiteral(red: 0.9921568627, green: 0.8588235294, blue: 0.1529411765, alpha: 1)), Color(#colorLiteral(red: 0.9921568627, green: 0.8588235294, blue: 0.1529411765, alpha: 0.5))]),
                                    startPoint: .leading,
                                    endPoint: .trailing)
                        )
        )
        .frame(width: screen.width - 20, height: .infinity, alignment: .center)
        .shadow(color: Color(#colorLiteral(red: 0.9921568627, green: 0.8588235294, blue: 0.1529411765, alpha: 1)).opacity(0.3), radius: 10, x: 0, y: 8)
    }
}

struct DaysWeatherCard_Previews: PreviewProvider {
    static var previews: some View {
        DaysWeatherCard()
    }
}
