//
//  Location.swift
//  WeatherApp
//
//  Created by Mohammed Alshulah on 11/11/2020.
//

import Foundation
import CoreLocation
import Combine

class Location: NSObject,ObservableObject, CLLocationManagerDelegate {
        
    let locationManger: CLLocationManager
    @Published var currentLocation: CLLocation = CLLocation()
    @Published var isLocationAvailable = false
    override init() {
        locationManger = CLLocationManager()
        super.init()
        locationManger.delegate = self
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
        locationManger.startUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        let auth = manager.authorizationStatus
        
        switch auth {
            case .authorizedWhenInUse:
                if let currentLocation = manager.location {
                    UserLocation.sharedInstance.userLatitude = currentLocation.coordinate.latitude
                    UserLocation.sharedInstance.userLongitude = currentLocation.coordinate.longitude
                }
                break
            case .authorizedAlways:
                print("nothing")
                break
            case .denied:
                manager.requestWhenInUseAuthorization()
                manager.startUpdatingLocation()
                break
            case .notDetermined:
                manager.requestWhenInUseAuthorization()
                manager.startUpdatingLocation()
                break
            case .restricted:
                print("nothing")
                break
            @unknown default:
                print("nothing")
        }
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {return}
        self.currentLocation = location
        UserLocation.sharedInstance.userLatitude = currentLocation.coordinate.latitude
        UserLocation.sharedInstance.userLongitude = currentLocation.coordinate.longitude
        self.isLocationAvailable = true
        manager.stopUpdatingLocation()
    }
    
        
    
}
