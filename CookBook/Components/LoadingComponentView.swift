//
//  LoadingComponentView.swift
//  CookBook
//
//  Created by Satyajit Bhol on 14/07/25.
//

import SwiftUI

struct LoadingComponentView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.35)
                .ignoresSafeArea()
            ProgressView()
                .tint(Color.white)
        }
    }
}

#Preview {
    LoadingComponentView()
}
