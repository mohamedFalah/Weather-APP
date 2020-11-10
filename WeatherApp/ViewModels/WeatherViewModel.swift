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
//                            print("city \(self.todayWeather.cityName)")
                        }
                        
                        if let weather = dataDictionary["weather"] as? [Dictionary<String, AnyObject>] {
                            
                           if let weatherType = weather[0]["description"] as? String {
                            self.todayWeather.weatherType = weatherType.capitalized
//                            print("type \(self.todayWeather.weatherType)")
                            }
                        
                            if let weatherIcon = weather[0]["icon"] as? String {
                                self.todayWeather.weatherIcon = weatherIcon
//                                print("\(BASE_ICON_URL)\(weatherIcon)\(ICON_FORMAT)")
                            }
                            
                        }
                        
                        if let main = dataDictionary["main"] as? Dictionary<String, AnyObject> {
                            if let temperature = main["temp"] as? Double {
                                self.todayWeather.currentTemperature = self.convertKelvinToCelcius(temperature: temperature)
//                                print("temp \(self.todayWeather.currentTemperature)")
                            }
                            if let feelsLike = main["feels_like"] as? Double {
                                self.todayWeather.feelsLike = self.convertKelvinToCelcius(temperature: feelsLike)
//                                print("temp \(self.todayWeather.currentTemperature)")
                            }
                            if let pressure = main["pressure"] as? Double {
                                self.todayWeather.pressure = pressure
//                                print("temp \(self.todayWeather.currentTemperature)")
                            }
                            if let humidity = main["humidity"] as? Double {
                                self.todayWeather.humidity = humidity
//                                print("temp \(self.todayWeather.currentTemperature)")
                            }
                        }
                        
                        if let visibility = dataDictionary["visibility"] as? Double {
                            self.todayWeather.visibility = visibility
                        }
                        
                        if let wind = dataDictionary["wind"] as? Dictionary<String, AnyObject> {
                            if let speed = wind["speed"] as? Double {
                                self.todayWeather.wind = speed
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
        let forcastUrl = URL(string: "\(BASE_URL)\(FORCAST)\(LATITUDE)26.565191\(LONGTUDE)49.996376\(EXCLUDE)\(APPID)\(API_KEY)")!
        //get the forcast
        
        AF.request(forcastUrl, method: .get).responseJSON { (response) in
            
            let result = response.result
            
            switch(result) {
                case .success(let data):
                    if let dataDictionary = data as? Dictionary<String, AnyObject> {
                        if let days = dataDictionary["daily"] as? [Dictionary<String,AnyObject>] {
                            // 7 days forcast
                            
                            for day in days {
                                var daily = Forcast()
                                
                                if let dateTime = day["dt"] as? Double {
                                    let unixConvertedDate = Date(timeIntervalSince1970: dateTime)
                                    let dateFormatter = DateFormatter()
                                    dateFormatter.dateStyle = .full
                                    dateFormatter.dateFormat = "E"
                                    dateFormatter.timeStyle = .none
                                    daily.day = unixConvertedDate.getDayOfTheWeek()
                                }
                                
                                if let weather = day["weather"] as? [Dictionary<String,AnyObject>] {
                                    if let weatherType = weather[0]["main"] as? String {
                                        daily.weatherType = weatherType
                                    }
                                    if let weatherIcon = weather[0]["icon"] as? String {
                                        daily.weatherIcon = weatherIcon
                                    }
                                }
                                
                                if let main = day["temp"] as? Dictionary<String, AnyObject> {
                                    if let minTemp = main["min"] as? Double {
                                        daily.minTemperature = self.convertKelvinToCelcius(temperature: minTemp)
                                    }
                                    
                                    if let maxTemp = main["max"] as? Double {
                                        daily.maxTemperature = self.convertKelvinToCelcius(temperature: maxTemp)
                                    }
                                }
                                
                                //add to the list
                                self.fiveDaysforcast.append(daily)
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

