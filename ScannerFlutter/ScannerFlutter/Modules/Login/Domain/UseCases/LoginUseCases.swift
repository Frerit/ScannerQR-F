//
//  LoginUseCases.swift
//  ScannerFlutter
//
//  Created by Julian Perez on 3/28/25.
//

import Foundation

class LoginUseCase {
    
    enum LoginTypes {
        case success(String)
        case failure(String)
    }
    
    func validateLogin(username: String, password: String, callback: @escaping (LoginTypes) -> Void) -> Void {
        let user = CoreDataStack.shared.fetchUser(username: username, password: password)
        if user != nil {
            callback(.success(username))
        } else {
            callback(.failure("Invalid credentials"))
        }
    }
    
    func fetchBiometrics(uuid: String, success: @escaping (PersistUser) -> Void) {
        let user = CoreDataStack.shared.fetchUser(username: uuid, password: "")
        if user != nil {
            success(user!)
        }
    }
    
    func signUp(username: String, password: String, method: String, uuid: UUID, success: @escaping () -> Void) {
        let user = CoreDataStack.shared.saveData(username: username, password: password, method: method, uuid: uuid)
        let keychain = KeychainManager.shared.save(uuid, forKey: "UserUUID")
        success()
    }
    
    func fecthUserUUID(success: @escaping (PersistUser) -> Void) {
        let keychain = KeychainManager.shared.getOrCreateUUID(forKey: "UserUUID")
        let user = CoreDataStack.shared.fecthUserByBiometrics(keychain: keychain.uuidString)
        if user != nil {
            success(user!)
        }
    }
}
