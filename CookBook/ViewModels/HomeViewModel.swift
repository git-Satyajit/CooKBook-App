//  SignoutViewModel.swift
//  CookBook

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
    

    // Search text for filtering mock recipes
     var searchText: String = ""

    // Computed variable to filter mock recipes by name
    var filteredMockRecipes: [Receipe] {
        if searchText.isEmpty {
            return Receipe.mockReceipes
        } else {
            return Receipe.mockReceipes.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}
