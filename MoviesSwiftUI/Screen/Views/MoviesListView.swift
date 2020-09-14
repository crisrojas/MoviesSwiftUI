//
//  MoviesListView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct MoviesListView: View {
    
    @ObservedObject private var nowPlayingState = MovieListViewModel()
    @ObservedObject private var upcomingState = MovieListViewModel()
    @ObservedObject private var topRatedState = MovieListViewModel()
    @ObservedObject private var popularState = MovieListViewModel()
    
    var body: some View {
        NavigationView {
            List {
                Group {
                    if nowPlayingState.movies != nil {
                        MoviePosterCarouselView(title: "Now Playing", movies: nowPlayingState.movies!)
                    } else {
                        LoadingView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                }.listRowInsets(EdgeInsets(top: 14, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if upcomingState.movies != nil {
                        MovieBackdropCarouselView(title: "Upcoming", movies: upcomingState.movies!)
                    } else {
                        LoadingView(isLoading: upcomingState.isLoading, error: upcomingState.error) {
                            self.upcomingState.loadMovies(with: .upcoming)
                        }
                    }
                }.listRowInsets(EdgeInsets(top: 14, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if topRatedState.movies != nil {
                        MovieBackdropCarouselView(title: "Top Rated", movies: topRatedState.movies!)
                    } else {
                        LoadingView(isLoading: topRatedState.isLoading, error: topRatedState.error) {
                            self.topRatedState.loadMovies(with: .upcoming)
                        }
                    }
                }.listRowInsets(EdgeInsets(top: 14, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if popularState.movies != nil {
                        MovieBackdropCarouselView(title: "Popular", movies: popularState.movies!)
                    } else {
                        LoadingView(isLoading: popularState.isLoading, error: topRatedState.error) {
                            self.popularState.loadMovies(with: .popular)
                        }
                    }
                }.listRowInsets(EdgeInsets(top: 14, leading: 0, bottom: 8, trailing: 0))
                
            }.navigationBarTitle("The MovieDb")
        }.onAppear() {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.upcomingState.loadMovies(with: .upcoming)
            self.topRatedState.loadMovies(with: .topRated)
            self.popularState.loadMovies(with: .popular)
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesListView()
    }
}
