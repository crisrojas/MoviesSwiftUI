//
//  MovieDetailDribble.swift
//  MoviesSwiftUI
//
//  Created by cristian on 22/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SafariServices
import SwiftUI
import SwiftUItilities

struct DetailScreen: View {
    
    @StateObject var movieDetailViewModel = DetailScreenViewModel()
    let id: Int
    
    var body: some View {
        
        switch movieDetailViewModel.state {
            
        case .idle, .loading:
            
            LoaderView()
                .onAppear { movieDetailViewModel.loadMovie(id: id) }
        case .success(let movie):
            
            successView(movie: movie)
        case .error(let error):
            
            ErrorView(message: error)
        }
    }
}


// MARK: - Sub Views
private extension DetailScreen {
    
    func successView(movie: Movie) -> some View {
        
        VStack {
            
            MovieDetailHeader(
                title: movie.title ?? "Unknown",
                averageVote: movie.voteAverageRounded,
                ratingStars: movie.ratingStarsOutOfFive,
                posterURL: movie.posterURL,
                trailerURL: movie.youtubeURL
            )
            
            MovieDetailInfoStack(movie: movie)
                .top(20)
            
            VStack(
                alignment: .leading,
                spacing: 20
            ) {
                
                Text("Storyline")
                    .font(.system(.headline, design: .rounded))
                    .fontWeight(.heavy)
                    .foregroundColor(Color(K.textStrongColor!))
                
                Text(movie.overview)
                    .font(.system(.footnote, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color(K.textSoftColor!))
            }
            .top(30)
            
            
            if let cast = movie.cast,
               cast.count > 0
            {
                CastCarrousel(cast: movie.cast!)
                    .horizontal(-30)
            }
        }
        .padding(30)
        .scrollify()
        .background(imageBackground(url: movie.backdropURL))
        .edgesIgnoringSafeArea(.all)
    }
    
    func imageBackground(url: URL?) -> some View {
        
        AsyncImage(url: url) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.7)
                .saturation(0.0)
        } placeholder: {
            DefaultGradient()
        }
        .overlayView(DefaultGradient.init)
    }
}





