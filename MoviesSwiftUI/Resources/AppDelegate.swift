//
//  AppDelegate.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        #if DEBUG
               // Short-circuit starting app if running unit tests
               let isUnitTesting = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
               guard !isUnitTesting else {
                   return true
               }
       #endif
        
        // @todo: Style large title
        // @todo: refacto "K" -> extensions (cgfloat, color, etc...)
        setTabBarAppearance()
//        setUpNavBarAppearance()
        setUpListAppearance()
        return true
    }
    
    func setTabBarAppearance() {
        
        let appearance = UITabBar.appearance()
        
        
        appearance.backgroundColor = K.themeColor
    
        appearance.shadowImage =  .tabBarShadow
        appearance.backgroundImage = .clear
        
        appearance.unselectedItemTintColor = K.textSoftColor
    }
    
    func setUpNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithTransparentBackground()
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
        UINavigationBar.appearance().standardAppearance = coloredAppearance
//        UINavigationBar.appearance().compactAppearance = coloredAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
//        UINavigationBar.appearance().tintColor = K.textStrongColor
        
    }
    
    func setUpListAppearance() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
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


}

