//
//  SessionManager.swift
//  CookBook
//
//  Created by Satyajit Bhol on 02/07/25.
//

import Foundation
import FirebaseAuth
import FirebaseCore
@Observable
class SessionManager {
    var sessionState: SessionState = .loggedout
    var currentUser: User?
    private static var isConfigured = false
    init() {
        if !SessionManager.isConfigured {
            FirebaseApp.configure()
            SessionManager.isConfigured = true
        }
        sessionState = Auth.auth().currentUser != nil ? .loggedIn : .loggedout
        
    }
}
