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

// @todo: make UIColor & olor extension
struct K {
    static let primaryColor = UIColor(named: "primaryColor")
    static let textStrongColor = UIColor(named: "textStrongColor")
    static let textSoftColor = UIColor(named: "textSoftColor")
    static let themeColor = UIColor(named: "themeColor")
    
//    static let paddingX: CGFloat = 30
}

// @todo: split
struct DefaultGradient: View {
    
    let gradient = Gradient(colors: [
        Color(K.primaryColor!).opacity(0.5),
        Color(K.themeColor!).opacity(1)
    ])
    
    var body: some View {
        LinearGradient(
            gradient: gradient,
            startPoint: .top,
            endPoint: .bottom
        )
        // @todo: delete this line
        .edgesIgnoringSafeArea(.all)
    }
}
