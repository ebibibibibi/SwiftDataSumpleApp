//
//  SwiftDataSumpleAppApp.swift
//  SwiftDataSumpleApp
//
//  Created by TakahashiKotomi on 2024/01/03.
//

import SwiftUI
import SwiftData

@main
struct SwiftDataSumpleApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
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
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
