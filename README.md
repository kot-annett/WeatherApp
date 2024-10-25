# Weather App #

### Overview
This Weather App is built using SwiftUI and utilizes the WeatherAPI to fetch real-time weather data based on the user's location.

### Features
#### Current Weather Data: 
Displays the current temperature, wind speed, and a description of the weather.
#### Temperature Unit Toggle: 
Users can switch between Celsius and Fahrenheit.
#### Automatic Location: 
The app uses the device’s location to display weather data.
#### Manual Data Refresh: 
A refresh button allows users to manually reload the weather data.
#### Night/Day Mode: 
The background dynamically changes based on the time of day.
#### Error Handling: 
Alerts are shown if location access is denied or if there is an issue with the network.

### Architecture
The project follows the MVVM (Model-View-ViewModel) architecture

### API Integration
This project uses the WeatherAPI to fetch real-time weather data. The following endpoint is used:
Endpoint: https://api.weatherapi.com/v1/current.json

### Technologies
#### SwiftUI: 
Used for building the user interface.
#### GCD (Grand Central Dispatch): 
Used for performing network requests on background threads and updating the UI on the main thread.
#### Core Location: 
For accessing the user's location to fetch relevant weather data.
#### WeatherAPI: 
Used to fetch weather data based on the user's current location.

