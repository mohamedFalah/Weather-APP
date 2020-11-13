//
//  SearchButtonView.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 10/11/2020.
//

import SwiftUI
struct SearchView: View {
    @ObservedObject var searchVM = SearchViewModel()
    @Binding var Cancelled: Bool
    @State var searchTerm : String = ""
    @State var viewState = CGFloat.zero
    @State var searchClicked = false
    @State var cityWeather  = CityWeather()
    var body: some View {
        VStack {
            HStack(spacing: 5){
                //Spacer()
                ZStack {
                    BlurView(style: .systemUltraThinMaterialLight)
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                }.onTapGesture {
                    if searchTerm.count > 0 {
                        searchVM.searchCityWeather(searchTerm: searchTerm) {
                            self.cityWeather = searchVM.cityWeather
                            self.searchClicked = true
                        }
                    }
                }
                .frame(width: 60, height: 60)
                HStack(spacing: 0){
                    TextField("Enter City Name", text: $searchTerm)
                        .font(.title)
                        .padding(.leading, 5)
                    Image(systemName: "multiply")
                        .font(.title)
                        .frame(width: 40, height: 60)
                        .onTapGesture {
                            searchTerm = ""
                            Cancelled = true
                            searchClicked = false
                        }
                }
                .padding(.trailing, 10)
                .frame(height: 60)
                .background(BlurView(style: .systemThinMaterial))

            }
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 8)
            .shadow(color: Color.white, radius: 3, x: 1, y: 5)
            .offset(x: Cancelled ? SCREEN.width - 60 : viewState)
            .gesture(
                DragGesture().onChanged {
                    value in
                    if value.translation.width < SCREEN.width - 60 {
                        Cancelled = false
                        withAnimation {
                            viewState = value.translation.width
                        }
                    }
                }
                .onEnded {
                    _ in
                    viewState = .zero
                }
            )

            Spacer()
            
            searchClicked ?
                CityWeatherCard(cityWeather: cityWeather)
                    .transition(.move(edge: .trailing))
                    .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0))
            : nil
            
            Spacer()
            
        }
        .padding(.top, 65)
    }
}


struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView(Cancelled: .constant(true))
    }
}
