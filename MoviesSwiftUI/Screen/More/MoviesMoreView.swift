//
//  MoviesListView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct MoviesMoreView: View {
    
    @ObservedObject private var upcomingViewModel = MoviesMoreViewModel()
    @ObservedObject private var topRatedViewModel = MoviesMoreViewModel()
    @ObservedObject private var popularViewModel = MoviesMoreViewModel()
    
    var body: some View {
        NavigationView {
            List {
               
                Group {
                    if !upcomingViewModel.model.isEmpty {
                        MoviePosterCarouselView(title: "Upcoming", movies: upcomingViewModel.model)
                    } else {
                        LoadingView(isLoading: upcomingViewModel.isLoading, error: upcomingViewModel.error) {
                            self.upcomingViewModel.loadUpcoming()
                        }
                    }
                }.listRowInsets(EdgeInsets(top: 14, leading: 0, bottom: 8, trailing: 0))
                
                
                Group {
                    if !topRatedViewModel.model.isEmpty {
                        MovieBackdropCarouselView(title: "Top Rated", movies: topRatedViewModel.model)
                    } else {
                        LoadingView(isLoading: topRatedViewModel.isLoading, error: topRatedViewModel.error) {
                            self.topRatedViewModel.loadTopRated()
                        }
                    }
                }.listRowInsets(EdgeInsets(top: 14, leading: 0, bottom: 8, trailing: 0))
                
                Group {
                    if !popularViewModel.model.isEmpty {
                        MovieBackdropCarouselView(title: "Popular", movies: popularViewModel.model)
                    } else {
                        LoadingView(isLoading: popularViewModel.isLoading, error: topRatedViewModel.error) {
                            self.popularViewModel.loadPopular()
                        }
                    }
                }.listRowInsets(EdgeInsets(top: 14, leading: 0, bottom: 8, trailing: 0))
                
                
            }.navigationBarTitle("The MovieDb")
        }.onAppear() {
            self.upcomingViewModel.loadUpcoming()
            self.topRatedViewModel.loadTopRated()
            self.popularViewModel.loadPopular()
        }
    }
}

struct MoviesListView_Previews: PreviewProvider {
    static var previews: some View {
        MoviesMoreView()
    }
}
