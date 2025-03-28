//
//  ScannerFlutterApp.swift
//  ScannerFlutter
//
//  Created by Julian Perez on 3/28/25.
//

import SwiftUI

@main
struct ScannerFlutterApp: App {
    let persistenceController = PersistenceController.shared
    @State var flutterDependencies = FlutterDependencies()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .environment(flutterDependencies)
        }
    }
}
