//
//  LoginView.swift
//  ScannerFlutter
//
//  Created by Julian Perez on 3/28/25.
//

import SwiftUI

struct LoginView: View {
    var success : () -> ()
    
    @StateObject var viewModel: LoginViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Image(colorScheme == .dark ? "Logo-D": "Logo")
                .resizable()
                .frame(width: 100, height: 100)
                .shadow(radius: 10)
                .padding(.bottom, 50)
            
            TextField("Usuario", text: $viewModel.username)
                .padding()
                .background(colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.04))
                .cornerRadius(10)
                .padding(.bottom, 20)
            
            SecureField("Contraseña", text: $viewModel.password)
                .padding()
                .background(colorScheme == .dark ? Color.white.opacity(0.2) : Color.black.opacity(0.04))
                .cornerRadius(10)
                .padding(.bottom, 10)
            
            if case .error(let message) = viewModel.state {
                Text(message)
                    .foregroundColor(.red)
            }
            
            Button(action: {
                viewModel.login(successLogin: success)
            }) {
                Text("Iniciar Sesión")
                    .padding()
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .background(colorScheme == .dark ? Color.white : Color.black)
                    .foregroundColor(colorScheme == .dark ? Color.black : Color.white)
                    .cornerRadius(10)
            }
            .padding(.bottom, 20)
            .padding(.top, 30)
            
            Button(action: {
                viewModel.faceIdLogin(successLogin: success)
            }) {
                HStack {
                    Spacer()
                    Image("FaceId")
                        .resizable()
                        .frame(width: 50, height: 50)
                    Spacer()
                }
                .padding()
                .frame(minWidth: 0, maxWidth:100, maxHeight: 100)
                .background(colorScheme == .dark ? Color.white : Color.black.opacity(0.3))
                .foregroundColor(.white)
                .cornerRadius(50)
            }
        }.padding(.horizontal, 20)
        
    }
}

#Preview {}
