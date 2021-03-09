//
//  ApiManager.swift
//  Clima-App
//
//  Created by Yuri Cavalcanti on 09/03/21.
//

import Foundation
import Alamofire

class ApiManager  {
    
    func performRequest(urlString: String,  completion: @escaping (WeatherModel?, Error?) -> Void){
        AF.request(urlString).responseData { response in
            if let data = response.value {
                let weatherTuple = self.parseJson(weatherData: data)
                completion(weatherTuple.0,weatherTuple.1)

            }
        }
        
    }
    
    func parseJson(weatherData: Data) -> (WeatherModel?, Error?) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            
            print("Json \(decodedData.name)")
            let id = decodedData.weather[0].id
            let name = decodedData.name
            let temp = decodedData.main.temp
            
            let weather = WeatherModel(condicionId: id, cityName: name, temperature: temp)
            
            return (weather,nil)
        } catch {
            return (nil, error)
        }
    }
}
