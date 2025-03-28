//
//  ContentView.swift
//  ScannerFlutter
//
//  Created by Julian Perez on 3/28/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationView {
            NavigationStack { 
                LoginView(success: {
                    self.isLoggedIn = true
                }, viewModel: LoginViewModel())
            }
        }.fullScreenCover(isPresented: $isLoggedIn) {
            ScannerView()
        }
    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
