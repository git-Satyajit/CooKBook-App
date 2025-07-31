
//  RegisterView.swift
//  CookBook

//  Created by Satyajit Bhol on 02/07/25.

import SwiftUI

struct RegisterView: View {
    @State var viewModel = RegisterViewModel()
    @Environment(\.dismiss) var dismiss
    @Environment(SessionManager.self) var sessionManager: SessionManager
    var body: some View {
      ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                VStack(alignment:.leading,spacing: 20) {
                    
                    
                    Text("Username")
                        .font(.system(size: 15))
                    TextField("Enter Username", text: $viewModel.username)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(AuthTextFieldStyle())
                    Text("Email")
                        .font(.system(size: 15))
                    TextField("Enter Email", text: $viewModel.email)
                        .keyboardType(.emailAddress)
                        .textFieldStyle(AuthTextFieldStyle())
                    Text("Password")
                        .font(.system(size: 15))
                    PasswordComponentView(showPassword: $viewModel.showPassword, password: $viewModel.password)
                    
                    Button {
                        Task {
                            if (await viewModel.signup()) != nil{
                                sessionManager.sessionState = .loggedIn
                            }
                            
                        }
                    } label: {
                        Text("Sign Up")
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    HStack {
                        Spacer()
                        Text("Already have an Account ?")
                            .font(.system(size: 15,weight:.semibold))
                        Button {
                            dismiss()
                        } label: {
                            Text("Login Now")
                                .font(.system(size: 15,weight:.semibold))
                        }
                        Spacer()
                    }
                    .padding(.top,10)
                    
                    
                    
                    
                }
                .padding()
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .shadow(radius: 8)
                .padding(.horizontal,20)
                .padding(.top,60)
                
                if viewModel.isLoading {
                    LoadingComponentView()
                }
            }
            .alert("Error", isPresented: $viewModel.presentAlert) {
                
            } message: {
                Text(viewModel.errorMessage)
            }
            
        }
    }


        
    
#Preview {
    RegisterView()
        .environment(SessionManager())
}
