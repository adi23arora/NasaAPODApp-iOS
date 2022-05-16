//
//  NasaPODAppApp.swift
//  NasaPODApp
//
//  Created by Aditya Arora on 16/05/22.
//

import SwiftUI

@main
struct NasaPODAppApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            PODContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
