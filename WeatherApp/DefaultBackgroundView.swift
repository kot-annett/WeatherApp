//
//  DefaultBackgroundView.swift
//  WeatherApp
//
//  Created by Anna on 23.10.2024.
//

import SwiftUI

struct DefaultBackgroundView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 0.85, green: 0.85, blue: 0.85),
                Color(red: 0.7, green: 0.85, blue: 0.95)
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    DefaultBackgroundView()
}
