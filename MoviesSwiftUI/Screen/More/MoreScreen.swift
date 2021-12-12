//
//  MoviesListView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

struct MoreScreen: View {
    
    @StateObject private var viewModel = MoreScreenViewModel()
    
    var body: some View {
        
        switch viewModel.state {
            
        case .idle, .loading:
            
            LoaderView()
                .onAppear(perform: viewModel.loadData)
            
        case .success(let upcoming, let topRated):
            
            successView(
                upcoming: upcoming,
                topRated: topRated
            )
            
        case .error(let message):
            
            ErrorView(message: message)
        }
    }
    
}

private extension MoreScreen {
    
    func successView(
        upcoming: [Movie],
        topRated: [Movie]
    ) -> some View {
        
        DefaultVStack {
            
            DiscoverCarousel(
                title: "Upcoming",
                movies: upcoming,
                type: .poster
            )
            .top(24)
            
            DiscoverCarousel(
                title: "Top Rated",
                movies: topRated,
                type: .backdrop
            )
            .top(24)
        }
        .bottom(.bottom)
        .scrollify()
        .navigationBarTitle("Discover")
        .background(DefaultGradient())
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoreScreen()
    }
}
