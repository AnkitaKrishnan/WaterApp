//
//  BMIView.swift
//  WaterApp
//
//  Created by Ankita Krishnan on 22/09/24.
//

import SwiftUI

struct BMIView: View {
    @State private var weight = UserDefaults.standard.string(forKey: "userWeight") ?? "0"
    @State private var height = UserDefaults.standard.string(forKey: "userHeight") ?? "0"
    
    var body: some View {
        VStack {
            Text("Your BMI")
                .font(.largeTitle)
                .bold()
                .padding(.top, 20)
            
            // Display the calculated BMI
            Text("BMI: \(calculateBMI(weight: weight, height: height))")
                .font(.title)
                .padding(.top, 10)
            
            // Show the ideal BMI range
            Text("Ideal BMI Range: 18.5 - 24.9")
                .font(.headline)
                .padding(.top, 10)
            
            // Display the BMI category based on the calculated BMI
            Text("BMI Category: \(bmiCategory(bmi: calculateBMI(weight: weight, height: height)))")
                .font(.subheadline)
                .padding(.top, 10)
        }
        .navigationBarTitle("BMI", displayMode: .inline)
        .padding()
        .onAppear {
            fetchUserDetails() // Fetch user details when the view appears
        }
    }
    
    // Function to calculate BMI
    func calculateBMI(weight: String, height: String) -> String {
        guard let weight = Double(weight), let height = Double(height) else {
            return "Configure Settings"
        }
        let heightInMeters = height / 100.0
        let bmi = weight / (heightInMeters * heightInMeters)
        return String(format: "%.2f", bmi)
    }
    
    // Function to return BMI category based on BMI value
    func bmiCategory(bmi: String) -> String {
        guard let bmiValue = Double(bmi) else { return "Invalid BMI" }
        
        switch bmiValue {
        case ..<18.5:
            return "Underweight"
        case 18.5...24.9:
            return "Normal weight"
        case 25...29.9:
            return "Overweight"
        case 30...:
            return "Obese"
        default:
            return "Unknown"
        }
    }
    
    // Function to fetch the user-provided height and weight from UserDefaults
    func fetchUserDetails() {
        weight = UserDefaults.standard.string(forKey: "userWeight") ?? "0"
        height = UserDefaults.standard.string(forKey: "userHeight") ?? "0"
    }
}

struct BMIView_Previews: PreviewProvider {
    static var previews: some View {
        BMIView()
    }
}

