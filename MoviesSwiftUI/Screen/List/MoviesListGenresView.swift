//
//  MoviesListGenres.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

import Moya
import struct Kingfisher.KFImage
import SwiftUI

struct MoviesListGenresView: View {
    
    @ObservedObject var moviesViewModel = MoviesListViewModel()
    let id: Int
 
    var body: some View {
            List(self.moviesViewModel.model) { movie in
                
                NavigationLink(destination: MovieDetailDribbleView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                    MoviesRow(movie: movie)
                       
                        .onAppear() {
                            self.moviesViewModel.loadGenre(id: self.id, currentItem: movie.id)
                    }
                }
                
            }.background(bgGradient())
         
            .onAppear() {
                if self.moviesViewModel.model.isEmpty {
                    self.moviesViewModel.loadGenre(id: self.id)
                }
            }
        
    }
}

