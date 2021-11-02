//
//  MovieSearchView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchViewModel = MovieSearchViewModel()
    
    var body: some View {

            List {
                SearchBarView(placeholder: "Search movies", text: self.$movieSearchViewModel.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                LoadingView(isLoading: self.movieSearchViewModel.isLoading, error: self.movieSearchViewModel.error) {
                    self.movieSearchViewModel.search(query: self.movieSearchViewModel.query)
                }
                
                if self.movieSearchViewModel.movies != nil {
                    ForEach(self.movieSearchViewModel.movies!) { movie in
                        NavigationLink(destination: MovieDetailScreen(id: movie.id)) {
                            VStack(alignment: .leading) {
                                Text(movie.title ?? "Unknown title")
                                Text(movie.yearText)
                            }
                        }
                        
                    }
                }
            }.background(DefaultGradient())
            .onAppear {
                self.movieSearchViewModel.stateObserve()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
