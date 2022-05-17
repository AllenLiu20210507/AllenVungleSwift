//
//  AllenSwiftUI_7_0_0_IntegrationTestApp.swift
//  AllenSwiftUI_7.0.0_IntegrationTest
//
//  Created by allen.liu on 2022/5/17.
//

import SwiftUI
import vng_ios_sdk
import AppTrackingTransparency

@main
struct AllenSwiftUI_7_0_0_IntegrationTestApp: App {
    let persistenceController = PersistenceController.shared
    init() {
        if Vungle.isInitialized() {
            print("[AllenTestApp Log] SDK is already initialized on launch? There's a problem.")
            return
        }
        
        Vungle.initWithAppId(Configs().appId) { error in
            if let error = error {
                print("[AllenTestApp Log] SDK failed to initialize with error \(error).")
            } else {
                
                print("[AllenTestApp Log] SDK successfully initialized.")
                ATTrackingManager.requestTrackingAuthorization { authorizationStatus in
                    print("[AllenTestApp Log] ATT status \(authorizationStatus.rawValue)")
                }
            }
        }
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
