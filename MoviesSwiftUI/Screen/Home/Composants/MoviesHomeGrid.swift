//
//  MoviesHomeGrid.swift
//  MoviesSwiftUI
//
//  Created by cristian on 28/09/2020.
//  Copyright © 2020 cristian. All rights reserved.
//

import SwiftUI
import struct Kingfisher.KFImage

struct MoviesHomeGrid: View {
    let movies: [Movie]
    var body: some View {
        VStack {
            MoviesHomeSectionHeader(title: "Now playing", viewAllDestination: LazyView { MoviesListView(title: "Now playing", endpoint: .nowPlaying) } )
            
            UIGrid(columns: 2, list: movies) { (movie) in
                ZStack {
                    
                    NavigationLink(destination: MovieDetailDribbleView(movieDetailViewModel: MovieDetailViewModel(movieId: movie.id))) {
                        KFImage(movie.posterURL)
                            .placeholder {
                                ZStack {
                                    Rectangle()
                                        .fill(Color.gray.opacity(0.3))
                                        .cornerRadius(4)
                                        .aspectRatio(210/297, contentMode: .fill)
                                    Image(systemName: "arrow.2.circlepath.circle")
                                        .font(.largeTitle)
                                        .opacity(0.3)
                                }
                            }
                            .resizable()
                            .renderingMode(.original)
                            .aspectRatio(210/297, contentMode: .fill)
                            .frame(width: 170)
                            .cornerRadius(10)
                    }
                    
                }
            }.padding(.top, 15)
            
        }.padding(.top, 30)
    }
}

struct MoviesHomeGrid_Previews: PreviewProvider {
    static var previews: some View {
        MoviesHomeGrid(movies: Movie.localMovies)
        .padding()
        .previewLayout(.sizeThatFits)
    }
}
