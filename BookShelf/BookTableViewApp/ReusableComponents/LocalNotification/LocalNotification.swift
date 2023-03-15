//
//  LocalNotification.swift
//  BookTableViewApp
//
//  Created by Paolo Cifuentes on 10/3/21.
//

import Foundation
import UIKit
import UserNotifications

class LocalNotification: NSObject {

    enum Actions {
        case action(title: String, identifier: String, option: UNNotificationActionOptions)
    }

    static let category = "category"
    static let shared = LocalNotification()
    
    override private init() {}

    private var settings: UNNotificationSettings?
    
    var isAuthorized: Bool { settings?.authorizationStatus == .authorized }
    
    func setNotification() {
        getNotificationSettings()
    }
    
    func requestAuthorization(completion: @escaping  (Bool) -> Void) {
      UNUserNotificationCenter.current()
        .requestAuthorization(options: [.alert, .sound, .badge]) { permission, _  in
          completion(permission)
        }
    }
    
    func getNotificationSettings() {
      UNUserNotificationCenter.current().getNotificationSettings { settings in
          self.settings = settings
          DispatchQueue.main.async {
              switch settings.authorizationStatus {
              case .notDetermined:
                  self.requestAuthorization { status in
                      if status {
                          UNUserNotificationCenter.current().delegate = self
                      }
                  }

              case .authorized:
                  UNUserNotificationCenter.current().delegate = self

              default:
                  break
              }
          }
      }
    }
    
    func configure(title: String,
                   subtitle: String,
                   body: String,
                   badge: Int) -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = title
        notificationContent.subtitle = subtitle
        notificationContent.body = body
        notificationContent.badge = NSNumber(value: badge)
        notificationContent.categoryIdentifier = LocalNotification.category
        return notificationContent
    }
    
    func configureRequest(content: UNNotificationContent,
                          time: TimeInterval,
                          repeats: Bool) {
        let identifier = "Login notification"
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: time, repeats: repeats)
        let request = UNNotificationRequest(identifier: identifier,
                                            content: content,
                                            trigger: trigger)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Unable to add the notification request. Error \(error) occured")
            }
        }
    }
    
    func configureActions(_ action: LocalNotification.Actions...) {
        var list = [UNNotificationAction]()
        action.forEach { action in
            switch action {
            case let .action(title: title, identifier: identifier, option: options):
                let actionNotification = UNNotificationAction(identifier: identifier, title: title, options: options)
                list.append(actionNotification)
            }
        }
        let categories = UNNotificationCategory(identifier: LocalNotification.category,
                                                actions: list,
                                                intentIdentifiers: [],
                                                options: [])
        UNUserNotificationCenter.current().setNotificationCategories([categories])
    }
    
    func deleteNotifications() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["Login notification"])
    }
}

extension LocalNotification: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        UIApplication.shared.applicationIconBadgeNumber = 0
        completionHandler()
    }
}
