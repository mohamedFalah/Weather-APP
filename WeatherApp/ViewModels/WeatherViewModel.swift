//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 08/11/2020.
//

import SwiftUI
import Alamofire


class WeatherViewModel: ObservableObject {
    @Published var todayWeather = TodayWeather()
    @Published var fiveDaysforcast: [Forcast] = []
    //typealias to pass the downloaded data from url request after finish
    typealias DownloadCompleted = () -> ()
    
    //get current weather data
    func downloadTodayWeather(completed: @escaping DownloadCompleted) {
        let todayWeatherUrl = URL(string: "\(BASE_URL)\(WEATHER)\(LATITUDE)26.565191\(LONGTUDE)49.996376\(APPID)\(API_KEY)")!

        //Alamofire request with get method
        AF.request(todayWeatherUrl, method: .get).responseJSON {response in
            let result = response.result

            switch(result) {
                case .success(let data):                    
                    if let dataDictionary = data as? Dictionary<String, AnyObject> {
                        if let name = dataDictionary["name"] as? String {
                            self.todayWeather.cityName = name.capitalized
                            print("city \(self.todayWeather.cityName)")
                        }
                        
                        if let weather = dataDictionary["weather"] as? [Dictionary<String, AnyObject>] {
                            
                           if let weatherType = weather[0]["description"] as? String {
                            self.todayWeather.weatherType = weatherType.capitalized
                            print("type \(self.todayWeather.weatherType)")
                            }
                        
                            if let weatherIcon = weather[0]["icon"] as? String {
                                self.todayWeather.weatherIcon = weatherIcon
                                print("\(BASE_ICON_URL)\(weatherIcon)\(ICON_FORMAT)")
                            }
                            
                        }
                        
                        if let main = dataDictionary["main"] as? Dictionary<String, AnyObject> {
                            if let temperature = main["temp"] as? Double {
                                self.todayWeather.currentTemperature = self.convertKelvinToCelcius(temperature: temperature)
                                print("temp \(self.todayWeather.currentTemperature)")
                            }
                        }
                        
                    }
                    completed()
                    break
                case .failure(let error):
                    print(error)
                    break
            }
        }

    }
    
    
    //get the forcast 5 days
    func download5DaysForcast(completed: @escaping DownloadCompleted) {
        let forcastUrl = URL(string: "\(BASE_URL)\(FORCAST)\(LATITUDE)26.565191\(LONGTUDE)49.996376\(APPID)\(API_KEY)")!
        //get the forcast
        
        AF.request(forcastUrl, method: .get).responseJSON { (response) in
            
            let result = response.result
            
            
            switch(result) {
                case .success(let data):
                    if let dataDictionary = data as? Dictionary<String, AnyObject> {
                        if let days = dataDictionary["list"] as? [Dictionary<String,AnyObject>] {
                            //cnt = 40 (known) each day is 8 means 5 days 1 9 17 25 33 :: 1 is excluded as it is the same as the current weather
                            let numbers = [1,9,17,25,33]
                            for number in numbers {
                                var day = Forcast()
                                
                                if let dateTime = days[number]["dt"] as? Double {
                                    let unixConvertedDate = Date(timeIntervalSince1970: dateTime)
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateStyle = .full
                                    dateFormatter.dateFormat = "E"
                                    dateFormatter.timeStyle = .none
                                    day.day = unixConvertedDate.getDayOfTheWeek()
                                }
                                
                                if let weather = days[number]["weather"] as? [Dictionary<String,AnyObject>] {
                                    if let weatherType = weather[0]["main"] as? String {
                                        day.weatherType = weatherType
                                    }
                                    if let weatherIcon = weather[0]["icon"] as? String {
                                        day.weatherIcon = weatherIcon
                                    }
                                }
                                
                                if let main = days[number]["main"] as? Dictionary<String, AnyObject> {
                                    if let minTemp = main["temp_min"] as? Double {
                                        day.minTemperature = self.convertKelvinToCelcius(temperature: minTemp)
                                    }
                                    
                                    if let maxTemp = main["temp_max"] as? Double {
                                        day.maxTemperature = self.convertKelvinToCelcius(temperature: maxTemp)
                                    }
                                }
                                
                                //add to the list
                                self.fiveDaysforcast.append(day)
                            }//forloop
                        }//days
                    }//dataDictionary
                    completed()
                    break
                case .failure(let error):
                    print(error)
                    break
            }
                
        }
        
    }
    
    
    func convertKelvinToCelcius(temperature: Double) -> Double {
     
        let K = temperature
        let C = K - 273.15
        let CRounded = Double(round(100*C)/100)
        return CRounded
    }
   
}

