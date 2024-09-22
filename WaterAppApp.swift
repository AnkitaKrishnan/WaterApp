//
//  WaterAppApp.swift
//  WaterApp
//
//  Created by Ankita Krishnan on 22/09/24.
//

import SwiftUI

@main
struct WaterAppApp: App {
    // Register AppDelegate
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

