//
//  ExpenseDiaryApp.swift
//  ExpenseDiary
//
//  Created by Gopabandhu Dash on 10/12/23.
//

import SwiftUI

@main
struct ExpenseDiaryApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
