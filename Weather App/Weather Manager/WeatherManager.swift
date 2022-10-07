//
//  WeatherManager.swift
//  Weather App
//
//  Created by Ayman alsubhi on 10/03/1444 AH.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUptadeWeather(weatherManager: WeatherManager , weather : WeatherModel)
    func didFailWithError( error : Error)
    
}


struct WeatherManager{
    
    var delegate : WeatherManagerDelegate?
    let weatherUrl = "https://api.openweathermap.org/data/2.5/weather?appid=588b2dd7e5929f80b47bfe4927c7b0f5&units=metric"
    
    func getWeather (cityName: String){
        
        let urlString = "\(weatherUrl)&q=\(cityName)"
        perfomRequest(urlString: urlString)
    }
    
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let urlString = "\(weatherUrl)&lat=\(latitude)&lon=\(longitude)"
        perfomRequest(urlString: urlString)
    }
    
    func perfomRequest(urlString : String){
        //Create url
        if  let url = URL(string:urlString){
            
            //Creat sesstion
            let sesstion = URLSession(configuration: .default)
            //Creat task
            let task = sesstion.dataTask(with: url) { (data, response, error) in
                
                if error != nil {
                    self.delegate?.didFailWithError(error: error as! Error)
                    
              
                }
                
                if let safeData = data {
                    let dataString = String(data: safeData, encoding: .utf8)
                    if let weather = self.paraJSON(weatherData: safeData) {
                        self.delegate?.didUptadeWeather(weatherManager: self, weather: weather)
                    }
                   
                    paraJSON(weatherData: safeData)
                    
                }
                
            }
            
           //start task
            task.resume()
        
            
        }
    }
    
  
    
    func paraJSON(weatherData: Data) -> WeatherModel?{
        
        let decoder = JSONDecoder()
        
        do {
            
            let decodeData =  try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodeData.weather[0].id
            let temp = decodeData.main.temp
            let name = decodeData.name
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            self.delegate?.didUptadeWeather(weatherManager: self, weather: weather)
            


            print(weather)
            
            return weather
            
        } catch {
            
            delegate?.didFailWithError(error: error.localizedDescription as! Error)
           return nil
            
        }
     
            
        
        
      
        
     
    }
    
    
    
}
