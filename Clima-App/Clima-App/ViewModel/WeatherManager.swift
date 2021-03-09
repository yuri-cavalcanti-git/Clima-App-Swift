//
//  WeatherManager.swift
//  Clima-App
//
//  Created by Yuri Cavalcanti on 09/03/21.
//

import Foundation
import CoreLocation

//MARK: - WeatherManagerDelegate

protocol WeatherManagerDelegate {
    func didUpdateWeather(weaterManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}

//MARK: - WeatherManager

struct WeatherManager {
    
    let apiKey = "" //put here the API Key - https://openweathermap.org/
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?&units=metric&lang=pt_br"
    var delegate: WeatherManagerDelegate?
    var apiManager = ApiManager()
    
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)&appid=\(apiKey)"
        
        apiManager.performRequest(urlString: urlString) { (weatherModel, error) in

            if let safeWeatherModel = weatherModel {
                delegate?.didUpdateWeather(weaterManager: self, weather: safeWeatherModel)
            } else {
                if let safeError = error {
                    delegate?.didFailWithError(error: safeError)
                }
            }
        }
    }
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
        

        apiManager.performRequest(urlString: urlString) { (weatherModel, error) in

            if let safeWeatherModel = weatherModel {
                delegate?.didUpdateWeather(weaterManager: self, weather: safeWeatherModel)
            } else {
                if let safeError = error {
                    delegate?.didFailWithError(error: safeError)
                }
            }
        }
    }
}
