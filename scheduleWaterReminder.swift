//
//  scheduleWaterReminder.swift
//  WaterApp
//
//  Created by Ankita Krishnan on 23/09/24.
//

import UserNotifications
import SwiftUI

func scheduleWaterReminder() {
    let center = UNUserNotificationCenter.current()
    
    // Request notification permissions
    center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if granted {
            // Fetch user details from UserDefaults
            let userName = UserDefaults.standard.string(forKey: "userName") ?? "User"
            let wakeUpTime = UserDefaults.standard.object(forKey: "wakeUpTime") as? Date ?? Date()
            let sleepTime = UserDefaults.standard.object(forKey: "sleepTime") as? Date ?? Date().addingTimeInterval(8 * 60 * 60) // Default sleep time 8 hours from now
            
            // Calculate total active time from wake up to sleep (in seconds)
            let activeInterval = sleepTime.timeIntervalSince(wakeUpTime)
            
            // Ensure activeInterval is positive
            guard activeInterval > 0 else { return }
            
            let content = UNMutableNotificationContent()
            content.title = "Hey \(userName), Time to Drink Water!"
            content.body = "Please drink 250ml of water to stay hydrated."
            content.sound = .default
            content.userInfo = ["action": "drinkWater"] // Custom payload to track the action
            
            // Create triggers spaced out based on active hours (e.g., every 2 hours within the active range)
            let intervalBetweenReminders: TimeInterval = 2 * 60 * 60 // 2 hours in seconds
            let numberOfReminders = Int(activeInterval / intervalBetweenReminders)
            
            for i in 0..<numberOfReminders {
                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: intervalBetweenReminders * Double(i), repeats: false)
                let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                
                center.add(request)
            }
        } else if let error = error {
            print("Permission denied: \(error.localizedDescription)")
        }
    }
}
