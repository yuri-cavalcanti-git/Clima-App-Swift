//
//  WeatherData.swift
//  Clima-App
//
//  Created by Yuri Cavalcanti on 09/03/21.
//

import Foundation
struct WeatherData: Codable {
    let name: String
    let main: Main
    let weather: [Weather]
    let visibility: Int
}


struct Main: Codable {
    let temp: Double
}

struct Weather: Codable {
    let description: String
    let id: Int
}
