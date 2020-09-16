//
//  NowPlayingGrid.swift
//  MoviesSwiftUI
//
//  Created by cristian on 16/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct NowPlayingGrid: View {
    @ObservedObject var nowPlayingViewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            List(self.nowPlayingViewModel.model) { movie in
                MoviePosterCard(movie: movie)
                    .onAppear() {
                        print("\(movie.title)")
                        self.nowPlayingViewModel.loadMovies(with: .nowPlaying, currentItem: movie.id)
                }
                NavigationLink(destination: MovieDetailView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                    EmptyView()
                }
                
                
//                ForEach(self.nowPlayingViewModel.chunkedModel, id: \.self) { index in
//
//                    HStack {
//                        ForEach(index, id: \.id) { movie in
//                            ZStack {
//                                NavigationLink(destination: MovieDetailView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
//                                    MoviePosterCard(movie: movie)
//                                        .onAppear() {
//                                            print("\(movie.title)")
//                                            self.nowPlayingViewModel.loadMovies(with: .nowPlaying, currentItem: movie.id)
//                                    }
//                                }
//                            }
//                        }
//                    }
//                }
                
            }.onAppear() {
                self.nowPlayingViewModel.loadMovies(with: .nowPlaying, currentItem: nil)
            }
        }
    }
}

struct NowPlayingGrid_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingGrid()
    }
}


extension Array {
    func chunked(into size:Int) -> [[Element]] {
        
        var chunkedArray = [[Element]]()
        
        for index in 0...self.count {
            if index % size == 0 && index != 0 {
                chunkedArray.append(Array(self[(index - size)..<index]))
            } else if(index == self.count) {
                chunkedArray.append(Array(self[index - 1..<index]))
            }
        }
        
        return chunkedArray
    }
}

