//
//  AllenSwiftUI_7_0_0_IntegrationTestApp.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/17.
//

import SwiftUI

@main
struct AllenSwiftUI_7_0_0_IntegrationTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
