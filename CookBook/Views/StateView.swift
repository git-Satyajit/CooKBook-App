//
//  StateView.swift
//  CookBook
//
//  Created by Satyajit Bhol on 01/07/25.
//

import SwiftUI

struct StateView: View {
    @State private var email = ""
    @State private var password = ""
    var body: some View {
        ZStack {
            Color(.systemGroupedBackground)
                .ignoresSafeArea()
            VStack(alignment:.leading,spacing: 20){
                Text("Email")
                    .font(.system(size: 15))
                TextField("Enter Email", text: $email)
                    .font(.system(size: 14))
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                Rectangle()
                    .frame(height:1)
                    .foregroundStyle(Color.border)
                    .padding(.bottom,10)
                Text("Password")
                    .font(.system(size: 15))
                SecureField("Enter Password", text: $password)
                    .font(.system(size: 14))
                    .textInputAutocapitalization(.never)
                Rectangle()
                    .frame(height:1)
                    .foregroundStyle(Color.border)
                    .padding(.bottom,20)
                Button {
                    
                } label: {
                    Text("Login")
                        .font(.system(size:20))
                        .foregroundStyle(Color.white)
                        .padding(12)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                HStack{
                    Spacer()
                    Text("Don't Have An Account?")
                        .font(.system(size: 15,weight: .semibold))
                    Button {
                        
                    } label: {
                        Text("Register Now")
                            .font(.system(size: 15,weight: .light))
                    }
                    
                    Spacer()
                }
                .padding(.top,10)
                
                
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(15)
            .shadow(radius:8)
            .padding(.horizontal,10)
            .padding(.top,60)
        }
        
    }
}

#Preview {
    StateView()
}
