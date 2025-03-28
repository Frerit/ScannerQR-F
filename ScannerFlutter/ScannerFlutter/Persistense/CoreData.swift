//
//  CoreData.swift
//  ScannerFlutter
//
//  Created by Julian Perez on 3/28/25.
//

import CoreData
import CryptoKit

class CoreDataStack: ObservableObject {
   static let shared = CoreDataStack()
   
   // MARK: Properties
   private let secretKey: SymmetricKey
   
   lazy var persistentContainer: NSPersistentContainer = {
        
       let container = NSPersistentContainer(name: "ScannerFlutter")
        
       container.loadPersistentStores { _, error in
           if let error = error as NSError? {
               fatalError("Error al cargar el contenedor de CoreData: \(error), \(error.userInfo)")
           }
       }
       return container
   }()
       
   private init() {
      let keyString = "APP123456789012345678901234567890"
       guard let keyData = keyString.data(using: .utf8) else {
           fatalError("Could not convert key string to data")
       }
       let paddedKeyData = keyData.prefix(32)
       self.secretKey = SymmetricKey(data: paddedKeyData)
   }
   
   var context: NSManagedObjectContext {
       return persistentContainer.viewContext
   }
   
   func saveData(username: String, password: String, method: String, uuid: UUID) {
       let user = PersistUser(context: context)
       user.uuid = uuid
       user.username = username
       user.typeAuth = method
       user.password = encrypt(password: password) ?? ""
       user.dateAuth = Date.now
       user.lastUpdate = Date.now
        
       if context.hasChanges {
           do {
               try context.save()
           } catch {
               let nserror = error as NSError
               fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
           }
       }
   }
  
   func encrypt(password: String) -> String? {
       do {
           let passwordData = password.data(using: .utf8)!
           let sealedBox = try AES.GCM.seal(passwordData, using: self.secretKey)
           return sealedBox.combined?.base64EncodedString()
       } catch {
           print("Error de encriptación: \(error)")
           return nil
       }
   }
   
   func decrypt(encryptedPassword: String) -> String? {
          do {
              guard let encryptedData = Data(base64Encoded: encryptedPassword) else {  return nil }
              let openedBox = try AES.GCM.open(AES.GCM.SealedBox(combined: encryptedData), using: self.secretKey)
              return String(data: openedBox, encoding: .utf8)
          } catch {
              print("Error de desencriptación: \(error)")
              return nil
          }
   }
      

   func fetchUser(username: String, password: String) -> PersistUser? {
       let encryptedPassword = encrypt(password: password) ?? ""
       let fetchRequest = NSFetchRequest<PersistUser>(entityName: "PersistUser")
       fetchRequest.predicate = NSPredicate(format: "username == %@ AND password == %@", username, encryptedPassword)
       
       do {
           let result = try context.fetch(fetchRequest)
           let persistUser = result.first
           persistUser?.password = decrypt(encryptedPassword: encryptedPassword) ?? ""
           return persistUser
       } catch {
           let nserror = error as NSError
           fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
       }
   }
   
   func fecthUserByBiometrics(keychain: String) -> PersistUser? {
       let fetchRequest: NSFetchRequest<PersistUser> = PersistUser.fetchRequest()
       fetchRequest.predicate = NSPredicate(format: "uuid == %@", keychain)
       do {
           let result = try context.fetch(fetchRequest)
           return result.first
       } catch {
           let nserror = error as NSError
           fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
       }
   }
}
