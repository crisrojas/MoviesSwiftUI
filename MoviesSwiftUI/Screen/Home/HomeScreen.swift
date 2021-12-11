//
//  MoviesHomeView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 24/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

struct HomeScreen: View {
    
    @StateObject private var viewModel = HomeScreenViewModel()
    
    var body: some View {
        
        
        switch viewModel.state {
            
        case .idle, .loading:
            loaderView
            
        case .success(let popular, let nowPlaying):
            successView(popular, nowPlaying)
            
        case .error(let message):
            errorView(message: message)
        }
    }
}

private extension HomeScreen {
  
    var loaderView: some View {
        LoaderView()
            .onAppear(perform: viewModel.loadData)
            .background(background)
    }
    
    func successView(
        _ popular: [Movie],
        _ nowPlaying: [Movie]
    ) -> some View {
        
        VStack(spacing: 30) {
            
            HomeCaroussel(movies: popular)
            HomeCategorySection()
            HomeMoviesGrid(movies: nowPlaying)
        }
        .vertical(30)
        .horizontal(.horizontal)
        .scrollify()
        .background(background)
        .navigationBarTitle("🎬 moVieLabs")
    }
    
    func errorView(message: String) -> some View {
        ErrorView(message: message)
    }
    
    var background: some View {
        DefaultGradient().fullScreen()
    }
    
}
