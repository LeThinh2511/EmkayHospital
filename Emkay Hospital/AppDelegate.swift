//
//  AppDelegate.swift
//  Emkay Hospital
//
//  Created by ThinhLe on 3/29/19.
//  Copyright © 2019 ThinhLe. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        preparePushNotifications(for: application)
        let notificationName = NotificationName.accessTokenExpired
        NotificationCenter.default.addObserver(self, selector: #selector(accessTokenExpiredHandler), name: notificationName, object: nil)
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        let storyboardName = UIStoryboard.patientStoryboard
        let selectPatientViewController: SelectPatientViewController = UIStoryboard.initViewController(in: storyboardName)
        self.window?.rootViewController?.present(selectPatientViewController, animated: true, completion: nil)
        let tabBarController: PatientTabBarController = UIStoryboard.initViewController(in: storyboardName)
        selectPatientViewController.present(tabBarController, animated: true, completion: nil)
    }
    
    func preparePushNotifications(for application: UIApplication) {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            guard granted else {
                return
            }
            DispatchQueue.main.async {
                application.registerForRemoteNotifications()
            }
        }
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map{ String(format: "%02.2hhx", $0) }.joined()
        Service.deviceID = token
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print(error.localizedDescription)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        debugPrint("Received: \(userInfo)")
        completionHandler(.newData)
    }
    
    @objc func accessTokenExpiredHandler() {
        guard let rootViewController = window?.rootViewController as? LoginViewController else {
            return
        }
        rootViewController.dismiss(animated: true, completion: nil)
        rootViewController.showAlert(title: Strings.alertTitle, message: Messages.accessTokenExpired)
    }
}

