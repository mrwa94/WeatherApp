//
//  WeatherData.swift
//  Weather App
//
//  Created by Ayman alsubhi on 10/03/1444 AH.
//

import Foundation


struct WeatherData : Codable {
    
    let name : String
    let main : Main
    let weather: [Weather]
    
    
}


struct Main : Codable {
    let temp : Double
}

struct Weather : Codable {
    let id : Int
    let description: String
}
