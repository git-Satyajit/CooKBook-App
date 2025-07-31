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
    let persistenceController = PersistenceController.shared

    
    var body: some Scene {
        WindowGroup {
            switch sessionmanager.sessionState {
                case .loggedIn:
                    HomeView()
                        .environment(sessionmanager)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
                case .loggedout:
                    LoginView()
                        .environment(sessionmanager)
                        .environment(\.managedObjectContext, persistenceController.container.viewContext)
            }
            
        }
    }
}
