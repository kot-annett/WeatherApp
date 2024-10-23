//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Anna on 22.10.2024.
//

import Combine
import Foundation

class WeatherViewModel: ObservableObject {
    @Published var cityName: String = ""
    @Published var temperature: String = ""
    @Published var windSpeed: String = ""
    @Published var weatherDescription: String = ""
    @Published var isCelsius: Bool = true
    @Published var isFahrenheit: Bool = false
    
    private var currentTempC: Double = 0.0
    private var currentTempF: Double = 0.0
    
    private var cancellable: AnyCancellable?
    
    func fetchWeather() {
        guard let url = URL(string: "https://api.weatherapi.com/v1/current.json?key=9ebda1cb1c8a4243b4c120443242110&q=auto:ip&aqi=no") else {
//            print("Invalid URL")
            return
        }
        
//        print("Starting fetchWeather with URL: \(url)")
        
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
                    .map { $0.data }
//                    .print("Data Task")
                    .decode(type: WeatherData.self, decoder: JSONDecoder())
                    .receive(on: DispatchQueue.main)
                    .sink(receiveCompletion: { completion in
                        switch completion {
                        case .finished:
                            print("Data successfully fetched")
                        case .failure(let error):
                            print("Failed to fetch data: \(error)")
                        }
                    }, receiveValue: { weatherData in
//                        print("Received weather data: \(weatherData)")
                        self.cityName = weatherData.location.name
                        self.currentTempC = weatherData.current.temp_c
                        self.currentTempF = weatherData.current.temp_f
                        self.windSpeed = "\(weatherData.current.wind_kph) kph"
                        self.updateTemperatureDisplay()
                        self.weatherDescription = weatherData.current.condition.text
                    })
//        print("Weather request sent")
    }
        
    
    func updateTemperatureDisplay() {
        if isCelsius {
            self.temperature = "\(currentTempC) °C"
        } else {
            self.temperature = "\(currentTempF) °F"
        }
//        print("Updated temperature display: \(self.temperature)")
    }
    
    func toggleTemperatureUnit() {
        isCelsius.toggle()
        updateTemperatureDisplay()
    }
}
