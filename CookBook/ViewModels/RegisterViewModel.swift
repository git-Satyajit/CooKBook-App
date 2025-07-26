//
//  RegisterViewModel.swift
//  CookBook
//
//  Created by Satyajit Bhol on 02/07/25.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
@Observable
class RegisterViewModel {
     var username = ""
     var email = ""
     var password = ""
     var showPassword = false
     var isLoading = false
     var errorMessage = ""
     var presentAlert = false
    func signup() async -> User? {
        // Validate UserName for counts
        guard validateUserName() else {
            return nil
        }
        guard validatePassword() else {
            return nil
        }
        isLoading = true
        // Retrieve to check if username is unique
        guard let userNameDocuments = try? await   Firestore.firestore().collection("users").whereField("username", isEqualTo: username).getDocuments() else {
            errorMessage = "UserName must be Unique"
            presentAlert = true
            isLoading = false
            return nil
        }
        guard userNameDocuments.documents.count == 0 else {
            errorMessage = "Username already exist"
            presentAlert = true
            isLoading = false
            return nil
        }
        do {
           isLoading = true
            // Create User
           let result = try await Auth.auth().createUser(withEmail: email, password: password)
            print("User created successfully.\(result.user.uid)")
            let userId = result.user.uid
//            let userData: [String:Any] = [
//                "username": username,
//                "email": email
//            ]
            let user = User(id: userId, userName: username, email: email)
            // Store it in FirestoreDatabase with userData
            
            try Firestore.firestore().collection("users").document(userId).setData(from: user)
            isLoading = false
            return user
           
        }
        catch(let error) {
            errorMessage = "Registration  Failed"
            let errorcode = error._code
            if   let authErrorCode = AuthErrorCode(rawValue: errorcode) {
                switch authErrorCode {
                    case .emailAlreadyInUse:
                        errorMessage = "Email Already in use"
                    case .invalidEmail:
                        errorMessage = "Enter Valid Email"
                    case .weakPassword :
                        errorMessage = "Password is weak"
                        
                    default :
                        break
                }
            }
            isLoading = false
            presentAlert = true
            print("Error creating user\(error)")
            return nil
            
        }
    }
    func validateUserName() -> Bool {
        if username.isEmpty {
            errorMessage = "UserName is empty"
            presentAlert = true
            return false
        }
        if  username.count < 3 && username.count > 15 {
            errorMessage = "UserName must be greater than 3 characters & less than 15"
            presentAlert = true
            return false
        }
        return true
    }
    func validatePassword() -> Bool {
        if password.isEmpty {
            errorMessage = "Password Can't be empty"
            presentAlert = true
            return false
        }
        let passwordRegex = "^ [A-Za-z0-9]{6} $"
        let passwordTest = NSPredicate(format:"SELF MATCHES %@",passwordRegex)
        if !passwordTest.evaluate(with: password) {
            errorMessage = "Password length should be atleast 6, containing atleast 1 lowercased , 1 uppercased,1 number "
            presentAlert = true
        }
        return true
        
    }
    }
    
