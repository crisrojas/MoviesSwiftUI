//
//  ContentView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import UIKit


// MARK: - TabbScreen View
struct TabbarScreen: View {
    
    var body: some View {
        
        TabView {

           
            tab(.more, content: MoreScreen.init)
            tab(.home, content: HomeScreen.init)
            tab(.search, content: MovieSearchView.init)
            
        }
        .accentColor(Color(K.textStrongColor!))
    }
}

// MARK: - Tab
private extension TabbarScreen {
    
    func tab<Content: View>(_ tab: Tab, content: () -> Content) -> some View {
        
        NavigationView { content() }
            .tabItem {
                Label(tab.title, systemImage: tab.image)
            }
            .tag(tab)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TabbarScreen()
    }
}

