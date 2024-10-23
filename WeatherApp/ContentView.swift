//
//  ContentView.swift
//  WeatherApp
//
//  Created by Anna on 21.10.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @State private var showAlert = false
    
    var body: some View {
        VStack {
//            if viewModel.cityName.isEmpty {
//                
//            } else {
            
            Text("Weather App")
                .font(.largeTitle)
                .padding()
            
            
                Text(viewModel.cityName)
                    .font(.largeTitle)
                    .padding()
                
                Text(viewModel.temperature)
                    .font(.system(size: 50))
                    .padding()
                
                Text(viewModel.weatherDescription)
                    .font(.title2)
                    .padding()
                
                Text("Wind: \(viewModel.windSpeed)")
                    .font(.title3)
                    .padding()
                
                Button(action: {
                    viewModel.toggleTemperatureUnit()
                }) {
                    Text("Change Unit")
                        .font(.title2)
                        .padding()
                }
                
                Button(action: {
                    loadWeather()
                }) {
                    Image(systemName: "arrow.clockwise")
                        .font(.title)
                        .padding()
                }
//            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Connection Error"),
                  message: Text("Please check your internet connection."),
                  primaryButton: .default(Text("Retry"), action: {
                loadWeather()
            }),
                  secondaryButton: .cancel(Text("OK")))
        }
        .onAppear {
            loadWeather()
        }
    }
    
    private func loadWeather() {
        viewModel.fetchWeather()
    }

}

#Preview {
    ContentView()
}
