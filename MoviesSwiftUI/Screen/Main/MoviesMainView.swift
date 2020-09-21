//
//  NowPlayingGrid.swift
//  MoviesSwiftUI
//
//  Created by cristian on 16/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MoviesMainView: View {
    
    @ObservedObject var nowPlayingViewModel = MoviesMainViewModel()
    
    var body: some View {

        NavigationView {
            List(self.nowPlayingViewModel.model) { movie in
                MovieListItem(movie: movie)
                    .onAppear() {
                        self.nowPlayingViewModel.loadNowPlaying(currentItem: movie.id)
                }
                NavigationLink(destination: MovieDetailView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                    EmptyView()
                }
                
            }.onAppear() {
                self.nowPlayingViewModel.loadNowPlaying()
            }
        }
    }
}

struct NowPlayingGrid_Previews: PreviewProvider {
    static var previews: some View {
        MoviesMainView()
    }
}
