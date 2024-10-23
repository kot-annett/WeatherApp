//
//  ProgressView.swift
//  WeatherApp
//
//  Created by Anna on 22.10.2024.
//

import ProgressHUD
import SwiftUI

final class ProgressView {
    static func show() {
        DispatchQueue.main.async {
            ProgressHUD.colorHUD = .black
            ProgressHUD.colorBackground = .white
            ProgressHUD.animate("Loading...")
        }
    }
    
    static func dismiss() {
        DispatchQueue.main.async {
            ProgressHUD.dismiss()
        }
    }
}
