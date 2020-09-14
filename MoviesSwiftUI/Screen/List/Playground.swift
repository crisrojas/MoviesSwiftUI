//
//  Playground.swift
//  MoviesSwiftUI
//
//  Created by cristian on 14/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct Playground: View {
   //let model = ["1", "2", "3", "4", "5"]
    let model = Movie.localMovies
    @ObservedObject var nowPlayingViewModel = MovieListViewModel()
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        List {
            if nowPlayingViewModel.model != nil {
            ForEach(0..<model.count) {i in
                HStack {
                    MoviePosterCard(movie: self.nowPlayingViewModel.model![i])
                    MoviePosterCard(movie: self.nowPlayingViewModel.model![i+1])
                    
                }
            }
            } else {
                LoadingView.init(isLoading: nowPlayingViewModel.isLoading, error: nowPlayingViewModel.error) {
                    self.nowPlayingViewModel.loadMovies(with: .nowPlaying)
                }
            }
        }.onAppear() {
            self.nowPlayingViewModel.loadMovies(with: .nowPlaying)
        }
    }
}

struct Playground_Previews: PreviewProvider {
    static var previews: some View {
        Playground()
    }
}

/*
 
 Todo: adapt columns to screen with
 UIScreen.main.bounds.width / (itemSize + spacing) = number of items that fit in one row. (if all of your horizontal spacings are the same)
 
 Use it in a computed property
 
 */
