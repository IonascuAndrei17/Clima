//
//  WeatherModel.swift
//  Clima
//
//  Created by Andrei Ionascu on 23.12.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

struct WeatherModel{
    let conditonId: Int
    let cityName: String
    let temperature: Double
    
    var temperatureString: String{
        String(format: "%.1f", temperature)
    }
    
    var conditionName: String{
        switch conditonId {
        case 200...232:
            return "cloud.bolt.rain.fill"
        case 300...321:
            return "cloud.drizzle"
        case 500...531:
            return "cloud.rain"
        case 600...622:
            return "cloud.snow"
        case 700...781:
            return "cloud.fog"
        case 800:
            return "sun.max"
        case 801...804:
            return "cloud"
        default:
            return "sun.max"
        }
    }
}
