//
//  ContentView.swift
//  WeatherApp
//
//  Created by Anna on 21.10.2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    @StateObject var locationDataManager = LocationDataManager()
    @State private var showAlert = false
    @State private var errorMessage = ""
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            ZStack {
                backgroundView(for: viewModel.weatherDescription)
                    .ignoresSafeArea()
                
                VStack {
                    Text("Current place")
                        .font(.largeTitle)
                        .bold()
                        .padding(.top, 20)
                        .foregroundColor(isNightTime() ? .white : .black)
                    
                    Text(viewModel.cityName)
                        .font(.largeTitle)
                        .foregroundColor(isNightTime() ? .white : .black)
                    
                    VStack(spacing: 16) {
                        weatherCard(title: "Temperature", value: viewModel.temperature, icon: "thermometer")
                        
                        Text("Description: \(viewModel.weatherDescription)")
                            .foregroundColor(isNightTime() ? .white : .black)
                        
                        weatherCard(title: "Wind Speed", value: "\(viewModel.windSpeed)", icon: "wind")
                    }
                    .padding()
                    
                    Button(action: {
                        viewModel.toggleTemperatureUnit()
                    }) {
                        Text("Change Temperature Unit")
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding()
                            .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    }
                    
                    Spacer()
                }
                .padding(.top, 20)
            }
//            .navigationTitle("Weather App")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing:
                                    Button(action: {
                loadWeather()
            }) {
                Image(systemName: "arrow.clockwise")
                    .imageScale(.medium)
                    .font(.system(size: 30))
                    .padding(6)
                    .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue))
                    .foregroundColor(.white)
            })
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Connection Error"),
                      message: Text(errorMessage),
                      primaryButton: .default(Text("Retry"), action: {
                    loadWeather()
                }),
                      secondaryButton: .cancel(Text("OK")))
            }
            .onAppear {
                locationDataManager.requestPermission()
            }
            .onChange(of: locationDataManager.authorizationStatus) { status in
                switch status {
                case .authorizedWhenInUse:
                    loadWeather()
                case .denied, .restricted:
                    showAlert = true
                    errorMessage = "For the application to work, you must allow access to location."
                default:
                    break
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Access error"),
                    message: Text(errorMessage),
                    primaryButton: .default(Text("Open settings"), action: {
                        if let appSettings = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(appSettings, options: [:], completionHandler: nil)
                        }
                    }),
                    secondaryButton: .cancel(Text("OK"))
                )
            }
        }
    }
    
    private func loadWeather() {
        viewModel.fetchWeather()
    }

    @ViewBuilder
    private func backgroundView(for condition: String) -> some View {
        if isNightTime() {
            NightBackgroundView()
        } else {
            switch condition {
            case "Sunny", "Clear":
                Image("sunnyBg")
                    .resizable()
                    .scaledToFill()
            case "Cloudy":
                Image("cloudyBg")
                    .resizable()
                    .scaledToFill()
            case "Partly cloudy":
                Image("partlyCloudyBg")
                    .resizable()
                    .scaledToFill()
            case "Rain":
                Image("rainBg")
                    .resizable()
                    .scaledToFill()
            case "Night", "Clear Night", "Partly cloudy night":
                NightBackgroundView()
            default:
                DefaultBackgroundView()
            }
        }
    }
    
    private func weatherCard(title: String, value: String, icon: String) -> some View {
        HStack {
            Image(systemName: icon)
                .font(.title)
                .padding(.trailing, 10)
                .foregroundColor(isNightTime() ? .white : .black)
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(isNightTime() ? .white : .black)
                Text(value)
                    .font(.largeTitle)
                    .bold()
                    .foregroundColor(isNightTime() ? .white : .black)
            }
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 15)
            .fill(isNightTime() ? Color.blue.opacity(0.3) : Color.blue.opacity(0.2)))
//            .fill(Color.blue.opacity(0.2)))
        .shadow(color: isNightTime() ? .white.opacity(0.5) : .black.opacity(0.2), radius: 5)
//        .shadow(radius: 5)
    }
    
    private func isNightTime() -> Bool {
        let hour = Calendar.current.component(.hour, from: Date())
        return hour >= 19 || hour < 6
    }
}

#Preview {
    ContentView()
}
