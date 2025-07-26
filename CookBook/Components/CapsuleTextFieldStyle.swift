//
//  CapsuleTextFieldStyle.swift
//  CookBook
//
//  Created by Satyajit Bhol on 08/07/25.
//

import Foundation
import SwiftUI
struct CapsuleTextFieldStyle : TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
        .padding()
        .background(Capsule().fill(Color.primaryFormEntry)
        )
        
    }
    
}
