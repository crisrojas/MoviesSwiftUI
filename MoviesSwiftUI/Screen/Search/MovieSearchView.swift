//
//  MovieSearchView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct MovieSearchView: View {
    
    @StateObject var viewModel = MovieSearchViewModel()
    
    var body: some View {

            List {
                SearchBarView(placeholder: "Search movies", text: self.$viewModel.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                LoadingView(isLoading: self.viewModel.isLoading, error: self.viewModel.error) {
                    self.viewModel.search(query: self.viewModel.query)
                }
                
                if self.viewModel.movies != nil {
                    ForEach(self.viewModel.movies!) { movie in
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
                self.viewModel.stateObserve()
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
