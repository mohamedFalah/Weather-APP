//
//  SearchModelView.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 12/11/2020.
//

import SwiftUI
import Alamofire
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var cityWeather = CityWeather()
    
    typealias DownloadCityWeather = () -> ()
    
    init() {
        
    }
    
    func searchCityWeather(searchTerm: String, completed: @escaping DownloadCityWeather) {
        
        let searchUrl = BASE_URL + WEATHER + "q=" + searchTerm + APPID + API_KEY
        
        AF.request(searchUrl, method: .get).responseJSON { response in
            let result = response.result
            
            switch(result) {
                case .success(let data):
                    if let dataDictionary = data as? Dictionary<String, AnyObject> {
                        if let name = dataDictionary["name"] as? String {
                            self.cityWeather.cityName = name.capitalized
//                            print("city \(self.todayWeather.cityName)")
                        }
                        
                        if let weather = dataDictionary["weather"] as? [Dictionary<String, AnyObject>] {
                            
                           if let weatherType = weather[0]["description"] as? String {
                            self.cityWeather.weatherType = weatherType.capitalized
//                            print("type \(self.todayWeather.weatherType)")
                            }
                        
                            if let weatherIcon = weather[0]["icon"] as? String {
                                self.cityWeather.weatherIcon = weatherIcon
//                                print("\(BASE_ICON_URL)\(weatherIcon)\(ICON_FORMAT)")
                            }
                            
                        }
                        
                        if let main = dataDictionary["main"] as? Dictionary<String, AnyObject> {
                            if var temperature = main["temp"] as? Double {
                                self.cityWeather.temperature = temperature.convertKelvinToCelcius()
//                                print("temp \(self.todayWeather.currentTemperature)")
                            }
                        }
                                                
                    }
                    completed()
                    break
                case .failure(let error):
                    print("error \(error)")
                    break
            }
            
                
        }
        
        
        
    }
    
    
}
