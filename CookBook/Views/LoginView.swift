//
//  LoginView.swift
//  CookBook

import SwiftUI

struct LoginView: View {
    @State var viewModel =  LoginViewModel()
    @Environment(SessionManager.self) var sessionManager: SessionManager
   
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(alignment: .leading, spacing: 12) {
                Text("Email")
                    .font(.system(size: 15))
                TextField("Enter Email", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textFieldStyle(AuthTextFieldStyle())

                
                Text("Password")
                    .font(.system(size: 15))
                PasswordComponentView(showPassword: $viewModel.showPassword, password: $viewModel.password)
            
                Button {
                    Task{
                         if let user =     await viewModel.login(){
                            sessionManager.currentUser = user
                            sessionManager.sessionState = .loggedIn
                        }
                        
                    }
                    
                } label: {
                    Text("Login")
                }
                .buttonStyle(PrimaryButtonStyle())
                HStack {
                    Spacer()
                    Button {
                        Task {
                            await viewModel.sendPasswordReset()
                        }
                        
                    } label: {
                        Text("Forgot Password?")
                            .font(.system(size: 15,weight: .semibold))
                            
                    }
                    Spacer()
                }

                HStack {
                    Spacer()
                    Text("Don't have an Account ?")
                        .font(.system(size: 15,weight:.semibold))
                    Button {
                        viewModel.presentRegisterView = true
                    } label: {
                        Text("Register Now")
                            .font(.system(size: 15,weight:.semibold))
                    }
                    Spacer()
                }
                .padding(.top,20)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .shadow(radius: 8)
            .padding(.horizontal, 20)
            .padding(.top, 60)
            .fullScreenCover(isPresented: $viewModel.presentRegisterView) {
                RegisterView()
            }
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
    LoginView()
        .environment(SessionManager())
}
