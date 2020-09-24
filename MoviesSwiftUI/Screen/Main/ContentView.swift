//
//  ContentView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import UIKit

struct ContentView: View {
    
    init() {
        setTabBarAppearance()
    }
    
    var body: some View {
        TabView {
            MoviesHomeView()
                .tabItem {
                    VStack {
                        Image(systemName: "play.fill")
                            .font(Font.headline.weight(.heavy))
                    }
            }
            .tag(0)
            
            MoviesMoreView()
                .tabItem {
                    VStack {
                        Image(systemName: "tv")
                        .font(Font.headline.weight(.heavy))
                    }
            }
            .tag(1)
            
            MovieSearchView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        .font(Font.headline.weight(.heavy))

                    }
            }
            .tag(2)
            
        }
            .accentColor(Color(K.textStrongColor!))
    }
    
    func setTabBarAppearance() {
        
        let appearance = UITabBar.appearance()
        
        appearance.backgroundColor = K.themeColor
    
        appearance.shadowImage =  UIImage.getShadow()
        appearance.backgroundImage = UIImage()
        
        //
        appearance.unselectedItemTintColor = K.textSoftColor
        
        //appearance.isTranslucent = false
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension UIImage {
    static func getShadow() -> UIImage {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: 1, height: 20)
        
        let color1 = K.primaryColor!.cgColor.copy(alpha: 0.4)!
        let color2: CGColor = UIColor.white.cgColor.copy(alpha: 0)!
        gradientLayer.colors = [color2, color1]
        
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
}
