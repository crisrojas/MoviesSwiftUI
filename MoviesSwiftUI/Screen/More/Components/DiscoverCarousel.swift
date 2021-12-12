//
//  MoviePosterCarousel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

struct DiscoverCarousel: View {
    
    let title: String
    let movies: [Movie]
    let type: `Type`
    
    enum `Type` {
        case poster
        case backdrop
    }
    
    var body: some View {
        
        DefaultVStack {
            
            Text(title)
                .font(.system(.title, design: .rounded))
                .fontWeight(.heavy)
                .foregroundColor(Color(K.textStrongColor!))
                .leading(.horizontal)
            
            CarouselView(model: movies, spacing: 16) { movie in
               
                card(movie: movie)
                    .leading(movie.id == movies.first?.id ? .horizontal : 0)
                    .trailing(movie.id == movies.last?.id ? .horizontal : 0)
                    .onTap(navigateTo: DetailScreen(id: movie.id))
            }
            .top(16)
        }
    }
}

// MARK: - Card component
private extension DiscoverCarousel {
    
    @ViewBuilder
    func card(movie: Movie) -> some View {
        
        switch type {
            
        case .poster:
            
            posterImage(url: movie.posterURL)
            
        case .backdrop:
            
            backDropImage(
                url: movie.backdropURL,
                title: movie.title
            )
        }
    }
    
    func posterImage(url: URL?) -> some View {
        
        image(url: url)
        .width(230)
        .height(310)
        .cornerRadius(8)
        .shadow(radius: 8)
    }
    
    
    func backDropImage(url: URL?, title: String?) -> some View {
        
        VStack(alignment: .leading) {
            
            image(url: url)
            .width(272)
            .height(180)
            .cornerRadius(8)
            .shadow(radius: 4)
            
            
            Text(title ?? "Unknown title")
                .font(.system(.subheadline, design:.rounded))
                .fontWeight(.bold)
                .foregroundColor(Color(K.textSoftColor!))
        }
    }
    
    func image(url: URL?) -> some View {
        
        AsyncImage(url: url) { image in
            
            image.resizable()
            
        } placeholder: {
            
            Color(K.primaryColor!)
                .overlay(ProgressView())
        }
    }
}
