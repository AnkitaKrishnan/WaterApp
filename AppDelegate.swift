//
//  AppDelegate.swift
//  WaterApp
//
//  Created by Ankita Krishnan on 22/09/24.
//

import UIKit
import UserNotifications

class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    // Register for notifications and set the delegate
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    // Handle notification response
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        
        // Check for specific action and increase water intake
        if let action = userInfo["action"] as? String, action == "drinkWater" {
            addWaterOnNotificationTap()
        }

        completionHandler()
    }

    // Function to increase water intake
    func addWaterOnNotificationTap() {
        let cupSize = UserDefaults.standard.double(forKey: "cupSize") / 1000.0 // Cup size in liters
        var totalWaterConsumed = UserDefaults.standard.double(forKey: "totalWaterConsumed")
        totalWaterConsumed += cupSize
        
        // Save the updated water consumption
        UserDefaults.standard.set(totalWaterConsumed, forKey: "totalWaterConsumed")
    }
}


