//
//  MoviesGrid.swift
//  MoviesSwiftUI
//
//  Created by Cristian Rojas on 24/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MoviesGrid: View {
    let movies: [[Movie]]
    
    var body: some View {
        
        List {
            ForEach(0..<self.movies.count) { index in
                HStack {
                    ForEach(self.movies[index]) { movie in
                        ZStack {
                        
                        KFImage(movie.posterURL)
                            .resizable()
                            .frame(width:150, height: 195)
                             .cornerRadius(10)
                            NavigationLink(destination: MovieDetailScreen(id: movie.id)) {
                                EmptyView()
                            }
                        }
                    }
                }
                
            }
        }.padding()
    }
}

struct MoviesGrid_Previews: PreviewProvider {
    static var previews: some View {
        MoviesGrid(movies: Movie.localMovies.chunked(into: 2))
            .previewLayout(.sizeThatFits)
    }
}
