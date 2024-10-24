//
//  NightBackgroundView.swift
//  WeatherApp
//
//  Created by Anna on 23.10.2024.
//

import SwiftUI

struct NightBackgroundView: View {
    var body: some View {
        ZStack {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.black,
                Color.blue
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .edgesIgnoringSafeArea(.all)
            StarsView()
    }
    }
}

#Preview {
    NightBackgroundView()
}
