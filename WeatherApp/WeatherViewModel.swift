//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Anna on 22.10.2024.
//

import Foundation

class WeatherViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var temperature: String = ""
    @Published var windSpeed: String = ""
    @Published var weatherDescription: String = ""
    @Published var weatherIcon: String = ""
    @Published var isCelsius: Bool = true
    @Published var isFahrenheit: Bool = false
    
    private var currentTempC: Double = 0.0
    private var currentTempF: Double = 0.0
    
    func fetchWeather(completion: @escaping () -> Void) {
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=9ebda1cb1c8a4243b4c120443242110&q=auto:ip&aqi=no") else {
            completion()
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
                guard let self = self else { return }
                
                if let error = error {
                    print("Failed to fetch data: \(error)")
                    completion()
                    return
                }
                
                guard let data = data else {
                    print("No data returned")
                    completion()
                    return
                }
                
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.cityName = weatherData.location.name
                        self.currentTempC = weatherData.current.temp_c
                        self.currentTempF = weatherData.current.temp_f
                        self.windSpeed = "\(weatherData.current.wind_kph) kph"
                        self.updateTemperatureDisplay()
                        self.weatherDescription = weatherData.current.condition.text
                        completion()
                    }
                } catch {
                    print("Failed to decode JSON: \(error)")
                    completion()
                }
            }
            
            task.resume()
        }
    }
    
    func updateTemperatureDisplay() {
        if isCelsius {
            self.temperature = "\(currentTempC) °C"
        } else {
            self.temperature = "\(currentTempF) °F"
        }
    }
    
    func toggleTemperatureUnit() {
        isCelsius.toggle()
        updateTemperatureDisplay()
    }
}
