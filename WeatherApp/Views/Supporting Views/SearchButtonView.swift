//
//  SearchButtonView.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 10/11/2020.
//

import SwiftUI

struct SearchButtonView: View {
    @Binding var Cancelled: Bool
    @State var searchTerm : String = ""
    @State var viewState = CGSize.zero
    var body: some View {
        VStack {
            HStack(spacing: 5){
                //Spacer()
                ZStack {
                    BlurView(style: .systemUltraThinMaterialLight)
                    Image(systemName: "magnifyingglass")
                        .font(.title)
                }
                .frame(width: 60, height: 60)
                HStack(spacing: 0){
                    TextField("Enter City Name", text: $searchTerm)
                        .font(.title)
                        .padding(.leading, 5)
                    Image(systemName: "multiply")
                        .font(.title)
                        .frame(width: 28, height: 28)
                        .onTapGesture {
                            searchTerm = ""
                            Cancelled = true
                        }
                }
                .padding(.trailing, 10)
                .frame(height: 60)
                .background(BlurView(style: .systemThinMaterial))

            }
            .animation(.easeInOut)
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 8)
            .shadow(color: Color.white, radius: 3, x: 1, y: 5)
            .offset(x: Cancelled ? SCREEN.width - 60 : viewState.width)
            .gesture(
            
                DragGesture().onChanged {
                    value in
                    if value.translation.width < SCREEN.width - 60 {
                        Cancelled = false
                        viewState = value.translation
                    }

                }
                .onEnded {
                    value in
                    
                    viewState = .zero
                }
            )

            Spacer()
        }
        .padding(.top, 50)
    }
}


struct SearchButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SearchButtonView(Cancelled: .constant(true))
    }
}
