//
//  ExpenseDiaryApp.swift
//  ExpenseDiary
//
//  Created by Gopabandhu Dash on 10/12/23.
//

import SwiftUI

@main
struct ExpenseDiaryApp: App {
    let coreDataStack = CoreDataStack()

    var body: some Scene {
        WindowGroup {
            HomeView()
                .environment(\.managedObjectContext, coreDataStack.persistentContainer.viewContext)
        }
    }
}
