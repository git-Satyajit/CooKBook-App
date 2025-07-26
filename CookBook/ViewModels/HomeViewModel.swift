//
//  SignoutViewModel.swift
//  CookBook
//
//  Created by Satyajit Bhol on 04/07/25.
//

import Foundation
import SwiftUI
import FirebaseAuth
@Observable
class HomeViewModel  {
     var showSignoutAlert:Bool = false
     var showAddReceipeView: Bool = false
    func signOut() -> Bool {
        do {
            try Auth.auth().signOut()
            return true
            
        }
        catch {
            print("Error \(error.localizedDescription)")
            return false
        }
    }
}
