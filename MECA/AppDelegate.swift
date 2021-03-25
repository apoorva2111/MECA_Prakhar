//
//  AppDelegate.swift
//  MECA
//
//  Created by Apoorva Gangrade on 18/03/21.
//

import UIKit
import IQKeyboardManagerSwift
import GoogleSignIn

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        GIDSignIn.sharedInstance().clientID = "365910591179-c7o6vcq049eo24todj72b5q8i3potanm.apps.googleusercontent.com"

        IQKeyboardManager.shared.enable = true

        return true
        
    }


}

