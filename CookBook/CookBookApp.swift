//
//  CookBookApp.swift
//  CookBook
//
//

import SwiftUI
import FirebaseCore
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
      


    return true
  }
}

@main
struct CookBookApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @State var sessionmanager = SessionManager()
    
    var body: some Scene {
        WindowGroup {
            switch sessionmanager.sessionState {
                case .loggedIn:
                    HomeView()
                        .environment(sessionmanager)
                case .loggedout:
                    LoginView()
                        .environment(sessionmanager)
            }
            
        }
    }
}
