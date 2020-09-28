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

struct MoviesListView: View {
    
    @ObservedObject var moviesViewModel = MoviesListViewModel()
    let endpoint: String?
    
    init(endpoint: String) {
       self.endpoint = endpoint
       //K.setUpNavBarAppearance()
       //K.setUpListAppearance()
    }
    
    var body: some View {
            List(self.moviesViewModel.model) { movie in
                
                NavigationLink(destination: MovieDetailDribbleView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                    MoviesRow(movie: movie)
                       
                        .onAppear() {
                            self.moviesViewModel.loadMovies(endpoint: self.endpoint, currentItem: movie.id)
                    }
                }
                
            }.background(bgGradient())
         
            .onAppear() {
                if self.moviesViewModel.model.isEmpty {
                    self.moviesViewModel.loadMovies(endpoint: self.endpoint)
                }
            }
        
    }
}


