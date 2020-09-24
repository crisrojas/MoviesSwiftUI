//
//  MovieSearchView.swift
//  MoviesSwiftUI
//
//  Created by cristian on 11/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

// todo: write protocol
protocol MovieSearchViewInput {
    //
}

struct MovieSearchView: View {
    
    @ObservedObject var movieSearchViewModel = MovieSearchViewModel()
    
    var body: some View {
        NavigationView {
            List {
                SearchBarView(placeholder: "Search movies", text: self.$movieSearchViewModel.query)
                    .listRowInsets(EdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8))
                
                LoadingView(isLoading: self.movieSearchViewModel.isLoading, error: self.movieSearchViewModel.error) {
                    self.movieSearchViewModel.search(query: self.movieSearchViewModel.query)
                }
                
                if self.movieSearchViewModel.movies != nil {
                    ForEach(self.movieSearchViewModel.movies!) { movie in
                        NavigationLink(destination: MovieDetailDribbleView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                            VStack(alignment: .leading) {
                                Text(movie.title)
                                Text(movie.yearText)
                            }
                        }
                        
                    }
                }
            }.background(LinearGradient(gradient: Gradient(colors: [Color(K.primaryColor!).opacity(0.5), Color(K.themeColor!)]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all))
            .onAppear {
                self.movieSearchViewModel.stateObserve()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
            
        }
    }
}

struct MovieSearchView_Previews: PreviewProvider {
    static var previews: some View {
        MovieSearchView()
    }
}
