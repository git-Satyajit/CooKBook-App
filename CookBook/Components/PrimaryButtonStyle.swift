//
//  PrimaryButtonStyle.swift
//  CookBook
//
//  Created by Satyajit Bhol on 08/07/25.
//

import Foundation
import SwiftUI
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.system(size: 15, weight: .semibold))
            .padding(12)
            .foregroundStyle(Color.white)
            .frame(maxWidth: .infinity)
            .background(Color.green)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .animation(.easeInOut(duration: 0.1), value: configuration.isPressed)
    }
}
