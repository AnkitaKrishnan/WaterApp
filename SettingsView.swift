import SwiftUI

struct SettingsView: View {
    @State private var name: String = UserDefaults.standard.string(forKey: "userName") ?? ""
    @State private var age: String = UserDefaults.standard.string(forKey: "userAge") ?? ""
    @State private var sex: String = UserDefaults.standard.string(forKey: "userSex") ?? "Female"
    @State private var height: String = UserDefaults.standard.string(forKey: "userHeight") ?? ""
    @State private var weight: String = UserDefaults.standard.string(forKey: "userWeight") ?? ""
    @State private var wakeUpTime: Date = UserDefaults.standard.object(forKey: "wakeUpTime") as? Date ?? Date()
    @State private var sleepTime: Date = UserDefaults.standard.object(forKey: "sleepTime") as? Date ?? Date().addingTimeInterval(8 * 3600)
    @State private var cupSize: String = UserDefaults.standard.string(forKey: "cupSize") ?? "250"
    @State private var dailyWaterGoal: String = String(UserDefaults.standard.double(forKey: "dailyWaterGoal"))
    
    let sexes = ["Female", "Male", "Other"]

    var body: some View {
        ScrollView { // Add ScrollView to allow scrolling
            VStack {
                Text("Update Your Settings")
                    .font(.largeTitle)
                    .padding()

                TextField("Update your name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Update your age", text: $age)
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
                
                TextField("Update your height (cm)", text: $height)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Update your weight (kg)", text: $weight)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                DatePicker("Wake-up time", selection: $wakeUpTime, displayedComponents: .hourAndMinute)
                    .padding()

                DatePicker("Sleep time", selection: $sleepTime, displayedComponents: .hourAndMinute)
                    .padding()

                TextField("Update your cup size (ml)", text: $cupSize)
                    .keyboardType(.numberPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                TextField("Update daily water goal (liters)", text: $dailyWaterGoal)
                    .keyboardType(.decimalPad)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    saveSettings()
                }) {
                    Text("Save Changes")
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
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
