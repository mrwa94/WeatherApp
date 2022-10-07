//
//  WeatherModel.swift
//  Weather App
//
//  Created by Ayman alsubhi on 10/03/1444 AH.
//

import Foundation
import UIKit

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    var temperatureString: String {
        
        return String(format: "%.1f", temperature)
    }
     var conditionName: UIImage {
         let image1 = UIImage(named: "Sun")
         let image2 = UIImage(named: "Clouds")
        
         switch conditionId {
         case 200...232:
             return image1!
         case 300...321:
             return image2!
         case 500...531:
             return image2!
         case 600...622:
             return image2!
         case 701...781:
             return image2!
         case 800:
             return image1!
         case 801...804:
             return image1!
         default:
             return  image2!
             
         }
     }

}



