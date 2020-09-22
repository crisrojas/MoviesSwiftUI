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

struct MoviesMainView: View {
    
    @ObservedObject var nowPlayingViewModel = MoviesMainViewModel()
    
    var body: some View {

        NavigationView {
            List(self.nowPlayingViewModel.model) { movie in
                
                NavigationLink(destination: MovieDetailView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                    MoviesRow(movie: movie)
                        .onAppear() {
                            self.nowPlayingViewModel.loadNowPlaying(currentItem: movie.id)
                    }
                }
                
            }
            .navigationBarTitle("Now Playing")
            .onAppear() {
                if self.nowPlayingViewModel.model.isEmpty {
                    self.nowPlayingViewModel.loadNowPlaying()
                }
            }
        }
    }
}


struct NowPlayingGrid_Previews: PreviewProvider {
    static var previews: some View {
        MoviesMainView()
    }
}
