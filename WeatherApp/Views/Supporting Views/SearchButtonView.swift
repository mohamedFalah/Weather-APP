//
//  SearchButtonView.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 10/11/2020.
//

import SwiftUI

struct SearchButtonView: View {
    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                }
                .frame(width: 60, height: 60)
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), Color(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))]),
                        startPoint: .topLeading, endPoint: .bottomTrailing)
                )
                .clipShape(Circle())
            }
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 8)
            .shadow(color: Color.white, radius: 3, x: 1, y: 5)
            Spacer()
        }
        .padding(.top, 50)
        .padding(.trailing, 10)
    }
}


struct SearchButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SearchButtonView()
    }
}
