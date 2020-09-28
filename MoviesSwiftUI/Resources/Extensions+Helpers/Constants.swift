//
//  UIColor.swift
//  MoviesSwiftUI
//
//  Created by cristian on 23/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation
import UIKit


struct K {
    static let primaryColor = UIColor(named: "primaryColor")
    static let textStrongColor = UIColor(named: "textStrongColor")
    static let textSoftColor = UIColor(named: "textSoftColor")
    static let themeColor = UIColor(named: "themeColor")
    
    static let paddingX: CGFloat = 30
    
    static func setUpNavBarAppearance() {
        let appearance = UINavigationBarAppearance()
               appearance.configureWithTransparentBackground()
               
               UINavigationBar.appearance().scrollEdgeAppearance = appearance
               UINavigationBar.appearance().standardAppearance = appearance
               
               
        UINavigationBar.appearance().tintColor = K.textStrongColor
    }
    
    
    
}
