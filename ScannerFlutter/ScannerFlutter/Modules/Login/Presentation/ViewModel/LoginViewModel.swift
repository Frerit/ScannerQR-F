//
//  LoginViewModel.swift
//  ScannerFlutter
//
//  Created by Julian Perez on 3/28/25.
//

import Foundation
import LocalAuthentication

class LoginViewModel: ObservableObject {
    
    let loginUseCase = LoginUseCase()
    
    // MARK:  The available states
    enum AuthenticationState {
        case loading, loggedout, error(String)
    }
    
    // MARK: Publisher
    
    var state: AuthenticationState = AuthenticationState.loggedout
    var username: String = ""
    var password: String = ""
    
    func login(successLogin: @escaping () -> Void) {
        self.state = .loading
        
        if self.username.isEmpty || self.password.isEmpty {
            self.state = .error("Error de Credenciales")
            return
        }
        
        // MARK: TODO Simulacion Login correcto
        if self.username == "Admin" && self.password == "1234" {
            self.faceIdLogin(successLogin: successLogin)
            return
        }
        
        loginUseCase.validateLogin(username: self.username, password: self.password) { result in
            switch result {
            case .success(let success):
                if !success.isEmpty {
                    print("Login success")
                    successLogin()
                } else {
                    self.state = .error("Error de Credenciales")
                }
            case .failure(let error):
                print(error)
                self.state = .error("Error de Credenciales")
            }
        }
    }
     
    func faceIdLogin(successLogin: @escaping () -> Void) {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Acceso al sistema") { [weak self] success, authError in
                DispatchQueue.main.async {
                    guard let self = self else { return }
                    if success {
                        let metodo = context.biometryType == .faceID ? "FaceID" : "TouchID"
                        if (self.username.isEmpty) {
                            self.loginUseCase.fecthUserUUID { user in
                                print("Login succes: \(String(describing: user.uuid))")
                                successLogin()
                            }
                        } else {
                            let uuid = UUID()
                            self.loginUseCase.signUp(username: self.username, password: self.password, method: metodo, uuid: uuid) {
                                print("Login success")
                                successLogin()
                            }
                        }
                    } else {
                        self.state = .error(authError?.localizedDescription ?? "")
                    }
                }
            }
        } else {
            DispatchQueue.main.async {
                print("Dispositivo no compatible: \(error?.localizedDescription ?? "")")
                self.state = .error("Dispositivo no compatible")
            }
        }
    }
}
