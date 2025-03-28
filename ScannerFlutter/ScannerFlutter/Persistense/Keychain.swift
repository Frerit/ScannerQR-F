//
//  Keychain.swift
//  ScannerFlutter
//
//  Created by Julian Perez on 3/28/25.
//

import Foundation

class KeychainManager {
    // Singleton para acceder al manager
    static let shared = KeychainManager()
    
    private init() {}
    
    // Guardar UUID en Keychain
    func save(_ uuid: UUID, forKey key: String) -> Bool {
        // Convertir UUID a Data
        let uuidString = uuid.uuidString
        guard let data = uuidString.data(using: .utf8) else {
            print("Error: No se pudo convertir UUID a Data")
            return false
        }
        
        // Configurar query para Keychain
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        // Primero intentar borrar si existe
        SecItemDelete(query as CFDictionary)
        
        // Guardar nuevo valor
        let status = SecItemAdd(query as CFDictionary, nil)
        
        return status == errSecSuccess
    }
    
    // Recuperar UUID de Keychain
    func retrieve(forKey key: String) -> UUID? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &result)
        
        guard status == errSecSuccess,
              let data = result as? Data,
              let uuidString = String(data: data, encoding: .utf8),
              let uuid = UUID(uuidString: uuidString) else {
            print("Error: No se pudo recuperar UUID")
            return nil
        }
        
        return uuid
    }
    
    // Eliminar UUID del Keychain
    func deleteUUID(forKey key: String) -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
    
    // Generar y guardar un nuevo UUID si no existe
    func getOrCreateUUID(forKey key: String) -> UUID {
        if let existingUUID = retrieve(forKey: key) {
            return existingUUID
        }
        
        let newUUID = UUID()
        _ = save(newUUID, forKey: key)
        return newUUID
    }
}
