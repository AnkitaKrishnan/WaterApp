//
//  ContentView.swift
//  WaterApp
//
//  Created by Ankita Krishnan on 22/09/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isFirstLaunch = !UserDefaults.standard.bool(forKey: "isSetupComplete")
    @State private var showingSettings = false
    @State private var showingBMI = false
    
    var body: some View {
        NavigationView {
            if isFirstLaunch {
                SetupView(isFirstLaunch: $isFirstLaunch) // First-time setup
            } else {
                WaterTrackingView() // After setup
                    .navigationBarItems(
                        leading: Button(action: {
                            showingBMI = true
                        }) {
                            Image(systemName: "scalemass")
                                .font(.title)
                        },
                        trailing: Button(action: {
                            showingSettings = true
                        }) {
                            Image(systemName: "gearshape")
                                .font(.title)
                        })
                    .sheet(isPresented: $showingSettings) {
                        SettingsView() // Access to update settings later
                    }
                    .sheet(isPresented: $showingBMI) {
                        BMIView() // Access to BMI page
                    }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}







