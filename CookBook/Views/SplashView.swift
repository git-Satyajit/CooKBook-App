
//  SplashView.swift
//  CookBook

import SwiftUI

struct SplashView: View {
    @Environment(SessionManager.self) var sessionManager: SessionManager
    @State private var shouldNavigate = false

    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            
            VStack(spacing: 20) {
                Spacer()
                
                Image("cookbook_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .clipShape(Circle())
                    .shadow(radius: 10)

                Text("CookBook")
                    .font(.system(size: 36, weight: .bold, design: .serif))
                    .foregroundColor(.red)

                Text("Your Recipe Diary")
                    .font(.headline)
                    .foregroundColor(.gray)
                    .padding(.top, -10)
                
                Spacer()

                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .red))
                    .scaleEffect(1.5)
                
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                shouldNavigate = true
                print("SplashView appeared. Session state: \(sessionManager.sessionState)")
                
            }
        }
        .fullScreenCover(isPresented: $shouldNavigate) {
            if sessionManager.sessionState == .loggedIn {
                HomeView() // Replace with your main screen
            } else {
                LoginView() // Replace with your login/signup
            }
        }
    }
}
#Preview {
    SplashView()
        .environment(SessionManager())
}
