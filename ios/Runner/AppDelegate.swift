// import Flutter
// import UIKit

// @main
// @objc class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
//     GeneratedPluginRegistrant.register(with: self)
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
// }


// import UIKit
// import Flutter
// import Firebase // Add this import
// import FirebaseMessaging // For FCM
// import UserNotifications // For notification permissions

// @main
// class AppDelegate: FlutterAppDelegate {
//   override func application(
//     _ application: UIApplication,
//     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
//   ) -> Bool {
      
//     // 1. Initialize Firebase (must come before plugin registration)
//     FirebaseApp.configure()
    
//     // 2. Register plugins (including firebase_messaging)
//     GeneratedPluginRegistrant.register(with: self)
    
//     // 3. Set up notification delegates
//     UNUserNotificationCenter.current().delegate = self
//     Messaging.messaging().delegate = self
    
//     // 4. Request notification permissions (optional)
//     requestNotificationPermissions()
    
//     return super.application(application, didFinishLaunchingWithOptions: launchOptions)
//   }
  
//   private func requestNotificationPermissions() {
//     UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
//       print("Notification permissions granted: \(granted)")
//     }
//   }
// }

// // MARK: - Notification Delegates
// extension AppDelegate: UNUserNotificationCenterDelegate {
//   // Handle notifications while app is in foreground
//   func userNotificationCenter(
//     _ center: UNUserNotificationCenter,
//     willPresent notification: UNNotification,
//     withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
//   ) {
//     completionHandler([[.banner, .sound, .badge]]) // Show notification even in foreground
//   }
  
//   // Handle notification taps
//   func userNotificationCenter(
//     _ center: UNUserNotificationCenter,
//     didReceive response: UNNotificationResponse,
//     withCompletionHandler completionHandler: @escaping () -> Void
//   ) {
//     completionHandler()
//   }
// }

// extension AppDelegate: MessagingDelegate {
//   func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//     print("Firebase registration token: \(fcmToken ?? "")")
//   }
// }

import UIKit
import Flutter
import Firebase
import FirebaseMessaging
import UserNotifications

@main
class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GeneratedPluginRegistrant.register(with: self)
    UNUserNotificationCenter.current().delegate = self
    Messaging.messaging().delegate = self
    requestNotificationPermissions()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  
  private func requestNotificationPermissions() {
    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
      print("Notification permissions granted: \(granted)")
    }
  }
}

// MARK: - Notification Delegates
extension AppDelegate {
  
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    willPresent notification: UNNotification,
    withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void
  ) {
    if #available(iOS 14.0, *) {
        completionHandler([.banner, .sound, .badge])
    } else {
        completionHandler([.alert, .sound, .badge])
    }
  }
  
  override func userNotificationCenter(
    _ center: UNUserNotificationCenter,
    didReceive response: UNNotificationResponse,
    withCompletionHandler completionHandler: @escaping () -> Void
  ) {
    completionHandler()
  }
}

// MARK: - FCM Delegate
extension AppDelegate: MessagingDelegate {
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
    print("Firebase registration token: \(fcmToken ?? "")")
  }
}
