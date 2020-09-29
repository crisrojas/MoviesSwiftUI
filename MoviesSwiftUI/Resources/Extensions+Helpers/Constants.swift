//
//  UIColor.swift
//  MoviesSwiftUI
//
//  Created by cristian on 23/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Foundation
import SwiftUI
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
        
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().standardAppearance = appearance
        
        
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.configureWithTransparentBackground()
//        coloredAppearance.backgroundColor = K.primaryColor
        coloredAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        coloredAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]
//
//        UINavigationBar.appearance().standardAppearance = coloredAppearance
//        UINavigationBar.appearance().compactAppearance = coloredAppearance
//        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
//        UINavigationBar.appearance().tintColor = K.textStrongColor
        
    }
    
    static func setUpListAppearance() {
        UITableView.appearance().backgroundColor = .clear
        UITableViewCell.appearance().backgroundColor = .clear
        UITableView.appearance().separatorStyle = .none
    }
}

struct bgGradient: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [Color(K.primaryColor!).opacity(0.5), Color(K.themeColor!).opacity(1)]),startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
    }
}
