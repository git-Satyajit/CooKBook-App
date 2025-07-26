//
//  PasswordComponentView.swift
//  CookBook
//
//  Created by Satyajit Bhol on 02/07/25.
//

import SwiftUI

struct PasswordComponentView: View {
    @Binding var showPassword: Bool
    @Binding var password: String
    var body: some View {
         
        if showPassword  {
            TextField("Enter Password", text: $password)
                .textFieldStyle(AuthTextFieldStyle())
                .overlay(alignment: .trailing) {
                    Button {
                        showPassword = false
                    } label: {
                        Image(systemName: "eye")
                            .foregroundStyle(Color.black)
                            .padding(.bottom,15)
                    }
                }
        }
        else {
            VStack {
                SecureField("Enter Password", text: $password)
                    .font(.system(size:14))
                    .textInputAutocapitalization(.never)
                
                Rectangle()
                    .fill(Color.border)
                    .frame(height:1)
                    .padding(.bottom,15)
            }
            .overlay(alignment: .trailing) {
                Button {
                    showPassword = true
                } label: {
                    Image(systemName: "eye.slash")
                        .foregroundStyle(Color.black)
                        .padding(.bottom,15)
                }
            }
        }
        
    }
}

#Preview {
    PasswordComponentView(showPassword: .constant(false), password: .constant(""))
}
