//
//  AppDelegate.swift
//  SightCallAgent
//
//  Created by Jason Jobe on 4/22/21.
//

import UIKit
import LSUniversalSDK

@main
class AppDelegate: UIResponder, UIApplicationDelegate, SightCallProvider {
    
    var sightCallSDK: SightCallSDK!
//    var lsUniversal: LSUniversal?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
//        self.lsUniversal = LSUniversal()
        sightCallSDK = SightCallSDK()
        sightCallSDK.timeout = 20.0

        application.registerForRemoteNotifications()
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


    var remoteNotificationToken: Data?
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print(#function, deviceToken.hexEncodedString())
        sightCallSDK.notificationToken = deviceToken.hexEncodedString()
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print (#function, error.localizedDescription)
    }
}

// MARK: SightCall Bridging

extension AppDelegate {
    @IBAction
    func registerAsAgent(_ sender: Any?) {
        if let url = UIPasteboard.general.url {
            sightCallSDK.registerAsAgent(url.absoluteString)
        }
        else if let url_s = UIPasteboard.general.string {
            sightCallSDK.registerAsAgent(url_s)
        }
    }
}
