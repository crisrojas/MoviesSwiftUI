//
//  PopularCaroussel.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 09/12/2021.
//  Copyright © 2021 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

struct HomeCaroussel: View {
    
    @State private var showMovieDetail: Bool = false
    
    let movies: [Movie]
    
    var body: some View {
        
        DefaultVStack {
            
            HomeSectionHeading(
                title: "Popular Movies",
                destination: LazyView { MoviesListView(title: "Popular", endpoint: .popular) }
            )
            
            CarousselView(model: movies, spacing: 15) { movie in
                
                PopularCarousselCard(
                    image: movie.backdropURL,
                    title: movie.title,
                    genres: movie.genresList
                )
                    .width(350)
                    .height(200)
                    .makeNavigationLink(MovieDetailScreen(id: movie.id), $showMovieDetail)
                    .leading(movie.id == movies.first?.id ? 30 : 0)
   
            }
            .top(15)
            .horizontal(-30) /// @todo @badPractice
        }
    }
}
