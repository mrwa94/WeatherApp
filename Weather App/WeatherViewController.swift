//
//  ViewController.swift
//  Weather App
//
//  Created by Ayman alsubhi on 09/03/1444 AH.
//

import UIKit
import CoreLocation

class WeatherViewController : UIViewController  , WeatherManagerDelegate {
    
    
    //vars
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()

    
    
    
    //IBOutlet
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var cityNameTextField: UITextField!
    @IBOutlet weak var temLabel: UILabel!
    @IBOutlet weak var cityNameLAbel: UILabel!
    @IBOutlet weak var searchButton: UIButton!
    
    
    
    

    @IBAction func searchButton(_ sender: Any) {
        
        if let city = cityNameTextField.text {
            weatherManager.getWeather(cityName: city)
          
        }
         
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        weatherManager.delegate = self
        locationManager.delegate = self
        
        
        
        
        
        
        
    }
    
    func didUptadeWeather(weatherManager: WeatherManager, weather: WeatherModel) {
        
        
        DispatchQueue.main.async {
            
            self.temLabel.text = weather.temperatureString
            self.weatherImage.image = UIImage(named: "\(weather.conditionName)")
            self.cityNameLAbel.text = weather.cityName
        }
          
        
    }
    
    func didFailWithError(error: Error) {
        print(error.localizedDescription)
    }
    


}


//MARK: - CLLocationManagerDelegate


extension WeatherViewController: CLLocationManagerDelegate {
    
    @IBAction func locationPressed(_ sender: UIButton) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(latitude: lat, longitude: lon)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}
