//
//  SetupView.swift
//  WaterApp
//
//  Created by Ankita Krishnan on 22/09/24.
//

import SwiftUI

struct SetupView: View {
    @Binding var isFirstLaunch: Bool
    @State private var name: String = ""
    @State private var age: String = ""
    @State private var sex: String = "Female"
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var wakeUpTime: Date = Date()
    @State private var sleepTime: Date = Date().addingTimeInterval(8 * 3600) // Default to 8 hours later
    @State private var cupSize: String = "250" // Default cup size in ml
    @State private var calculatedWaterGoal: Double = 0.0
    @State private var dailyWaterGoal: String = ""
    
    let sexes = ["Female", "Male", "Other"]
    
    var body: some View {
        ScrollView { // Add ScrollView to allow scrolling
            VStack {
                Text("Let's set up your profile!")
                    .font(.largeTitle)
                    .padding()

                TextField("Enter your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Enter your age", text: $age)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Picker("Sex", selection: $sex) {
                    ForEach(sexes, id: \.self) { sex in
                        Text(sex)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                TextField("Enter your height (cm)", text: $height)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Enter your weight (kg)", text: $weight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                DatePicker("Wake-up time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                    .padding()

                DatePicker("Sleep time", selection: $sleepTime, displayedComponents: .hourAndMinute)
                    .padding()

                TextField("Enter your cup size (ml)", text: $cupSize)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                // Automatically calculate recommended water goal based on weight
                Button(action: calculateWaterGoal) {
                    Text("Calculate Water Goal")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()

                // Show the calculated goal and allow the user to adjust it
                if calculatedWaterGoal > 0 {
                    VStack {
                        Text("Calculated Water Goal: \(calculatedWaterGoal, specifier: "%.2f") L")
                            .font(.subheadline)
                            .padding()

                        TextField("Adjust daily water goal (liters)", text: $dailyWaterGoal)
                            .keyboardType(.decimalPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding()
                    }
                }

                Button(action: {
                    saveSettings()
                    isFirstLaunch = false
                }) {
                    Text("Start Tracking")
                        .font(.headline)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding()
        }
    }

    func calculateWaterGoal() {
        guard let weightInKg = Double(weight) else {
            return
        }

        // Basic calculation: 0.033 liters of water per kg of body weight
        calculatedWaterGoal = weightInKg * 0.033

        // Allow user to further adjust
        dailyWaterGoal = String(format: "%.2f", calculatedWaterGoal)
    }

    func saveSettings() {
        UserDefaults.standard.set(name, forKey: "userName")
        UserDefaults.standard.set(age, forKey: "userAge")
        UserDefaults.standard.set(sex, forKey: "userSex")
        UserDefaults.standard.set(height, forKey: "userHeight")
        UserDefaults.standard.set(weight, forKey: "userWeight")
        UserDefaults.standard.set(wakeUpTime, forKey: "wakeUpTime")
        UserDefaults.standard.set(sleepTime, forKey: "sleepTime")
        UserDefaults.standard.set(cupSize, forKey: "cupSize")
        if let goal = Double(dailyWaterGoal) {
            UserDefaults.standard.set(goal, forKey: "dailyWaterGoal")
        }
        UserDefaults.standard.set(true, forKey: "isSetupComplete")
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView(isFirstLaunch: .constant(true))
    }
}

