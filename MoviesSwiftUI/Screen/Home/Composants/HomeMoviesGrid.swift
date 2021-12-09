//
//  HomeNowPlayingGrid.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 09/12/2021.
//  Copyright © 2021 cristian. All rights reserved.
//

import SwiftUI
import SwiftUItilities

struct HomeMoviesGrid: View {
    
    let movies: [Movie]
    var columns: [GridItem] =
    Array(repeating: .init(.flexible()), count: 2)
    
    var body: some View {
        
        VStack {
            
            HomeSectionHeading(
                title: "Now Playing",
                destination: destination
            )
            
            TwoColumnsGrid(model: movies) { movie in
                
                gridImage(url: movie.posterURL)
                    .onTap(navigateTo: DetailScreen(id: movie.id))
            }
            .top(15)
        }
    }
    
    private var destination: some View {
        
        MoviesListView(
            title: "Now playing",
            endpoint: .nowPlaying
        )
    }
    
    private func gridImage(url: URL?) -> some View {
        
        AsyncImage(url: url) { image in
            image
                .resizable()
                .frame(width: 170)
                .aspectRatio(210/297, contentMode: .fill)
                .cornerRadius(10)
        } placeholder: {
            image¨Placeholder
        }
    }
    
    
    private var image¨Placeholder: some View {
        
       Color(K.primaryColor!)
            .frame(width: 170)
            .aspectRatio(210/297, contentMode: .fill)
            .cornerRadius(10)
            .overlayView(ProgressView.init)
    }
    
}
