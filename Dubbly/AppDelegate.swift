//
//  AppDelegate.swift
//  Dubbly
//
//  Created by Shachish Sneh on 07/02/24.
//

import UIKit
import GoogleSignIn


@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    //google client id 345774184682-uog825hf1o31nv8mlibb82t9v0cepbbf.apps.googleusercontent.com
    
    //func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    // Thread.sleep(forTimeInterval: 1.0)
    // Override point for customization after application launch.
    //        GIDSignIn.sharedInstance.clientID = "345774184682-uog825hf1o31nv8mlibb82t9v0cepbbf.apps.googleusercontent.com"
    //        return true
    
    //    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    //        GIDSignIn.sharedInstance.clientID = "345774184682-uog825hf1o31nv8mlibb82t9v0cepbbf.apps.googleusercontent.com"
    //
    //        return true
    //
    //    }
    //    }
    func application(
        _ app: UIApplication,
        open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
    ) -> Bool {
        var handled: Bool
        
        handled = GIDSignIn.sharedInstance.handle(url)
        if handled {
            return true
        }
        
        // Handle other custom URL types.
        
        // If not handled by this app, return false.
        return false
    }
}

func application(
  _ application: UIApplication,
  didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
) -> Bool {
  GIDSignIn.sharedInstance.restorePreviousSignIn { user, error in
    if error != nil || user == nil {
      // Show the app's signed-out state.
    } else {
      // Show the app's signed-in state.
    }
  }
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
    
    func application(_ app: UIApplication, open url: URL , options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
        return (GIDSignIn.sharedInstance.handle(url))
    }




