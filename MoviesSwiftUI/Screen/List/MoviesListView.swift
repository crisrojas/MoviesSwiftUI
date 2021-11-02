//
//  NowPlayingGrid.swift
//  MoviesSwiftUI
//
//  Created by cristian on 16/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import Moya
import struct Kingfisher.KFImage
import SwiftUI

enum MovieListViewEndpoint {
    case popular
    case nowPlaying
    case genre
}

struct MoviesListView: View {
    
    @ObservedObject var moviesViewModel: MoviesListViewModel
    let title: String
    let endpoint: MovieListViewEndpoint
    let genreId: Int?
    
    
    init(title: String, endpoint: MovieListViewEndpoint, genreId: Int? = nil) {
        self.genreId = genreId
        self.title = title
        self.endpoint = endpoint
        moviesViewModel = MoviesListViewModel()
    }
    
    var body: some View {
        
        List(self.moviesViewModel.movies) { movie in
            
            ZStack {
                NavigationLink(destination: LazyView { MovieDetailScreen(id: movie.id) }) {
                    MoviesRow(movie: movie)
                }.onAppear {
                    loadData(currentItem: movie.id)
                }
            }
            
            
        }.background(DefaultGradient())
        .navigationBarTitle(Text(title), displayMode: .inline)
        
        .onAppear() {
            if moviesViewModel.movies.isEmpty {
               loadData()
            }
        }
    }
    
    func loadData(currentItem: Int? = nil) {
        switch endpoint {
        case .popular:
            moviesViewModel.loadPopular(currentItem: currentItem)
        case .nowPlaying:
            moviesViewModel.loadNowPlaying(currentItem: currentItem)
        case .genre:
            guard let id = genreId else { return }
            moviesViewModel.loadGenre(id: id, currentItem: currentItem)
        }
    }
}

extension MoviesListView: MoviesListVMOutput {
    func didUpdate(state: MoviesListViewState) {
        //
    }
    
    
}
