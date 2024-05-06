//
//  AppDelegate.swift
//  SoulSync
//
//  Created by Jeegrra on 02/04/2024.
//

import UIKit
import FirebaseCore
import GoogleSignIn
import FirebaseAuth
import GoogleMaps

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        if FirebaseApp.app() == nil {
            print("Firebase initialization failed.")
        } else {
            print("success")
        }
        let signInConfig = GIDConfiguration(clientID: "789768779431-ipfcmp2k7oimjlpio1svi8sif5ap28dk.apps.googleusercontent.com")
        GIDSignIn.sharedInstance.configuration = signInConfig
        // Check if user is logged in
                if Auth.auth().currentUser != nil {
                    // User is logged in, show the main tab bar controller
                    showMainTabBarController()
                } else {
                    // User is not logged in, show the login screen
                    showLoginScreen()
                }
        GMSServices.provideAPIKey("AIzaSyDzuwTbmWJdslR2d00U9wlz7DhPA1S_ZAI")
        return true
    }

    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
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
    func showMainTabBarController() {
            let mainTabBarController = MainTabBarController()
            window?.rootViewController = mainTabBarController
            window?.makeKeyAndVisible()
        }
        
        func showLoginScreen() {
            // Assuming you have a LoginViewController
            let signInVC = SignInVC()
            window?.rootViewController = signInVC
            window?.makeKeyAndVisible()
        }

}
