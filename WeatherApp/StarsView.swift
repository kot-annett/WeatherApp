//
//  StarsView.swift
//  WeatherApp
//
//  Created by Anna on 24.10.2024.
//

import SwiftUI

struct StarsView: View {
    @State private var animate = false
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                ForEach(0..<100, id: \.self) { _ in
                    let starSize = CGFloat.random(in: 2...4)
                    let xPosition = CGFloat.random(in: 0...geometry.size.width)
                    let yPosition = CGFloat.random(in: 0...geometry.size.height)
                    
                    Circle()
                        .fill(Color.white.opacity(0.8))
                        .frame(width: starSize, height: starSize)
                        .position(x: xPosition, y: yPosition)
                        .opacity(animate ? 0.2 : 1)
                }
            }
        }
        .ignoresSafeArea()
    }
}
