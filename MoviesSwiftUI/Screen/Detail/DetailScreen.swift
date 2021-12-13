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

/// **Screen challenges**
/// The Image background was really tricky.
/// I thought everything was fine till I realized that there was an overflow of the image only visible when turning back.
/// Solution was using .clipped() modifier. Took me a whole hour.
///
/// Also, there was a small padding on top that disappeared when the screen was loaded.
/// It was me setting the display mode .inline (navigationBar) only for the success screen. Silly me.
struct DetailScreen: View {
    
    @StateObject private var viewModel = DetailScreenViewModel()
    let id: Int
    
    var body: some View {
        
        switch viewModel.state {
            
        case .idle, .loading:
            
            LoaderView()
                .onAppear { viewModel.loadMovie(id: id) }
                .navigationBarTitle("", displayMode: .inline)
                .background(DefaultGradient().fullScreen())
            
        case .success(let movie):
            
            successView(movie: movie)
                .navigationBarTitle("", displayMode: .inline)
            
        case .error(let error):
            
            ErrorView(message: error)
                .navigationBarTitle("", displayMode: .inline)
        }
    }
}


// MARK: - Sub Views
private extension DetailScreen {
    
    func successView(movie: Movie) -> some View {
        
        VStack(spacing: 0) {

            
            MovieDetailHeader(
                title: movie.title ?? "Unknown",
                averageVote: movie.voteAverageRounded,
                ratingStars: movie.ratingStarsOutOfFive,
                posterURL: movie.posterURL,
                trailerURL: movie.youtubeURL
            )
            .top(10)
            
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
            .alignX(.leading)
            .top(30)

            if let cast = movie.cast,
               cast.count > 0
            {
                CastCarousel(model: cast)
                    .top(30)
                    .horizontal(-.horizontal)
            }
        }
        .bottom(.bottom)
        .horizontal(.horizontal)
        .scrollify()
        .background(ImageBackground(url: movie.backdropURL))
    }
}


struct ImageBackground: View {
    
    let url: URL?
    
    var body: some View {
        AsyncImage(url: url) { image in
            image
                .resizable()
                .scaledToFill()
                .fullScreen()
                .opacity(0.7)
                .saturation(0.0)
                .clipped()
                .edgesIgnoringSafeArea(.top)
                .overlayView(DefaultGradient.init)
        } placeholder: {
            DefaultGradient().fullScreen()
        }
    }
}




