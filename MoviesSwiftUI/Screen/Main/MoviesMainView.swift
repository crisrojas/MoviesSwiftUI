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

// todo: créer une note sur cet algo, puis l'éliminer du code
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

