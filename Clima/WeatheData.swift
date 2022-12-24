//
//  WeatherData.swift
//  Clima
//
//  Created by Andrei Ionascu on 22.12.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherData: Codable {
    
    let name: String
    let weather: [Weather]
    let main: Main
    
}

struct Weather: Codable{
    let id: Int
}

struct Main: Codable{
    let temp: Double
}
