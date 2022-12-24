//
//  WeatherManager.swift
//  Clima
//
//  Created by Andrei Ionascu on 21.12.2022.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager{
    
    var city = ""
    var temperature = 0.0
    var id = 0
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=d166bb700d27576c1ce2a7304e2061c3&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String){
        //1.Create a URL
        
        if let url = URL(string: urlString){
            //2.Create a URLSesion
            
            let session = URLSession(configuration: .default)
            //3. Give the session a task
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather)
                    }
                }
            }
            
            //4.Start the task
            
            task.resume()
            
        }
    }
    
    func parseJSON(_ weatherData: Data)-> WeatherModel?{
        let decoder = JSONDecoder()
        do{
            
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let city = decodedData.name
            let temperature = decodedData.main.temp
            let id = decodedData.weather[0].id
            print(city)
            print(temperature)
            print(id)
            
            let weather = WeatherModel(conditonId: id, cityName: city, temperature: temperature)
            print(weather.temperatureString)
             return weather
            
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
    
    
}
