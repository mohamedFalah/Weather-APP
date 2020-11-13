//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 08/11/2020.
//

import SwiftUI
import Alamofire
import CoreLocation

class WeatherViewModel: ObservableObject {
    @Published var todayWeather = TodayWeather()
    @Published var fiveDaysforcast: [Forcast] = []
    @Published var isLocationAvailable = false
    
    var userLatitude: Double!
    var userLongitude: Double!
    //typealias to pass the downloaded data from url request after finish
    typealias DownloadCompleted = () -> ()        
    

    //get current weather data
    func downloadTodayWeather(completed: @escaping DownloadCompleted) {
        let todayWeatherUrl = URL(string: BASE_URL + WEATHER + LATITUDE + "\(UserLocation.sharedInstance.userLatitude ?? 0)" +  LONGTUDE + "\(UserLocation.sharedInstance.userLongitude ?? 0)" + APPID + API_KEY)!

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
                            if var temperature = main["temp"] as? Double {
                                self.todayWeather.currentTemperature = temperature.convertKelvinToCelcius()
//                                print("temp \(self.todayWeather.currentTemperature)")
                            }
                            if var feelsLike = main["feels_like"] as? Double {
                                self.todayWeather.feelsLike = feelsLike.convertKelvinToCelcius()
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
        let forcastUrl = URL(string: BASE_URL + FORCAST + LATITUDE + "\(UserLocation.sharedInstance.userLatitude ?? 0)" + LONGTUDE + "\(UserLocation.sharedInstance.userLongitude ?? 0 )" + EXCLUDE + APPID + API_KEY)!
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
                                    if var minTemp = main["min"] as? Double {
                                        daily.minTemperature = minTemp.convertKelvinToCelcius()
                                    }
                                    
                                    if var maxTemp = main["max"] as? Double {
                                        daily.maxTemperature = maxTemp.convertKelvinToCelcius()
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
    

   
}

