//
//  MovieGrid.swift
//  MoviesSwiftUI
//
//  Created by cristian on 14/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct MovieGrid: View {
    
    let emojiList: [String] = Emoji.emoji
    let movies = Movie.localMovies
    @ObservedObject private var nowPlayingViewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView() {
                  
                if nowPlayingViewModel.model != nil {
                    UIGrid(columns: 2, list: nowPlayingViewModel.model!) { movie in
                        NavigationLink(destination: MovieDetailView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                             MoviePosterCard(movie: movie)
                        }.buttonStyle(PlainButtonStyle())
                    }
                }
                
            }
            .navigationBarTitle("Now Playing")
            .onAppear() {
            self.nowPlayingViewModel.loadMovies(with: .nowPlaying)
            }
        }
    }
}

struct MovieGrid_Previews: PreviewProvider {
    static var previews: some View {
        MovieGrid()
    }
}

