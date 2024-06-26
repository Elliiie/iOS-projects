//
//  CarsLibApp.swift
//  CarsLib
//
//  Created by Elena Georgieva on 7.05.24.
//

import SwiftUI
import SwiftData

@main
struct CarsLibApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Car.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            BrandsListView(modelContext: sharedModelContainer.mainContext)
        }
        .modelContainer(sharedModelContainer)
    }
}
