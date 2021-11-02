//
//  MoviePosterCarousel.swift
//  MoviesSwiftUI
//
//  Created by cristian on 10/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI

struct MoviePosterCarouselView: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
           Text(title)
            .font(.system(.title, design: .rounded))
            .fontWeight(.heavy)
            .padding(.horizontal)
            .foregroundColor(Color(K.textStrongColor!))
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetailScreen(id: movie.id)) {
                              MoviePosterCard(movie: movie)
                               .frame(width:204, height:306)
                            }.buttonStyle(PlainButtonStyle())
                            .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                
                        
                    }
                }
            }
        }
    }
}

struct MoviePosterCarouselView_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCarouselView(title: "Now Playing", movies: Movie.localMovies)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
