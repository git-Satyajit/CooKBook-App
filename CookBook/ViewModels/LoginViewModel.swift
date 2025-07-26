//
//  LoginViewModel.swift
//  CookBook
//
//  Created by Satyajit Bhol on 01/07/25.
//

import Foundation
import SwiftUI
import FirebaseAuth
import FirebaseFirestore
@Observable
class  LoginViewModel  {
    var presentRegisterView = false
    var email = ""
    var password = ""
    var showPassword = false
    var presentAlert: Bool = false
    var isLoading: Bool = false
    var errorMessage: String = ""
    func login () async  -> User? {
        isLoading = true
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            let userId = result.user.uid
            //            let userEmail = result.user.email
            let  user =    try await Firestore.firestore().collection("users").document(userId).getDocument(as: User.self)
            print("Logged in user is \(result.user.uid)")
            isLoading = false
            return user
        }
        catch(let error) {
            isLoading = false
            errorMessage = "Login Failed"
            let errorCode = error._code
            if let authErrorCode = AuthErrorCode(rawValue:  errorCode) {
                switch authErrorCode {
                    case .invalidEmail:
                        errorMessage = "Enter Valid Email"
                    case .wrongPassword:
                        errorMessage = "Incorrect Password"
                    default:
                        errorMessage = "\(error.localizedDescription)"
                }
                
                
            }
            presentAlert = true
            return nil
            
        }
    }
    func sendPasswordReset() async {
        guard  !email.isEmpty else {
            errorMessage = "Enter email Address"
            presentAlert = true
            return
        }
        isLoading = true
        do {
            let snapShots =  try await Firestore.firestore().collection("users").whereField("email", isEqualTo: email).getDocuments()
            if snapShots.documents.isEmpty {
                errorMessage = "Email Not Registered"
                presentAlert = true
            }
            else {
                try await Auth.auth().sendPasswordReset(withEmail: email)
                errorMessage = "Password reset link has been sent"
                presentAlert = true
            }
        }
        catch {
            isLoading = false
            errorMessage = "Failed to send reset password link , try again!"
            presentAlert = true
            
        }
        isLoading = false
        
    }
}

