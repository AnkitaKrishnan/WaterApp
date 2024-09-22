import SwiftUI

struct WaterTrackingView: View {
    @State private var totalWaterConsumed: Double = 0.0
    
    // Fetch the cup size and daily water goal from UserDefaults
    let cupSize: Double = UserDefaults.standard.double(forKey: "cupSize") != 0.0 ? UserDefaults.standard.double(forKey: "cupSize") / 1000.0 : 0.25 // Default to 250 ml, convert to liters
    let dailyWaterGoal: Double = UserDefaults.standard.double(forKey: "dailyWaterGoal") != 0.0 ? UserDefaults.standard.double(forKey: "dailyWaterGoal") : 3.0 // Default to 3 liters
    
    var body: some View {
        VStack {
            Text("Water Consumed: \(totalWaterConsumed, specifier: "%.2f") L / \(dailyWaterGoal, specifier: "%.2f") L")
                .font(.headline)
                .padding(.top, 20)
            
            Spacer()

            ZStack(alignment: .bottom) {
                // Water droplet background outline
                Image(systemName: "drop.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(.blue.opacity(0.2)) // Light outline of the droplet

                GeometryReader { geometry in
                    ForEach(0..<Int(totalWaterConsumed / cupSize), id: \.self) { index in
                        Rectangle()
                            .fill(totalWaterConsumed > dailyWaterGoal ? Color.green : Color.blue) // Blue for normal, green for overconsumption
                            .frame(width: geometry.size.width, height: geometry.size.height / CGFloat(dailyWaterGoal / cupSize)) // Divide the height by water goals in steps
                            .position(x: geometry.size.width / 2, y: geometry.size.height - CGFloat(index) * geometry.size.height / CGFloat(dailyWaterGoal / cupSize)) // Place the line from bottom
                    }
                    .mask(
                        Image(systemName: "drop.fill") // Mask everything outside the droplet shape
                            .resizable()
                            .scaledToFit()
                            .frame(width: geometry.size.width, height: geometry.size.height)
                    )
                }
                .frame(width: 200, height: 200)
            }
            .onTapGesture {
                addWater()
            }

            Spacer()
        }
        .padding()
    }

    // Add water based on cup size
    func addWater() {
        totalWaterConsumed += cupSize
    }
}

struct WaterTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        WaterTrackingView()
    }
}
