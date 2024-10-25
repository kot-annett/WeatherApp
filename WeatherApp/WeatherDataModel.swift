//
//  WeatherDataModel.swift
//  WeatherApp
//
//  Created by Anna on 22.10.2024.
//

import Foundation

struct WeatherData: Codable {
    let location: Location
    let current: CurrentWeather
}

struct Location: Codable {
    let name: String
}

struct CurrentWeather: Codable {
    let temp_c: Double
    let temp_f: Double
    let wind_kph: Double
    let condition: Condition
}

struct Condition: Codable {
    let text: String
}
