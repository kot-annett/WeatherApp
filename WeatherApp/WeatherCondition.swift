//
//  WeatherCondition.swift
//  WeatherApp
//
//  Created by Anna on 25.10.2024.
//

import Foundation

enum WeatherCondition: String {
    case sunny = "Sunny"
    case clear = "Clear"
    case cloudy = "Cloudy"
    case partlyCloudy = "Partly Сloudy"
    case rain = "Rain"
    case night = "Night"
    case clearNight = "Clear Night"
    case partlyCloudyNight = "Partly cloudy night"
    
    var backgroundImageName: String {
        switch self {
        case .sunny, .clear:
            return "sunnyBg"
        case .cloudy:
            return "cloudyBg"
        case .partlyCloudy:
            return "partlyCloudyBg"
        case .rain:
            return "rainBg"
        case .night, .clearNight, .partlyCloudyNight:
            return "nightBg"
        }
    }
}
