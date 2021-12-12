//
//  NowPlayingGrid.swift
//  MoviesSwiftUI
//
//  Created by cristian on 16/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Moya
import SwiftUI

enum MovieListViewEndpoint {
    case popular
    case nowPlaying
    case genre(id: Int)
}

struct ListScreen: View {
    
    @StateObject var viewModel = ListScreenViewModel()
    
    let title: String
    let endpoint: MovieListViewEndpoint
    
    var body: some View {
        
        switch viewModel.state {
        case .idle, .loading:
            
            LoaderView()
                .onAppear {
                    viewModel.initialLoad(endpoint: endpoint)
                }
                .navigationBarTitle(title, displayMode: .inline)
            
        case .success(let movies, let loadingMoreItems):
            
            successView(
                model: movies,
                loadingMore: loadingMoreItems
            )
                .navigationBarTitle(title, displayMode: .inline)
            
        case .error(let message):
            ErrorView(message: message)
                .navigationBarTitle(title, displayMode: .inline)
        }
    }
}

// MARK: - Success View
private extension ListScreen {
    
    func successView(
        model: [Movie],
        loadingMore: Bool
    ) -> some View {
        
        List {
            
            ForEach(model) { movie in
                
                MoviesRow(movie: movie)
                    .onTap(navigateTo: DetailScreen(id: movie.id))
                    .onAppear(if: movie.id == model.last?.id) {
                        viewModel.loadMoreItems(for: endpoint)
                    }
            }
          
            if loadingMore {
                ProgressView()
                    .alignX(.center)
                    .height(100)
            }
        }
        .background(DefaultGradient.init)
    }
}

extension View {
    
    func background<Content: View>(_ content: () -> Content) -> some View {
        
        self.background(content())
    }
    
    func onAppear(
        if condition: Bool,
        perform action: @escaping () ->()
    ) -> some View {
        
        self.onAppear() {
            if condition {
                action()
            }
        }
    }
}
