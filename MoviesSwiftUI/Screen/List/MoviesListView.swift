//
//  MoviesListView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct MoviesListView: View {
    
    @ObservedObject private var nowPlayingViewModel = MovieListViewModel()
    @ObservedObject private var upcomingViewModel = MovieListViewModel()
    @ObservedObject private var topRatedViewModel = MovieListViewModel()
    @ObservedObject private var popularViewModel = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            List {
               
                Group {
                    if upcomingViewModel.model != nil {
                        MoviePosterCarouselView(title: "Upcoming", movies: upcomingViewModel.model!)
                    } else {
                        LoadingView(isLoading: upcomingViewModel.isLoading, error: upcomingViewModel.error) {
                            self.upcomingViewModel.loadMovies(with: .upcoming)
                        }
                    }
                }.listRowInsets(EdgeInsets(top: 14, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if topRatedViewModel.model != nil {
                        MovieBackdropCarouselView(title: "Top Rated", movies: topRatedViewModel.model!)
                    } else {
                        LoadingView(isLoading: topRatedViewModel.isLoading, error: topRatedViewModel.error) {
                            self.topRatedViewModel.loadMovies(with: .upcoming)
                        }
                    }
                }.listRowInsets(EdgeInsets(top: 14, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if popularViewModel.model != nil {
                        MovieBackdropCarouselView(title: "Popular", movies: popularViewModel.model!)
                    } else {
                        LoadingView(isLoading: popularViewModel.isLoading, error: topRatedViewModel.error) {
                            self.popularViewModel.loadMovies(with: .popular)
                        }
                    }
                }.listRowInsets(EdgeInsets(top: 14, leading: 0, bottom: 8, trailing: 0))
                
            }.navigationBarTitle("The MovieDb")
        }.onAppear() {
            self.nowPlayingViewModel.loadMovies(with: .nowPlaying)
            self.upcomingViewModel.loadMovies(with: .upcoming)
            self.topRatedViewModel.loadMovies(with: .topRated)
            self.popularViewModel.loadMovies(with: .popular)
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
