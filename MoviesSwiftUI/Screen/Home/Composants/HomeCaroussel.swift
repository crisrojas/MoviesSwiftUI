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
    
    let movies: [Movie]
    
    var body: some View {
        
        DefaultVStack {
            
            HomeSectionHeading(
                title: "Popular Movies",
                destination: LazyView { MoviesListView(title: "Popular", endpoint: .popular) }
            )
            
            CarouselView(model: movies, spacing: 15) { movie in
                
                PopularCarouselCard(
                    image: movie.backdropURL,
                    title: movie.title,
                    genres: movie.genresList
                )
                    .width(350)
                    .height(200)
                    .onTap(navigateTo: DetailScreen.init(id: movie.id))
                    .leading(movie.id == movies.first?.id ? .horizontal : 0)
                    .trailing(movie.id == movies.last?.id ? .horizontal : 0)
   
            }
            .top(15)
            .horizontal(-.horizontal) /// @todo @notSoGoodPractice
        }
    }
}
