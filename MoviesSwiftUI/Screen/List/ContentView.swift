//
//  ContentView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            MovieGrid()
                .tabItem {
                    VStack {
                        Image(systemName: "tv")
                        Text("Now Playing")
                    }
            }
            .tag(0)
            
            MovieSearchView()
                .tabItem {
                    VStack {
                        Image(systemName: "magnifyingglass")
                        Text("Search")
                    }
            }
            .tag(1)
            
            GridView()
                .tabItem {
                    VStack {
                        Image(systemName: "tv")
                        Text("More")
                    }
            }
            .tag(2)
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
